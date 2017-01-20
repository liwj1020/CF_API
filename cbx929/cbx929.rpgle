     **
     **  Program . . : CBX929
     **  Description : Retrieve user special authority - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX929 )
     **                DbgView( *NONE )
     **                Aut( *USE )
     **
     **    CrtPgm      Pgm( CBX929 )
     **                Module( CBX929 )
     **                ActGrp( *NEW )
     **                UsrPrf( *OWNER )
     **                Aut( *USE )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D MAX_SUPGRP      c                   15
     D MAX_SPCAUT      c                   15
     **-- Global variables:
     D AccSpcAut       s              1a   Dim( MAX_SPCAUT )
     D Idx             s             10i 0

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a
     **-- User information structure:
     D USRI0200        Ds           512    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  SpcAut                        1a   Overlay( USRI0200: 29 )
     D                                     Dim( MAX_SPCAUT )
     D  GrpPrf                       10a   Overlay( USRI0200: 44 )
     D  SupGrpOfs                    10i 0 Overlay( USRI0200: 97 )
     D  SupGrpNbr                    10i 0 Overlay( USRI0200: 101 )
     **
     D SupGrpPrf       s             10a   Based( pSupGrpPrf )
     D                                     Dim( MAX_SUPGRP )

     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
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
     D  SpError                    1024a          Options( *VarSize )

     **-- Add special authority:
     D AddSpcAut       Pr             1a   Dim( MAX_SPCAUT )
     D  PxSpcAut1                     1a   Dim( MAX_SPCAUT )  Value
     D  PxSpcAut2                     1a   Dim( MAX_SPCAUT )  Value
     **-- Get special authority:
     D GetSpcAut       Pr             1a   Dim( MAX_SPCAUT )
     D  PxUsrPrf                     10a   Value
     **-- Format special authority:
     D FmtSpcAut       Pr            10a   Dim( MAX_SPCAUT )
     D  PxSpcAut                      1a   Dim( MAX_SPCAUT )  Value
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     D CBX929          Pr
     D  PxUsrPrf                     10a
     D  PxOption                     10a
     D  PxSpcAut                     10a   Dim( MAX_SPCAUT )
     **
     D CBX929          Pi
     D  PxUsrPrf                     10a
     D  PxOption                     10a
     D  PxSpcAut                     10a   Dim( MAX_SPCAUT )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );

        Else;
          pSupGrpPrf = %Addr( USRI0200 ) + USRI0200.SupGrpOfs;
        EndIf;

        If  PxOption = '*USRPRF'  Or PxOption = '*ALL';

          AccSpcAut = AddSpcAut( AccSpcAut: USRI0200.SpcAut );
        EndIf;

        If  PxOption = '*GRPPRF'  Or PxOption = '*ALL';

          If  USRI0200.GrpPrf <> '*NONE';

            AccSpcAut = AddSpcAut( AccSpcAut: GetSpcAut( USRI0200.GrpPrf ));
          EndIf;
        EndIf;

        If  PxOption = '*SUPGRP'  Or PxOption = '*ALL';

          For  Idx = 1 to  USRI0200.SupGrpNbr;

            AccSpcAut = AddSpcAut( AccSpcAut: GetSpcAut( SupGrpPrf(Idx) ));
          EndFor;
        EndIf;

        PxSpcAut = FmtSpcAut( AccSpcAut );

        *InLr = *On;
        Return;

      /End-Free

     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
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
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
     **-- Get special authority:  --------------------------------------------**
     P GetSpcAut       B
     D                 Pi             1a   Dim( MAX_SPCAUT )
     D  PxUsrPrf                     10a   Value
     **
     D USRI0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  SpcAut                        1a   Overlay( USRI0200: 29 )
     D                                     Dim( MAX_SPCAUT )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  USRI0200.SpcAut;
        EndIf;

      /End-Free

     P GetSpcAut       E
     **-- Add special authority:  --------------------------------------------**
     P AddSpcAut       B
     D                 Pi             1a   Dim( MAX_SPCAUT )
     D  PxSpcAut1                     1a   Dim( MAX_SPCAUT )  Value
     D  PxSpcAut2                     1a   Dim( MAX_SPCAUT )  Value
     **
     D Idx             s             10i 0
     **

      /Free

        For Idx = 1  To %Elem( PxSpcAut1 );

          If  PxSpcAut2( Idx ) = 'Y';

            PxSpcAut1(Idx) = PxSpcAut2(Idx);
          EndIf;
        EndFor;

        Return  PxSpcAut1;

      /End-Free

     P AddSpcAut       E
     **-- Format special authority:  -----------------------------------------**
     P FmtSpcAut       B                   Export
     D                 Pi            10a   Dim( MAX_SPCAUT )
     D  PxSpcAut                      1a   Dim( MAX_SPCAUT )  Value
     **
     D Idx             s             10i 0
     D SpcAut          s             10a   Dim( MAX_SPCAUT )

      /Free

        If  PxSpcAut(1) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*ALLOBJ';
        EndIf;

        If  PxSpcAut(2) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*SECADM';
        EndIf;

        If  PxSpcAut(3) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*JOBCTL';
        EndIf;

        If  PxSpcAut(4) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*SPLCTL';
        EndIf;

        If  PxSpcAut(5) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*SAVSYS';
        EndIf;

        If  PxSpcAut(6) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*SERVICE';
        EndIf;

        If  PxSpcAut(7) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*AUDIT';
        EndIf;

        If  PxSpcAut(8) = 'Y';
          Idx += 1;
          SpcAut(Idx) = '*IOSYSCFG';
        EndIf;

        If  SpcAut(1) = *Blanks;
          SpcAut(1) = '*NONE';
        EndIf;

        Return  SpcAut;

      /End-Free

     P FmtSpcAut       E
