     **
     **  Program . . : CBX920
     **  Description : Process file locks - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX920 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX920 )
     **              Module( CBX920 )
     **              ActGrp( QILE )
     **
     **
     **  PTF issues for QDBRJBRL API:
     **    V4R5: SA95609, SA95800
     **    V5R1: SE07985
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- System information:
     D PgmSts         Sds
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- Global variables & constants:
     D JobIdx          s             10u 0
     D RcdIdx          s             10u 0
     D PrcIdx          s             10u 0
     D MaxIdx          s             10u 0
     **
     D FncRqs          s             10i 0
     D MsgSntInd       s             10i 0
     **
     D PrdRcdLck       s               n
     D CmdStr          s            512a   Varying
     D MsgTyps         s             10a   Dim( 4 )
     D PrcJobIds       s             26a   Dim( 4096 )
     **
     D USRSPC          c                   'LSTOBJLCK QTEMP'
     D PROD_LIB        c                   '0'
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- API header information:
     D ApiHdrInf       Ds                  Qualified  Based( pHdrInf )
     D  UsrSpcU                      10a
     D  UsrLibU                      10a
     D  ObjNamU                      10a
     D  ObjLibU                      10a
     D  ObjTypR                      10a
     D  ObjExtAtr                    10a
     D  ShrFilNam                    10a
     D  ShrFilLib                    10a
     D  OfsPthNamU                   10i 0
     D  LenPthNamU                   10i 0
     D  ObjNamAspU                   10a
     D  ObjLibAspU                   10a
     **-- User space generic header:
     D UsrSpcHdr       Ds                  Qualified  Based( pUsrSpc )
     D  OfsHdr                       10i 0 Overlay( UsrSpcHdr: 117 )
     D  OfsLst                       10i 0 Overlay( UsrSpcHdr: 125 )
     D  NumLstEnt                    10i 0 Overlay( UsrSpcHdr: 133 )
     D  SizLstEnt                    10i 0 Overlay( UsrSpcHdr: 137 )
     **-- User space pointers:
     D pUsrSpc         s               *   Inz( *Null )
     D pHdrInf         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )
     **-- Object lock entry:
     D OBJL0100        DS                  Qualified  Based( pLstEnt )
     D  JobNamQ                      26a
     D   JobNam                      10a   Overlay( JobNamQ:  1 )
     D   JobUsr                      10a   Overlay( JobNamQ: 11 )
     D   JobNbr                       6a   Overlay( JobNamQ: 21 )
     D  LckStt                       10a
     D  LckSts                       10i 0
     D  LckTyp                       10i 0
     D  MbrNam                       10a
     D  Share                         1a
     D  LckScp                        1a
     D  ThdId                         8a
     **-- Job lock information:
     D RJBL0100        Ds         65535    Qualified
     D  LckAvl                       10i 0
     D  LckRtn                       10i 0
     D  OfsLckInf                    10i 0
     D  SizLckInf                    10i 0
     **
     D LckInf          Ds                  Qualified  Based( pLckInf )
     D  DbFilNam                     10a
     D  DbFilLib                     10a
     D  DbFilMbr                     10a
     D  LckSts                        1a
     D  LckStt                        1a
     D  LckRrn                       10u 0
     **-- Library information:
     D LibInf          Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  VarRtn                       10i 0
     D  VarAvl                       10i 0
     **
     D  RtnDtaLen                    10i 0
     D  KeyId                        10i 0
     D  FldSiz                       10i 0
     D  LibTyp                        1a
     **
     D RcvAtr          Ds                  Qualified
     D  NbrAtr                       10i 0 Inz( 1 )
     D  AtrAvl                       10i 0 Inz( 1 )
     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  CsSpcNamQ                    20a   Const
     D  CsExtAtr                     10a   Const
     D  CsInzSiz                     10i 0 Const
     D  CsInzVal                      1a   Const
     D  CsPubAut                     10a   Const
     D  CsText                       50a   Const
     D  CsReplace                    10a   Const  Options( *NoPass )
     D  CsError                   32767a          Options( *NoPass: *VarSize )
     D  CsDomain                     10a   Const  Options( *NoPass )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  DsSpcNamQ                    20a   Const
     D  DsError                   32767a          Options( *VarSize )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a          Options( *NoPass: *VarSize )
     **-- List object locks:
     D LstObjLck       Pr                  ExtPgm( 'QWCLOBJL' )
     D  OlSpcNamQ                    20a   Const
     D  OlFmtNam                      8a   Const
     D  OlObjNamQ                    20a   Const
     D  OlObjTyp                     10a   Const
     D  OlMbrNam                     10a   Const
     D  OlError                   32767a          Options( *VarSize )
     D  OlPthNam                   1024a   Const  Options( *NoPass:  *VarSize )
     D  OlPthNamLen                  10i 0 Const  Options( *NoPass )
     D  OlObjAspQ                    10a   Const  Options( *NoPass )
     **-- Retrieve job record locks:
     D RtvJobLck       Pr                  ExtPgm( 'QDBRJBRL' )
     D  JlRcvVar                  65535a          Options( *VarSize )
     D  JlRcvVarLen                  10i 0 Const
     D  JlFmtNam                      8a   Const
     D  JlJobNam                     26a   Const
     D  JlError                   32767a          Options( *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Retrieve library information:
     D RtvLibInf       Pr                  ExtPgm( 'QLIRLIBD' )
     D  RlRcvVar                   1024a          Options( *VarSize )
     D  RlRcvVarLen                  10i 0 Const
     D  RlLibNam                     10a   Const
     D  RlRcvAtr                   1024a   Const  Options( *VarSize )
     D  RlError                   32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RoRcvVar                  32767a          Options( *VarSize )
     D  RoRcvVarLen                  10i 0 Const
     D  RoFmtNam                      8a   Const
     D  RoObjNamQ                    20a   Const
     D  RoObjTyp                     10a   Const
     D  RoError                   32767a          Options( *VarSize )
     **-- Execute command:
     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
     D  XcCmd                       512a   Const  Options( *VarSize )
     D  XcCmdLen                     15p 5 Const
     D  XcCmdIGC                      3a   Const  Options( *NoPass )
     **-- Send break message:
     D SndBrkMsg       Pr                  ExtPgm( 'QMHSNDBM' )
     D  SbMsgTxt                   6000a   Const  Options( *VarSize )
     D  SbMsgTxtLen                  10i 0 Const
     D  SbMsgTyp                     10a   Const
     D  SbMsgQueQ                    20a   Const  Options( *VarSize )  Dim( 50 )
     D  SbMsgQueNbr                  10i 0 Const
     D  SbMsgQueRpy                  20a   Const
     D  SbError                   32767a          Options( *VarSize )
     D  SbCcsId                      10i 0 Const  Options( *NoPass )
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
     D  SmMsgTyp                     10a   Const
     D  SmDlvMod                     10a   Const
     D  SmMsgTxt                    494a   Const  Options( *VarSize )
     D  SmMsgTxtLen                  10i 0 Const
     D  SmMsgRcv                     10a   Const  Options( *VarSize ) Dim( 299 )
     D  SmMsgRcvNbr                  10i 0 Const
     D  SmMsgSntInd                  10i 0
     D  SmFncRqs                     10i 0
     D  SmError                   32767a          Options( *VarSize )
     D  SmShwSndMsgDs                 1a   Const  Options( *NoPass )
     D  SmMsgQueNam                  20a   Const  Options( *NoPass )
     D  SmNamTypInd                   4a   Const  Options( *NoPass )
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
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
     **-- Move program messages:
     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
     D  MpMsgKey                      4a   Const
     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
     D  MpNbrMsgTyps                 10i 0 Const
     D  MpToCalStkE                4102a   Const  Options( *VarSize )
     D  MpToCalStkCnt                10i 0 Const
     D  MpError                   32767a          Options( *VarSize )
     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )

     **-- Validate special authority:
     D ValSpcAut       Pr            10i 0
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value
     **-- Set member option:
     D SetMbrOpt       Pr            10a
     D  RaFilNamQ                    20a   Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send message by type:
     D SndMsgTyp       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const

     **-- Entry parameters:
     D CBX920          Pr
     D  PxFilNamQ                    20a
     D  PxAction                      7a
     D  PxMsgTxt                    512a   Varying
     D  PxMsgTo                       5a
     D  PxEndOpt                      7a
     D  PxDelay                      10i 0
     D  PxIgnRcdLck                   4a
     **
     D CBX920          Pi
     D  PxFilNamQ                    20a
     D  PxAction                      7a
     D  PxMsgTxt                    512a   Varying
     D  PxMsgTo                       5a
     D  PxEndOpt                      7a
     D  PxDelay                      10i 0
     D  PxIgnRcdLck                   4a

      /Free

        If  ValSpcAut( PsUsrPrf: '*JOBCTL' ) = -1;

          SndEscMsg( 'CPFB0CE'
                   : 'QCPFMSG'
                   : '*JOBCTL'
                   );
        Else;

          CrtUsrSpc( USRSPC
                   : *Blanks
                   : 65535
                   : x'00'
                   : '*CHANGE'
                   : *Blanks
                   : '*YES'
                   : ERRC0100
                   );

          LstObjLck( USRSPC
                   : 'OBJL0100'
                   : PxFilNamQ
                   : '*FILE'
                   : SetMbrOpt( PxFilNamQ )
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;
            ExSr  PrcLstEnt;

          Else;
            SndEscMsg( ERRC0100.MsgId
                     : 'QCPFMSG'
                     : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
                     );

          EndIf;
        EndIf;

        DltUsrSpc( USRSPC: ERRC0100 );

        *InLr = *On;

        Return;

        BegSr  PrcLstEnt;

          RtvPtrSpc( USRSPC: pUsrSpc );

          pHdrInf = pUsrSpc + UsrSpcHdr.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpcHdr.OfsLst;

          For  JobIdx = 1  to UsrSpcHdr.NumLstEnt;

            If  %Lookup( OBJL0100.JobNamQ: PrcJobIds: 1: MaxIdx ) = *Zero;

              ExSr  LodJobId;

              If  PxAction = '*BRKMSG';
                ExSr  SndNtfMsg;

              Else;
                ExSr  RunEndJob;
              EndIf;
            EndIf;

            If  JobIdx < UsrSpcHdr.NumLstEnt;
              pLstEnt = pLstEnt + UsrSpcHdr.SizLstEnt;
            EndIf;
          EndFor;

          SndMsgTyp( 'Lock processing completed normally.': '*COMP' );

        EndSr;

        BegSr  LodJobId;

          If  PrcIdx < %Elem( PrcJobIds );
            PrcIdx = PrcIdx + 1;

            If  PrcIdx > MaxIdx;
              MaxIdx = PrcIdx;
            EndIf;

          Else;
            PrcIdx = 1;
          EndIf;

          PrcJobIds(PrcIdx) = OBJL0100.JobNamQ;

        EndSr;

        BegSr  RunEndJob;

          If  PxIgnRcdLck = '*NO';
            ExSr  ChkRcdLck;
          EndIf;

          If  PxIgnRcdLck = '*YES'  Or
              PrdRcdLck   = *Off;

            CmdStr = 'ENDJOB JOB('                       +
                      %Trim( OBJL0100.JobNbr )           + '/'  +
                      %Trim( OBJL0100.JobUsr )           + '/'  +
                      %Trim( OBJL0100.JobNam )           + ') ' +
                     'OPTION(' + %Trim( PxEndOpt )       + ') ' +
                     'DELAY(' + %Char( PxDelay )         + ') ' +
                     'SPLFILE(*NO) LOGLMT(*SAME) ADLINTJOBS(*NONE)';

            Monitor;
              ExcCmd( CmdStr: %Len( CmdStr ));

            On-Error;
              MsgTyps(1) = '*DIAG';
              MsgTyps(2) = '*ESCAPE';

              MovPgmMsg( *Blanks
                       : MsgTyps
                       : 2
                       : '*PGMBDY'
                       : 1
                       : ERRC0100
                       );

              LeaveSr;
            EndMon;

              MovPgmMsg( *Blanks
                       : '*COMP'
                       : 1
                       : '*PGMBDY'
                       : 1
                       : ERRC0100
                       );
          EndIf;

        EndSr;

        BegSr  ChkRcdLck;

          Eval  PrdRcdLck = *Off;

          RtvJobLck( RJBL0100
                   : %Size( RJBL0100 )
                   : 'RJBL0100'
                   : OBJL0100.JobNam + OBJL0100.JobUsr + OBJL0100.JobNbr
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;
            ExSr  PrcJobLck;
          EndIf;

        EndSr;

        BegSr  SndNtfMsg;

          If  PxMsgTo = '*JOB';

            SndBrkMsg( PxMsgTxt
                     : %Len( PxMsgTxt )
                     : '*INFO'
                     : OBJL0100.JobNam + '*LIBL'
                     : 1
                     : ' '
                     : ERRC0100
                     );

        If  ERRC0100.BytAvl > *Zero;

          MovPgmMsg( *Blanks
                   : '*DIAG'
                   : 1
                   : '*PGMBDY'
                   : 1
                   : ERRC0100
                   );
        EndIf;

          Else;

            SndMsg( '*INFO'
                  : '*BREAK'
                  : PxMsgTxt
                  : %Len( PxMsgTxt )
                  : OBJL0100.JobUsr
                  : 1
                  : MsgSntInd
                  : FncRqs
                  : ERRC0100
                  : 'N'
                  : *Blanks
                  : '*USR'
                  );
        EndIf;

        EndSr;

        BegSr  PrcJobLck;

          pLckInf = %Addr( RJBL0100 ) + RJBL0100.OfsLckInf;

          For  RcdIdx = 1  to RJBL0100.LckRtn;

            RtvLibInf( LibInf
                     : %Size( LibInf )
                     : LckInf.DbFilLib
                     : RcvAtr
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero  And
                LibInf.LibTyp   = PROD_LIB;

              SndMsgTyp( 'Job '              + %TrimR( OBJL0100.JobNam ) +
                         ' has locked file ' + %TrimR( LckInf.DbFilNam ) +
                         ' record number '   + %Char( LckInf.LckRrn )    +
                         ', job not ended.'
                       : '*INFO'
                       );

              Eval  PrdRcdLck = *On;
              Leave;
            EndIf;

            If  RcdIdx < RJBL0100.LckRtn;
              Eval  pLckInf = pLckInf + RJBL0100.SizLckInf;
            EndIf;
          EndFor;

        EndSr;

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
     **-- Send message by type:  ---------------------------------------------**
     P SndMsgTyp       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : PxMsgTyp
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

     P SndMsgTyp       E
     **-- Set member option:  ------------------------------------------------**
     P SetMbrOpt       B                   Export
     D                 Pi            10a
     D  RaFilNamQ                    20a   Const
     **
     D OBJD0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTypRt                     10a
     D  ObjLibRt                     10a
     D  ObjASP                       10i 0
     D  ObjOwn                       10a
     D  ObjDmn                        2a
     D  ObjCrtDT                     13a
     D  ObjChgDT                     13a
     D  ExtAtr                       10a
     D  TxtDsc                       50a
     D  SrcF                         10a
     D  SrcLib                       10a
     D  SrcMbr                       10a

      /Free

         RtvObjD( OBJD0200
                : %Size( OBJD0200 )
                : 'OBJD0200'
                : RaFilNamQ
                : '*FILE'
                : ERRC0100
                );

         Select;
         When  ERRC0100.BytAvl > *Zero;
           Return  '*NONE';

         When  OBJD0200.ExtAtr = 'PF'  Or
               OBJD0200.ExtAtr = 'LF';
           Return  '*ALL';

         Other;
           Return  '*NONE';
         EndSl;

         Return    OBJD0200.ExtAtr;

      /End-Free

     P SetMbrOpt       E
     **-- Validate special authority:  ---------------------------------------**
     P ValSpcAut       B                   Export
     D                 Pi            10i 0
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value
     **
     D USRI0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  SpcAut                       15a   Overlay( USRI0200: 29 )
     D   AllObj                       1a   Overlay( SpcAut: 1 )
     D   SecAdm                       1a   Overlay( SpcAut: *Next )
     D   JobCtl                       1a   Overlay( SpcAut: *Next )
     D   SplCtl                       1a   Overlay( SpcAut: *Next )
     D   SavSys                       1a   Overlay( SpcAut: *Next )
     D   Service                      1a   Overlay( SpcAut: *Next )
     D   Audit                        1a   Overlay( SpcAut: *Next )
     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return -1;

        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
          Return  0;

        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
          Return  0;

        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
          Return  0;

        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
          Return  0;

        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
          Return  0;

        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
          Return  0;

        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
          Return  0;

        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
          Return  0;

        Other;
          Return -1;
        EndSl;

      /End-Free

     P ValSpcAut       E
