000100060517     **
000200070101     **  Program . . : CBX965L
000300060517     **  Description : Work with Jobs - UIM List Exit Program
000400060517     **  Author  . . : Carsten Flensburg
000500070101     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060517     **
000700060517     **
000800060517     **
000900060517     **  Compile options:
001000070101     **    CrtRpgMod  Module( CBX965L )
001100060517     **               DbgView( *LIST )
001200060517     **
001300070101     **    CrtPgm     Pgm( CBX965L )
001400070101     **               Module( CBX965L )
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
004400060510
004500060510     **-- UIM constants:
004600060510     D LIST_TOP        c                   'TOP'
004700060510     D LIST_BOT        c                   'BOT'
004800060510     D LIST_COMP       c                   'ALL'
004900060510     D LIST_SAME       c                   'SAME'
005000060510     D EXIT_SAME       c                   '*SAME'
005100060510     D TRIM_SAME       c                   'S'
005200060510     D POS_TOP         c                   'TOP'
005300060510     D POS_BOT         c                   'BOT'
005400060510     D POS_SAME        c                   'SAME'
005500060510     **-- UIM variables:
005600060510     D UIM             Ds                  Qualified
005700060510     D  AppHdl                        8a
005800060510     D  LstHdl                        4a
005900060510     D  EntHdl                        4a
006000060510     D  FncRqs                       10i 0
006100060510     D  EntLocOpt                     4a
006200060510     D  LstPos                        4a
006300060510     D  LstCnt                        4a
006400060510     **-- UIM exit program interfaces:
006500060510     **-- Incomplete list:
006600060510     D Type6           Ds                  Qualified
006700060510     D  StcLvl                       10i 0
006800060510     D                                8a
006900060510     D  TypCall                      10i 0
007000060510     D  AppHdl                        8a
007100060510     D                               10a
007200060510     D  LstNam                       10a
007300060510     D  IncLstDir                    10i 0
007400060510     D  NbrEntRqd                    10i 0
007500060511
007600060510     **-- UIM Panel control record:
007700060510     D CtlRcd          Ds                  Qualified
007800060510     D  Action                        4a
007900060510     D  EntLocOpt                     4a
008000060510     **-- UIM List parameter record:
008100060510     D PrmRcd          Ds                  Qualified
008200060510     D  UsrPrf                       10a
008300060516     D  JobSts                       10a
008400060510     D  JobTyp                        1a
008500060510     D  CurUsr                       10a
008600060511     D  CmpSts                       10a
008700060511     **-- UIM List entry:
008800060511     D LstEnt          Ds                  Qualified
008900060511     D  EntId                        19a
009000060511     D  JobNam                       10a
009100060511     D  JobUsr                       10a
009200060511     D  JobNbr                        6a
009300060511     D  JobTyp                        1a
009400060511     D  JobSts1                       7a
009500060511     D  JobSts2                       4a
009600060511     D  JobDat                        7a
009700060511     D  EntDat                        7a
009800060511     D  EntTim                        6a
009900060511     D  ActDat                        7a
010000060511     D  ActTim                        6a
010100060511     D  CurUsr                       10a
010200060511     D  FncCmp                       14a
010300060511     D  MsgRpy                        1a
010400060511     D  SbmJob                       10a
010500060511     D  SbmUsr                       10a
010600060511     D  SbmNbr                        6a
010700060510
010800060424     **-- List API parameters:
010900060424     D LstApi          Ds                  Qualified  Inz
011000060510     D  RtnRcdNbr                    10i 0
011100060510     D  CurRcdNbr                    10i 0
011200060424     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
011300060511     D  KeyFld                       10i 0 Dim( 11 )
011400000906     **-- Job information:
011500060411     D OLJB0200        Ds           512    Qualified
011600050311     D  JobNam                       10a
011700050311     D  UsrPrf                       10a
011800050311     D  JobNbr                        6a
011900050226     D  JobIdInt                     16a
012000050226     D  Status                       10a
012100050226     D  JobTyp                        1a
012200050226     D  JobSubTyp                     1a
012300000427     D                                2a
012400060411     D  JobInfSts                     1a
012500060411     D                                3a
012600060411     **-- Key information:
012700060411     D KeyInf          Ds                  Qualified
012800060411     D  FldNbrRtn                    10i 0
012900060424     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
013000060411     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
013100060411     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
013200060411     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
013300060411     D                                3a   Overlay( KeyStr: 10 )
013400060411     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
013500060411     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
013600000906     **-- Sort information:
013700050226     D SrtInf          Ds                  Qualified
013800060430     D  NbrKeys                      10i 0 Inz( 0 )
013900060425     D  SrtStr                       12a   Dim( 3 )
014000050226     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
014100050226     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
014200050226     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
014300050226     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
014400060411     D   Rsv                          1a   Overlay( SrtStr: 12 )
014500000906     **-- List information:
014600050226     D LstInf          Ds                  Qualified
014700050226     D  RcdNbrTot                    10i 0
014800050226     D  RcdNbrRtn                    10i 0
014900050226     D  Handle                        4a
015000050226     D  RcdLen                       10i 0
015100050226     D  InfSts                        1a
015200050226     D  Dts                          13a
015300050226     D  LstSts                        1a
015400990920     D                                1a
015500050226     D  InfLen                       10i 0
015600050226     D  Rcd1                         10i 0
015700990920     D                               40a
015800060424     **-- Selection information:
015900060424     D OLJS0200        Ds                  Qualified
016000061116     D  JobNam                       10a   Inz( '*ALL' )
016100060509     D  UsrPrf                       10a
016200060424     D  JobNbr                        6a   Inz( '*ALL' )
016300060509     D  JobTyp                        1a
016400060424     D                                1a
016500060424     D  OfsPriSts                    10i 0 Inz( 108 )
016600060509     D  NbrPriSts                    10i 0 Inz( 0 )
016700060424     D  OfsActSts                    10i 0 Inz( 128 )
016800060424     D  NbrActSts                    10i 0 Inz( 0 )
016900060424     D  OfsJbqSts                    10i 0 Inz( 136 )
017000060424     D  NbrJbqSts                    10i 0 Inz( 0 )
017100060424     D  OfsJbqNam                    10i 0 Inz( 146 )
017200060508     D  NbrJbqNam                    10i 0 Inz( 0 )
017300060424     D  OfsCurUsr                    10i 0 Inz( 166 )
017400060509     D  NbrCurUsr                    10i 0 Inz( 0 )
017500060424     D  OfsSvrTyp                    10i 0 Inz( 176 )
017600060424     D  NbrSvrTyp                    10i 0 Inz( 0 )
017700060424     D  OfsActSbs                    10i 0 Inz( 206 )
017800060424     D  NbrActSbs                    10i 0 Inz( 0 )
017900060424     D  OfsMemPool                   10i 0 Inz( 216 )
018000060424     D  NbrMemPool                   10i 0 Inz( 0 )
018100060424     D  OfsJobTypE                   10i 0 Inz( 220 )
018200060508     D  NbrJobTypE                   10i 0 Inz( 0 )
018300060424     D  OfsJobNamQ                   10i 0 Inz( 228 )
018400060424     D  NbrJobNamQ                   10i 0 Inz( 0 )
018500060424     **
018600060424     D  PriSts                       10a   Dim( 2 )
018700060424     D  ActSts                        4a   Dim( 2 )
018800060424     D  JbqSts                       10a   Dim( 1 )
018900060424     D  JbqNam                       20a   Dim( 1 )
019000060424     D  CurUsr                       10a   Dim( 1 )
019100060424     D  SvrTyp                       30a   Dim( 1 )
019200060424     D  ActSbs                       10a   Dim( 1 )
019300060424     D  MemPool                      10i 0 Dim( 1 )
019400060424     D  JobTypE                      10i 0 Dim( 1 )
019500060424     D  JobNamQ                      26a   Dim( 1 )
019600060423     **-- Job information key fields:
019700060423     D KeyDta          Ds                  Qualified
019800060509     D  JobEntDts                    13a
019900060511     D   JobEntDat                    7a   Overlay( JobEntDts: 1 )
020000060511     D   JobEntTim                    6a   Overlay( JobEntDts: *Next )
020100060509     D  JobActDts                    13a
020200060511     D   JobActDat                    7a   Overlay( JobActDts: 1 )
020300060511     D   JobActTim                    6a   Overlay( JobActDts: *Next )
020400060509     D  ActJobSts                     4a
020500060511     D  JobDat                        7a
020600060509     D  CurUsr                       10a
020700060511     D  JobCmpSts                     1a
020800060509     D  FncNam                       10a
020900060509     D  FncTyp                        1a
021000060509     D  MsgRpy                        1a
021100060423     D  JobQueSts                    10a
021200060423     D  SbmJob_q                     26a
021300060511     D   SbmJob                      10a   Overlay( SbmJob_q: 1 )
021400060511     D   SbmUsr                      10a   Overlay( SbmJob_q: *Next )
021500060511     D   SbmNbr                       6a   Overlay( SbmJob_q: *Next )
021600060411
021700050226     **-- Open list of jobs:
021800030608     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
021900060411     D  RcvVar                    65535a          Options( *VarSize )
022000060411     D  RcvVarLen                    10i 0 Const
022100060411     D  FmtNam                        8a   Const
022200060411     D  RcvVarDfn                 65535a          Options( *VarSize )
022300060411     D  RcvDfnLen                    10i 0 Const
022400060411     D  LstInf                       80a
022500060411     D  NbrRcdRtn                    10i 0 Const
022600060411     D  SrtInf                     1024a   Const  Options( *VarSize )
022700060411     D  JobSltInf                  1024a   Const  Options( *VarSize )
022800060411     D  JobSltLen                    10i 0 Const
022900060411     D  NbrFldRtn                    10i 0 Const
023000060411     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
023100060411     D  Error                      1024a          Options( *VarSize )
023200060411     D  JobSltFmt                     8a   Const  Options( *NoPass )
023300060411     D  ResStc                        1a   Const  Options( *NoPass )
023400060411     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
023500060411     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
023600060510     **-- Get open list entry:
023700060510     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
023800060423     D  RcvVar                    65535a          Options( *VarSize )
023900060423     D  RcvVarLen                    10i 0 Const
024000060423     D  Handle                        4a   Const
024100060423     D  LstInf                       80a
024200060423     D  NbrRcdRtn                    10i 0 Const
024300060423     D  RtnRcdNbr                    10i 0 Const
024400060423     D  Error                      1024a          Options( *VarSize )
024500050226     **-- Close list:
024600050226     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
024700060411     D  Handle                        4a   Const
024800060411     D  Error                      1024a          Options( *VarSize )
024900060510
025000060510     **-- Add list entry:
025100060510     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
025200060510     D  AppHdl                        8a   Const
025300060510     D  VarBuf                    32767a   Const  Options( *VarSize )
025400060510     D  VarBufLen                    10i 0 Const
025500060510     D  VarRcdNam                    10a   Const
025600060510     D  LstNam                       10a   Const
025700060510     D  EntLocOpt                     4a   Const
025800060510     D  LstEntHdl                     4a
025900060510     D  Error                     32767a          Options( *VarSize )
026000060510     **-- Put dialog variable:
026100060510     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
026200060510     D  AppHdl                        8a   Const
026300060510     D  VarBuf                    32767a   Const  Options( *VarSize )
026400060510     D  VarBufLen                    10i 0 Const
026500060510     D  VarRcdNam                    10a   Const
026600060510     D  Error                     32767a          Options( *VarSize )
026700060510     **-- Get dialog variable:
026800060510     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
026900060510     D  AppHdl                        8a   Const
027000060510     D  VarBuf                    32767a          Options( *VarSize )
027100060510     D  VarBufLen                    10i 0 Const
027200060510     D  VarRcdNam                    10a   Const
027300060510     D  Error                     32767a          Options( *VarSize )
027400060510     **-- Retrieve list attributes:
027500060510     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
027600060510     D  AppHdl                        8a   Const
027700060510     D  LstNam                       10a   Const
027800060510     D  AtrRcv                    32767a          Options( *VarSize )
027900060510     D  AtrRcvLen                    10i 0 Const
028000060510     D  Error                     32767a          Options( *VarSize )
028100060510     **-- Set list attributes:
028200060510     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
028300060510     D  AppHdl                        8a   Const
028400060510     D  LstNam                       10a   Const
028500060510     D  LstCon                        4a   Const
028600060510     D  ExtPgmVar                    10a   Const
028700060510     D  DspPos                        4a   Const
028800060510     D  AlwTrim                       1a   Const
028900060510     D  Error                     32767a          Options( *VarSize )
029000060510     **-- Delete list:
029100060510     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
029200060510     D  AppHdl                        8a   Const
029300060510     D  LstNam                       10a   Const
029400060510     D  Error                     32767a          Options( *VarSize )
029500060605     **-- Register activation group exit:
029600060605     D CEE4RAGE        Pr                    ExtProc( 'CEE4RAGE' )
029700060605     D  procedure                      *     ProcPtr  Const
029800060605     D  fb                           12a     Options( *Omit )
029900060605
030000060605     **-- Terminate activation group exit:
030100060605     D TrmActGrp       Pr
030200060605     D  ActGrpMrk                    10u 0
030300060605     D  Reason                       10u 0
030400060605     D  Gen_RC                       10u 0
030500060605     D  Usr_RC                       10u 0
030600060510
030700070101     D CBX965L         Pr
030800060510     D  PxType6                            LikeDs( Type6 )
030900050226     **
031000070101     D CBX965L         Pi
031100060510     D  PxType6                            LikeDs( Type6 )
031200050226
031300050226      /Free
031400060510
031500060510        GetDlgVar( PxType6.AppHdl
031600060510                 : CtlRcd
031700060510                 : %Size( CtlRcd )
031800060510                 : 'CTLRCD'
031900060510                 : ERRC0100
032000060510                 );
032100060510
032200060510        If  CtlRcd.Action = 'LIST'  Or  CtlRcd.Action = 'F05';
032300060510          ExSr  BldJobLst;
032400060510        EndIf;
032500060510
032600060512        ExSr  PrcJobLst;
032700060510
032800060510        CtlRcd.EntLocOpt = UIM.EntLocOpt;
032900060510        CtlRcd.Action = *Blanks;
033000060510
033100060510        PutDlgVar( PxType6.AppHdl
033200060510                 : CtlRcd
033300060510                 : %Size( CtlRcd )
033400060510                 : 'CTLRCD'
033500060510                 : ERRC0100
033600060510                 );
033700060510
033800050226        Return;
033900060424
034000060425
034100060510        BegSr  BldJobLst;
034200060510
034300060510          If  LstInf.Handle <> *Blanks;
034400060510            CloseLst( LstInf.Handle: ERRC0100 );
034500060510          EndIf;
034600060510
034700060511          UIM.EntLocOpt = 'FRST';
034800060512
034900060512          LstApi.RtnRcdNbr = 1;
035000060511
035100060424          LstJobs( OLJB0200
035200060424                 : %Size( OLJB0200 )
035300060424                 : 'OLJB0200'
035400060424                 : KeyInf
035500060424                 : %Size( KeyInf )
035600060424                 : LstInf
035700060604                 : BLD_SYNCH
035800060424                 : SrtInf
035900060424                 : OLJS0200
036000060424                 : %Size( OLJS0200 )
036100060424                 : LstApi.NbrFldRtn
036200060424                 : LstApi.KeyFld
036300060424                 : ERRC0100
036400060424                 : 'OLJS0200'
036500060424                 );
036600060424
036700060512          If  ERRC0100.BytAvl > *Zero  Or  LstInf.RcdNbrRtn = *Zero;
036800060510            LstApi.RtnRcdNbr = -1;
036900060512
037000060510          Else;
037100060512            ExSr  PrcLstEnt;
037200060510          EndIf;
037300060605
037400060510        EndSr;
037500060510
037600060512        BegSr  PrcJobLst;
037700060510
037800060512          If  LstApi.RtnRcdNbr > *Zero;
037900060523            LstApi.CurRcdNbr = *Zero;
038000060510
038100060512            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
038200060512
038300060512              LstApi.RtnRcdNbr += 1;
038400060512
038500060512              GetOplEnt( OLJB0200
038600060512                       : %Size( OLJB0200 )
038700060512                       : LstInf.Handle
038800060512                       : LstInf
038900060605                       : SNG_ENT
039000060512                       : LstApi.RtnRcdNbr
039100060512                       : ERRC0100
039200060512                       );
039300060512
039400060512              If  ERRC0100.BytAvl > *Zero;
039500060512                Leave;
039600060512              EndIf;
039700060512
039800060512              ExSr  PrcLstEnt;
039900060512
040000060605              If  LstApi.CurRcdNbr >= MIN_NBR_ENT  And
040100060512                  LstApi.CurRcdNbr >= PxType6.NbrEntRqd;
040200060512
040300060512                Leave;
040400060512              EndIf;
040500060512            EndDo;
040600060510          EndIf;
040700060510
040800060510          Select;
040900060510          When  LstApi.RtnRcdNbr = -1;
041000060510            UIM.LstCnt = LIST_COMP;
041100060510
041200060510          When  LstInf.RcdNbrTot <= LstApi.RtnRcdNbr;
041300060510            UIM.LstCnt = LIST_COMP;
041400060510
041500060510          Other;
041600060510            UIM.LstCnt = LIST_TOP;
041700060510          EndSl;
041800060510
041900060511          SetLstAtr( PxType6.AppHdl
042000060510                   : 'DTLLST'
042100060510                   : UIM.LstCnt
042200060524                   : EXIT_SAME
042300060510                   : POS_SAME
042400060510                   : TRIM_SAME
042500060510                   : ERRC0100
042600060510                   );
042700060510
042800060424        EndSr;
042900060429
043000060512        BegSr  PrcLstEnt;
043100060423
043200060423          Clear  KeyDta;
043300060423
043400060423          For Idx = 1  To KeyInf.FldNbrRtn;
043500060423
043600060423            KeyDtaVal = %SubSt( OLJB0200
043700060423                              : KeyInf.DtaOfs(Idx) + 1
043800060423                              : KeyInf.DtaLen(Idx)
043900060423                              );
044000060423
044100060423            Select;
044200060423            When  KeyInf.KeyFld(Idx) = 101;
044300060423              KeyDta.ActJobSts = KeyDtaVal;
044400060423
044500060423            When  KeyInf.KeyFld(Idx) = 305;
044600060424              KeyDta.CurUsr = KeyDtaVal;
044700060423
044800060511            When  KeyInf.KeyFld(Idx) = 306;
044900060511              KeyDta.JobCmpSts = KeyDtaVal;
045000060511
045100060423            When  KeyInf.KeyFld(Idx) = 401;
045200060423              KeyDta.JobActDts = KeyDtaVal;
045300060423
045400060509            When  KeyInf.KeyFld(Idx) = 402;
045500060509              KeyDta.JobEntDts = KeyDtaVal;
045600060509
045700060509            When  KeyInf.KeyFld(Idx) = 601;
045800060509              KeyDta.FncNam = KeyDtaVal;
045900060509
046000061116            When  KeyInf.KeyFld(Idx) = 602;
046100060509              KeyDta.Fnctyp = KeyDtaVal;
046200060423
046300060511            When  KeyInf.KeyFld(Idx) = 1002;
046400060511              KeyDta.JobDat = KeyDtaVal;
046500060511
046600060509            When  KeyInf.KeyFld(Idx) = 1307;
046700060509              KeyDta.MsgRpy = KeyDtaVal;
046800060424
046900060423            When  KeyInf.KeyFld(Idx) = 1903;
047000060423              KeyDta.JobQueSts = KeyDtaVal;
047100060423
047200060423            When  KeyInf.KeyFld(Idx) = 1904;
047300060423              KeyDta.SbmJob_q = KeyDtaVal;
047400060423            EndSl;
047500060423          EndFor;
047600060423
047700060511          If  PrmRcd.CmpSts = '*ALL'  Or
047800060511              PrmRcd.CmpSts = '*NORMAL'  And  KeyDta.JobCmpSts = '0'  Or
047900060511              PrmRcd.CmpSts = '*ABNORMAL'  And  KeyDta.JobCmpSts = '1';
048000060511
048100060512            ExSr  PutLstEnt;
048200060511          EndIf;
048300060428
048400060423        EndSr;
048500060423
048600060512        BegSr  PutLstEnt;
048700060428
048800060510          LstApi.CurRcdNbr += 1;
048900060510
049000060511          LstEnt.EntId  = KeyDta.JobEntDts + OLJB0200.JobNbr;
049100060511          LstEnt.JobNam = OLJB0200.JobNam;
049200060511          LstEnt.JobUsr = OLJB0200.UsrPrf;
049300060511          LstEnt.JobNbr = OLJB0200.JobNbr;
049400060511          LstEnt.JobTyp = OLJB0200.JobTyp;
049500060511          LstEnt.JobSts1 = OLJB0200.Status;
049600060511
049700060511          LstEnt.JobDat = KeyDta.JobDat;
049800060511          LstEnt.EntDat = KeyDta.JobEntDat;
049900060511          LstEnt.EntTim = KeyDta.JobEntTim;
050000060511          LstEnt.ActDat = KeyDta.JobActDat;
050100060511          LstEnt.ActTim = KeyDta.JobActTim;
050200060511          LstEnt.MsgRpy = KeyDta.MsgRpy;
050300060511          LstEnt.SbmJob = KeyDta.SbmJob;
050400060511          LstEnt.SbmUsr = KeyDta.SbmUsr;
050500060511          LstEnt.SbmNbr = KeyDta.SbmNbr;
050600060511
050700060511          Select;
050800060511          When  OLJB0200.Status = '*ACTIVE';
050900060515            LstEnt.CurUsr = KeyDta.CurUsr;
051000060515            LstEnt.JobSts2 = KeyDta.ActJobSts;
051100060511
051200060511          When  OLJB0200.Status = '*JOBQ';
051300060515            LstEnt.CurUsr = OLJB0200.UsrPrf;
051400060515            LstEnt.JobSts2 = KeyDta.JobQueSts;
051500060511
051600060511          Other;
051700060515            LstEnt.CurUsr = OLJB0200.UsrPrf;
051800060515            LstEnt.JobSts2 = *Blanks;
051900060511          EndSl;
052000060511
052100060511          Select;
052200060511          When  OLJB0200.Status = '*ACTIVE';
052300060511
052400060512            Select;
052500060512            When  KeyDta.FncTyp = 'C';
052600060511              LstEnt.FncCmp = 'CMD-' + KeyDta.FncNam;
052700060511
052800060512            When  KeyDta.FncTyp = 'D';
052900060511              LstEnt.FncCmp = 'DLY-' + KeyDta.FncNam;
053000060511
053100060512            When  KeyDta.FncTyp = 'G';
053200060511              LstEnt.FncCmp = 'GRP-' + KeyDta.FncNam;
053300060511
053400060512            When  KeyDta.FncTyp = 'I';
053500060511              LstEnt.FncCmp = 'IDX-' + KeyDta.FncNam;
053600060511
053700060512            When  KeyDta.FncTyp = 'J';
053800060511              LstEnt.FncCmp = 'JVM-' + KeyDta.FncNam;
053900060511
054000060512            When  KeyDta.FncTyp = 'L';
054100060511              LstEnt.FncCmp = 'LOG-' + KeyDta.FncNam;
054200060511
054300060512            When  KeyDta.FncTyp = 'M';
054400060511              LstEnt.FncCmp = 'MRT-' + KeyDta.FncNam;
054500060511
054600060512            When  KeyDta.FncTyp = 'N';
054700060511              LstEnt.FncCmp = 'MNU-' + KeyDta.FncNam;
054800060511
054900060512            When  KeyDta.FncTyp = 'O';
055000060511              LstEnt.FncCmp = 'I/O-' + KeyDta.FncNam;
055100060511
055200060512            When  KeyDta.FncTyp = 'P';
055300060511              LstEnt.FncCmp = 'PGM-' + KeyDta.FncNam;
055400060511
055500060512            When  KeyDta.FncTyp = 'R';
055600060511              LstEnt.FncCmp = 'PRC-' + KeyDta.FncNam;
055700060511
055800060512            When  KeyDta.FncTyp = '*';
055900060511              LstEnt.FncCmp = '*  -' + KeyDta.FncNam;
056000060518
056100060518            Other;
056200060518              LstEnt.FncCmp = *Blanks;
056300060512            EndSl;
056400060511
056500060511          When  OLJB0200.Status = '*OUTQ';
056600060511
056700060512            Select;
056800060512            When  KeyDta.JobCmpSts = *Blanks;
056900060511              LstEnt.FncCmp = *Blanks;
057000060511
057100060512            When  KeyDta.JobCmpSts = '0';
057200060511              LstEnt.FncCmp = '*NORMAL';
057300060511
057400060512            When  KeyDta.JobCmpSts = '1';
057500060511              LstEnt.FncCmp = '*ABNORMAL';
057600060512            EndSl;
057700060511
057800060511          Other;
057900060511            LstEnt.FncCmp = *Blanks;
058000060511          EndSl;
058100060511
058200060511          AddLstEnt( PxType6.AppHdl
058300060511                   : LstEnt
058400060511                   : %Size( LstEnt )
058500060511                   : 'DTLRCD'
058600060511                   : 'DTLLST'
058700060511                   : UIM.EntLocOpt
058800060511                   : UIM.LstHdl
058900060511                   : ERRC0100
059000060511                   );
059100060511
059200060511          UIM.EntLocOpt = 'NEXT';
059300060428
059400060428        EndSr;
059500060510
059600060510        BegSr  *InzSr;
059700060605
059800060605          CEE4RAGE( %Paddr( TrmActGrp ): *Omit );
059900060510
060000060510          GetDlgVar( PxType6.AppHdl
060100060510                   : PrmRcd
060200060510                   : %Size( PrmRcd )
060300060510                   : 'PRMRCD'
060400060510                   : ERRC0100
060500060510                   );
060600060510
060700060510          OLJS0200.UsrPrf = PrmRcd.UsrPrf;
060800060510          OLJS0200.JobTyp = PrmRcd.JobTyp;
060900060510
061000060510          Select;
061100060516          When  PrmRcd.JobSts = '*ALL';
061200060510            OLJS0200.NbrPriSts = *Zero;
061300060510
061400060516          When  PrmRcd.JobSts = '*NONOUTQ';
061500060516            OLJS0200.NbrPriSts = 2;
061600060516            OLJS0200.PriSts(1) = '*JOBQ';
061700060516            OLJS0200.PriSts(2) = '*ACTIVE';
061800060516
061900060516          Other;
062000060510            OLJS0200.NbrPriSts = 1;
062100060516            OLJS0200.PriSts(1) = PrmRcd.JobSts;
062200060510          EndSl;
062300060510
062400060510          If  PrmRcd.CurUsr > *Blanks;
062500060510            OLJS0200.NbrCurUsr = 1;
062600060510            OLJS0200.CurUsr(1) = PrmRcd.CurUsr;
062700060510            OLJS0200.UsrPrf = '*ALL';
062800060510          EndIf;
062900060510
063000060510          SrtInf.NbrKeys      = 2;
063100060510          SrtInf.KeyFldOfs(1) = 61;
063200060510          SrtInf.KeyFldLen(1) = %Size( KeyDta.JobEntDts );
063300060510          SrtInf.KeyFldTyp(1) = NUM_ZON;
063400060510          SrtInf.SrtOrd(1)    = SORT_DSC;
063500060510          SrtInf.Rsv(1)       = x'00';
063600060510
063700060510          SrtInf.KeyFldOfs(2) = 21;
063800060510          SrtInf.KeyFldLen(2) = %Size( OLJB0200.JobNbr );
063900060510          SrtInf.KeyFldTyp(2) = NUM_ZON;
064000060510          SrtInf.SrtOrd(2)    = SORT_DSC;
064100060510          SrtInf.Rsv(2)       = x'00';
064200060510
064300060510          LstApi.KeyFld(1) = 402;
064400060510          LstApi.KeyFld(2) = 401;
064500060510          LstApi.KeyFld(3) = 101;
064600060511          LstApi.KeyFld(4) = 305;
064700060511          LstApi.KeyFld(5) = 306;
064800060511          LstApi.KeyFld(6) = 601;
064900061116          LstApi.KeyFld(7) = 602;
065000060511          LstApi.KeyFld(8) = 1002;
065100060511          LstApi.KeyFld(9) = 1307;
065200060511          LstApi.KeyFld(10) = 1903;
065300060511          LstApi.KeyFld(11) = 1904;
065400060428
065500060510        EndSr;
065600060430
065700060510      /End-Free
065800060605
065900060605     **-- Terminate activation group exit:
066000060605     P TrmActGrp       B
066100060605     D                 Pi
066200060605     D  ActGrpMrk                    10u 0
066300060605     D  Reason                       10u 0
066400060605     D  Gen_RC                       10u 0
066500060605     D  Usr_RC                       10u 0
066600060605
066700060605      /Free
066800060605
066900060605        If  LstInf.Handle <> *Blanks;
067000060605          CloseLst( LstInf.Handle: ERRC0100 );
067100060605        EndIf;
067200060605
067300060605        *InLr = *On;
067400060605
067500060605        Return;
067600060605
067700060605      /End-Free
067800060605
067900060605     P TrmActGrp       E
