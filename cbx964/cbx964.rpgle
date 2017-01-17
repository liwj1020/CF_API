000100060505     **
000200061106     **  Program . . : CBX964
000300061106     **  Description : Work with Server Shares - CCP
000400060505     **  Author  . . : Carsten Flensburg
000500061106     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000061106     **    CrtRpgMod   Module( CBX964 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300061106     **    CrtPgm      Pgm( CBX964 )
001400061106     **                Module( CBX964 )
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
003000061107     D MAX_ALLOC       c                   16776704
003100061107     D INZ_ALLOC       c                   65535
003200061107     D INC_ALLOC       c                   32767
003300061108     D DEV_ALL         c                   -1
003400061108     D DEV_FILE        c                   0
003500061108     D DEV_PRINT       c                   1
003600061203     D TYP_INTER       c                   'I'
003700061109     **
003800061109     D NBR_KEY         c                   1
003900061109     D KEY_OFS         c                   80
004000061109     D SIZ_NLS_INF     c                   290
004100061109     D JOB_RUN         c                   0
004200061109     D CHAR_NLS        c                   4
004300061109     D ASCEND          c                   1
004400061109     D DESCEND         c                   2
004500061109     **
004600061109     D SRT_PUT         c                   1
004700061109     D SRT_END         c                   2
004800061109     D SRT_GET         c                   3
004900061109     D SRT_CNL         c                   4
005000060504     **-- UIM constants:
005100061106     D PNLGRP_Q        c                   'CBX964P   *LIBL     '
005200061106     D PNLGRP          c                   'CBX964P   '
005300060504     D SCP_AUT_RCL     c                   -1
005400060504     D RDS_OPT_INZ     c                   'N'
005500060504     D PRM_IFC_0       c                   0
005600060504     D CLO_NORM        c                   'M'
005700060504     D FNC_EXIT        c                   -4
005800060504     D FNC_CNL         c                   -8
005900060504     D KEY_F05         c                   5
006000061109     D KEY_F17         c                   17
006100061109     D KEY_F18         c                   18
006200060506     D RTN_ENTER       c                   500
006300060504     D HLP_WDW         c                   'N'
006400060504     D POS_TOP         c                   'TOP'
006500060504     D POS_BOT         c                   'BOT'
006600060504     D LIST_COMP       c                   'ALL'
006700060504     D LIST_SAME       c                   'SAME'
006800060504     D EXIT_SAME       c                   '*SAME'
006900060504     D TRIM_SAME       c                   'S'
007000060729     **
007100060729     D APP_PRTF        c                   'QPRINT    *LIBL'
007200060729     D ODP_SHR         c                   'N'
007300061106     D SPLF_NAM        c                   'PSVRSHR'
007400061203     D SPLF_USRDTA     c                   'DWRKVRSHR'
007500060729     D EJECT_NO        c                   'N'
007600060504
007700060424     **-- Global variables:
007800060506     D Idx             s             10i 0
007900061106     D ApiRcvSiz       s             10u 0
008000061108     D Path            s           1024a   Varying
008100060506     D SysDts          s               z
008200061106     D WrkShr          s             12a
008300061108     D WrkTyp          s             10i 0
008400061109     D pRtnDta         s               *
008500061108     D RcvVar          s           1024a   Based( pRcvVar )
008600061109     D SrtAct          s               n
008700060504
008800061109     **-- Sort API parameters:
008900061109     D SrtApi          Ds                  Qualified  Inz
009000061109     D  DtaBufLen                    10i 0
009100061109     D  DtaRtnLen                    10i 0
009200061109     D  Omit                         16a
009300061109     **
009400061109     D RqsCtlBlk       Ds                  Qualified  Inz
009500061109     D  BlkLen                       10i 0
009600061109     D  RqsTyp                       10i 0 Inz( 8 )
009700061109     D                               10i 0
009800061109     D  Options                      10i 0
009900061109     D  RcdLen                       10i 0 Inz( %Size( LstEnt ))
010000061109     D  RcdCnt                       10i 0
010100061109     D  KeyOfs                       10i 0 Inz( KEY_OFS )
010200061109     D  KeyNbr                       10i 0
010300061109     D  NlsOfs                       10i 0
010400061109     D  InpFlsOfs                    10i 0
010500061109     D  InpFlsNbr                    10i 0
010600061109     D  OutFlsOfs                    10i 0
010700061109     D  OutFlsNbr                    10i 0
010800061109     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
010900061109     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
011000061109     D  InpFenLen                    10i 0
011100061109     D  OutFenLen                    10i 0
011200061109     D  NlbMapOfs                    10i 0
011300061109     D  VlrAciOfs                    10i 0
011400061109     D                               10i 0
011500061109     **
011600061109     D SrtKeyInf                     20a   Dim( NBR_KEY )
011700061109     **
011800061109     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
011900061109     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
012000061109     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
012100061109     D SrtSeqTbl                    256a
012200061109     **
012300061109     D SrtKeyInfDs     Ds                  Qualified  Inz
012400061109     D  KeyStrPos                    10i 0
012500061109     D  KeySize                      10i 0
012600061109     D  KeyDtaTyp                    10i 0
012700061109     D  KeyOrder                     10i 0
012800061109     D  KeyOrdPos                    10i 0
012900061109     **
013000061109     D RqsCtlBlkIo     Ds                  Qualified
013100061109     D  RqsTyp                       10i 0 Inz
013200061109     D                               10i 0 Inz
013300061109     D  RcdLen                       10i 0 Inz
013400061109     D  RcdCnt                       10i 0 Inz
013500061109     **
013600061109     D DtaBufInf       Ds                  Qualified
013700061109     D  RcdPrc                       10i 0
013800061109     D  RcdAvl                       10i 0 Inz( *Zero )
013900061109     D                                8a
014000061109
014100060504     **-- UIM variables:
014200060504     D UIM             Ds                  Qualified
014300060504     D  AppHdl                        8a
014400060504     D  LstHdl                        4a
014500060504     D  EntHdl                        4a
014600060504     D  FncRqs                       10i 0
014700060504     D  EntLocOpt                     4a
014800060504     D  LstPos                        4a
014900060504     **-- List attributes structure:
015000060504     D LstAtr          Ds                  Qualified
015100060504     D  LstCon                        4a
015200060504     D  ExtPgmVar                    10a
015300060504     D  DspPos                        4a
015400060504     D  AlwTrim                       1a
015500060505
015600061109     **-- Initialize sort:
015700061109     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
015800061109     D  RqsCtlBlk                    80a   Const  Options( *VarSize )
015900061109     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
016000061109     D  OutDtaBuf                 65535a          Options( *VarSize )
016100061109     D  OutDtaLen                    10i 0 Const
016200061109     D  RtnDtaLen                    10i 0
016300061109     D  Error                     32767a          Options( *VarSize )
016400061109     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
016500061109     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
016600061109     **-- Sort input/output:
016700061109     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
016800061109     D  RqsCtlBlk                    16a   Const
016900061109     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
017000061109     D  OutDtaBuf                 65535a          Options( *VarSize )
017100061109     D  OutDtaLen                    10i 0 Const
017200061109     D  OutDtaInf                    16a
017300061109     D  Error                     32767a          Options( *VarSize )
017400061109     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
017500061109     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
017600060511     **-- UIM Panel exit prgram record:
017700060511     D ExpRcd          Ds                  Qualified
017800061106     D  ExitPg                       20a   Inz( 'CBX964E   *LIBL' )
017900060511     **-- UIM Panel header record:
018000060511     D HdrRcd          Ds                  Qualified
018100060504     D  SysDat                        7a
018200060504     D  SysTim                        6a
018300060504     D  TimZon                       10a
018400061106     D  WrkShr                       12a
018500061108     D  WrkTyp                       10i 0
018600061106     D  PosShr                       12a
018700060504     **-- UIM List entry:
018800060504     D LstEnt          Ds                  Qualified
018900060504     D  Option                        5i 0
019000061106     D  Share                        12a
019100061108     D  ShrTyp                        1s 0
019200061106     D  TxtDsc                       50a
019300061108     D  ShrRsc                       50a
019400060504     **
019500060504     D LstEntPos       Ds                  LikeDs( LstEnt )
019600060504
019700060729     **-- List information:
019800060729     D LstInf          Ds                  Qualified
019900060729     D  RcdNbrTot                    10i 0
020000060729     D  RcdNbrRtn                    10i 0
020100060729     D  RcdLen                       10i 0
020200060729     D  InfLenRtn                    10i 0
020300060729     D  InfCmp                        1a
020400060729     D  Dts                          13a
020500061106     D                               34a   Inz( *Allx'00' )
020600061106     **-- List information:
020700061106     D ZLSL0101        Ds         32767    Qualified  Based( pZLSL0101 )
020800061106     D  EntLen                       10i 0
020900061106     D  Share                        12a
021000061106     D  DevTyp                       10i 0
021100061106     D  Permis                       10i 0
021200061106     D  MaxUsr                       10i 0
021300061106     D  CurUsr                       10i 0
021400061106     D  SpfTyp                       10i 0
021500061106     D  OfsPthNam                    10i 0
021600061106     D  LenPthNam                    10i 0
021700061106     D  OutQue_q                     20a
021800061106     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
021900061106     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
022000061106     D  PrtDrv                       50a
022100061106     D  TxtDsc                       50a
022200061106     D  PrtFil_q                     20a
022300061106     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
022400061106     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
022500061106     D  TxtCcsId                     10i 0
022600061106     D  OfsExtTbl                    10i 0
022700061106     D  NbrTblEnt                    10i 0
022800061106     D  EnbTxtCnv                     1a
022900061106     D  Publish                       1a
023000061108     D  DATA                      10240a
023100060503
023200060729     **-- Open list of server information:
023300060729     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
023400060729     D  RcvVar                    32767a          Options( *VarSize )
023500060729     D  RcvVarLen                    10i 0 Const
023600060729     D  LstInf                       64a
023700060729     D  FmtNam                       10a   Const
023800060729     D  InfQual                      15a   Const
023900060729     D  Error                     32767a          Options( *VarSize )
024000060729     D  SsnUsr                       10a   Const  Options( *NoPass )
024100060729     D  SsnId                        20i 0 Const  Options( *NoPass )
024200060504     **-- Send program message:
024300060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
024400060504     D  MsgId                         7a   Const
024500060504     D  MsgFq                        20a   Const
024600060504     D  MsgDta                      128a   Const
024700060504     D  MsgDtaLen                    10i 0 Const
024800060504     D  MsgTyp                       10a   Const
024900060504     D  CalStkE                      10a   Const  Options( *VarSize )
025000060504     D  CalStkCtr                    10i 0 Const
025100060504     D  MsgKey                        4a
025200060504     D  Error                     32767a          Options( *VarSize )
025300060729     **-- Retrieve job information:
025400060729     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
025500060729     D  RcvVar                    32767a         Options( *VarSize )
025600060729     D  RcvVarLen                    10i 0 Const
025700060729     D  FmtNam                        8a   Const
025800060729     D  JobNamQ                      26a   Const
025900060729     D  JobIntId                     16a   Const
026000060729     D  Error                     32767a         Options( *NoPass: *VarSize )
026100061108     **-- Retrieve object description:
026200061108     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
026300061108     D  RcvVar                    32767a          Options( *VarSize )
026400061108     D  RcvVarLen                    10i 0 Const
026500061108     D  FmtNam                        8a   Const
026600061108     D  ObjNamQ                      20a   Const
026700061108     D  ObjTyp                       10a   Const
026800061108     D  Error                     32767a          Options( *VarSize )
026900061106
027000060504     **-- Open display application:
027100060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
027200060504     D  AppHdl                        8a
027300060504     D  PnlGrp_q                     20a   Const
027400060504     D  AppScp                       10i 0 Const
027500060504     D  ExtPrmIfc                    10i 0 Const
027600060504     D  FulScrHlp                     1a   Const
027700060504     D  Error                     32767a          Options( *VarSize )
027800060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
027900060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
028000060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
028100060729     **-- Add print application:
028200060729     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
028300060729     D  AppHdl                        8a   Const
028400060729     D  PrtDevF_q                    20a   Const
028500060729     D  AltFilNam                    10a   Const
028600060729     D  ShrOpnDtaPth                  1a   Const
028700060729     D  UsrDta                       10a   Const
028800060729     D  Error                     32767a          Options( *VarSize )
028900060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
029000060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
029100060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
029200060729     **-- Open print application:
029300060729     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
029400060729     D  AppHdl                        8a
029500060729     D  PnlGrp_q                     20a   Const
029600060729     D  AppScp                       10i 0 Const
029700060729     D  ExtPrmIfc                    10i 0 Const
029800060729     D  PrtDevF_q                    20a   Const
029900060729     D  AltFilNam                    10a   Const
030000060729     D  ShrOpnDtaPth                  1a   Const
030100060729     D  UsrDta                       10a   Const
030200060729     D  Error                     32767a          Options( *VarSize )
030300060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
030400060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
030500060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
030600060504     **-- Display panel:
030700060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
030800060504     D  AppHdl                        8a   Const
030900060504     D  FncRqs                       10i 0
031000060504     D  PnlNam                       10a   Const
031100060504     D  ReDspOpt                      1a   Const
031200060504     D  Error                     32767a          Options( *VarSize )
031300060504     D  UsrTsk                        1a   Const  Options( *NoPass )
031400060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
031500060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
031600060504     D  MsgKey                        4a   Const  Options( *NoPass )
031700060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
031800060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
031900060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
032000060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
032100060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
032200060504     D  CalQlf                       20a   Const  Options( *NoPass )
032300060729     **-- Print panel:
032400060729     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
032500060729     D  AppHdl                        8a   Const
032600060729     D  PrtPnlNam                    10a   Const
032700060729     D  EjtOpt                        1a   Const
032800060729     D  Error                     32767a          Options( *VarSize )
032900060504     **-- Put dialog variable:
033000060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
033100060504     D  AppHdl                        8a   Const
033200060504     D  VarBuf                    32767a   Const  Options( *VarSize )
033300060504     D  VarBufLen                    10i 0 Const
033400060504     D  VarRcdNam                    10a   Const
033500060504     D  Error                     32767a          Options( *VarSize )
033600060504     **-- Get dialog variable:
033700060504     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
033800060504     D  AppHdl                        8a   Const
033900060504     D  VarBuf                    32767a          Options( *VarSize )
034000060504     D  VarBufLen                    10i 0 Const
034100060504     D  VarRcdNam                    10a   Const
034200060504     D  Error                     32767a          Options( *VarSize )
034300060504     **-- Add list entry:
034400060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
034500060504     D  AppHdl                        8a   Const
034600060504     D  VarBuf                    32767a   Const  Options( *VarSize )
034700060504     D  VarBufLen                    10i 0 Const
034800060504     D  VarRcdNam                    10a   Const
034900060504     D  LstNam                       10a   Const
035000060504     D  EntLocOpt                     4a   Const
035100060504     D  LstEntHdl                     4a
035200060504     D  Error                     32767a          Options( *VarSize )
035300060504     **-- Get list entry:
035400060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
035500060504     D  AppHdl                        8a   Const
035600060504     D  VarBuf                    32767a   Const  Options( *VarSize )
035700060504     D  VarBufLen                    10i 0 Const
035800060504     D  VarRcdNam                    10a   Const
035900060504     D  LstNam                       10a   Const
036000060504     D  PosOpt                        4a   Const
036100060504     D  CpyOpt                        1a   Const
036200060504     D  SltCri                       20a   Const
036300060504     D  SltHdl                        4a   Const
036400060504     D  ExtOpt                        1a   Const
036500060504     D  LstEntHdl                     4a
036600060504     D  Error                     32767a          Options( *VarSize )
036700060504     **-- Retrieve list attributes:
036800060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
036900060504     D  AppHdl                        8a   Const
037000060504     D  LstNam                       10a   Const
037100060504     D  AtrRcv                    32767a          Options( *VarSize )
037200060504     D  AtrRcvLen                    10i 0 Const
037300060504     D  Error                     32767a          Options( *VarSize )
037400060504     **-- Set list attributes:
037500060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
037600060504     D  AppHdl                        8a   Const
037700060504     D  LstNam                       10a   Const
037800060504     D  LstCon                        4a   Const
037900060504     D  ExtPgmVar                    10a   Const
038000060504     D  DspPos                        4a   Const
038100060504     D  AlwTrim                       1a   Const
038200060504     D  Error                     32767a          Options( *VarSize )
038300060504     **-- Delete list:
038400060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
038500060504     D  AppHdl                        8a   Const
038600060504     D  LstNam                       10a   Const
038700060504     D  Error                     32767a          Options( *VarSize )
038800060504     **-- Close application:
038900060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
039000060504     D  AppHdl                        8a   Const
039100060504     D  CloOpt                        1a   Const
039200060504     D  Error                     32767a          Options( *VarSize )
039300060504
039400060729     **-- Get job type:
039500060729     D GetJobTyp       Pr             1a
039600061108     **-- Convert object to path:
039700061108     D CvtObjPth       Pr          1024a   Varying
039800061108     D  PxObjNam                     10a   Value  Varying  Options( *Trim )
039900061108     D  PxObjLib                     10a   Value  Varying  Options( *Trim )
040000061108     D  PxObjTyp                     10a   Value  Varying  Options( *Trim )
040100061108     D  PxFilMbr                     10a   Const  Varying
040200061108     D                                            Options( *Trim: *Omit )
040300061108     D  PxRslLib                       n   Const  Options( *Omit )
040400061108     **-- Get object library:
040500061108     D GetObjLib       Pr            10a   Varying
040600061108     D  PxObjNam                     10a   Const
040700061108     D  PxObjLib                     10a   Const
040800061108     D  PxObjTyp                     10a   Const
040900060729     **-- Send completion message:
041000060729     D SndCmpMsg       Pr            10i 0
041100060729     D  PxMsgDta                    512a   Const  Varying
041200060504     **-- Send escape message:
041300060504     D SndEscMsg       Pr            10i 0
041400060504     D  PxMsgId                       7a   Const
041500060504     D  PxMsgF                       10a   Const
041600060504     D  PxMsgDta                    512a   Const  Varying
041700050226
041800061106     D CBX964          Pr
041900061106     D  PxShare                      12a
042000061108     D  PxType                       10i 0
042100060729     D  PxOutOpt                      3a
042200050226     **
042300061106     D CBX964          Pi
042400061106     D  PxShare                      12a
042500061108     D  PxType                       10i 0
042600060729     D  PxOutOpt                      3a
042700050226
042800050226      /Free
042900060729
043000061203        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;
043100060729
043200060729          OpnDspApp( UIM.AppHdl
043300060729                   : PNLGRP_Q
043400060729                   : SCP_AUT_RCL
043500060729                   : PRM_IFC_0
043600060729                   : HLP_WDW
043700060729                   : ERRC0100
043800060729                   );
043900060729        Else;
044000060729          OpnPrtApp( UIM.AppHdl
044100060729                   : PNLGRP_Q
044200060729                   : SCP_AUT_RCL
044300060729                   : PRM_IFC_0
044400060729                   : APP_PRTF
044500060729                   : SPLF_NAM
044600060729                   : ODP_SHR
044700060729                   : SPLF_USRDTA
044800060729                   : ERRC0100
044900060729                   );
045000060729        EndIf;
045100060729
045200061108        If  ERRC0100.BytAvl > *Zero;
045300100319          ExSr  EscApiErr;
045400060729        EndIf;
045500060729
045600060729        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
045700060729
045800060729        ExSr  BldHdrRcd;
045900061107        ExSr  BldShrLst;
046000060729
046100061203        If  PxOutOpt = 'DSP'  And  GetJobTyp() = TYP_INTER;
046200060729          ExSr  DspLst;
046300060729        Else;
046400060729          ExSr  WrtLst;
046500060729        EndIf;
046600060424
046700060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
046800050226
046900050226        *InLr = *On;
047000050226        Return;
047100060412
047200060505
047300060729        BegSr  DspLst;
047400060729
047500060729          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
047600060729
047700060729            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
047800060729
047900100319            If  ERRC0100.BytAvl > *Zero;
048000100319              ExSr  EscApiErr;
048100100319            EndIf;
048200100319
048300060729            GetDlgVar( UIM.AppHdl
048400060729                     : HdrRcd
048500060729                     : %Size( HdrRcd )
048600060729                     : 'HDRRCD'
048700060729                     : ERRC0100
048800060729                     );
048900060729
049000060729            Select;
049100060729            When  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
049200060729              ExSr  GetLstPos;
049300060729              ExSr  DltUsrLst;
049400060729
049500061109            When  WrkShr <> HdrRcd.WrkShr  Or  WrkTyp <> HdrRcd.WrkTyp;
049600060729              ExSr  DltUsrLst;
049700060729            EndSl;
049800060729
049900060729            Select;
050000060729            When  UIM.FncRqs = KEY_F05;
050100060730              ExSr  RstHdrRcd;
050200061107              ExSr  BldShrLst;
050300060729              ExSr  SetLstPos;
050400060729
050500061107            When  WrkShr <> HdrRcd.WrkShr  Or  WrkTyp <> HdrRcd.WrkTyp;
050600061106              WrkShr = HdrRcd.WrkShr;
050700061106              WrkTyp = HdrRcd.WrkTyp;
050800061106
050900061107              ExSr  BldShrLst;
051000060729            EndSl;
051100060729
051200061109            Select;
051300061109            When  UIM.FncRqs = RTN_ENTER  And
051400061109                  UIM.EntLocOpt = 'NEXT'  And
051500061109                  HdrRcd.PosShr > *Blanks;
051600061109
051700061109              ExSr  FndLstPos;
051800061109
051900061109            When  UIM.FncRqs = KEY_F17;
052000061109              ExSr  PosLstTop;
052100061109
052200061109            When  UIM.FncRqs = KEY_F18;
052300061109              ExSr  PosLstBot;
052400061109            EndSl;
052500060729
052600060729            ExSr  BldHdrRcd;
052700060729          EndDo;
052800060729
052900060729        EndSr;
053000060729
053100060729        BegSr  WrtLst;
053200060729
053300060729          PrtPnl( UIM.AppHdl
053400060729                : 'PRTHDR'
053500060729                : EJECT_NO
053600060729                : ERRC0100
053700060729                );
053800060729
053900060729          PrtPnl( UIM.AppHdl
054000060729                : 'PRTLST'
054100060729                : EJECT_NO
054200060729                : ERRC0100
054300060729                );
054400060729
054500060729          SndCmpMsg( 'List has been printed.' );
054600060729
054700060729        EndSr;
054800060729
054900061107        BegSr  BldShrLst;
055000060504
055100060504          UIM.EntLocOpt = 'FRST';
055200060505
055300061107          ApiRcvSiz = INZ_ALLOC;
055400061108          pZLSL0101 = %Alloc( ApiRcvSiz );
055500061106
055600061106          DoU  LstInf.RcdNbrTot = LstInf.RcdNbrRtn  Or
055700061106               ERRC0100.BytAvl > *Zero;
055800061106
055900061106            LstSvrInf( ZLSL0101
056000061106                     : ApiRcvSiz
056100061106                     : LstInf
056200061107                     : 'ZLSL0101'
056300061107                     : HdrRcd.WrkShr
056400061106                     : ERRC0100
056500061106                     );
056600061106
056700061106            If  LstInf.RcdNbrTot > LstInf.RcdNbrRtn;
056800061107
056900061107              If  ApiRcvSiz + INC_ALLOC > MAX_ALLOC;
057000061107                Leave;
057100061107              Else;
057200061107                ApiRcvSiz += INC_ALLOC;
057300061107              EndIf;
057400061107
057500061106              pZLSL0101  = %ReAlloc( pZLSL0101: ApiRcvSiz );
057600061106            EndIf;
057700061106          EndDo;
057800061106
057900060729          If  ERRC0100.BytAvl = *Zero;
058000061109            pRtnDta = pZLSL0101;
058100060729
058200061106            For  Idx = 1  to LstInf.RcdNbrTot;
058300060729              ExSr  PrcLstEnt;
058400061106
058500061106              If  Idx < LstInf.RcdNbrTot;
058600061106                pZLSL0101 += ZLSL0101.EntLen;
058700061107              EndIf;
058800060729            EndFor;
058900061109
059000061109            ExSr  PutSrtLst;
059100060729          EndIf;
059200060729
059300060504          SetLstAtr( UIM.AppHdl
059400060504                   : 'DTLLST'
059500060504                   : LIST_COMP
059600060504                   : EXIT_SAME
059700060504                   : POS_TOP
059800060504                   : TRIM_SAME
059900060504                   : ERRC0100
060000060504                   );
060100060504
060200060504        EndSr;
060300060506
060400060504        BegSr  PrcLstEnt;
060500060504
060600061108          If  HdrRcd.WrkTyp = DEV_ALL  Or  HdrRcd.WrkTyp = ZLSL0101.DevTyp;
060700060506
060800060729            LstEnt.Option = *Zero;
060900061108            LstEnt.Share  = ZLSL0101.Share;
061000061108            LstEnt.ShrTyp = ZLSL0101.DevTyp;
061100061108            LstEnt.TxtDsc = ZLSL0101.TxtDsc;
061200061108
061300061108            If  ZLSL0101.DevTyp = DEV_FILE;
061400061108
061500061109              pRcvVar = pRtnDta + ZLSL0101.OfsPthNam;
061600061108              Path = %Subst( RcvVar: 1: ZLSL0101.LenPthNam );
061700061108
061800061108              LstEnt.ShrRsc = Path;
061900061108            Else;
062000061108              LstEnt.ShrRsc = CvtObjPth( ZLSL0101.OutQueNam
062100061108                                       : ZLSL0101.OutQueLib
062200061108                                       : '*OUTQ'
062300061108                                       : *Omit
062400061108                                       : *Off
062500061108                                       );
062600061108            EndIf;
062700060729
062800061109            ExSr  AddSrtLst;
062900060729          EndIf;
063000060504
063100060504        EndSr;
063200060504
063300061109        BegSr  AddSrtLst;
063400061109
063500061109          If  SrtAct = *Off;
063600061109            ExSr  InzSrtLst;
063700061109          EndIf;
063800061109
063900061109          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
064000061109          RqsCtlBlkIo.RcdCnt = 1;
064100061109          RqsCtlBlkIo.RqsTyp = SRT_PUT;
064200061109
064300061109          SortIo( RqsCtlBlkIo
064400061109                : LstEnt
064500061109                : SrtApi.Omit
064600061109                : SrtApi.DtaBufLen
064700061109                : DtaBufInf
064800061109                : ERRC0100
064900061109                );
065000061109
065100061109        EndSr;
065200061109
065300061109        BegSr  PutSrtLst;
065400061109
065500061109          ExSr  EndSrtLst;
065600061109
065700061109          If  DtaBufInf.RcdAvl > *Zero;
065800061109
065900061109            RqsCtlBlkIo.RqsTyp = SRT_GET;
066000061109
066100061109            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
066200061109
066300061109            SortIo( RqsCtlBlkIo
066400061109                  : SrtApi.Omit
066500061109                  : LstEnt
066600061109                  : SrtApi.DtaBufLen
066700061109                  : DtaBufInf
066800061109                  : ERRC0100
066900061109                  );
067000061109
067100061109            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;
067200061109
067300061109              AddLstEnt( UIM.AppHdl
067400061109                       : LstEnt
067500061109                       : %Size( LstEnt )
067600061109                       : 'DTLRCD'
067700061109                       : 'DTLLST'
067800061109                       : UIM.EntLocOpt
067900061109                       : UIM.LstHdl
068000061109                       : ERRC0100
068100061109                       );
068200061109
068300061109              UIM.EntLocOpt = 'NEXT';
068400061109
068500061109              If  DtaBufInf.RcdAvl <= *Zero;
068600061109                Leave;
068700061109              Else;
068800061109
068900061109                SortIo( RqsCtlBlkIo
069000061109                      : SrtApi.Omit
069100061109                      : LstEnt
069200061109                      : SrtApi.DtaBufLen
069300061109                      : DtaBufInf
069400061109                      : ERRC0100
069500061109                      );
069600061109              EndIf;
069700061109            EndDo;
069800061109          EndIf;
069900061109
070000061109        EndSr;
070100061109
070200061109        BegSr  InzSrtLst;
070300061109
070400061109          SrtKeyInfDs.KeySize   = %Size( LstEnt.Share );
070500061109          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
070600061109          SrtKeyInfDs.KeyOrder  = ASCEND;
070700061109          SrtKeyInfDs.KeyStrPos = 1;
070800061109
070900061109          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
071000061109
071100061109          RqsCtlBlk.NlsOfs = KEY_OFS +
071200061109                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
071300061109
071400061109          RqsCtlBlk.BlkLen = KEY_OFS +
071500061109                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
071600061109                             SIZ_NLS_INF;
071700061109
071800061109          RqsCtlBlk.KeyNbr = NBR_KEY;
071900061109
072000061109          InzSort( RqsCtlBlk
072100061109                 : SrtApi.Omit
072200061109                 : SrtApi.Omit
072300061109                 : SrtApi.DtaBufLen
072400061109                 : SrtApi.DtaRtnLen
072500061109                 : ERRC0100
072600061109                 );
072700061109
072800061109          If  ERRC0100.BytAvl = *Zero;
072900061109            SrtAct = *On;
073000061109          EndIf;
073100061109
073200061109        EndSr;
073300061109
073400061109        BegSr  EndSrtLst;
073500061109
073600061109          RqsCtlBlkIo.RqsTyp = SRT_END;
073700061109
073800061109          SortIo( RqsCtlBlkIo
073900061109                : SrtApi.Omit
074000061109                : SrtApi.Omit
074100061109                : SrtApi.DtaBufLen
074200061109                : DtaBufInf
074300061109                : ERRC0100
074400061109                );
074500061109
074600061109          If  ERRC0100.BytAvl = *Zero;
074700061109            SrtAct = *Off;
074800061109          EndIf;
074900061109
075000061109        EndSr;
075100061109
075200060504        BegSr  GetLstPos;
075300060504
075400060504          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
075500060504
075600060504          If  LstAtr.DspPos <> 'TOP';
075700060504
075800060504            GetLstEnt( UIM.AppHdl
075900060504                     : LstEnt
076000060504                     : %Size( LstEnt )
076100060504                     : 'DTLRCD'
076200060504                     : 'DTLLST'
076300060504                     : 'HNDL'
076400060504                     : 'Y'
076500060504                     : *Blanks
076600060504                     : LstAtr.DspPos
076700060504                     : 'N'
076800060504                     : UIM.EntHdl
076900060504                     : ERRC0100
077000060504                     );
077100060504
077200060504            LstEntPos = LstEnt;
077300060504          EndIf;
077400060504
077500060504        EndSr;
077600060504
077700060504        BegSr  SetLstPos;
077800060504
077900060504          If  LstAtr.DspPos <> 'TOP';
078000060504
078100060504            LstEnt = LstEntPos;
078200060504
078300060504            PutDlgVar( UIM.AppHdl
078400060504                     : LstEnt
078500060504                     : %Size( LstEnt )
078600060504                     : 'DTLRCD'
078700060504                     : ERRC0100
078800060504                     );
078900060504
079000060504            GetLstEnt( UIM.AppHdl
079100060504                     : LstEnt
079200060504                     : %Size( LstEnt )
079300060504                     : '*NONE'
079400060504                     : 'DTLLST'
079500060504                     : 'FSLT'
079600060504                     : 'N'
079700061109                     : 'EQ        SHRNAM'
079800060730                     : *Blanks
079900060504                     : 'N'
080000060504                     : UIM.EntHdl
080100060504                     : ERRC0100
080200060504                     );
080300060504
080400060504            If  ERRC0100.BytAvl = *Zero;
080500060504
080600060504              SetLstAtr( UIM.AppHdl
080700060504                       : 'DTLLST'
080800060504                       : LIST_SAME
080900060504                       : EXIT_SAME
081000060504                       : UIM.EntHdl
081100060504                       : TRIM_SAME
081200060504                       : ERRC0100
081300060504                       );
081400060504
081500060504            EndIf;
081600060504          EndIf;
081700060504
081800060504        EndSr;
081900060730
082000060730        BegSr  FndLstPos;
082100060730
082200061106          LstEnt.Share  = HdrRcd.PosShr;
082300060730
082400060730          PutDlgVar( UIM.AppHdl
082500060730                   : LstEnt
082600060730                   : %Size( LstEnt )
082700060730                   : 'DTLRCD'
082800060730                   : ERRC0100
082900060730                   );
083000060730
083100060730          GetLstEnt( UIM.AppHdl
083200060730                   : LstEnt
083300060730                   : %Size( LstEnt )
083400060730                   : 'DTLRCD'
083500060730                   : 'DTLLST'
083600060730                   : 'FSLT'
083700060730                   : 'Y'
083800061109                   : 'GE        SHRNAM'
083900060730                   : *Blanks
084000060730                   : 'N'
084100060730                   : UIM.EntHdl
084200060730                   : ERRC0100
084300060730                   );
084400060730
084500060730          Select;
084600060730          When  ERRC0100.BytAvl > *Zero;
084700060730            GetLstEnt( UIM.AppHdl
084800060730                     : LstEnt
084900060730                     : %Size( LstEnt )
085000060730                     : '*NONE'
085100060730                     : 'DTLLST'
085200060730                     : 'LAST'
085300060730                     : 'N'
085400060730                     : *Blanks
085500060730                     : *Blanks
085600060730                     : 'N'
085700060730                     : UIM.EntHdl
085800060730                     : ERRC0100
085900060730                     );
086000060730
086100061106          When  %Scan( %Trim( HdrRcd.PosShr ): LstEnt.Share ) <> 1;
086200060730            GetLstEnt( UIM.AppHdl
086300060730                     : LstEnt
086400060730                     : %Size( LstEnt )
086500060730                     : '*NONE'
086600060730                     : 'DTLLST'
086700060730                     : 'PREV'
086800060730                     : 'N'
086900060730                     : *Blanks
087000060730                     : *Blanks
087100060730                     : 'N'
087200060730                     : UIM.EntHdl
087300060730                     : ERRC0100
087400060730                     );
087500060730
087600060730            If  ERRC0100.BytAvl > *Zero;
087700060730              GetLstEnt( UIM.AppHdl
087800060730                       : LstEnt
087900060730                       : %Size( LstEnt )
088000060730                       : '*NONE'
088100060730                       : 'DTLLST'
088200060730                       : 'FRST'
088300060730                       : 'N'
088400060730                       : *Blanks
088500060730                       : *Blanks
088600060730                       : 'N'
088700060730                       : UIM.EntHdl
088800060730                       : ERRC0100
088900060730                       );
089000060730            EndIf;
089100060730          EndSl;
089200060730
089300060730          If  ERRC0100.BytAvl = *Zero;
089400060730
089500060730            SetLstAtr( UIM.AppHdl
089600060730                     : 'DTLLST'
089700060730                     : LIST_SAME
089800060730                     : EXIT_SAME
089900060730                     : UIM.EntHdl
090000060730                     : TRIM_SAME
090100060730                     : ERRC0100
090200060730                     );
090300060730
090400060730          EndIf;
090500060730
090600061106          HdrRcd.PosShr = *Blanks;
090700060730
090800060730        EndSr;
090900060504
091000061109        BegSr  PosLstTop;
091100061109
091200061109          SetLstAtr( UIM.AppHdl
091300061109                   : 'DTLLST'
091400061109                   : LIST_SAME
091500061109                   : EXIT_SAME
091600061109                   : POS_TOP
091700061109                   : TRIM_SAME
091800061109                   : ERRC0100
091900061109                   );
092000061109
092100061109        EndSr;
092200061109
092300061109        BegSr  PosLstBot;
092400061109
092500061109          SetLstAtr( UIM.AppHdl
092600061109                   : 'DTLLST'
092700061109                   : LIST_SAME
092800061109                   : EXIT_SAME
092900061109                   : POS_BOT
093000061109                   : TRIM_SAME
093100061109                   : ERRC0100
093200061109                   );
093300061109
093400061109        EndSr;
093500061109
093600060504        BegSr  BldHdrRcd;
093700060504
093800060504          SysDts = %Timestamp();
093900060504
094000060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
094100060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
094200060511          HdrRcd.TimZon = '*SYS';
094300060504
094400060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
094500060504
094600060504        EndSr;
094700060729
094800060730        BegSr  RstHdrRcd;
094900060730
095000061106          HdrRcd.WrkShr = WrkShr;
095100061106          HdrRcd.WrkTyp = WrkTyp;
095200061106          HdrRcd.PosShr = *Blanks;
095300060730
095400060730        EndSr;
095500060730
095600060729        BegSr  *InzSr;
095700060729
095800061106          HdrRcd.WrkShr = PxShare;
095900061106          HdrRcd.WrkTyp = PxType;
096000061106          HdrRcd.PosShr = *Blanks;
096100060729
096200061106          WrkShr = HdrRcd.WrkShr;
096300061109          WrkTyp = HdrRcd.WrkTyp;
096400060729
096500060729        EndSr;
096600060504
096700060504        BegSr  DltUsrLst;
096800060504
096900060504          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
097000060504
097100060504        EndSr;
097200060519
097300100319        BegSr  EscApiErr;
097400100319
097500100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
097600100319            ERRC0100.BytAvl = OFS_MSGDTA;
097700100319          EndIf;
097800100319
097900100319          SndEscMsg( ERRC0100.MsgId
098000100319                   : 'QCPFMSG'
098100100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
098200100319                   );
098300100319
098400100319        EndSr;
098500100319
098600050226      /End-Free
098700060428
098800060729     **-- Get job type:
098900060729     P GetJobTyp       B
099000060729     D                 Pi             1a
099100060729
099200060729     D JOBI0400        Ds                  Qualified
099300060729     D  BytRtn                       10i 0
099400060729     D  BytAvl                       10i 0
099500060729     D  JobNam                       10a
099600060729     D  UsrNam                       10a
099700060729     D  JobNbr                        6a
099800060729     D  JobIntId                     16a
099900060729     D  JobSts                       10a
100000060729     D  JobTyp                        1a
100100060729     D  JobSubTyp                     1a
100200060729
100300060729      /Free
100400060729
100500060729        RtvJobInf( JOBI0400
100600060729                 : %Size( JOBI0400 )
100700060729                 : 'JOBI0400'
100800060729                 : '*'
100900060729                 : *Blank
101000060729                 : ERRC0100
101100060729                 );
101200060729
101300060729        If  ERRC0100.BytAvl > *Zero;
101400060729          Return  *Blank;
101500060729
101600060729        Else;
101700060729          Return  JOBI0400.JobTyp;
101800060729        EndIf;
101900060729
102000060729      /End-Free
102100060729
102200060729     P GetJobTyp       E
102300061108     **-- Get object library:
102400061108     P GetObjLib       B
102500061108     D                 Pi            10a   Varying
102600061108     D  PxObjNam                     10a   Const
102700061108     D  PxObjLib                     10a   Const
102800061108     D  PxObjTyp                     10a   Const
102900061108     **
103000061108     D OBJD0100        Ds                  Qualified
103100061108     D  BytRtn                       10i 0
103200061108     D  BytAvl                       10i 0
103300061108     D  ObjNam                       10a
103400061108     D  ObjLib                       10a
103500061108     D  ObjTyp                       10a
103600061108     D  ObjLibRtn                    10a
103700061108     D  ObjASP                       10i 0
103800061108     D  ObjOwn                       10a
103900061108     D  ObjDmn                        2a
104000061108
104100061108      /Free
104200061108
104300061108         RtvObjD( OBJD0100
104400061108                : %Size( OBJD0100 )
104500061108                : 'OBJD0100'
104600061108                : PxObjNam + PxObjLib
104700061108                : PxObjTyp
104800061108                : ERRC0100
104900061108                );
105000061108
105100061108         If  ERRC0100.BytAvl > *Zero;
105200061108           Return  *Blanks;
105300061108
105400061108         Else;
105500061108           Return  %Trim( OBJD0100.ObjLibRtn );
105600061108         EndIf;
105700061108
105800061108      /End-Free
105900061108
106000061108     P GetObjLib       E
106100061108     **-- Convert object to path:
106200061108     P CvtObjPth       B                   Export
106300061108     D                 Pi          1024a   Varying
106400061108     D  PxObjNam                     10a   Value  Varying  Options( *Trim )
106500061108     D  PxObjLib                     10a   Value  Varying  Options( *Trim )
106600061108     D  PxObjTyp                     10a   Value  Varying  Options( *Trim )
106700061108     D  PxFilMbr                     10a   Const  Varying
106800061108     D                                            Options( *Trim: *Omit )
106900061108     D  PxRslLib                       n   Const  Options( *Omit )
107000061108     **-- Local variables:
107100061108     D Path            s           1024a   Varying
107200061108
107300061108      /Free
107400061108
107500061108        If  %Addr( PxRslLib ) <> *Null  And  PxRslLib = *On;
107600061108
107700061108          If  PxObjLib = '*LIBL';
107800061108            PxObjLib = GetObjLib( PxObjNam: PxObjLib: PxObjTyp );
107900061108          EndIf;
108000061108        EndIf;
108100061108
108200061108        If  PxObjLib = 'QSYS';
108300061108          Path = '/';
108400061108        Else;
108500061108          Path = '/QSYS.LIB/';
108600061108        EndIf;
108700061108
108800061108        Path += PxObjLib + '.LIB/' + PxObjNam + '.' +  %Subst( PxObjTyp: 2 );
108900061108
109000061108        If  %Addr( PxFilMbr ) <> *Null;
109100061108          Path += '/' + PxFilMbr + '.MBR';
109200061108        EndIf;
109300061108
109400061108        Return  Path;
109500061108
109600061108      /End-Free
109700061108
109800061108     P CvtObjPth       E
109900060729     **-- Send completion message:
110000060729     P SndCmpMsg       B
110100060729     D                 Pi            10i 0
110200060729     D  PxMsgDta                    512a   Const  Varying
110300060729     **
110400060729     D MsgKey          s              4a
110500060729
110600060729      /Free
110700060729
110800060729        SndPgmMsg( 'CPF9897'
110900060729                 : 'QCPFMSG   *LIBL'
111000060729                 : PxMsgDta
111100060729                 : %Len( PxMsgDta )
111200060729                 : '*COMP'
111300060729                 : '*PGMBDY'
111400060729                 : 1
111500060729                 : MsgKey
111600060729                 : ERRC0100
111700060729                 );
111800060729
111900060729        If  ERRC0100.BytAvl > *Zero;
112000060729          Return  -1;
112100060729
112200060729        Else;
112300060729          Return  0;
112400060729
112500060729        EndIf;
112600060729
112700060729      /End-Free
112800060729
112900060729     P SndCmpMsg       E
113000060504     **-- Send escape message:
113100060504     P SndEscMsg       B
113200060504     D                 Pi            10i 0
113300060504     D  PxMsgId                       7a   Const
113400060504     D  PxMsgF                       10a   Const
113500060504     D  PxMsgDta                    512a   Const  Varying
113600060504     **
113700060504     D MsgKey          s              4a
113800060504
113900060504      /Free
114000060504
114100060504        SndPgmMsg( PxMsgId
114200060504                 : PxMsgF + '*LIBL'
114300060504                 : PxMsgDta
114400060504                 : %Len( PxMsgDta )
114500060504                 : '*ESCAPE'
114600060504                 : '*PGMBDY'
114700060504                 : 1
114800060504                 : MsgKey
114900060504                 : ERRC0100
115000060504                 );
115100060504
115200060504        If  ERRC0100.BytAvl > *Zero;
115300060504          Return  -1;
115400060504
115500060504        Else;
115600060504          Return   0;
115700060504        EndIf;
115800060504
115900060504      /End-Free
116000060504
116100060504     P SndEscMsg       E
