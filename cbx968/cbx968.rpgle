000100060518     **
000200070123     **  Program . . : CBX968
000300061114     **  Description : Display Job Queue Jobs - CPP
000400060518     **  Author  . . : Carsten Flensburg
000500070211     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060518     **
000700060518     **
000800050310     **
000900070123     **    CrtRpgMod   Module( CBX968 )
001000050310     **                DbgView( *LIST )
001100050310     **
001200070123     **    CrtPgm      Pgm( CBX968 )
001300070123     **                Module( CBX968 )
001400060430     **                ActGrp( *NEW )
001500050310     **
001600070225     **
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
003000060424     **
003100060424     D BIN_SGN         c                   0
003200060509     D NUM_ZON         c                   2
003300060424     D CHAR_NLS        c                   4
003400060509     D SORT_ASC        c                   '1'
003500060501     **-- UIM constants:
003600070123     D PNLGRP_Q        c                   'CBX968P   *LIBL     '
003700070123     D PNLGRP          c                   'CBX968P   '
003800060501     D SCP_AUT_RCL     c                   -1
003900060501     D RDS_OPT_INZ     c                   'N'
004000060501     D PRM_IFC_0       c                   0
004100060501     D CLO_NORM        c                   'M'
004200060501     D FNC_EXIT        c                   -4
004300060501     D FNC_CNL         c                   -8
004400060501     D KEY_F05         c                   5
004500060705     D KEY_F17         c                   17
004600060705     D KEY_F18         c                   18
004700060506     D RTN_ENTER       c                   500
004800060501     D HLP_WDW         c                   'N'
004900060501     D POS_TOP         c                   'TOP'
005000060501     D POS_BOT         c                   'BOT'
005100060501     D LIST_COMP       c                   'ALL'
005200060501     D LIST_SAME       c                   'SAME'
005300060501     D EXIT_SAME       c                   '*SAME'
005400060501     D TRIM_SAME       c                   'S'
005500060501
005600060424     **-- Global variables:
005700060501     D SysDts          s               z
005800060424     D KeyDtaVal       s             32a
005900060424     D Idx             s             10i 0
006000060430     **
006100060430     D ObjNam_q        Ds
006200060430     D  ObjNam                       10a
006300060430     D  ObjLib                       10a
006400060501
006500060501     **-- UIM variables:
006600060501     D UIM             Ds                  Qualified
006700060501     D  AppHdl                        8a
006800060501     D  LstHdl                        4a
006900060501     D  EntHdl                        4a
007000060501     D  FncRqs                       10i 0
007100060501     D  EntLocOpt                     4a
007200060501     D  LstPos                        4a
007300060501     **-- List attributes structure:
007400060501     D LstAtr          Ds                  Qualified
007500060501     D  LstCon                        4a
007600060501     D  ExtPgmVar                    10a
007700060501     D  DspPos                        4a
007800060501     D  AlwTrim                       1a
007900060505
008000060516     **-- UIM Panel exit program record:
008100060511     D ExpRcd          Ds                  Qualified
008200070123     D  ExitPg                       20a   Inz( 'CBX968E   *LIBL' )
008300060511     **-- UIM Panel header record:
008400060511     D HdrRcd          Ds                  Qualified
008500060501     D  SysDat                        7a
008600060501     D  SysTim                        6a
008700060501     D  TimZon                       10a
008800060501     D  JobQue                       10a
008900060501     D  JobQueLib                    10a
009000060501     D  JobQueSts                     1a
009100060501     D  ActSbs                       10a
009200060501     **-- UIM List entry:
009300060501     D LstEnt          Ds                  Qualified
009400070123     D  Option                        5i 0
009500060501     D  JobId                        26a
009600060501     D  JobNam                       10a
009700060501     D  JobUsr                       10a
009800060501     D  JobNbr                        6s 0
009900060516     D  JobTyp                        1a
010000060501     D  JobSts1                       7a
010100060501     D  JobSts2                       7a
010200060501     D  JobPty                        2a
010300060502     D  EntDat                        7a
010400060502     D  EntTim                        6a
010500060501     D  CurUsr                       10a
010600060501     D  SbmJob                       10a
010700060501     D  SbmUsr                       10a
010800060501     D  SbmNbr                        6s 0
010900131107     D  MsgRpy                        1a
011000131107     D  MsgQue_q                     20a
011100131107     D   MsgQueNam                   10a   Overlay( MsgQue_q:  1 )
011200131107     D   MsgQueLib                   10a   Overlay( MsgQue_q: 11 )
011300131107     D  MsgKey                        4a
011400060501     **
011500060501     D LstEntPos       Ds                  LikeDs( LstEnt )
011600060501
011700060424     **-- List API parameters:
011800060424     D LstApi          Ds                  Qualified  Inz
011900060424     D  RtnRcdNbr                    10i 0 Inz( 1 )
012000060424     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
012100131107     D  KeyFld                       10i 0 Dim( 13 )
012200060411
012300060424     **-- Job queue information:
012400060430     D OJBQ0100        Ds                  Qualified  Inz
012500060430     D  JobQue                       10a
012600060430     D  JobQueLib                    10a
012700060430     D  JobQueSts                     1a
012800060430     D  ActSbs                       10a
012900060430     D  ActSbsLib                    10a
013000060424     D                                3a
013100060424     D  NbrJobOnQue                  10i 0
013200060424     D  SeqNbr                       10i 0
013300060424     D  MaxAct                       10i 0
013400060424     D  CurAct                       10i 0
013500060424     D  QueDsc                       50a
013600060424     **-- Filter information:
013700060424     D FltInf          Ds                  Qualified
013800060424     D  FltInfLen                    10i 0 Inz( %Size( FltInf ))
013900060430     D  JobQue_q                     20a
014000060430     D   JobQue                      10a   Overlay( JobQue_q:  1 )
014100060430     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
014200060430     D  ActSbs                       10a
014300000906     **-- Job information:
014400060411     D OLJB0200        Ds           512    Qualified
014500060501     D  JobId                        26a
014600060501     D  JobNam                       10a   Overlay( JobId:  1 )
014700060501     D  UsrPrf                       10a   Overlay( JobId: 11 )
014800060501     D  JobNbr                        6s 0 Overlay( JobId: 21 )
014900050226     D  JobIdInt                     16a
015000050226     D  Status                       10a
015100050226     D  JobTyp                        1a
015200050226     D  JobSubTyp                     1a
015300000427     D                                2a
015400060411     D  JobInfSts                     1a
015500060411     D                                3a
015600060523     D  Data                        128a
015700060501     **-- Job information key fields:
015800060501     D KeyDta          Ds                  Qualified
015900060501     D  JobQue_q                     20a
016000060501     D  JobPty                        2a
016100060501     D  SbsNam_q                     20a
016200060501     D  ActJobSts                     4a
016300060501     D  CurUsr                       10a
016400060502     D  JobEntDts                    13a
016500060502     D   JobEntDat                    7a   Overlay( JobEntDts: 1 )
016600060502     D   JobEntTim                    6a   Overlay( JobEntDts: 8 )
016700060501     D  JobTypE                      10i 0
016800060501     D  RunPty                       10i 0
016900060501     D  JobQueSts                    10a
017000060501     D  SbmJob_q                     26a
017100060501     D   SbmJobNam                   10a   Overlay( SbmJob_q:  1 )
017200060501     D   SbmJobUsr                   10a   Overlay( SbmJob_q: 11 )
017300060501     D   SbmJobNbr                    6s 0 Overlay( SbmJob_q: 21 )
017400131107     D  MsgRpy                        1a
017500131107     D  MsgQue_q                     20a
017600131107     D  MsgKey                        4a
017700060411     **-- Key information:
017800060411     D KeyInf          Ds                  Qualified
017900060411     D  FldNbrRtn                    10i 0
018000060424     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
018100060411     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
018200060411     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
018300060411     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
018400060411     D                                3a   Overlay( KeyStr: 10 )
018500060411     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
018600060411     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
018700000906     **-- Sort information:
018800050226     D SrtInf          Ds                  Qualified
018900060430     D  NbrKeys                      10i 0 Inz( 0 )
019000060510     D  SrtStr                       12a   Dim( 4 )
019100050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
019200050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
019300050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
019400050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
019500060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
019600000906     **-- List information:
019700050226     D LstInf          Ds                  Qualified
019800050226     D  RcdNbrTot                    10i 0
019900050226     D  RcdNbrRtn                    10i 0
020000050226     D  Handle                        4a
020100050226     D  RcdLen                       10i 0
020200050226     D  InfSts                        1a
020300050226     D  Dts                          13a
020400050226     D  LstSts                        1a
020500990920     D                                1a
020600050226     D  InfLen                       10i 0
020700050226     D  Rcd1                         10i 0
020800990920     D                               40a
020900060424     **-- Selection information:
021000060424     D OLJS0200        Ds                  Qualified
021100060424     D  JobNam                       10a   Inz( '*ALL' )
021200060509     D  UsrPrf                       10a   Inz( '*ALL' )
021300060424     D  JobNbr                        6a   Inz( '*ALL' )
021400060516     D  JobTyp                        1a   Inz( '*' )
021500060424     D                                1a
021600060424     D  OfsPriSts                    10i 0 Inz( 108 )
021700060424     D  NbrPriSts                    10i 0 Inz( 2 )
021800060424     D  OfsActSts                    10i 0 Inz( 128 )
021900060424     D  NbrActSts                    10i 0 Inz( 0 )
022000060424     D  OfsJbqSts                    10i 0 Inz( 136 )
022100060424     D  NbrJbqSts                    10i 0 Inz( 0 )
022200060424     D  OfsJbqNam                    10i 0 Inz( 146 )
022300060425     D  NbrJbqNam                    10i 0 Inz( 1 )
022400060424     D  OfsCurUsr                    10i 0 Inz( 166 )
022500060424     D  NbrCurUsr                    10i 0 Inz( 0 )
022600060424     D  OfsSvrTyp                    10i 0 Inz( 176 )
022700060424     D  NbrSvrTyp                    10i 0 Inz( 0 )
022800060424     D  OfsActSbs                    10i 0 Inz( 206 )
022900060424     D  NbrActSbs                    10i 0 Inz( 0 )
023000060424     D  OfsMemPool                   10i 0 Inz( 216 )
023100060424     D  NbrMemPool                   10i 0 Inz( 0 )
023200060424     D  OfsJobTypE                   10i 0 Inz( 220 )
023300060516     D  NbrJobTypE                   10i 0 Inz( 0 )
023400060424     D  OfsJobNamQ                   10i 0 Inz( 228 )
023500060424     D  NbrJobNamQ                   10i 0 Inz( 0 )
023600060424     **
023700060424     D  PriSts                       10a   Dim( 2 )
023800060424     D  ActSts                        4a   Dim( 2 )
023900060424     D  JbqSts                       10a   Dim( 1 )
024000060424     D  JbqNam                       20a   Dim( 1 )
024100060424     D  CurUsr                       10a   Dim( 1 )
024200060424     D  SvrTyp                       30a   Dim( 1 )
024300060424     D  ActSbs                       10a   Dim( 1 )
024400060424     D  MemPool                      10i 0 Dim( 1 )
024500060424     D  JobTypE                      10i 0 Dim( 1 )
024600060424     D  JobNamQ                      26a   Dim( 1 )
024700060411
024800060424     **-- Open list of job queues:
024900060424     D LstJobQs        Pr                  ExtPgm( 'QSPOLJBQ' )
025000060424     D  RcvVar                    65535a          Options( *VarSize )
025100060424     D  RcvVarLen                    10i 0 Const
025200060424     D  FmtNam                        8a   Const
025300060424     D  LstInf                       80a
025400060424     D  FltInf                       32a   Const  Options( *VarSize )
025500060424     D  SrtInf                     1024a   Const  Options( *VarSize )
025600060424     D  NbrRcdRtn                    10i 0 Const
025700060424     D  Error                      1024a          Options( *VarSize )
025800050226     **-- Open list of jobs:
025900030608     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
026000060411     D  RcvVar                    65535a          Options( *VarSize )
026100060411     D  RcvVarLen                    10i 0 Const
026200060411     D  FmtNam                        8a   Const
026300060411     D  RcvVarDfn                 65535a          Options( *VarSize )
026400060411     D  RcvDfnLen                    10i 0 Const
026500060411     D  LstInf                       80a
026600060411     D  NbrRcdRtn                    10i 0 Const
026700060411     D  SrtInf                     1024a   Const  Options( *VarSize )
026800060411     D  JobSltInf                  1024a   Const  Options( *VarSize )
026900060411     D  JobSltLen                    10i 0 Const
027000060411     D  NbrFldRtn                    10i 0 Const
027100060411     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
027200060411     D  Error                      1024a          Options( *VarSize )
027300060411     D  JobSltFmt                     8a   Const  Options( *NoPass )
027400060411     D  ResStc                        1a   Const  Options( *NoPass )
027500060411     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
027600060411     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
027700060501     **-- Get open list entry:
027800060501     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
027900060423     D  RcvVar                    65535a          Options( *VarSize )
028000060423     D  RcvVarLen                    10i 0 Const
028100060423     D  Handle                        4a   Const
028200060423     D  LstInf                       80a
028300060423     D  NbrRcdRtn                    10i 0 Const
028400060423     D  RtnRcdNbr                    10i 0 Const
028500060423     D  Error                      1024a          Options( *VarSize )
028600050226     **-- Close list:
028700050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
028800060411     D  Handle                        4a   Const
028900060411     D  Error                      1024a          Options( *VarSize )
029000060430     **-- Retrieve object description:
029100060430     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
029200060430     D  RcvVar                    32767a          Options( *VarSize )
029300060430     D  RcvVarLen                    10i 0 Const
029400060430     D  FmtNam                        8a   Const
029500060430     D  ObjNamQ                      20a   Const
029600060430     D  ObjTyp                       10a   Const
029700060430     D  Error                     32767a          Options( *VarSize )
029800060423     **-- Copy memory:
029900060423     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
030000060423     D  MemOut                         *   Value
030100060423     D  MemInp                         *   Value
030200060423     D  MemSiz                       10u 0 Value
030300060501     **-- Send program message:
030400060501     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
030500060501     D  MsgId                         7a   Const
030600060501     D  MsgFq                        20a   Const
030700060501     D  MsgDta                      128a   Const
030800060501     D  MsgDtaLen                    10i 0 Const
030900060501     D  MsgTyp                       10a   Const
031000060501     D  CalStkE                      10a   Const  Options( *VarSize )
031100060501     D  CalStkCtr                    10i 0 Const
031200060501     D  MsgKey                        4a
031300060501     D  Error                     32767a          Options( *VarSize )
031400060501
031500060501     **-- Open display application:
031600060501     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
031700060501     D  AppHdl                        8a
031800060501     D  PnlGrp_q                     20a   Const
031900060501     D  AppScp                       10i 0 Const
032000060501     D  ExtPrmIfc                    10i 0 Const
032100060501     D  FulScrHlp                     1a   Const
032200060501     D  Error                     32767a          Options( *VarSize )
032300060501     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
032400060501     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
032500060501     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
032600060501     **-- Display panel:
032700060501     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
032800060501     D  AppHdl                        8a   Const
032900060501     D  FncRqs                       10i 0
033000060501     D  PnlNam                       10a   Const
033100060501     D  ReDspOpt                      1a   Const
033200060501     D  Error                     32767a          Options( *VarSize )
033300060501     D  UsrTsk                        1a   Const  Options( *NoPass )
033400060501     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
033500060501     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
033600060501     D  MsgKey                        4a   Const  Options( *NoPass )
033700060501     D  CsrPosOpt                     1a   Const  Options( *NoPass )
033800060501     D  FinLstEnt                     4a   Const  Options( *NoPass )
033900060501     D  ErrLstEnt                     4a   Const  Options( *NoPass )
034000060501     D  WaitTim                      10i 0 Const  Options( *NoPass )
034100060501     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
034200060501     D  CalQlf                       20a   Const  Options( *NoPass )
034300060501     **-- Put dialog variable:
034400060501     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
034500060501     D  AppHdl                        8a   Const
034600060501     D  VarBuf                    32767a   Const  Options( *VarSize )
034700060501     D  VarBufLen                    10i 0 Const
034800060501     D  VarRcdNam                    10a   Const
034900060501     D  Error                     32767a          Options( *VarSize )
035000060501     **-- Get dialog variable:
035100060501     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
035200060501     D  AppHdl                        8a   Const
035300060501     D  VarBuf                    32767a          Options( *VarSize )
035400060501     D  VarBufLen                    10i 0 Const
035500060501     D  VarRcdNam                    10a   Const
035600060501     D  Error                     32767a          Options( *VarSize )
035700060501     **-- Add list entry:
035800060501     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
035900060501     D  AppHdl                        8a   Const
036000060501     D  VarBuf                    32767a   Const  Options( *VarSize )
036100060501     D  VarBufLen                    10i 0 Const
036200060501     D  VarRcdNam                    10a   Const
036300060501     D  LstNam                       10a   Const
036400060501     D  EntLocOpt                     4a   Const
036500060501     D  LstEntHdl                     4a
036600060501     D  Error                     32767a          Options( *VarSize )
036700060501     **-- Get list entry:
036800060501     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
036900060501     D  AppHdl                        8a   Const
037000060501     D  VarBuf                    32767a   Const  Options( *VarSize )
037100060501     D  VarBufLen                    10i 0 Const
037200060501     D  VarRcdNam                    10a   Const
037300060501     D  LstNam                       10a   Const
037400060501     D  PosOpt                        4a   Const
037500060501     D  CpyOpt                        1a   Const
037600060501     D  SltCri                       20a   Const
037700060501     D  SltHdl                        4a   Const
037800060501     D  ExtOpt                        1a   Const
037900060501     D  LstEntHdl                     4a
038000060501     D  Error                     32767a          Options( *VarSize )
038100060501     **-- Retrieve list attributes:
038200060501     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
038300060501     D  AppHdl                        8a   Const
038400060501     D  LstNam                       10a   Const
038500060501     D  AtrRcv                    32767a          Options( *VarSize )
038600060501     D  AtrRcvLen                    10i 0 Const
038700060501     D  Error                     32767a          Options( *VarSize )
038800060501     **-- Set list attributes:
038900060501     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
039000060501     D  AppHdl                        8a   Const
039100060501     D  LstNam                       10a   Const
039200060501     D  LstCon                        4a   Const
039300060501     D  ExtPgmVar                    10a   Const
039400060501     D  DspPos                        4a   Const
039500060501     D  AlwTrim                       1a   Const
039600060501     D  Error                     32767a          Options( *VarSize )
039700060501     **-- Delete list:
039800060501     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
039900060501     D  AppHdl                        8a   Const
040000060501     D  LstNam                       10a   Const
040100060501     D  Error                     32767a          Options( *VarSize )
040200060501     **-- Close application:
040300060501     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
040400060501     D  AppHdl                        8a   Const
040500060501     D  CloOpt                        1a   Const
040600060501     D  Error                     32767a          Options( *VarSize )
040700060430
040800060430     **-- Get object library:
040900060430     D GetObjLib       Pr            10a
041000060430     D  PxObjNam_q                   20a   Const
041100060430     D  PxObjTyp                     10a   Const
041200060501     **-- Send escape message:
041300060501     D SndEscMsg       Pr            10i 0
041400060501     D  PxMsgId                       7a   Const
041500060501     D  PxMsgF                       10a   Const
041600060501     D  PxMsgDta                    512a   Const  Varying
041700050226
041800070123     D CBX968          Pr
041900060430     D  PxJobQue_q                         LikeDs( ObjNam_q )
042000050226     **
042100070123     D CBX968          Pi
042200060430     D  PxJobQue_q                         LikeDs( ObjNam_q )
042300050226
042400050226      /Free
042500060501
042600060501        OpnDspApp( UIM.AppHdl
042700060501                 : PNLGRP_Q
042800060501                 : SCP_AUT_RCL
042900060501                 : PRM_IFC_0
043000060501                 : HLP_WDW
043100060501                 : ERRC0100
043200060501                 );
043300060501
043400060501        If  ERRC0100.BytAvl > *Zero;
043500100319          ExSr  EscApiErr;
043600060501        EndIf;
043700060501
043800060511        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
043900060501
044000060501        ExSr  BldHdrRcd;
044100060430        ExSr  BldJobLst;
044200050226
044300060501        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
044400060501
044500060501          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
044600060501
044700060705          Select;
044800100319          When  ERRC0100.BytAvl > *Zero;
044900100319            ExSr  EscApiErr;
045000100319
045100060705          When  UIM.FncRqs = RTN_ENTER;
045200060506            Leave;
045300060705
045400060705          When  UIM.FncRqs = KEY_F17;
045500060705            ExSr  PosLstTop;
045600060506
045700060705          When  UIM.FncRqs = KEY_F18;
045800060705            ExSr  PosLstBot;
045900060705          EndSl;
046000060705
046100060511          GetDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
046200060501
046300060501          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
046400060501            ExSr  GetLstPos;
046500060501            ExSr  DltUsrLst;
046600060501          EndIf;
046700060501
046800060501          If  UIM.FncRqs = KEY_F05;
046900060501            ExSr  BldJobLst;
047000060501            ExSr  SetLstPos;
047100060501          EndIf;
047200060501
047300060501          ExSr  BldHdrRcd;
047400060501        EndDo;
047500060501
047600060501        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
047700060501
047800050226        *InLr = *On;
047900050226        Return;
048000060501
048100060424
048200060430        BegSr  BldJobLst;
048300060424
048400060503          ExSr  InzApiPrm;
048500060501
048600060501          UIM.EntLocOpt = 'FRST';
048700060501          LstApi.RtnRcdNbr = 1;
048800060429
048900060424          LstJobs( OLJB0200
049000060424                 : %Size( OLJB0200 )
049100060424                 : 'OLJB0200'
049200060424                 : KeyInf
049300060424                 : %Size( KeyInf )
049400060424                 : LstInf
049500060424                 : -1
049600060424                 : SrtInf
049700060424                 : OLJS0200
049800060424                 : %Size( OLJS0200 )
049900060424                 : LstApi.NbrFldRtn
050000060424                 : LstApi.KeyFld
050100060424                 : ERRC0100
050200060424                 : 'OLJS0200'
050300060424                 );
050400060424
050500060503          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrTot > *Zero;
050600060424
050700060501            ExSr  PrcLstEnt;
050800060424
050900060424            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
051000060424              LstApi.RtnRcdNbr += 1;
051100060424
051200060501              GetOplEnt( OLJB0200
051300060424                       : %Size( OLJB0200 )
051400060424                       : LstInf.Handle
051500060424                       : LstInf
051600060424                       : 1
051700060424                       : LstApi.RtnRcdNbr
051800060424                       : ERRC0100
051900060424                       );
052000060424
052100060424              If  ERRC0100.BytAvl > *Zero;
052200060424                Leave;
052300060424              EndIf;
052400060424
052500060501              ExSr  PrcLstEnt;
052600060424            EndDo;
052700060424          EndIf;
052800060424
052900060424          CloseLst( LstInf.Handle: ERRC0100 );
053000060501
053100060501          SetLstAtr( UIM.AppHdl
053200060501                   : 'DTLLST'
053300060501                   : LIST_COMP
053400060501                   : EXIT_SAME
053500060501                   : POS_TOP
053600060501                   : TRIM_SAME
053700060501                   : ERRC0100
053800060501                   );
053900060424
054000060424        EndSr;
054100060429
054200060501        BegSr  PrcLstEnt;
054300060423
054400060423          Clear  KeyDta;
054500060423
054600060423          For Idx = 1  To KeyInf.FldNbrRtn;
054700060423
054800060423            KeyDtaVal = %SubSt( OLJB0200
054900060423                              : KeyInf.DtaOfs(Idx) + 1
055000060423                              : KeyInf.DtaLen(Idx)
055100060423                              );
055200060423
055300060423            Select;
055400060423            When  KeyInf.KeyFld(Idx) = 101;
055500060423              KeyDta.ActJobSts = KeyDtaVal;
055600060423
055700060423            When  KeyInf.KeyFld(Idx) = 305;
055800060424              KeyDta.CurUsr = KeyDtaVal;
055900060423
056000060502            When  KeyInf.KeyFld(Idx) = 402;
056100060502              KeyDta.JobEntDts = KeyDtaVal;
056200060423
056300060423            When  KeyInf.KeyFld(Idx) = 1004;
056400060423              KeyDta.JobQue_q = KeyDtaVal;
056500060423
056600060423            When  KeyInf.KeyFld(Idx) = 1005;
056700060423              KeyDta.JobPty = KeyDtaVal;
056800060423
056900131107            When  KeyInf.KeyFld(Idx) = 1307;
057000131107              KeyDta.MsgRpy = KeyDtaVal;
057100131107
057200131107            When  KeyInf.KeyFld(Idx) = 1308;
057300131107              KeyDta.MsgKey = KeyDtaVal;
057400131107
057500131107            When  KeyInf.KeyFld(Idx) = 1309;
057600131107              KeyDta.MsgQue_q = KeyDtaVal;
057700131107
057800060424            When  KeyInf.KeyFld(Idx) = 1016;
057900060424              memcpy( %Addr( KeyDta.JobTypE )
058000060424                    : %Addr( KeyDtaVal )
058100060424                    : %Size( KeyDta.JobTypE )
058200060424                    );
058300060424
058400060423            When  KeyInf.KeyFld(Idx) = 1802;
058500060423              memcpy( %Addr( KeyDta.RunPty )
058600060423                    : %Addr( KeyDtaVal )
058700060423                    : %Size( KeyDta.RunPty )
058800060423                    );
058900060423
059000060423            When  KeyInf.KeyFld(Idx) = 1903;
059100060423              KeyDta.JobQueSts = KeyDtaVal;
059200060423
059300060423            When  KeyInf.KeyFld(Idx) = 1904;
059400060423              KeyDta.SbmJob_q = KeyDtaVal;
059500060423
059600060423            When  KeyInf.KeyFld(Idx) = 1906;
059700060423              KeyDta.SbsNam_q = KeyDtaVal;
059800060423            EndSl;
059900060428
060000060428            If  KeyDta.JobQue_q > *Blanks  And  KeyDta.JobQue_q <> PxJobQue_q;
060100060428              Leave;
060200060428            EndIf;
060300060423          EndFor;
060400060423
060500060428          If  KeyDta.JobQue_q = PxJobQue_q;
060600060501            ExSr  PutLstEnt;
060700060428          EndIf;
060800060428
060900060423        EndSr;
061000060423
061100060501        BegSr  PutLstEnt;
061200060501
061300070123          LstEnt.Option = *Zero;
061400060501          LstEnt.JobId  = OLJB0200.JobId;
061500060501          LstEnt.JobNam = OLJB0200.JobNam;
061600060501          LstEnt.JobUsr = OLJB0200.UsrPrf;
061700060501          LstEnt.JobNbr = OLJB0200.JobNbr;
061800060516          LstEnt.JobTyp = OLJB0200.JobTyp;
061900060501          LstEnt.JobSts1 = OLJB0200.Status;
062000060501
062100060501          LstEnt.JobPty = KeyDta.JobPty;
062200060502          LstEnt.EntDat = KeyDta.JobEntDat;
062300060502          LstEnt.EntTim = KeyDta.JobEntTim;
062400060501          LstEnt.SbmJob = KeyDta.SbmJobNam;
062500060501          LstEnt.SbmUsr = KeyDta.SbmJobUsr;
062600060501          LstEnt.SbmNbr = KeyDta.SbmJobNbr;
062700131107          LstEnt.MsgRpy = KeyDta.MsgRpy;
062800131107          LstEnt.MsgKey = KeyDta.MsgKey;
062900131107          LstEnt.MsgQue_q = KeyDta.MsgQue_q;
063000060516
063100060516          Select;
063200060516          When  OLJB0200.Status = '*ACTIVE';
063300060516            LstEnt.CurUsr = KeyDta.CurUsr;
063400060516            LstEnt.JobSts2 = KeyDta.ActJobSts;
063500060516
063600060516          When  OLJB0200.Status = '*JOBQ';
063700060516            LstEnt.CurUsr = OLJB0200.UsrPrf;
063800060516            LstEnt.JobSts2 = KeyDta.JobQueSts;
063900060516
064000060516          Other;
064100060516            LstEnt.CurUsr = OLJB0200.UsrPrf;
064200060516            LstEnt.JobSts2 = *Blanks;
064300060516          EndSl;
064400060501
064500060501          AddLstEnt( UIM.AppHdl
064600060501                   : LstEnt
064700060501                   : %Size( LstEnt )
064800060501                   : 'DTLRCD'
064900060501                   : 'DTLLST'
065000060501                   : UIM.EntLocOpt
065100060501                   : UIM.LstHdl
065200060501                   : ERRC0100
065300060501                   );
065400060501
065500060501          UIM.EntLocOpt = 'NEXT';
065600060501
065700060501        EndSr;
065800060501
065900060501        BegSr  GetLstPos;
066000060501
066100060501          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
066200060501
066300060501          If  LstAtr.DspPos <> 'TOP';
066400060501
066500060501            GetLstEnt( UIM.AppHdl
066600060501                     : LstEnt
066700060501                     : %Size( LstEnt )
066800060501                     : 'DTLRCD'
066900060501                     : 'DTLLST'
067000060501                     : 'HNDL'
067100060501                     : 'Y'
067200060501                     : *Blanks
067300060501                     : LstAtr.DspPos
067400060501                     : 'N'
067500060501                     : UIM.EntHdl
067600060501                     : ERRC0100
067700060501                     );
067800060501
067900060501            LstEntPos = LstEnt;
068000060501          EndIf;
068100060501
068200060501        EndSr;
068300060501
068400060501        BegSr  SetLstPos;
068500060501
068600060501          If  LstAtr.DspPos <> 'TOP';
068700060501
068800060501            LstEnt = LstEntPos;
068900060501
069000060501            PutDlgVar( UIM.AppHdl
069100060501                     : LstEnt
069200060501                     : %Size( LstEnt )
069300060501                     : 'DTLRCD'
069400060501                     : ERRC0100
069500060501                     );
069600060501
069700060501            GetLstEnt( UIM.AppHdl
069800060501                     : LstEnt
069900060501                     : %Size( LstEnt )
070000060501                     : '*NONE'
070100060501                     : 'DTLLST'
070200060501                     : 'FSLT'
070300060501                     : 'N'
070400060501                     : 'EQ        JOBID'
070500060501                     : LstAtr.DspPos
070600060501                     : 'N'
070700060501                     : UIM.EntHdl
070800060501                     : ERRC0100
070900060501                     );
071000060501
071100060501            If  ERRC0100.BytAvl = *Zero;
071200060501
071300060501              SetLstAtr( UIM.AppHdl
071400060501                       : 'DTLLST'
071500060501                       : LIST_SAME
071600060501                       : EXIT_SAME
071700060501                       : UIM.EntHdl
071800060501                       : TRIM_SAME
071900060501                       : ERRC0100
072000060501                       );
072100060501
072200060501            EndIf;
072300060501          EndIf;
072400060501
072500060501        EndSr;
072600060501
072700060705        BegSr  PosLstTop;
072800060705
072900060705          SetLstAtr( UIM.AppHdl
073000060705                   : 'DTLLST'
073100060705                   : LIST_SAME
073200060705                   : EXIT_SAME
073300060705                   : POS_TOP
073400060705                   : TRIM_SAME
073500060705                   : ERRC0100
073600060705                   );
073700060705
073800060705        EndSr;
073900060705
074000060705        BegSr  PosLstBot;
074100060705
074200060705          SetLstAtr( UIM.AppHdl
074300060705                   : 'DTLLST'
074400060705                   : LIST_SAME
074500060705                   : EXIT_SAME
074600060705                   : POS_BOT
074700060705                   : TRIM_SAME
074800060705                   : ERRC0100
074900060705                   );
075000060705
075100060705        EndSr;
075200060705
075300060501        BegSr  BldHdrRcd;
075400060501
075500060501          SysDts = %Timestamp();
075600060501
075700060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
075800060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
075900060511          HdrRcd.TimZon = '*SYS';
076000060501
076100060501          ExSr  GetJobQueInf;
076200060501
076300060511          HdrRcd.JobQue    = OJBQ0100.JobQue;
076400060511          HdrRcd.JobQueLib = OJBQ0100.JobQueLib;
076500060511          HdrRcd.JobQueSts = OJBQ0100.JobQueSts;
076600060511          HdrRcd.ActSbs    = OJBQ0100.ActSbs;
076700060501
076800060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
076900060501
077000060501        EndSr;
077100060501
077200060501        BegSr  GetJobQueInf;
077300060501
077400060501          FltInf.JobQue_q = PxJobQue_q;
077500060501          FltInf.ActSbs = *Blanks;
077600060501
077700060501          SrtInf.NbrKeys = *Zero;
077800060501
077900060501          LstJobQs( OJBQ0100
078000060501                  : %Size( OJBQ0100 )
078100060501                  : 'OJBQ0100'
078200060501                  : LstInf
078300060501                  : FltInf
078400060501                  : SrtInf
078500060501                  : -1
078600060501                  : ERRC0100
078700060501                  );
078800060501
078900060503          If  ERRC0100.BytAvl > *Zero  Or  LstInf.RcdNbrTot = *Zero;
079000060501            Reset  OJBQ0100;
079100060501          EndIf;
079200060501
079300060501          CloseLst( LstInf.Handle: ERRC0100 );
079400060501
079500060501        EndSr;
079600060501
079700060501        BegSr  DltUsrLst;
079800060501
079900060501          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
080000060501
080100060501        EndSr;
080200060501
080300060503        BegSr  InzApiPrm;
080400060501
080500060501          OLJS0200.PriSts(1) = '*ACTIVE';
080600060501          OLJS0200.PriSts(2) = '*JOBQ';
080700060501
080800060501          OLJS0200.JbqNam(1) = PxJobQue_q;
080900060501
081000060510          SrtInf.NbrKeys      = 4;
081100060501          SrtInf.KeyFldOfs(1) = 43;
081200060509          SrtInf.KeyFldLen(1) = %Size( OLJB0200.Status );
081300060501          SrtInf.KeyFldTyp(1) = CHAR_NLS;
081400060509          SrtInf.SrtOrd(1)    = SORT_ASC;
081500060501          SrtInf.Rsv(1)       = x'00';
081600060501
081700060501          SrtInf.KeyFldOfs(2) = 61;
081800060509          SrtInf.KeyFldLen(2) = %Size( KeyDta.JobQue_q );
081900060501          SrtInf.KeyFldTyp(2) = CHAR_NLS;
082000060509          SrtInf.SrtOrd(2)    = SORT_ASC;
082100060501          SrtInf.Rsv(2)       = x'00';
082200060501
082300060501          SrtInf.KeyFldOfs(3) = 81;
082400060510          SrtInf.KeyFldLen(3) = %Size( KeyDta.JobPty );
082500060501          SrtInf.KeyFldTyp(3) = CHAR_NLS;
082600060509          SrtInf.SrtOrd(3)    = SORT_ASC;
082700060501          SrtInf.Rsv(3)       = x'00';
082800060510
082900060523          SrtInf.KeyFldOfs(4) = 21;
083000060523          SrtInf.KeyFldLen(4) = %Size( OLJB0200.JobNbr );
083100060523          SrtInf.KeyFldTyp(4) = NUM_ZON;
083200060510          SrtInf.SrtOrd(4)    = SORT_ASC;
083300060510          SrtInf.Rsv(4)       = x'00';
083400060501
083500060501          LstApi.KeyFld(1) = 1004;
083600060501          LstApi.KeyFld(2) = 1005;
083700060523          LstApi.KeyFld(3) = 402;
083800060523          LstApi.KeyFld(4) = 1906;
083900060523          LstApi.KeyFld(5) = 101;
084000060523          LstApi.KeyFld(6) = 305;
084100060501          LstApi.KeyFld(7) = 1016;
084200060501          LstApi.KeyFld(8) = 1802;
084300060501          LstApi.KeyFld(9) = 1903;
084400060501          LstApi.KeyFld(10) = 1904;
084500131107          LstApi.KeyFld(11) = 1307;
084600131107          LstApi.KeyFld(12) = 1308;
084700131107          LstApi.KeyFld(13) = 1309;
084800060501
084900060501        EndSr;
085000060501
085100100319        BegSr  EscApiErr;
085200100319
085300100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
085400100319            ERRC0100.BytAvl = OFS_MSGDTA;
085500100319          EndIf;
085600100319
085700100319          SndEscMsg( ERRC0100.MsgId
085800100319                   : 'QCPFMSG'
085900100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
086000100319                   );
086100100319
086200100319        EndSr;
086300100319
086400060501        BegSr  *InzSr;
086500060501
086600060501          If  PxJobQue_q.ObjLib = '*LIBL';
086700060501            PxJobQue_q.ObjLib = GetObjLib( PxJobQue_q: '*JOBQ' );
086800060501          EndIf;
086900060501
087000060501        EndSr;
087100060501
087200050226      /End-Free
087300060430
087400060430     **-- Get object library:
087500060430     P GetObjLib       B
087600060430     D                 Pi            10a
087700060430     D  PxObjNam_q                   20a   Const
087800060430     D  PxObjTyp                     10a   Const
087900060430     **
088000060430     D OBJD0100        Ds                  Qualified
088100060430     D  BytRtn                       10i 0
088200060430     D  BytAvl                       10i 0
088300060430     D  ObjNam                       10a
088400060430     D  ObjLib                       10a
088500060430     D  ObjTyp                       10a
088600060430     D  ObjLibRtn                    10a
088700060430     D  ObjASP                       10i 0
088800060430     D  ObjOwn                       10a
088900060430     D  ObjDmn                        2a
089000060430
089100060430      /Free
089200060430
089300060430         RtvObjD( OBJD0100
089400060430                : %Size( OBJD0100 )
089500060430                : 'OBJD0100'
089600060430                : PxObjNam_q
089700060430                : PxObjTyp
089800060430                : ERRC0100
089900060430                );
090000060430
090100060430         If  ERRC0100.BytAvl > *Zero;
090200060430           Return  *Blanks;
090300060430
090400060430         Else;
090500060430           Return  OBJD0100.ObjLibRtn;
090600060430         EndIf;
090700060430
090800060430      /End-Free
090900060430
091000060430     P GetObjLib       E
091100060501     **-- Send escape message:
091200060501     P SndEscMsg       B
091300060501     D                 Pi            10i 0
091400060501     D  PxMsgId                       7a   Const
091500060501     D  PxMsgF                       10a   Const
091600060501     D  PxMsgDta                    512a   Const  Varying
091700060501     **
091800060501     D MsgKey          s              4a
091900060501
092000060501      /Free
092100060501
092200060501        SndPgmMsg( PxMsgId
092300060501                 : PxMsgF + '*LIBL'
092400060501                 : PxMsgDta
092500060501                 : %Len( PxMsgDta )
092600060501                 : '*ESCAPE'
092700060501                 : '*PGMBDY'
092800060501                 : 1
092900060501                 : MsgKey
093000060501                 : ERRC0100
093100060501                 );
093200060501
093300060501        If  ERRC0100.BytAvl > *Zero;
093400060501          Return  -1;
093500060501
093600060501        Else;
093700060501          Return   0;
093800060501        EndIf;
093900060501
094000060501      /End-Free
094100060501
094200060501     P SndEscMsg       E
