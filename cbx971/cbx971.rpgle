000100060505     **
000200070518     **  Program . . : CBX971
000300070518     **  Description : Work with Output Queue Authorities - CPP
000400060505     **  Author  . . : Carsten Flensburg
000500070518     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000070518     **    CrtRpgMod   Module( CBX971 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300070518     **    CrtPgm      Pgm( CBX971 )
001400070518     **                Module( CBX971 )
001500060505     **                ActGrp( *NEW )
001600050310     **
001700050310     **-- Header specifications:  --------------------------------------------**
001800060411     H Option( *SrcStmt )
001900060411
002000050227     **-- API error data structure:
002100050226     D ERRC0100        Ds                  Qualified
002200050226     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002300050226     D  BytAvl                       10i 0
002400050226     D  MsgId                         7a
002500990921     D                                1a
002600050226     D  MsgDta                      128a
002700060424
002800060424     **-- Global constants:
002900060424     D OFS_MSGDTA      c                   16
003000061203     D TYP_INTER       c                   'I'
003100060504     **-- UIM constants:
003200070519     D PNLGRP_Q        c                   'CBX971P   *LIBL     '
003300070519     D PNLGRP          c                   'CBX971P   '
003400060504     D SCP_AUT_RCL     c                   -1
003500060504     D RDS_OPT_INZ     c                   'N'
003600060504     D PRM_IFC_0       c                   0
003700060504     D CLO_NORM        c                   'M'
003800060504     D FNC_EXIT        c                   -4
003900060504     D FNC_CNL         c                   -8
004000060504     D KEY_F05         c                   5
004100061109     D KEY_F17         c                   17
004200061109     D KEY_F18         c                   18
004300060506     D RTN_ENTER       c                   500
004400060504     D HLP_WDW         c                   'N'
004500060504     D POS_TOP         c                   'TOP'
004600060504     D POS_BOT         c                   'BOT'
004700060504     D LIST_COMP       c                   'ALL'
004800060504     D LIST_SAME       c                   'SAME'
004900060504     D EXIT_SAME       c                   '*SAME'
005000060504     D TRIM_SAME       c                   'S'
005100060729     **
005200060729     D APP_PRTF        c                   'QPRINT    *LIBL'
005300060729     D ODP_SHR         c                   'N'
005400070427     D SPLF_NAM        c                   'PSVRAUTE'
005500070427     D SPLF_USRDTA     c                   'WRKSVRAUTE'
005600060729     D EJECT_NO        c                   'N'
005700060504
005800060424     **-- Global variables:
005900060506     D Idx             s             10i 0
006000060506     D SysDts          s               z
006100070427     D WrkUsr          s             10a
006200061109
006300060504     **-- UIM variables:
006400060504     D UIM             Ds                  Qualified
006500060504     D  AppHdl                        8a
006600060504     D  LstHdl                        4a
006700060504     D  EntHdl                        4a
006800060504     D  FncRqs                       10i 0
006900060504     D  EntLocOpt                     4a
007000060504     D  LstPos                        4a
007100060504     **-- List attributes structure:
007200060504     D LstAtr          Ds                  Qualified
007300060504     D  LstCon                        4a
007400060504     D  ExtPgmVar                    10a
007500060504     D  DspPos                        4a
007600060504     D  AlwTrim                       1a
007700060505
007800140101     **-- UIM Panel exit prgram record:
007900140101     D ExpRcd          Ds                  Qualified
008000140101     D  ExitPg                       20a   Inz( 'CBX971E   *LIBL' )
008100060511     **-- UIM Panel header record:
008200060511     D HdrRcd          Ds                  Qualified
008300060504     D  SysDat                        7a
008400060504     D  SysTim                        6a
008500060504     D  TimZon                       10a
008600070519     D  OutQue                       20a
008700070427     D  WrkUsr                       10a
008800070427     D  PosUsr                       10a
008900070519     D  DspDta                       10a
009000070519     D  OprCtl                       10a
009100070519     D  AutChk                       10a
009200070519     D  QueOwn                       10a
009300070519     D  PubAut                       10a
009400070522     D  QueAutL                      10a
009500060504     **-- UIM List entry:
009600060504     D LstEnt          Ds                  Qualified
009700060504     D  Option                        5i 0
009800070427     D  UsrPrf                       10a
009900070521     D  UsrCls                       10a
010000070522     D  GrpPrf                       10a
010100070526     D  NbrSupGrp                     5i 0
010200070519     D  SplCtl                        1a
010300070519     D  JobCtl                        1a
010400070519     D  AutSrc                        2a
010500070519     D  QueAut                       10a
010600070519     D  QueRead                       1a
010700070519     D  QueRAD                        1a
010800070519     D  QueMgt                        1a
010900070519     D  StrWtr                        1a
011000070519     D  AddSpl                        1a
011100070519     D  WrkWth                        1a
011200070519     D  QueOpr                        1a
011300070519     D  QueOpm                        1a
011400070519     D  SplCon                        1a
011500070519     D  SplOpr                        1a
011600060504     **
011700060504     D LstEntPos       Ds                  LikeDs( LstEnt )
011800060504
011900070427     **-- List API parameters:
012000070427     D LstApi          Ds                  Qualified  Inz
012100070427     D  RtnRcdNbr                    10i 0
012200070427     D  GrpNam                       10a
012300070427     D  SltCri                       10a
012400070427     **-- Return records feedback information:
012500070427     D RtnRcdFbi       Ds                  Qualified
012600070427     D  BytRtn                       10i 0
012700070427     D  BytAvl                       10i 0
012800070427     D  NbrSvrAutE                   10i 0
012900070427     **-- List information:
013000070427     D LstInf          Ds                  Qualified
013100070427     D  RcdNbrTot                    10i 0
013200070427     D  RcdNbrRtn                    10i 0
013300070427     D  Handle                        4a
013400070427     D  RcdLen                       10i 0
013500070427     D  InfSts                        1a
013600070427     D  Dts                          13a
013700070427     D  LstSts                        1a
013800070427     D                                1a
013900070427     D  InfLen                       10i 0
014000070427     D  Rcd1                         10i 0
014100070427     D                               40a
014200060503
014300070427     **-- User information:
014400070427     D AUTU0150        Ds                  Qualified
014500070427     D  UsrPrf                       10a
014600070427     D  UsrGrpI                       1a
014700070427     D  GrpMbrI                       1a
014800070427     D  TxtDsc                       50a
014900070518     **-- Output queue information:
015000070518     D OUTQ0100        Ds                  Qualified
015100070518     D  BytRtn                       10i 0
015200070518     D  BytAvl                       10i 0
015300070519     D  OutQue_q                     20a
015400070518     D   OutQueNam                   10a   Overlay( OutQue_q: 1 )
015500070518     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
015600070518     D  FilOrd                       10a
015700070518     D  DspAnyF                      10a
015800070518     D  JobSep                       10i 0
015900070518     D  OprCtl                       10a
016000070518     D  DtaQueNam                    10a
016100070518     D  DtaQueLib                    10a
016200070518     D  AutChk                       10a
016300070518     D  NbrFil                       10i 0
016400070518     D  OutQueSts                    10a
016500070518     D  WtrJobNam                    10a
016600070518     D  WtrJobUsr                    10a
016700070518     D  WtrJobNbr                     6a
016800070518     D  WtrJobSts                    10a
016900070518     D  PrtDevNam                    10a
017000070518     D  OutQueTxt                    50a
017100070518     D                                2a
017200070518     D  NbrSpfPag                    10i 0
017300070518     D  NbrWtrStr                    10i 0
017400070518     D  WtrAutStr                    10i 0
017500070521     **-- User profile information:
017600070521     D USRI0200        Ds                  Qualified
017700070521     D  BytRtn                       10i 0
017800070521     D  BytAvl                       10i 0
017900070521     D  UsrPrf                       10a
018000070521     D  UsrCls                       10a
018100070521     D  SpcAut                       15a   Overlay( USRI0200: 29 )
018200070521     D   AllObj                       1a   Overlay( SpcAut: 1 )
018300070521     D   SecAdm                       1a   Overlay( SpcAut: *Next )
018400070521     D   JobCtl                       1a   Overlay( SpcAut: *Next )
018500070521     D   SplCtl                       1a   Overlay( SpcAut: *Next )
018600070521     D   SavSys                       1a   Overlay( SpcAut: *Next )
018700070521     D   Service                      1a   Overlay( SpcAut: *Next )
018800070521     D   Audit                        1a   Overlay( SpcAut: *Next )
018900070521     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )
019000070522     D  GrpPrf                       10a
019100070526     D  PrfOwn                       10a
019200070526     D  GrpAut                       10a
019300070526     D  LmtCap                       10a
019400070526     D  GrpAutTyp                    10a
019500070526     D                                3a
019600070526     D  OfsSupGrp                    10i 0
019700070526     D  NbrSupGrp                    10i 0
019800070518     **-- Object authority information:
019900070518     D USRA0100        Ds                  Qualified
020000070518     D  BytRtn                       10i 0
020100070518     D  BytAvl                       10i 0
020200070518     D  ObjAut                       10a
020300070518     D  AutLstMgt                     1a
020400070518     D  ObjOpr                        1a
020500070519     D  ObjMgt                        1a
020600070518     D  ObjExs                        1a
020700070518     D  DtaRead                       1a
020800070518     D  DtaAdd                        1a
020900070518     D  DtaUpd                        1a
021000070518     D  DtaDlt                        1a
021100070518     D  AutLst                       10a
021200070518     D  AutSrc                        2a
021300070518     D  AdpAut                        1a
021400070518     D  AdpObjAut                    10a
021500070518     D  AdpAutLstMgt                  1a
021600070518     D  AdpObjOpr                     1a
021700070519     D  AdpObjMgt                     1a
021800070518     D  AdpObjExs                     1a
021900070518     D  AdpDtaRead                    1a
022000070518     D  AdpDtaAdd                     1a
022100070518     D  AdpDtaUpd                     1a
022200070518     D  AdpDtaDlt                     1a
022300070518     D  AdpDtaExe                     1a
022400070518     D                               10a
022500070518     D  AdpObjAlt                     1a
022600070518     D  AdpObjRef                     1a
022700070518     D                               10a
022800070518     D  DtaExe                        1a
022900070518     D                               10a
023000070518     D  ObjAlt                        1a
023100070518     D  ObjRef                        1a
023200070518     D  AspDevLib                    10a
023300070518     D  AspDevObj                    10a
023400070427
023500070427     **-- Open list of authorized users:
023600070427     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
023700070427     D  RcvVar                    65535a          Options( *VarSize )
023800070427     D  RcvVarLen                    10i 0 Const
023900070427     D  LstInf                       80a
024000070427     D  NbrRcdRtn                    10i 0 Const
024100070427     D  FmtNam                        8a   Const
024200070427     D  SltCri                       10a   Const
024300070427     D  GrpNam                       10a   Const
024400070427     D  Error                      1024a          Options( *VarSize )
024500070427     D  UsrPrf                       10a   Const  Options( *NoPass )
024600070518     **-- Retrieve output queue information:
024700070518     D RtvOutQueInf    Pr                  ExtPgm( 'QSPROUTQ' )
024800070518     D  RcvVar                    32767a          Options( *VarSize )
024900070518     D  RcvVarLen                    10i 0 Const
025000070518     D  FmtNam                        8a   Const
025100070518     D  OutQue_q                     20a   Const
025200070518     D  Error                     32767a          Options( *VarSize )
025300070518     **-- Retrieve object description:
025400070518     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
025500070518     D  RcvVar                    32767a          Options( *VarSize )
025600070518     D  RcvVarLen                    10i 0 Const
025700070518     D  FmtNam                        8a   Const
025800070518     D  ObjNamQ                      20a   Const
025900070518     D  ObjTyp                       10a   Const
026000070518     D  Error                     32767a          Options( *VarSize )
026100070518     **-- Retrieve user information:
026200070518     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
026300070518     D  RcvVar                    32767a          Options( *VarSize )
026400070518     D  RcvVarLen                    10i 0 Const
026500070518     D  FmtNam                       10a   Const
026600070518     D  UsrPrf                       10a   Const
026700070518     D  Error                     32767a          Options( *VarSize )
026800070518     **-- Retrieve user authority to object:
026900070518     D RtvUsrAut       Pr                  ExtPgm( 'QSYRUSRA' )
027000070518     D  RcvVar                    32767a          Options( *VarSize )
027100070518     D  RcvVarLen                    10i 0 Const
027200070518     D  FmtNam                        8a   Const
027300070518     D  UsrPrf                       10a   Const
027400070518     D  ObjNamQ                      20a   Const
027500070518     D  ObjTyp                       10a   Const
027600070518     D  Error                     32767a          Options( *VarSize )
027700070518     D  AspDev                       10a          Options( *NoPass )
027800070518
027900070427     **-- Get open list entry:
028000070427     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
028100070427     D  RcvVar                    65535a          Options( *VarSize )
028200070427     D  RcvVarLen                    10i 0 Const
028300070427     D  Handle                        4a   Const
028400070427     D  LstInf                       80a
028500070427     D  NbrRcdRtn                    10i 0 Const
028600070427     D  RtnRcdNbr                    10i 0 Const
028700070427     D  Error                      1024a          Options( *VarSize )
028800070427     **-- Close list:
028900070427     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
029000070427     D  Handle                        4a   Const
029100070427     D  Error                      1024a          Options( *VarSize )
029200060504     **-- Send program message:
029300060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
029400060504     D  MsgId                         7a   Const
029500060504     D  MsgFq                        20a   Const
029600060504     D  MsgDta                      128a   Const
029700060504     D  MsgDtaLen                    10i 0 Const
029800060504     D  MsgTyp                       10a   Const
029900060504     D  CalStkE                      10a   Const  Options( *VarSize )
030000060504     D  CalStkCtr                    10i 0 Const
030100060504     D  MsgKey                        4a
030200060504     D  Error                     32767a          Options( *VarSize )
030300060729     **-- Retrieve job information:
030400060729     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
030500060729     D  RcvVar                    32767a         Options( *VarSize )
030600060729     D  RcvVarLen                    10i 0 Const
030700060729     D  FmtNam                        8a   Const
030800060729     D  JobNamQ                      26a   Const
030900060729     D  JobIntId                     16a   Const
031000060729     D  Error                     32767a         Options( *NoPass: *VarSize )
031100061106
031200060504     **-- Open display application:
031300060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
031400060504     D  AppHdl                        8a
031500060504     D  PnlGrp_q                     20a   Const
031600060504     D  AppScp                       10i 0 Const
031700060504     D  ExtPrmIfc                    10i 0 Const
031800060504     D  FulScrHlp                     1a   Const
031900060504     D  Error                     32767a          Options( *VarSize )
032000060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
032100060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
032200060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
032300060729     **-- Add print application:
032400060729     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
032500060729     D  AppHdl                        8a   Const
032600060729     D  PrtDevF_q                    20a   Const
032700060729     D  AltFilNam                    10a   Const
032800060729     D  ShrOpnDtaPth                  1a   Const
032900060729     D  UsrDta                       10a   Const
033000060729     D  Error                     32767a          Options( *VarSize )
033100060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
033200060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
033300060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
033400060729     **-- Open print application:
033500060729     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
033600060729     D  AppHdl                        8a
033700060729     D  PnlGrp_q                     20a   Const
033800060729     D  AppScp                       10i 0 Const
033900060729     D  ExtPrmIfc                    10i 0 Const
034000060729     D  PrtDevF_q                    20a   Const
034100060729     D  AltFilNam                    10a   Const
034200060729     D  ShrOpnDtaPth                  1a   Const
034300060729     D  UsrDta                       10a   Const
034400060729     D  Error                     32767a          Options( *VarSize )
034500060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
034600060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
034700060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
034800060504     **-- Display panel:
034900060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
035000060504     D  AppHdl                        8a   Const
035100060504     D  FncRqs                       10i 0
035200060504     D  PnlNam                       10a   Const
035300060504     D  ReDspOpt                      1a   Const
035400060504     D  Error                     32767a          Options( *VarSize )
035500060504     D  UsrTsk                        1a   Const  Options( *NoPass )
035600060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
035700060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
035800060504     D  MsgKey                        4a   Const  Options( *NoPass )
035900060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
036000060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
036100060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
036200060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
036300060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
036400060504     D  CalQlf                       20a   Const  Options( *NoPass )
036500060729     **-- Print panel:
036600060729     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
036700060729     D  AppHdl                        8a   Const
036800060729     D  PrtPnlNam                    10a   Const
036900060729     D  EjtOpt                        1a   Const
037000060729     D  Error                     32767a          Options( *VarSize )
037100060504     **-- Put dialog variable:
037200060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
037300060504     D  AppHdl                        8a   Const
037400060504     D  VarBuf                    32767a   Const  Options( *VarSize )
037500060504     D  VarBufLen                    10i 0 Const
037600060504     D  VarRcdNam                    10a   Const
037700060504     D  Error                     32767a          Options( *VarSize )
037800060504     **-- Get dialog variable:
037900060504     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
038000060504     D  AppHdl                        8a   Const
038100060504     D  VarBuf                    32767a          Options( *VarSize )
038200060504     D  VarBufLen                    10i 0 Const
038300060504     D  VarRcdNam                    10a   Const
038400060504     D  Error                     32767a          Options( *VarSize )
038500060504     **-- Add list entry:
038600060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
038700060504     D  AppHdl                        8a   Const
038800060504     D  VarBuf                    32767a   Const  Options( *VarSize )
038900060504     D  VarBufLen                    10i 0 Const
039000060504     D  VarRcdNam                    10a   Const
039100060504     D  LstNam                       10a   Const
039200060504     D  EntLocOpt                     4a   Const
039300060504     D  LstEntHdl                     4a
039400060504     D  Error                     32767a          Options( *VarSize )
039500060504     **-- Get list entry:
039600060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
039700060504     D  AppHdl                        8a   Const
039800060504     D  VarBuf                    32767a   Const  Options( *VarSize )
039900060504     D  VarBufLen                    10i 0 Const
040000060504     D  VarRcdNam                    10a   Const
040100060504     D  LstNam                       10a   Const
040200060504     D  PosOpt                        4a   Const
040300060504     D  CpyOpt                        1a   Const
040400060504     D  SltCri                       20a   Const
040500060504     D  SltHdl                        4a   Const
040600060504     D  ExtOpt                        1a   Const
040700060504     D  LstEntHdl                     4a
040800060504     D  Error                     32767a          Options( *VarSize )
040900060504     **-- Retrieve list attributes:
041000060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
041100060504     D  AppHdl                        8a   Const
041200060504     D  LstNam                       10a   Const
041300060504     D  AtrRcv                    32767a          Options( *VarSize )
041400060504     D  AtrRcvLen                    10i 0 Const
041500060504     D  Error                     32767a          Options( *VarSize )
041600060504     **-- Set list attributes:
041700060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
041800060504     D  AppHdl                        8a   Const
041900060504     D  LstNam                       10a   Const
042000060504     D  LstCon                        4a   Const
042100060504     D  ExtPgmVar                    10a   Const
042200060504     D  DspPos                        4a   Const
042300060504     D  AlwTrim                       1a   Const
042400060504     D  Error                     32767a          Options( *VarSize )
042500060504     **-- Delete list:
042600060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
042700060504     D  AppHdl                        8a   Const
042800060504     D  LstNam                       10a   Const
042900060504     D  Error                     32767a          Options( *VarSize )
043000060504     **-- Close application:
043100060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
043200060504     D  AppHdl                        8a   Const
043300060504     D  CloOpt                        1a   Const
043400060504     D  Error                     32767a          Options( *VarSize )
043500060504
043600060729     **-- Get job type:
043700060729     D GetJobTyp       Pr             1a
043800070518     **-- Get object owner:
043900070518     D GetObjOwn       Pr            10a
044000070518     D  PxObjNam_q                   20a   Const
044100070518     D  PxObjTyp                     10a   Const
044200070519     **-- Get object public authority:
044300070519     D GetPubAut       Pr            10a
044400070519     D  PxObjNam_q                   20a   Const
044500070519     D  PxObjTyp                     10a   Const
044600070522     **-- Get object authorization list:
044700070522     D GetObjAutL      Pr            10a
044800070522     D  PxObjNam_q                   20a   Const
044900070522     D  PxObjTyp                     10a   Const
045000070521     **-- Get user class:
045100070521     D GetUsrCls       Pr            10a
045200070521     D  PxUsrPrf                     10a   Value
045300070522     **-- Get group profile:
045400070522     D GetGrpPrf       Pr            10a
045500070522     D  PxUsrPrf                     10a   Value
045600070526     **-- Get number of supplemental group profiles:
045700070526     D GetNbrSupGrp    Pr             5i 0
045800070526     D  PxUsrPrf                     10a   Value
045900070518     **-- Validate special authority:
046000070519     D ValSpcAut       Pr              n
046100070518     D  PxUsrPrf                     10a   Value
046200070518     D  PxSpcAut                     10a   Value
046300070428     **-- Send status message:
046400070428     D SndStsMsg       Pr            10i 0
046500070428     D  PxMsgDta                   1024a   Const  Varying
046600060729     **-- Send completion message:
046700060729     D SndCmpMsg       Pr            10i 0
046800060729     D  PxMsgDta                    512a   Const  Varying
046900060504     **-- Send escape message:
047000060504     D SndEscMsg       Pr            10i 0
047100060504     D  PxMsgId                       7a   Const
047200060504     D  PxMsgF                       10a   Const
047300060504     D  PxMsgDta                    512a   Const  Varying
047400050226
047500070518     **-- Entry parameters:
047600070518     D ObjNam_q        Ds
047700070518     D  ObjNam                       10a
047800070518     D  ObjLib                       10a
047900070518     **
048000070519     D CBX971          Pr
048100070518     D  PxOutQue_q                         LikeDs( ObjNam_q )
048200070427     D  PxUsrPrf                     10a
048300060729     D  PxOutOpt                      3a
048400050226     **
048500070519     D CBX971          Pi
048600070518     D  PxOutQue_q                         LikeDs( ObjNam_q )
048700070427     D  PxUsrPrf                     10a
048800060729     D  PxOutOpt                      3a
048900050226
049000050226      /Free
049100060729
049200061203        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;
049300060729
049400060729          OpnDspApp( UIM.AppHdl
049500060729                   : PNLGRP_Q
049600060729                   : SCP_AUT_RCL
049700060729                   : PRM_IFC_0
049800060729                   : HLP_WDW
049900060729                   : ERRC0100
050000060729                   );
050100060729        Else;
050200060729          OpnPrtApp( UIM.AppHdl
050300060729                   : PNLGRP_Q
050400060729                   : SCP_AUT_RCL
050500060729                   : PRM_IFC_0
050600060729                   : APP_PRTF
050700060729                   : SPLF_NAM
050800060729                   : ODP_SHR
050900060729                   : SPLF_USRDTA
051000060729                   : ERRC0100
051100060729                   );
051200060729        EndIf;
051300060729
051400061108        If  ERRC0100.BytAvl > *Zero;
051500070427          ExSr  EscApiErr;
051600060729        EndIf;
051700060729
051800070521        SndStsMsg( 'Retrieving output queue information, please wait...' );
051900070502
052000140101        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
052100140101
052200060729        ExSr  BldHdrRcd;
052300070821        ExSr  BldAutUsrLst;
052400060729
052500061203        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;
052600060729          ExSr  DspLst;
052700060729        Else;
052800060729          ExSr  WrtLst;
052900060729        EndIf;
053000060424
053100060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
053200050226
053300050226        *InLr = *On;
053400050226        Return;
053500060412
053600060505
053700070427        BegSr  EscApiErr;
053800070427
053900070427          If  ERRC0100.BytAvl < OFS_MSGDTA;
054000070427            ERRC0100.BytAvl = OFS_MSGDTA;
054100070427          EndIf;
054200070427
054300070427          SndEscMsg( ERRC0100.MsgId
054400070427                   : 'QCPFMSG'
054500070427                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
054600070427                   );
054700070427
054800070427        EndSr;
054900070427
055000060729        BegSr  DspLst;
055100060729
055200060729          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
055300060729
055400060729            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
055500060729
055600100319            If  ERRC0100.BytAvl > *Zero;
055700100319              ExSr  EscApiErr;
055800100319            EndIf;
055900100319
056000060729            GetDlgVar( UIM.AppHdl
056100060729                     : HdrRcd
056200060729                     : %Size( HdrRcd )
056300060729                     : 'HDRRCD'
056400060729                     : ERRC0100
056500060729                     );
056600060729
056700060729            Select;
056800060729            When  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
056900060729              ExSr  GetLstPos;
057000060729              ExSr  DltUsrLst;
057100060729
057200070427            When  WrkUsr <> HdrRcd.WrkUsr;
057300060729              ExSr  DltUsrLst;
057400060729            EndSl;
057500060729
057600060729            Select;
057700060729            When  UIM.FncRqs = KEY_F05;
057800060730              ExSr  RstHdrRcd;
057900070522              ExSr  BldHdrRcd;
058000070821              ExSr  BldAutUsrLst;
058100060729              ExSr  SetLstPos;
058200060729
058300070427            When  WrkUsr <> HdrRcd.WrkUsr;
058400070427              WrkUsr = HdrRcd.WrkUsr;
058500061106
058600070522              ExSr  BldHdrRcd;
058700070821              ExSr  BldAutUsrLst;
058800060729            EndSl;
058900060729
059000061109            Select;
059100061109            When  UIM.FncRqs = RTN_ENTER  And
059200061109                  UIM.EntLocOpt = 'NEXT'  And
059300070427                  HdrRcd.PosUsr > *Blanks;
059400061109
059500061109              ExSr  FndLstPos;
059600061109
059700061109            When  UIM.FncRqs = KEY_F17;
059800061109              ExSr  PosLstTop;
059900061109
060000061109            When  UIM.FncRqs = KEY_F18;
060100061109              ExSr  PosLstBot;
060200061109            EndSl;
060300070522
060400060729          EndDo;
060500060729
060600060729        EndSr;
060700060729
060800060729        BegSr  WrtLst;
060900060729
061000060729          PrtPnl( UIM.AppHdl
061100060729                : 'PRTHDR'
061200060729                : EJECT_NO
061300060729                : ERRC0100
061400060729                );
061500060729
061600060729          PrtPnl( UIM.AppHdl
061700060729                : 'PRTLST'
061800060729                : EJECT_NO
061900060729                : ERRC0100
062000060729                );
062100060729
062200060729          SndCmpMsg( 'List has been printed.' );
062300060729
062400060729        EndSr;
062500060729
062600070821        BegSr  BldAutUsrLst;
062700060504
062800060504          UIM.EntLocOpt = 'FRST';
062900070522          USRI0200.UsrPrf = *Blanks;
063000060505
063100070427          LstApi.RtnRcdNbr = 1;
063200070427          LstApi.SltCri = '*ALL';
063300070427          LstApi.GrpNam = '*NONE';
063400070427
063500070427          LstAutUsr( AUTU0150
063600070427                   : %Size( AUTU0150 )
063700070427                   : LstInf
063800070427                   : 1
063900070427                   : 'AUTU0150'
064000070427                   : LstApi.SltCri
064100070427                   : LstApi.GrpNam
064200070427                   : ERRC0100
064300070427                   : WrkUsr
064400070427                   );
064500070427
064600070427          If  ERRC0100.BytAvl = *Zero;
064700070427
064800070427            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
064900070427
065000070427              ExSr  PrcLstEnt;
065100070427
065200070427              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
065300070427
065400070427              GetOplEnt( AUTU0150
065500070427                       : %Size( AUTU0150 )
065600070427                       : LstInf.Handle
065700070427                       : LstInf
065800070427                       : 1
065900070427                       : LstApi.RtnRcdNbr
066000070427                       : ERRC0100
066100070427                       );
066200070427
066300070427              If  ERRC0100.BytAvl > *Zero;
066400070427                Leave;
066500070427              EndIf;
066600070427
066700070427            EndDo;
066800070427
066900070427            CloseLst( LstInf.Handle: ERRC0100 );
067000070427          EndIf;
067100060729
067200060504          SetLstAtr( UIM.AppHdl
067300060504                   : 'DTLLST'
067400060504                   : LIST_COMP
067500060504                   : EXIT_SAME
067600060504                   : POS_TOP
067700060504                   : TRIM_SAME
067800060504                   : ERRC0100
067900060504                   );
068000060504
068100060504        EndSr;
068200060506
068300070427        BegSr  PrcLstEnt;
068400070427
068500070519          RtvUsrAut( USRA0100
068600070519                   : %Size( USRA0100 )
068700070519                   : 'USRA0100'
068800070519                   : AUTU0150.UsrPrf
068900070519                   : OUTQ0100.OutQueNam + OUTQ0100.OutQueLib
069000070519                   : '*OUTQ'
069100070519                   : ERRC0100
069200070519                   );
069300070519
069400070519          If  ERRC0100.BytAvl = *Zero;
069500070519
069600070519            LstEnt.UsrPrf = AUTU0150.UsrPrf;
069700070521            LstEnt.UsrCls = GetUsrCls( AUTU0150.UsrPrf );
069800070522            LstEnt.GrpPrf = GetGrpPrf( AUTU0150.UsrPrf );
069900070526            LstEnt.NbrSupGrp = GetNbrSupGrp( AUTU0150.UsrPrf );
070000070519
070100070519            LstEnt.SplCtl  = 'N';
070200070519            LstEnt.JobCtl  = 'N';
070300070519            LstEnt.QueRead = 'N';
070400070519            LstEnt.QueRAD  = 'N';
070500070519            LstEnt.QueMgt  = 'N';
070600070519
070700070519            If  ValSpcAut( AUTU0150.UsrPrf: '*SPLCTL' ) = *On;
070800070519              LstEnt.SplCtl = 'Y';
070900070519            EndIf;
071000070519
071100070519            If  ValSpcAut( AUTU0150.UsrPrf: '*JOBCTL' ) = *On;
071200070519              LstEnt.JobCtl = 'Y';
071300070519            EndIf;
071400070519
071500070519            If  USRA0100.DtaRead = 'Y';
071600070519              LstEnt.QueRead = 'Y';
071700070519            EndIf;
071800070519
071900070519            If  USRA0100.DtaRead = 'Y'  And
072000070519                USRA0100.DtaAdd  = 'Y'  And
072100070519                USRA0100.DtaDlt  = 'Y';
072200070519              LstEnt.QueRAD = 'Y';
072300070519            EndIf;
072400070519
072500070519            If  USRA0100.ObjMgt = 'Y';
072600070519              LstEnt.QueMgt = 'Y';
072700070519            EndIf;
072800070519
072900070519            ExSr  SetAutFlg;
073000070519
073100070519            ExSr  PutLstEnt;
073200070427          EndIf;
073300070427
073400070427        EndSr;
073500070427
073600070519        BegSr  SetAutFlg;
073700070519
073800070519          LstEnt.StrWtr = 'N';
073900070519          LstEnt.AddSpl = 'N';
074000070519          LstEnt.WrkWth = 'N';
074100070519          LstEnt.QueOpr = 'N';
074200070519          LstEnt.QueOpm = 'N';
074300070519          LstEnt.SplCon = 'N';
074400070519          LstEnt.SplOpr = 'N';
074500070519
074600070519          If  LstEnt.SplCtl = 'Y';
074700070519            LstEnt.StrWtr = 'Y';
074800070519            LstEnt.AddSpl = 'Y';
074900070519            LstEnt.WrkWth = 'Y';
075000070519            LstEnt.QueOpr = 'Y';
075100070519            LstEnt.QueOpm = 'Y';
075200070519            LstEnt.SplCon = 'Y';
075300070519            LstEnt.SplOpr = 'Y';
075400070519          Else;
075500070519
075600070526            If  HdrRcd.AutChk = '*DTAAUT'       And
075700070526                LstEnt.QueRAD = 'Y'             Or
075800070526
075900070526                HdrRcd.AutChk  = '*OWNER'       And
076000070526                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or
076100070526
076200070526                HdrRcd.OprCtl = '*YES'          And
076300070519                LstEnt.JobCtl = 'Y';
076400070519
076500070519              LstEnt.StrWtr = 'Y';
076600070519            EndIf;
076700070519
076800070519            If  LstEnt.QueRead = 'Y'  Or
076900070519
077000070519                LstEnt.JobCtl  = 'Y'  And
077100070519                HdrRcd.OprCtl  = '*YES';
077200070519
077300070519              LstEnt.AddSpl = 'Y';
077400070519            EndIf;
077500070519
077600070519            If  LstEnt.QueRead = 'Y'  Or
077700070519
077800070519                LstEnt.JobCtl  = 'Y'  And
077900070519                HdrRcd.OprCtl  = '*YES';
078000070519
078100070519              LstEnt.WrkWth = 'Y';
078200070519            EndIf;
078300070519
078400070519            If  HdrRcd.AutChk  = '*DTAAUT'      And
078500070519                LstEnt.QueRAD  = 'Y'            Or
078600070519
078700070519                HdrRcd.AutChk  = '*OWNER'       And
078800070519                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or
078900070519
079000070519                HdrRcd.OprCtl  = '*YES'         And
079100070519                LstEnt.JobCtl  = 'Y';
079200070519
079300070519              LstEnt.QueOpr = 'Y';
079400070519            EndIf;
079500070519
079600070519            If  LstEnt.QueOpr = 'Y'  And
079700070519                LstEnt.QueMgt = 'Y';
079800070519
079900070519              LstEnt.QueOpm = 'Y';
080000070519            EndIf;
080100070519
080200070519            Select;
080300070519            When  HdrRcd.DspDta  = '*YES'         And
080400070519                  LstEnt.QueRead = 'Y'            Or
080500070519
080600070519                  HdrRcd.AutChk  = '*DTAAUT'      And
080700070519                  LstEnt.QueRAD  = 'Y'            Or
080800070519
080900070519                  HdrRcd.AutChk  = '*OWNER'       And
081000070519                  LstEnt.UsrPrf  = HdrRcd.QueOwn  Or
081100070519
081200070519                  HdrRcd.DspDta  = '*YES'         And
081300070522                  HdrRcd.OprCtl  = '*YES'         And
081400070519                  LstEnt.JobCtl  = 'Y'            Or
081500070522
081600070519                  HdrRcd.DspDta  = '*NO'          And
081700070522                  HdrRcd.OprCtl  = '*YES'         And
081800070519                  LstEnt.JobCtl  = 'Y';
081900070519
082000070519              LstEnt.SplCon = 'Y';
082100070519
082200070519            When  HdrRcd.DspDta = '*OWNER';
082300070519              LstEnt.SplCon = 'O';
082400070519            EndSl;
082500070519
082600070519            If  HdrRcd.AutChk  = '*DTAAUT'      And
082700070519                LstEnt.QueRAD  = 'Y'            Or
082800070519
082900070519                HdrRcd.AutChk  = '*OWNER'       And
083000070519                LstEnt.UsrPrf  = HdrRcd.QueOwn  Or
083100070519
083200070519                HdrRcd.OprCtl  = '*YES'         And
083300070519                LstEnt.JobCtl  = 'Y';
083400070519
083500070519              LstEnt.SplOpr = 'Y';
083600070519            EndIf;
083700070519
083800070519          EndIf;
083900070519
084000070519        EndSr;
084100070519
084200070427        BegSr  PutLstEnt;
084300060504
084400070427          LstEnt.Option = *Zero;
084500061109
084600070519          LstEnt.AutSrc = USRA0100.AutSrc;
084700070519          LstEnt.QueAut = USRA0100.ObjAut;
084800070519
084900070427          AddLstEnt( UIM.AppHdl
085000070427                   : LstEnt
085100070427                   : %Size( LstEnt )
085200070427                   : 'DTLRCD'
085300070427                   : 'DTLLST'
085400070427                   : UIM.EntLocOpt
085500070427                   : UIM.LstHdl
085600070427                   : ERRC0100
085700070427                   );
085800070427
085900070427              UIM.EntLocOpt = 'NEXT';
086000070427
086100061109        EndSr;
086200061109
086300060504        BegSr  GetLstPos;
086400060504
086500060504          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
086600060504
086700060504          If  LstAtr.DspPos <> 'TOP';
086800060504
086900060504            GetLstEnt( UIM.AppHdl
087000060504                     : LstEnt
087100060504                     : %Size( LstEnt )
087200060504                     : 'DTLRCD'
087300060504                     : 'DTLLST'
087400060504                     : 'HNDL'
087500060504                     : 'Y'
087600060504                     : *Blanks
087700060504                     : LstAtr.DspPos
087800060504                     : 'N'
087900060504                     : UIM.EntHdl
088000060504                     : ERRC0100
088100060504                     );
088200060504
088300060504            LstEntPos = LstEnt;
088400060504          EndIf;
088500060504
088600060504        EndSr;
088700060504
088800060504        BegSr  SetLstPos;
088900060504
089000060504          If  LstAtr.DspPos <> 'TOP';
089100060504
089200060504            LstEnt = LstEntPos;
089300060504
089400060504            PutDlgVar( UIM.AppHdl
089500060504                     : LstEnt
089600060504                     : %Size( LstEnt )
089700060504                     : 'DTLRCD'
089800060504                     : ERRC0100
089900060504                     );
090000060504
090100060504            GetLstEnt( UIM.AppHdl
090200060504                     : LstEnt
090300060504                     : %Size( LstEnt )
090400060504                     : '*NONE'
090500060504                     : 'DTLLST'
090600060504                     : 'FSLT'
090700060504                     : 'N'
090800070427                     : 'EQ        USRPRF'
090900060730                     : *Blanks
091000060504                     : 'N'
091100060504                     : UIM.EntHdl
091200060504                     : ERRC0100
091300060504                     );
091400060504
091500060504            If  ERRC0100.BytAvl = *Zero;
091600060504
091700060504              SetLstAtr( UIM.AppHdl
091800060504                       : 'DTLLST'
091900060504                       : LIST_SAME
092000060504                       : EXIT_SAME
092100060504                       : UIM.EntHdl
092200060504                       : TRIM_SAME
092300060504                       : ERRC0100
092400060504                       );
092500060504
092600060504            EndIf;
092700060504          EndIf;
092800060504
092900060504        EndSr;
093000060730
093100060730        BegSr  FndLstPos;
093200060730
093300070427          LstEnt.UsrPrf = HdrRcd.PosUsr;
093400060730
093500060730          PutDlgVar( UIM.AppHdl
093600060730                   : LstEnt
093700060730                   : %Size( LstEnt )
093800060730                   : 'DTLRCD'
093900060730                   : ERRC0100
094000060730                   );
094100060730
094200060730          GetLstEnt( UIM.AppHdl
094300060730                   : LstEnt
094400060730                   : %Size( LstEnt )
094500060730                   : 'DTLRCD'
094600060730                   : 'DTLLST'
094700060730                   : 'FSLT'
094800060730                   : 'Y'
094900070427                   : 'GE        USRPRF'
095000060730                   : *Blanks
095100060730                   : 'N'
095200060730                   : UIM.EntHdl
095300060730                   : ERRC0100
095400060730                   );
095500060730
095600060730          Select;
095700060730          When  ERRC0100.BytAvl > *Zero;
095800060730            GetLstEnt( UIM.AppHdl
095900060730                     : LstEnt
096000060730                     : %Size( LstEnt )
096100060730                     : '*NONE'
096200060730                     : 'DTLLST'
096300060730                     : 'LAST'
096400060730                     : 'N'
096500060730                     : *Blanks
096600060730                     : *Blanks
096700060730                     : 'N'
096800060730                     : UIM.EntHdl
096900060730                     : ERRC0100
097000060730                     );
097100060730
097200070427          When  %Scan( %Trim( HdrRcd.PosUsr ): LstEnt.UsrPrf ) <> 1;
097300060730            GetLstEnt( UIM.AppHdl
097400060730                     : LstEnt
097500060730                     : %Size( LstEnt )
097600060730                     : '*NONE'
097700060730                     : 'DTLLST'
097800060730                     : 'PREV'
097900060730                     : 'N'
098000060730                     : *Blanks
098100060730                     : *Blanks
098200060730                     : 'N'
098300060730                     : UIM.EntHdl
098400060730                     : ERRC0100
098500060730                     );
098600060730
098700060730            If  ERRC0100.BytAvl > *Zero;
098800060730              GetLstEnt( UIM.AppHdl
098900060730                       : LstEnt
099000060730                       : %Size( LstEnt )
099100060730                       : '*NONE'
099200060730                       : 'DTLLST'
099300060730                       : 'FRST'
099400060730                       : 'N'
099500060730                       : *Blanks
099600060730                       : *Blanks
099700060730                       : 'N'
099800060730                       : UIM.EntHdl
099900060730                       : ERRC0100
100000060730                       );
100100060730            EndIf;
100200060730          EndSl;
100300060730
100400060730          If  ERRC0100.BytAvl = *Zero;
100500060730
100600060730            SetLstAtr( UIM.AppHdl
100700060730                     : 'DTLLST'
100800060730                     : LIST_SAME
100900060730                     : EXIT_SAME
101000060730                     : UIM.EntHdl
101100060730                     : TRIM_SAME
101200060730                     : ERRC0100
101300060730                     );
101400060730
101500060730          EndIf;
101600060730
101700070427          HdrRcd.PosUsr = *Blanks;
101800060730
101900060730        EndSr;
102000060504
102100061109        BegSr  PosLstTop;
102200061109
102300061109          SetLstAtr( UIM.AppHdl
102400061109                   : 'DTLLST'
102500061109                   : LIST_SAME
102600061109                   : EXIT_SAME
102700061109                   : POS_TOP
102800061109                   : TRIM_SAME
102900061109                   : ERRC0100
103000061109                   );
103100061109
103200061109        EndSr;
103300061109
103400061109        BegSr  PosLstBot;
103500061109
103600061109          SetLstAtr( UIM.AppHdl
103700061109                   : 'DTLLST'
103800061109                   : LIST_SAME
103900061109                   : EXIT_SAME
104000061109                   : POS_BOT
104100061109                   : TRIM_SAME
104200061109                   : ERRC0100
104300061109                   );
104400061109
104500061109        EndSr;
104600061109
104700060504        BegSr  BldHdrRcd;
104800060504
104900070519          RtvOutQueInf( OUTQ0100
105000070519                      : %Size( OUTQ0100 )
105100070519                      : 'OUTQ0100'
105200070519                      : PxOutQue_q
105300070519                      : ERRC0100
105400070519                      );
105500070519
105600070519          If  ERRC0100.BytAvl = *Zero;
105700070520            HdrRcd.OutQue = OUTQ0100.OutQue_q;
105800070519            HdrRcd.DspDta = OUTQ0100.DspAnyF;
105900070519            HdrRcd.OprCtl = OUTQ0100.OprCtl;
106000070519            HdrRcd.AutChk = OUTQ0100.AutChk;
106100070519
106200070522            HdrRcd.QueOwn  = GetObjOwn( OUTQ0100.OutQue_q: '*OUTQ' );
106300070522            HdrRcd.PubAut  = GetPubAut( OUTQ0100.OutQue_q: '*OUTQ' );
106400070522            HdrRcd.QueAutL = GetObjAutL( OUTQ0100.OutQue_q: '*OUTQ' );
106500070519          EndIf;
106600070519
106700060504          SysDts = %Timestamp();
106800060504
106900060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
107000060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
107100060511          HdrRcd.TimZon = '*SYS';
107200060504
107300060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
107400060504
107500060504        EndSr;
107600060729
107700060730        BegSr  RstHdrRcd;
107800060730
107900070427          HdrRcd.WrkUsr = WrkUsr;
108000070427          HdrRcd.PosUsr = *Blanks;
108100060730
108200060730        EndSr;
108300060730
108400060729        BegSr  *InzSr;
108500060729
108600070427          HdrRcd.WrkUsr = PxUsrPrf;
108700070427          HdrRcd.PosUsr = *Blanks;
108800060729
108900070427          WrkUsr = HdrRcd.WrkUsr;
109000060729
109100060729        EndSr;
109200060504
109300060504        BegSr  DltUsrLst;
109400060504
109500060504          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
109600060504
109700060504        EndSr;
109800060519
109900050226      /End-Free
110000060428
110100060729     **-- Get job type:
110200060729     P GetJobTyp       B
110300060729     D                 Pi             1a
110400060729
110500060729     D JOBI0400        Ds                  Qualified
110600060729     D  BytRtn                       10i 0
110700060729     D  BytAvl                       10i 0
110800060729     D  JobNam                       10a
110900060729     D  UsrNam                       10a
111000060729     D  JobNbr                        6a
111100060729     D  JobIntId                     16a
111200060729     D  JobSts                       10a
111300060729     D  JobTyp                        1a
111400060729     D  JobSubTyp                     1a
111500060729
111600060729      /Free
111700060729
111800060729        RtvJobInf( JOBI0400
111900060729                 : %Size( JOBI0400 )
112000060729                 : 'JOBI0400'
112100060729                 : '*'
112200060729                 : *Blank
112300060729                 : ERRC0100
112400060729                 );
112500060729
112600060729        If  ERRC0100.BytAvl > *Zero;
112700060729          Return  *Blank;
112800060729
112900060729        Else;
113000060729          Return  JOBI0400.JobTyp;
113100060729        EndIf;
113200060729
113300060729      /End-Free
113400060729
113500060729     P GetJobTyp       E
113600070518     **-- Get object owner:
113700070518     P GetObjOwn       B
113800070518     D                 Pi            10a
113900070518     D  PxObjNam_q                   20a   Const
114000070518     D  PxObjTyp                     10a   Const
114100070518     **
114200070518     D OBJD0100        Ds                  Qualified
114300070518     D  BytRtn                       10i 0
114400070518     D  BytAvl                       10i 0
114500070518     D  ObjNam                       10a
114600070518     D  ObjLib                       10a
114700070518     D  ObjTyp                       10a
114800070518     D  ObjLibRtn                    10a
114900070518     D  ObjASP                       10i 0
115000070518     D  ObjOwn                       10a
115100070518     D  ObjDmn                        2a
115200070518
115300070518      /Free
115400070518
115500070518         RtvObjD( OBJD0100
115600070518                : %Size( OBJD0100 )
115700070518                : 'OBJD0100'
115800070518                : PxObjNam_q
115900070518                : PxObjTyp
116000070518                : ERRC0100
116100070518                );
116200070518
116300070518         If  ERRC0100.BytAvl > *Zero;
116400070518           Return  *Blanks;
116500070518
116600070518         Else;
116700070518           Return  OBJD0100.ObjOwn;
116800070518         EndIf;
116900070518
117000070518      /End-Free
117100070518
117200070518     P GetObjOwn       E
117300070519     **-- Get object public authority:
117400070519     P GetPubAut       B
117500070519     D                 Pi            10a
117600070519     D  PxObjNam_q                   20a   Const
117700070519     D  PxObjTyp                     10a   Const
117800070519
117900070519      /Free
118000070519
118100070519        RtvUsrAut( USRA0100
118200070519                 : %Size( USRA0100 )
118300070519                 : 'USRA0100'
118400070519                 : '*PUBLIC'
118500070519                 : PxObjNam_q
118600070519                 : PxObjTyp
118700070519                 : ERRC0100
118800070519                 );
118900070519
119000070519        If  ERRC0100.BytAvl > *Zero;
119100070519           Return  *Blanks;
119200070519         Else;
119300070519           Return  USRA0100.ObjAut;
119400070519         EndIf;
119500070519
119600070519      /End-Free
119700070519
119800070519     P GetPubAut       E
119900070522     **-- Get object auhtorization list:
120000070522     P GetObjAutL      B
120100070522     D                 Pi            10a
120200070522     D  PxObjNam_q                   20a   Const
120300070522     D  PxObjTyp                     10a   Const
120400070522
120500070522      /Free
120600070522
120700070522        RtvUsrAut( USRA0100
120800070522                 : %Size( USRA0100 )
120900070522                 : 'USRA0100'
121000070522                 : '*PUBLIC'
121100070522                 : PxObjNam_q
121200070522                 : PxObjTyp
121300070522                 : ERRC0100
121400070522                 );
121500070522
121600070522        If  ERRC0100.BytAvl > *Zero;
121700070522           Return  *Blanks;
121800070522         Else;
121900070522           Return  USRA0100.AutLst;
122000070522         EndIf;
122100070522
122200070522      /End-Free
122300070522
122400070522     P GetObjAutL      E
122500070521     **-- Get user class:
122600070526     P GetUsrCls       B
122700070521     D                 Pi            10a
122800070518     D  PxUsrPrf                     10a   Value
122900070521
123000070518
123100070518      /Free
123200070521
123300070521        If  PxUsrPrf = USRI0200.UsrPrf;
123400070521          ERRC0100.BytAvl = *Zero;
123500070521
123600070521        Else;
123700070521          RtvUsrInf( USRI0200
123800070521                   : %Size( USRI0200 )
123900070521                   : 'USRI0200'
124000070521                   : PxUsrPrf
124100070521                   : ERRC0100
124200070521                   );
124300070521        EndIf;
124400070518
124500070521        If  ERRC0100.BytAvl > *Zero;
124600070521          Return  *Blanks;
124700070518
124800070521        Else;
124900070521          Return  USRI0200.UsrCls;
125000070521        EndIf;
125100070518
125200070518      /End-Free
125300070518
125400070521     P GetUsrCls       E
125500070522     **-- Get group profile:
125600070526     P GetGrpPrf       B
125700070522     D                 Pi            10a
125800070522     D  PxUsrPrf                     10a   Value
125900070522
126000070522
126100070522      /Free
126200070522
126300070522        If  PxUsrPrf = USRI0200.UsrPrf;
126400070522          ERRC0100.BytAvl = *Zero;
126500070522
126600070522        Else;
126700070522          RtvUsrInf( USRI0200
126800070522                   : %Size( USRI0200 )
126900070522                   : 'USRI0200'
127000070522                   : PxUsrPrf
127100070522                   : ERRC0100
127200070522                   );
127300070522        EndIf;
127400070522
127500070522        If  ERRC0100.BytAvl > *Zero;
127600070522          Return  *Blanks;
127700070522
127800070522        Else;
127900070522          Return  USRI0200.GrpPrf;
128000070522        EndIf;
128100070522
128200070522      /End-Free
128300070522
128400070522     P GetGrpPrf       E
128500070526     **-- Get number of supplemental group profiles:
128600070526     P GetNbrSupGrp    B
128700070526     D                 Pi             5i 0
128800070526     D  PxUsrPrf                     10a   Value
128900070526
129000070526
129100070526      /Free
129200070526
129300070526        If  PxUsrPrf = USRI0200.UsrPrf;
129400070526          ERRC0100.BytAvl = *Zero;
129500070526
129600070526        Else;
129700070526          RtvUsrInf( USRI0200
129800070526                   : %Size( USRI0200 )
129900070526                   : 'USRI0200'
130000070526                   : PxUsrPrf
130100070526                   : ERRC0100
130200070526                   );
130300070526        EndIf;
130400070526
130500070526        If  ERRC0100.BytAvl > *Zero;
130600070526          Return  -1;
130700070526
130800070526        Else;
130900070526          Return  USRI0200.NbrSupGrp;
131000070526        EndIf;
131100070526
131200070526      /End-Free
131300070526
131400070526     P GetNbrSupGrp    E
131500070521     **-- Validate special authority:
131600070526     P ValSpcAut       B
131700070521     D                 Pi              n
131800070521     D  PxUsrPrf                     10a   Value
131900070521     D  PxSpcAut                     10a   Value
132000070521
132100070521
132200070521      /Free
132300070521
132400070521        If  PxUsrPrf = USRI0200.UsrPrf;
132500070521          ERRC0100.BytAvl = *Zero;
132600070521
132700070521        Else;
132800070521          RtvUsrInf( USRI0200
132900070521                   : %Size( USRI0200 )
133000070521                   : 'USRI0200'
133100070521                   : PxUsrPrf
133200070521                   : ERRC0100
133300070521                   );
133400070521        EndIf;
133500070521
133600070521        Select;
133700070521        When  ERRC0100.BytAvl > *Zero;
133800070521          Return *Off;
133900070521
134000070521        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
134100070521          Return  *On;
134200070521
134300070521        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
134400070521          Return  *On;
134500070521
134600070521        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
134700070521          Return  *On;
134800070521
134900070521        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
135000070521          Return  *On;
135100070521
135200070521        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
135300070521          Return  *On;
135400070521
135500070521        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
135600070521          Return  *On;
135700070521
135800070521        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
135900070521          Return  *On;
136000070521
136100070521        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
136200070521          Return  *On;
136300070521
136400070521        Other;
136500070521          Return *Off;
136600070521        EndSl;
136700070521
136800070521      /End-Free
136900070521
137000070521     P ValSpcAut       E
137100070428     **-- Send status message:
137200070428     P SndStsMsg       B
137300070428     D                 Pi            10i 0
137400070428     D  PxMsgDta                   1024a   Const  Varying
137500070428     **
137600070428     D MsgKey          s              4a
137700070428
137800070428      /Free
137900070428
138000070428        SndPgmMsg( 'CPF9897'
138100070428                 : 'QCPFMSG   *LIBL'
138200070428                 : PxMsgDta
138300070428                 : %Len( PxMsgDta )
138400070428                 : '*STATUS'
138500070428                 : '*EXT'
138600070428                 : 0
138700070428                 : MsgKey
138800070428                 : ERRC0100
138900070428                 );
139000070428
139100070428        If  ERRC0100.BytAvl > *Zero;
139200070428          Return  -1;
139300070428
139400070428        Else;
139500070428          Return   0;
139600070428        EndIf;
139700070428
139800070428      /End-Free
139900070428
140000070428     P SndStsMsg       E
140100060729     **-- Send completion message:
140200060729     P SndCmpMsg       B
140300060729     D                 Pi            10i 0
140400060729     D  PxMsgDta                    512a   Const  Varying
140500060729     **
140600060729     D MsgKey          s              4a
140700060729
140800060729      /Free
140900060729
141000060729        SndPgmMsg( 'CPF9897'
141100060729                 : 'QCPFMSG   *LIBL'
141200060729                 : PxMsgDta
141300060729                 : %Len( PxMsgDta )
141400060729                 : '*COMP'
141500060729                 : '*PGMBDY'
141600060729                 : 1
141700060729                 : MsgKey
141800060729                 : ERRC0100
141900060729                 );
142000060729
142100060729        If  ERRC0100.BytAvl > *Zero;
142200060729          Return  -1;
142300060729
142400060729        Else;
142500060729          Return  0;
142600060729
142700060729        EndIf;
142800060729
142900060729      /End-Free
143000060729
143100060729     P SndCmpMsg       E
143200060504     **-- Send escape message:
143300060504     P SndEscMsg       B
143400060504     D                 Pi            10i 0
143500060504     D  PxMsgId                       7a   Const
143600060504     D  PxMsgF                       10a   Const
143700060504     D  PxMsgDta                    512a   Const  Varying
143800060504     **
143900060504     D MsgKey          s              4a
144000060504
144100060504      /Free
144200060504
144300060504        SndPgmMsg( PxMsgId
144400060504                 : PxMsgF + '*LIBL'
144500060504                 : PxMsgDta
144600060504                 : %Len( PxMsgDta )
144700060504                 : '*ESCAPE'
144800060504                 : '*PGMBDY'
144900060504                 : 1
145000060504                 : MsgKey
145100060504                 : ERRC0100
145200060504                 );
145300060504
145400060504        If  ERRC0100.BytAvl > *Zero;
145500060504          Return  -1;
145600060504
145700060504        Else;
145800060504          Return   0;
145900060504        EndIf;
146000060504
146100060504      /End-Free
146200060504
146300060504     P SndEscMsg       E
