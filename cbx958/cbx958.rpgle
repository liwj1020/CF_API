000100060505     **
000200060729     **  Program . . : CBX958
000300060518     **  Description : Work with Subsystem Activity - CPP
000400060505     **  Author  . . : Carsten Flensburg
000500060729     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000060729     **    CrtRpgMod   Module( CBX958 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300060729     **    CrtPgm      Pgm( CBX958 )
001400060729     **                Module( CBX958 )
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
003500060729     D NULL            c                   ''
003600060504     **-- UIM constants:
003700060729     D PNLGRP_Q        c                   'CBX958P   *LIBL     '
003800060729     D PNLGRP          c                   'CBX958P   '
003900060504     D SCP_AUT_RCL     c                   -1
004000060504     D RDS_OPT_INZ     c                   'N'
004100060504     D PRM_IFC_0       c                   0
004200060504     D CLO_NORM        c                   'M'
004300060504     D FNC_EXIT        c                   -4
004400060504     D FNC_CNL         c                   -8
004500060504     D KEY_F05         c                   5
004600060506     D RTN_ENTER       c                   500
004700060504     D HLP_WDW         c                   'N'
004800060504     D POS_TOP         c                   'TOP'
004900060504     D POS_BOT         c                   'BOT'
005000060504     D LIST_COMP       c                   'ALL'
005100060504     D LIST_SAME       c                   'SAME'
005200060504     D EXIT_SAME       c                   '*SAME'
005300060504     D TRIM_SAME       c                   'S'
005400060729     **
005500060729     D APP_PRTF        c                   'QPRINT    *LIBL'
005600060729     D ODP_SHR         c                   'N'
005700060729     D SPLF_NAM        c                   'PNETUSR'
005800060729     D SPLF_USRDTA     c                   'WRKNETUSR'
005900060729     D EJECT_NO        c                   'N'
006000060504
006100060424     **-- Global variables:
006200060506     D Idx             s             10i 0
006300060506     D SysDts          s               z
006400060729     D WrkUsr          s             10a
006500060504
006600060504     **-- UIM variables:
006700060504     D UIM             Ds                  Qualified
006800060504     D  AppHdl                        8a
006900060504     D  LstHdl                        4a
007000060504     D  EntHdl                        4a
007100060504     D  FncRqs                       10i 0
007200060504     D  EntLocOpt                     4a
007300060504     D  LstPos                        4a
007400060504     **-- List attributes structure:
007500060504     D LstAtr          Ds                  Qualified
007600060504     D  LstCon                        4a
007700060504     D  ExtPgmVar                    10a
007800060504     D  DspPos                        4a
007900060504     D  AlwTrim                       1a
008000060505
008100060511     **-- UIM Panel exit prgram record:
008200060511     D ExpRcd          Ds                  Qualified
008300060729     D  ExitPg                       20a   Inz( 'CBX958E   *LIBL' )
008400060511     **-- UIM Panel header record:
008500060511     D HdrRcd          Ds                  Qualified
008600060504     D  SysDat                        7a
008700060504     D  SysTim                        6a
008800060504     D  TimZon                       10a
008900060729     D  WrkUsr                       10a
009000060729     D  WrkSts                       10a
009100060729     D  PosUsr                       10a
009200060504     **-- UIM List entry:
009300060504     D LstEnt          Ds                  Qualified
009400060504     D  Option                        5i 0
009500060729     D  NetUsr                       10a
009600060729     D  UsrSts                       10a
009700060729     D  UsrTxt                       50a
009800060504     **
009900060504     D LstEntPos       Ds                  LikeDs( LstEnt )
010000060504
010100060729     **-- List information:
010200060729     D LstInf          Ds                  Qualified
010300060729     D  RcdNbrTot                    10i 0
010400060729     D  RcdNbrRtn                    10i 0
010500060729     D  RcdLen                       10i 0
010600060729     D  InfLenRtn                    10i 0
010700060729     D  InfCmp                        1a
010800060729     D  Dts                          13a
010900060729     D                               34a
011000060729     **-- API parameters:
011100060729     D ZLSL0900        Ds                  Qualified
011200060729     D  DsaNetUsr                    10a   Dim( 5120 )
011300060503
011400060729     **-- Open list of server information:
011500060729     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
011600060729     D  RcvVar                    32767a          Options( *VarSize )
011700060729     D  RcvVarLen                    10i 0 Const
011800060729     D  LstInf                       64a
011900060729     D  FmtNam                       10a   Const
012000060729     D  InfQual                      15a   Const
012100060729     D  Error                     32767a          Options( *VarSize )
012200060729     D  SsnUsr                       10a   Const  Options( *NoPass )
012300060729     D  SsnId                        20i 0 Const  Options( *NoPass )
012400060504     **-- Send program message:
012500060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
012600060504     D  MsgId                         7a   Const
012700060504     D  MsgFq                        20a   Const
012800060504     D  MsgDta                      128a   Const
012900060504     D  MsgDtaLen                    10i 0 Const
013000060504     D  MsgTyp                       10a   Const
013100060504     D  CalStkE                      10a   Const  Options( *VarSize )
013200060504     D  CalStkCtr                    10i 0 Const
013300060504     D  MsgKey                        4a
013400060504     D  Error                     32767a          Options( *VarSize )
013500060729     **-- Retrieve job information:
013600060729     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
013700060729     D  RcvVar                    32767a         Options( *VarSize )
013800060729     D  RcvVarLen                    10i 0 Const
013900060729     D  FmtNam                        8a   Const
014000060729     D  JobNamQ                      26a   Const
014100060729     D  JobIntId                     16a   Const
014200060729     D  Error                     32767a         Options( *NoPass: *VarSize )
014300060729     **-- Retrieve user information:
014400060729     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
014500060729     D  RcvVar                    32767a          Options( *VarSize )
014600060729     D  RcvVarLen                    10i 0 Const
014700060729     D  FmtNam                       10a   Const
014800060729     D  UsrPrf                       10a   Const
014900060729     D  Error                     32767a          Options( *VarSize )
015000060428
015100060504     **-- Open display application:
015200060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
015300060504     D  AppHdl                        8a
015400060504     D  PnlGrp_q                     20a   Const
015500060504     D  AppScp                       10i 0 Const
015600060504     D  ExtPrmIfc                    10i 0 Const
015700060504     D  FulScrHlp                     1a   Const
015800060504     D  Error                     32767a          Options( *VarSize )
015900060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
016000060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
016100060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
016200060729     **-- Add print application:
016300060729     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
016400060729     D  AppHdl                        8a   Const
016500060729     D  PrtDevF_q                    20a   Const
016600060729     D  AltFilNam                    10a   Const
016700060729     D  ShrOpnDtaPth                  1a   Const
016800060729     D  UsrDta                       10a   Const
016900060729     D  Error                     32767a          Options( *VarSize )
017000060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
017100060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
017200060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
017300060729     **-- Open print application:
017400060729     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
017500060729     D  AppHdl                        8a
017600060729     D  PnlGrp_q                     20a   Const
017700060729     D  AppScp                       10i 0 Const
017800060729     D  ExtPrmIfc                    10i 0 Const
017900060729     D  PrtDevF_q                    20a   Const
018000060729     D  AltFilNam                    10a   Const
018100060729     D  ShrOpnDtaPth                  1a   Const
018200060729     D  UsrDta                       10a   Const
018300060729     D  Error                     32767a          Options( *VarSize )
018400060729     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
018500060729     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
018600060729     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
018700060504     **-- Display panel:
018800060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
018900060504     D  AppHdl                        8a   Const
019000060504     D  FncRqs                       10i 0
019100060504     D  PnlNam                       10a   Const
019200060504     D  ReDspOpt                      1a   Const
019300060504     D  Error                     32767a          Options( *VarSize )
019400060504     D  UsrTsk                        1a   Const  Options( *NoPass )
019500060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
019600060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
019700060504     D  MsgKey                        4a   Const  Options( *NoPass )
019800060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
019900060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
020000060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
020100060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
020200060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
020300060504     D  CalQlf                       20a   Const  Options( *NoPass )
020400060729     **-- Print panel:
020500060729     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
020600060729     D  AppHdl                        8a   Const
020700060729     D  PrtPnlNam                    10a   Const
020800060729     D  EjtOpt                        1a   Const
020900060729     D  Error                     32767a          Options( *VarSize )
021000060504     **-- Put dialog variable:
021100060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
021200060504     D  AppHdl                        8a   Const
021300060504     D  VarBuf                    32767a   Const  Options( *VarSize )
021400060504     D  VarBufLen                    10i 0 Const
021500060504     D  VarRcdNam                    10a   Const
021600060504     D  Error                     32767a          Options( *VarSize )
021700060504     **-- Get dialog variable:
021800060504     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
021900060504     D  AppHdl                        8a   Const
022000060504     D  VarBuf                    32767a          Options( *VarSize )
022100060504     D  VarBufLen                    10i 0 Const
022200060504     D  VarRcdNam                    10a   Const
022300060504     D  Error                     32767a          Options( *VarSize )
022400060504     **-- Add list entry:
022500060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
022600060504     D  AppHdl                        8a   Const
022700060504     D  VarBuf                    32767a   Const  Options( *VarSize )
022800060504     D  VarBufLen                    10i 0 Const
022900060504     D  VarRcdNam                    10a   Const
023000060504     D  LstNam                       10a   Const
023100060504     D  EntLocOpt                     4a   Const
023200060504     D  LstEntHdl                     4a
023300060504     D  Error                     32767a          Options( *VarSize )
023400060504     **-- Get list entry:
023500060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
023600060504     D  AppHdl                        8a   Const
023700060504     D  VarBuf                    32767a   Const  Options( *VarSize )
023800060504     D  VarBufLen                    10i 0 Const
023900060504     D  VarRcdNam                    10a   Const
024000060504     D  LstNam                       10a   Const
024100060504     D  PosOpt                        4a   Const
024200060504     D  CpyOpt                        1a   Const
024300060504     D  SltCri                       20a   Const
024400060504     D  SltHdl                        4a   Const
024500060504     D  ExtOpt                        1a   Const
024600060504     D  LstEntHdl                     4a
024700060504     D  Error                     32767a          Options( *VarSize )
024800060504     **-- Retrieve list attributes:
024900060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
025000060504     D  AppHdl                        8a   Const
025100060504     D  LstNam                       10a   Const
025200060504     D  AtrRcv                    32767a          Options( *VarSize )
025300060504     D  AtrRcvLen                    10i 0 Const
025400060504     D  Error                     32767a          Options( *VarSize )
025500060504     **-- Set list attributes:
025600060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
025700060504     D  AppHdl                        8a   Const
025800060504     D  LstNam                       10a   Const
025900060504     D  LstCon                        4a   Const
026000060504     D  ExtPgmVar                    10a   Const
026100060504     D  DspPos                        4a   Const
026200060504     D  AlwTrim                       1a   Const
026300060504     D  Error                     32767a          Options( *VarSize )
026400060504     **-- Delete list:
026500060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
026600060504     D  AppHdl                        8a   Const
026700060504     D  LstNam                       10a   Const
026800060504     D  Error                     32767a          Options( *VarSize )
026900060504     **-- Close application:
027000060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
027100060504     D  AppHdl                        8a   Const
027200060504     D  CloOpt                        1a   Const
027300060504     D  Error                     32767a          Options( *VarSize )
027400060504
027500060729     **-- Get job type:
027600060729     D GetJobTyp       Pr             1a
027700060729     **-- Get user text:
027800060729     D GetUsrTxt       Pr            50a   Varying
027900060729     D  PxUsrPrf                     10a   Value
028000060729     **-- Check generic string:
028100060729     D ChkGenStr       Pr              n
028200060729     D  PxCmpStr                    256a   Const  Varying
028300060729     D  PxChkStr                    256a   Const  Varying
028400060729     **-- Send completion message:
028500060729     D SndCmpMsg       Pr            10i 0
028600060729     D  PxMsgDta                    512a   Const  Varying
028700060504     **-- Send escape message:
028800060504     D SndEscMsg       Pr            10i 0
028900060504     D  PxMsgId                       7a   Const
029000060504     D  PxMsgF                       10a   Const
029100060504     D  PxMsgDta                    512a   Const  Varying
029200050226
029300060729     D CBX958          Pr
029400060729     D  PxNetUsr                     10a
029500060729     D  PxStatus                     10a
029600060729     D  PxOutOpt                      3a
029700050226     **
029800060729     D CBX958          Pi
029900060729     D  PxNetUsr                     10a
030000060729     D  PxStatus                     10a
030100060729     D  PxOutOpt                      3a
030200050226
030300050226      /Free
030400060729
030500060729        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
030600060729
030700060729          OpnDspApp( UIM.AppHdl
030800060729                   : PNLGRP_Q
030900060729                   : SCP_AUT_RCL
031000060729                   : PRM_IFC_0
031100060729                   : HLP_WDW
031200060729                   : ERRC0100
031300060729                   );
031400060729        Else;
031500060729          OpnPrtApp( UIM.AppHdl
031600060729                   : PNLGRP_Q
031700060729                   : SCP_AUT_RCL
031800060729                   : PRM_IFC_0
031900060729                   : APP_PRTF
032000060729                   : SPLF_NAM
032100060729                   : ODP_SHR
032200060729                   : SPLF_USRDTA
032300060729                   : ERRC0100
032400060729                   );
032500060729        EndIf;
032600060729
032700060729        If  ERRC0100.BytAvl > *Zero;
032800100319          ExSr  EscApiErr;
032900060729        EndIf;
033000060729
033100060729        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
033200060729
033300060729        ExSr  BldHdrRcd;
033400060729        ExSr  BldUsrLst;
033500060729
033600060729        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
033700060729          ExSr  DspLst;
033800060729        Else;
033900060729          ExSr  WrtLst;
034000060729        EndIf;
034100060424
034200060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
034300050226
034400050226        *InLr = *On;
034500050226        Return;
034600060412
034700060505
034800060729        BegSr  DspLst;
034900060729
035000060729          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
035100060729
035200060729            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
035300060729
035400100319            If  ERRC0100.BytAvl > *Zero;
035500100319              ExSr  EscApiErr;
035600100319            EndIf;
035700100319
035800060729            GetDlgVar( UIM.AppHdl
035900060729                     : HdrRcd
036000060729                     : %Size( HdrRcd )
036100060729                     : 'HDRRCD'
036200060729                     : ERRC0100
036300060729                     );
036400060729
036500060729            Select;
036600060729            When  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
036700060729              ExSr  GetLstPos;
036800060729              ExSr  DltUsrLst;
036900060729
037000060729            When  WrkUsr <> HdrRcd.WrkUsr;
037100060729              ExSr  DltUsrLst;
037200060729            EndSl;
037300060729
037400060729            Select;
037500060729            When  UIM.FncRqs = KEY_F05;
037600060730              ExSr  RstHdrRcd;
037700060729              ExSr  BldUsrLst;
037800060729              ExSr  SetLstPos;
037900060729
038000060729            When  WrkUsr <> HdrRcd.WrkUsr;
038100060729              WrkUsr = HdrRcd.WrkUsr;
038200060729
038300060729              ExSr  BldUsrLst;
038400060729            EndSl;
038500060729
038600060730            If  UIM.FncRqs = RTN_ENTER  And
038700060730                UIM.EntLocOpt = 'NEXT'  And
038800060730                HdrRcd.PosUsr > *Blanks;
038900060730
039000060730              ExSr  FndLstPos;
039100060729            EndIf;
039200060729
039300060729            ExSr  BldHdrRcd;
039400060729          EndDo;
039500060729
039600060729        EndSr;
039700060729
039800060729        BegSr  WrtLst;
039900060729
040000060729          PrtPnl( UIM.AppHdl
040100060729                : 'PRTHDR'
040200060729                : EJECT_NO
040300060729                : ERRC0100
040400060729                );
040500060729
040600060729          PrtPnl( UIM.AppHdl
040700060729                : 'PRTLST'
040800060729                : EJECT_NO
040900060729                : ERRC0100
041000060729                );
041100060729
041200060729          SndCmpMsg( 'List has been printed.' );
041300060729
041400060729        EndSr;
041500060729
041600060729        BegSr  BldUsrLst;
041700060504
041800060504          UIM.EntLocOpt = 'FRST';
041900060505
042000060729          LstSvrInf( ZLSL0900
042100060729                   : %Size( ZLSL0900 )
042200060729                   : LstInf
042300060729                   : 'ZLSL0900'
042400060729                   : *Blank
042500060729                   : ERRC0100
042600060729                   );
042700060729
042800060729          If  ERRC0100.BytAvl = *Zero;
042900060729
043000060729            For Idx = 1  to LstInf.RcdNbrTot;
043100060729              ExSr  PrcLstEnt;
043200060729            EndFor;
043300060729          EndIf;
043400060729
043500060504          SetLstAtr( UIM.AppHdl
043600060504                   : 'DTLLST'
043700060504                   : LIST_COMP
043800060504                   : EXIT_SAME
043900060504                   : POS_TOP
044000060504                   : TRIM_SAME
044100060504                   : ERRC0100
044200060504                   );
044300060504
044400060504        EndSr;
044500060506
044600060504        BegSr  PrcLstEnt;
044700060504
044800060729          LstEnt.NetUsr = ZLSL0900.DsaNetUsr(Idx);
044900060729
045000060729          If  HdrRcd.WrkUsr = '*ALL'  Or
045100060729              HdrRcd.WrkUsr = LstEnt.NetUsr  Or
045200060729              ChkGenStr( HdrRcd.WrkUsr: LstEnt.NetUsr ) = *On;
045300060506
045400060729            LstEnt.Option = *Zero;
045500060729            LstEnt.UsrSts = '*DISABLED';
045600060729            LstEnt.UsrTxt = GetUsrTxt( LstEnt.NetUsr );
045700060729
045800060729            AddLstEnt( UIM.AppHdl
045900060729                     : LstEnt
046000060729                     : %Size( LstEnt )
046100060729                     : 'DTLRCD'
046200060729                     : 'DTLLST'
046300060729                     : UIM.EntLocOpt
046400060729                     : UIM.LstHdl
046500060729                     : ERRC0100
046600060729                     );
046700060729
046800060729            UIM.EntLocOpt = 'NEXT';
046900060729          EndIf;
047000060504
047100060504        EndSr;
047200060504
047300060504        BegSr  GetLstPos;
047400060504
047500060504          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
047600060504
047700060504          If  LstAtr.DspPos <> 'TOP';
047800060504
047900060504            GetLstEnt( UIM.AppHdl
048000060504                     : LstEnt
048100060504                     : %Size( LstEnt )
048200060504                     : 'DTLRCD'
048300060504                     : 'DTLLST'
048400060504                     : 'HNDL'
048500060504                     : 'Y'
048600060504                     : *Blanks
048700060504                     : LstAtr.DspPos
048800060504                     : 'N'
048900060504                     : UIM.EntHdl
049000060504                     : ERRC0100
049100060504                     );
049200060504
049300060504            LstEntPos = LstEnt;
049400060504          EndIf;
049500060504
049600060504        EndSr;
049700060504
049800060504        BegSr  SetLstPos;
049900060504
050000060504          If  LstAtr.DspPos <> 'TOP';
050100060504
050200060504            LstEnt = LstEntPos;
050300060504
050400060504            PutDlgVar( UIM.AppHdl
050500060504                     : LstEnt
050600060504                     : %Size( LstEnt )
050700060504                     : 'DTLRCD'
050800060504                     : ERRC0100
050900060504                     );
051000060504
051100060504            GetLstEnt( UIM.AppHdl
051200060504                     : LstEnt
051300060504                     : %Size( LstEnt )
051400060504                     : '*NONE'
051500060504                     : 'DTLLST'
051600060504                     : 'FSLT'
051700060504                     : 'N'
051800060729                     : 'EQ        NETUSR'
051900060730                     : *Blanks
052000060504                     : 'N'
052100060504                     : UIM.EntHdl
052200060504                     : ERRC0100
052300060504                     );
052400060504
052500060504            If  ERRC0100.BytAvl = *Zero;
052600060504
052700060504              SetLstAtr( UIM.AppHdl
052800060504                       : 'DTLLST'
052900060504                       : LIST_SAME
053000060504                       : EXIT_SAME
053100060504                       : UIM.EntHdl
053200060504                       : TRIM_SAME
053300060504                       : ERRC0100
053400060504                       );
053500060504
053600060504            EndIf;
053700060504          EndIf;
053800060504
053900060504        EndSr;
054000060730
054100060730        BegSr  FndLstPos;
054200060730
054300060730          LstEnt.NetUsr = HdrRcd.PosUsr;
054400060730
054500060730          PutDlgVar( UIM.AppHdl
054600060730                   : LstEnt
054700060730                   : %Size( LstEnt )
054800060730                   : 'DTLRCD'
054900060730                   : ERRC0100
055000060730                   );
055100060730
055200060730          GetLstEnt( UIM.AppHdl
055300060730                   : LstEnt
055400060730                   : %Size( LstEnt )
055500060730                   : 'DTLRCD'
055600060730                   : 'DTLLST'
055700060730                   : 'FSLT'
055800060730                   : 'Y'
055900060730                   : 'GE        NETUSR'
056000060730                   : *Blanks
056100060730                   : 'N'
056200060730                   : UIM.EntHdl
056300060730                   : ERRC0100
056400060730                   );
056500060730
056600060730          Select;
056700060730          When  ERRC0100.BytAvl > *Zero;
056800060730            GetLstEnt( UIM.AppHdl
056900060730                     : LstEnt
057000060730                     : %Size( LstEnt )
057100060730                     : '*NONE'
057200060730                     : 'DTLLST'
057300060730                     : 'LAST'
057400060730                     : 'N'
057500060730                     : *Blanks
057600060730                     : *Blanks
057700060730                     : 'N'
057800060730                     : UIM.EntHdl
057900060730                     : ERRC0100
058000060730                     );
058100060730
058200060730          When  %Scan( %Trim( HdrRcd.PosUsr ): LstEnt.NetUsr ) <> 1;
058300060730            GetLstEnt( UIM.AppHdl
058400060730                     : LstEnt
058500060730                     : %Size( LstEnt )
058600060730                     : '*NONE'
058700060730                     : 'DTLLST'
058800060730                     : 'PREV'
058900060730                     : 'N'
059000060730                     : *Blanks
059100060730                     : *Blanks
059200060730                     : 'N'
059300060730                     : UIM.EntHdl
059400060730                     : ERRC0100
059500060730                     );
059600060730
059700060730            If  ERRC0100.BytAvl > *Zero;
059800060730              GetLstEnt( UIM.AppHdl
059900060730                       : LstEnt
060000060730                       : %Size( LstEnt )
060100060730                       : '*NONE'
060200060730                       : 'DTLLST'
060300060730                       : 'FRST'
060400060730                       : 'N'
060500060730                       : *Blanks
060600060730                       : *Blanks
060700060730                       : 'N'
060800060730                       : UIM.EntHdl
060900060730                       : ERRC0100
061000060730                       );
061100060730            EndIf;
061200060730          EndSl;
061300060730
061400060730          If  ERRC0100.BytAvl = *Zero;
061500060730
061600060730            SetLstAtr( UIM.AppHdl
061700060730                     : 'DTLLST'
061800060730                     : LIST_SAME
061900060730                     : EXIT_SAME
062000060730                     : UIM.EntHdl
062100060730                     : TRIM_SAME
062200060730                     : ERRC0100
062300060730                     );
062400060730
062500060730          EndIf;
062600060730
062700060730          HdrRcd.PosUsr = *Blanks;
062800060730
062900060730        EndSr;
063000060504
063100060504        BegSr  BldHdrRcd;
063200060504
063300060504          SysDts = %Timestamp();
063400060504
063500060511          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
063600060511          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
063700060511          HdrRcd.TimZon = '*SYS';
063800060504
063900060511          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
064000060504
064100060504        EndSr;
064200060729
064300060730        BegSr  RstHdrRcd;
064400060730
064500060730          HdrRcd.WrkUsr = WrkUsr;
064600060730          HdrRcd.PosUsr = *Blanks;
064700060730
064800060730        EndSr;
064900060730
065000060729        BegSr  *InzSr;
065100060729
065200060729          HdrRcd.WrkUsr = PxNetUsr;
065300060729          HdrRcd.WrkSts = PxStatus;
065400060729          HdrRcd.PosUsr = *Blanks;
065500060729
065600060729          WrkUsr = HdrRcd.WrkUsr;
065700060729
065800060729        EndSr;
065900060504
066000060504        BegSr  DltUsrLst;
066100060504
066200060504          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
066300060504
066400060504        EndSr;
066500060519
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
067800100319
067900050226      /End-Free
068000060428
068100060729     **-- Get job type:
068200060729     P GetJobTyp       B
068300060729     D                 Pi             1a
068400060729
068500060729     D JOBI0400        Ds                  Qualified
068600060729     D  BytRtn                       10i 0
068700060729     D  BytAvl                       10i 0
068800060729     D  JobNam                       10a
068900060729     D  UsrNam                       10a
069000060729     D  JobNbr                        6a
069100060729     D  JobIntId                     16a
069200060729     D  JobSts                       10a
069300060729     D  JobTyp                        1a
069400060729     D  JobSubTyp                     1a
069500060729
069600060729      /Free
069700060729
069800060729        RtvJobInf( JOBI0400
069900060729                 : %Size( JOBI0400 )
070000060729                 : 'JOBI0400'
070100060729                 : '*'
070200060729                 : *Blank
070300060729                 : ERRC0100
070400060729                 );
070500060729
070600060729        If  ERRC0100.BytAvl > *Zero;
070700060729          Return  *Blank;
070800060729
070900060729        Else;
071000060729          Return  JOBI0400.JobTyp;
071100060729        EndIf;
071200060729
071300060729      /End-Free
071400060729
071500060729     P GetJobTyp       E
071600060729     **-- Get user text:
071700060729     P GetUsrTxt       B
071800060729     D                 Pi            50a   Varying
071900060729     D  PxUsrPrf                     10a   Value
072000060729     **
072100060729     D USRI0300        Ds                  Qualified
072200060729     D  BytRtn                       10i 0
072300060729     D  BytAvl                       10i 0
072400060729     D  UsrPrf                       10a
072500060729     D  UsrTxt                       50a   Overlay( USRI0300: 199 )
072600060729
072700060729      /Free
072800060729
072900060729        RtvUsrInf( USRI0300
073000060729                 : %Size( USRI0300 )
073100060729                 : 'USRI0300'
073200060729                 : PxUsrPrf
073300060729                 : ERRC0100
073400060729                 );
073500060729
073600060729        If  ERRC0100.BytAvl > *Zero;
073700060729          Return  NULL;
073800060729
073900060729        Else;
074000060729          Return  %Trim( USRI0300.UsrTxt );
074100060729        EndIf;
074200060729
074300060729      /End-Free
074400060729
074500060729     P GetUsrTxt       E
074600060729     **-- Check generic string:
074700060729     P ChkGenStr       B
074800060729     D                 Pi              n
074900060729     D  PxCmpStr                    256a   Const  Varying
075000060729     D  PxChkStr                    256a   Const  Varying
075100060729
075200060729     D  ChkLen         s             10i 0
075300060729
075400060729      /Free
075500060729
075600060729        ChkLen =  %Scan( '*': PxCmpStr ) - 1;
075700060729
075800060729        If  ChkLen > *Zero;
075900060729          Return  %Scan( %Subst( PxCmpStr: 1: ChkLen ): PxChkStr ) = 1;
076000060729
076100060729        Else;
076200060729          Return  *Off;
076300060729        EndIf;
076400060729
076500060729      /End-Free
076600060729
076700060729     P ChkGenStr       E
076800060729     **-- Send completion message:
076900060729     P SndCmpMsg       B
077000060729     D                 Pi            10i 0
077100060729     D  PxMsgDta                    512a   Const  Varying
077200060729     **
077300060729     D MsgKey          s              4a
077400060729
077500060729      /Free
077600060729
077700060729        SndPgmMsg( 'CPF9897'
077800060729                 : 'QCPFMSG   *LIBL'
077900060729                 : PxMsgDta
078000060729                 : %Len( PxMsgDta )
078100060729                 : '*COMP'
078200060729                 : '*PGMBDY'
078300060729                 : 1
078400060729                 : MsgKey
078500060729                 : ERRC0100
078600060729                 );
078700060729
078800060729        If  ERRC0100.BytAvl > *Zero;
078900060729          Return  -1;
079000060729
079100060729        Else;
079200060729          Return  0;
079300060729
079400060729        EndIf;
079500060729
079600060729      /End-Free
079700060729
079800060729     P SndCmpMsg       E
079900060504     **-- Send escape message:
080000060504     P SndEscMsg       B
080100060504     D                 Pi            10i 0
080200060504     D  PxMsgId                       7a   Const
080300060504     D  PxMsgF                       10a   Const
080400060504     D  PxMsgDta                    512a   Const  Varying
080500060504     **
080600060504     D MsgKey          s              4a
080700060504
080800060504      /Free
080900060504
081000060504        SndPgmMsg( PxMsgId
081100060504                 : PxMsgF + '*LIBL'
081200060504                 : PxMsgDta
081300060504                 : %Len( PxMsgDta )
081400060504                 : '*ESCAPE'
081500060504                 : '*PGMBDY'
081600060504                 : 1
081700060504                 : MsgKey
081800060504                 : ERRC0100
081900060504                 );
082000060504
082100060504        If  ERRC0100.BytAvl > *Zero;
082200060504          Return  -1;
082300060504
082400060504        Else;
082500060504          Return   0;
082600060504        EndIf;
082700060504
082800060504      /End-Free
082900060504
083000060504     P SndEscMsg       E
