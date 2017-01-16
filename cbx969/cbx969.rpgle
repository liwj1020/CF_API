000100060517     **
000200070423     **  Program . . : CBX969
000300060517     **  Description : Work with Jobs - CPP
000400060517     **  Author  . . : Carsten Flensburg
000500070423     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060517     **
000700050310     **
000800070423     **    CrtRpgMod   Module( CBX969 )
000900050310     **                DbgView( *LIST )
001000050310     **
001100070423     **    CrtPgm      Pgm( CBX969 )
001200070423     **                Module( CBX969 )
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
003000070423     D PNLGRP_Q        c                   'CBX969P   *LIBL     '
003100070423     D PNLGRP          c                   'CBX969P   '
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
007500070423     D  ExitPg                       20a   Inz( 'CBX969E   *LIBL' )
007600070423     D  ListPg                       20a   Inz( 'CBX969L   *LIBL' )
007700060510     **-- UIM Panel control record:
007800060510     D CtlRcd          Ds                  Qualified
007900060510     D  Action                        4a
008000060510     D  EntLocOpt                     4a
008100060510     **-- UIM List parameter record:
008200060510     D PrmRcd          Ds                  Qualified
008300060510     D  JobNam                       10a
008400060510     D  UsrPrf                       10a
008500060516     D  JobSts                       10a
008600060510     D  JobTyp                        1a
008700060510     D  CurUsr                       10a
008800060510     D  CmpSts                       10a
008900070308     D  Period                       36a
009000060511     **-- UIM Panel header record:
009100060511     D HdrRcd          Ds                  Qualified  Inz
009200060501     D  SysDat                        7a
009300060501     D  SysTim                        6a
009400060501     D  TimZon                       10a
009500060511     D  JobNam                       10a
009600060511     D  UsrPrf                       10a
009700060511     D  CurUsr                       10a
009800060516     D  JobSts                       10a
009900060501     **-- UIM List entry:
010000060501     D LstEnt          Ds                  Qualified
010100060501     D  Option                        5i 0
010200060511     D  EntId                        19a
010300060501     D  JobNam                       10a
010400060501     D  JobUsr                       10a
010500060511     D  JobNbr                        6a
010600060511     D  JobTyp                        1a
010700060501     D  JobSts1                       7a
010800060511     D  JobSts2                       4a
010900060511     D  JobDat                        7a
011000060502     D  EntDat                        7a
011100060502     D  EntTim                        6a
011200060511     D  ActDat                        7a
011300060511     D  ActTim                        6a
011400060501     D  CurUsr                       10a
011500060511     D  FncCmp                       14a
011600060511     D  MsgRpy                        1a
011700060511     D  SbmJob                       10a
011800060511     D  SbmUsr                       10a
011900060511     D  SbmNbr                        6a
012000060501     **
012100060501     D LstEntPos       Ds                  LikeDs( LstEnt )
012200060411
012300060501     **-- Send program message:
012400060501     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
012500060501     D  MsgId                         7a   Const
012600060501     D  MsgFq                        20a   Const
012700060501     D  MsgDta                      128a   Const
012800060501     D  MsgDtaLen                    10i 0 Const
012900060501     D  MsgTyp                       10a   Const
013000060501     D  CalStkE                      10a   Const  Options( *VarSize )
013100060501     D  CalStkCtr                    10i 0 Const
013200060501     D  MsgKey                        4a
013300060501     D  Error                     32767a          Options( *VarSize )
013400060501     **-- Open display application:
013500060501     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
013600060501     D  AppHdl                        8a
013700060501     D  PnlGrp_q                     20a   Const
013800060501     D  AppScp                       10i 0 Const
013900060501     D  ExtPrmIfc                    10i 0 Const
014000060501     D  FulScrHlp                     1a   Const
014100060501     D  Error                     32767a          Options( *VarSize )
014200060501     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
014300060501     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
014400060501     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
014500060501     **-- Display panel:
014600060501     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
014700060501     D  AppHdl                        8a   Const
014800060501     D  FncRqs                       10i 0
014900060501     D  PnlNam                       10a   Const
015000060501     D  ReDspOpt                      1a   Const
015100060501     D  Error                     32767a          Options( *VarSize )
015200060501     D  UsrTsk                        1a   Const  Options( *NoPass )
015300060501     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
015400060501     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
015500060501     D  MsgKey                        4a   Const  Options( *NoPass )
015600060501     D  CsrPosOpt                     1a   Const  Options( *NoPass )
015700060501     D  FinLstEnt                     4a   Const  Options( *NoPass )
015800060501     D  ErrLstEnt                     4a   Const  Options( *NoPass )
015900060501     D  WaitTim                      10i 0 Const  Options( *NoPass )
016000060501     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
016100060501     D  CalQlf                       20a   Const  Options( *NoPass )
016200060501     **-- Put dialog variable:
016300060501     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
016400060501     D  AppHdl                        8a   Const
016500060501     D  VarBuf                    32767a   Const  Options( *VarSize )
016600060501     D  VarBufLen                    10i 0 Const
016700060501     D  VarRcdNam                    10a   Const
016800060501     D  Error                     32767a          Options( *VarSize )
016900060501     **-- Get dialog variable:
017000060501     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
017100060501     D  AppHdl                        8a   Const
017200060501     D  VarBuf                    32767a          Options( *VarSize )
017300060501     D  VarBufLen                    10i 0 Const
017400060501     D  VarRcdNam                    10a   Const
017500060501     D  Error                     32767a          Options( *VarSize )
017600060501     **-- Get list entry:
017700060501     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
017800060501     D  AppHdl                        8a   Const
017900060501     D  VarBuf                    32767a   Const  Options( *VarSize )
018000060501     D  VarBufLen                    10i 0 Const
018100060501     D  VarRcdNam                    10a   Const
018200060501     D  LstNam                       10a   Const
018300060501     D  PosOpt                        4a   Const
018400060501     D  CpyOpt                        1a   Const
018500060501     D  SltCri                       20a   Const
018600060501     D  SltHdl                        4a   Const
018700060501     D  ExtOpt                        1a   Const
018800060501     D  LstEntHdl                     4a
018900060501     D  Error                     32767a          Options( *VarSize )
019000060501     **-- Retrieve list attributes:
019100060501     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
019200060501     D  AppHdl                        8a   Const
019300060501     D  LstNam                       10a   Const
019400060501     D  AtrRcv                    32767a          Options( *VarSize )
019500060501     D  AtrRcvLen                    10i 0 Const
019600060501     D  Error                     32767a          Options( *VarSize )
019700060501     **-- Set list attributes:
019800060501     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
019900060501     D  AppHdl                        8a   Const
020000060501     D  LstNam                       10a   Const
020100060501     D  LstCon                        4a   Const
020200060501     D  ExtPgmVar                    10a   Const
020300060501     D  DspPos                        4a   Const
020400060501     D  AlwTrim                       1a   Const
020500060501     D  Error                     32767a          Options( *VarSize )
020600060501     **-- Delete list:
020700060501     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
020800060501     D  AppHdl                        8a   Const
020900060501     D  LstNam                       10a   Const
021000060501     D  Error                     32767a          Options( *VarSize )
021100060501     **-- Close application:
021200060501     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
021300060501     D  AppHdl                        8a   Const
021400060501     D  CloOpt                        1a   Const
021500060501     D  Error                     32767a          Options( *VarSize )
021600060430
021700060501     **-- Send escape message:
021800060501     D SndEscMsg       Pr            10i 0
021900060501     D  PxMsgId                       7a   Const
022000060501     D  PxMsgF                       10a   Const
022100060501     D  PxMsgDta                    512a   Const  Varying
022200050226
022300070306     **-- Entry parameters:
022400070306     D Period          Ds                  Based( pNull )
022500070308     D  NbrElm                        5i 0
022600070308     D  OfsElm1                       5i 0
022700070308     D  OfsElm2                       5i 0
022800070308     D  NbrEnd                        5i 0
022900070308     D  TimEnd                        6a
023000070308     D  DatEnd                        7a
023100070308     D  NbrBeg                        5i 0
023200070308     D  TimBeg                        6a
023300070308     D  DatBeg                        7a
023400070306     **
023500070423     D CBX969          Pr
023600060510     D  PxJobNam                     10a
023700060510     D  PxUsrPrf                     10a
023800060516     D  PxJobSts                     10a
023900060510     D  PxJobTyp                      1a
024000060510     D  PxCurUsr                     10a
024100060510     D  PxCmpSts                     10a
024200070306     D  PxPeriod                           LikeDs( Period )
024300050226     **
024400070423     D CBX969          Pi
024500060510     D  PxJobNam                     10a
024600060510     D  PxUsrPrf                     10a
024700060516     D  PxJobSts                     10a
024800060510     D  PxJobTyp                      1a
024900060510     D  PxCurUsr                     10a
025000060510     D  PxCmpSts                     10a
025100070306     D  PxPeriod                           LikeDs( Period )
025200050226
025300050226      /Free
025400060501
025500060501        OpnDspApp( UIM.AppHdl
025600060501                 : PNLGRP_Q
025700060501                 : SCP_AUT_RCL
025800060501                 : PRM_IFC_0
025900060501                 : HLP_WDW
026000060501                 : ERRC0100
026100060501                 );
026200060501
026300060501        If  ERRC0100.BytAvl > *Zero;
026400070119          ExSr  EscApiErr;
026500060501        EndIf;
026600060501
026700060510        ExSr  BldComRcd;
026800060501        ExSr  BldHdrRcd;
026900060430        ExSr  BldJobLst;
027000050226
027100060501        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
027200060501
027300060501          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
027400060501
027500070119          If  ERRC0100.BytAvl > *Zero;
027600070119            ExSr  EscApiErr;
027700070119          EndIf;
027800070119
027900060506          If  UIM.FncRqs = RTN_ENTER;
028000060506            Leave;
028100060506          EndIf;
028200060506
028300060510          GetDlgVar( UIM.AppHdl: CtlRcd: %Size( CtlRcd ): 'CTLRCD': ERRC0100 );
028400060501
028500060510          If  UIM.FncRqs = KEY_F05  And  CtlRcd.EntLocOpt = 'NEXT';
028600060501            ExSr  GetLstPos;
028700060501            ExSr  DltUsrLst;
028800060501          EndIf;
028900060501
029000060501          If  UIM.FncRqs = KEY_F05;
029100060501            ExSr  BldJobLst;
029200060501            ExSr  SetLstPos;
029300060501          EndIf;
029400060501
029500060501          ExSr  BldHdrRcd;
029600060501        EndDo;
029700060501
029800060501        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
029900060501
030000050226        *InLr = *On;
030100050226        Return;
030200060501
030300060424
030400070119
030500070119        BegSr  EscApiErr;
030600070119
030700070119          If  ERRC0100.BytAvl < OFS_MSGDTA;
030800070119            ERRC0100.BytAvl = OFS_MSGDTA;
030900070119          EndIf;
031000070119
031100070119          SndEscMsg( ERRC0100.MsgId
031200070119                   : 'QCPFMSG'
031300070119                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
031400070119                   );
031500070119
031600070119        EndSr;
031700070119
031800060430        BegSr  BldJobLst;
031900060510
032000060510          If  UIM.FncRqs = KEY_F05;
032100060510            CtlRcd.Action = 'F05';
032200060510          Else;
032300060510            CtlRcd.Action = 'LIST';
032400060510          EndIf;
032500060510
032600060510          PutDlgVar( UIM.AppHdl: CtlRcd: %Size( CtlRcd ): 'CTLRCD': ERRC0100 );
032700060523
032800060523          SetLstAtr( UIM.AppHdl
032900060523                   : 'DTLLST'
033000060523                   : 'TOP'
033100060523                   : 'LISTPG'
033200060523                   : DSPA_SAME
033300060523                   : TRIM_SAME
033400060523                   : ERRC0100
033500060523                   );
033600060523
033700060424        EndSr;
033800060501
033900060501        BegSr  GetLstPos;
034000060501
034100060501          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
034200060501
034300060501          If  LstAtr.DspPos <> 'TOP';
034400060501
034500060501            GetLstEnt( UIM.AppHdl
034600060501                     : LstEnt
034700060501                     : %Size( LstEnt )
034800060501                     : 'DTLRCD'
034900060501                     : 'DTLLST'
035000060501                     : 'HNDL'
035100060511                     : CPY_VAR
035200060501                     : *Blanks
035300060501                     : LstAtr.DspPos
035400060511                     : INC_EXP
035500060501                     : UIM.EntHdl
035600060501                     : ERRC0100
035700060501                     );
035800060501
035900060501            LstEntPos = LstEnt;
036000060501          EndIf;
036100060501
036200060501        EndSr;
036300060501
036400060501        BegSr  SetLstPos;
036500060501
036600060501          If  LstAtr.DspPos <> 'TOP';
036700060501
036800060501            LstEnt = LstEntPos;
036900060501
037000060501            PutDlgVar( UIM.AppHdl
037100060501                     : LstEnt
037200060501                     : %Size( LstEnt )
037300060501                     : 'DTLRCD'
037400060501                     : ERRC0100
037500060501                     );
037600060501
037700060501            GetLstEnt( UIM.AppHdl
037800060501                     : LstEnt
037900060501                     : %Size( LstEnt )
038000060501                     : '*NONE'
038100060501                     : 'DTLLST'
038200060523                     : 'NSLT'
038300060511                     : CPY_VAR_NO
038400060511                     : 'LE        ENTID'
038500060501                     : LstAtr.DspPos
038600060511                     : INC_EXP
038700060501                     : UIM.EntHdl
038800060501                     : ERRC0100
038900060501                     );
039000060501
039100060501            If  ERRC0100.BytAvl = *Zero;
039200060501
039300060501              SetLstAtr( UIM.AppHdl
039400060501                       : 'DTLLST'
039500060501                       : LIST_SAME
039600060501                       : EXIT_SAME
039700060501                       : UIM.EntHdl
039800060501                       : TRIM_SAME
039900060501                       : ERRC0100
040000060501                       );
040100060501
040200060501            EndIf;
040300060501          EndIf;
040400060501
040500060501        EndSr;
040600060501
040700060501        BegSr  BldHdrRcd;
040800060501
040900060501          SysDts = %Timestamp();
041000060501
041100060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
041200060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
041300060511          HdrRcd.TimZon = '*SYS';
041400060511          HdrRcd.JobNam = PxJobNam;
041500060511          HdrRcd.UsrPrf = PxUsrPrf;
041600060511          HdrRcd.CurUsr = PxCurUsr;
041700060516          HdrRcd.JobSts = PxJobSts;
041800060501
041900060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
042000060501
042100060501        EndSr;
042200060501
042300060501        BegSr  DltUsrLst;
042400060501
042500060501          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
042600060501
042700060501        EndSr;
042800060501
042900060510        BegSr  BldComRcd;
043000060522
043100060510          PrmRcd.JobNam = PxJobNam;
043200060510          PrmRcd.UsrPrf = PxUsrPrf;
043300060510          PrmRcd.JobSts = PxJobSts;
043400060510          PrmRcd.JobTyp = PxJobTyp;
043500060510          PrmRcd.CurUsr = PxCurUsr;
043600060510          PrmRcd.CmpSts = PxCmpSts;
043700070306          PrmRcd.Period = PxPeriod;
043800060501
043900060510          PutDlgVar( UIM.AppHdl: PrmRcd: %Size( PrmRcd ): 'PRMRCD': ERRC0100 );
044000060511          PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
044100060510
044200060501        EndSr;
044300060501
044400050226      /End-Free
044500060430
044600060501     **-- Send escape message:
044700060501     P SndEscMsg       B
044800060501     D                 Pi            10i 0
044900060501     D  PxMsgId                       7a   Const
045000060501     D  PxMsgF                       10a   Const
045100060501     D  PxMsgDta                    512a   Const  Varying
045200060501     **
045300060501     D MsgKey          s              4a
045400060501
045500060501      /Free
045600060501
045700060501        SndPgmMsg( PxMsgId
045800060501                 : PxMsgF + '*LIBL'
045900060501                 : PxMsgDta
046000060501                 : %Len( PxMsgDta )
046100060501                 : '*ESCAPE'
046200060501                 : '*PGMBDY'
046300060501                 : 1
046400060501                 : MsgKey
046500060501                 : ERRC0100
046600060501                 );
046700060501
046800060501        If  ERRC0100.BytAvl > *Zero;
046900060501          Return  -1;
047000060501
047100060501        Else;
047200060501          Return   0;
047300060501        EndIf;
047400060501
047500060501      /End-Free
047600060501
047700060501     P SndEscMsg       E
