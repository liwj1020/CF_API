     **
     **  Program . . : CBX951
     **  Description : Add PRN seed - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Programmer's notes:
     **    Earliest release program will run: V5R1
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX951 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX951 )
     **              Module( CBX951 )
     **              ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )

     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a

     **-- Global variables:
     D AutFlg          s              1a
     D Seed            s             20a
     D SeedHex         s             40a   Varying
     D MsgKey          s              4a
     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D ADP_PRV_INVLVL  c                   1

     **-- Convert hex to character:
     D cvthc           Pr                  ExtProc( 'cvthc' )
     D  RcvHex                         *   Value
     D  SrcChr                         *   Value
     D  RcvLen                       10i 0 Value
     **-- Convert character to hex:
     D cvtch           Pr                  ExtProc( 'cvtch' )
     D  RcvChr                         *   Value
     D  SrcHex                         *   Value
     D  RcvLen                       10i 0 Value
     **-- String to unsigned long:
     D strtoul         pr            10i 0 ExtProc( 'strtoul' )
     D  nptr                           *   Value  Options( *String )
     D  endptr                         *   Value
     D  base                         10i 0 Value
     **-- Add seed for pseudorandom number generator:
     D AddSeedPng      pr            10i 0 ExtProc( 'Qc3AddPRNGSeed' )
     D  Seed                         20a   Const  Options( *VarSize )
     D  SeedLen                      10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **-- Check special authority
     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
     D  CsAutInf                      1a
     D  CsUsrPrf                     10a   Const
     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
     D  CsNbrAut                     10i 0 Const
     D  CsCalLvl                     10i 0 Const
     D  CsError                   32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                   32767a          Options( *VarSize )

     **-- Add seed in hexadecimal form:
     D AddSeedHex      Pr             8a
     D  PxSeed                       32a   Const
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX951          Pr
     D  PxSeed1                      32a
     D  PxSeed2                      32a
     D  PxSeed3                      32a
     D  PxSeed4                      32a
     D  PxSeed5                      32a
     **
     D CBX951          Pi
     D  PxSeed1                      32a
     D  PxSeed2                      32a
     D  PxSeed3                      32a
     D  PxSeed4                      32a
     D  PxSeed5                      32a

      /Free

        ChkSpcAut( AutFlg
                 : PgmSts.UsrPrf
                 : '*ALLOBJ'
                 : 1
                 : ADP_PRV_INVLVL
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';

          SndEscMsg( 'Special authority *ALLOBJ required.' );
        Else;

          If  %Check( '01': PxSeed1 ) > *Zero  Or
              %Check( '01': PxSeed2 ) > *Zero  Or
              %Check( '01': PxSeed3 ) > *Zero  Or
              %Check( '01': PxSeed4 ) > *Zero  Or
              %Check( '01': PxSeed5 ) > *Zero;

            SndDiagMsg( 'CPF9898'
                      : 'Only binary values are allowed, please specify ' +
                        '''0'' and ''1'''
                      );

            SndEscMsg( 'ADDPRNSEED command ended in error' );

          Else;
            SeedHex  = AddSeedHex( PxSeed1 );
            SeedHex += AddSeedHex( PxSeed2 );
            SeedHex += AddSeedHex( PxSeed3 );
            SeedHex += AddSeedHex( PxSeed4 );
            SeedHex += AddSeedHex( PxSeed5 );

            cvtch( %Addr( Seed ): %Addr( SeedHex ) + 2: %Len( SeedHex ));

            AddSeedPng( Seed: %Size( Seed ): ERRC0100 );

            If  ERRC0100.BytAvl > *Zero;
              If  ERRC0100.BytAvl < OFS_MSGDTA;
                ERRC0100.BytAvl = OFS_MSGDTA;
              EndIf;

              SndDiagMsg( ERRC0100.MsgId
                        : %Subst( ERRC0100.MsgDta
                                : 1
                                : ERRC0100.BytAvl - OFS_MSGDTA
                                ));

              SndEscMsg( 'ADDPRNSEED command ended in error' );
            Else;
              SndCmpMsg( 'PRN seed added succesfully.' );
            EndIf;
          EndIf;
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Add seed in hexadecimal form:  -------------------------------------**
     P AddSeedHex      B
     D                 Pi             8a
     D  PxSeed                       32a   Const

     **-- Local variables:
     D Ptr             s               *
     D Uint            s             10u 0
     D SeedHex         s              8a

      /Free

        Uint = strtoul( PxSeed: %Addr( Ptr ): 2 );

        cvthc( %Addr( SeedHex ): %Addr( Uint ): %Size( SeedHex ));

        Return  SeedHex;

      /End-Free

     P AddSeedHex      E
     **-- Send diagnostic message:  ------------------------------------------**
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*DIAG'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndDiagMsg      E
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying

      /Free

        SndPgmMsg( 'CPF9898'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     P SndEscMsg       E
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     P SndCmpMsg       E
