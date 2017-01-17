000100041212     **
000200060216     **  Program . . : CBX9522
000300060216     **  Description : Print job run attributes - main CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Compile and setup instructions:
000800060216     **    CrtRpgMod   Module( CBX9522 )
000900050318     **                DbgView( *LIST )
001000041212     **
001100060216     **    CrtPgm      Pgm( CBX9522 )
001200050428     **                Module( CBX9322 )
001300041212     **                ActGrp( *NEW )
001400041212     **
001500041212     **
001600041212     **-- Control specification:  --------------------------------------------**
001700050319     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
001800060216
001900041212     **-- Printer file:
002000041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002100060213
002200041212     **-- Printer file information:
002300050212     D PrtLinInf       Ds                  Qualified
002400050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
002500050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
002600050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
002700041212     **-- System information:
002800050319     D PgmSts         SDs                  Qualified
002900050319     D  PgmNam           *Proc
003000060216
003100041211     **-- API error data structure:
003200041211     D ERRC0100        Ds                  Qualified
003300041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003400041211     D  BytAvl                       10i 0
003500041211     D  MsgId                         7a
003600990921     D                                1a
003700041211     D  MsgDta                      128a
003800060216
003900050212     **-- Global constants:
004000060216     D OFS_MSGDTA      c                   16
004100060216     D NBR_KEY         c                   1
004200050212     D KEY_OFS         c                   80
004300050212     D SIZ_NLS_INF     c                   290
004400050212     D JOB_RUN         c                   0
004500060216     D TYP_BIN         c                   0
004600060216     D TYP_UBIN        c                   9
004700050212     D ASCEND          c                   1
004800050212     D DESCEND         c                   2
004900050212     **
005000050212     D SRT_PUT         c                   1
005100050212     D SRT_END         c                   2
005200050212     D SRT_GET         c                   3
005300050212     D SRT_CNL         c                   4
005400041212     **-- Global variables:
005500041212     D LstTim          s              6s 0
005600050319     D SysNam          s              8a
005700050415     D TrlTxt          s             32a
005800041211     D Idx             s             10i 0
005900050212     D SrtAct          s               n
006000060216     D KeyDtaVal       s             32a
006100050319     **
006200050319     D PrtOrd          Ds                  Based( pNULL )  Qualified
006300050319     D  NbrElm                        5i 0
006400050319     D  SrtFld                       10a
006500050319     D  SrtSeq                       10a
006600050122     **-- List record:
006700050122     D LstRcd          Ds                  Qualified
006800060216     D  PrcUnTm                      20u 0
006900060216     D  TmpStMb                      10i 0
007000060216     D  MxPrcUt                      10a
007100060216     D  MxTmpSt                      10a
007200060216     D  PrcUtDb                      19a
007300060216     D  DftWait                       7a
007400060216     D  ElgPrg                        5a
007500060216     D  TimSlc                        7a
007600060216     D  RunPty                        3i 0
007700060216     D  JobNam                       10a
007800060216     D  UsrPrf                       10a
007900060216     D  JobNbr                        6a
008000050212     **-- List API parameters:
008100050212     D LstApi          Ds                  Qualified  Inz
008200060216     D  RtnRcdNbr                    10i 0 Inz( 1 )
008300050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
008400100403     D  KeyFld                       10i 0 Dim( 10 )
008500060213     **-- Job information:
008600060213     D OLJB0200        Ds           512    Qualified
008700060213     D  JobNam                       10a
008800060213     D  UsrPrf                       10a
008900060213     D  JobNbr                        6a
009000060213     D  JobIdInt                     16a
009100060213     D  Status                       10a
009200060213     D  JobTyp                        1a
009300060213     D  JobSubTyp                     1a
009400060213     D                                2a
009500040426     **-- Key information:
009600060213     D KeyInf          Ds                  Qualified
009700060213     D  FldNbrRtn                    10i 0
009800060216     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
009900060213     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
010000060213     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
010100060213     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
010200060213     D                                3a   Overlay( KeyStr: 10 )
010300060213     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
010400060213     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
010500040426     **-- List information:
010600041211     D LstInf          Ds                  Qualified
010700041211     D  RcdNbrTot                    10i 0
010800041211     D  RcdNbrRtn                    10i 0
010900041211     D  Handle                        4a
011000041211     D  RcdLen                       10i 0
011100041211     D  InfSts                        1a
011200041211     D  Dts                          13a
011300041211     D  LstSts                        1a
011400040426     D                                1a
011500041211     D  InfLen                       10i 0
011600041211     D  Rcd1                         10i 0
011700040426     D                               40a
011800040426     **-- Sort information:
011900050428     D SrtInf          Ds                  Qualified
012000041211     D  NbrKeys                      10i 0 Inz( 0 )
012100050428     D  SrtInf                       12a   Dim( 10 )
012200041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
012300041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
012400041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
012500041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
012600041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
012700040426     **-- Authority control:
012800041211     D AutCtl          Ds                  Qualified
012900041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
013000041211     D  CalLvl                       10i 0 Inz( 0 )
013100041211     D  DplObjAut                    10i 0 Inz( 0 )
013200041211     D  NbrObjAut                    10i 0 Inz( 0 )
013300041211     D  DplLibAut                    10i 0 Inz( 0 )
013400041211     D  NbrLibAut                    10i 0 Inz( 0 )
013500040426     D                               10i 0 Inz( 0 )
013600041211     D  ObjAut                       10a   Dim( 10 )
013700041211     D  LibAut                       10a   Dim( 10 )
013800040426     **-- Selection control:
013900041211     D SltCtl          Ds
014000041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
014100041211     D  SltOmt                       10i 0 Inz( 0 )
014200041211     D  DplSts                       10i 0 Inz( 20 )
014300041211     D  NbrSts                       10i 0 Inz( 1 )
014400040426     D                               10i 0 Inz( 0 )
014500041211     D  Status                        1a   Inz( '*' )
014600060213     **-- Selection information:
014700060213     D OLJS0100        Ds                  Qualified
014800060213     D  JobNam                       10a   Inz( '*ALL' )
014900060213     D  UsrNam                       10a   Inz( '*ALL' )
015000060213     D  JobNbr                        6a   Inz( '*ALL' )
015100060213     D  JobTyp                        1a   Inz( '*' )
015200060213     D                                1a
015300060213     D  OfsPriSts                    10i 0 Inz( 60 )
015400060213     D  NbrPriSts                    10i 0 Inz( 1 )
015500060213     D  OfsActSts                    10i 0 Inz( 70 )
015600060213     D  NbrActSts                    10i 0 Inz( 0 )
015700060213     D  OfsJbqSts                    10i 0 Inz( 78 )
015800060213     D  NbrJbqSts                    10i 0 Inz( 0 )
015900060213     D  OfsJbqNam                    10i 0 Inz( 88 )
016000060213     D  NbrJbqNam                    10i 0 Inz( 0 )
016100060213     **
016200060213     D  PriSts                       10a   Dim( 1 )
016300060213     D  ActSts                        4a   Dim( 2 )
016400060213     D  JbqSts                       10a   Dim( 1 )
016500060213     D  JbqNam                       20a   Dim( 1 )
016600060213     **-- Job information key fields:
016700060213     D KeyDta          Ds                  Qualified
016800060213     D  PrcUniTim                    20u 0
016900060216     D  TmpStgUsdMb                  10i 0
017000060216     D  MaxPrcUniTm                  10i 0
017100060213     D  MaxTmpStgMb                  10i 0
017200060216     D  PrcUniTimDb                  20u 0
017300100403     D  NbrAuxIoRqs                  20u 0
017400060216     D  DftWait                      10i 0
017500060213     D  ElgPrg                       10a
017600060213     D  TimSlc                       10i 0
017700060216     D  RunPty                       10i 0
017800060216
017900050122     **-- Sort API parameters:
018000050212     D SrtApi          Ds                  Qualified  Inz
018100050212     D  DtaBufLen                    10i 0
018200050212     D  DtaRtnLen                    10i 0
018300050212     D  Omit                         16a
018400050122     **
018500050122     D RqsCtlBlk       Ds                  Qualified  Inz
018600050122     D  BlkLen                       10i 0
018700050122     D  RqsTyp                       10i 0 Inz( 8 )
018800050122     D                               10i 0
018900050122     D  Options                      10i 0
019000050122     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
019100050122     D  RcdCnt                       10i 0
019200050122     D  KeyOfs                       10i 0 Inz( KEY_OFS )
019300050122     D  KeyNbr                       10i 0
019400050122     D  NlsOfs                       10i 0
019500050122     D  InpFlsOfs                    10i 0
019600050122     D  InpFlsNbr                    10i 0
019700050122     D  OutFlsOfs                    10i 0
019800050122     D  OutFlsNbr                    10i 0
019900050122     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
020000050122     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
020100050122     D  InpFenLen                    10i 0
020200050122     D  OutFenLen                    10i 0
020300050122     D  NlbMapOfs                    10i 0
020400050122     D  VlrAciOfs                    10i 0
020500050122     D                               10i 0
020600050122     **
020700050122     D SrtKeyInf                     20a   Dim( NBR_KEY )
020800050122     **
020900050122     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
021000050122     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
021100050122     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
021200050122     D SrtSeqTbl                    256a
021300050122     **
021400050122     D SrtKeyInfDs     Ds                  Qualified  Inz
021500050122     D  KeyStrPos                    10i 0
021600050122     D  KeySize                      10i 0
021700050122     D  KeyDtaTyp                    10i 0
021800050122     D  KeyOrder                     10i 0
021900050122     D  KeyOrdPos                    10i 0
022000050122     **
022100050122     D RqsCtlBlkIo     Ds                  Qualified
022200050122     D  RqsTyp                       10i 0 Inz
022300050122     D                               10i 0 Inz
022400050122     D  RcdLen                       10i 0 Inz
022500050122     D  RcdCnt                       10i 0 Inz
022600050122     **
022700050122     D DtaBufInf       Ds                  Qualified
022800050122     D  RcdPrc                       10i 0
022900050122     D  RcdAvl                       10i 0
023000050122     D                                8a
023100060216
023200060213     **-- Open list of jobs:
023300060213     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
023400060213     D  RcvVar                    65535a          Options( *VarSize )
023500060213     D  RcvVarLen                    10i 0 Const
023600060213     D  FmtNam                        8a   Const
023700060213     D  RcvVarDfn                 65535a          Options( *VarSize )
023800060213     D  RcvDfnLen                    10i 0 Const
023900060213     D  LstInf                       80a
024000060213     D  NbrRcdRtn                    10i 0 Const
024100060213     D  SrtInf                     1024a   Const  Options( *VarSize )
024200060213     D  JobSltInf                  1024a   Const  Options( *VarSize )
024300060213     D  JobSltLen                    10i 0 Const
024400060213     D  NbrFldRtn                    10i 0 Const
024500060213     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
024600060213     D  Error                      1024a          Options( *VarSize )
024700060213     D  JobSltFmt                     8a   Const  Options( *NoPass )
024800060213     D  ResStc                        1a   Const  Options( *NoPass )
024900060213     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
025000060213     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
025100041212     **-- Get list entry:
025200020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
025300060213     D  RcvVar                    65535a          Options( *VarSize )
025400060213     D  RcvVarLen                    10i 0 Const
025500060213     D  Handle                        4a   Const
025600060213     D  LstInf                       80a
025700060213     D  NbrRcdRtn                    10i 0 Const
025800060213     D  RtnRcdNbr                    10i 0 Const
025900060213     D  Error                      1024a          Options( *VarSize )
026000041212     **-- Close list:
026100020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
026200060213     D  Handle                        4a   Const
026300060213     D  Error                      1024a          Options( *VarSize )
026400050318     **-- Copy memory:
026500050318     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
026600050318     D  MemOut                         *   Value
026700050318     D  MemInp                         *   Value
026800050318     D  MemSiz                       10u 0 Value
026900050122     **-- Initialize sort:
027000050122     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
027100060213     D  RqsCtlBlk                    80a   Const  Options( *VarSize )
027200060213     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
027300060213     D  OutDtaBuf                 65535a          Options( *VarSize )
027400060213     D  OutDtaLen                    10i 0 Const
027500060213     D  RtnDtaLen                    10i 0
027600060213     D  Error                     32767a          Options( *VarSize )
027700060213     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
027800060213     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
027900050122     **-- Sort input/output:
028000050122     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
028100060213     D  RqsCtlBlk                    16a   Const
028200060213     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
028300060213     D  OutDtaBuf                 65535a          Options( *VarSize )
028400060213     D  OutDtaLen                    10i 0 Const
028500060213     D  OutDtaInf                    16a
028600060213     D  Error                     32767a          Options( *VarSize )
028700060213     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
028800060213     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
028900050319     **-- Send program message:
029000050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
029100060213     D  MsgId                         7a   Const
029200060213     D  MsgFq                        20a   Const
029300060213     D  MsgDta                      128a   Const
029400060213     D  MsgDtaLen                    10i 0 Const
029500060213     D  MsgTyp                       10a   Const
029600060213     D  CalStkE                      10a   Const  Options( *VarSize )
029700060213     D  CalStkCtr                    10i 0 Const
029800060213     D  MsgKey                        4a
029900060213     D  Error                     32767a          Options( *VarSize )
030000050319     **-- Retrieve net attribute:
030100050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
030200060213     D  RcvVar                    32767a          Options( *VarSize )
030300060213     D  RcvVarLen                    10i 0 Const
030400060213     D  NbrNetAtr                    10i 0 Const
030500060213     D  NetAtr                       10a   Const  Dim( 256 )
030600050319     D                                            Options( *VarSize )
030700060213     D  Error                     32767a          Options( *VarSize )
030800041212
030900050319     **-- Get system name:
031000050319     D GetSysNam       Pr             8a   Varying
031100041216     **-- Write detail line:
031200041216     D WrtDtlLin       Pr
031300041212     **-- Write list header:
031400041212     D WrtLstHdr       Pr
031500050415     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
031600041216     **-- Write list trailer:
031700041216     D WrtLstTrl       Pr
031800050415     D  PxTrlTxt                     32a   Const
031900060216     **-- Send escape message:
032000060216     D SndEscMsg       Pr            10i 0
032100060216     D  PxMsgId                       7a   Const
032200060216     D  PxMsgF                       10a   Const
032300060216     D  PxMsgDta                    512a   Const  Varying
032400041212
032500050319     **-- Entry parameters:
032600060216     D CBX9522         Pr
032700060216     D  PxJobTyp                      1a
032800060216     D  PxCpuTimLmt                  10i 0
032900060216     D  PxTmpStgLmt                  10i 0
033000050319     D  PxPrtOrd                           LikeDs( PrtOrd )
033100041212     **
033200060216     D CBX9522         Pi
033300060216     D  PxJobTyp                      1a
033400060216     D  PxCpuTimLmt                  10i 0
033500060216     D  PxTmpStgLmt                  10i 0
033600060216     D  PxPrtOrd                           LikeDs( PrtOrd )
033700041211
033800041211      /Free
033900060216
034000060216        OLJS0100.PriSts(1) = '*ACTIVE';
034100060216        OLJS0100.JobTyp    = PxJobTyp;
034200060216
034300060216        LstApi.KeyFld(1) = 0312;
034400060216        LstApi.KeyFld(2) = 0313;
034500060216        LstApi.KeyFld(3) = 0409;
034600060216        LstApi.KeyFld(4) = 1302;
034700060216        LstApi.KeyFld(5) = 1305;
034800100403        LstApi.KeyFld(6) = 1406;
034900100403        LstApi.KeyFld(7) = 1604;
035000100403        LstApi.KeyFld(8) = 1802;
035100100403        LstApi.KeyFld(9) = 2002;
035200100403        LstApi.KeyFld(10) = 2009;
035300060216
035400060216        SrtInf.NbrKeys      = 0;
035500060216        SrtInf.KeyFldOfs(1) = 0;
035600060216        SrtInf.KeyFldLen(1) = 0;
035700060216        SrtInf.KeyFldTyp(1) = 0;
035800060216        SrtInf.SrtOrd(1)    = '1';
035900060216        SrtInf.Rsv(1)       = x'00';
036000060216
036100060216        LstJobs( OLJB0200
036200060216               : %Size( OLJB0200 )
036300060216               : 'OLJB0200'
036400060216               : KeyInf
036500060216               : %Size( KeyInf )
036600060216               : LstInf
036700060216               : 1
036800060216               : SrtInf
036900060216               : OLJS0100
037000060216               : %Size( OLJS0100 )
037100060216               : LstApi.NbrKeyRtn
037200060216               : LstApi.KeyFld
037300060216               : ERRC0100
037400060216               : 'OLJS0100'
037500060216               );
037600060216
037700060216        If  ERRC0100.BytAvl > *Zero;
037800060216
037900060216          If  ERRC0100.BytAvl < OFS_MSGDTA;
038000060216            ERRC0100.BytAvl = OFS_MSGDTA;
038100060216          EndIf;
038200060216
038300060216          SndEscMsg( ERRC0100.MsgId
038400060216                   : 'QCPFMSG'
038500060216                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
038600060216                   );
038700060216        Else;
038800060216
038900060216          DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
039000060216
039100060216            ExSr  GetKeyDta;
039200060216            ExSr  ChkKeyDta;
039300060216
039400060216            LstApi.RtnRcdNbr += 1;
039500060216
039600060216            GetLstEnt( OLJB0200
039700060216                     : %Size( OLJB0200 )
039800060216                     : LstInf.Handle
039900060216                     : LstInf
040000060216                     : 1
040100060216                     : LstApi.RtnRcdNbr
040200060216                     : ERRC0100
040300060216                     );
040400060216
040500060216          EndDo;
040600060216
040700060216          ExSr  WrtSrtLst;
040800060216
040900060216          If  LstInf.LstSts = '5';
041000060216            WrtLstTrl( '***  P A R T I A L  L I S T  ***' );
041100060216          EndIf;
041200060216
041300060216          WrtLstTrl( '***  E N D  O F  L I S T  ***' );
041400060216
041500060216          CloseLst( LstInf.Handle: ERRC0100 );
041600060216        EndIf;
041700060216
041800060216        *InLr = *On;
041900060216        Return;
042000060216
042100050415
042200060213        BegSr  GetKeyDta;
042300060213
042400060213          Clear  KeyDta;
042500060213
042600060213          For Idx = 1  To KeyInf.FldNbrRtn;
042700060213
042800060213            KeyDtaVal = %SubSt( OLJB0200
042900060213                              : KeyInf.DtaOfs(Idx) + 1
043000060213                              : KeyInf.DtaLen(Idx)
043100060213                              );
043200060213
043300060213
043400060213            Select;
043500060213            When  KeyInf.KeyFld(Idx) = 0312;
043600060213              memcpy( %Addr( KeyDta.PrcUniTim )
043700060213                    : %Addr( KeyDtaVal )
043800060213                    : %Size( KeyDta.PrcUniTim )
043900060213                    );
044000060213
044100060213            When  KeyInf.KeyFld(Idx) = 0313;
044200060213              memcpy( %Addr( KeyDta.PrcUniTimDb )
044300060213                    : %Addr( KeyDtaVal )
044400060213                    : %Size( KeyDta.PrcUniTimDb )
044500060213                    );
044600060213
044700060213            When  KeyInf.KeyFld(Idx) = 0409;
044800060213              memcpy( %Addr( KeyDta.DftWait )
044900060213                    : %Addr( KeyDtaVal )
045000060213                    : %Size( KeyDta.DftWait )
045100060213                    );
045200060213
045300060216            When  KeyInf.KeyFld(Idx) = 1302;
045400060216              memcpy( %Addr( KeyDta.MaxPrcUniTm )
045500060213                    : %Addr( KeyDtaVal )
045600060216                    : %Size( KeyDta.MaxPrcUniTm )
045700060213                    );
045800060213
045900060216            When  KeyInf.KeyFld(Idx) = 1305;
046000060216              memcpy( %Addr( KeyDta.MaxTmpStgMb )
046100060216                    : %Addr( KeyDtaVal )
046200060216                    : %Size( KeyDta.MaxTmpStgMb )
046300060216                    );
046400060216
046500100403            When  KeyInf.KeyFld(Idx) = 1406;
046600100403              memcpy( %Addr( KeyDta.NbrAuxIoRqs )
046700100403                    : %Addr( KeyDtaVal )
046800100403                    : %Size( KeyDta.NbrAuxIoRqs )
046900100403                    );
047000100403
047100060213            When  KeyInf.KeyFld(Idx) = 1604;
047200060213              KeyDta.ElgPrg = KeyDtaVal;
047300060213
047400060213            When  KeyInf.KeyFld(Idx) = 1802;
047500060213              memcpy( %Addr( KeyDta.RunPty )
047600060213                    : %Addr( KeyDtaVal )
047700060213                    : %Size( KeyDta.RunPty )
047800060213                    );
047900060213
048000060213            When  KeyInf.KeyFld(Idx) = 2002;
048100060213              memcpy( %Addr( KeyDta.TimSlc )
048200060213                    : %Addr( KeyDtaVal )
048300060213                    : %Size( KeyDta.TimSlc )
048400060213                    );
048500060213
048600060213            When  KeyInf.KeyFld(Idx) = 2009;
048700060213              memcpy( %Addr( KeyDta.TmpStgUsdMb )
048800060213                    : %Addr( KeyDtaVal )
048900060213                    : %Size( KeyDta.TmpStgUsdMb )
049000060213                    );
049100060213
049200060213            EndSl;
049300060213          EndFor;
049400060213
049500060213        EndSr;
049600041211
049700050319        BegSr  ChkKeyDta;
049800060216
049900060216          Select;
050000060216          When  PxTmpStgLmt = -1  And PxCpuTimLmt = -1;
050100050319            ExSr  AddSrtLst;
050200050319
050300060216          When  PxTmpStgLmt < KeyDta.TmpStgUsdMb  And  PxCpuTimLmt = -1;
050400050319            ExSr  AddSrtLst;
050500060216
050600060216          When  PxCpuTimLmt < KeyDta.PrcUniTim  And  PxTmpStgLmt = -1;
050700060216            ExSr  AddSrtLst;
050800060216
050900060216          When  PxTmpStgLmt < KeyDta.TmpStgUsdMb  And
051000060216                PxCpuTimLmt < KeyDta.PrcUniTim;
051100060216            ExSr  AddSrtLst;
051200050319          EndSl;
051300050319
051400050319        EndSr;
051500050319
051600050122        BegSr  InzSrtLst;
051700050415
051800060216          If  PxPrtOrd.SrtFld = '*TMPSTG';
051900060216            SrtKeyInfDs.KeyDtaTyp = TYP_BIN;
052000060216            SrtKeyInfDs.KeyStrPos = 9;
052100060216            SrtKeyInfDs.KeySize   = %Size( LstRcd.TmpStMb );
052200050415
052300060216          ElseIf  PxPrtOrd.SrtFld = '*CPUTIM';
052400060216            SrtKeyInfDs.KeyDtaTyp = TYP_UBIN;
052500060216            SrtKeyInfDs.KeyStrPos = 1;
052600060216            SrtKeyInfDs.KeySize   = %Size( LstRcd.PrcUnTm );
052700050415          EndIf;
052800050415
052900050415          If  PxPrtOrd.SrtSeq = '*ASCEND';
053000050415            SrtKeyInfDs.KeyOrder  = ASCEND;
053100050415
053200050415          ElseIf  PxPrtOrd.SrtSeq = '*DESCEND';
053300050415            SrtKeyInfDs.KeyOrder  = DESCEND;
053400050415          EndIf;
053500050318
053600060216          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
053700050122
053800050122          RqsCtlBlk.NlsOfs = KEY_OFS +
053900050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
054000050122
054100050122          RqsCtlBlk.BlkLen = KEY_OFS +
054200050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
054300050122                             SIZ_NLS_INF;
054400050122
054500050122          RqsCtlBlk.KeyNbr = NBR_KEY;
054600050122
054700050122          InzSort( RqsCtlBlk
054800050212                 : SrtApi.Omit
054900050212                 : SrtApi.Omit
055000050212                 : SrtApi.DtaBufLen
055100050212                 : SrtApi.DtaRtnLen
055200050122                 : ERRC0100
055300050122                 );
055400050122
055500050122          If  ERRC0100.BytAvl = *Zero;
055600050212            SrtAct = *On;
055700050122          EndIf;
055800050122
055900050122        EndSr;
056000050122
056100050122        BegSr  AddSrtLst;
056200050122
056300050212          If  SrtAct = *Off;
056400050122            ExSr  InzSrtLst;
056500050122          EndIf;
056600050122
056700050122          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
056800050122          RqsCtlBlkIo.RcdCnt = 1;
056900050122          RqsCtlBlkIo.RqsTyp = SRT_PUT;
057000050122
057100060216          LstRcd.PrcUnTm = KeyDta.PrcUniTim;
057200060216          LstRcd.TmpStMb = KeyDta.TmpStgUsdMb;
057300060216
057400060216          If  KeyDta.MaxPrcUniTm = -1;
057500060216            LstRcd.MxPrcUt = '*NOMAX';
057600060216          Else;
057700060216            EvalR  LstRcd.MxPrcUt = %Char( KeyDta.MaxPrcUniTm );
057800060216          EndIf;
057900060216
058000060216          If  KeyDta.MaxTmpStgMb = -1;
058100060216            LstRcd.MxTmpSt = '*NOMAX';
058200060216          Else;
058300060216            EvalR  LstRcd.MxTmpSt = %Char( KeyDta.MaxTmpStgMb );
058400060216          EndIf;
058500060216
058600060216          EvalR  LstRcd.PrcUtDb = %Char( KeyDta.PrcUniTimDb );
058700060216          EvalR  LstRcd.DftWait = %Char( KeyDta.DftWait );
058800060216          EvalR  LstRcd.TimSlc  = %Char( KeyDta.TimSlc );
058900060216
059000060216          LstRcd.ElgPrg  = KeyDta.ElgPrg;
059100060216          LstRcd.RunPty  = KeyDta.RunPty;
059200060216          LstRcd.JobNam  = OLJB0200.JobNam;
059300060216          LstRcd.UsrPrf  = OLJB0200.UsrPrf;
059400060216          LstRcd.JobNbr  = OLJB0200.JobNbr;
059500060216
059600050122          SortIo( RqsCtlBlkIo
059700050122                : LstRcd
059800050212                : SrtApi.Omit
059900050212                : SrtApi.DtaBufLen
060000050122                : DtaBufInf
060100050122                : ERRC0100
060200050122                );
060300050122
060400050122        EndSr;
060500050122
060600050122        BegSr  WrtSrtLst;
060700050122
060800060216          ExSr  EndSrtLst;
060900060216
061000050319          If  DtaBufInf.RcdAvl > *Zero;
061100050319
061200050319            RqsCtlBlkIo.RqsTyp = SRT_GET;
061300050319
061400050319            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
061500050319
061600050319            SortIo( RqsCtlBlkIo
061700050319                  : SrtApi.Omit
061800050319                  : LstRcd
061900050319                  : SrtApi.DtaBufLen
062000050319                  : DtaBufInf
062100050319                  : ERRC0100
062200050319                  );
062300050319
062400060226            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;
062500050319
062600050319              WrtDtlLin();
062700050319
062800050319              SortIo( RqsCtlBlkIo
062900050319                    : SrtApi.Omit
063000050319                    : LstRcd
063100050319                    : SrtApi.DtaBufLen
063200050319                    : DtaBufInf
063300050319                    : ERRC0100
063400050319                    );
063500050319            EndDo;
063600050319          EndIf;
063700050122
063800050122        EndSr;
063900050122
064000050122        BegSr  EndSrtLst;
064100050122
064200050122          RqsCtlBlkIo.RqsTyp = SRT_END;
064300050122
064400050122          SortIo( RqsCtlBlkIo
064500050212                : SrtApi.Omit
064600050212                : SrtApi.Omit
064700050212                : SrtApi.DtaBufLen
064800050122                : DtaBufInf
064900050122                : ERRC0100
065000050122                );
065100050415
065200050415          If  ERRC0100.BytAvl = *Zero;
065300050415            SrtAct = *Off;
065400050415          EndIf;
065500050122
065600050122        EndSr;
065700050122
065800041212        BegSr  *InzSr;
065900041212
066000041212          LstTim = %Int( %Char( %Time(): *ISO0));
066100050319          SysNam = GetSysNam();
066200060216
066300060216          WrtLstHdr( *Omit );
066400041212
066500041212        EndSr;
066600041212
066700050122      /End-Free
066800050122
066900041212     **-- Printer file definition:  ------------------------------------------**
067000041212     OQSYSPRT   EF           Header         2  2
067100041212     O                       UDATE         Y      8
067200041212     O                       LstTim              18 '  :  :  '
067300050319     O                                           36 'System:'
067400050319     O                       SysNam              45
067500060224     O                                           85 'Print Job Run Attributes'
067600041212     O                                          107 'Program:'
067700050319     O                       PgmSts.PgmNam      118
067800041212     O                                          126 'Page:'
067900041212     O                       PAGE             +   1
068000050415     **
068100041212     OQSYSPRT   EF           LstHdr         1
068200060217     O                                           34 'Run'
068300060217     O                                           41 'Time'
068400060217     O                                           58 'Default'
068500060217     O                                           68 'Max. CPU'
068600060217     O                                          102 'Max. temp.'
068700060217     O                                          114 'Temp. stg.'
068800060216     OQSYSPRT   EF           LstHdr         1
068900060216     O                                            3 'Job'
069000060216     O                                           15 'User'
069100060216     O                                           28 'Number'
069200060217     O                                           35 'pty.'
069300060217     O                                           42 'slice'
069400060217     O                                           49 'Purge'
069500060217     O                                           58 'wait'
069600060217     O                                           67 'time ms'
069700060217     O                                           90 'CPU time used ms'
069800060217     O                                          102 'storage Mb'
069900060217     O                                          113 'used Mb'
070000060224     O                                          132 'DB CPU time used'
070100041216     **
070200041212     OQSYSPRT   EF           DtlLin         1
070300060216     O                       LstRcd.JobNam       10
070400060216     O                       LstRcd.UsrPrf       21
070500060216     O                       LstRcd.JobNbr       28
070600060217     O                       LstRcd.RunPty 3     34
070700060217     O                       LstRcd.TimSlc       42
070800060217     O                       LstRcd.ElgPrg       49
070900060217     O                       LstRcd.DftWait      58
071000060217     O                       LstRcd.MxPrcUt      70
071100060217     O                       LstRcd.PrcUnTm3     90
071200060217     O                       LstRcd.MxTmpSt     102
071300060217     O                       LstRcd.TmpStMb3    112
071400060217     O                       LstRcd.PrcUtDb     132
071500041212     **
071600050123     OQSYSPRT   EF           LstTrl         1
071700050415     O                       TrlTxt              34
071800060217
071900060217     **-- Write detail line:
072000041216     P WrtDtlLin       B
072100041212     D                 Pi
072200041212
072300041212      /Free
072400041212
072500060216        WrtLstHdr( 3 );
072600041212
072700041216        Except  DtlLin;
072800041212
072900041212      /End-Free
073000041212
073100041216     P WrtDtlLin       E
073200060217     **-- Write list header:
073300041212     P WrtLstHdr       B
073400041212     D                 Pi
073500050415     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
073600041212
073700041212      /Free
073800041212
073900050415        If  %Addr( PxOvrFlwRel) = *Null;
074000041212
074100041212          Except  Header;
074200041212          Except  LstHdr;
074300041212        Else;
074400041212
074500050212          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
074600041212
074700041212            Except  Header;
074800041212            Except  LstHdr;
074900041212          EndIf;
075000041212        EndIf;
075100041212
075200041212      /End-Free
075300041212
075400041212     P WrtLstHdr       E
075500060217     **-- Write list trailer:
075600041216     P WrtLstTrl       B
075700041216     D                 Pi
075800050415     D  PxTrlTxt                     32a   Const
075900041216
076000041216      /Free
076100041216
076200050415        TrlTxt = PxTrlTxt;
076300050415
076400041216        Except  LstTrl;
076500041216
076600041216      /End-Free
076700041216
076800041216     P WrtLstTrl       E
076900060217     **-- Get system name:
077000050319     P GetSysNam       B
077100050319     D                 Pi             8a   Varying
077200060217
077300050319     **-- Local variables:
077400050319     D Idx             s             10i 0
077500050319     D SysNam          s              8a   Varying
077600050319     **
077700050319     D RtnAtrLen       s             10i 0
077800050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
077900050319     D NetAtr          s             10a   Dim( 1 )
078000050319     **
078100050319     D RtnVar          Ds                  Qualified
078200050319     D  RtnVarNbr                    10i 0
078300050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
078400050319     D  RtnVarDta                  1024a
078500050319
078600050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
078700050319     D  AtrNam                       10a
078800050319     D  DtaTyp                        1a
078900050319     D  InfSts                        1a
079000050319     D  AtrLen                       10i 0
079100050319     D  Atr                        1008a
079200050319
079300050319      /Free
079400050319
079500050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
079600050319
079700050319        NetAtr(1) = 'SYSNAME';
079800050319
079900050319        RtvNetAtr( RtnVar
080000050319                 : RtnAtrLen
080100050319                 : NetAtrNbr
080200050319                 : NetAtr
080300050319                 : ERRC0100
080400050319                 );
080500050319
080600050319        If  ERRC0100.BytAvl > *Zero;
080700050319          SysNam = '';
080800050319
080900050319        Else;
081000050319          For  Idx = 1  to RtnVar.RtnVarNbr;
081100050319
081200050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
081300050319
081400050319            If  RtnAtr.AtrNam = 'SYSNAME';
081500050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
081600050319            EndIf;
081700050319
081800050319          EndFor;
081900050319        EndIf;
082000050319
082100050319        Return  SysNam;
082200050319
082300050319      /End-Free
082400050319
082500050319     P GetSysNam       E
082600060217     **-- Send escape message:
082700060216     P SndEscMsg       B
082800060216     D                 Pi            10i 0
082900060216     D  PxMsgId                       7a   Const
083000060216     D  PxMsgF                       10a   Const
083100060216     D  PxMsgDta                    512a   Const  Varying
083200060216     **
083300060216     D MsgKey          s              4a
083400060216
083500060216      /Free
083600060216
083700060216        SndPgmMsg( PxMsgId
083800060216                 : PxMsgF + '*LIBL'
083900060216                 : PxMsgDta
084000060216                 : %Len( PxMsgDta )
084100060216                 : '*ESCAPE'
084200060216                 : '*PGMBDY'
084300060216                 : 1
084400060216                 : MsgKey
084500060216                 : ERRC0100
084600060216                 );
084700060216
084800060216        If  ERRC0100.BytAvl > *Zero;
084900060216          Return  -1;
085000060216
085100060216        Else;
085200060216          Return   0;
085300060216        EndIf;
085400060216
085500060216      /End-Free
085600060216
085700060216     P SndEscMsg       E
