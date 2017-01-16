000100060517     **
000200070423     **  Program . . : CBX969L
000300060517     **  Description : Work with Jobs - UIM List Exit Program
000400060517     **  Author  . . : Carsten Flensburg
000500070423     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060517     **
000700060517     **
000800060517     **
000900060517     **  Compile options:
001000070423     **    CrtRpgMod  Module( CBX969L )
001100060517     **               DbgView( *LIST )
001200060517     **
001300070423     **    CrtPgm     Pgm( CBX969L )
001400070423     **               Module( CBX969L )
001500060517     **               ActGrp( *CALLER )
001600060517     **
001700050310     **
001800050310     **-- Header specifications:  --------------------------------------------**
001900060411     H Option( *SrcStmt )
002000060411
002100050227     **-- API error data structure:
002200050226     D ERRC0100        Ds                  Qualified
002300050226     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002400050226     D  BytAvl                       10i 0
002500050226     D  MsgId                         7a
002600990921     D                                1a
002700050226     D  MsgDta                      128a
002800060424
002900060424     **-- Global constants:
003000060424     D OFS_MSGDTA      c                   16
003100060604     D BLD_SYNCH       c                   -1
003200060605     D SNG_ENT         c                   1
003300060605     D MIN_NBR_ENT     c                   34
003400060424     **
003500060424     D BIN_SGN         c                   0
003600060509     D NUM_ZON         c                   2
003700060424     D CHAR_NLS        c                   4
003800060509     D SORT_ASC        c                   '1'
003900060509     D SORT_DSC        c                   '2'
004000060424     **-- Global variables:
004100060424     D KeyDtaVal       s             32a
004200060424     D Idx             s             10i 0
004300060510     D EntNbr          s             10i 0
004400070327     D HI_Time         s               t   Inz( *HiVal )
004500070309     D HI_Date         s               d   DatFmt( *DMY )  Inz( *HiVal )
004600070309     D LO_Date         s               d   DatFmt( *DMY )  Inz( *LoVal )
004700070309     D JobEntDts       s               z
004800070309     D PerBegDts       s               z
004900070309     D PerEndDts       s               z
005000070306     **-- Period definition:
005100070306     D Period          Ds                  Based( pNull )
005200070306     D  NbrElm                        5i 0
005300070308     D  OfsElm1                       5i 0
005400070308     D  OfsElm2                       5i 0
005500070306     D  NbrEnd                        5i 0
005600070308     D  TimEnd                        6a
005700070308     D  DatEnd                        7a
005800070308     D  NbrBeg                        5i 0
005900070308     D  TimBeg                        6a
006000070308     D  DatBeg                        7a
006100060510
006200060510     **-- UIM constants:
006300060510     D LIST_TOP        c                   'TOP'
006400060510     D LIST_BOT        c                   'BOT'
006500060510     D LIST_COMP       c                   'ALL'
006600060510     D LIST_SAME       c                   'SAME'
006700060510     D EXIT_SAME       c                   '*SAME'
006800060510     D TRIM_SAME       c                   'S'
006900060510     D POS_TOP         c                   'TOP'
007000060510     D POS_BOT         c                   'BOT'
007100060510     D POS_SAME        c                   'SAME'
007200060510     **-- UIM variables:
007300060510     D UIM             Ds                  Qualified
007400060510     D  AppHdl                        8a
007500060510     D  LstHdl                        4a
007600060510     D  EntHdl                        4a
007700060510     D  FncRqs                       10i 0
007800060510     D  EntLocOpt                     4a
007900060510     D  LstPos                        4a
008000060510     D  LstCnt                        4a
008100060510     **-- UIM exit program interfaces:
008200060510     **-- Incomplete list:
008300060510     D Type6           Ds                  Qualified
008400060510     D  StcLvl                       10i 0
008500060510     D                                8a
008600060510     D  TypCall                      10i 0
008700060510     D  AppHdl                        8a
008800060510     D                               10a
008900060510     D  LstNam                       10a
009000060510     D  IncLstDir                    10i 0
009100060510     D  NbrEntRqd                    10i 0
009200060511
009300060510     **-- UIM Panel control record:
009400060510     D CtlRcd          Ds                  Qualified
009500060510     D  Action                        4a
009600060510     D  EntLocOpt                     4a
009700060510     **-- UIM List parameter record:
009800060510     D PrmRcd          Ds                  Qualified
009900060510     D  JobNam                       10a
010000060510     D  UsrPrf                       10a
010100060516     D  JobSts                       10a
010200060510     D  JobTyp                        1a
010300060510     D  CurUsr                       10a
010400060511     D  CmpSts                       10a
010500070306     D  Period                             LikeDs( Period )
010600060511     **-- UIM List entry:
010700060511     D LstEnt          Ds                  Qualified
010800060511     D  Option                        5i 0
010900060511     D  EntId                        19a
011000060511     D  JobNam                       10a
011100060511     D  JobUsr                       10a
011200060511     D  JobNbr                        6a
011300060511     D  JobTyp                        1a
011400060511     D  JobSts1                       7a
011500060511     D  JobSts2                       4a
011600060511     D  JobDat                        7a
011700060511     D  EntDat                        7a
011800060511     D  EntTim                        6a
011900060511     D  ActDat                        7a
012000060511     D  ActTim                        6a
012100060511     D  CurUsr                       10a
012200060511     D  FncCmp                       14a
012300060511     D  MsgRpy                        1a
012400060511     D  SbmJob                       10a
012500060511     D  SbmUsr                       10a
012600060511     D  SbmNbr                        6a
012700060510
012800060424     **-- List API parameters:
012900060424     D LstApi          Ds                  Qualified  Inz
013000060510     D  RtnRcdNbr                    10i 0
013100060510     D  CurRcdNbr                    10i 0
013200060424     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
013300060511     D  KeyFld                       10i 0 Dim( 11 )
013400000906     **-- Job information:
013500060411     D OLJB0200        Ds           512    Qualified
013600050311     D  JobNam                       10a
013700050311     D  UsrPrf                       10a
013800050311     D  JobNbr                        6a
013900050226     D  JobIdInt                     16a
014000050226     D  Status                       10a
014100050226     D  JobTyp                        1a
014200050226     D  JobSubTyp                     1a
014300000427     D                                2a
014400060411     D  JobInfSts                     1a
014500060411     D                                3a
014600060411     **-- Key information:
014700060411     D KeyInf          Ds                  Qualified
014800060411     D  FldNbrRtn                    10i 0
014900060424     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
015000060411     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
015100060411     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
015200060411     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
015300060411     D                                3a   Overlay( KeyStr: 10 )
015400060411     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
015500060411     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
015600000906     **-- Sort information:
015700050226     D SrtInf          Ds                  Qualified
015800060430     D  NbrKeys                      10i 0 Inz( 0 )
015900060425     D  SrtStr                       12a   Dim( 3 )
016000050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
016100050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
016200050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
016300050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
016400060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
016500000906     **-- List information:
016600050226     D LstInf          Ds                  Qualified
016700050226     D  RcdNbrTot                    10i 0
016800050226     D  RcdNbrRtn                    10i 0
016900050226     D  Handle                        4a
017000050226     D  RcdLen                       10i 0
017100050226     D  InfSts                        1a
017200050226     D  Dts                          13a
017300050226     D  LstSts                        1a
017400990920     D                                1a
017500050226     D  InfLen                       10i 0
017600050226     D  Rcd1                         10i 0
017700990920     D                               40a
017800060424     **-- Selection information:
017900060424     D OLJS0200        Ds                  Qualified
018000060509     D  JobNam                       10a
018100060509     D  UsrPrf                       10a
018200060424     D  JobNbr                        6a   Inz( '*ALL' )
018300060509     D  JobTyp                        1a
018400060424     D                                1a
018500060424     D  OfsPriSts                    10i 0 Inz( 108 )
018600060509     D  NbrPriSts                    10i 0 Inz( 0 )
018700060424     D  OfsActSts                    10i 0 Inz( 128 )
018800060424     D  NbrActSts                    10i 0 Inz( 0 )
018900060424     D  OfsJbqSts                    10i 0 Inz( 136 )
019000060424     D  NbrJbqSts                    10i 0 Inz( 0 )
019100060424     D  OfsJbqNam                    10i 0 Inz( 146 )
019200060508     D  NbrJbqNam                    10i 0 Inz( 0 )
019300060424     D  OfsCurUsr                    10i 0 Inz( 166 )
019400060509     D  NbrCurUsr                    10i 0 Inz( 0 )
019500060424     D  OfsSvrTyp                    10i 0 Inz( 176 )
019600060424     D  NbrSvrTyp                    10i 0 Inz( 0 )
019700060424     D  OfsActSbs                    10i 0 Inz( 206 )
019800060424     D  NbrActSbs                    10i 0 Inz( 0 )
019900060424     D  OfsMemPool                   10i 0 Inz( 216 )
020000060424     D  NbrMemPool                   10i 0 Inz( 0 )
020100060424     D  OfsJobTypE                   10i 0 Inz( 220 )
020200060508     D  NbrJobTypE                   10i 0 Inz( 0 )
020300060424     D  OfsJobNamQ                   10i 0 Inz( 228 )
020400060424     D  NbrJobNamQ                   10i 0 Inz( 0 )
020500060424     **
020600060424     D  PriSts                       10a   Dim( 2 )
020700060424     D  ActSts                        4a   Dim( 2 )
020800060424     D  JbqSts                       10a   Dim( 1 )
020900060424     D  JbqNam                       20a   Dim( 1 )
021000060424     D  CurUsr                       10a   Dim( 1 )
021100060424     D  SvrTyp                       30a   Dim( 1 )
021200060424     D  ActSbs                       10a   Dim( 1 )
021300060424     D  MemPool                      10i 0 Dim( 1 )
021400060424     D  JobTypE                      10i 0 Dim( 1 )
021500060424     D  JobNamQ                      26a   Dim( 1 )
021600060423     **-- Job information key fields:
021700060423     D KeyDta          Ds                  Qualified
021800060509     D  JobEntDts                    13a
021900060511     D   JobEntDat                    7a   Overlay( JobEntDts: 1 )
022000060511     D   JobEntTim                    6a   Overlay( JobEntDts: *Next )
022100060509     D  JobActDts                    13a
022200060511     D   JobActDat                    7a   Overlay( JobActDts: 1 )
022300060511     D   JobActTim                    6a   Overlay( JobActDts: *Next )
022400060509     D  ActJobSts                     4a
022500060511     D  JobDat                        7a
022600060509     D  CurUsr                       10a
022700060511     D  JobCmpSts                     1a
022800060509     D  FncNam                       10a
022900060509     D  FncTyp                        1a
023000060509     D  MsgRpy                        1a
023100060423     D  JobQueSts                    10a
023200060423     D  SbmJob_q                     26a
023300060511     D   SbmJob                      10a   Overlay( SbmJob_q: 1 )
023400060511     D   SbmUsr                      10a   Overlay( SbmJob_q: *Next )
023500060511     D   SbmNbr                       6a   Overlay( SbmJob_q: *Next )
023600060411
023700050226     **-- Open list of jobs:
023800030608     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
023900060411     D  RcvVar                    65535a          Options( *VarSize )
024000060411     D  RcvVarLen                    10i 0 Const
024100060411     D  FmtNam                        8a   Const
024200060411     D  RcvVarDfn                 65535a          Options( *VarSize )
024300060411     D  RcvDfnLen                    10i 0 Const
024400060411     D  LstInf                       80a
024500060411     D  NbrRcdRtn                    10i 0 Const
024600060411     D  SrtInf                     1024a   Const  Options( *VarSize )
024700060411     D  JobSltInf                  1024a   Const  Options( *VarSize )
024800060411     D  JobSltLen                    10i 0 Const
024900060411     D  NbrFldRtn                    10i 0 Const
025000060411     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
025100060411     D  Error                      1024a          Options( *VarSize )
025200060411     D  JobSltFmt                     8a   Const  Options( *NoPass )
025300060411     D  ResStc                        1a   Const  Options( *NoPass )
025400060411     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
025500060411     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
025600060510     **-- Get open list entry:
025700060510     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
025800060423     D  RcvVar                    65535a          Options( *VarSize )
025900060423     D  RcvVarLen                    10i 0 Const
026000060423     D  Handle                        4a   Const
026100060423     D  LstInf                       80a
026200060423     D  NbrRcdRtn                    10i 0 Const
026300060423     D  RtnRcdNbr                    10i 0 Const
026400060423     D  Error                      1024a          Options( *VarSize )
026500050226     **-- Close list:
026600050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
026700060411     D  Handle                        4a   Const
026800060411     D  Error                      1024a          Options( *VarSize )
026900060510
027000060510     **-- Add list entry:
027100060510     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
027200060510     D  AppHdl                        8a   Const
027300060510     D  VarBuf                    32767a   Const  Options( *VarSize )
027400060510     D  VarBufLen                    10i 0 Const
027500060510     D  VarRcdNam                    10a   Const
027600060510     D  LstNam                       10a   Const
027700060510     D  EntLocOpt                     4a   Const
027800060510     D  LstEntHdl                     4a
027900060510     D  Error                     32767a          Options( *VarSize )
028000060510     **-- Put dialog variable:
028100060510     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
028200060510     D  AppHdl                        8a   Const
028300060510     D  VarBuf                    32767a   Const  Options( *VarSize )
028400060510     D  VarBufLen                    10i 0 Const
028500060510     D  VarRcdNam                    10a   Const
028600060510     D  Error                     32767a          Options( *VarSize )
028700060510     **-- Get dialog variable:
028800060510     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
028900060510     D  AppHdl                        8a   Const
029000060510     D  VarBuf                    32767a          Options( *VarSize )
029100060510     D  VarBufLen                    10i 0 Const
029200060510     D  VarRcdNam                    10a   Const
029300060510     D  Error                     32767a          Options( *VarSize )
029400060510     **-- Retrieve list attributes:
029500060510     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
029600060510     D  AppHdl                        8a   Const
029700060510     D  LstNam                       10a   Const
029800060510     D  AtrRcv                    32767a          Options( *VarSize )
029900060510     D  AtrRcvLen                    10i 0 Const
030000060510     D  Error                     32767a          Options( *VarSize )
030100060510     **-- Set list attributes:
030200060510     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
030300060510     D  AppHdl                        8a   Const
030400060510     D  LstNam                       10a   Const
030500060510     D  LstCon                        4a   Const
030600060510     D  ExtPgmVar                    10a   Const
030700060510     D  DspPos                        4a   Const
030800060510     D  AlwTrim                       1a   Const
030900060510     D  Error                     32767a          Options( *VarSize )
031000060510     **-- Delete list:
031100060510     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
031200060510     D  AppHdl                        8a   Const
031300060510     D  LstNam                       10a   Const
031400060510     D  Error                     32767a          Options( *VarSize )
031500060605     **-- Register activation group exit:
031600060605     D CEE4RAGE        Pr                    ExtProc( 'CEE4RAGE' )
031700060605     D  procedure                      *     ProcPtr  Const
031800060605     D  fb                           12a     Options( *Omit )
031900060605
032000060605     **-- Terminate activation group exit:
032100060605     D TrmActGrp       Pr
032200060605     D  ActGrpMrk                    10u 0
032300060605     D  Reason                       10u 0
032400060605     D  Gen_RC                       10u 0
032500060605     D  Usr_RC                       10u 0
032600060510
032700070423     D CBX969L         Pr
032800060510     D  PxType6                            LikeDs( Type6 )
032900050226     **
033000070423     D CBX969L         Pi
033100060510     D  PxType6                            LikeDs( Type6 )
033200050226
033300050226      /Free
033400060510
033500060510        GetDlgVar( PxType6.AppHdl
033600060510                 : CtlRcd
033700060510                 : %Size( CtlRcd )
033800060510                 : 'CTLRCD'
033900060510                 : ERRC0100
034000060510                 );
034100060510
034200060510        If  CtlRcd.Action = 'LIST'  Or  CtlRcd.Action = 'F05';
034300060510          ExSr  BldJobLst;
034400060510        EndIf;
034500060510
034600060512        ExSr  PrcJobLst;
034700060510
034800060510        CtlRcd.EntLocOpt = UIM.EntLocOpt;
034900060510        CtlRcd.Action = *Blanks;
035000060510
035100060510        PutDlgVar( PxType6.AppHdl
035200060510                 : CtlRcd
035300060510                 : %Size( CtlRcd )
035400060510                 : 'CTLRCD'
035500060510                 : ERRC0100
035600060510                 );
035700060510
035800050226        Return;
035900060424
036000060425
036100060510        BegSr  BldJobLst;
036200060510
036300060510          If  LstInf.Handle <> *Blanks;
036400060510            CloseLst( LstInf.Handle: ERRC0100 );
036500060510          EndIf;
036600060510
036700060511          UIM.EntLocOpt = 'FRST';
036800060512
036900060512          LstApi.RtnRcdNbr = 1;
037000060511
037100060424          LstJobs( OLJB0200
037200060424                 : %Size( OLJB0200 )
037300060424                 : 'OLJB0200'
037400060424                 : KeyInf
037500060424                 : %Size( KeyInf )
037600060424                 : LstInf
037700060604                 : BLD_SYNCH
037800060424                 : SrtInf
037900060424                 : OLJS0200
038000060424                 : %Size( OLJS0200 )
038100060424                 : LstApi.NbrFldRtn
038200060424                 : LstApi.KeyFld
038300060424                 : ERRC0100
038400060424                 : 'OLJS0200'
038500060424                 );
038600060424
038700060512          If  ERRC0100.BytAvl > *Zero  Or  LstInf.RcdNbrRtn = *Zero;
038800060510            LstApi.RtnRcdNbr = -1;
038900060512
039000060510          Else;
039100060512            ExSr  PrcLstEnt;
039200060510          EndIf;
039300060605
039400060510        EndSr;
039500060510
039600060512        BegSr  PrcJobLst;
039700060510
039800060512          If  LstApi.RtnRcdNbr > *Zero;
039900060523            LstApi.CurRcdNbr = *Zero;
040000060510
040100060512            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
040200060512
040300060512              LstApi.RtnRcdNbr += 1;
040400060512
040500060512              GetOplEnt( OLJB0200
040600060512                       : %Size( OLJB0200 )
040700060512                       : LstInf.Handle
040800060512                       : LstInf
040900060605                       : SNG_ENT
041000060512                       : LstApi.RtnRcdNbr
041100060512                       : ERRC0100
041200060512                       );
041300060512
041400060512              If  ERRC0100.BytAvl > *Zero;
041500060512                Leave;
041600060512              EndIf;
041700060512
041800060512              ExSr  PrcLstEnt;
041900060512
042000060605              If  LstApi.CurRcdNbr >= MIN_NBR_ENT  And
042100060512                  LstApi.CurRcdNbr >= PxType6.NbrEntRqd;
042200060512
042300060512                Leave;
042400060512              EndIf;
042500060512            EndDo;
042600060510          EndIf;
042700060510
042800060510          Select;
042900060510          When  LstApi.RtnRcdNbr = -1;
043000060510            UIM.LstCnt = LIST_COMP;
043100060510
043200060510          When  LstInf.RcdNbrTot <= LstApi.RtnRcdNbr;
043300060510            UIM.LstCnt = LIST_COMP;
043400060510
043500060510          Other;
043600060510            UIM.LstCnt = LIST_TOP;
043700060510          EndSl;
043800060510
043900060511          SetLstAtr( PxType6.AppHdl
044000060510                   : 'DTLLST'
044100060510                   : UIM.LstCnt
044200060524                   : EXIT_SAME
044300060510                   : POS_SAME
044400060510                   : TRIM_SAME
044500060510                   : ERRC0100
044600060510                   );
044700060510
044800060424        EndSr;
044900060429
045000060512        BegSr  PrcLstEnt;
045100060423
045200060423          Clear  KeyDta;
045300060423
045400060423          For Idx = 1  To KeyInf.FldNbrRtn;
045500060423
045600060423            KeyDtaVal = %SubSt( OLJB0200
045700060423                              : KeyInf.DtaOfs(Idx) + 1
045800060423                              : KeyInf.DtaLen(Idx)
045900060423                              );
046000060423
046100060423            Select;
046200060423            When  KeyInf.KeyFld(Idx) = 101;
046300060423              KeyDta.ActJobSts = KeyDtaVal;
046400060423
046500060423            When  KeyInf.KeyFld(Idx) = 305;
046600060424              KeyDta.CurUsr = KeyDtaVal;
046700060423
046800060511            When  KeyInf.KeyFld(Idx) = 306;
046900060511              KeyDta.JobCmpSts = KeyDtaVal;
047000060511
047100060423            When  KeyInf.KeyFld(Idx) = 401;
047200060423              KeyDta.JobActDts = KeyDtaVal;
047300060423
047400060509            When  KeyInf.KeyFld(Idx) = 402;
047500060509              KeyDta.JobEntDts = KeyDtaVal;
047600070309
047700070309              JobEntDts = %Date( KeyDta.JobEntDat: *CYMD0 ) +
047800070309                          %Time( KeyDta.JobEntTim: *HMS0 );
047900060509
048000060509            When  KeyInf.KeyFld(Idx) = 601;
048100060509              KeyDta.FncNam = KeyDtaVal;
048200060509
048300070423            When  KeyInf.KeyFld(Idx) = 602;
048400060509              KeyDta.Fnctyp = KeyDtaVal;
048500060423
048600060511            When  KeyInf.KeyFld(Idx) = 1002;
048700060511              KeyDta.JobDat = KeyDtaVal;
048800060511
048900060509            When  KeyInf.KeyFld(Idx) = 1307;
049000060509              KeyDta.MsgRpy = KeyDtaVal;
049100060424
049200060423            When  KeyInf.KeyFld(Idx) = 1903;
049300060423              KeyDta.JobQueSts = KeyDtaVal;
049400060423
049500060423            When  KeyInf.KeyFld(Idx) = 1904;
049600060423              KeyDta.SbmJob_q = KeyDtaVal;
049700060423            EndSl;
049800060423          EndFor;
049900060423
050000060511          If  PrmRcd.CmpSts = '*ALL'  Or
050100060511              PrmRcd.CmpSts = '*NORMAL'  And  KeyDta.JobCmpSts = '0'  Or
050200060511              PrmRcd.CmpSts = '*ABNORMAL'  And  KeyDta.JobCmpSts = '1';
050300060511
050400070309            If  JobEntDts >= PerBegDts  And  JobEntDts <= PerEndDts;
050500070309
050600070309              ExSr  PutLstEnt;
050700070309            EndIf;
050800060511          EndIf;
050900060428
051000060423        EndSr;
051100060423
051200060512        BegSr  PutLstEnt;
051300060428
051400060510          LstApi.CurRcdNbr += 1;
051500060510
051600060511          LstEnt.Option = *Zero;
051700060511          LstEnt.EntId  = KeyDta.JobEntDts + OLJB0200.JobNbr;
051800060511          LstEnt.JobNam = OLJB0200.JobNam;
051900060511          LstEnt.JobUsr = OLJB0200.UsrPrf;
052000060511          LstEnt.JobNbr = OLJB0200.JobNbr;
052100060511          LstEnt.JobTyp = OLJB0200.JobTyp;
052200060511          LstEnt.JobSts1 = OLJB0200.Status;
052300060511
052400060511          LstEnt.JobDat = KeyDta.JobDat;
052500060511          LstEnt.EntDat = KeyDta.JobEntDat;
052600060511          LstEnt.EntTim = KeyDta.JobEntTim;
052700060511          LstEnt.ActDat = KeyDta.JobActDat;
052800060511          LstEnt.ActTim = KeyDta.JobActTim;
052900060511          LstEnt.MsgRpy = KeyDta.MsgRpy;
053000060511          LstEnt.SbmJob = KeyDta.SbmJob;
053100060511          LstEnt.SbmUsr = KeyDta.SbmUsr;
053200060511          LstEnt.SbmNbr = KeyDta.SbmNbr;
053300060511
053400060511          Select;
053500060511          When  OLJB0200.Status = '*ACTIVE';
053600060515            LstEnt.CurUsr = KeyDta.CurUsr;
053700060515            LstEnt.JobSts2 = KeyDta.ActJobSts;
053800060511
053900060511          When  OLJB0200.Status = '*JOBQ';
054000060515            LstEnt.CurUsr = OLJB0200.UsrPrf;
054100060515            LstEnt.JobSts2 = KeyDta.JobQueSts;
054200060511
054300060511          Other;
054400060515            LstEnt.CurUsr = OLJB0200.UsrPrf;
054500060515            LstEnt.JobSts2 = *Blanks;
054600060511          EndSl;
054700060511
054800060511          Select;
054900060511          When  OLJB0200.Status = '*ACTIVE';
055000060511
055100060512            Select;
055200060512            When  KeyDta.FncTyp = 'C';
055300060511              LstEnt.FncCmp = 'CMD-' + KeyDta.FncNam;
055400060511
055500060512            When  KeyDta.FncTyp = 'D';
055600060511              LstEnt.FncCmp = 'DLY-' + KeyDta.FncNam;
055700060511
055800060512            When  KeyDta.FncTyp = 'G';
055900060511              LstEnt.FncCmp = 'GRP-' + KeyDta.FncNam;
056000060511
056100060512            When  KeyDta.FncTyp = 'I';
056200060511              LstEnt.FncCmp = 'IDX-' + KeyDta.FncNam;
056300060511
056400060512            When  KeyDta.FncTyp = 'J';
056500060511              LstEnt.FncCmp = 'JVM-' + KeyDta.FncNam;
056600060511
056700060512            When  KeyDta.FncTyp = 'L';
056800060511              LstEnt.FncCmp = 'LOG-' + KeyDta.FncNam;
056900060511
057000060512            When  KeyDta.FncTyp = 'M';
057100060511              LstEnt.FncCmp = 'MRT-' + KeyDta.FncNam;
057200060511
057300060512            When  KeyDta.FncTyp = 'N';
057400060511              LstEnt.FncCmp = 'MNU-' + KeyDta.FncNam;
057500060511
057600060512            When  KeyDta.FncTyp = 'O';
057700060511              LstEnt.FncCmp = 'I/O-' + KeyDta.FncNam;
057800060511
057900060512            When  KeyDta.FncTyp = 'P';
058000060511              LstEnt.FncCmp = 'PGM-' + KeyDta.FncNam;
058100060511
058200060512            When  KeyDta.FncTyp = 'R';
058300060511              LstEnt.FncCmp = 'PRC-' + KeyDta.FncNam;
058400060511
058500060512            When  KeyDta.FncTyp = '*';
058600060511              LstEnt.FncCmp = '*  -' + KeyDta.FncNam;
058700060518
058800060518            Other;
058900060518              LstEnt.FncCmp = *Blanks;
059000060512            EndSl;
059100060511
059200060511          When  OLJB0200.Status = '*OUTQ';
059300060511
059400060512            Select;
059500060512            When  KeyDta.JobCmpSts = *Blanks;
059600060511              LstEnt.FncCmp = *Blanks;
059700060511
059800060512            When  KeyDta.JobCmpSts = '0';
059900060511              LstEnt.FncCmp = '*NORMAL';
060000060511
060100060512            When  KeyDta.JobCmpSts = '1';
060200060511              LstEnt.FncCmp = '*ABNORMAL';
060300060512            EndSl;
060400060511
060500060511          Other;
060600060511            LstEnt.FncCmp = *Blanks;
060700060511          EndSl;
060800060511
060900060511          AddLstEnt( PxType6.AppHdl
061000060511                   : LstEnt
061100060511                   : %Size( LstEnt )
061200060511                   : 'DTLRCD'
061300060511                   : 'DTLLST'
061400060511                   : UIM.EntLocOpt
061500060511                   : UIM.LstHdl
061600060511                   : ERRC0100
061700060511                   );
061800060511
061900060511          UIM.EntLocOpt = 'NEXT';
062000060428
062100060428        EndSr;
062200060510
062300060510        BegSr  *InzSr;
062400060605
062500060605          CEE4RAGE( %Paddr( TrmActGrp ): *Omit );
062600060510
062700060510          GetDlgVar( PxType6.AppHdl
062800060510                   : PrmRcd
062900060510                   : %Size( PrmRcd )
063000060510                   : 'PRMRCD'
063100060510                   : ERRC0100
063200060510                   );
063300060510
063400060510          OLJS0200.JobNam = PrmRcd.JobNam;
063500060510          OLJS0200.UsrPrf = PrmRcd.UsrPrf;
063600060510          OLJS0200.JobTyp = PrmRcd.JobTyp;
063700060510
063800060510          Select;
063900060516          When  PrmRcd.JobSts = '*ALL';
064000060510            OLJS0200.NbrPriSts = *Zero;
064100060510
064200060516          When  PrmRcd.JobSts = '*NONOUTQ';
064300060516            OLJS0200.NbrPriSts = 2;
064400060516            OLJS0200.PriSts(1) = '*JOBQ';
064500060516            OLJS0200.PriSts(2) = '*ACTIVE';
064600060516
064700060516          Other;
064800060510            OLJS0200.NbrPriSts = 1;
064900060516            OLJS0200.PriSts(1) = PrmRcd.JobSts;
065000060510          EndSl;
065100060510
065200060510          If  PrmRcd.CurUsr > *Blanks;
065300060510            OLJS0200.NbrCurUsr = 1;
065400060510            OLJS0200.CurUsr(1) = PrmRcd.CurUsr;
065500060510            OLJS0200.UsrPrf = '*ALL';
065600060510          EndIf;
065700060510
065800060510          SrtInf.NbrKeys      = 2;
065900060510          SrtInf.KeyFldOfs(1) = 61;
066000060510          SrtInf.KeyFldLen(1) = %Size( KeyDta.JobEntDts );
066100060510          SrtInf.KeyFldTyp(1) = NUM_ZON;
066200060510          SrtInf.SrtOrd(1)    = SORT_DSC;
066300060510          SrtInf.Rsv(1)       = x'00';
066400060510
066500060510          SrtInf.KeyFldOfs(2) = 21;
066600060510          SrtInf.KeyFldLen(2) = %Size( OLJB0200.JobNbr );
066700060510          SrtInf.KeyFldTyp(2) = NUM_ZON;
066800060510          SrtInf.SrtOrd(2)    = SORT_DSC;
066900060510          SrtInf.Rsv(2)       = x'00';
067000060510
067100060510          LstApi.KeyFld(1) = 402;
067200060510          LstApi.KeyFld(2) = 401;
067300060510          LstApi.KeyFld(3) = 101;
067400060511          LstApi.KeyFld(4) = 305;
067500060511          LstApi.KeyFld(5) = 306;
067600060511          LstApi.KeyFld(6) = 601;
067700070423          LstApi.KeyFld(7) = 602;
067800060511          LstApi.KeyFld(8) = 1002;
067900060511          LstApi.KeyFld(9) = 1307;
068000060511          LstApi.KeyFld(10) = 1903;
068100060511          LstApi.KeyFld(11) = 1904;
068200060428
068300070308          If  PrmRcd.Period.NbrElm = 2;
068400070308
068500070306            Select;
068600070306            When  PrmRcd.Period.DatBeg = '0010000';
068700070306              PrmRcd.Period.DatBeg = %Char( %Date(): *CYMD0 );
068800070306
068900070306            When  PrmRcd.Period.DatBeg = '0020000';
069000070308              PrmRcd.Period.DatBeg = %Char( LO_Date: *CYMD0 );
069100070306            EndSl;
069200070306
069300070306            Select;
069400070306            When  PrmRcd.Period.DatEnd = '0010000';
069500070308              PrmRcd.Period.DatEnd = %Char( %Date(): *CYMD0 );
069600070306
069700070306            When  PrmRcd.Period.DatEnd = '0030000';
069800070308              PrmRcd.Period.DatEnd = %Char( HI_Date: *CYMD0 );
069900070327              PrmRcd.Period.TimEnd = %Char( HI_Time: *HMS0 );
070000070306            EndSl;
070100070306
070200070309            PerBegDts = %Date( PrmRcd.Period.DatBeg: *CYMD0 ) +
070300070309                        %Time( PrmRcd.Period.TimBeg: *HMS0 );
070400070309
070500070309            PerEndDts = %Date( PrmRcd.Period.DatEnd: *CYMD0 ) +
070600070309                        %Time( PrmRcd.Period.TimEnd: *HMS0 );
070700070306          EndIf;
070800070306
070900060510        EndSr;
071000060430
071100060510      /End-Free
071200060605
071300060605     **-- Terminate activation group exit:
071400060605     P TrmActGrp       B
071500060605     D                 Pi
071600060605     D  ActGrpMrk                    10u 0
071700060605     D  Reason                       10u 0
071800060605     D  Gen_RC                       10u 0
071900060605     D  Usr_RC                       10u 0
072000060605
072100060605      /Free
072200060605
072300060605        If  LstInf.Handle <> *Blanks;
072400060605          CloseLst( LstInf.Handle: ERRC0100 );
072500060605        EndIf;
072600060605
072700060605        *InLr = *On;
072800060605
072900060605        Return;
073000060605
073100060605      /End-Free
073200060605
073300060605     P TrmActGrp       E
