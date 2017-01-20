     **
     **  Program . . : CBX970
     **  Description : Work with Journal 2 - CCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( CBX970 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX970 )
     **                Module( CBX970 )
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
     D JRN_RCVDIR      c                   1
     **
     D BIN_SGN         c                   0
     D NUM_ZON         c                   2
     D CHAR_NLS        c                   4
     D SORT_ASC        c                   '1'
     **-- UIM constants:
     D PNLGRP_Q        c                   'CBX970P   *LIBL     '
     D PNLGRP          c                   'CBX970P   '
     D SCP_AUT_RCL     c                   -1
     D RDS_OPT_INZ     c                   'N'
     D PRM_IFC_0       c                   0
     D CLO_NORM        c                   'M'
     D FNC_EXIT        c                   -4
     D FNC_CNL         c                   -8
     D KEY_F05         c                   5
     D KEY_F17         c                   17
     D KEY_F18         c                   18
     D KEY_F24         c                   24
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
     D SPLF_NAM        c                   'PLSTJRNX'
     D SPLF_USRDTA     c                   'WRKJRN2'
     D EJECT_NO        c                   'N'

     **-- Global variables:
     D Idx             s             10i 0
     D SysDts          s               z
     D ApiRcvSiz       s             10u 0
     **
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a

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

     **-- UIM Panel exit program record:
     D ExpRcd          Ds                  Qualified
     D  ExitPg                       20a   Inz( 'CBX970E   *LIBL' )
     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  JrnNam                       10a
     D  JrnLib                       10a
     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  JrnPos                       20a
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  JrnTyp                        1a
     D  JrnStt                        1a
     D  NbrRcv                        7s 0
     D  CurSeqNbr                    20s 0
     D  RcvDirSiz                    20s 0
     D  AtcRcvNam                    10a
     D  AtcRcvLib                    10a
     D  OldRcvNam                    10a
     D  OldRcvLib                    10a
     D  JrnDscTxt                    50a
     D  AspDevNam                    10a
     **
     D LstEntPos       Ds                  LikeDs( LstEnt )

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0 Inz( 1 )
     D  NbrKeyRtn                    10i 0 Inz( *Zero )
     D  KeyFld                       10i 0 Dim( 1 )

     **-- Object information:
     D ObjInf          Ds          4096    Qualified
     D  ObjNam_q                     20a
     D   ObjNam                      10a   Overlay( ObjNam_q: 1 )
     D   ObjLib                      10a   Overlay( ObjNam_q: *Next )
     D  ObjTyp                       10a
     D  InfSts                        1a
     D                                1a
     D  FldNbrRtn                    10i 0
     D  Data                               Like( KeyInf )
     **-- Key information:
     D KeyInf          Ds                  Qualified  Based( pKeyInf )
     D  FldInfLen                    10i 0
     D  KeyFld                       10i 0
     D  DtaTyp                        1a
     D                                3a
     D  DtaLen                       10i 0
     D  Data                        256a
     **-- Authority control:
     D AutCtl          Ds                  Qualified
     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
     D  CalLvl                       10i 0 Inz( 0 )
     D  DplObjAut                    10i 0 Inz( 0 )
     D  NbrObjAut                    10i 0 Inz( 0 )
     D  DplLibAut                    10i 0 Inz( 0 )
     D  NbrLibAut                    10i 0 Inz( 0 )
     D                               10i 0 Inz( 0 )
     D  ObjAut                       10a   Dim( 10 )
     D  LibAut                       10a   Dim( 10 )
     **-- Selection control:
     D SltCtl          Ds
     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
     D  SltOmt                       10i 0 Inz( 0 )
     D  DplSts                       10i 0 Inz( 20 )
     D  NbrSts                       10i 0 Inz( 1 )
     D                               10i 0 Inz( 0 )
     D  Status                        1a   Inz( '*' )

     **-- Journal information:
     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OfsKeyInf                    10i 0
     D  JrnNam_q                     20a
     D   JrnNam                      10a   Overlay( JrnNam_q: 1 )
     D   JrnLib                      10a   Overlay( JrnNam_q: *Next )
     D  ASP                          10i 0
     D  MsgQueNam                    10a
     D  MsgQueLib                    10a
     D  MngRcvOpt                     1a
     D  DltRcvOpt                     1a
     D  RsoRit                        1a
     D  RsoMfl                        1a
     D  RsoMo1                        1a
     D  RsoMo2                        1a
     D  Rsv1                          3a
     D  JrnTyp                        1a
     D  RmtJrnTyp                     1a
     D  JrnStt                        1a
     D  JrnDlvMod                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  RdrRcvLib                    10a
     D  JrnTxt                       50a
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv2                          9a
     D  NbrAtcRcv                    10i 0
     D  AtcRcvNam_q                  20a
     D   AtcRcvNam                   10a   Overlay( AtcRcvNam_q: 1 )
     D   AtcRcvLib                   10a   Overlay( AtcRcvNam_q: *Next )
     D  AtcLocSys                     8a
     D  AtcSrcSys                     8a
     D  AtcRcvNamDu                  10a
     D  AtcRcvLibDu                  10a
     D  MngRcvDly                    10i 0
     D  DltRcvDly                    10i 0
     D  AspDevNam                    10a
     D  LclJrnAspGrp                 10a
     D  RmtJrnAspGrp                 10a
     D  FldJob                        1a
     D  FldUsr                        1a
     D  FldPgm                        1a
     D  FldPgmLib                     1a
     D  FldSysSeq                     1a
     D  FldRmtAdr                     1a
     D  FldThd                        1a
     D  FldLuw                        1a
     D  FldXid                        1a
     D                                4a
     D  JrnObjLmt                     1a
     D  TotJrnObj                    10u 0
     D  TotJrnFil                    10u 0
     D  TotJrnMbr                    10u 0
     D  TotJrnDtaAra                 10u 0
     D  TotJrnDtaQue                 10u 0
     D  TotJrnIfs                    10u 0
     D  TotJrnAccPth                 10u 0
     D  TotJrnCmtDfn                 10u 0
     D  JrnRcyCnt                    10u 0
     D                              104a
     D  NbrKey                       10i 0
     **
     D JrnKey          Ds                  Based( pJrnKey )  Qualified
     D  Key                          10i 0
     D  OfsKeyInf                    10i 0
     D  KeyHdrSecLn                  10i 0
     D  NbrEnt                       10i 0
     D  KeyInfEntLn                  10i 0
     **
     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
     D  RcvNbrTot                    10i 0
     D  RcvSizTot                    10i 0
     D  RcvSizMtp                    10i 0
     D  Rsv                           8a
     **
     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  RcvNbr                        5a
     D  RcvAtcDts                    13a
     D  RcvSts                        1a
     D  RcvSavDts                    13a
     D  LocJrnSys                     8a
     D  SrcJrnSys                     8a
     D  RcvSiz                       10i 0
     D  Rsv                          56a
     **-- Journal information specification:
     D JrnInfRtv       Ds                  Qualified
     D  NbrVarRcd                    10i 0 Inz( 1 )
     D  VarRcdLen                    10i 0 Inz( 12 )
     D  Key                          10i 0 Inz( JRN_RCVDIR )
     D  DtaLen                       10i 0 Inz( 0 )
     **-- Receiver information:
     D RRCV0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RcvNam_q                     20a
     D   RcvNam                      10a   Overlay( RcvNam_q: 1 )
     D   RcvLib                      10a   Overlay( RcvNam_q: *Next )
     D  JrnNam_q                     20a
     D   JrnNam                      10a   Overlay( JrnNam_q: 1 )
     D   JrnLib                      10a   Overlay( JrnNam_q: *Next )
     D  Thh                          10i 0
     D  Siz                          10i 0
     D  ASP                          10i 0
     D  NbrJrnEnt                    10i 0
     D  MaxEspDtaLn                  10i 0
     D  MaxNulInd                    10i 0
     D  FstSeqNbr                    10i 0
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv1                          2a
     D  LstSeqNbr                    10i 0
     D  Rsv2                         10i 0
     D  Status                        1a
     D  MinFxlVal                     1a
     D  RcvMaxOpt                     1a
     D  Rsv3                          4a
     D  AtcDts                       13a
     D  DtcDts                       13a
     D   DtcDat                       7a   Overlay( DtcDts: 1 )
     D   DtcTim                       6a   Overlay( DtcDts: *Next )
     D  SavDts                       13a
     D   SavDat                       7a   Overlay( SavDts: 1 )
     D   SavTim                       6a   Overlay( SavDts: *Next )
     D  Txt                          50a
     D  PndTrn                        1a
     D  RmtJrnTyp                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  LocRcvLib                    10a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  SrcRcvLib                    10a
     D  RdcRcvLib                    10a
     D  DuaRcvNam                    10a
     D  DuaRcvLib                    10a
     D  PrvRcvNam                    10a
     D  PrvRcvLib                    10a
     D  PrvRcvNamDu                  10a
     D  PrvRcvLibDu                  10a
     D  NxtRcvNam                    10a
     D  NxtRcvLib                    10a
     D  NxtRcvNamDu                  10a
     D  NxtRcvLibDu                  10a
     D  NbrJrnEntL                   20s 0
     D  MaxEspDtlL                   20s 0
     D  FstSeqNbrL                   20s 0
     D  LstSeqNbrL                   20s 0
     D  AspDevNam                    10a
     D  LocJrnAspGn                  10a
     D  SrcJrnAspGn                  10a
     D  FldJob                        1a
     D  FldUsr                        1a
     D  FldPgm                        1a
     D  FldPgmLib                     1a
     D  FldSysSeq                     1a
     D  FldRmtAdr                     1a
     D  FldThd                        1a
     D  FldLuw                        1a
     D  FldXid                        1a
     D  Rsv4                         21a

     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 4 )
     D  SrtStr                       12a   Dim( 4 )
     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
     D   Rsv                          1a   Overlay( SrtStr: 12 )
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

     **-- Open list of objects:
     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  ObjNam_q                     20a   Const
     D  ObjTyp                       10a   Const
     D  AutCtl                     1024a   Const  Options( *VarSize )
     D  SltCtl                     1024a   Const  Options( *VarSize )
     D  NbrKeyRtn                    10i 0 Const
     D  KeyFld                       10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  Error                      1024a          Options( *VarSize )
     **
     D  JobIdInf                    256a          Options( *NoPass: *VarSize )
     D  JobIdFmt                      8a   Const  Options( *NoPass )
     **
     D  AspCtl                      256a          Options( *NoPass: *VarSize )
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
     **-- Retrieve journal information:
     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
     D                                     Information' )
     D  RcvVar                    65535a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  JrnNam                       20a   Const
     D  FmtNam                        8a   Const
     D  InfRtv                    65535a   Const Options( *VarSize )
     D  Error                     32767a         Options( *VarSize: *Omit )
     **-- Retrieve journal receiver information:
     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
     D                                     Information' )
     D  RcvVar                    65535a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  RcvNam                       20a   Const
     D  FmtNam                        8a   Const
     D  Error                     32767a         Options( *VarSize: *Omit )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNamQ                      26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a         Options( *NoPass: *VarSize )
     **-- Convert case:
     D CvtCase         Pr                  ExtProc( 'QlgConvertCase' )
     D  RqsBlk                       22a   Const
     D  InpDta                    32767a   Const  Options( *VarSize )
     D  OutDta                    32767a          Options( *VarSize )
     D  DtaLen                       10i 0 Const
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
     D  Error                     32767a          Options( *VarSize )
     **-- Register termination exit:
     D CeeRtx          Pr                    ExtProc( 'CEERTX' )
     D  procedure                      *     ProcPtr  Const
     D  token                          *     Options( *Omit )
     D  fb                           12a     Options( *Omit )
     **-- Unregister termination exit:
     D CeeUtx          Pr                    ExtProc( 'CEEUTX' )
     D  procedure                      *     ProcPtr  Const
     D  fb                           12a     Options( *Omit )

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
     **-- To upper case:
     D ToUpper         Pr          4096a   Varying
     D  InpStr                     4096a   Const  Varying
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
     **-- Terminate program:
     D TrmPgm          Pr
     D  pPtr                           *

     D CBX970          Pr
     D  PxJrnNam_q                         LikeDs( ObjNam_q )
     D  PxLstOrd                     10a
     D  PxOutOpt                      3a
     **
     D CBX970          Pi
     D  PxJrnNam_q                         LikeDs( ObjNam_q )
     D  PxLstOrd                     10a
     D  PxOutOpt                      3a

      /Free

        CeeRtx( %Paddr( TrmPgm ): pJrnInf: *Omit );

        SndStsMsg( 'Retrieving journal information, please wait...' );

        ApiRcvSiz = 65535;
        pJrnInf   = %Alloc( ApiRcvSiz );

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';

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

        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );

        ExSr  BldHdrRcd;
        ExSr  BldJrnLst;

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
          ExSr  DspLst;
        Else;
          ExSr  WrtLst;
        EndIf;

        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );

        CeeUtx( %Paddr( TrmPgm ): *Omit );

        TrmPgm( pJrnInf );

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

            Select;
            When  ERRC0100.BytAvl > *Zero;
              ExSr  EscApiErr;

            When  UIM.FncRqs = RTN_ENTER;
              Leave;

            When  UIM.FncRqs = KEY_F17;
              ExSr  PosLstTop;

            When  UIM.FncRqs = KEY_F18;
              ExSr  PosLstBot;
            EndSl;

          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
            ExSr  GetLstPos;
            ExSr  DltJrnLst;
          EndIf;

          If  UIM.FncRqs = KEY_F05;
            ExSr  BldJrnLst;
            ExSr  SetLstPos;
          EndIf;

            ExSr  BldHdrRcd;
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

        BegSr  BldJrnLst;

          ExSr  InzApiPrm;

          UIM.EntLocOpt = 'FRST';
          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : -1
                 : SrtInf
                 : PxJrnNam_q
                 : '*JRN'
                 : AutCtl
                 : SltCtl
                 : LstApi.NbrKeyRtn
                 : LstApi.KeyFld
                 : ERRC0100
                 );

          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrTot > *Zero;

            ExSr  PrcLstEnt;

            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
              LstApi.RtnRcdNbr += 1;

              GetOplEnt( ObjInf
                       : %Size( ObjInf )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;

              ExSr  PrcLstEnt;
            EndDo;
          EndIf;

          CloseLst( LstInf.Handle: ERRC0100 );

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

          RJRN0100.BytAvl = *Zero;

          DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
               ERRC0100.BytAvl  > *Zero;

            If  RJRN0100.BytAvl > ApiRcvSiz;
              ApiRcvSiz  = RJRN0100.BytAvl;
              pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
            EndIf;

            RtvJrnInf( RJRN0100
                     : ApiRcvSiz
                     : ObjInf.ObjNam_q
                     : 'RJRN0100'
                     : JrnInfRtv
                     : ERRC0100
                     );
          EndDo;

          If  ERRC0100.BytAvl = *Zero;
            ExSr  PrcKeyEnt;
          EndIf;

        EndSr;

        BegSr PrcKeyEnt;

          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );

          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );

          For  Idx = 1  to JrnKey.NbrEnt;

            RtvRcvInf( RRCV0100
                     : %Size( RRCV0100 )
                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
                     : 'RRCV0100'
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;

              If  Idx = 1;
                ExSr  RtvOldRcv;
              EndIf;

              If  RJRN0100.AtcRcvNam_q = RRCV0100.RcvNam_q;
                ExSr  RtvAtcRcv;
              EndIf;
            EndIf;

            If  Idx < JrnKey.NbrEnt;
              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
            EndIf;
          EndFor;

          ExSr  PutLstEnt;

        EndSr;

        BegSr  RtvOldRcv;

          LstEnt.OldRcvNam = RRCV0100.RcvNam;
          LstEnt.OldRcvLib = RRCV0100.RcvLib;

        EndSr;

        BegSr  RtvAtcRcv;

          LstEnt.AtcRcvNam = RRCV0100.RcvNam;
          LstEnt.AtcRcvLib = RRCV0100.RcvLib;
          LstEnt.CurSeqNbr = RRCV0100.LstSeqNbrL;

        EndSr;

        BegSr  PutLstEnt;

          LstEnt.Option = *Zero;

          LstEnt.JrnPos = RJRN0100.JrnNam_q;
          LstEnt.JrnNam = RJRN0100.JrnNam;
          LstEnt.JrnLib = RJRN0100.JrnLib;
          LstEnt.JrnTyp = RJRN0100.JrnTyp;
          LstEnt.JrnStt = RJRN0100.JrnStt;
          LstEnt.AspDevNam = RJRN0100.AspDevNam;

          LstEnt.NbrRcv = JrnKeyHdr1.RcvNbrTot;
          LstEnt.RcvDirSiz = JrnKeyHdr1.RcvSizTot * JrnKeyHdr1.RcvSizMtp;
          LstEnt.JrnDscTxt = RJRN0100.JrnTxt;

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
                     : 'EQ        JRNPOS'
                     : LstAtr.DspPos
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

          SysDts = %Timestamp();

          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
          HdrRcd.TimZon = '*SYS';

          HdrRcd.JrnNam = PxJrnNam_q.ObjNam;
          HdrRcd.JrnLib = PxJrnNam_q.ObjLib;

          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

        EndSr;

        BegSr  DltJrnLst;

          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );

        EndSr;

        BegSr  InzApiPrm;

          SrtInf.NbrKeys   = 2;

          If  PxLstOrd = '*JRN';
            SrtInf.KeyFldOfs(1) = 1;
            SrtInf.KeyFldLen(1) = %Size( LstEnt.JrnNam );
            SrtInf.KeyFldOfs(2) = 11;
            SrtInf.KeyFldLen(2) = %Size( LstEnt.JrnLib );
          Else;
            SrtInf.KeyFldOfs(1) = 11;
            SrtInf.KeyFldLen(1) = %Size( LstEnt.JrnLib );
            SrtInf.KeyFldOfs(2) = 1;
            SrtInf.KeyFldLen(2) = %Size( LstEnt.JrnNam );
          EndIf;

          SrtInf.KeyFldTyp(1) = CHAR_NLS;
          SrtInf.SrtOrd(1)    = SORT_ASC;
          SrtInf.Rsv(1)       = x'00';

          SrtInf.KeyFldTyp(2) = CHAR_NLS;
          SrtInf.SrtOrd(2)    = SORT_ASC;
          SrtInf.Rsv(2)       = x'00';

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
     **-- To upper case:  ----------------------------------------------------**
     P ToUpper         B
     D                 Pi          4096a   Varying
     D  PxInpStr                   4096a   Const  Varying

     **-- Convert case parameters & constants:
     D RqsCtlBlk       Ds                  Qualified
     D  RqsType                      10i 0 Inz( CVT_BY_CCSID )
     D  CCSID                        10i 0 Inz( JOB_CCSID )
     D  CaseRqs                      10i 0 Inz
     D                               10a   Inz( *Allx'00')
     **
     D CVT_BY_CCSID    c                   1
     D JOB_CCSID       c                   0
     D TO_LOWER        c                   1
     D TO_UPPER        c                   0
     **-- Local variable:
     D OutStr          s           4096a

      /Free

        If  %Len( PxInpStr ) > *Zero;

         RqsCtlBlk.CaseRqs = TO_UPPER;

         CvtCase( RqsCtlBlk: PxInpStr: OutStr: %Len( PxInpStr ): ERRC0100 );

         If  ERRC0100.BytAvl = *Zero;
           Return  %TrimR( OutStr );
         EndIf;
       EndIf;

       Return  PxInpStr;

      /End-Free

     P ToUpper         E
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
     **-- Terminate program:
     P TrmPgm          B
     D                 Pi
     D  pPtr                           *

      /Free

        If  pPtr <> *Null;
          DeAlloc  pPtr;
        EndIf;

        *InLr = *On;

        Return;

      /End-Free

     P TrmPgm          E
