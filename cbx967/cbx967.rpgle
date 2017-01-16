000100060505     **
000200070128     **  Program . . : CBX967
000300061114     **  Description : Display Subsystem Job Queues - CPP
000400060505     **  Author  . . : Carsten Flensburg
000500070128     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000070128     **    CrtRpgMod   Module( CBX967 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300070128     **    CrtPgm      Pgm( CBX967 )
001400070128     **                Module( CBX967 )
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
003000060424     **
003100060424     D BIN_SGN         c                   0
003200060509     D NUM_ZON         c                   2
003300060424     D CHAR_NLS        c                   4
003400060509     D SORT_ASC        c                   '1'
003500060504     **-- UIM constants:
003600070128     D PNLGRP_Q        c                   'CBX967P   *LIBL     '
003700070128     D PNLGRP          c                   'CBX967P   '
003800060504     D SCP_AUT_RCL     c                   -1
003900060504     D RDS_OPT_INZ     c                   'N'
004000060504     D PRM_IFC_0       c                   0
004100060504     D CLO_NORM        c                   'M'
004200060504     D FNC_EXIT        c                   -4
004300060504     D FNC_CNL         c                   -8
004400060504     D KEY_F05         c                   5
004500060504     D KEY_F24         c                   24
004600060506     D RTN_ENTER       c                   500
004700060504     D HLP_WDW         c                   'N'
004800060504     D POS_TOP         c                   'TOP'
004900060504     D POS_BOT         c                   'BOT'
005000060504     D LIST_COMP       c                   'ALL'
005100060504     D LIST_SAME       c                   'SAME'
005200060504     D EXIT_SAME       c                   '*SAME'
005300060504     D TRIM_SAME       c                   'S'
005400060504
005500060424     **-- Global variables:
005600060505     D SysDts          s               z
005700060504     **
005800060504     D ObjNam_q        Ds
005900060504     D  ObjNam                       10a
006000060504     D  ObjLib                       10a
006100060504
006200060504     **-- UIM variables:
006300060504     D UIM             Ds                  Qualified
006400060504     D  AppHdl                        8a
006500060504     D  LstHdl                        4a
006600060504     D  EntHdl                        4a
006700060504     D  FncRqs                       10i 0
006800060504     D  EntLocOpt                     4a
006900060504     D  LstPos                        4a
007000060504     **-- List attributes structure:
007100060504     D LstAtr          Ds                  Qualified
007200060504     D  LstCon                        4a
007300060504     D  ExtPgmVar                    10a
007400060504     D  DspPos                        4a
007500060504     D  AlwTrim                       1a
007600060505
007700060511     **-- UIM Panel exit program record:
007800060511     D ExpRcd          Ds                  Qualified
007900070128     D  ExitPg                       20a   Inz( 'CBX967E   *LIBL' )
008000060511     **-- UIM Panel header record:
008100060618     D HdrRcd          Ds                  Qualified
008200060504     D  SysDat                        7a
008300060504     D  SysTim                        6a
008400060504     D  TimZon                       10a
008500060505     D  SbsNam                       10a
008600060505     D  SbsLib                       10a
008700060505     D  SbsSts                       10a
008800060505     D  MaxActJob                     7s 0
008900060504     **-- UIM List entry:
009000060504     D LstEnt          Ds                  Qualified
009100060504     D  Option                        5i 0
009200060505     D  SeqNbr                        4s 0
009300060505     D  JobQue_q                     20a
009400060505     D   JobQue                      10a   Overlay( JobQue_q: 1 )
009500060505     D   JobQueLib                   10a   Overlay( JobQue_q: *Next )
009600060505     D  JobQueSts                     1a
009700060505     D  MaxAct                        7s 0
009800060505     D  CurAct                        7s 0
009900060505     D  NbrJobOnQue                   7s 0
010000060505     D  QueDsc                       50a
010100060524     D  MaxPty1                       2s 0
010200060524     D  MaxPty2                       2s 0
010300060524     D  MaxPty3                       2s 0
010400060524     D  MaxPty4                       2s 0
010500060524     D  MaxPty5                       2s 0
010600060524     D  MaxPty6                       2s 0
010700060524     D  MaxPty7                       2s 0
010800060524     D  MaxPty8                       2s 0
010900060524     D  MaxPty9                       2s 0
011000060504     **
011100060504     D LstEntPos       Ds                  LikeDs( LstEnt )
011200060504
011300060424     **-- List API parameters:
011400060424     D LstApi          Ds                  Qualified  Inz
011500060424     D  RtnRcdNbr                    10i 0 Inz( 1 )
011600060424     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
011700060424     D  KeyFld                       10i 0 Dim( 10 )
011800060411
011900060503     **-- Subsystem information:
012000060505     D SBSI0100        Ds                  Qualified  Inz
012100060505     D  BytRtn                       10i 0
012200060503     D  BytAvl                       10i 0
012300060506     D  SbsNam_q                     20a
012400060506     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
012500060506     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
012600060503     D  SbsSts                       10a
012700060503     D  SgnDevName                   10a
012800060503     D  SgnDevLib                    10a
012900060503     D  SecLngLib                    10a
013000060503     D  MaxActJob                    10i 0
013100060503     D  CurActJob                    10i 0
013200060503     D  NbrPools                     10i 0
013300060503     D  PoolInf                            Dim( 10 )
013400060503     D   PoolId                      10i 0 Overlay( PoolInf: 1 )
013500060503     D   PoolNam                     10a   Overlay( PoolInf: *Next )
013600060503     D                                6a   Overlay( PoolInf: *Next )
013700060503     D   PoolSiz                     10i 0 Overlay( PoolInf: *Next )
013800060503     D   PoolActLvl                  10i 0 Overlay( PoolInf: *Next )
013900060524     **-- Job queue information:
014000060424     D OJBQ0100        Ds                  Qualified
014100060505     D  JobQue_q                     20a
014200060504     D   JobQueNam                   10a   Overlay( JobQue_q:  1 )
014300060504     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
014400060503     D  JobQueSts                     1a
014500060506     D  SbsNam_Q                     20a
014600060506     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
014700060506     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
014800060424     D                                3a
014900060424     D  NbrJobOnQue                  10i 0
015000060424     D  SeqNbr                       10i 0
015100060424     D  MaxAct                       10i 0
015200060424     D  CurAct                       10i 0
015300060424     D  QueDsc                       50a
015400060524     **-- Job queue information (partial):
015500060524     D JOBQ0200        Ds                  Qualified
015600060524     D  BytRtn                       10i 0
015700060524     D  BytAvl                       10i 0
015800060524     D  JobQue_q                     20a
015900060524     D   JobQueNam                   10a   Overlay( JobQue_q:  1 )
016000060524     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
016100060524     D  OprCtl                       10a
016200060524     D  AutChk                       10a
016300060524     D  NbrJobOnQue                  10i 0
016400060524     D  JobQueSts                    10a
016500060524     D  SbsNam_Q                     20a
016600060524     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
016700060524     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
016800060524     D  QueDsc                       50a
016900060524     D  SeqNbr                       10i 0
017000060524     D  MaxAct                       10i 0
017100060524     D  CurAct                       10i 0
017200060524     D  MaxPty1                      10i 0
017300060524     D  MaxPty2                      10i 0
017400060524     D  MaxPty3                      10i 0
017500060524     D  MaxPty4                      10i 0
017600060524     D  MaxPty5                      10i 0
017700060524     D  MaxPty6                      10i 0
017800060524     D  MaxPty7                      10i 0
017900060524     D  MaxPty8                      10i 0
018000060524     D  MaxPty9                      10i 0
018100060424     **-- Filter information:
018200060424     D FltInf          Ds                  Qualified
018300060424     D  FltInfLen                    10i 0 Inz( %Size( FltInf ))
018400060503     D  JobQue                       20a
018500060503     D   JobQueNam                   10a   Overlay( JobQue:  1 )
018600060503     D   JobQueLib                   10a   Overlay( JobQue: 11 )
018700060424     D  ActSbsNam                    10a
018800000906     **-- Sort information:
018900050226     D SrtInf          Ds                  Qualified
019000060424     D  NbrKeys                      10i 0 Inz( 4 )
019100060424     D  SrtStr                       12a   Dim( 4 )
019200050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
019300050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
019400050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
019500050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
019600060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
019700000906     **-- List information:
019800050226     D LstInf          Ds                  Qualified
019900050226     D  RcdNbrTot                    10i 0
020000050226     D  RcdNbrRtn                    10i 0
020100050226     D  Handle                        4a
020200050226     D  RcdLen                       10i 0
020300050226     D  InfSts                        1a
020400050226     D  Dts                          13a
020500050226     D  LstSts                        1a
020600990920     D                                1a
020700050226     D  InfLen                       10i 0
020800050226     D  Rcd1                         10i 0
020900990920     D                               40a
021000060503
021100060424     **-- Open list of job queues:
021200060503     D LstJobQues      Pr                  ExtPgm( 'QSPOLJBQ' )
021300060424     D  RcvVar                    65535a          Options( *VarSize )
021400060424     D  RcvVarLen                    10i 0 Const
021500060424     D  FmtNam                        8a   Const
021600060424     D  LstInf                       80a
021700060424     D  FltInf                       32a   Const  Options( *VarSize )
021800060424     D  SrtInf                     1024a   Const  Options( *VarSize )
021900060424     D  NbrRcdRtn                    10i 0 Const
022000060424     D  Error                      1024a          Options( *VarSize )
022100060504     **-- Get open list entry:
022200060504     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
022300060423     D  RcvVar                    65535a          Options( *VarSize )
022400060423     D  RcvVarLen                    10i 0 Const
022500060423     D  Handle                        4a   Const
022600060423     D  LstInf                       80a
022700060423     D  NbrRcdRtn                    10i 0 Const
022800060423     D  RtnRcdNbr                    10i 0 Const
022900060423     D  Error                      1024a          Options( *VarSize )
023000050226     **-- Close list:
023100050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
023200060411     D  Handle                        4a   Const
023300060411     D  Error                      1024a          Options( *VarSize )
023400060428     **-- Retrieve subsystem information:
023500060428     D RtvSbsInf       Pr                  ExtPgm( 'QWDRSBSD' )
023600060428     D  RcvVar                    32767a          Options( *VarSize )
023700060428     D  RcvVarLen                    10i 0 Const
023800060428     D  FmtNam                       10a   Const
023900060506     D  SbsNam_q                     20a   Const
024000060428     D  Error                     32767a          Options( *VarSize )
024100060524     **-- Retrieve job queue information:
024200060524     D RtvJobQueInf    Pr                  ExtPgm( 'QSPRJOBQ' )
024300060524     D  RcvVar                    65535a          Options( *VarSize )
024400060524     D  RcvVarLen                    10i 0 Const
024500060524     D  FmtNam                        8a   Const
024600060524     D  JobQue_q                     20a   Const
024700060524     D  Error                      1024a          Options( *VarSize )
024800060504     **-- Send program message:
024900060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
025000060504     D  MsgId                         7a   Const
025100060504     D  MsgFq                        20a   Const
025200060504     D  MsgDta                      128a   Const
025300060504     D  MsgDtaLen                    10i 0 Const
025400060504     D  MsgTyp                       10a   Const
025500060504     D  CalStkE                      10a   Const  Options( *VarSize )
025600060504     D  CalStkCtr                    10i 0 Const
025700060504     D  MsgKey                        4a
025800060504     D  Error                     32767a          Options( *VarSize )
025900060504     **-- Retrieve object description:
026000060504     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
026100060504     D  RcvVar                    32767a          Options( *VarSize )
026200060504     D  RcvVarLen                    10i 0 Const
026300060504     D  FmtNam                        8a   Const
026400060504     D  ObjNamQ                      20a   Const
026500060504     D  ObjTyp                       10a   Const
026600060504     D  Error                     32767a          Options( *VarSize )
026700060428
026800060504     **-- Open display application:
026900060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
027000060504     D  AppHdl                        8a
027100060504     D  PnlGrp_q                     20a   Const
027200060504     D  AppScp                       10i 0 Const
027300060504     D  ExtPrmIfc                    10i 0 Const
027400060504     D  FulScrHlp                     1a   Const
027500060504     D  Error                     32767a          Options( *VarSize )
027600060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
027700060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
027800060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
027900060504     **-- Display panel:
028000060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
028100060504     D  AppHdl                        8a   Const
028200060504     D  FncRqs                       10i 0
028300060504     D  PnlNam                       10a   Const
028400060504     D  ReDspOpt                      1a   Const
028500060504     D  Error                     32767a          Options( *VarSize )
028600060504     D  UsrTsk                        1a   Const  Options( *NoPass )
028700060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
028800060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
028900060504     D  MsgKey                        4a   Const  Options( *NoPass )
029000060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
029100060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
029200060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
029300060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
029400060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
029500060504     D  CalQlf                       20a   Const  Options( *NoPass )
029600060504     **-- Put dialog variable:
029700060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
029800060504     D  AppHdl                        8a   Const
029900060504     D  VarBuf                    32767a   Const  Options( *VarSize )
030000060504     D  VarBufLen                    10i 0 Const
030100060504     D  VarRcdNam                    10a   Const
030200060504     D  Error                     32767a          Options( *VarSize )
030300060504     **-- Get dialog variable:
030400060504     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
030500060504     D  AppHdl                        8a   Const
030600060504     D  VarBuf                    32767a          Options( *VarSize )
030700060504     D  VarBufLen                    10i 0 Const
030800060504     D  VarRcdNam                    10a   Const
030900060504     D  Error                     32767a          Options( *VarSize )
031000060504     **-- Add list entry:
031100060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
031200060504     D  AppHdl                        8a   Const
031300060504     D  VarBuf                    32767a   Const  Options( *VarSize )
031400060504     D  VarBufLen                    10i 0 Const
031500060504     D  VarRcdNam                    10a   Const
031600060504     D  LstNam                       10a   Const
031700060504     D  EntLocOpt                     4a   Const
031800060504     D  LstEntHdl                     4a
031900060504     D  Error                     32767a          Options( *VarSize )
032000060504     **-- Get list entry:
032100060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
032200060504     D  AppHdl                        8a   Const
032300060504     D  VarBuf                    32767a   Const  Options( *VarSize )
032400060504     D  VarBufLen                    10i 0 Const
032500060504     D  VarRcdNam                    10a   Const
032600060504     D  LstNam                       10a   Const
032700060504     D  PosOpt                        4a   Const
032800060504     D  CpyOpt                        1a   Const
032900060504     D  SltCri                       20a   Const
033000060504     D  SltHdl                        4a   Const
033100060504     D  ExtOpt                        1a   Const
033200060504     D  LstEntHdl                     4a
033300060504     D  Error                     32767a          Options( *VarSize )
033400060504     **-- Retrieve list attributes:
033500060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
033600060504     D  AppHdl                        8a   Const
033700060504     D  LstNam                       10a   Const
033800060504     D  AtrRcv                    32767a          Options( *VarSize )
033900060504     D  AtrRcvLen                    10i 0 Const
034000060504     D  Error                     32767a          Options( *VarSize )
034100060504     **-- Set list attributes:
034200060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
034300060504     D  AppHdl                        8a   Const
034400060504     D  LstNam                       10a   Const
034500060504     D  LstCon                        4a   Const
034600060504     D  ExtPgmVar                    10a   Const
034700060504     D  DspPos                        4a   Const
034800060504     D  AlwTrim                       1a   Const
034900060504     D  Error                     32767a          Options( *VarSize )
035000060504     **-- Delete list:
035100060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
035200060504     D  AppHdl                        8a   Const
035300060504     D  LstNam                       10a   Const
035400060504     D  Error                     32767a          Options( *VarSize )
035500060504     **-- Close application:
035600060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
035700060504     D  AppHdl                        8a   Const
035800060504     D  CloOpt                        1a   Const
035900060504     D  Error                     32767a          Options( *VarSize )
036000060504
036100060504     **-- Get object library:
036200060504     D GetObjLib       Pr            10a
036300060504     D  PxObjNam_q                   20a   Const
036400060504     D  PxObjTyp                     10a   Const
036500060504     **-- Send escape message:
036600060504     D SndEscMsg       Pr            10i 0
036700060504     D  PxMsgId                       7a   Const
036800060504     D  PxMsgF                       10a   Const
036900060504     D  PxMsgDta                    512a   Const  Varying
037000050226
037100070128     D CBX967          Pr
037200060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
037300050226     **
037400070128     D CBX967          Pi
037500060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
037600050226
037700050226      /Free
037800060424
037900060504        OpnDspApp( UIM.AppHdl
038000060504                 : PNLGRP_Q
038100060504                 : SCP_AUT_RCL
038200060504                 : PRM_IFC_0
038300060504                 : HLP_WDW
038400060504                 : ERRC0100
038500060504                 );
038600060504
038700060504        If  ERRC0100.BytAvl > *Zero;
038800100319          ExSr  EscApiErr;
038900060504        EndIf;
039000060504
039100060511        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
039200060504
039300060504        ExSr  BldHdrRcd;
039400060504        ExSr  BldJobQueLst;
039500060504
039600060504        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
039700060504
039800060504          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
039900060504
040000100319          Select;
040100100319          When  ERRC0100.BytAvl > *Zero;
040200100319            ExSr  EscApiErr;
040300100319
040400100319          When  UIM.FncRqs = RTN_ENTER;
040500060506            Leave;
040600100319          EndSl;
040700060506
040800060618          GetDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
040900060504
041000060504          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
041100060504            ExSr  GetLstPos;
041200060504            ExSr  DltUsrLst;
041300060504          EndIf;
041400060504
041500060504          If  UIM.FncRqs = KEY_F05;
041600060504            ExSr  BldJobQueLst;
041700060504            ExSr  SetLstPos;
041800060504          EndIf;
041900060504
042000060504          ExSr  BldHdrRcd;
042100060504        EndDo;
042200060504
042300060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
042400050226
042500050226        *InLr = *On;
042600050226        Return;
042700060412
042800060505
042900060504        BegSr  BldJobQueLst;
043000060504
043100060504          ExSr  InzApiPrm;
043200060504
043300060504          UIM.EntLocOpt = 'FRST';
043400060504          LstApi.RtnRcdNbr = 1;
043500060505
043600060505          LstJobQues( OJBQ0100
043700060505                    : %Size( OJBQ0100 )
043800060505                    : 'OJBQ0100'
043900060505                    : LstInf
044000060505                    : FltInf
044100060505                    : SrtInf
044200060505                    : -1
044300060505                    : ERRC0100
044400060505                    );
044500060505
044600060505          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrRtn > *Zero;
044700060505            ExSr  PrcLstEnt;
044800060505
044900060505            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
045000060505              LstApi.RtnRcdNbr += 1;
045100060505
045200060505              GetOplEnt( OJBQ0100
045300060505                       : %Size( OJBQ0100 )
045400060505                       : LstInf.Handle
045500060505                       : LstInf
045600060505                       : 1
045700060505                       : LstApi.RtnRcdNbr
045800060505                       : ERRC0100
045900060505                       );
046000060505
046100060505              If  ERRC0100.BytAvl > *Zero;
046200060505                Leave;
046300060505              EndIf;
046400060505
046500060505              ExSr  PrcLstEnt;
046600060505            EndDo;
046700060505          EndIf;
046800060505
046900060505          CloseLst( LstInf.Handle: ERRC0100 );
047000060504
047100060504          SetLstAtr( UIM.AppHdl
047200060504                   : 'DTLLST'
047300060504                   : LIST_COMP
047400060504                   : EXIT_SAME
047500060504                   : POS_TOP
047600060504                   : TRIM_SAME
047700060504                   : ERRC0100
047800060504                   );
047900060504
048000060504        EndSr;
048100060504
048200060504        BegSr  PrcLstEnt;
048300060504
048400060504          LstEnt.Option = *Zero;
048500060505
048600060505          LstEnt.SeqNbr      = OJBQ0100.SeqNbr;
048700060505          LstEnt.JobQue_q    = OJBQ0100.JobQue_q;
048800060505          LstEnt.JobQueSts   = OJBQ0100.JobQueSts;
048900060505          LstEnt.MaxAct      = OJBQ0100.MaxAct;
049000060505          LstEnt.CurAct      = OJBQ0100.CurAct;
049100060505          LstEnt.NbrJobOnQue = OJBQ0100.NbrJobOnQue;
049200060505          LstEnt.QueDsc      = OJBQ0100.QueDsc;
049300060504
049400060524          ExSr  GetJobQueInf;
049500060524
049600060524          LstEnt.MaxPty1     = JOBQ0200.MaxPty1;
049700060524          LstEnt.MaxPty2     = JOBQ0200.MaxPty2;
049800060524          LstEnt.MaxPty3     = JOBQ0200.MaxPty3;
049900060524          LstEnt.MaxPty4     = JOBQ0200.MaxPty4;
050000060524          LstEnt.MaxPty5     = JOBQ0200.MaxPty5;
050100060524          LstEnt.MaxPty6     = JOBQ0200.MaxPty6;
050200060524          LstEnt.MaxPty7     = JOBQ0200.MaxPty7;
050300060524          LstEnt.MaxPty8     = JOBQ0200.MaxPty8;
050400060524          LstEnt.MaxPty9     = JOBQ0200.MaxPty9;
050500060524
050600060504          AddLstEnt( UIM.AppHdl
050700060504                   : LstEnt
050800060504                   : %Size( LstEnt )
050900060504                   : 'DTLRCD'
051000060504                   : 'DTLLST'
051100060504                   : UIM.EntLocOpt
051200060504                   : UIM.LstHdl
051300060504                   : ERRC0100
051400060504                   );
051500060504
051600060504          UIM.EntLocOpt = 'NEXT';
051700060504
051800060504        EndSr;
051900060524
052000060524        BegSr  GetJobQueInf;
052100060504
052200060524          RtvJobQueInf( JOBQ0200
052300060524                      : %Size( JOBQ0200 )
052400060524                      : 'JOBQ0200'
052500060524                      : OJBQ0100.JobQue_q
052600060524                      : ERRC0100
052700060524                      );
052800060524
052900060524          If  ERRC0100.BytAvl > *Zero;
053000060524            Clear  JOBQ0200;
053100060524          EndIf;
053200060524
053300060524        EndSr;
053400060524
053500060504        BegSr  GetLstPos;
053600060504
053700060504          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
053800060504
053900060504          If  LstAtr.DspPos <> 'TOP';
054000060504
054100060504            GetLstEnt( UIM.AppHdl
054200060504                     : LstEnt
054300060504                     : %Size( LstEnt )
054400060504                     : 'DTLRCD'
054500060504                     : 'DTLLST'
054600060504                     : 'HNDL'
054700060504                     : 'Y'
054800060504                     : *Blanks
054900060504                     : LstAtr.DspPos
055000060504                     : 'N'
055100060504                     : UIM.EntHdl
055200060504                     : ERRC0100
055300060504                     );
055400060504
055500060504            LstEntPos = LstEnt;
055600060504          EndIf;
055700060504
055800060504        EndSr;
055900060504
056000060504        BegSr  SetLstPos;
056100060504
056200060504          If  LstAtr.DspPos <> 'TOP';
056300060504
056400060504            LstEnt = LstEntPos;
056500060504
056600060504            PutDlgVar( UIM.AppHdl
056700060504                     : LstEnt
056800060504                     : %Size( LstEnt )
056900060504                     : 'DTLRCD'
057000060504                     : ERRC0100
057100060504                     );
057200060504
057300060504            GetLstEnt( UIM.AppHdl
057400060504                     : LstEnt
057500060504                     : %Size( LstEnt )
057600060504                     : '*NONE'
057700060504                     : 'DTLLST'
057800060504                     : 'FSLT'
057900060504                     : 'N'
058000060505                     : 'EQ        SEQNBR'
058100060504                     : LstAtr.DspPos
058200060504                     : 'N'
058300060504                     : UIM.EntHdl
058400060504                     : ERRC0100
058500060504                     );
058600060504
058700060504            If  ERRC0100.BytAvl = *Zero;
058800060504
058900060504              SetLstAtr( UIM.AppHdl
059000060504                       : 'DTLLST'
059100060504                       : LIST_SAME
059200060504                       : EXIT_SAME
059300060504                       : UIM.EntHdl
059400060504                       : TRIM_SAME
059500060504                       : ERRC0100
059600060504                       );
059700060504
059800060504            EndIf;
059900060504          EndIf;
060000060504
060100060504        EndSr;
060200060504
060300060504        BegSr  BldHdrRcd;
060400060504
060500060504          SysDts = %Timestamp();
060600060504
060700060618          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
060800060618          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
060900060618          HdrRcd.TimZon = '*SYS';
061000060504
061100060505          ExSr  GetSbsInf;
061200060504
061300060618          HdrRcd.SbsNam    = SBSI0100.SbsNam;
061400060618          HdrRcd.SbsLib    = SBSI0100.SbsLib;
061500060618          HdrRcd.SbsSts    = SBSI0100.SbsSts;
061600060618          HdrRcd.MaxActJob = SBSI0100.MaxActJob;
061700060504
061800060618          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
061900060504
062000060504        EndSr;
062100060504
062200060504        BegSr  DltUsrLst;
062300060504
062400060504          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
062500060504
062600060504        EndSr;
062700060505
062800060505        BegSr  GetSbsInf;
062900060505
063000060505          RtvSbsInf( SBSI0100
063100060505                   : %Size( SBSI0100 )
063200060505                   : 'SBSI0100'
063300060506                   : PxSbsNam_q
063400060505                   : ERRC0100
063500060505                   );
063600060505
063700060505          If  ERRC0100.BytAvl > *Zero;
063800060505            Reset  SBSI0100;
063900060505          EndIf;
064000060505
064100060505        EndSr;
064200060505
064300060504        BegSr  InzApiPrm;
064400060504
064500060519          FltInf.JobQue    = '*ALLOCATED';
064600060506          FltInf.ActSbsNam = SBSI0100.SbsNam_q;
064700060505
064800060505          SrtInf.NbrKeys   = 1;
064900060505
065000060505          SrtInf.KeyFldOfs(1) = 49;
065100060509          SrtInf.KeyFldLen(1) = %Size( OJBQ0100.SeqNbr );
065200060505          SrtInf.KeyFldTyp(1) = BIN_SGN;
065300060509          SrtInf.SrtOrd(1)    = SORT_ASC;
065400060505          SrtInf.Rsv(1)       = x'00';
065500060504
065600060504        EndSr;
065700060504
065800060504        BegSr  *InzSr;
065900060504
066000060506          If  PxSbsNam_q.ObjLib = '*LIBL';
066100060506            PxSbsNam_q.ObjLib = GetObjLib( PxSbsNam_q: '*SBSD' );
066200060504          EndIf;
066300060504
066400060504        EndSr;
066500100319
066600100319        BegSr  EscApiErr;
066700100319
066800100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
066900100319            ERRC0100.BytAvl = OFS_MSGDTA;
067000100319          EndIf;
067100100319
067200100319          SndEscMsg( ERRC0100.MsgId
067300100319                   : 'QCPFMSG'
067400100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
067500100319                   );
067600100319
067700100319        EndSr;
067800060504
067900050226      /End-Free
068000060428
068100060504     **-- Get object library:
068200060504     P GetObjLib       B
068300060504     D                 Pi            10a
068400060504     D  PxObjNam_q                   20a   Const
068500060504     D  PxObjTyp                     10a   Const
068600060504     **
068700060504     D OBJD0100        Ds                  Qualified
068800060504     D  BytRtn                       10i 0
068900060504     D  BytAvl                       10i 0
069000060504     D  ObjNam                       10a
069100060504     D  ObjLib                       10a
069200060504     D  ObjTyp                       10a
069300060504     D  ObjLibRtn                    10a
069400060504     D  ObjASP                       10i 0
069500060504     D  ObjOwn                       10a
069600060504     D  ObjDmn                        2a
069700060504
069800060504      /Free
069900060504
070000060504         RtvObjD( OBJD0100
070100060504                : %Size( OBJD0100 )
070200060504                : 'OBJD0100'
070300060504                : PxObjNam_q
070400060504                : PxObjTyp
070500060504                : ERRC0100
070600060504                );
070700060504
070800060504         If  ERRC0100.BytAvl > *Zero;
070900060504           Return  *Blanks;
071000060504
071100060504         Else;
071200060504           Return  OBJD0100.ObjLibRtn;
071300060504         EndIf;
071400060504
071500060504      /End-Free
071600060504
071700060504     P GetObjLib       E
071800060504     **-- Send escape message:
071900060504     P SndEscMsg       B
072000060504     D                 Pi            10i 0
072100060504     D  PxMsgId                       7a   Const
072200060504     D  PxMsgF                       10a   Const
072300060504     D  PxMsgDta                    512a   Const  Varying
072400060504     **
072500060504     D MsgKey          s              4a
072600060504
072700060504      /Free
072800060504
072900060504        SndPgmMsg( PxMsgId
073000060504                 : PxMsgF + '*LIBL'
073100060504                 : PxMsgDta
073200060504                 : %Len( PxMsgDta )
073300060504                 : '*ESCAPE'
073400060504                 : '*PGMBDY'
073500060504                 : 1
073600060504                 : MsgKey
073700060504                 : ERRC0100
073800060504                 );
073900060504
074000060504        If  ERRC0100.BytAvl > *Zero;
074100060504          Return  -1;
074200060504
074300060504        Else;
074400060504          Return   0;
074500060504        EndIf;
074600060504
074700060504      /End-Free
074800060504
074900060504     P SndEscMsg       E
