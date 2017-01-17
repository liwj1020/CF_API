000100060517     **
000200070101     **  Program . . : CBX965
000300061116     **  Description : Display User Jobs - CPP
000400060517     **  Author  . . : Carsten Flensburg
000500070101     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060517     **
000700050310     **
000800070101     **    CrtRpgMod   Module( CBX965 )
000900050310     **                DbgView( *LIST )
001000050310     **
001100070101     **    CrtPgm      Pgm( CBX965 )
001200070101     **                Module( CBX965 )
001300060430     **                ActGrp( *NEW )
001400060517     **
001500050310     **
001600050310     **-- Header specifications:  --------------------------------------------**
001700060411     H Option( *SrcStmt )
001800060411
001900050227     **-- API error data structure:
002000050226     D ERRC0100        Ds                  Qualified
002100050226     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002200050226     D  BytAvl                       10i 0
002300050226     D  MsgId                         7a
002400990921     D                                1a
002500050226     D  MsgDta                      128a
002600060424
002700060424     **-- Global constants:
002800060424     D OFS_MSGDTA      c                   16
002900060501     **-- UIM constants:
003000070101     D PNLGRP_Q        c                   'CBX965P   *LIBL     '
003100070101     D PNLGRP          c                   'CBX965P   '
003200060501     D SCP_AUT_RCL     c                   -1
003300060501     D RDS_OPT_INZ     c                   'N'
003400060501     D PRM_IFC_0       c                   0
003500060501     D CLO_NORM        c                   'M'
003600060501     D FNC_EXIT        c                   -4
003700060501     D FNC_CNL         c                   -8
003800060501     D KEY_F05         c                   5
003900060501     D KEY_F24         c                   24
004000060506     D RTN_ENTER       c                   500
004100060511     D INC_EXP         c                   'Y'
004200060511     D CPY_VAR         c                   'Y'
004300060522     D CPY_VAR_NO      c                   'N'
004400060501     D HLP_WDW         c                   'N'
004500060501     D POS_TOP         c                   'TOP'
004600060501     D POS_BOT         c                   'BOT'
004700060510     D LIST_COMP       c                   'ALL'
004800060510     D LIST_SAME       c                   'SAME'
004900060510     D EXIT_SAME       c                   '*SAME'
005000060522     D DSPA_SAME       c                   'SAME'
005100060522     D TRIM_SAME       c                   'S'
005200060501
005300060424     **-- Global variables:
005400060501     D SysDts          s               z
005500060424     D KeyDtaVal       s             32a
005600060424     D Idx             s             10i 0
005700060501
005800060501     **-- UIM variables:
005900060501     D UIM             Ds                  Qualified
006000060501     D  AppHdl                        8a
006100060501     D  LstHdl                        4a
006200060501     D  EntHdl                        4a
006300060510     D  FncRqs                       10i 0 Inz
006400060501     D  EntLocOpt                     4a
006500060501     D  LstPos                        4a
006600060501     **-- List attributes structure:
006700060501     D LstAtr          Ds                  Qualified
006800060501     D  LstCon                        4a
006900060501     D  ExtPgmVar                    10a
007000060501     D  DspPos                        4a
007100060501     D  AlwTrim                       1a
007200060505
007300060511     **-- UIM Panel exit program record:
007400060511     D ExpRcd          Ds                  Qualified
007500070101     D  ExitPg                       20a   Inz( 'CBX965E   *LIBL' )
007600070101     D  ListPg                       20a   Inz( 'CBX965L   *LIBL' )
007700060510     **-- UIM Panel control record:
007800060510     D CtlRcd          Ds                  Qualified
007900060510     D  Action                        4a
008000060510     D  EntLocOpt                     4a
008100060510     **-- UIM List parameter record:
008200060510     D PrmRcd          Ds                  Qualified
008300060510     D  UsrPrf                       10a
008400060516     D  JobSts                       10a
008500060510     D  JobTyp                        1a
008600060510     D  CurUsr                       10a
008700060510     D  CmpSts                       10a
008800060511     **-- UIM Panel header record:
008900060511     D HdrRcd          Ds                  Qualified  Inz
009000060501     D  SysDat                        7a
009100060501     D  SysTim                        6a
009200060501     D  TimZon                       10a
009300060511     D  UsrPrf                       10a
009400060511     D  CurUsr                       10a
009500060516     D  JobSts                       10a
009600060501     **-- UIM List entry:
009700060501     D LstEnt          Ds                  Qualified
009800060501     D  Option                        5i 0
009900060511     D  EntId                        19a
010000060501     D  JobNam                       10a
010100060501     D  JobUsr                       10a
010200060511     D  JobNbr                        6a
010300060511     D  JobTyp                        1a
010400060501     D  JobSts1                       7a
010500060511     D  JobSts2                       4a
010600060511     D  JobDat                        7a
010700060502     D  EntDat                        7a
010800060502     D  EntTim                        6a
010900060511     D  ActDat                        7a
011000060511     D  ActTim                        6a
011100060501     D  CurUsr                       10a
011200060511     D  FncCmp                       14a
011300060511     D  MsgRpy                        1a
011400060511     D  SbmJob                       10a
011500060511     D  SbmUsr                       10a
011600060511     D  SbmNbr                        6a
011700060501     **
011800060501     D LstEntPos       Ds                  LikeDs( LstEnt )
011900060411
012000060501     **-- Send program message:
012100060501     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
012200060501     D  MsgId                         7a   Const
012300060501     D  MsgFq                        20a   Const
012400060501     D  MsgDta                      128a   Const
012500060501     D  MsgDtaLen                    10i 0 Const
012600060501     D  MsgTyp                       10a   Const
012700060501     D  CalStkE                      10a   Const  Options( *VarSize )
012800060501     D  CalStkCtr                    10i 0 Const
012900060501     D  MsgKey                        4a
013000060501     D  Error                     32767a          Options( *VarSize )
013100060501     **-- Open display application:
013200060501     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
013300060501     D  AppHdl                        8a
013400060501     D  PnlGrp_q                     20a   Const
013500060501     D  AppScp                       10i 0 Const
013600060501     D  ExtPrmIfc                    10i 0 Const
013700060501     D  FulScrHlp                     1a   Const
013800060501     D  Error                     32767a          Options( *VarSize )
013900060501     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
014000060501     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
014100060501     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
014200060501     **-- Display panel:
014300060501     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
014400060501     D  AppHdl                        8a   Const
014500060501     D  FncRqs                       10i 0
014600060501     D  PnlNam                       10a   Const
014700060501     D  ReDspOpt                      1a   Const
014800060501     D  Error                     32767a          Options( *VarSize )
014900060501     D  UsrTsk                        1a   Const  Options( *NoPass )
015000060501     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
015100060501     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
015200060501     D  MsgKey                        4a   Const  Options( *NoPass )
015300060501     D  CsrPosOpt                     1a   Const  Options( *NoPass )
015400060501     D  FinLstEnt                     4a   Const  Options( *NoPass )
015500060501     D  ErrLstEnt                     4a   Const  Options( *NoPass )
015600060501     D  WaitTim                      10i 0 Const  Options( *NoPass )
015700060501     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
015800060501     D  CalQlf                       20a   Const  Options( *NoPass )
015900060501     **-- Put dialog variable:
016000060501     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
016100060501     D  AppHdl                        8a   Const
016200060501     D  VarBuf                    32767a   Const  Options( *VarSize )
016300060501     D  VarBufLen                    10i 0 Const
016400060501     D  VarRcdNam                    10a   Const
016500060501     D  Error                     32767a          Options( *VarSize )
016600060501     **-- Get dialog variable:
016700060501     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
016800060501     D  AppHdl                        8a   Const
016900060501     D  VarBuf                    32767a          Options( *VarSize )
017000060501     D  VarBufLen                    10i 0 Const
017100060501     D  VarRcdNam                    10a   Const
017200060501     D  Error                     32767a          Options( *VarSize )
017300060501     **-- Get list entry:
017400060501     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
017500060501     D  AppHdl                        8a   Const
017600060501     D  VarBuf                    32767a   Const  Options( *VarSize )
017700060501     D  VarBufLen                    10i 0 Const
017800060501     D  VarRcdNam                    10a   Const
017900060501     D  LstNam                       10a   Const
018000060501     D  PosOpt                        4a   Const
018100060501     D  CpyOpt                        1a   Const
018200060501     D  SltCri                       20a   Const
018300060501     D  SltHdl                        4a   Const
018400060501     D  ExtOpt                        1a   Const
018500060501     D  LstEntHdl                     4a
018600060501     D  Error                     32767a          Options( *VarSize )
018700060501     **-- Retrieve list attributes:
018800060501     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
018900060501     D  AppHdl                        8a   Const
019000060501     D  LstNam                       10a   Const
019100060501     D  AtrRcv                    32767a          Options( *VarSize )
019200060501     D  AtrRcvLen                    10i 0 Const
019300060501     D  Error                     32767a          Options( *VarSize )
019400060501     **-- Set list attributes:
019500060501     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
019600060501     D  AppHdl                        8a   Const
019700060501     D  LstNam                       10a   Const
019800060501     D  LstCon                        4a   Const
019900060501     D  ExtPgmVar                    10a   Const
020000060501     D  DspPos                        4a   Const
020100060501     D  AlwTrim                       1a   Const
020200060501     D  Error                     32767a          Options( *VarSize )
020300060501     **-- Delete list:
020400060501     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
020500060501     D  AppHdl                        8a   Const
020600060501     D  LstNam                       10a   Const
020700060501     D  Error                     32767a          Options( *VarSize )
020800060501     **-- Close application:
020900060501     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
021000060501     D  AppHdl                        8a   Const
021100060501     D  CloOpt                        1a   Const
021200060501     D  Error                     32767a          Options( *VarSize )
021300060430
021400060501     **-- Send escape message:
021500060501     D SndEscMsg       Pr            10i 0
021600060501     D  PxMsgId                       7a   Const
021700060501     D  PxMsgF                       10a   Const
021800060501     D  PxMsgDta                    512a   Const  Varying
021900050226
022000070101     D CBX965          Pr
022100060510     D  PxUsrPrf                     10a
022200060516     D  PxJobSts                     10a
022300060510     D  PxJobTyp                      1a
022400060510     D  PxCurUsr                     10a
022500060510     D  PxCmpSts                     10a
022600060510
022700050226     **
022800070101     D CBX965          Pi
022900060510     D  PxUsrPrf                     10a
023000060516     D  PxJobSts                     10a
023100060510     D  PxJobTyp                      1a
023200060510     D  PxCurUsr                     10a
023300060510     D  PxCmpSts                     10a
023400050226
023500050226      /Free
023600060501
023700060501        OpnDspApp( UIM.AppHdl
023800060501                 : PNLGRP_Q
023900060501                 : SCP_AUT_RCL
024000060501                 : PRM_IFC_0
024100060501                 : HLP_WDW
024200060501                 : ERRC0100
024300060501                 );
024400060501
024500060501        If  ERRC0100.BytAvl > *Zero;
024600100319          ExSr  EscApiErr;
024700060501        EndIf;
024800060501
024900060510        ExSr  BldComRcd;
025000060501        ExSr  BldHdrRcd;
025100060430        ExSr  BldJobLst;
025200050226
025300060501        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
025400060501
025500060501          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
025600060501
025700100319          If  ERRC0100.BytAvl > *Zero;
025800100319            ExSr  EscApiErr;
025900100319          EndIf;
026000100319
026100060506          If  UIM.FncRqs = RTN_ENTER;
026200060506            Leave;
026300060506          EndIf;
026400060506
026500060510          GetDlgVar( UIM.AppHdl: CtlRcd: %Size( CtlRcd ): 'CTLRCD': ERRC0100 );
026600060501
026700060510          If  UIM.FncRqs = KEY_F05  And  CtlRcd.EntLocOpt = 'NEXT';
026800060501            ExSr  GetLstPos;
026900060501            ExSr  DltUsrLst;
027000060501          EndIf;
027100060501
027200060501          If  UIM.FncRqs = KEY_F05;
027300060501            ExSr  BldJobLst;
027400060501            ExSr  SetLstPos;
027500060501          EndIf;
027600060501
027700060501          ExSr  BldHdrRcd;
027800060501        EndDo;
027900060501
028000060501        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
028100060501
028200050226        *InLr = *On;
028300050226        Return;
028400060501
028500060424
028600060430        BegSr  BldJobLst;
028700060510
028800060510          If  UIM.FncRqs = KEY_F05;
028900060510            CtlRcd.Action = 'F05';
029000060510          Else;
029100060510            CtlRcd.Action = 'LIST';
029200060510          EndIf;
029300060510
029400060510          PutDlgVar( UIM.AppHdl: CtlRcd: %Size( CtlRcd ): 'CTLRCD': ERRC0100 );
029500060523
029600060523          SetLstAtr( UIM.AppHdl
029700060523                   : 'DTLLST'
029800060523                   : 'TOP'
029900060523                   : 'LISTPG'
030000060523                   : DSPA_SAME
030100060523                   : TRIM_SAME
030200060523                   : ERRC0100
030300060523                   );
030400060523
030500060424        EndSr;
030600060501
030700060501        BegSr  GetLstPos;
030800060501
030900060501          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
031000060501
031100060501          If  LstAtr.DspPos <> 'TOP';
031200060501
031300060501            GetLstEnt( UIM.AppHdl
031400060501                     : LstEnt
031500060501                     : %Size( LstEnt )
031600060501                     : 'DTLRCD'
031700060501                     : 'DTLLST'
031800060501                     : 'HNDL'
031900060511                     : CPY_VAR
032000060501                     : *Blanks
032100060501                     : LstAtr.DspPos
032200060511                     : INC_EXP
032300060501                     : UIM.EntHdl
032400060501                     : ERRC0100
032500060501                     );
032600060501
032700060501            LstEntPos = LstEnt;
032800060501          EndIf;
032900060501
033000060501        EndSr;
033100060501
033200060501        BegSr  SetLstPos;
033300060501
033400060501          If  LstAtr.DspPos <> 'TOP';
033500060501
033600060501            LstEnt = LstEntPos;
033700060501
033800060501            PutDlgVar( UIM.AppHdl
033900060501                     : LstEnt
034000060501                     : %Size( LstEnt )
034100060501                     : 'DTLRCD'
034200060501                     : ERRC0100
034300060501                     );
034400060501
034500060501            GetLstEnt( UIM.AppHdl
034600060501                     : LstEnt
034700060501                     : %Size( LstEnt )
034800060501                     : '*NONE'
034900060501                     : 'DTLLST'
035000060523                     : 'NSLT'
035100060511                     : CPY_VAR_NO
035200060511                     : 'LE        ENTID'
035300060501                     : LstAtr.DspPos
035400060511                     : INC_EXP
035500060501                     : UIM.EntHdl
035600060501                     : ERRC0100
035700060501                     );
035800060501
035900060501            If  ERRC0100.BytAvl = *Zero;
036000060501
036100060501              SetLstAtr( UIM.AppHdl
036200060501                       : 'DTLLST'
036300060501                       : LIST_SAME
036400060501                       : EXIT_SAME
036500060501                       : UIM.EntHdl
036600060501                       : TRIM_SAME
036700060501                       : ERRC0100
036800060501                       );
036900060501
037000060501            EndIf;
037100060501          EndIf;
037200060501
037300060501        EndSr;
037400060501
037500060501        BegSr  BldHdrRcd;
037600060501
037700060501          SysDts = %Timestamp();
037800060501
037900060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
038000060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
038100060511          HdrRcd.TimZon = '*SYS';
038200060511          HdrRcd.UsrPrf = PxUsrPrf;
038300060511          HdrRcd.CurUsr = PxCurUsr;
038400060516          HdrRcd.JobSts = PxJobSts;
038500060501
038600060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
038700060501
038800060501        EndSr;
038900060501
039000060501        BegSr  DltUsrLst;
039100060501
039200060501          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
039300060501
039400060501        EndSr;
039500060501
039600060510        BegSr  BldComRcd;
039700060522
039800060510          PrmRcd.UsrPrf = PxUsrPrf;
039900060510          PrmRcd.JobSts = PxJobSts;
040000060510          PrmRcd.JobTyp = PxJobTyp;
040100060510          PrmRcd.CurUsr = PxCurUsr;
040200060510          PrmRcd.CmpSts = PxCmpSts;
040300060501
040400060510          PutDlgVar( UIM.AppHdl: PrmRcd: %Size( PrmRcd ): 'PRMRCD': ERRC0100 );
040500060511          PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
040600060510
040700060501        EndSr;
040800060501
040900100319        BegSr  EscApiErr;
041000100319
041100100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
041200100319            ERRC0100.BytAvl = OFS_MSGDTA;
041300100319          EndIf;
041400100319
041500100319          SndEscMsg( ERRC0100.MsgId
041600100319                   : 'QCPFMSG'
041700100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
041800100319                   );
041900100319
042000100319        EndSr;
042100100319
042200050226      /End-Free
042300060430
042400060501     **-- Send escape message:
042500060501     P SndEscMsg       B
042600060501     D                 Pi            10i 0
042700060501     D  PxMsgId                       7a   Const
042800060501     D  PxMsgF                       10a   Const
042900060501     D  PxMsgDta                    512a   Const  Varying
043000060501     **
043100060501     D MsgKey          s              4a
043200060501
043300060501      /Free
043400060501
043500060501        SndPgmMsg( PxMsgId
043600060501                 : PxMsgF + '*LIBL'
043700060501                 : PxMsgDta
043800060501                 : %Len( PxMsgDta )
043900060501                 : '*ESCAPE'
044000060501                 : '*PGMBDY'
044100060501                 : 1
044200060501                 : MsgKey
044300060501                 : ERRC0100
044400060501                 );
044500060501
044600060501        If  ERRC0100.BytAvl > *Zero;
044700060501          Return  -1;
044800060501
044900060501        Else;
045000060501          Return   0;
045100060501        EndIf;
045200060501
045300060501      /End-Free
045400060501
045500060501     P SndEscMsg       E
