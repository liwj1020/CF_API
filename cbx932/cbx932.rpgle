000100041212     **
000200050323     **  Program . . : CBX932
000300050415     **  Description : Print save information - main CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Compile and setup instructions:
000800050318     **    CrtRpgMod   Module( CBX932 )
000900050318     **                DbgView( *LIST )
001000041212     **
001100050318     **    CrtPgm      Pgm( CBX932 )
001200050318     **                Module( CBX932 )
001300041212     **                ActGrp( *NEW )
001400041212     **
001500041212     **
001600041212     **-- Control specification:  --------------------------------------------**
001700050428     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )  BndDir( 'QC2LE' )
001800041212     **-- Printer file:
001900041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002000041212     **-- Printer file information:
002100050212     D PrtLinInf       Ds                  Qualified
002200050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
002300050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
002400050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
002500041212     **-- System information:
002600050319     D PgmSts         SDs                  Qualified
002700050319     D  PgmNam           *Proc
002800041211     **-- API error data structure:
002900041211     D ERRC0100        Ds                  Qualified
003000041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003100041211     D  BytAvl                       10i 0
003200041211     D  MsgId                         7a
003300990921     D                                1a
003400041211     D  MsgDta                      128a
003500050212     **-- Global constants:
003600050212     D ADP_PRV_INVLVL  c                   1
003700050415     D NBR_KEY         c                   2
003800050212     D KEY_OFS         c                   80
003900050212     D SIZ_NLS_INF     c                   290
004000050212     D JOB_RUN         c                   0
004100050212     D CHAR_NLS        c                   4
004200050319     D DATE_MDY        c                   13
004300050319     D DATE_DMY        c                   14
004400050212     D ASCEND          c                   1
004500050212     D DESCEND         c                   2
004600050212     **
004700050212     D SRT_PUT         c                   1
004800050212     D SRT_END         c                   2
004900050212     D SRT_GET         c                   3
005000050212     D SRT_CNL         c                   4
005100041212     **-- Global variables:
005200041212     D LstTim          s              6s 0
005300050319     D SysNam          s              8a
005400050415     D ObjLib          s             10a
005500050415     D TrlTxt          s             32a
005600041211     D Idx             s             10i 0
005700050212     D SrtAct          s               n
005800050319     D SavDat          s               d
005900050319     **
006000050415     D IncDat          Ds                  Based( pNULL )  Qualified
006100050319     D  NbrElm                        5i 0
006200050319     D  SavDat                        7a
006300050319     D  DatRel                       10a
006400050319     **
006500050319     D PrtOrd          Ds                  Based( pNULL )  Qualified
006600050319     D  NbrElm                        5i 0
006700050319     D  SrtFld                       10a
006800050319     D  SrtSeq                       10a
006900050122     **-- List record:
007000050122     D LstRcd          Ds                  Qualified
007100050415     D  ObjLib                       10a
007200050318     D  ObjNam                       10a
007300050318     D  ObjTxt                       50a
007400050319     D  SavDat                        8a
007500050319     D  RstDat                        8a
007600050318     D  SavCmd                       10a
007700050319     D  SavDev                        5a
007800050318     D  SavVol                       10a
007900050319     D  SavSeq                        6s 0
008000050319     D  SavLbl                       17a
008100050212     **-- List API parameters:
008200050212     D LstApi          Ds                  Qualified  Inz
008300050212     D  RtnRcdNbr                    10i 0
008400050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
008500050318     D  KeyFld                       10i 0 Dim( 8 )
008600050318     D  ObjNam                       10a
008700050318     D  ObjLib                       10a
008800050318     D  ObjTyp                       10a
008900040426     **-- Object information:
009000041211     D ObjInf          Ds          4096    Qualified
009100041212     D  ObjNam                       10a
009200041212     D  ObjLib                       10a
009300041212     D  ObjTyp                       10a
009400041211     D  InfSts                        1a
009500040426     D                                1a
009600041211     D  FldNbrRtn                    10i 0
009700041211     D  Data                               Like( KeyInf )
009800040426     **-- Key information:
009900041211     D KeyInf          Ds                  Qualified  Based( pKeyInf )
010000041211     D  FldInfLen                    10i 0
010100041211     D  KeyFld                       10i 0
010200041211     D  DtaTyp                        1a
010300041211     D                                3a
010400041211     D  DtaLen                       10i 0
010500041211     D  Data                        256a
010600040426     **-- List information:
010700041211     D LstInf          Ds                  Qualified
010800041211     D  RcdNbrTot                    10i 0
010900041211     D  RcdNbrRtn                    10i 0
011000041211     D  Handle                        4a
011100041211     D  RcdLen                       10i 0
011200041211     D  InfSts                        1a
011300041211     D  Dts                          13a
011400041211     D  LstSts                        1a
011500040426     D                                1a
011600041211     D  InfLen                       10i 0
011700041211     D  Rcd1                         10i 0
011800040426     D                               40a
011900040426     **-- Sort information:
012000050428     D SrtInf          Ds                  Qualified
012100041211     D  NbrKeys                      10i 0 Inz( 0 )
012200050428     D  SrtInf                       12a   Dim( 10 )
012300041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
012400041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
012500041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
012600041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
012700041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
012800040426     **-- Authority control:
012900041211     D AutCtl          Ds                  Qualified
013000041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
013100041211     D  CalLvl                       10i 0 Inz( 0 )
013200041211     D  DplObjAut                    10i 0 Inz( 0 )
013300041211     D  NbrObjAut                    10i 0 Inz( 0 )
013400041211     D  DplLibAut                    10i 0 Inz( 0 )
013500041211     D  NbrLibAut                    10i 0 Inz( 0 )
013600040426     D                               10i 0 Inz( 0 )
013700041211     D  ObjAut                       10a   Dim( 10 )
013800041211     D  LibAut                       10a   Dim( 10 )
013900040426     **-- Selection control:
014000041211     D SltCtl          Ds
014100041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
014200041211     D  SltOmt                       10i 0 Inz( 0 )
014300041211     D  DplSts                       10i 0 Inz( 20 )
014400041211     D  NbrSts                       10i 0 Inz( 1 )
014500040426     D                               10i 0 Inz( 0 )
014600041211     D  Status                        1a   Inz( '*' )
014700040426     **-- Object information key fields:
014800050318     D KeyFld          Ds                  Qualified
014900050318     D  ObjTxt                       50a
015000050318     D  SavDts                        8a
015100050318     D  RstDts                        8a
015200050318     D  SavSeq                       10i 0
015300050318     D  SavCmd                       10a
015400050318     D  SavVol                       71a
015500050318     D  SavDev                       10a
015600050318     D  SavLbl                       17a
015700050319     D  SavDat                         d
015800050122     **-- Sort API parameters:
015900050212     D SrtApi          Ds                  Qualified  Inz
016000050212     D  DtaBufLen                    10i 0
016100050212     D  DtaRtnLen                    10i 0
016200050212     D  Omit                         16a
016300050122     **
016400050122     D RqsCtlBlk       Ds                  Qualified  Inz
016500050122     D  BlkLen                       10i 0
016600050122     D  RqsTyp                       10i 0 Inz( 8 )
016700050122     D                               10i 0
016800050122     D  Options                      10i 0
016900050122     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
017000050122     D  RcdCnt                       10i 0
017100050122     D  KeyOfs                       10i 0 Inz( KEY_OFS )
017200050122     D  KeyNbr                       10i 0
017300050122     D  NlsOfs                       10i 0
017400050122     D  InpFlsOfs                    10i 0
017500050122     D  InpFlsNbr                    10i 0
017600050122     D  OutFlsOfs                    10i 0
017700050122     D  OutFlsNbr                    10i 0
017800050122     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
017900050122     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
018000050122     D  InpFenLen                    10i 0
018100050122     D  OutFenLen                    10i 0
018200050122     D  NlbMapOfs                    10i 0
018300050122     D  VlrAciOfs                    10i 0
018400050122     D                               10i 0
018500050122     **
018600050122     D SrtKeyInf                     20a   Dim( NBR_KEY )
018700050122     **
018800050122     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
018900050122     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
019000050122     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
019100050122     D SrtSeqTbl                    256a
019200050122     **
019300050122     D SrtKeyInfDs     Ds                  Qualified  Inz
019400050122     D  KeyStrPos                    10i 0
019500050122     D  KeySize                      10i 0
019600050122     D  KeyDtaTyp                    10i 0
019700050122     D  KeyOrder                     10i 0
019800050122     D  KeyOrdPos                    10i 0
019900050122     **
020000050122     D RqsCtlBlkIo     Ds                  Qualified
020100050122     D  RqsTyp                       10i 0 Inz
020200050122     D                               10i 0 Inz
020300050122     D  RcdLen                       10i 0 Inz
020400050122     D  RcdCnt                       10i 0 Inz
020500050122     **
020600050122     D DtaBufInf       Ds                  Qualified
020700050122     D  RcdPrc                       10i 0
020800050122     D  RcdAvl                       10i 0
020900050122     D                                8a
021000041211     **-- Open list of objects:
021100040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
021200040426     D  LoRcvVar                  65535a          Options( *VarSize )
021300040426     D  LoRcvVarLen                  10i 0 Const
021400040426     D  LoLstInf                     80a
021500040426     D  LoNbrRcdRtn                  10i 0 Const
021600040426     D  LoSrtInf                   1024a   Const  Options( *VarSize )
021700040426     D  LoObjNam_q                   20a   Const
021800040426     D  LoObjTyp                     10a   Const
021900040426     D  LoAutCtl                   1024a   Const  Options( *VarSize )
022000040426     D  LoSltCtl                   1024a   Const  Options( *VarSize )
022100041211     D  LoNbrKeyRtn                  10i 0 Const
022200041211     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
022300040426     D  LoError                    1024a          Options( *VarSize )
022400020531     **
022500040426     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
022600040426     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
022700040426     **
022800040426     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
022900041212     **-- Get list entry:
023000020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
023100020531     D  GlRcvVar                  65535a          Options( *VarSize )
023200020531     D  GlRcvVarLen                  10i 0 Const
023300020531     D  GlHandle                      4a   Const
023400020531     D  GlLstInf                     80a
023500020531     D  GlNbrRcdRtn                  10i 0 Const
023600020531     D  GlRtnRcdNbr                  10i 0 Const
023700020531     D  GlError                    1024a          Options( *VarSize )
023800041212     **-- Close list:
023900020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
024000020531     D  ClHandle                      4a   Const
024100020531     D  ClError                    1024a          Options( *VarSize )
024200050318     **-- Copy memory:
024300050428     D memcpy          Pr              *   ExtProc( 'memmove' )
024400050318     D  MemOut                         *   Value
024500050318     D  MemInp                         *   Value
024600050318     D  MemSiz                       10u 0 Value
024700050122     **-- Initialize sort:
024800050122     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
024900050122     D  IsRqsCtlBlk                  80a   Const  Options( *VarSize )
025000050122     D  IsInpDtaBuf               65535a   Const  Options( *VarSize )
025100050122     D  IsOutDtaBuf               65535a          Options( *VarSize )
025200050122     D  IsOutDtaLen                  10i 0 Const
025300050122     D  IsRtnDtaLen                  10i 0
025400050122     D  IsError                   32767a          Options( *VarSize )
025500050122     D  IsRtnRcdFb                  144a          Options( *VarSize: *NoPass )
025600050122     D  IsRtnRcdFbLen                10i 0 Const  Options( *NoPass )
025700050122     **-- Sort input/output:
025800050122     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
025900050122     D  IoRqsCtlBlk                  16a   Const
026000050122     D  IoInpDtaBuf               65535a   Const  Options( *VarSize )
026100050122     D  IoOutDtaBuf               65535a          Options( *VarSize )
026200050122     D  IoOutDtaLen                  10i 0 Const
026300050122     D  IoOutDtaInf                  16a
026400050122     D  IoError                   32767a          Options( *VarSize )
026500050122     D  IoRtnRcdFb                  144a          Options( *VarSize: *NoPass )
026600050122     D  IoRtnRcdFbLen                10i 0 Const  Options( *NoPass )
026700050319     **-- Send program message:
026800050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
026900050319     D  SpMsgId                       7a   Const
027000050319     D  SpMsgFq                      20a   Const
027100050319     D  SpMsgDta                    128a   Const
027200050319     D  SpMsgDtaLen                  10i 0 Const
027300050319     D  SpMsgTyp                     10a   Const
027400050319     D  SpCalStkE                    10a   Const  Options( *VarSize )
027500050319     D  SpCalStkCtr                  10i 0 Const
027600050319     D  SpMsgKey                      4a
027700050319     D  SpError                   32767a          Options( *VarSize )
027800050318     **-- Convert date & time:
027900050318     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
028000050318     D  CdInpFmt                     10a   Const
028100050318     D  CdInpVar                     17a   Const  Options( *VarSize )
028200050318     D  CdOutFmt                     10a   Const
028300050318     D  CdOutVar                     17a          Options( *VarSize )
028400050318     D  CdError                      10i 0 Const
028500050319     **-- Retrieve net attribute:
028600050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
028700050319     D  RnRcvVar                  32767a          Options( *VarSize )
028800050319     D  RnRcvVarLen                  10i 0 Const
028900050319     D  RnNbrNetAtr                  10i 0 Const
029000050319     D  RnNetAtr                     10a   Const  Dim( 256 )
029100050319     D                                            Options( *VarSize )
029200050319     D  RnError                   32767a          Options( *VarSize )
029300041212
029400050318     **-- Convert system DTS to date:
029500050318     D CvtDtsDat       Pr              d
029600050318     D  PxSysDts                      8a   Value
029700050319     **-- Get system name:
029800050319     D GetSysNam       Pr             8a   Varying
029900041216     **-- Write detail line:
030000041216     D WrtDtlLin       Pr
030100041212     **-- Write list header:
030200041212     D WrtLstHdr       Pr
030300050415     D  PxObjLib                     10a   Const  Options( *Omit )
030400050415     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
030500050415     **-- Write library header:
030600050415     D WrtLibHdr       Pr
030700050415     D  PxObjLib                     10a   Const
030800041216     **-- Write list trailer:
030900041216     D WrtLstTrl       Pr
031000050415     D  PxTrlTxt                     32a   Const
031100041212
031200050319     **-- Entry parameters:
031300050428     D CBX9322X        Pr
031400050415     D  PxLibNam                     10a   Varying
031500050415     D  PxObjLvl                     10a
031600050319     D  PxIncDat                           LikeDs( IncDat )
031700050319     D  PxPrtOrd                           LikeDs( PrtOrd )
031800041212     **
031900050428     D CBX9322X        Pi
032000050415     D  PxLibNam                     10a   Varying
032100050415     D  PxObjLvl                     10a
032200050319     D  PxIncDat                           LikeDs( IncDat )
032300050319     D  PxPrtOrd                           LikeDs( PrtOrd )
032400041211
032500041211      /Free
032600041211
032700050415        ExSr  InzApiPrm;
032800050415
032900050415        ExSr  PrtSavCmd;
033000050415
033100050415        ExSr  PrtLibInf;
033200041216
033300041211        *InLr = *On;
033400041211        Return;
033500041211
033600050415
033700050415        BegSr  InzApiPrm;
033800050415
033900050415          LstApi.KeyFld(1) = 203;
034000050415          LstApi.KeyFld(2) = 501;
034100050415          LstApi.KeyFld(3) = 502;
034200050415          LstApi.KeyFld(4) = 505;
034300050415          LstApi.KeyFld(5) = 506;
034400050415          LstApi.KeyFld(6) = 507;
034500050415          LstApi.KeyFld(7) = 508;
034600050415          LstApi.KeyFld(8) = 511;
034700050415
034800050415          SrtInf.NbrKeys      = 0;
034900050415          SrtInf.KeyFldOfs(1) = 0;
035000050415          SrtInf.KeyFldLen(1) = 0;
035100050415          SrtInf.KeyFldTyp(1) = 0;
035200050415          SrtInf.SrtOrd(1)    = '1';
035300050415          SrtInf.Rsv(1)       = x'00';
035400050415
035500050415        EndSr;
035600050415
035700050415        BegSr  PrtLibInf;
035800050415
035900050415          Select;
036000050415          When  PxObjLvl = '*LIB';
036100050415            LstApi.ObjNam = PxLibNam;
036200050415            LstApi.ObjLib = '*LIBL';
036300050415            LstApi.ObjTyp = '*LIB';
036400050415
036500050415          When  PxObjLvl = '*OBJ';
036600050415            LstApi.ObjNam = '*ALL';
036700050415            LstApi.ObjLib = PxLibNam;
036800050415            LstApi.ObjTyp = '*ALL';
036900050415          EndSl;
037000050415
037100050415          LstApi.RtnRcdNbr = 1;
037200050415
037300050415          LstObjs( ObjInf
037400050415                 : %Size( ObjInf )
037500050415                 : LstInf
037600050415                 : 1
037700050415                 : SrtInf
037800050415                 : LstApi.ObjNam + LstApi.ObjLib
037900050415                 : LstApi.ObjTyp
038000050415                 : AutCtl
038100050415                 : SltCtl
038200050415                 : LstApi.NbrKeyRtn
038300050415                 : LstApi.KeyFld
038400050415                 : ERRC0100
038500050415                 );
038600050415
038700050415          If  ERRC0100.BytAvl = *Zero;
038800050415
038900050426            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
039000050415
039100050415              ExSr  GetKeyDta;
039200050415              ExSr  ChkKeyDta;
039300050415
039400050415              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
039500050415
039600050415              GetLstEnt( ObjInf
039700050415                       : %Size( ObjInf )
039800050415                       : LstInf.Handle
039900050415                       : LstInf
040000050415                       : 1
040100050415                       : LstApi.RtnRcdNbr
040200050415                       : ERRC0100
040300050415                       );
040400050415
040500050415              If  ERRC0100.BytAvl > *Zero;
040600050415                Leave;
040700050415              EndIf;
040800050426
040900050426              If  LstInf.LstSts = '5'  And  LstInf.RcdNbrTot = LstApi.RtnRcdNbr;
041000050426                Leave;
041100050426              EndIf;
041200050415            EndDo;
041300050415
041400050415            CloseLst( LstInf.Handle: ERRC0100 );
041500050415          EndIf;
041600050415
041700050415          ObjLib = *Blanks;
041800050415
041900050415          ExSr  WrtSrtLst;
042000050426
042100050426          If  LstInf.LstSts = '5';
042200050426            WrtLstTrl( '***  P A R T I A L  L I S T  ***' );
042300050426          EndIf;
042400050426
042500050415          WrtLstTrl( '***  E N D  O F  L I S T  2  ***' );
042600050415
042700050415        EndSr;
042800050415
042900050415        BegSr  PrtSavCmd;
043000050415
043100050415          LstApi.ObjNam = 'QSAV*';
043200050415          LstApi.ObjLib = 'QSYS';
043300050415          LstApi.ObjTyp = '*DTAARA';
043400050415
043500050415          LstApi.RtnRcdNbr = 1;
043600050415
043700050415          LstObjs( ObjInf
043800050415                 : %Size( ObjInf )
043900050415                 : LstInf
044000050415                 : 1
044100050415                 : SrtInf
044200050415                 : LstApi.ObjNam + LstApi.ObjLib
044300050415                 : LstApi.ObjTyp
044400050415                 : AutCtl
044500050415                 : SltCtl
044600050415                 : LstApi.NbrKeyRtn
044700050415                 : LstApi.KeyFld
044800050415                 : ERRC0100
044900050415                 );
045000050415
045100050415          If  ERRC0100.BytAvl = *Zero;
045200050415
045300050415            DoW  LstInf.LstSts <> '2'  Or
045400050415                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
045500050415
045600050415              ExSr  GetKeyDta;
045700050415              ExSr  ChkKeyDta;
045800050415
045900050415              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
046000050415
046100050415              GetLstEnt( ObjInf
046200050415                       : %Size( ObjInf )
046300050415                       : LstInf.Handle
046400050415                       : LstInf
046500050415                       : 1
046600050415                       : LstApi.RtnRcdNbr
046700050415                       : ERRC0100
046800050415                       );
046900050415
047000050415              If  ERRC0100.BytAvl > *Zero;
047100050415                Leave;
047200050415              EndIf;
047300050415            EndDo;
047400050415
047500050415            CloseLst( LstInf.Handle: ERRC0100 );
047600050415          EndIf;
047700050415
047800050415          ObjLib = '*NONE';
047900050415
048000050415          ExSr  WrtSrtLst;
048100050415
048200050415          WrtLstTrl( '***  E N D  O F  L I S T  1  ***' );
048300050415
048400050415        EndSr;
048500050415
048600041211        BegSr  GetKeyDta;
048700041211
048800041211          pKeyInf = %Addr( ObjInf.Data );
048900041211
049000041211          For  Idx = 1  To ObjInf.FldNbrRtn;
049100041211
049200041211            Select;
049300050318            When  KeyInf.KeyFld = 203;
049400050318              KeyFld.ObjTxt = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
049500041211
049600050318            When  KeyInf.KeyFld = 501;
049700050319              KeyFld.SavDts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
049800050319              KeyFld.SavDat = CvtDtsDat( KeyFld.SavDts );
049900050306
050000050318            When  KeyInf.KeyFld = 502;
050100050318              KeyFld.RstDts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
050200050318
050300050318            When  KeyInf.KeyFld = 505;
050400050318              MemCpy( %Addr( KeyFld.SavSeq )
050500050318                    : %Addr( KeyInf.Data )
050600050318                    : %Size( KeyFld.SavSeq )
050700050318                    );
050800050318
050900050318            When  KeyInf.KeyFld = 506;
051000050318              KeyFld.SavCmd = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
051100050318
051200050318            When  KeyInf.KeyFld = 507;
051300050318              KeyFld.SavVol = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
051400050318
051500050318            When  KeyInf.KeyFld = 508;
051600050318              KeyFld.SavDev = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
051700050318
051800050318            When  KeyInf.KeyFld = 511;
051900050318              KeyFld.SavLbl = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
052000041211            EndSl;
052100041211
052200041211            If  Idx < ObjInf.FldNbrRtn;
052300041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
052400041211            EndIf;
052500041211          EndFor;
052600041211
052700041211        EndSr;
052800041211
052900050319        BegSr  ChkKeyDta;
053000050319
053100050319          Select;
053200050319          When  PxIncDat.NbrElm = 1;
053300050319            ExSr  AddSrtLst;
053400050319
053500050319          When  PxIncDat.DatRel = '*BEFORE'  And
053600050319                KeyFld.SavDat < SavDat;
053700050319            ExSr  AddSrtLst;
053800050319
053900050319          When  PxIncDat.DatRel = '*AFTER'  And
054000050319                KeyFld.SavDat >= SavDat;
054100050319            ExSr  AddSrtLst;
054200050319          EndSl;
054300050319
054400050319        EndSr;
054500050319
054600050122        BegSr  InzSrtLst;
054700050122
054800050415          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
054900050415          SrtKeyInfDs.KeyStrPos = 1;
055000050415          SrtKeyInfDs.KeySize   = %Size( LstRcd.ObjLib );
055100050426          SrtKeyInfDs.KeyOrder  = ASCEND;
055200050415
055300050415          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
055400050415
055500050415          If  PxPrtOrd.SrtFld = '*LIBOBJ';
055600050415            SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
055700050415            SrtKeyInfDs.KeyStrPos = 11;
055800050415            SrtKeyInfDs.KeySize   = %Size( LstRcd.ObjNam );
055900050415
056000050417          ElseIf  PxPrtOrd.SrtFld = '*LIBSAV';
056100050415            SrtKeyInfDs.KeyDtaTyp = DATE_DMY;
056200050415            SrtKeyInfDs.KeyStrPos = 71;
056300050415            SrtKeyInfDs.KeySize   = %Size( LstRcd.SavDat );
056400050415          EndIf;
056500050415
056600050415          If  PxPrtOrd.SrtSeq = '*ASCEND';
056700050415            SrtKeyInfDs.KeyOrder  = ASCEND;
056800050415
056900050415          ElseIf  PxPrtOrd.SrtSeq = '*DESCEND';
057000050415            SrtKeyInfDs.KeyOrder  = DESCEND;
057100050415          EndIf;
057200050318
057300050415          RqsCtlBlk.SrtKeyInf(2) = SrtKeyInfDs;
057400050122
057500050122          RqsCtlBlk.NlsOfs = KEY_OFS +
057600050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
057700050122
057800050122          RqsCtlBlk.BlkLen = KEY_OFS +
057900050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
058000050122                             SIZ_NLS_INF;
058100050122
058200050122          RqsCtlBlk.KeyNbr = NBR_KEY;
058300050122
058400050122          InzSort( RqsCtlBlk
058500050212                 : SrtApi.Omit
058600050212                 : SrtApi.Omit
058700050212                 : SrtApi.DtaBufLen
058800050212                 : SrtApi.DtaRtnLen
058900050122                 : ERRC0100
059000050122                 );
059100050122
059200050122          If  ERRC0100.BytAvl = *Zero;
059300050212            SrtAct = *On;
059400050122          EndIf;
059500050122
059600050122        EndSr;
059700050122
059800050122        BegSr  AddSrtLst;
059900050122
060000050212          If  SrtAct = *Off;
060100050122            ExSr  InzSrtLst;
060200050122          EndIf;
060300050122
060400050122          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
060500050122          RqsCtlBlkIo.RcdCnt = 1;
060600050122          RqsCtlBlkIo.RqsTyp = SRT_PUT;
060700050122
060800050415          LstRcd.ObjLib = ObjInf.ObjLib;
060900050122          LstRcd.ObjNam = ObjInf.ObjNam;
061000050318          LstRcd.ObjTxt = KeyFld.ObjTxt;
061100050318          LstRcd.SavCmd = KeyFld.SavCmd;
061200050318          LstRcd.SavDev = KeyFld.SavDev;
061300050318          LstRcd.SavVol = KeyFld.SavVol;
061400050318          LstRcd.SavSeq = KeyFld.SavSeq;
061500050318          LstRcd.SavLbl = KeyFld.SavLbl;
061600050319
061700050319          If  KeyFld.SavDts = *Allx'00';
061800050319            LstRcd.SavDat = *Blanks;
061900050319          Else;
062000050319            LstRcd.SavDat = %Char( CvtDtsDat( KeyFld.SavDts ): *DMY/);
062100050319          EndIf;
062200050319
062300050319          If  KeyFld.RstDts = *Allx'00';
062400050319            LstRcd.RstDat = *Blanks;
062500050319          Else;
062600050319            LstRcd.RstDat = %Char( CvtDtsDat( KeyFld.RstDts ): *DMY/);
062700050319          EndIf;
062800050122
062900050122          SortIo( RqsCtlBlkIo
063000050122                : LstRcd
063100050212                : SrtApi.Omit
063200050212                : SrtApi.DtaBufLen
063300050122                : DtaBufInf
063400050122                : ERRC0100
063500050122                );
063600050122
063700050122        EndSr;
063800050122
063900050122        BegSr  WrtSrtLst;
064000050415
064100050415          If  PxObjLvl = '*LIB'  Or  ObjLib = '*NONE';
064200050415            WrtLstHdr( *Omit: *Omit );
064300050415          EndIf;
064400050122
064500050122          ExSr  EndSrtLst;
064600050122
064700050319          If  DtaBufInf.RcdAvl > *Zero;
064800050319
064900050319            RqsCtlBlkIo.RqsTyp = SRT_GET;
065000050319
065100050319            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
065200050319
065300050319            SortIo( RqsCtlBlkIo
065400050319                  : SrtApi.Omit
065500050319                  : LstRcd
065600050319                  : SrtApi.DtaBufLen
065700050319                  : DtaBufInf
065800050319                  : ERRC0100
065900050319                  );
066000050319
066100050426            DoW  DtaBufInf.RcdAvl > *Zero  And  ERRC0100.BytAvl = *Zero;
066200050415
066300050415              If  PxObjLvl = '*OBJ'  And  ObjLib <> '*NONE';
066400050415
066500050415                If  LstRcd.ObjLib <> ObjLib;
066600050415
066700050415                  WrtLstHdr( LstRcd.ObjLib: *Omit );
066800050415                  ObjLib = LstRcd.ObjLib;
066900050415                EndIf;
067000050415              EndIf;
067100050319
067200050319              WrtDtlLin();
067300050319
067400050319              SortIo( RqsCtlBlkIo
067500050319                    : SrtApi.Omit
067600050319                    : LstRcd
067700050319                    : SrtApi.DtaBufLen
067800050319                    : DtaBufInf
067900050319                    : ERRC0100
068000050319                    );
068100050319            EndDo;
068200050319          EndIf;
068300050122
068400050122        EndSr;
068500050122
068600050122        BegSr  EndSrtLst;
068700050122
068800050122          RqsCtlBlkIo.RqsTyp = SRT_END;
068900050122
069000050122          SortIo( RqsCtlBlkIo
069100050212                : SrtApi.Omit
069200050212                : SrtApi.Omit
069300050212                : SrtApi.DtaBufLen
069400050122                : DtaBufInf
069500050122                : ERRC0100
069600050122                );
069700050415
069800050415          If  ERRC0100.BytAvl = *Zero;
069900050415            SrtAct = *Off;
070000050415          EndIf;
070100050122
070200050122        EndSr;
070300050122
070400041212        BegSr  *InzSr;
070500050415
070600050319          If  PxIncDat.NbrElm = 2;
070700050319
070800050319            If  PxIncDat.SavDat = '0010000';
070900050319              SavDat = %Date();
071000050319            Else;
071100050319              SavDat = %Date( PxIncDat.SavDat: *CYMD0 );
071200050319            EndIf;
071300050319          EndIf;
071400041212
071500041212          LstTim = %Int( %Char( %Time(): *ISO0));
071600050319          SysNam = GetSysNam();
071700041212
071800041212        EndSr;
071900041212
072000050122      /End-Free
072100050122
072200041212     **-- Printer file definition:  ------------------------------------------**
072300041212     OQSYSPRT   EF           Header         2  2
072400041212     O                       UDATE         Y      8
072500041212     O                       LstTim              18 '  :  :  '
072600050319     O                                           36 'System:'
072700050319     O                       SysNam              45
072800050319     O                                           80 'Save information'
072900041212     O                                          107 'Program:'
073000050319     O                       PgmSts.PgmNam      118
073100041212     O                                          126 'Page:'
073200041212     O                       PAGE             +   1
073300041216     **
073400050415     OQSYSPRT   EF           LibHdr         2
073500050415     O                                           26 'Object library . . . . . -
073600050415     O                                              :'
073700050415     O                       ObjLib              38
073800050415     **
073900041212     OQSYSPRT   EF           LstHdr         1
074000041212     O                                            6 'Object'
074100050319     O                                           22 'Description'
074200050319     O                                           66 'Saved'
074300050319     O                                           79 'Restored'
074400050319     O                                           90 'Save cmd.'
074500050319     O                                           96 'Dev.'
074600050319     O                                          107 'Volume ID'
074700050319     O                                          114 'Seq.'
074800050319     O                                          120 'Label'
074900041216     **
075000041212     OQSYSPRT   EF           DtlLin         1
075100050122     O                       LstRcd.ObjNam       10
075200050319     O                       LstRcd.ObjTxt       61
075300050319     O                       LstRcd.SavDat       69
075400050319     O                       LstRcd.RstDat       79
075500050319     O                       LstRcd.SavCmd       91
075600050319     O                       LstRcd.SavDev       97
075700050319     O                       LstRcd.SavVol      108
075800050319     O                       LstRcd.SavSeq Z    114
075900050319     O                       LstRcd.SavLbl      132
076000041212     **
076100050123     OQSYSPRT   EF           LstTrl         1
076200050415     O                       TrlTxt              34
076300041216     **-- Write detail line:  ------------------------------------------------**
076400041216     P WrtDtlLin       B
076500041212     D                 Pi
076600041212
076700041212      /Free
076800041212
076900050415        WrtLstHdr( *Omit: 3 );
077000041212
077100041216        Except  DtlLin;
077200041212
077300041212      /End-Free
077400041212
077500041216     P WrtDtlLin       E
077600041212     **-- Write list header:  ------------------------------------------------**
077700041212     P WrtLstHdr       B
077800041212     D                 Pi
077900050415     D  PxObjLib                     10a   Const  Options( *Omit )
078000050415     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
078100041212
078200041212      /Free
078300041212
078400050415        If  %Addr( PxOvrFlwRel) = *Null;
078500041212
078600041212          Except  Header;
078700050415
078800050415          If  %Addr( PxObjLib ) <> *Null;
078900050415            WrtLibHdr( PxObjLib );
079000050415          EndIf;
079100050415
079200041212          Except  LstHdr;
079300041212        Else;
079400041212
079500050212          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
079600041212
079700041212            Except  Header;
079800050415
079900050415            If  %Addr( PxObjLib ) <> *Null;
080000050415              WrtLibHdr( PxObjLib );
080100050415            EndIf;
080200050415
080300041212            Except  LstHdr;
080400041212          EndIf;
080500041212        EndIf;
080600041212
080700041212      /End-Free
080800041212
080900041212     P WrtLstHdr       E
081000050415     **-- Write library header:  ---------------------------------------------**
081100050415     P WrtLibHdr       B
081200050415     D                 Pi
081300050415     D  PxObjLib                     10a   Const
081400050415
081500050415      /Free
081600050415
081700050415        ObjLib = PxObjLib;
081800050415
081900050415        Except  LibHdr;
082000050415
082100050415      /End-Free
082200050415
082300050415     P WrtLibHdr       E
082400041216     **-- Write list trailer:  -----------------------------------------------**
082500041216     P WrtLstTrl       B
082600041216     D                 Pi
082700050415     D  PxTrlTxt                     32a   Const
082800041216
082900041216      /Free
083000041216
083100050415        TrlTxt = PxTrlTxt;
083200050415
083300041216        Except  LstTrl;
083400041216
083500041216      /End-Free
083600041216
083700041216     P WrtLstTrl       E
083800050318     **-- Convert system DTS to date:  ---------------------------------------**
083900050318     P CvtDtsDat       B
084000050318     D                 Pi              d
084100050318     D  PxSysDts                      8a   Value
084200050318
084300050318     D MI_DTS          s             20a
084400050318
084500050318      /Free
084600050318
084700050318        CvtDtf( '*DTS': PxSysDts: '*YYMD': MI_DTS: *Zero );
084800050318
084900050318        Return  %Date( %Timestamp( MI_DTS: *ISO0 ));
085000050318
085100050318      /End-Free
085200050318
085300050318     P CvtDtsDat       E
085400050319     **-- Get system name:  --------------------------------------------------**
085500050319     P GetSysNam       B
085600050319     D                 Pi             8a   Varying
085700050319     **
085800050319     **-- Local variables:
085900050319     D Idx             s             10i 0
086000050319     D SysNam          s              8a   Varying
086100050319     **
086200050319     D RtnAtrLen       s             10i 0
086300050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
086400050319     D NetAtr          s             10a   Dim( 1 )
086500050319     **
086600050319     D RtnVar          Ds                  Qualified
086700050319     D  RtnVarNbr                    10i 0
086800050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
086900050319     D  RtnVarDta                  1024a
087000050319
087100050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
087200050319     D  AtrNam                       10a
087300050319     D  DtaTyp                        1a
087400050319     D  InfSts                        1a
087500050319     D  AtrLen                       10i 0
087600050319     D  Atr                        1008a
087700050319
087800050319      /Free
087900050319
088000050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
088100050319
088200050319        NetAtr(1) = 'SYSNAME';
088300050319
088400050319        RtvNetAtr( RtnVar
088500050319                 : RtnAtrLen
088600050319                 : NetAtrNbr
088700050319                 : NetAtr
088800050319                 : ERRC0100
088900050319                 );
089000050319
089100050319        If  ERRC0100.BytAvl > *Zero;
089200050319          SysNam = '';
089300050319
089400050319        Else;
089500050319          For  Idx = 1  to RtnVar.RtnVarNbr;
089600050319
089700050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
089800050319
089900050319            If  RtnAtr.AtrNam = 'SYSNAME';
090000050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
090100050319            EndIf;
090200050319
090300050319          EndFor;
090400050319        EndIf;
090500050319
090600050319        Return  SysNam;
090700050319
090800050319      /End-Free
090900050319
091000050319     P GetSysNam       E
