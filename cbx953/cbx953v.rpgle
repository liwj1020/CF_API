     **
     **  Program . . : CBX953V
     **  Description : Add Group Profile - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : Club Tech iSeries System Management Tips Newsletter
     **
     **
     **  Program description:
     **    Validity checking program for the Add Group Profile
     **    (ADDGRPPRF) command.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX953V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX953V )
     **              Module( CBX953V )
     **              ActGrp( CBX953 )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  ExcpId                        7a
     D                                1a
     D  ExcpDta                     512a

     **-- Global constants:
     D ADP_PRV_INVLVL  c                   1
     **-- Global variables:
     D AutFlg          s              1a
     D SpcAut          s             10a   Dim( 8 )
     D FilNamRtn_q     s             20a
     **
     D UsrCls          Ds                  Qualified
     D  NbrCls                        5i 0
     D  ClsVal                       10a   Dim( 5 )
     **
     D File_q          Ds                  Qualified
     D  FilNam                       10a
     D  LibNam                       10a
     **-- FILD0100 format - partial:
     D Qdb_Qdbfh       Ds           512    Qualified
     D  Qdbfyret                     10i 0
     D  Qdbfyavl                     10i 0
     D  Qdbfhflg                      2a
     D  Reserved_7                    4a
     D  Qdbflbnum                     5i 0
     D  Qdbfkdat                     14a
     D  Qdbfhaut                     10a
     D  Qdbfhupl                      1a
     D  Qdbfhmxm                      5i 0
     D  Qdbfwtfi                      5i 0
     D  Qdbfhfrt                      5i 0
     D  Qdbfhmnum                     5i 0
     D  Reserved_11                   9a
     D  Qdbfbrwt                      5i 0
     D  Qaaf                          1a
     D  Qdbffmtnum                    5i 0
     D  Qdbfhfl2                      2a
     D  Qdbfvrm                       5i 0
     D  Qaaf2                         2a
     D  Qdbfhcrt                     13a
     D  Qdbfhtx                      52a
     D  Reserved_19                  13a
     D  Qdbfsrc                      30a
     D  Qdbfkrcv                      1a
     D  Reserved_20                  23a
     D  Qdbftcid                      5i 0
     D  Qdbfasp                       2a
     D  Qdbfnbit                      1a
     D  Qdbfmxfnum                    5i 0
     D  Reserved_22                  76a
     D  Qdbfodic                     10i 0
     D  Reserved_23                  14a
     D  Qdbffigl                      5i 0
     D  Qdbfmxrl                      5i 0

     **-- Check special authority
     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
     D  AutInf                        1a
     D  UsrPrf                       10a   Const
     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
     D  NbrAut                       10i 0 Const
     D  CalLvl                       10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve database file description:
     D RtvDbfDsc       Pr                  ExtPgm( 'QDBRTVFD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FilNamRtnQ                   20a
     D  FmtNam                        8a   Const
     D  FilNamQ                      20a   Const
     D  RcdFmtNam                    10a   Const
     D  OvrPrc                        1a   Const
     D  System                       10a   Const
     D  FmtTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                      1024a          Options( *VarSize )

     **-- Check object existence:
     D ChkObj          Pr              n
     D  PxObjNam                     10a   Const
     D  PxObjLib                     10a   Const
     D  PxObjTyp                     10a   Const
     **-- Get creating user profile:
     D GetCrtUsr       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get user profile GID:
     D GetPrfGid       Pr            10i 0
     D  PxUsrPrf                     10a   Const
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX953V         Pr
     D  PxUsrPrf                     10a
     D  PxNewGrpPrf                  10a
     D  PxGrpOwn                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxGrpPrf                     10a
     D  PxRplPriGrp                   4a
     D  PxPrfOpt                      7a
     D  PxFile_q                           LikeDs( File_q )
     **
     D CBX953V         Pi
     D  PxUsrPrf                     10a
     D  PxNewGrpPrf                  10a
     D  PxGrpOwn                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxGrpPrf                     10a
     D  PxRplPriGrp                   4a
     D  PxPrfOpt                      7a
     D  PxFile_q                           LikeDs( File_q )

      /Free

        SpcAut( 1 ) = '*SECADM';
        SpcAut( 2 ) = '*ALLOBJ';

        ChkSpcAut( AutFlg
                 : PgmSts.UsrPrf
                 : SpcAut
                 : 2
                 : ADP_PRV_INVLVL
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
          SndDiagMsg( 'CPD0006'
                    : '0000Special authority *SECADM and *ALLOBJ required.'
                    );

          SndEscMsg( 'CPF0002': '' );
        EndIf;

        If  ChkObj( PxNewGrpPrf: '*LIBL': '*USRPRF' ) = *Off;
          SndDiagMsg( 'CPD0006': '0000Group profile does not exist.' );
          SndEscMsg( 'CPF0002': '' );
        EndIf;

        If  GetCrtUsr( PxNewGrpPrf ) = '*IBM';
          SndDiagMsg( 'CPD0006'
                    : '0000Group profile cannot be a system profile.'
                    );

          SndEscMsg( 'CPF0002': '' );
        EndIf;

        If  %Subst( PxNewGrpPrf: 1: 1 ) = 'Q';
          SndDiagMsg( 'CPD0006'
                    : '0000Group profile cannot be a system profile.'
                    );

          SndEscMsg( 'CPF0002': '' );
        EndIf;

        If  GetPrfGid( PxNewGrpPrf ) = *Zero;
          SndDiagMsg( 'CPD0006': '0000Group profile is not correct type.' );
          SndEscMsg( 'CPF0002': '' );
        EndIf;

        If  PxUsrPrf = '*FILE';

          If  ChkObj( PxFile_q.FilNam: PxFile_q.LibNam: '*FILE' ) = *Off;
            SndDiagMsg( 'CPD0006': '0000Specified file does not exist.' );
            SndEscMsg( 'CPF0002': '' );
          EndIf;

          RtvDbfDsc( Qdb_Qdbfh
                   : %Size( Qdb_Qdbfh )
                   : FilNamRtn_q
                   : 'FILD0100'
                   : PxFile_q
                   : '*FIRST'
                   : '0'
                   : '*LCL'
                   : '*EXT'
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl > *Zero  Or  Qdb_qdbfh.Qdbfmxrl <> 10;
            SndDiagMsg( 'CPD0006'
                      : '0000File must have a record length of 10 bytes.'
                      );

            SndEscMsg( 'CPF0002': '' );
          EndIf;
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Check object existence:  -------------------------------------------**
     P ChkObj          B
     D                 Pi              n
     D  PxObjNam                     10a   Const
     D  PxObjLib                     10a   Const
     D  PxObjTyp                     10a   Const
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : PxObjNam + PxObjLib
                : PxObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Off;

         Else;
           Return  *On;
         EndIf;

      /End-Free

     P ChkObj          E
     **-- Get creating user profile:
     P GetCrtUsr       B
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxUsrPrf + 'QSYS'
               : '*USRPRF'
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  OBJD0300.ObjCrt;
        EndIf;

      /End-Free

     P GetCrtUsr       E
     **-- Get user profile GID:
     P GetPrfGid       B
     D                 Pi            10i 0
     D  PxUsrPrf                     10a   Const

     **-- User information:
     D USRI0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  GID                          10i 0 Overlay( USRI0300: 597 )

      /Free

          RtvUsrInf( USRI0300
                   : %Size( USRI0300 )
                   : 'USRI0300'
                   : PxUsrPrf
                   : ERRC0100
                   );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Zero;

         Else;
           Return  USRI0300.GID;
         EndIf;

      /End-Free

     P GetPrfGid       E
     **-- Send diagnostic message:
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
     **-- Send escape message:
     P SndEscMsg       B
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
