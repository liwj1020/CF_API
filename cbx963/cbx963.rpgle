000100060310     **
000200061104     **  Program . . : CBX963
000300061104     **  Description : Display Server Share - CPP
000400061022     **  Author  . . : Carsten Flensburg
000500061104     **  Published . : System iNetwork Systems Management Tips Newsletter
000600061022     **
000700060310     **
000800060310     **  Programmer's notes:
000900061107     **    Activation group *NEW to avoid risk of recursive calls and
001000061107     **    ensure resource scoping and clean-up.
001100061107     **
001200061107     **
001300060310     **  Compile options:
001400061104     **    CrtRpgMod  Module( CBX963 )
001500060310     **               DbgView( *LIST )
001600060310     **
001700061104     **    CrtPgm     Pgm( CBX963 )
001800061104     **               Module( CBX963 )
001900060310     **               ActGrp( *NEW )
002000060310     **
002100060310     **
002200060310     **-- Header specifications:  --------------------------------------------**
002300060310     H Option( *SrcStmt )
002400060221
002500060221     **-- Api error data structure:
002600060220     D ERRC0100        Ds                  Qualified
002700060220     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
002800060220     D  BytAvl                       10i 0 Inz
002900060220     D  MsgId                         7a
003000021009     D                                1a
003100061022     D  MsgDta                      512a
003200061104
003300060310     **-- Global constants:
003400060310     D OFS_MSGDTA      c                   16
003500061104     **-- Global variables:
003600061104     D Idx             s             10i 0
003700061104     D SysDts          s               z
003800061104     D Path            s           1024a   Varying
003900061104
004000061104     **-- File extension table:
004100061104     D FilExtTbl       Ds                  Qualified
004200061104     D  TblEnt                             Dim( 128 )
004300061104     D   ExtLen                      10i 0 Overlay( TblEnt: 1 )
004400061104     D   FilExt                      46a   Overlay( TblEnt: 5 )
004500061104     **-- List information:
004600061104     D ZLSL0101        Ds         32767    Qualified
004700061104     D  EntLen                       10i 0
004800061104     D  Share                        12a
004900061104     D  DevTyp                       10i 0
005000061104     D  Permis                       10i 0
005100061104     D  MaxUsr                       10i 0
005200061104     D  CurUsr                       10i 0
005300061104     D  SpfTyp                       10i 0
005400061104     D  OfsPthNam                    10i 0
005500061104     D  LenPthNam                    10i 0
005600061104     D  OutQue_q                     20a
005700061104     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
005800061104     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
005900061104     D  PrtDrv                       50a
006000061104     D  TxtDsc                       50a
006100061104     D  PrtFil_q                     20a
006200061104     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
006300061104     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
006400061104     D  TxtCcsId                     10i 0
006500061104     D  OfsExtTbl                    10i 0
006600061104     D  NbrTblEnt                    10i 0
006700061104     D  EnbTxtCnv                     1a
006800061104     D  Publish                       1a
006900061104     **-- List information:
007000061104     D LstInf          Ds                  Qualified
007100061104     D  RcdNbrTot                    10i 0
007200061104     D  RcdNbrRtn                    10i 0
007300061104     D  RcdLen                       10i 0
007400061104     D  InfLen                       10i 0
007500061104     D  InfSts                        1a
007600061104     D  Dts                          13a
007700061104     D                               34a
007800061104
007900061028     **-- UIM constants:
008000061104     D PNLGRP_Q        c                   'CBX963P   *LIBL     '
008100061104     D PNLGRP          c                   'CBX963P   '
008200061028     D SCP_AUT_RCL     c                   -1
008300061028     D RDS_OPT_INZ     c                   'N'
008400061028     D PRM_IFC_0       c                   0
008500061028     D CLO_NORM        c                   'M'
008600061028     D FNC_EXIT        c                   -4
008700061028     D FNC_CNL         c                   -8
008800061028     D KEY_F05         c                   5
008900061028     D RTN_ENTER       c                   500
009000061028     D INC_EXP         c                   'Y'
009100061028     D CPY_VAR         c                   'Y'
009200061028     D CPY_VAR_NO      c                   'N'
009300061028     D HLP_WDW         c                   'N'
009400061028     D POS_TOP         c                   'TOP'
009500061028     D POS_BOT         c                   'BOT'
009600061028     D LIST_COMP       c                   'ALL'
009700061028     D LIST_SAME       c                   'SAME'
009800061028     D EXIT_SAME       c                   '*SAME'
009900061028     D DSPA_SAME       c                   'SAME'
010000061028     D TRIM_SAME       c                   'S'
010100061028     **
010200061028     D APP_PRTF        c                   'QPRINT    *LIBL'
010300061028     D ODP_SHR         c                   'N'
010400061104     D SPLF_NAM        c                   'PDSPSVRSHR'
010500061104     D SPLF_USRDTA     c                   'DSPSVRSHR'
010600061028     D EJECT_NO        c                   'N'
010700060310
010800061028     **-- UIM variables:
010900061028     D UIM             Ds                  Qualified
011000061028     D  AppHdl                        8a
011100061028     D  FncRqs                       10i 0 Inz
011200061105     **-- UIM Panel exit program record:
011300061105     D ExpRcd          Ds                  Qualified
011400061105     D  ExitPg                       20a   Inz( 'CBX963E   *LIBL' )
011500061028     **-- UIM Panel header record:
011600061028     D HdrRcd          Ds                  Qualified  Inz
011700061028     D  SysDat                        7a
011800061028     D  SysTim                        6a
011900061028     D  TimZon                       10a
012000061104     D  Share                        12a
012100061104     D  DevTyp                        1s 0
012200061104     D  TxtDsc                       50a
012300061028     **-- UIM Detail record:
012400061028     D DtlRcd          Ds                  Qualified
012500061104     D  Permis                        1s 0
012600061104     D  MaxUsr                       10i 0
012700061104     D  CurUsr                       10i 0
012800061104     D  SpfTyp                        1s 0
012900061104     D  Path                       1000a
013000061104     D  Path_s                      256a
013100061104     D  OutQue_q                     20a
013200061104     D  PrtDrv                       50a
013300061104     D  PrtFil_q                     20a
013400061104     D  EnbTxtCnv                     1a
013500061104     D  PubPrtShr                     1a
013600061105     D  NbrFilExt                     3s 0
013700061105     D  FilExt                     1000a
013800060220
013900061104     **-- Open list of server information:
014000061104     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
014100061104     D  RcvVar                    32767a          Options( *VarSize )
014200061104     D  RcvVarLen                    10i 0 Const
014300061104     D  LstInf                       64a
014400061104     D  Format                        8a   Const
014500061104     D  InfQual                      15a   Const
014600061104     D  Error                     32767a          Options( *VarSize )
014700061104     D  SsnUsr                       10a   Const  Options( *NoPass )
014800061104     D  SsnId                        20u 0 Const  Options( *NoPass )
014900061028     **-- Retrieve job information:
015000061028     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
015100061028     D  RcvVar                    32767a         Options( *VarSize )
015200061028     D  RcvVarLen                    10i 0 Const
015300061028     D  FmtNam                        8a   Const
015400061028     D  JobNamQ                      26a   Const
015500061028     D  JobIntId                     16a   Const
015600061028     D  Error                     32767a         Options( *NoPass: *VarSize )
015700060310     **-- Send program message:
015800060310     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
015900060310     D  MsgId                         7a   Const
016000060310     D  MsgFq                        20a   Const
016100060310     D  MsgDta                      128a   Const
016200060310     D  MsgDtaLen                    10i 0 Const
016300060310     D  MsgTyp                       10a   Const
016400060310     D  CalStkE                      10a   Const  Options( *VarSize )
016500060310     D  CalStkCtr                    10i 0 Const
016600060310     D  MsgKey                        4a
016700060310     D  Error                     32767a          Options( *VarSize )
016800061028     **-- Open display application:
016900061028     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
017000061028     D  AppHdl                        8a
017100061028     D  PnlGrp_q                     20a   Const
017200061028     D  AppScp                       10i 0 Const
017300061028     D  ExtPrmIfc                    10i 0 Const
017400061028     D  FulScrHlp                     1a   Const
017500061028     D  Error                     32767a          Options( *VarSize )
017600061028     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
017700061028     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
017800061028     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
017900061028     **-- Open print application:
018000061028     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
018100061028     D  AppHdl                        8a
018200061028     D  PnlGrp_q                     20a   Const
018300061028     D  AppScp                       10i 0 Const
018400061028     D  ExtPrmIfc                    10i 0 Const
018500061028     D  PrtDevF_q                    20a   Const
018600061028     D  AltFilNam                    10a   Const
018700061028     D  ShrOpnDtaPth                  1a   Const
018800061028     D  UsrDta                       10a   Const
018900061028     D  Error                     32767a          Options( *VarSize )
019000061028     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
019100061028     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
019200061028     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
019300061028     **-- Display panel:
019400061028     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
019500061028     D  AppHdl                        8a   Const
019600061028     D  FncRqs                       10i 0
019700061028     D  PnlNam                       10a   Const
019800061028     D  ReDspOpt                      1a   Const
019900061028     D  Error                     32767a          Options( *VarSize )
020000061028     D  UsrTsk                        1a   Const  Options( *NoPass )
020100061028     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
020200061028     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
020300061028     D  MsgKey                        4a   Const  Options( *NoPass )
020400061028     D  CsrPosOpt                     1a   Const  Options( *NoPass )
020500061028     D  FinLstEnt                     4a   Const  Options( *NoPass )
020600061028     D  ErrLstEnt                     4a   Const  Options( *NoPass )
020700061028     D  WaitTim                      10i 0 Const  Options( *NoPass )
020800061028     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
020900061028     D  CalQlf                       20a   Const  Options( *NoPass )
021000061028     **-- Print panel:
021100061028     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
021200061028     D  AppHdl                        8a   Const
021300061028     D  PrtPnlNam                    10a   Const
021400061028     D  EjtOpt                        1a   Const
021500061028     D  Error                     32767a          Options( *VarSize )
021600061028     **-- Put dialog variable:
021700061028     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
021800061028     D  AppHdl                        8a   Const
021900061028     D  VarBuf                    32767a   Const  Options( *VarSize )
022000061028     D  VarBufLen                    10i 0 Const
022100061028     D  VarRcdNam                    10a   Const
022200061028     D  Error                     32767a          Options( *VarSize )
022300061028     **-- Close application:
022400061028     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
022500061028     D  AppHdl                        8a   Const
022600061028     D  CloOpt                        1a   Const
022700061028     D  Error                     32767a          Options( *VarSize )
022800060310
022900061028     **-- Get job type:
023000061028     D GetJobTyp       Pr             1a
023100061105     **-- Format file extension:
023200061105     D FmtFilExt       Pr          1000a   Varying
023300061105     D  PxFilExtTbl                        LikeDs( FilExtTbl )
023400061105     D                                     Const
023500061105     D  PxNbrFilEnt                  10i 0 Const
023600060310     **-- Send escape message:
023700060310     D SndEscMsg       Pr            10i 0
023800060310     D  PxMsgId                       7a   Const
023900060310     D  PxMsgF                       10a   Const
024000060310     D  PxMsgDta                    512a   Const  Varying
024100060310     **-- Send completion message:
024200060310     D SndCmpMsg       Pr            10i 0
024300060310     D  PxMsgDta                    512a   Const  Varying
024400060220
024500060221     **-- Program entry:
024600061104     D CBX963          Pr
024700061104     D  PxShare                      12a
024800061104     D  PxOutOpt                      3a
024900060221     **
025000061104     D CBX963          Pi
025100061104     D  PxShare                      12a
025200061104     D  PxOutOpt                      3a
025300060221
025400060221      /Free
025500060310
025600061028        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
025700061028
025800061028          OpnDspApp( UIM.AppHdl
025900061028                   : PNLGRP_Q
026000061028                   : SCP_AUT_RCL
026100061028                   : PRM_IFC_0
026200061028                   : HLP_WDW
026300061028                   : ERRC0100
026400061028                   );
026500061028        Else;
026600061028          OpnPrtApp( UIM.AppHdl
026700061028                   : PNLGRP_Q
026800061028                   : SCP_AUT_RCL
026900061028                   : PRM_IFC_0
027000061028                   : APP_PRTF
027100061028                   : SPLF_NAM
027200061028                   : ODP_SHR
027300061028                   : SPLF_USRDTA
027400061028                   : ERRC0100
027500061028                   );
027600061028        EndIf;
027700061028
027800061028        If  ERRC0100.BytAvl > *Zero;
027900100319          ExSr  EscApiErr;
028000061028        EndIf;
028100061028
028200061105        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
028300061105
028400061104        ExSr  BldShrDsp;
028500061028        ExSr  BldHdrRcd;
028600061028
028700061028        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
028800061028          ExSr  DspLst;
028900061028        Else;
029000061028          ExSr  WrtLst;
029100061028        EndIf;
029200061028
029300061028        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
029400061028
029500060221        *InLr = *On;
029600060221        Return;
029700060221
029800061028
029900061104        BegSr  BldShrDsp;
030000061028
030100061104          LstSvrInf( ZLSL0101
030200061104                   : %Len( ZLSL0101 )
030300061104                   : LstInf
030400061104                   : 'ZLSL0101'
030500061104                   : PxShare
030600061104                   : ERRC0100
030700061104                   );
030800061104
030900061106          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrRtn = 1;
031000061104            ExSr  PutDtlRcd;
031100061104          EndIf;
031200061028
031300061028        EndSr;
031400061028
031500061028        BegSr  PutDtlRcd;
031600061104
031700061104          Path = %Subst( ZLSL0101
031800061104                       : ZLSL0101.OfsPthNam + 1
031900061104                       : ZLSL0101.LenPthNam
032000061104                       );
032100061028
032200061105          FilExtTbl = %Subst( ZLSL0101
032300061105                            : ZLSL0101.OfsExtTbl + 1
032400061105                            : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
032500061105                            );
032600061105
032700061104          DtlRcd.Permis      = ZLSL0101.Permis;
032800061104          DtlRcd.MaxUsr      = ZLSL0101.MaxUsr;
032900061104          DtlRcd.CurUsr      = ZLSL0101.CurUsr;
033000061104          DtlRcd.SpfTyp      = ZLSL0101.SpfTyp;
033100061104          DtlRcd.Path        = Path;
033200061104          DtlRcd.Path_s      = Path;
033300061104          DtlRcd.OutQue_q    = ZLSL0101.OutQue_q;
033400061104          DtlRcd.PrtDrv      = ZLSL0101.PrtDrv;
033500061104          DtlRcd.PrtFil_q    = ZLSL0101.PrtFil_q;
033600061104          DtlRcd.NbrFilExt   = ZLSL0101.NbrTblEnt;
033700061104          DtlRcd.EnbTxtCnv   = ZLSL0101.EnbTxtCnv;
033800061104          DtlRcd.PubPrtShr   = ZLSL0101.Publish;
033900061105          DtlRcd.FilExt      = FmtFilExt( FilExtTbl: ZLSL0101.NbrTblEnt );
034000061028
034100061028          PutDlgVar( UIM.AppHdl: DtlRcd: %Size( DtlRcd ): 'DTLRCD': ERRC0100 );
034200061028
034300061028        EndSr;
034400061028
034500061028        BegSr  DspLst;
034600061028
034700061028          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
034800061028
034900061028            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
035000061028
035100100319            Select;
035200100319            When  ERRC0100.BytAvl > *Zero;
035300100319              ExSr  EscApiErr;
035400100319
035500100319            When  UIM.FncRqs = RTN_ENTER;
035600061028              Leave;
035700061028
035800100319            When  UIM.FncRqs = KEY_F05;
035900061104              ExSr  BldShrDsp;
036000100319            EndSl;
036100061028
036200061028            ExSr  BldHdrRcd;
036300061028          EndDo;
036400061028
036500061028        EndSr;
036600061028
036700061028        BegSr  WrtLst;
036800061028
036900061028          PrtPnl( UIM.AppHdl
037000061028                : 'PRTHDR'
037100061028                : EJECT_NO
037200061028                : ERRC0100
037300061028                );
037400061028
037500061028          PrtPnl( UIM.AppHdl
037600061028                : 'PRTDTL'
037700061028                : EJECT_NO
037800061028                : ERRC0100
037900061028                );
038000061028
038100061028          SndCmpMsg( 'List has been printed.' );
038200061028
038300061028        EndSr;
038400061028
038500061028        BegSr  BldHdrRcd;
038600061028
038700061028          SysDts = %Timestamp();
038800061028
038900061028          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
039000061028          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
039100061028          HdrRcd.TimZon = '*SYS';
039200061028
039300061104          HdrRcd.Share  = ZLSL0101.Share;
039400061104          HdrRcd.DevTyp = ZLSL0101.DevTyp;
039500061104          HdrRcd.TxtDsc = ZLSL0101.TxtDsc;
039600061028
039700061028          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
039800061028
039900061028        EndSr;
040000100319
040100100319        BegSr  EscApiErr;
040200100319
040300100319          If  ERRC0100.BytAvl < OFS_MSGDTA;
040400100319            ERRC0100.BytAvl = OFS_MSGDTA;
040500100319          EndIf;
040600100319
040700100319          SndEscMsg( ERRC0100.MsgId
040800100319                   : 'QCPFMSG'
040900100319                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
041000100319                   );
041100100319
041200100319        EndSr;
041300100319
041400060310      /End-Free
041500060310
041600061028     **-- Get job type:
041700061028     P GetJobTyp       B
041800061028     D                 Pi             1a
041900061028
042000061028     D JOBI0400        Ds                  Qualified
042100061028     D  BytRtn                       10i 0
042200061028     D  BytAvl                       10i 0
042300061028     D  JobNam                       10a
042400061028     D  UsrNam                       10a
042500061028     D  JobNbr                        6a
042600061028     D  JobIntId                     16a
042700061028     D  JobSts                       10a
042800061028     D  JobTyp                        1a
042900061028     D  JobSubTyp                     1a
043000061028
043100061028      /Free
043200061028
043300061028        RtvJobInf( JOBI0400
043400061028                 : %Size( JOBI0400 )
043500061028                 : 'JOBI0400'
043600061028                 : '*'
043700061028                 : *Blank
043800061028                 : ERRC0100
043900061028                 );
044000061028
044100061028        If  ERRC0100.BytAvl > *Zero;
044200061028          Return  *Blank;
044300061028
044400061028        Else;
044500061028          Return  JOBI0400.JobTyp;
044600061028        EndIf;
044700061028
044800061028      /End-Free
044900061028
045000061028     P GetJobTyp       E
045100061105     **-- Format file extension:  --------------------------------------------**
045200061105     P FmtFilExt       B
045300061105     D                 Pi          1000a   Varying
045400061105     D  PxFilExtTbl                        LikeDs( FilExtTbl )
045500061105     D                                     Const
045600061105     D  PxNbrFilEnt                  10i 0 Const
045700061105
045800061105     D Idx             s             10i 0
045900061105     D FilExt          s             46a   Varying
046000061105     D RtnStr          s           1000a   Varying
046100061105
046200061105      /Free
046300061105
046400061105          For  Idx = 1  to  PxNbrFilEnt;
046500061105            FilExt = %Subst( PxFilExtTbl.FilExt(Idx)
046600061105                           : 1
046700061105                           : PxFilExtTbl.ExtLen(Idx)
046800061105                           );
046900061105
047000061105            Select;
047100061105            When  FilExt = '*';
047200061105              RtnStr += '*ALL';
047300061105
047400061105            When  FilExt = '.';
047500061105              RtnStr += '*NOEXT';
047600061105
047700061105            Other;
047800061105              RtnStr += '''' + FilExt + ''' ';
047900061105            EndSl;
048000061105          EndFor;
048100061105
048200061105          Return  %TrimR( RtnStr );
048300061105
048400061105      /End-Free
048500061105
048600061105     P FmtFilExt       E
048700061028     **-- Send escape message:
048800060310     P SndEscMsg       B
048900060310     D                 Pi            10i 0
049000060310     D  PxMsgId                       7a   Const
049100060310     D  PxMsgF                       10a   Const
049200060310     D  PxMsgDta                    512a   Const  Varying
049300060310     **
049400060310     D MsgKey          s              4a
049500060310
049600060310      /Free
049700060310
049800060310        SndPgmMsg( PxMsgId
049900060310                 : PxMsgF + '*LIBL'
050000060310                 : PxMsgDta
050100060310                 : %Len( PxMsgDta )
050200060310                 : '*ESCAPE'
050300060310                 : '*PGMBDY'
050400060310                 : 1
050500060310                 : MsgKey
050600060310                 : ERRC0100
050700060310                 );
050800060310
050900060310        If  ERRC0100.BytAvl > *Zero;
051000060310          Return  -1;
051100060310
051200060310        Else;
051300060310          Return   0;
051400060310        EndIf;
051500060310
051600060310      /End-Free
051700060310
051800060310     P SndEscMsg       E
051900060310     **-- Send completion message:
052000060310     P SndCmpMsg       B
052100060310     D                 Pi            10i 0
052200060310     D  PxMsgDta                    512a   Const  Varying
052300060310     **
052400060310     D MsgKey          s              4a
052500060310
052600060310      /Free
052700060310
052800060310        SndPgmMsg( 'CPF9897'
052900060310                 : 'QCPFMSG   *LIBL'
053000060310                 : PxMsgDta
053100060310                 : %Len( PxMsgDta )
053200060310                 : '*COMP'
053300060310                 : '*PGMBDY'
053400060310                 : 1
053500060310                 : MsgKey
053600060310                 : ERRC0100
053700060310                 );
053800060310
053900060310        If  ERRC0100.BytAvl > *Zero;
054000060310          Return  -1;
054100060310
054200060310        Else;
054300060310          Return  0;
054400060310
054500060310        EndIf;
054600060310
054700060310      /End-Free
054800060310
054900060310     **
055000060310     P SndCmpMsg       E
