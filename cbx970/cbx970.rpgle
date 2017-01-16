000100060505     **
000200070429     **  Program . . : CBX970
000300070502     **  Description : Work with Journal 2 - CCP
000400060825     **  Author  . . : Carsten Flensburg
000500070429     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060505     **
000700060505     **
000800060505     **
000900060505     **  Compile options:
001000070429     **    CrtRpgMod   Module( CBX970 )
001100050310     **                DbgView( *LIST )
001200050310     **
001300070429     **    CrtPgm      Pgm( CBX970 )
001400070429     **                Module( CBX970 )
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
003000070429     D JRN_RCVDIR      c                   1
003100060424     **
003200060424     D BIN_SGN         c                   0
003300060509     D NUM_ZON         c                   2
003400060424     D CHAR_NLS        c                   4
003500060509     D SORT_ASC        c                   '1'
003600060504     **-- UIM constants:
003700070429     D PNLGRP_Q        c                   'CBX970P   *LIBL     '
003800070429     D PNLGRP          c                   'CBX970P   '
003900060504     D SCP_AUT_RCL     c                   -1
004000060504     D RDS_OPT_INZ     c                   'N'
004100060504     D PRM_IFC_0       c                   0
004200060504     D CLO_NORM        c                   'M'
004300060504     D FNC_EXIT        c                   -4
004400060504     D FNC_CNL         c                   -8
004500060504     D KEY_F05         c                   5
004600060825     D KEY_F17         c                   17
004700060825     D KEY_F18         c                   18
004800060504     D KEY_F24         c                   24
004900060506     D RTN_ENTER       c                   500
005000060504     D HLP_WDW         c                   'N'
005100060504     D POS_TOP         c                   'TOP'
005200060504     D POS_BOT         c                   'BOT'
005300060504     D LIST_COMP       c                   'ALL'
005400060504     D LIST_SAME       c                   'SAME'
005500060504     D EXIT_SAME       c                   '*SAME'
005600060504     D TRIM_SAME       c                   'S'
005700060825     **
005800060825     D APP_PRTF        c                   'QPRINT    *LIBL'
005900060825     D ODP_SHR         c                   'N'
006000070429     D SPLF_NAM        c                   'PLSTJRNX'
006100070502     D SPLF_USRDTA     c                   'WRKJRN2'
006200060825     D EJECT_NO        c                   'N'
006300060504
006400060424     **-- Global variables:
006500060506     D Idx             s             10i 0
006600060506     D SysDts          s               z
006700070429     D ApiRcvSiz       s             10u 0
006800060504     **
006900060504     D ObjNam_q        Ds
007000060504     D  ObjNam                       10a
007100060504     D  ObjLib                       10a
007200060504
007300060504     **-- UIM variables:
007400060504     D UIM             Ds                  Qualified
007500060504     D  AppHdl                        8a
007600060504     D  LstHdl                        4a
007700060504     D  EntHdl                        4a
007800060504     D  FncRqs                       10i 0
007900060504     D  EntLocOpt                     4a
008000060504     D  LstPos                        4a
008100060504     **-- List attributes structure:
008200060504     D LstAtr          Ds                  Qualified
008300060504     D  LstCon                        4a
008400060504     D  ExtPgmVar                    10a
008500060504     D  DspPos                        4a
008600060504     D  AlwTrim                       1a
008700060505
008800060829     **-- UIM Panel exit program record:
008900060511     D ExpRcd          Ds                  Qualified
009000070429     D  ExitPg                       20a   Inz( 'CBX970E   *LIBL' )
009100060511     **-- UIM Panel header record:
009200060511     D HdrRcd          Ds                  Qualified
009300060504     D  SysDat                        7a
009400060504     D  SysTim                        6a
009500060504     D  TimZon                       10a
009600070429     D  JrnNam                       10a
009700070429     D  JrnLib                       10a
009800060504     **-- UIM List entry:
009900060504     D LstEnt          Ds                  Qualified
010000060504     D  Option                        5i 0
010100070429     D  JrnPos                       20a
010200070429     D  JrnNam                       10a
010300070429     D  JrnLib                       10a
010400070429     D  JrnTyp                        1a
010500070429     D  JrnStt                        1a
010600070429     D  NbrRcv                        7s 0
010700070429     D  CurSeqNbr                    20s 0
010800070429     D  RcvDirSiz                    20s 0
010900070429     D  AtcRcvNam                    10a
011000070429     D  AtcRcvLib                    10a
011100070429     D  OldRcvNam                    10a
011200070429     D  OldRcvLib                    10a
011300070429     D  JrnDscTxt                    50a
011400070430     D  AspDevNam                    10a
011500060504     **
011600060504     D LstEntPos       Ds                  LikeDs( LstEnt )
011700060504
011800060506     **-- List API parameters:
011900060506     D LstApi          Ds                  Qualified  Inz
012000060506     D  RtnRcdNbr                    10i 0 Inz( 1 )
012100060506     D  NbrKeyRtn                    10i 0 Inz( *Zero )
012200060506     D  KeyFld                       10i 0 Dim( 1 )
012300060411
012400060826     **-- Object information:
012500060826     D ObjInf          Ds          4096    Qualified
012600060826     D  ObjNam_q                     20a
012700060826     D   ObjNam                      10a   Overlay( ObjNam_q: 1 )
012800060826     D   ObjLib                      10a   Overlay( ObjNam_q: *Next )
012900060826     D  ObjTyp                       10a
013000060826     D  InfSts                        1a
013100060826     D                                1a
013200060826     D  FldNbrRtn                    10i 0
013300060826     D  Data                               Like( KeyInf )
013400060826     **-- Key information:
013500060826     D KeyInf          Ds                  Qualified  Based( pKeyInf )
013600060826     D  FldInfLen                    10i 0
013700060826     D  KeyFld                       10i 0
013800060826     D  DtaTyp                        1a
013900060826     D                                3a
014000060826     D  DtaLen                       10i 0
014100060826     D  Data                        256a
014200060506     **-- Authority control:
014300060506     D AutCtl          Ds                  Qualified
014400060506     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
014500060506     D  CalLvl                       10i 0 Inz( 0 )
014600060506     D  DplObjAut                    10i 0 Inz( 0 )
014700060506     D  NbrObjAut                    10i 0 Inz( 0 )
014800060506     D  DplLibAut                    10i 0 Inz( 0 )
014900060506     D  NbrLibAut                    10i 0 Inz( 0 )
015000060506     D                               10i 0 Inz( 0 )
015100060506     D  ObjAut                       10a   Dim( 10 )
015200060506     D  LibAut                       10a   Dim( 10 )
015300060506     **-- Selection control:
015400060506     D SltCtl          Ds
015500060506     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
015600060506     D  SltOmt                       10i 0 Inz( 0 )
015700060506     D  DplSts                       10i 0 Inz( 20 )
015800060506     D  NbrSts                       10i 0 Inz( 1 )
015900060506     D                               10i 0 Inz( 0 )
016000060506     D  Status                        1a   Inz( '*' )
016100070429
016200070429     **-- Journal information:
016300070429     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
016400070429     D  BytRtn                       10i 0
016500070429     D  BytAvl                       10i 0
016600070429     D  OfsKeyInf                    10i 0
016700070429     D  JrnNam_q                     20a
016800070429     D   JrnNam                      10a   Overlay( JrnNam_q: 1 )
016900070429     D   JrnLib                      10a   Overlay( JrnNam_q: *Next )
017000070429     D  ASP                          10i 0
017100070429     D  MsgQueNam                    10a
017200070429     D  MsgQueLib                    10a
017300070429     D  MngRcvOpt                     1a
017400070429     D  DltRcvOpt                     1a
017500070429     D  RsoRit                        1a
017600070429     D  RsoMfl                        1a
017700070429     D  RsoMo1                        1a
017800070429     D  RsoMo2                        1a
017900070429     D  Rsv1                          3a
018000070429     D  JrnTyp                        1a
018100070429     D  RmtJrnTyp                     1a
018200070429     D  JrnStt                        1a
018300070429     D  JrnDlvMod                     1a
018400070429     D  LocJrnNam                    10a
018500070429     D  LocJrnLib                    10a
018600070429     D  LocJrnSys                     8a
018700070429     D  SrcJrnNam                    10a
018800070429     D  SrcJrnLib                    10a
018900070429     D  SrcJrnSys                     8a
019000070429     D  RdrRcvLib                    10a
019100070429     D  JrnTxt                       50a
019200070429     D  MinEntDtaAr                   1a
019300070429     D  MinEntFiles                   1a
019400070429     D  Rsv2                          9a
019500070429     D  NbrAtcRcv                    10i 0
019600070429     D  AtcRcvNam_q                  20a
019700070429     D   AtcRcvNam                   10a   Overlay( AtcRcvNam_q: 1 )
019800070429     D   AtcRcvLib                   10a   Overlay( AtcRcvNam_q: *Next )
019900070429     D  AtcLocSys                     8a
020000070429     D  AtcSrcSys                     8a
020100070429     D  AtcRcvNamDu                  10a
020200070429     D  AtcRcvLibDu                  10a
020300070430     D  MngRcvDly                    10i 0
020400070430     D  DltRcvDly                    10i 0
020500070430     D  AspDevNam                    10a
020600070430     D  LclJrnAspGrp                 10a
020700070430     D  RmtJrnAspGrp                 10a
020800070514     D  FldJob                        1a
020900070514     D  FldUsr                        1a
021000070514     D  FldPgm                        1a
021100070514     D  FldPgmLib                     1a
021200070514     D  FldSysSeq                     1a
021300070514     D  FldRmtAdr                     1a
021400070514     D  FldThd                        1a
021500070514     D  FldLuw                        1a
021600070514     D  FldXid                        1a
021700070514     D                                4a
021800070514     D  JrnObjLmt                     1a
021900070514     D  TotJrnObj                    10u 0
022000070514     D  TotJrnFil                    10u 0
022100070514     D  TotJrnMbr                    10u 0
022200070514     D  TotJrnDtaAra                 10u 0
022300070514     D  TotJrnDtaQue                 10u 0
022400070514     D  TotJrnIfs                    10u 0
022500070514     D  TotJrnAccPth                 10u 0
022600070514     D  TotJrnCmtDfn                 10u 0
022700070514     D  JrnRcyCnt                    10u 0
022800070514     D                              104a
022900070514     D  NbrKey                       10i 0
023000070429     **
023100070429     D JrnKey          Ds                  Based( pJrnKey )  Qualified
023200070429     D  Key                          10i 0
023300070429     D  OfsKeyInf                    10i 0
023400070429     D  KeyHdrSecLn                  10i 0
023500070429     D  NbrEnt                       10i 0
023600070429     D  KeyInfEntLn                  10i 0
023700070429     **
023800070429     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
023900070429     D  RcvNbrTot                    10i 0
024000070429     D  RcvSizTot                    10i 0
024100070429     D  RcvSizMtp                    10i 0
024200070429     D  Rsv                           8a
024300070429     **
024400070429     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
024500070429     D  RcvNam                       10a
024600070429     D  RcvLib                       10a
024700070429     D  RcvNbr                        5a
024800070429     D  RcvAtcDts                    13a
024900070429     D  RcvSts                        1a
025000070429     D  RcvSavDts                    13a
025100070429     D  LocJrnSys                     8a
025200070429     D  SrcJrnSys                     8a
025300070429     D  RcvSiz                       10i 0
025400070429     D  Rsv                          56a
025500070429     **-- Journal information specification:
025600070429     D JrnInfRtv       Ds                  Qualified
025700070429     D  NbrVarRcd                    10i 0 Inz( 1 )
025800070429     D  VarRcdLen                    10i 0 Inz( 12 )
025900070429     D  Key                          10i 0 Inz( JRN_RCVDIR )
026000070429     D  DtaLen                       10i 0 Inz( 0 )
026100070429     **-- Receiver information:
026200070429     D RRCV0100        Ds                  Qualified
026300070429     D  BytRtn                       10i 0
026400070429     D  BytAvl                       10i 0
026500070429     D  RcvNam_q                     20a
026600070429     D   RcvNam                      10a   Overlay( RcvNam_q: 1 )
026700070429     D   RcvLib                      10a   Overlay( RcvNam_q: *Next )
026800070429     D  JrnNam_q                     20a
026900070429     D   JrnNam                      10a   Overlay( JrnNam_q: 1 )
027000070429     D   JrnLib                      10a   Overlay( JrnNam_q: *Next )
027100070429     D  Thh                          10i 0
027200070429     D  Siz                          10i 0
027300070429     D  ASP                          10i 0
027400070429     D  NbrJrnEnt                    10i 0
027500070429     D  MaxEspDtaLn                  10i 0
027600070429     D  MaxNulInd                    10i 0
027700070429     D  FstSeqNbr                    10i 0
027800070429     D  MinEntDtaAr                   1a
027900070429     D  MinEntFiles                   1a
028000070429     D  Rsv1                          2a
028100070429     D  LstSeqNbr                    10i 0
028200070429     D  Rsv2                         10i 0
028300070429     D  Status                        1a
028400070429     D  MinFxlVal                     1a
028500070429     D  RcvMaxOpt                     1a
028600070429     D  Rsv3                          4a
028700070429     D  AtcDts                       13a
028800070429     D  DtcDts                       13a
028900070429     D   DtcDat                       7a   Overlay( DtcDts: 1 )
029000070429     D   DtcTim                       6a   Overlay( DtcDts: *Next )
029100070429     D  SavDts                       13a
029200070429     D   SavDat                       7a   Overlay( SavDts: 1 )
029300070429     D   SavTim                       6a   Overlay( SavDts: *Next )
029400070429     D  Txt                          50a
029500070429     D  PndTrn                        1a
029600070429     D  RmtJrnTyp                     1a
029700070429     D  LocJrnNam                    10a
029800070429     D  LocJrnLib                    10a
029900070429     D  LocJrnSys                     8a
030000070429     D  LocRcvLib                    10a
030100070429     D  SrcJrnNam                    10a
030200070429     D  SrcJrnLib                    10a
030300070429     D  SrcJrnSys                     8a
030400070429     D  SrcRcvLib                    10a
030500070429     D  RdcRcvLib                    10a
030600070429     D  DuaRcvNam                    10a
030700070429     D  DuaRcvLib                    10a
030800070429     D  PrvRcvNam                    10a
030900070429     D  PrvRcvLib                    10a
031000070429     D  PrvRcvNamDu                  10a
031100070429     D  PrvRcvLibDu                  10a
031200070429     D  NxtRcvNam                    10a
031300070429     D  NxtRcvLib                    10a
031400070429     D  NxtRcvNamDu                  10a
031500070429     D  NxtRcvLibDu                  10a
031600070429     D  NbrJrnEntL                   20s 0
031700070429     D  MaxEspDtlL                   20s 0
031800070429     D  FstSeqNbrL                   20s 0
031900070429     D  LstSeqNbrL                   20s 0
032000070429     D  AspDevNam                    10a
032100070429     D  LocJrnAspGn                  10a
032200070429     D  SrcJrnAspGn                  10a
032300070429     D  FldJob                        1a
032400070429     D  FldUsr                        1a
032500070429     D  FldPgm                        1a
032600070429     D  FldPgmLib                     1a
032700070429     D  FldSysSeq                     1a
032800070429     D  FldRmtAdr                     1a
032900070429     D  FldThd                        1a
033000070429     D  FldLuw                        1a
033100070429     D  FldXid                        1a
033200070429     D  Rsv4                         21a
033300070429
033400000906     **-- Sort information:
033500050226     D SrtInf          Ds                  Qualified
033600060424     D  NbrKeys                      10i 0 Inz( 4 )
033700060424     D  SrtStr                       12a   Dim( 4 )
033800050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
033900050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
034000050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
034100050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
034200060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
034300000906     **-- List information:
034400050226     D LstInf          Ds                  Qualified
034500050226     D  RcdNbrTot                    10i 0
034600050226     D  RcdNbrRtn                    10i 0
034700050226     D  Handle                        4a
034800050226     D  RcdLen                       10i 0
034900050226     D  InfSts                        1a
035000050226     D  Dts                          13a
035100050226     D  LstSts                        1a
035200990920     D                                1a
035300050226     D  InfLen                       10i 0
035400050226     D  Rcd1                         10i 0
035500990920     D                               40a
035600060503
035700060506     **-- Open list of objects:
035800060506     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
035900060506     D  RcvVar                    65535a          Options( *VarSize )
036000060506     D  RcvVarLen                    10i 0 Const
036100060506     D  LstInf                       80a
036200060506     D  NbrRcdRtn                    10i 0 Const
036300060506     D  SrtInf                     1024a   Const  Options( *VarSize )
036400060506     D  ObjNam_q                     20a   Const
036500060506     D  ObjTyp                       10a   Const
036600060506     D  AutCtl                     1024a   Const  Options( *VarSize )
036700060506     D  SltCtl                     1024a   Const  Options( *VarSize )
036800060506     D  NbrKeyRtn                    10i 0 Const
036900060506     D  KeyFld                       10i 0 Const  Options( *VarSize )  Dim( 32 )
037000060506     D  Error                      1024a          Options( *VarSize )
037100060506     **
037200060506     D  JobIdInf                    256a          Options( *NoPass: *VarSize )
037300060506     D  JobIdFmt                      8a   Const  Options( *NoPass )
037400060506     **
037500060506     D  AspCtl                      256a          Options( *NoPass: *VarSize )
037600060504     **-- Get open list entry:
037700060504     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
037800060423     D  RcvVar                    65535a          Options( *VarSize )
037900060423     D  RcvVarLen                    10i 0 Const
038000060423     D  Handle                        4a   Const
038100060423     D  LstInf                       80a
038200060423     D  NbrRcdRtn                    10i 0 Const
038300060423     D  RtnRcdNbr                    10i 0 Const
038400060423     D  Error                      1024a          Options( *VarSize )
038500050226     **-- Close list:
038600050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
038700060411     D  Handle                        4a   Const
038800060411     D  Error                      1024a          Options( *VarSize )
038900070429     **-- Retrieve journal information:
039000070429     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
039100070429     D                                     Information' )
039200070429     D  RcvVar                    65535a         Options( *VarSize )
039300070429     D  RcvVarLen                    10i 0 Const
039400070429     D  JrnNam                       20a   Const
039500070429     D  FmtNam                        8a   Const
039600070429     D  InfRtv                    65535a   Const Options( *VarSize )
039700070429     D  Error                     32767a         Options( *VarSize: *Omit )
039800070429     **-- Retrieve journal receiver information:
039900070429     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
040000070429     D                                     Information' )
040100070429     D  RcvVar                    65535a         Options( *VarSize )
040200070429     D  RcvVarLen                    10i 0 Const
040300070429     D  RcvNam                       20a   Const
040400070429     D  FmtNam                        8a   Const
040500070429     D  Error                     32767a         Options( *VarSize: *Omit )
040600060826     **-- Retrieve job information:
040700060826     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
040800060826     D  RcvVar                    32767a         Options( *VarSize )
040900060826     D  RcvVarLen                    10i 0 Const
041000060826     D  FmtNam                        8a   Const
041100060826     D  JobNamQ                      26a   Const
041200060826     D  JobIntId                     16a   Const
041300060826     D  Error                     32767a         Options( *NoPass: *VarSize )
041400060826     **-- Convert case:
041500060826     D CvtCase         Pr                  ExtProc( 'QlgConvertCase' )
041600070429     D  RqsBlk                       22a   Const
041700070429     D  InpDta                    32767a   Const  Options( *VarSize )
041800070429     D  OutDta                    32767a          Options( *VarSize )
041900070429     D  DtaLen                       10i 0 Const
042000070429     D  Error                     32767a          Options( *VarSize )
042100060504     **-- Send program message:
042200060504     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
042300060504     D  MsgId                         7a   Const
042400060504     D  MsgFq                        20a   Const
042500060504     D  MsgDta                      128a   Const
042600060504     D  MsgDtaLen                    10i 0 Const
042700060504     D  MsgTyp                       10a   Const
042800060504     D  CalStkE                      10a   Const  Options( *VarSize )
042900060504     D  CalStkCtr                    10i 0 Const
043000060504     D  MsgKey                        4a
043100060504     D  Error                     32767a          Options( *VarSize )
043200070429     **-- Register termination exit:
043300070429     D CeeRtx          Pr                    ExtProc( 'CEERTX' )
043400070429     D  procedure                      *     ProcPtr  Const
043500070429     D  token                          *     Options( *Omit )
043600070429     D  fb                           12a     Options( *Omit )
043700070429     **-- Unregister termination exit:
043800070429     D CeeUtx          Pr                    ExtProc( 'CEEUTX' )
043900070429     D  procedure                      *     ProcPtr  Const
044000070429     D  fb                           12a     Options( *Omit )
044100060428
044200060504     **-- Open display application:
044300060504     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
044400060504     D  AppHdl                        8a
044500060504     D  PnlGrp_q                     20a   Const
044600060504     D  AppScp                       10i 0 Const
044700060504     D  ExtPrmIfc                    10i 0 Const
044800060504     D  FulScrHlp                     1a   Const
044900060504     D  Error                     32767a          Options( *VarSize )
045000060504     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
045100060504     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
045200060504     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
045300060825     **-- Open print application:
045400060825     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
045500060825     D  AppHdl                        8a
045600060825     D  PnlGrp_q                     20a   Const
045700060825     D  AppScp                       10i 0 Const
045800060825     D  ExtPrmIfc                    10i 0 Const
045900060825     D  PrtDevF_q                    20a   Const
046000060825     D  AltFilNam                    10a   Const
046100060825     D  ShrOpnDtaPth                  1a   Const
046200060825     D  UsrDta                       10a   Const
046300060825     D  Error                     32767a          Options( *VarSize )
046400060825     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
046500060825     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
046600060825     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
046700060504     **-- Display panel:
046800060504     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
046900060504     D  AppHdl                        8a   Const
047000060504     D  FncRqs                       10i 0
047100060504     D  PnlNam                       10a   Const
047200060504     D  ReDspOpt                      1a   Const
047300060504     D  Error                     32767a          Options( *VarSize )
047400060504     D  UsrTsk                        1a   Const  Options( *NoPass )
047500060504     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
047600060504     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
047700060504     D  MsgKey                        4a   Const  Options( *NoPass )
047800060504     D  CsrPosOpt                     1a   Const  Options( *NoPass )
047900060504     D  FinLstEnt                     4a   Const  Options( *NoPass )
048000060504     D  ErrLstEnt                     4a   Const  Options( *NoPass )
048100060504     D  WaitTim                      10i 0 Const  Options( *NoPass )
048200060504     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
048300060504     D  CalQlf                       20a   Const  Options( *NoPass )
048400060825     **-- Print panel:
048500060825     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
048600060825     D  AppHdl                        8a   Const
048700060825     D  PrtPnlNam                    10a   Const
048800060825     D  EjtOpt                        1a   Const
048900060825     D  Error                     32767a          Options( *VarSize )
049000060504     **-- Put dialog variable:
049100060504     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
049200060504     D  AppHdl                        8a   Const
049300060504     D  VarBuf                    32767a   Const  Options( *VarSize )
049400060504     D  VarBufLen                    10i 0 Const
049500060504     D  VarRcdNam                    10a   Const
049600060504     D  Error                     32767a          Options( *VarSize )
049700060504     **-- Add list entry:
049800060504     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
049900060504     D  AppHdl                        8a   Const
050000060504     D  VarBuf                    32767a   Const  Options( *VarSize )
050100060504     D  VarBufLen                    10i 0 Const
050200060504     D  VarRcdNam                    10a   Const
050300060504     D  LstNam                       10a   Const
050400060504     D  EntLocOpt                     4a   Const
050500060504     D  LstEntHdl                     4a
050600060504     D  Error                     32767a          Options( *VarSize )
050700060504     **-- Get list entry:
050800060504     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
050900060504     D  AppHdl                        8a   Const
051000060504     D  VarBuf                    32767a   Const  Options( *VarSize )
051100060504     D  VarBufLen                    10i 0 Const
051200060504     D  VarRcdNam                    10a   Const
051300060504     D  LstNam                       10a   Const
051400060504     D  PosOpt                        4a   Const
051500060504     D  CpyOpt                        1a   Const
051600060504     D  SltCri                       20a   Const
051700060504     D  SltHdl                        4a   Const
051800060504     D  ExtOpt                        1a   Const
051900060504     D  LstEntHdl                     4a
052000060504     D  Error                     32767a          Options( *VarSize )
052100060504     **-- Retrieve list attributes:
052200060504     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
052300060504     D  AppHdl                        8a   Const
052400060504     D  LstNam                       10a   Const
052500060504     D  AtrRcv                    32767a          Options( *VarSize )
052600060504     D  AtrRcvLen                    10i 0 Const
052700060504     D  Error                     32767a          Options( *VarSize )
052800060504     **-- Set list attributes:
052900060504     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
053000060504     D  AppHdl                        8a   Const
053100060504     D  LstNam                       10a   Const
053200060504     D  LstCon                        4a   Const
053300060504     D  ExtPgmVar                    10a   Const
053400060504     D  DspPos                        4a   Const
053500060504     D  AlwTrim                       1a   Const
053600060504     D  Error                     32767a          Options( *VarSize )
053700060504     **-- Delete list:
053800060504     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
053900060504     D  AppHdl                        8a   Const
054000060504     D  LstNam                       10a   Const
054100060504     D  Error                     32767a          Options( *VarSize )
054200060504     **-- Close application:
054300060504     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
054400060504     D  AppHdl                        8a   Const
054500060504     D  CloOpt                        1a   Const
054600060504     D  Error                     32767a          Options( *VarSize )
054700060504
054800060825     **-- Get job type:
054900060825     D GetJobTyp       Pr             1a
055000060826     **-- To upper case:
055100060826     D ToUpper         Pr          4096a   Varying
055200060826     D  InpStr                     4096a   Const  Varying
055300070429     **-- Send status message:
055400070429     D SndStsMsg       Pr            10i 0
055500070429     D  PxMsgDta                   1024a   Const  Varying
055600060825     **-- Send completion message:
055700060825     D SndCmpMsg       Pr            10i 0
055800060825     D  PxMsgDta                    512a   Const  Varying
055900060504     **-- Send escape message:
056000060504     D SndEscMsg       Pr            10i 0
056100060504     D  PxMsgId                       7a   Const
056200060504     D  PxMsgF                       10a   Const
056300060504     D  PxMsgDta                    512a   Const  Varying
056400070429     **-- Terminate program:
056500070429     D TrmPgm          Pr
056600070429     D  pPtr                           *
056700050226
056800070429     D CBX970          Pr
056900070429     D  PxJrnNam_q                         LikeDs( ObjNam_q )
057000070429     D  PxLstOrd                     10a
057100060825     D  PxOutOpt                      3a
057200050226     **
057300070429     D CBX970          Pi
057400070429     D  PxJrnNam_q                         LikeDs( ObjNam_q )
057500070429     D  PxLstOrd                     10a
057600070429     D  PxOutOpt                      3a
057700050226
057800050226      /Free
057900070429
058000070429        CeeRtx( %Paddr( TrmPgm ): pJrnInf: *Omit );
058100070429
058200070429        SndStsMsg( 'Retrieving journal information, please wait...' );
058300070429
058400070429        ApiRcvSiz = 65535;
058500070429        pJrnInf   = %Alloc( ApiRcvSiz );
058600060424
058700060825        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
058800060825
058900060825          OpnDspApp( UIM.AppHdl
059000060825                   : PNLGRP_Q
059100060825                   : SCP_AUT_RCL
059200060825                   : PRM_IFC_0
059300060825                   : HLP_WDW
059400060825                   : ERRC0100
059500060825                   );
059600060825        Else;
059700060825          OpnPrtApp( UIM.AppHdl
059800060825                   : PNLGRP_Q
059900060825                   : SCP_AUT_RCL
060000060825                   : PRM_IFC_0
060100060825                   : APP_PRTF
060200060825                   : SPLF_NAM
060300060825                   : ODP_SHR
060400060825                   : SPLF_USRDTA
060500060825                   : ERRC0100
060600060825                   );
060700060825        EndIf;
060800060825
060900060504        If  ERRC0100.BytAvl > *Zero;
061000070429          ExSr  EscApiErr;
061100060504        EndIf;
061200060504
061300060511        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );
061400060504
061500060504        ExSr  BldHdrRcd;
061600070429        ExSr  BldJrnLst;
061700060504
061800060825        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
061900060825          ExSr  DspLst;
062000060825        Else;
062100060825          ExSr  WrtLst;
062200060825        EndIf;
062300060504
062400060504        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );
062500050226
062600070429        CeeUtx( %Paddr( TrmPgm ): *Omit );
062700070429
062800070429        TrmPgm( pJrnInf );
062900070429
063000050226        Return;
063100060412
063200060505
063300070429        BegSr  EscApiErr;
063400070429
063500070429          If  ERRC0100.BytAvl < OFS_MSGDTA;
063600070429            ERRC0100.BytAvl = OFS_MSGDTA;
063700070429          EndIf;
063800070429
063900070429          SndEscMsg( ERRC0100.MsgId
064000070429                   : 'QCPFMSG'
064100070429                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
064200070429                   );
064300070429
064400070429        EndSr;
064500070429
064600060825        BegSr  DspLst;
064700060825
064800060825          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;
064900060825
065000060825            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );
065100060825
065200060825            Select;
065300100319            When  ERRC0100.BytAvl > *Zero;
065400100319              ExSr  EscApiErr;
065500100319
065600060825            When  UIM.FncRqs = RTN_ENTER;
065700060825              Leave;
065800060825
065900060825            When  UIM.FncRqs = KEY_F17;
066000060825              ExSr  PosLstTop;
066100060825
066200060825            When  UIM.FncRqs = KEY_F18;
066300060825              ExSr  PosLstBot;
066400060825            EndSl;
066500060825
066600060825          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
066700060825            ExSr  GetLstPos;
066800070429            ExSr  DltJrnLst;
066900060825          EndIf;
067000060825
067100060825          If  UIM.FncRqs = KEY_F05;
067200070429            ExSr  BldJrnLst;
067300060825            ExSr  SetLstPos;
067400060825          EndIf;
067500060825
067600060825            ExSr  BldHdrRcd;
067700060825          EndDo;
067800060825
067900060825        EndSr;
068000060825
068100060825        BegSr  WrtLst;
068200060825
068300060825          PrtPnl( UIM.AppHdl
068400060825                : 'PRTHDR'
068500060825                : EJECT_NO
068600060825                : ERRC0100
068700060825                );
068800060825
068900060825          PrtPnl( UIM.AppHdl
069000060825                : 'PRTLST'
069100060825                : EJECT_NO
069200060825                : ERRC0100
069300060825                );
069400060825
069500060825          SndCmpMsg( 'List has been printed.' );
069600060825
069700060825        EndSr;
069800060825
069900070429        BegSr  BldJrnLst;
070000060825
070100060825          ExSr  InzApiPrm;
070200060825
070300060825          UIM.EntLocOpt = 'FRST';
070400060825          LstApi.RtnRcdNbr = 1;
070500060825
070600060826          LstObjs( ObjInf
070700060826                 : %Size( ObjInf )
070800060826                 : LstInf
070900060826                 : -1
071000060826                 : SrtInf
071100070429                 : PxJrnNam_q
071200070429                 : '*JRN'
071300060826                 : AutCtl
071400060826                 : SltCtl
071500060826                 : LstApi.NbrKeyRtn
071600060826                 : LstApi.KeyFld
071700060826                 : ERRC0100
071800060826                 );
071900060826
072000060825          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrTot > *Zero;
072100060825
072200060825            ExSr  PrcLstEnt;
072300060825
072400060825            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
072500060825              LstApi.RtnRcdNbr += 1;
072600060825
072700060826              GetOplEnt( ObjInf
072800060826                       : %Size( ObjInf )
072900060825                       : LstInf.Handle
073000060825                       : LstInf
073100060825                       : 1
073200060825                       : LstApi.RtnRcdNbr
073300060825                       : ERRC0100
073400060825                       );
073500060825
073600060825              If  ERRC0100.BytAvl > *Zero;
073700060825                Leave;
073800060825              EndIf;
073900060825
074000060825              ExSr  PrcLstEnt;
074100060825            EndDo;
074200060825          EndIf;
074300060825
074400060825          CloseLst( LstInf.Handle: ERRC0100 );
074500060825
074600060825          SetLstAtr( UIM.AppHdl
074700060825                   : 'DTLLST'
074800060825                   : LIST_COMP
074900060825                   : EXIT_SAME
075000060825                   : POS_TOP
075100060825                   : TRIM_SAME
075200060825                   : ERRC0100
075300060825                   );
075400070429
075500070429        EndSr;
075600060825
075700060826        BegSr  PrcLstEnt;
075800060826
075900070429          RJRN0100.BytAvl = *Zero;
076000070429
076100070429          DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
076200070429               ERRC0100.BytAvl  > *Zero;
076300070429
076400070429            If  RJRN0100.BytAvl > ApiRcvSiz;
076500070429              ApiRcvSiz  = RJRN0100.BytAvl;
076600070429              pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
076700070429            EndIf;
076800070429
076900070429            RtvJrnInf( RJRN0100
077000070429                     : ApiRcvSiz
077100070429                     : ObjInf.ObjNam_q
077200070429                     : 'RJRN0100'
077300070429                     : JrnInfRtv
077400070429                     : ERRC0100
077500070429                     );
077600070429          EndDo;
077700070429
077800070514          If  ERRC0100.BytAvl = *Zero;
077900070429            ExSr  PrcKeyEnt;
078000070429          EndIf;
078100060826
078200060826        EndSr;
078300060828
078400070429        BegSr PrcKeyEnt;
078500070429
078600070429          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );
078700070429
078800070429          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
078900070429          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );
079000070429
079100070429          For  Idx = 1  to JrnKey.NbrEnt;
079200070429
079300070429            RtvRcvInf( RRCV0100
079400070429                     : %Size( RRCV0100 )
079500070429                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
079600070429                     : 'RRCV0100'
079700070429                     : ERRC0100
079800070429                     );
079900070429
080000070429            If  ERRC0100.BytAvl = *Zero;
080100070429
080200070429              If  Idx = 1;
080300070429                ExSr  RtvOldRcv;
080400070429              EndIf;
080500070429
080600070429              If  RJRN0100.AtcRcvNam_q = RRCV0100.RcvNam_q;
080700070429                ExSr  RtvAtcRcv;
080800070429              EndIf;
080900070429            EndIf;
081000070429
081100070429            If  Idx < JrnKey.NbrEnt;
081200070429              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
081300070429            EndIf;
081400070429          EndFor;
081500070429
081600070429          ExSr  PutLstEnt;
081700070429
081800070429        EndSr;
081900070429
082000070429        BegSr  RtvOldRcv;
082100070429
082200070429          LstEnt.OldRcvNam = RRCV0100.RcvNam;
082300070429          LstEnt.OldRcvLib = RRCV0100.RcvLib;
082400070429
082500070429        EndSr;
082600070429
082700070429        BegSr  RtvAtcRcv;
082800070429
082900070429          LstEnt.AtcRcvNam = RRCV0100.RcvNam;
083000070429          LstEnt.AtcRcvLib = RRCV0100.RcvLib;
083100070429          LstEnt.CurSeqNbr = RRCV0100.LstSeqNbrL;
083200070429
083300070429        EndSr;
083400070429
083500060826        BegSr  PutLstEnt;
083600060826
083700060826          LstEnt.Option = *Zero;
083800060826
083900070429          LstEnt.JrnPos = RJRN0100.JrnNam_q;
084000070429          LstEnt.JrnNam = RJRN0100.JrnNam;
084100070429          LstEnt.JrnLib = RJRN0100.JrnLib;
084200070429          LstEnt.JrnTyp = RJRN0100.JrnTyp;
084300070429          LstEnt.JrnStt = RJRN0100.JrnStt;
084400070430          LstEnt.AspDevNam = RJRN0100.AspDevNam;
084500070429
084600070429          LstEnt.NbrRcv = JrnKeyHdr1.RcvNbrTot;
084700070429          LstEnt.RcvDirSiz = JrnKeyHdr1.RcvSizTot * JrnKeyHdr1.RcvSizMtp;
084800070429          LstEnt.JrnDscTxt = RJRN0100.JrnTxt;
084900060826
085000060826          AddLstEnt( UIM.AppHdl
085100060826                   : LstEnt
085200060826                   : %Size( LstEnt )
085300060826                   : 'DTLRCD'
085400060826                   : 'DTLLST'
085500060826                   : UIM.EntLocOpt
085600060826                   : UIM.LstHdl
085700060826                   : ERRC0100
085800060826                   );
085900060826
086000060826          UIM.EntLocOpt = 'NEXT';
086100060826
086200060826        EndSr;
086300060826
086400060825        BegSr  GetLstPos;
086500060825
086600060825          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );
086700060825
086800060825          If  LstAtr.DspPos <> 'TOP';
086900060825
087000060825            GetLstEnt( UIM.AppHdl
087100060825                     : LstEnt
087200060825                     : %Size( LstEnt )
087300060825                     : 'DTLRCD'
087400060825                     : 'DTLLST'
087500060825                     : 'HNDL'
087600060825                     : 'Y'
087700060825                     : *Blanks
087800060825                     : LstAtr.DspPos
087900060825                     : 'N'
088000060825                     : UIM.EntHdl
088100060825                     : ERRC0100
088200060825                     );
088300060825
088400060825            LstEntPos = LstEnt;
088500060825          EndIf;
088600060825
088700060825        EndSr;
088800060825
088900060825        BegSr  SetLstPos;
089000060825
089100060825          If  LstAtr.DspPos <> 'TOP';
089200060825
089300060825            LstEnt = LstEntPos;
089400060825
089500060825            PutDlgVar( UIM.AppHdl
089600060825                     : LstEnt
089700060825                     : %Size( LstEnt )
089800060825                     : 'DTLRCD'
089900060825                     : ERRC0100
090000060825                     );
090100060825
090200060825            GetLstEnt( UIM.AppHdl
090300060825                     : LstEnt
090400060825                     : %Size( LstEnt )
090500060825                     : '*NONE'
090600060825                     : 'DTLLST'
090700060825                     : 'FSLT'
090800060825                     : 'N'
090900070429                     : 'EQ        JRNPOS'
091000060825                     : LstAtr.DspPos
091100060825                     : 'N'
091200060825                     : UIM.EntHdl
091300060825                     : ERRC0100
091400060825                     );
091500060825
091600060825            If  ERRC0100.BytAvl = *Zero;
091700060825
091800060825              SetLstAtr( UIM.AppHdl
091900060825                       : 'DTLLST'
092000060825                       : LIST_SAME
092100060825                       : EXIT_SAME
092200060825                       : UIM.EntHdl
092300060825                       : TRIM_SAME
092400060825                       : ERRC0100
092500060825                       );
092600060825
092700060825            EndIf;
092800060825          EndIf;
092900060825
093000060825        EndSr;
093100060825
093200060825        BegSr  PosLstTop;
093300060825
093400060825          SetLstAtr( UIM.AppHdl
093500060825                   : 'DTLLST'
093600060825                   : LIST_SAME
093700060825                   : EXIT_SAME
093800060825                   : POS_TOP
093900060825                   : TRIM_SAME
094000060825                   : ERRC0100
094100060825                   );
094200060825
094300060825        EndSr;
094400060825
094500060825        BegSr  PosLstBot;
094600060825
094700060825          SetLstAtr( UIM.AppHdl
094800060825                   : 'DTLLST'
094900060825                   : LIST_SAME
095000060825                   : EXIT_SAME
095100060825                   : POS_BOT
095200060825                   : TRIM_SAME
095300060825                   : ERRC0100
095400060825                   );
095500060825
095600060825        EndSr;
095700060825
095800060825        BegSr  BldHdrRcd;
095900060825
096000060825          SysDts = %Timestamp();
096100060825
096200060825          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
096300060825          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
096400060825          HdrRcd.TimZon = '*SYS';
096500060825
096600070429          HdrRcd.JrnNam = PxJrnNam_q.ObjNam;
096700070429          HdrRcd.JrnLib = PxJrnNam_q.ObjLib;
096800060825
096900060825          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );
097000060825
097100060825        EndSr;
097200060825
097300070429        BegSr  DltJrnLst;
097400060825
097500060825          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );
097600060825
097700060825        EndSr;
097800060825
097900060825        BegSr  InzApiPrm;
098000060825
098100060826          SrtInf.NbrKeys   = 2;
098200060826
098300070429          If  PxLstOrd = '*JRN';
098400060826            SrtInf.KeyFldOfs(1) = 1;
098500070429            SrtInf.KeyFldLen(1) = %Size( LstEnt.JrnNam );
098600060826            SrtInf.KeyFldOfs(2) = 11;
098700070429            SrtInf.KeyFldLen(2) = %Size( LstEnt.JrnLib );
098800060826          Else;
098900060826            SrtInf.KeyFldOfs(1) = 11;
099000070429            SrtInf.KeyFldLen(1) = %Size( LstEnt.JrnLib );
099100060826            SrtInf.KeyFldOfs(2) = 1;
099200070429            SrtInf.KeyFldLen(2) = %Size( LstEnt.JrnNam );
099300060826          EndIf;
099400060826
099500060826          SrtInf.KeyFldTyp(1) = CHAR_NLS;
099600060826          SrtInf.SrtOrd(1)    = SORT_ASC;
099700060826          SrtInf.Rsv(1)       = x'00';
099800060826
099900060826          SrtInf.KeyFldTyp(2) = CHAR_NLS;
100000060826          SrtInf.SrtOrd(2)    = SORT_ASC;
100100060826          SrtInf.Rsv(2)       = x'00';
100200060825
100300060825        EndSr;
100400060825
100500050226      /End-Free
100600060428
100700060825     **-- Get job type:
100800060825     P GetJobTyp       B
100900060825     D                 Pi             1a
101000060825
101100060825     D JOBI0400        Ds                  Qualified
101200060825     D  BytRtn                       10i 0
101300060825     D  BytAvl                       10i 0
101400060825     D  JobNam                       10a
101500060825     D  UsrNam                       10a
101600060825     D  JobNbr                        6a
101700060825     D  JobIntId                     16a
101800060825     D  JobSts                       10a
101900060825     D  JobTyp                        1a
102000060825     D  JobSubTyp                     1a
102100060825
102200060825      /Free
102300060825
102400060825        RtvJobInf( JOBI0400
102500060825                 : %Size( JOBI0400 )
102600060825                 : 'JOBI0400'
102700060825                 : '*'
102800060825                 : *Blank
102900060825                 : ERRC0100
103000060825                 );
103100060825
103200060825        If  ERRC0100.BytAvl > *Zero;
103300060825          Return  *Blank;
103400060825
103500060825        Else;
103600060825          Return  JOBI0400.JobTyp;
103700060825        EndIf;
103800060825
103900060825      /End-Free
104000060825
104100060825     P GetJobTyp       E
104200060826     **-- To upper case:  ----------------------------------------------------**
104300060826     P ToUpper         B
104400060826     D                 Pi          4096a   Varying
104500060826     D  PxInpStr                   4096a   Const  Varying
104600060826
104700060826     **-- Convert case parameters & constants:
104800060826     D RqsCtlBlk       Ds                  Qualified
104900060826     D  RqsType                      10i 0 Inz( CVT_BY_CCSID )
105000060826     D  CCSID                        10i 0 Inz( JOB_CCSID )
105100060826     D  CaseRqs                      10i 0 Inz
105200060826     D                               10a   Inz( *Allx'00')
105300060826     **
105400060826     D CVT_BY_CCSID    c                   1
105500060826     D JOB_CCSID       c                   0
105600060826     D TO_LOWER        c                   1
105700060826     D TO_UPPER        c                   0
105800060826     **-- Local variable:
105900060826     D OutStr          s           4096a
106000060826
106100060826      /Free
106200060826
106300060826        If  %Len( PxInpStr ) > *Zero;
106400060826
106500060826         RqsCtlBlk.CaseRqs = TO_UPPER;
106600060826
106700060826         CvtCase( RqsCtlBlk: PxInpStr: OutStr: %Len( PxInpStr ): ERRC0100 );
106800060826
106900060826         If  ERRC0100.BytAvl = *Zero;
107000060826           Return  %TrimR( OutStr );
107100060826         EndIf;
107200060826       EndIf;
107300060826
107400060826       Return  PxInpStr;
107500060826
107600060826      /End-Free
107700060826
107800060826     P ToUpper         E
107900070429     **-- Send status message:
108000070429     P SndStsMsg       B
108100070429     D                 Pi            10i 0
108200070429     D  PxMsgDta                   1024a   Const  Varying
108300070429     **
108400070429     D MsgKey          s              4a
108500070429
108600070429      /Free
108700070429
108800070429        SndPgmMsg( 'CPF9897'
108900070429                 : 'QCPFMSG   *LIBL'
109000070429                 : PxMsgDta
109100070429                 : %Len( PxMsgDta )
109200070429                 : '*STATUS'
109300070429                 : '*EXT'
109400070429                 : 0
109500070429                 : MsgKey
109600070429                 : ERRC0100
109700070429                 );
109800070429
109900070429        If  ERRC0100.BytAvl > *Zero;
110000070429          Return  -1;
110100070429
110200070429        Else;
110300070429          Return   0;
110400070429        EndIf;
110500070429
110600070429      /End-Free
110700070429
110800070429     P SndStsMsg       E
110900060825     **-- Send completion message:
111000060825     P SndCmpMsg       B
111100060825     D                 Pi            10i 0
111200060825     D  PxMsgDta                    512a   Const  Varying
111300060825     **
111400060825     D MsgKey          s              4a
111500060825
111600060825      /Free
111700060825
111800060825        SndPgmMsg( 'CPF9897'
111900060825                 : 'QCPFMSG   *LIBL'
112000060825                 : PxMsgDta
112100060825                 : %Len( PxMsgDta )
112200060825                 : '*COMP'
112300060825                 : '*PGMBDY'
112400060825                 : 1
112500060825                 : MsgKey
112600060825                 : ERRC0100
112700060825                 );
112800060825
112900060825        If  ERRC0100.BytAvl > *Zero;
113000060825          Return  -1;
113100060825
113200060825        Else;
113300060825          Return  0;
113400060825
113500060825        EndIf;
113600060825
113700060825      /End-Free
113800060825
113900060825     P SndCmpMsg       E
114000060504     **-- Send escape message:
114100060504     P SndEscMsg       B
114200060504     D                 Pi            10i 0
114300060504     D  PxMsgId                       7a   Const
114400060504     D  PxMsgF                       10a   Const
114500060504     D  PxMsgDta                    512a   Const  Varying
114600060504     **
114700060504     D MsgKey          s              4a
114800060504
114900060504      /Free
115000060504
115100060504        SndPgmMsg( PxMsgId
115200060504                 : PxMsgF + '*LIBL'
115300060504                 : PxMsgDta
115400060504                 : %Len( PxMsgDta )
115500060504                 : '*ESCAPE'
115600060504                 : '*PGMBDY'
115700060504                 : 1
115800060504                 : MsgKey
115900060504                 : ERRC0100
116000060504                 );
116100060504
116200060504        If  ERRC0100.BytAvl > *Zero;
116300060504          Return  -1;
116400060504
116500060504        Else;
116600060504          Return   0;
116700060504        EndIf;
116800060504
116900060504      /End-Free
117000060504
117100060504     P SndEscMsg       E
117200070429     **-- Terminate program:
117300070429     P TrmPgm          B
117400070429     D                 Pi
117500070429     D  pPtr                           *
117600070429
117700070429      /Free
117800070429
117900070429        If  pPtr <> *Null;
118000070429          DeAlloc  pPtr;
118100070429        EndIf;
118200070429
118300070429        *InLr = *On;
118400070429
118500070429        Return;
118600070429
118700070429      /End-Free
118800070429
118900070429     P TrmPgm          E
