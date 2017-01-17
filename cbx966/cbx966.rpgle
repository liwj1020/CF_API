000100060505     **
000200070102     **  Program . . : CBX966
000300061122     **  Description : Display Subsystem Activity - CPP
000400060505     **  Author  . . : Carsten Flensburg
000500070102     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000070102     **    CrtRpgMod   Module( CBX966 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300070102     **    CrtPgm      Pgm( CBX966 )
001400070102     **                Module( CBX966 )
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
003600070102     D PNLGRP_Q        c                   'CBX966P   *LIBL     '
003700070102     D PNLGRP          c                   'CBX966P   '
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
005600060506     D Idx             s             10i 0
005700060506     D SysDts          s               z
005800060506     D NbrSbs          s             10i 0 Inz
005900060506     D SbsLst          s             20a   Dim( 2000 )
006000060506     D ExcLib          s             10a   Varying
006100060506     D ExcLibLen       s             10i 0
006200060504
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
007800060511     **-- UIM Panel exit prgram record:
007900060511     D ExpRcd          Ds                  Qualified
008000070102     D  ExitPg                       20a   Inz( 'CBX966E   *LIBL' )
008100060511     **-- UIM Panel header record:
008200060511     D HdrRcd          Ds                  Qualified
008300060504     D  SysDat                        7a
008400060504     D  SysTim                        6a
008500060504     D  TimZon                       10a
008600060506     D  SbsNam                       10a
008700060506     D  SbsLib                       10a
008800060506     D  ExcLib                       10a
008900060504     **-- UIM List entry:
009000060504     D LstEnt          Ds                  Qualified
009100060504     D  Option                        5i 0
009200060506     D  SbsPos                       20a
009300060506     D  SbsNam                       10a
009400060506     D  SbsLib                       10a
009500060506     D  SbsExtSts                    12a
009600060506     D  MaxActJob                     7s 0
009700060506     D  CurActJob                     7s 0
009800070123     D  JobOnQue                      7s 0
009900060506     D  SbsMonJob                    10a
010000060506     D  SbsMonUsr                    10a
010100060506     D  SbsMonNbr                     6a
010200060506     D  SbsDsc                       50a
010300060504     **
010400060504     D LstEntPos       Ds                  LikeDs( LstEnt )
010500060504
010600060506     **-- List API parameters:
010700060506     D LstApi          Ds                  Qualified  Inz
010800060506     D  RtnRcdNbr                    10i 0 Inz( 1 )
010900060506     D  NbrKeyRtn                    10i 0 Inz( *Zero )
011000060506     D  KeyFld                       10i 0 Dim( 1 )
011100060411
011200060506     **-- Object information:
011300060506     D ObjInf          Ds          4096    Qualified
011400060506     D  ObjNam_q                     20a
011500060506     D   ObjNam                      10a   Overlay( ObjNam_q: 1 )
011600060506     D   ObjLib                      10a   Overlay( ObjNam_q: *Next )
011700060506     D  ObjTyp                       10a
011800060506     D  InfSts                        1a
011900060506     D                                1a
012000060506     D  FldNbrRtn                    10i 0
012100060506     D  Data                               Like( KeyInf )
012200060506     **-- Key information:
012300060506     D KeyInf          Ds                  Qualified  Based( pKeyInf )
012400060506     D  FldInfLen                    10i 0
012500060506     D  KeyFld                       10i 0
012600060506     D  DtaTyp                        1a
012700060506     D                                3a
012800060506     D  DtaLen                       10i 0
012900060506     D  Data                        256a
013000060506     **-- Authority control:
013100060506     D AutCtl          Ds                  Qualified
013200060506     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
013300060506     D  CalLvl                       10i 0 Inz( 0 )
013400060506     D  DplObjAut                    10i 0 Inz( 0 )
013500060506     D  NbrObjAut                    10i 0 Inz( 0 )
013600060506     D  DplLibAut                    10i 0 Inz( 0 )
013700060506     D  NbrLibAut                    10i 0 Inz( 0 )
013800060506     D                               10i 0 Inz( 0 )
013900060506     D  ObjAut                       10a   Dim( 10 )
014000060506     D  LibAut                       10a   Dim( 10 )
014100060506     **-- Selection control:
014200060506     D SltCtl          Ds
014300060506     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
014400060506     D  SltOmt                       10i 0 Inz( 0 )
014500060506     D  DplSts                       10i 0 Inz( 20 )
014600060506     D  NbrSts                       10i 0 Inz( 1 )
014700060506     D                               10i 0 Inz( 0 )
014800060506     D  Status                        1a   Inz( '*' )
014900060503     **-- Subsystem information:
015000060506     D SBSI0200        Ds         65535    Qualified  Inz
015100060505     D  BytRtn                       10i 0
015200060503     D  BytAvl                       10i 0
015300060506     D  OfsSbsEnt                    10i 0
015400060506     D  NbrSbsEnt                    10i 0
015500060506     D  SizSbsEnt                    10i 0
015600060506     **
015700060506     D SbsEnt          Ds                  Qualified  Based( pSbsEnt )
015800060506     D  SbsNam_q                     20a
015900060506     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
016000060506     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
016100060506     D  SbsExtSts                    12a
016200060506     D  MaxActJob                    10i 0
016300060506     D  CurActJob                    10i 0
016400060506     D  SbsMonJob                    10a
016500060506     D  SbsMonUsr                    10a
016600060506     D  SbsMonNbr                     6a
016700060506     D  SbsDsc                       50a
016800000906     **-- Sort information:
016900050226     D SrtInf          Ds                  Qualified
017000060424     D  NbrKeys                      10i 0 Inz( 4 )
017100060424     D  SrtStr                       12a   Dim( 4 )
017200050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
017300050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
017400050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
017500050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
017600060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
017700000906     **-- List information:
017800050226     D LstInf          Ds                  Qualified
017900050226     D  RcdNbrTot                    10i 0
018000050226     D  RcdNbrRtn                    10i 0
018100050226     D  Handle                        4a
018200050226     D  RcdLen                       10i 0
018300050226     D  InfSts                        1a
018400050226     D  Dts                          13a
018500050226     D  LstSts                        1a
018600990920     D                                1a
018700050226     D  InfLen                       10i 0
018800050226     D  Rcd1                         10i 0
018900990920     D                               40a
019000060503
019100060506     **-- Open list of objects:
019200060506     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
019300060506     D  RcvVar                    65535a          Options( *VarSize )
019400060506     D  RcvVarLen                    10i 0 Const
019500060506     D  LstInf                       80a
019600060506     D  NbrRcdRtn                    10i 0 Const
019700060506     D  SrtInf                     1024a   Const  Options( *VarSize )
019800060506     D  ObjNam_q                     20a   Const
019900060506     D  ObjTyp                       10a   Const
020000060506     D  AutCtl                     1024a   Const  Options( *VarSize )
020100060506     D  SltCtl                     1024a   Const  Options( *VarSize )
020200060506     D  NbrKeyRtn                    10i 0 Const
020300060506     D  KeyFld                       10i 0 Const  Options( *VarSize )  Dim( 32 )
020400060506     D  Error                      1024a          Options( *VarSize )
020500060506     **
020600060506     D  JobIdInf                    256a          Options( *NoPass: *VarSize )
020700060506     D  JobIdFmt                      8a   Const  Options( *NoPass )
020800060506     **
020900060506     D  AspCtl                      256a          Options( *NoPass: *VarSize )
021000060504     **-- Get open list entry:
021100060504     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
021200060423     D  RcvVar                    65535a          Options( *VarSize )
021300060423     D  RcvVarLen                    10i 0 Const
021400060423     D  Handle                        4a   Const
021500060423     D  LstInf                       80a
021600060423     D  NbrRcdRtn                    10i 0 Const
021700060423     D  RtnRcdNbr                    10i 0 Const
021800060423     D  Error                      1024a          Options( *VarSize )
021900050226     **-- Close list:
022000050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
022100060411     D  Handle                        4a   Const
022200060411     D  Error                      1024a          Options( *VarSize )
022300060428     **-- Retrieve subsystem information:
022400060428     D RtvSbsInf       Pr                  ExtPgm( 'QWDRSBSD' )
022500060428     D  RcvVar                    32767a          Options( *VarSize )
022600060428     D  RcvVarLen                    10i 0 Const
022700060428     D  FmtNam                       10a   Const
022800060506     D  SbsNam_q                     20a   Const  Options( *VarSize )
022900060506     D                                            Dim( 2000 )
023000060428     D  Error                     32767a          Options( *VarSize )
023100060506     D  NbrSbs                       10i 0 Const  Options( *NoPass )
023200060504     **-- Send program message:
023300060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
023400060504     D  MsgId                         7a   Const
023500060504     D  MsgFq                        20a   Const
023600060504     D  MsgDta                      128a   Const
023700060504     D  MsgDtaLen                    10i 0 Const
023800060504     D  MsgTyp                       10a   Const
023900060504     D  CalStkE                      10a   Const  Options( *VarSize )
024000060504     D  CalStkCtr                    10i 0 Const
024100060504     D  MsgKey                        4a
024200060504     D  Error                     32767a          Options( *VarSize )
024300060428
024400060504     **-- Open display application:
024500060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
024600060504     D  AppHdl                        8a
024700060504     D  PnlGrp_q                     20a   Const
024800060504     D  AppScp                       10i 0 Const
024900060504     D  ExtPrmIfc                    10i 0 Const
025000060504     D  FulScrHlp                     1a   Const
025100060504     D  Error                     32767a          Options( *VarSize )
025200060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
025300060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
025400060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
025500060504     **-- Display panel:
025600060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
025700060504     D  AppHdl                        8a   Const
025800060504     D  FncRqs                       10i 0
025900060504     D  PnlNam                       10a   Const
026000060504     D  ReDspOpt                      1a   Const
026100060504     D  Error                     32767a          Options( *VarSize )
026200060504     D  UsrTsk                        1a   Const  Options( *NoPass )
026300060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
026400060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
026500060504     D  MsgKey                        4a   Const  Options( *NoPass )
026600060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
026700060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
026800060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
026900060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
027000060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
027100060504     D  CalQlf                       20a   Const  Options( *NoPass )
027200060504     **-- Put dialog variable:
027300060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
027400060504     D  AppHdl                        8a   Const
027500060504     D  VarBuf                    32767a   Const  Options( *VarSize )
027600060504     D  VarBufLen                    10i 0 Const
027700060504     D  VarRcdNam                    10a   Const
027800060504     D  Error                     32767a          Options( *VarSize )
027900060504     **-- Get dialog variable:
028000060504     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
028100060504     D  AppHdl                        8a   Const
028200060504     D  VarBuf                    32767a          Options( *VarSize )
028300060504     D  VarBufLen                    10i 0 Const
028400060504     D  VarRcdNam                    10a   Const
028500060504     D  Error                     32767a          Options( *VarSize )
028600060504     **-- Add list entry:
028700060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
028800060504     D  AppHdl                        8a   Const
028900060504     D  VarBuf                    32767a   Const  Options( *VarSize )
029000060504     D  VarBufLen                    10i 0 Const
029100060504     D  VarRcdNam                    10a   Const
029200060504     D  LstNam                       10a   Const
029300060504     D  EntLocOpt                     4a   Const
029400060504     D  LstEntHdl                     4a
029500060504     D  Error                     32767a          Options( *VarSize )
029600060504     **-- Get list entry:
029700060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
029800060504     D  AppHdl                        8a   Const
029900060504     D  VarBuf                    32767a   Const  Options( *VarSize )
030000060504     D  VarBufLen                    10i 0 Const
030100060504     D  VarRcdNam                    10a   Const
030200060504     D  LstNam                       10a   Const
030300060504     D  PosOpt                        4a   Const
030400060504     D  CpyOpt                        1a   Const
030500060504     D  SltCri                       20a   Const
030600060504     D  SltHdl                        4a   Const
030700060504     D  ExtOpt                        1a   Const
030800060504     D  LstEntHdl                     4a
030900060504     D  Error                     32767a          Options( *VarSize )
031000060504     **-- Retrieve list attributes:
031100060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
031200060504     D  AppHdl                        8a   Const
031300060504     D  LstNam                       10a   Const
031400060504     D  AtrRcv                    32767a          Options( *VarSize )
031500060504     D  AtrRcvLen                    10i 0 Const
031600060504     D  Error                     32767a          Options( *VarSize )
031700060504     **-- Set list attributes:
031800060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
031900060504     D  AppHdl                        8a   Const
032000060504     D  LstNam                       10a   Const
032100060504     D  LstCon                        4a   Const
032200060504     D  ExtPgmVar                    10a   Const
032300060504     D  DspPos                        4a   Const
032400060504     D  AlwTrim                       1a   Const
032500060504     D  Error                     32767a          Options( *VarSize )
032600060504     **-- Delete list:
032700060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
032800060504     D  AppHdl                        8a   Const
032900060504     D  LstNam                       10a   Const
033000060504     D  Error                     32767a          Options( *VarSize )
033100060504     **-- Close application:
033200060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
033300060504     D  AppHdl                        8a   Const
033400060504     D  CloOpt                        1a   Const
033500060504     D  Error                     32767a          Options( *VarSize )
033600060504
033700070123     **-- Get jobs on queue:
033800070123     D GetJobOnQue     Pr            10i 0
033900070123     D  PxActSbs                     10a   Const
034000060504     **-- Send escape message:
034100060504     D SndEscMsg       Pr            10i 0
034200060504     D  PxMsgId                       7a   Const
034300060504     D  PxMsgF                       10a   Const
034400060504     D  PxMsgDta                    512a   Const  Varying
034500050226
034600070125     **-- Entry parameters:
034700070125     D ObjNam_q        Ds
034800070125     D  ObjNam                       10a
034900070125     D  ObjLib                       10a
035000070125     **
035100070102     D CBX966          Pr
035200060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
035300060506     D  PxExcLib                     10a
035400050226     **
035500070102     D CBX966          Pi
035600060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
035700060506     D  PxExcLib                     10a
035800050226
035900050226      /Free
036000060424
036100060504        OpnDspApp( UIM.AppHdl
036200060504                 : PNLGRP_Q
036300060504                 : SCP_AUT_RCL
036400060504                 : PRM_IFC_0
036500060504                 : HLP_WDW
036600060504                 : ERRC0100
036700060504                 );
036800060504
036900060504        If  ERRC0100.BytAvl > *Zero;
037000100319          ExSr  EscApiErr;
037100060504        EndIf;
037200060504
037300060511        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
037400060504
037500060504        ExSr  BldHdrRcd;
037600060506        ExSr  BldSbsLst;
037700060504
037800060504        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
037900060504
038000060504          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
038100060504
038200100319          Select;
038300100319          When  ERRC0100.BytAvl > *Zero;
038400100319            ExSr  EscApiErr;
038500100319
038600100319          When  UIM.FncRqs = RTN_ENTER;
038700060506            Leave;
038800100319          EndSl;
038900060506
039000060511          GetDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
039100060504
039200060504          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
039300060504            ExSr  GetLstPos;
039400060504            ExSr  DltUsrLst;
039500060504          EndIf;
039600060504
039700060504          If  UIM.FncRqs = KEY_F05;
039800060506            ExSr  BldSbsLst;
039900060504            ExSr  SetLstPos;
040000060504          EndIf;
040100060504
040200060504          ExSr  BldHdrRcd;
040300060504        EndDo;
040400060504
040500060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
040600050226
040700050226        *InLr = *On;
040800050226        Return;
040900060412
041000060505
041100060506        BegSr  BldSbsLst;
041200060504
041300060506          If  PxSbsNam_q.ObjNam = '*ALL'  Or
041400060506              PxSbsNam_q.ObjLib = '*ALL'  Or
041500060506              %Scan( '*': PxSbsNam_q.ObjNam: 2 ) >= 2;
041600060526            ExSr  LodSbsLst;
041700060506          Else;
041800060526            ExSr  LodSbsSng;
041900060506          EndIf;
042000060506
042100060504          UIM.EntLocOpt = 'FRST';
042200060505
042300060506          RtvSbsInf( SBSI0200
042400060506                   : %Size( SBSI0200 )
042500060506                   : 'SBSI0200'
042600060506                   : SbsLst
042700060506                   : ERRC0100
042800060506                   : NbrSbs
042900060506                   );
043000060506
043100060506          If  ERRC0100.BytAvl = *Zero;
043200060506            pSbsEnt = %Addr( SBSI0200 ) + SBSI0200.OfsSbsEnt;
043300060506
043400060506            For  Idx = 1  to  SBSI0200.NbrSbsEnt;
043500060506              ExSr  PrcLstEnt;
043600060505
043700060506              If  Idx < SBSI0200.NbrSbsEnt;
043800060506                pSbsEnt += SBSI0200.SizSbsEnt;
043900060506              EndIf;
044000060506            EndFor;
044100060505          EndIf;
044200060505
044300060505          CloseLst( LstInf.Handle: ERRC0100 );
044400060504
044500060504          SetLstAtr( UIM.AppHdl
044600060504                   : 'DTLLST'
044700060504                   : LIST_COMP
044800060504                   : EXIT_SAME
044900060504                   : POS_TOP
045000060504                   : TRIM_SAME
045100060504                   : ERRC0100
045200060504                   );
045300060504
045400060504        EndSr;
045500060506
045600060526        BegSr  LodSbsSng;
045700060506
045800060506          NbrSbs = 1;
045900060506          SbsLst(NbrSbs) = PxSbsNam_q;
046000060506
046100060506        EndSr;
046200060504
046300060526        BegSr  LodSbsLst;
046400060506
046500060506          ExSr  InzApiPrm;
046600060506
046700060506          LstApi.RtnRcdNbr = 1;
046800060506
046900060506          LstObjs( ObjInf
047000060506                 : %Size( ObjInf )
047100060506                 : LstInf
047200060506                 : -1
047300060506                 : SrtInf
047400060506                 : PxSbsNam_q
047500060506                 : '*SBSD'
047600060506                 : AutCtl
047700060506                 : SltCtl
047800060506                 : LstApi.NbrKeyRtn
047900060506                 : LstApi.KeyFld
048000060506                 : ERRC0100
048100060506                 );
048200060506
048300060506          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrRtn > *Zero;
048400060506            ExSr  AddSbsEnt;
048500060506
048600060506            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
048700060506              LstApi.RtnRcdNbr += 1;
048800060506
048900060506              GetOplEnt( ObjInf
049000060506                       : %Size( ObjInf )
049100060506                       : LstInf.Handle
049200060506                       : LstInf
049300060506                       : 1
049400060506                       : LstApi.RtnRcdNbr
049500060506                       : ERRC0100
049600060506                       );
049700060506
049800060506              If  ERRC0100.BytAvl > *Zero;
049900060506                Leave;
050000060506              EndIf;
050100060506
050200060506              ExSr  AddSbsEnt;
050300060506            EndDo;
050400060506          EndIf;
050500060506
050600060506          CloseLst( LstInf.Handle: ERRC0100 );
050700060506        EndSr;
050800060506
050900060506        BegSr  AddSbsEnt;
051000060506
051100060506          If  ExcLib = *Blanks  Or  %Scan( ExcLib: ObjInf.ObjLib ) <> 1;
051200060506
051300060506            If  NbrSbs < %Elem( SbsLst );
051400060506              NbrSbs += 1;
051500060506
051600060506              SbsLst(NbrSbs) = ObjInf.ObjNam_q;
051700060506            EndIf;
051800060506          EndIf;
051900060506
052000060506        EndSr;
052100060506
052200060504        BegSr  PrcLstEnt;
052300060504
052400060504          LstEnt.Option = *Zero;
052500060506
052600060506          LstEnt.SbsPos    = SbsEnt.SbsNam_q;
052700060506          LstEnt.SbsNam    = SbsEnt.SbsNam;
052800060506          LstEnt.SbsLib    = SbsEnt.SbsLib;
052900060506          LstEnt.SbsExtSts = SbsEnt.SbsExtSts;
053000060506          LstEnt.MaxActJob = SbsEnt.MaxActJob;
053100060506          LstEnt.CurActJob = SbsEnt.CurActJob;
053200060506          LstEnt.SbsMonJob = SbsEnt.SbsMonJob;
053300060506          LstEnt.SbsMonUsr = SbsEnt.SbsMonUsr;
053400060506          LstEnt.SbsMonNbr = SbsEnt.SbsMonNbr;
053500060506          LstEnt.SbsDsc    = SbsEnt.SbsDsc;
053600060504
053700070123          If  SbsEnt.SbsExtSts = '*ACTIVE';
053800070123            LstEnt.JobOnQue = GetJobOnQue( SbsEnt.SbsNam );
053900070123          Else;
054000070123            LstEnt.JobOnQue = -1;
054100070123          EndIf;
054200070123
054300060504          AddLstEnt( UIM.AppHdl
054400060504                   : LstEnt
054500060504                   : %Size( LstEnt )
054600060504                   : 'DTLRCD'
054700060504                   : 'DTLLST'
054800060504                   : UIM.EntLocOpt
054900060504                   : UIM.LstHdl
055000060504                   : ERRC0100
055100060504                   );
055200060504
055300060504          UIM.EntLocOpt = 'NEXT';
055400060504
055500060504        EndSr;
055600060504
055700060504        BegSr  GetLstPos;
055800060504
055900060504          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
056000060504
056100060504          If  LstAtr.DspPos <> 'TOP';
056200060504
056300060504            GetLstEnt( UIM.AppHdl
056400060504                     : LstEnt
056500060504                     : %Size( LstEnt )
056600060504                     : 'DTLRCD'
056700060504                     : 'DTLLST'
056800060504                     : 'HNDL'
056900060504                     : 'Y'
057000060504                     : *Blanks
057100060504                     : LstAtr.DspPos
057200060504                     : 'N'
057300060504                     : UIM.EntHdl
057400060504                     : ERRC0100
057500060504                     );
057600060504
057700060504            LstEntPos = LstEnt;
057800060504          EndIf;
057900060504
058000060504        EndSr;
058100060504
058200060504        BegSr  SetLstPos;
058300060504
058400060504          If  LstAtr.DspPos <> 'TOP';
058500060504
058600060504            LstEnt = LstEntPos;
058700060504
058800060504            PutDlgVar( UIM.AppHdl
058900060504                     : LstEnt
059000060504                     : %Size( LstEnt )
059100060504                     : 'DTLRCD'
059200060504                     : ERRC0100
059300060504                     );
059400060504
059500060504            GetLstEnt( UIM.AppHdl
059600060504                     : LstEnt
059700060504                     : %Size( LstEnt )
059800060504                     : '*NONE'
059900060504                     : 'DTLLST'
060000060504                     : 'FSLT'
060100060504                     : 'N'
060200060506                     : 'EQ        SBSPOS'
060300060504                     : LstAtr.DspPos
060400060504                     : 'N'
060500060504                     : UIM.EntHdl
060600060504                     : ERRC0100
060700060504                     );
060800060504
060900060504            If  ERRC0100.BytAvl = *Zero;
061000060504
061100060504              SetLstAtr( UIM.AppHdl
061200060504                       : 'DTLLST'
061300060504                       : LIST_SAME
061400060504                       : EXIT_SAME
061500060504                       : UIM.EntHdl
061600060504                       : TRIM_SAME
061700060504                       : ERRC0100
061800060504                       );
061900060504
062000060504            EndIf;
062100060504          EndIf;
062200060504
062300060504        EndSr;
062400060504
062500060504        BegSr  BldHdrRcd;
062600060504
062700060504          SysDts = %Timestamp();
062800060504
062900060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
063000060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
063100060511          HdrRcd.TimZon = '*SYS';
063200060511          HdrRcd.SbsNam = PxSbsNam_q.ObjNam;
063300060511          HdrRcd.SbsLib = PxSbsNam_q.ObjLib;
063400060511          HdrRcd.ExcLib = PxExcLib;
063500060504
063600060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
063700060504
063800060504        EndSr;
063900060504
064000060504        BegSr  DltUsrLst;
064100060504
064200060504          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
064300060504
064400060504        EndSr;
064500060505
064600060504        BegSr  InzApiPrm;
064700060505
064800060506          SrtInf.NbrKeys   = 2;
064900060505
065000060506          SrtInf.KeyFldOfs(1) = 1;
065100060509          SrtInf.KeyFldLen(1) = %Size( SbsEnt.SbsNam );
065200060506          SrtInf.KeyFldTyp(1) = CHAR_NLS;
065300060509          SrtInf.SrtOrd(1)    = SORT_ASC;
065400060505          SrtInf.Rsv(1)       = x'00';
065500060506
065600060506          SrtInf.KeyFldOfs(2) = 11;
065700060509          SrtInf.KeyFldLen(2) = %Size( SbsEnt.SbsLib );
065800060506          SrtInf.KeyFldTyp(2) = CHAR_NLS;
065900060509          SrtInf.SrtOrd(2)    = SORT_ASC;
066000060506          SrtInf.Rsv(2)       = x'00';
066100060504
066200061122          If  PxExcLib <> '*NONE';
066300061122            ExcLibLen = %Scan( '*': PxExcLib );
066400061122
066500061122            If  ExcLibLen > 1;
066600061122              ExcLib = %Subst( PxExcLib: 1: ExcLibLen - 1 );
066700061122            Else;
066800061122              ExcLib = PxExcLib;
066900061122            EndIf;
067000061122          EndIf;
067100061122
067200060504        EndSr;
067300100319
067400100319        BegSr  EscApiErr;
067500100319
067600100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
067700100319            ERRC0100.BytAvl = OFS_MSGDTA;
067800100319          EndIf;
067900100319
068000100319          SndEscMsg( ERRC0100.MsgId
068100100319                   : 'QCPFMSG'
068200100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
068300100319                   );
068400100319
068500100319        EndSr;
068600060519
068700050226      /End-Free
068800060428
068900070123     **-- Get jobs on queue:
069000070123     P GetJobOnQue     B
069100070123     D                 Pi            10i 0
069200070123     D  PxActSbs                     10a   Const
069300070123     **
069400070123     **-- Job queue information:
069500070123     D OJBQ0100        Ds                  Qualified
069600070123     D  JobQue_q                     20a
069700070123     D   JobQueNam                   10a   Overlay( JobQue_q:  1 )
069800070123     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
069900070123     D  JobQueSts                     1a
070000070123     D  SbsNam_Q                     20a
070100070123     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
070200070123     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
070300070123     D                                3a
070400070123     D  NbrJobOnQue                  10i 0
070500070123     D  SeqNbr                       10i 0
070600070123     D  MaxAct                       10i 0
070700070123     D  CurAct                       10i 0
070800070123     D  QueDsc                       50a
070900070123     **-- Filter information:
071000070123     D FltInf          Ds                  Qualified
071100070123     D  FltInfLen                    10i 0 Inz( %Size( FltInf ))
071200070123     D  JobQue                       20a
071300070123     D   JobQueNam                   10a   Overlay( JobQue:  1 )
071400070123     D   JobQueLib                   10a   Overlay( JobQue: 11 )
071500070123     D  ActSbsNam                    10a
071600070123     **-- Sort information:
071700070123     D SrtInf          Ds                  Qualified
071800070123     D  NbrKeys                      10i 0 Inz( 0 )
071900070123     D  SrtStr                       12a   Dim( 1 )
072000070123     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
072100070123     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
072200070123     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
072300070123     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
072400070123     D   Rsv                          1a   Overlay( SrtStr: 12 )
072500070123     **-- List information:
072600070123     D LstInf          Ds                  Qualified
072700070123     D  RcdNbrTot                    10i 0
072800070123     D  RcdNbrRtn                    10i 0
072900070123     D  Handle                        4a
073000070123     D  RcdLen                       10i 0
073100070123     D  InfSts                        1a
073200070123     D  Dts                          13a
073300070123     D  LstSts                        1a
073400070123     D                                1a
073500070123     D  InfLen                       10i 0
073600070123     D  Rcd1                         10i 0
073700070123     D                               40a
073800070123     **-- Open list of job queues:
073900070123     D LstJobQues      Pr                  ExtPgm( 'QSPOLJBQ' )
074000070123     D  RcvVar                    65535a          Options( *VarSize )
074100070123     D  RcvVarLen                    10i 0 Const
074200070123     D  FmtNam                        8a   Const
074300070123     D  LstInf                       80a
074400070123     D  FltInf                       32a   Const  Options( *VarSize )
074500070123     D  SrtInf                     1024a   Const  Options( *VarSize )
074600070123     D  NbrRcdRtn                    10i 0 Const
074700070123     D  Error                      1024a          Options( *VarSize )
074800070123     **
074900070123     D RtnRcdNbr       s             10i 0 Inz( 1 )
075000070123     D NbrJobOnQue     s             10i 0
075100070123
075200070123      /Free
075300070123
075400070123        FltInf.JobQue = '*ALLOCATED';
075500070123        FltInf.ActSbsNam = PxActSbs;
075600070123
075700070123        LstJobQues( OJBQ0100
075800070123                  : %Size( OJBQ0100 )
075900070123                  : 'OJBQ0100'
076000070123                  : LstInf
076100070123                  : FltInf
076200070123                  : SrtInf
076300070123                  : -1
076400070123                  : ERRC0100
076500070123                  );
076600070123
076700070123        Select;
076800070123        When  ERRC0100.BytAvl > *Zero;
076900070123          NbrJobOnQue = -1;
077000070123
077100070123        When  LstInf.RcdNbrRtn > *Zero;
077200070123          NbrJobOnQue += OJBQ0100.NbrJobOnQue;
077300070123
077400070123          DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
077500070123            RtnRcdNbr += 1;
077600070123
077700070123             GetOplEnt( OJBQ0100
077800070123                      : %Size( OJBQ0100 )
077900070123                      : LstInf.Handle
078000070123                      : LstInf
078100070123                      : 1
078200070123                      : RtnRcdNbr
078300070123                      : ERRC0100
078400070123                      );
078500070123
078600070123            If  ERRC0100.BytAvl > *Zero;
078700070123              Leave;
078800070123            EndIf;
078900070123
079000070123            NbrJobOnQue += OJBQ0100.NbrJobOnQue;
079100070123          EndDo;
079200070123        EndSl;
079300070123
079400070123        CloseLst( LstInf.Handle: ERRC0100 );
079500070123
079600070123        Return  NbrJobOnQue;
079700070123
079800070123      /End-Free
079900070123
080000070123     P GetJobOnQue     E
080100060504     **-- Send escape message:
080200060504     P SndEscMsg       B
080300060504     D                 Pi            10i 0
080400060504     D  PxMsgId                       7a   Const
080500060504     D  PxMsgF                       10a   Const
080600060504     D  PxMsgDta                    512a   Const  Varying
080700060504     **
080800060504     D MsgKey          s              4a
080900060504
081000060504      /Free
081100060504
081200060504        SndPgmMsg( PxMsgId
081300060504                 : PxMsgF + '*LIBL'
081400060504                 : PxMsgDta
081500060504                 : %Len( PxMsgDta )
081600060504                 : '*ESCAPE'
081700060504                 : '*PGMBDY'
081800060504                 : 1
081900060504                 : MsgKey
082000060504                 : ERRC0100
082100060504                 );
082200060504
082300060504        If  ERRC0100.BytAvl > *Zero;
082400060504          Return  -1;
082500060504
082600060504        Else;
082700060504          Return   0;
082800060504        EndIf;
082900060504
083000060504      /End-Free
083100060504
083200060504     P SndEscMsg       E
