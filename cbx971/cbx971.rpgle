     **
     **  Program . . : CBX971
     **  Description : Work with Output Queue Authorities - CPP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( CBX971 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX971 )
     **                Module( CBX971 )
     **                ActGrp( *NEW )
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D TYP_INTER       c                   'I'
     **-- UIM constants:
     D PNLGRP_Q        c                   'CBX971P   *LIBL     '
     D PNLGRP          c                   'CBX971P   '
     D SCP_AUT_RCL     c                   -1
     D RDS_OPT_INZ     c                   'N'
     D PRM_IFC_0       c                   0
     D CLO_NORM        c                   'M'
     D FNC_EXIT        c                   -4
     D FNC_CNL         c                   -8
     D KEY_F05         c                   5
     D KEY_F17         c                   17
     D KEY_F18         c                   18
     D RTN_ENTER       c                   500
     D HLP_WDW         c                   'N'
     D POS_TOP         c                   'TOP'
     D POS_BOT         c                   'BOT'
     D LIST_COMP       c                   'ALL'
     D LIST_SAME       c                   'SAME'
     D EXIT_SAME       c                   '*SAME'
     D TRIM_SAME       c                   'S'
     **
     D APP_PRTF        c                   'QPRINT    *LIBL'
     D ODP_SHR         c                   'N'
     D SPLF_NAM        c                   'PSVRAUTE'
     D SPLF_USRDTA     c                   'WRKSVRAUTE'
     D EJECT_NO        c                   'N'

     **-- Global variables:
     D Idx             s             10i 0
     D SysDts          s               z
     D WrkUsr          s             10a

     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  AppHdl                        8a
     D  LstHdl                        4a
     D  EntHdl                        4a
     D  FncRqs                       10i 0
     D  EntLocOpt                     4a
     D  LstPos                        4a
     **-- List attributes structure:
     D LstAtr          Ds                  Qualified
     D  LstCon                        4a
     D  ExtPgmVar                    10a
     D  DspPos                        4a
     D  AlwTrim                       1a

     **-- UIM Panel exit prgram record:
     D ExpRcd          Ds                  Qualified
     D  ExitPg                       20a   Inz( 'CBX971E   *LIBL' )
     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  OutQue                       20a
     D  WrkUsr                       10a
     D  PosUsr                       10a
     D  DspDta                       10a
     D  OprCtl                       10a
     D  AutChk                       10a
     D  QueOwn                       10a
     D  PubAut                       10a
     D  QueAutL                      10a
     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  UsrPrf                       10a
     D  UsrCls                       10a
     D  GrpPrf                       10a
     D  NbrSupGrp                     5i 0
     D  SplCtl                        1a
     D  JobCtl                        1a
     D  AutSrc                        2a
     D  QueAut                       10a
     D  QueRead                       1a
     D  QueRAD                        1a
     D  QueMgt                        1a
     D  StrWtr                        1a
     D  AddSpl                        1a
     D  WrkWth                        1a
     D  QueOpr                        1a
     D  QueOpm                        1a
     D  SplCon                        1a
     D  SplOpr                        1a
     **
     D LstEntPos       Ds                  LikeDs( LstEnt )

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  GrpNam                       10a
     D  SltCri                       10a
     **-- Return records feedback information:
     D RtnRcdFbi       Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  NbrSvrAutE                   10i 0
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a

     **-- User information:
     D AUTU0150        Ds                  Qualified
     D  UsrPrf                       10a
     D  UsrGrpI                       1a
     D  GrpMbrI                       1a
     D  TxtDsc                       50a
     **-- Output queue information:
     D OUTQ0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OutQue_q                     20a
     D   OutQueNam                   10a   Overlay( OutQue_q: 1 )
     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
     D  FilOrd                       10a
     D  DspAnyF                      10a
     D  JobSep                       10i 0
     D  OprCtl                       10a
     D  DtaQueNam                    10a
     D  DtaQueLib                    10a
     D  AutChk                       10a
     D  NbrFil                       10i 0
     D  OutQueSts                    10a
     D  WtrJobNam                    10a
     D  WtrJobUsr                    10a
     D  WtrJobNbr                     6a
     D  WtrJobSts                    10a
     D  PrtDevNam                    10a
     D  OutQueTxt                    50a
     D                                2a
     D  NbrSpfPag                    10i 0
     D  NbrWtrStr                    10i 0
     D  WtrAutStr                    10i 0
     **-- User profile information:
     D USRI0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  UsrCls                       10a
     D  SpcAut                       15a   Overlay( USRI0200: 29 )
     D   AllObj                       1a   Overlay( SpcAut: 1 )
     D   SecAdm                       1a   Overlay( SpcAut: *Next )
     D   JobCtl                       1a   Overlay( SpcAut: *Next )
     D   SplCtl                       1a   Overlay( SpcAut: *Next )
     D   SavSys                       1a   Overlay( SpcAut: *Next )
     D   Service                      1a   Overlay( SpcAut: *Next )
     D   Audit                        1a   Overlay( SpcAut: *Next )
     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )
     D  GrpPrf                       10a
     D  PrfOwn                       10a
     D  GrpAut                       10a
     D  LmtCap                       10a
     D  GrpAutTyp                    10a
     D                                3a
     D  OfsSupGrp                    10i 0
     D  NbrSupGrp                    10i 0
     **-- Object authority information:
     D USRA0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjAut                       10a
     D  AutLstMgt                     1a
     D  ObjOpr                        1a
     D  ObjMgt                        1a
     D  ObjExs                        1a
     D  DtaRead                       1a
     D  DtaAdd                        1a
     D  DtaUpd                        1a
     D  DtaDlt                        1a
     D  AutLst                       10a
     D  AutSrc                        2a
     D  AdpAut                        1a
     D  AdpObjAut                    10a
     D  AdpAutLstMgt                  1a
     D  AdpObjOpr                     1a
     D  AdpObjMgt                     1a
     D  AdpObjExs                     1a
     D  AdpDtaRead                    1a
     D  AdpDtaAdd                     1a
     D  AdpDtaUpd                     1a
     D  AdpDtaDlt                     1a
     D  AdpDtaExe                     1a
     D                               10a
     D  AdpObjAlt                     1a
     D  AdpObjRef                     1a
     D                               10a
     D  DtaExe                        1a
     D                               10a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     D  AspDevLib                    10a
     D  AspDevObj                    10a

     **-- Open list of authorized users:
     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  FmtNam                        8a   Const
     D  SltCri                       10a   Const
     D  GrpNam                       10a   Const
     D  Error                      1024a          Options( *VarSize )
     D  UsrPrf                       10a   Const  Options( *NoPass )
     **-- Retrieve output queue information:
     D RtvOutQueInf    Pr                  ExtPgm( 'QSPROUTQ' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  OutQue_q                     20a   Const
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
     **-- Retrieve user authority to object:
     D RtvUsrAut       Pr                  ExtPgm( 'QSYRUSRA' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  UsrPrf                       10a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  AspDev                       10a          Options( *NoPass )

     **-- Get open list entry:
     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  Handle                        4a   Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  RtnRcdNbr                    10i 0 Const
     D  Error                      1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  Handle                        4a   Const
     D  Error                      1024a          Options( *VarSize )
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
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNamQ                      26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a         Options( *NoPass: *VarSize )

     **-- Open display application:
     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
     D  AppHdl                        8a
     D  PnlGrp_q                     20a   Const
     D  AppScp                       10i 0 Const
     D  ExtPrmIfc                    10i 0 Const
     D  FulScrHlp                     1a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Add print application:
     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
     D  AppHdl                        8a   Const
     D  PrtDevF_q                    20a   Const
     D  AltFilNam                    10a   Const
     D  ShrOpnDtaPth                  1a   Const
     D  UsrDta                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Open print application:
     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
     D  AppHdl                        8a
     D  PnlGrp_q                     20a   Const
     D  AppScp                       10i 0 Const
     D  ExtPrmIfc                    10i 0 Const
     D  PrtDevF_q                    20a   Const
     D  AltFilNam                    10a   Const
     D  ShrOpnDtaPth                  1a   Const
     D  UsrDta                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Display panel:
     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
     D  AppHdl                        8a   Const
     D  FncRqs                       10i 0
     D  PnlNam                       10a   Const
     D  ReDspOpt                      1a   Const
     D  Error                     32767a          Options( *VarSize )
     D  UsrTsk                        1a   Const  Options( *NoPass )
     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
     D  MsgKey                        4a   Const  Options( *NoPass )
     D  CsrPosOpt                     1a   Const  Options( *NoPass )
     D  FinLstEnt                     4a   Const  Options( *NoPass )
     D  ErrLstEnt                     4a   Const  Options( *NoPass )
     D  WaitTim                      10i 0 Const  Options( *NoPass )
     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
     D  CalQlf                       20a   Const  Options( *NoPass )
     **-- Print panel:
     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
     D  AppHdl                        8a   Const
     D  PrtPnlNam                    10a   Const
     D  EjtOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Put dialog variable:
     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Get dialog variable:
     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a          Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Add list entry:
     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  EntLocOpt                     4a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  PosOpt                        4a   Const
     D  CpyOpt                        1a   Const
     D  SltCri                       20a   Const
     D  SltHdl                        4a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve list attributes:
     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  AtrRcv                    32767a          Options( *VarSize )
     D  AtrRcvLen                    10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **-- Set list attributes:
     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  LstCon                        4a   Const
     D  ExtPgmVar                    10a   Const
     D  DspPos                        4a   Const
     D  AlwTrim                       1a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Delete list:
     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Close application:
     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
     D  AppHdl                        8a   Const
     D  CloOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Get job type:
     D GetJobTyp       Pr             1a
     **-- Get object owner:
     D GetObjOwn       Pr            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Get object public authority:
     D GetPubAut       Pr            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Get object authorization list:
     D GetObjAutL      Pr            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Get user class:
     D GetUsrCls       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get group profile:
     D GetGrpPrf       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get number of supplemental group profiles:
     D GetNbrSupGrp    Pr             5i 0
     D  PxUsrPrf                     10a   Value
     **-- Validate special authority:
     D ValSpcAut       Pr              n
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value
     **-- Send status message:
     D SndStsMsg       Pr            10i 0
     D  PxMsgDta                   1024a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a
     **
     D CBX971          Pr
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxUsrPrf                     10a
     D  PxOutOpt                      3a
     **
     D CBX971          Pi
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxUsrPrf                     10a
     D  PxOutOpt                      3a

      /Free

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;

          OpnDspApp( UIM.AppHdl
                   : PNLGRP_Q
                   : SCP_AUT_RCL
                   : PRM_IFC_0
                   : HLP_WDW
                   : ERRC0100
                   );
        Else;
          OpnPrtApp( UIM.AppHdl
                   : PNLGRP_Q
                   : SCP_AUT_RCL
                   : PRM_IFC_0
                   : APP_PRTF
                   : SPLF_NAM
                   : ODP_SHR
                   : SPLF_USRDTA
                   : ERRC0100
                   );
        EndIf;

        If  ERRC0100.BytAvl > *Zero;
          ExSr  EscApiErr;
        EndIf;

        SndStsMsg( 'Retrieving output queue information, please wait...' );

        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );

        ExSr  BldHdrRcd;
        ExSr  BldAutUsrLst;

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;
          ExSr  DspLst;
        Else;
          ExSr  WrtLst;
        EndIf;

        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );

        *InLr = *On;
        Return;


        BegSr  EscApiErr;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );

        EndSr;

        BegSr  DspLst;

          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;

            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );

            If  ERRC0100.BytAvl > *Zero;
              ExSr  EscApiErr;
            EndIf;

            GetDlgVar( UIM.AppHdl
                     : HdrRcd
                     : %Size( HdrRcd )
                     : 'HDRRCD'
                     : ERRC0100
                     );

            Select;
            When  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
              ExSr  GetLstPos;
              ExSr  DltUsrLst;

            When  WrkUsr <> HdrRcd.WrkUsr;
              ExSr  DltUsrLst;
            EndSl;

            Select;
            When  UIM.FncRqs = KEY_F05;
              ExSr  RstHdrRcd;
              ExSr  BldHdrRcd;
              ExSr  BldAutUsrLst;
              ExSr  SetLstPos;

            When  WrkUsr <> HdrRcd.WrkUsr;
              WrkUsr = HdrRcd.WrkUsr;

              ExSr  BldHdrRcd;
              ExSr  BldAutUsrLst;
            EndSl;

            Select;
            When  UIM.FncRqs = RTN_ENTER  And
                  UIM.EntLocOpt = 'NEXT'  And
                  HdrRcd.PosUsr > *Blanks;

              ExSr  FndLstPos;

            When  UIM.FncRqs = KEY_F17;
              ExSr  PosLstTop;

            When  UIM.FncRqs = KEY_F18;
              ExSr  PosLstBot;
            EndSl;

          EndDo;

        EndSr;

        BegSr  WrtLst;

          PrtPnl( UIM.AppHdl
                : 'PRTHDR'
                : EJECT_NO
                : ERRC0100
                );

          PrtPnl( UIM.AppHdl
                : 'PRTLST'
                : EJECT_NO
                : ERRC0100
                );

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  BldAutUsrLst;

          UIM.EntLocOpt = 'FRST';
          USRI0200.UsrPrf = *Blanks;

          LstApi.RtnRcdNbr = 1;
          LstApi.SltCri = '*ALL';
          LstApi.GrpNam = '*NONE';

          LstAutUsr( AUTU0150
                   : %Size( AUTU0150 )
                   : LstInf
                   : 1
                   : 'AUTU0150'
                   : LstApi.SltCri
                   : LstApi.GrpNam
                   : ERRC0100
                   : WrkUsr
                   );

          If  ERRC0100.BytAvl = *Zero;

            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

              ExSr  PrcLstEnt;

              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

              GetOplEnt( AUTU0150
                       : %Size( AUTU0150 )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;

            EndDo;

            CloseLst( LstInf.Handle: ERRC0100 );
          EndIf;

          SetLstAtr( UIM.AppHdl
                   : 'DTLLST'
                   : LIST_COMP
                   : EXIT_SAME
                   : POS_TOP
                   : TRIM_SAME
                   : ERRC0100
                   );

        EndSr;

        BegSr  PrcLstEnt;

          RtvUsrAut( USRA0100
                   : %Size( USRA0100 )
                   : 'USRA0100'
                   : AUTU0150.UsrPrf
                   : OUTQ0100.OutQueNam + OUTQ0100.OutQueLib
                   : '*OUTQ'
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            LstEnt.UsrPrf = AUTU0150.UsrPrf;
            LstEnt.UsrCls = GetUsrCls( AUTU0150.UsrPrf );
            LstEnt.GrpPrf = GetGrpPrf( AUTU0150.UsrPrf );
            LstEnt.NbrSupGrp = GetNbrSupGrp( AUTU0150.UsrPrf );

            LstEnt.SplCtl  = 'N';
            LstEnt.JobCtl  = 'N';
            LstEnt.QueRead = 'N';
            LstEnt.QueRAD  = 'N';
            LstEnt.QueMgt  = 'N';

            If  ValSpcAut( AUTU0150.UsrPrf: '*SPLCTL' ) = *On;
              LstEnt.SplCtl = 'Y';
            EndIf;

            If  ValSpcAut( AUTU0150.UsrPrf: '*JOBCTL' ) = *On;
              LstEnt.JobCtl = 'Y';
            EndIf;

            If  USRA0100.DtaRead = 'Y';
              LstEnt.QueRead = 'Y';
            EndIf;

            If  USRA0100.DtaRead = 'Y'  And
                USRA0100.DtaAdd  = 'Y'  And
                USRA0100.DtaDlt  = 'Y';
              LstEnt.QueRAD = 'Y';
            EndIf;

            If  USRA0100.ObjMgt = 'Y';
              LstEnt.QueMgt = 'Y';
            EndIf;

            ExSr  SetAutFlg;

            ExSr  PutLstEnt;
          EndIf;

        EndSr;

        BegSr  SetAutFlg;

          LstEnt.StrWtr = 'N';
          LstEnt.AddSpl = 'N';
          LstEnt.WrkWth = 'N';
          LstEnt.QueOpr = 'N';
          LstEnt.QueOpm = 'N';
          LstEnt.SplCon = 'N';
          LstEnt.SplOpr = 'N';

          If  LstEnt.SplCtl = 'Y';
            LstEnt.StrWtr = 'Y';
            LstEnt.AddSpl = 'Y';
            LstEnt.WrkWth = 'Y';
            LstEnt.QueOpr = 'Y';
            LstEnt.QueOpm = 'Y';
            LstEnt.SplCon = 'Y';
            LstEnt.SplOpr = 'Y';
          Else;

            If  HdrRcd.AutChk = '*DTAAUT'       And
                LstEnt.QueRAD = 'Y'             Or

                HdrRcd.AutChk  = '*OWNER'       And
                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or

                HdrRcd.OprCtl = '*YES'          And
                LstEnt.JobCtl = 'Y';

              LstEnt.StrWtr = 'Y';
            EndIf;

            If  LstEnt.QueRead = 'Y'  Or

                LstEnt.JobCtl  = 'Y'  And
                HdrRcd.OprCtl  = '*YES';

              LstEnt.AddSpl = 'Y';
            EndIf;

            If  LstEnt.QueRead = 'Y'  Or

                LstEnt.JobCtl  = 'Y'  And
                HdrRcd.OprCtl  = '*YES';

              LstEnt.WrkWth = 'Y';
            EndIf;

            If  HdrRcd.AutChk  = '*DTAAUT'      And
                LstEnt.QueRAD  = 'Y'            Or

                HdrRcd.AutChk  = '*OWNER'       And
                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or

                HdrRcd.OprCtl  = '*YES'         And
                LstEnt.JobCtl  = 'Y';

              LstEnt.QueOpr = 'Y';
            EndIf;

            If  LstEnt.QueOpr = 'Y'  And
                LstEnt.QueMgt = 'Y';

              LstEnt.QueOpm = 'Y';
            EndIf;

            Select;
            When  HdrRcd.DspDta  = '*YES'         And
                  LstEnt.QueRead = 'Y'            Or

                  HdrRcd.AutChk  = '*DTAAUT'      And
                  LstEnt.QueRAD  = 'Y'            Or

                  HdrRcd.AutChk  = '*OWNER'       And
                  LstEnt.UsrPrf  = HdrRcd.QueOwn  Or

                  HdrRcd.DspDta  = '*YES'         And
                  HdrRcd.OprCtl  = '*YES'         And
                  LstEnt.JobCtl  = 'Y'            Or

                  HdrRcd.DspDta  = '*NO'          And
                  HdrRcd.OprCtl  = '*YES'         And
                  LstEnt.JobCtl  = 'Y';

              LstEnt.SplCon = 'Y';

            When  HdrRcd.DspDta = '*OWNER';
              LstEnt.SplCon = 'O';
            EndSl;

            If  HdrRcd.AutChk  = '*DTAAUT'      And
                LstEnt.QueRAD  = 'Y'            Or

                HdrRcd.AutChk  = '*OWNER'       And
                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or

                HdrRcd.OprCtl  = '*YES'         And
                LstEnt.JobCtl  = 'Y';

              LstEnt.SplOpr = 'Y';
            EndIf;

          EndIf;

        EndSr;

        BegSr  PutLstEnt;

          LstEnt.Option = *Zero;

          LstEnt.AutSrc = USRA0100.AutSrc;
          LstEnt.QueAut = USRA0100.ObjAut;

          AddLstEnt( UIM.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : UIM.EntLocOpt
                   : UIM.LstHdl
                   : ERRC0100
                   );

              UIM.EntLocOpt = 'NEXT';

        EndSr;

        BegSr  GetLstPos;

          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );

          If  LstAtr.DspPos <> 'TOP';

            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : 'DTLRCD'
                     : 'DTLLST'
                     : 'HNDL'
                     : 'Y'
                     : *Blanks
                     : LstAtr.DspPos
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            LstEntPos = LstEnt;
          EndIf;

        EndSr;

        BegSr  SetLstPos;

          If  LstAtr.DspPos <> 'TOP';

            LstEnt = LstEntPos;

            PutDlgVar( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : 'DTLRCD'
                     : ERRC0100
                     );

            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'FSLT'
                     : 'N'
                     : 'EQ        USRPRF'
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;

              SetLstAtr( UIM.AppHdl
                       : 'DTLLST'
                       : LIST_SAME
                       : EXIT_SAME
                       : UIM.EntHdl
                       : TRIM_SAME
                       : ERRC0100
                       );

            EndIf;
          EndIf;

        EndSr;

        BegSr  FndLstPos;

          LstEnt.UsrPrf = HdrRcd.PosUsr;

          PutDlgVar( UIM.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : ERRC0100
                   );

          GetLstEnt( UIM.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'FSLT'
                   : 'Y'
                   : 'GE        USRPRF'
                   : *Blanks
                   : 'N'
                   : UIM.EntHdl
                   : ERRC0100
                   );

          Select;
          When  ERRC0100.BytAvl > *Zero;
            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'LAST'
                     : 'N'
                     : *Blanks
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

          When  %Scan( %Trim( HdrRcd.PosUsr ): LstEnt.UsrPrf ) <> 1;
            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'PREV'
                     : 'N'
                     : *Blanks
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl > *Zero;
              GetLstEnt( UIM.AppHdl
                       : LstEnt
                       : %Size( LstEnt )
                       : '*NONE'
                       : 'DTLLST'
                       : 'FRST'
                       : 'N'
                       : *Blanks
                       : *Blanks
                       : 'N'
                       : UIM.EntHdl
                       : ERRC0100
                       );
            EndIf;
          EndSl;

          If  ERRC0100.BytAvl = *Zero;

            SetLstAtr( UIM.AppHdl
                     : 'DTLLST'
                     : LIST_SAME
                     : EXIT_SAME
                     : UIM.EntHdl
                     : TRIM_SAME
                     : ERRC0100
                     );

          EndIf;

          HdrRcd.PosUsr = *Blanks;

        EndSr;

        BegSr  PosLstTop;

          SetLstAtr( UIM.AppHdl
                   : 'DTLLST'
                   : LIST_SAME
                   : EXIT_SAME
                   : POS_TOP
                   : TRIM_SAME
                   : ERRC0100
                   );

        EndSr;

        BegSr  PosLstBot;

          SetLstAtr( UIM.AppHdl
                   : 'DTLLST'
                   : LIST_SAME
                   : EXIT_SAME
                   : POS_BOT
                   : TRIM_SAME
                   : ERRC0100
                   );

        EndSr;

        BegSr  BldHdrRcd;

          RtvOutQueInf( OUTQ0100
                      : %Size( OUTQ0100 )
                      : 'OUTQ0100'
                      : PxOutQue_q
                      : ERRC0100
                      );

          If  ERRC0100.BytAvl = *Zero;
            HdrRcd.OutQue = OUTQ0100.OutQue_q;
            HdrRcd.DspDta = OUTQ0100.DspAnyF;
            HdrRcd.OprCtl = OUTQ0100.OprCtl;
            HdrRcd.AutChk = OUTQ0100.AutChk;

            HdrRcd.QueOwn  = GetObjOwn( OUTQ0100.OutQue_q: '*OUTQ' );
            HdrRcd.PubAut  = GetPubAut( OUTQ0100.OutQue_q: '*OUTQ' );
            HdrRcd.QueAutL = GetObjAutL( OUTQ0100.OutQue_q: '*OUTQ' );
          EndIf;

          SysDts = %Timestamp();

          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
          HdrRcd.TimZon = '*SYS';

          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

        EndSr;

        BegSr  RstHdrRcd;

          HdrRcd.WrkUsr = WrkUsr;
          HdrRcd.PosUsr = *Blanks;

        EndSr;

        BegSr  *InzSr;

          HdrRcd.WrkUsr = PxUsrPrf;
          HdrRcd.PosUsr = *Blanks;

          WrkUsr = HdrRcd.WrkUsr;

        EndSr;

        BegSr  DltUsrLst;

          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );

        EndSr;

      /End-Free

     **-- Get job type:
     P GetJobTyp       B
     D                 Pi             1a

     D JOBI0400        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  JobNam                       10a
     D  UsrNam                       10a
     D  JobNbr                        6a
     D  JobIntId                     16a
     D  JobSts                       10a
     D  JobTyp                        1a
     D  JobSubTyp                     1a

      /Free

        RtvJobInf( JOBI0400
                 : %Size( JOBI0400 )
                 : 'JOBI0400'
                 : '*'
                 : *Blank
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blank;

        Else;
          Return  JOBI0400.JobTyp;
        EndIf;

      /End-Free

     P GetJobTyp       E
     **-- Get object owner:
     P GetObjOwn       B
     D                 Pi            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  ObjLibRtn                    10a
     D  ObjASP                       10i 0
     D  ObjOwn                       10a
     D  ObjDmn                        2a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : PxObjNam_q
                : PxObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;

         Else;
           Return  OBJD0100.ObjOwn;
         EndIf;

      /End-Free

     P GetObjOwn       E
     **-- Get object public authority:
     P GetPubAut       B
     D                 Pi            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const

      /Free

        RtvUsrAut( USRA0100
                 : %Size( USRA0100 )
                 : 'USRA0100'
                 : '*PUBLIC'
                 : PxObjNam_q
                 : PxObjTyp
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;
         Else;
           Return  USRA0100.ObjAut;
         EndIf;

      /End-Free

     P GetPubAut       E
     **-- Get object auhtorization list:
     P GetObjAutL      B
     D                 Pi            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const

      /Free

        RtvUsrAut( USRA0100
                 : %Size( USRA0100 )
                 : 'USRA0100'
                 : '*PUBLIC'
                 : PxObjNam_q
                 : PxObjTyp
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;
         Else;
           Return  USRA0100.AutLst;
         EndIf;

      /End-Free

     P GetObjAutL      E
     **-- Get user class:
     P GetUsrCls       B
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value


      /Free

        If  PxUsrPrf = USRI0200.UsrPrf;
          ERRC0100.BytAvl = *Zero;

        Else;
          RtvUsrInf( USRI0200
                   : %Size( USRI0200 )
                   : 'USRI0200'
                   : PxUsrPrf
                   : ERRC0100
                   );
        EndIf;

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  USRI0200.UsrCls;
        EndIf;

      /End-Free

     P GetUsrCls       E
     **-- Get group profile:
     P GetGrpPrf       B
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value


      /Free

        If  PxUsrPrf = USRI0200.UsrPrf;
          ERRC0100.BytAvl = *Zero;

        Else;
          RtvUsrInf( USRI0200
                   : %Size( USRI0200 )
                   : 'USRI0200'
                   : PxUsrPrf
                   : ERRC0100
                   );
        EndIf;

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  USRI0200.GrpPrf;
        EndIf;

      /End-Free

     P GetGrpPrf       E
     **-- Get number of supplemental group profiles:
     P GetNbrSupGrp    B
     D                 Pi             5i 0
     D  PxUsrPrf                     10a   Value


      /Free

        If  PxUsrPrf = USRI0200.UsrPrf;
          ERRC0100.BytAvl = *Zero;

        Else;
          RtvUsrInf( USRI0200
                   : %Size( USRI0200 )
                   : 'USRI0200'
                   : PxUsrPrf
                   : ERRC0100
                   );
        EndIf;

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  USRI0200.NbrSupGrp;
        EndIf;

      /End-Free

     P GetNbrSupGrp    E
     **-- Validate special authority:
     P ValSpcAut       B
     D                 Pi              n
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value


      /Free

        If  PxUsrPrf = USRI0200.UsrPrf;
          ERRC0100.BytAvl = *Zero;

        Else;
          RtvUsrInf( USRI0200
                   : %Size( USRI0200 )
                   : 'USRI0200'
                   : PxUsrPrf
                   : ERRC0100
                   );
        EndIf;

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return *Off;

        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
          Return  *On;

        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
          Return  *On;

        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
          Return  *On;

        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
          Return  *On;

        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
          Return  *On;

        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
          Return  *On;

        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
          Return  *On;

        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
          Return  *On;

        Other;
          Return *Off;
        EndSl;

      /End-Free

     P ValSpcAut       E
     **-- Send status message:
     P SndStsMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                   1024a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*STATUS'
                 : '*EXT'
                 : 0
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndStsMsg       E
     **-- Send completion message:
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

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
     **-- Send escape message:
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
