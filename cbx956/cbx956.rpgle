000100041212     **
000200060217     **  Program . . : CBX956
000300060217     **  Description : Print user's authorization lists
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **
000800050304     **  Compile instructions:
000900060217     **    CrtRpgMod   Module( CBX956 )
001000050304     **                DbgView( *LIST )
001100041212     **
001200060217     **    CrtPgm      Pgm( CBX956 )
001300060217     **                Module( CBX956 )
001400041212     **                ActGrp( *NEW )
001500041212     **
001600041212     **
001700041212     **-- Control specification:  --------------------------------------------**
001800060217     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
001900050801
002000060217     **-- Printer file:
002100060217     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002200060217
002300060217     **-- Printer file information:
002400060217     D PrtLinInf       Ds                  Qualified
002500060217     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
002600060217     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
002700060217     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
002800050303     **-- System information:
002900050303     D PgmSts         sDs                  Qualified
003000060217     D  PgmNam           *Proc
003100050303     D  JobUsr                       10a   Overlay( PgmSts: 254 )
003200050303     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003300060217
003400041211     **-- API error data structure:
003500041211     D ERRC0100        Ds                  Qualified
003600041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003700041211     D  BytAvl                       10i 0
003800041211     D  MsgId                         7a
003900990921     D                                1a
004000041211     D  MsgDta                      128a
004100060217
004200050212     **-- Global constants:
004300050801     D USR_SPC_Q       c                   'AUTOBJLST QTEMP'
004400050306     D OFS_MSGDTA      c                   16
004500060218     D MAX_GRPPRF      c                   16
004600060226     **
004700060226     D NBR_KEY         c                   1
004800060226     D KEY_OFS         c                   80
004900060226     D SIZ_NLS_INF     c                   290
005000060226     D JOB_RUN         c                   0
005100060226     D CHAR_NLS        c                   4
005200060226     D ASCEND          c                   1
005300060226     D DESCEND         c                   2
005400060226     **
005500060226     D SRT_PUT         c                   1
005600060226     D SRT_END         c                   2
005700060226     D SRT_GET         c                   3
005800060226     D SRT_CNL         c                   4
005900041212     **-- Global variables:
006000041211     D Idx             s             10i 0
006100060218     D GrpIdx          s             10i 0
006200060217     D LstTim          s              6s 0
006300060217     D SysNam          s              8a
006400060217     D TrlTxt          s             32a
006500060226     D SrtAct          s               n
006600060218     D UsrPrf          s             10a
006700060218     D GrpPrf          s             10a
006800060218     D GrpPrfLst       s             10a   Dim( MAX_GRPPRF )
006900060225     **-- API parameters:
007000060225     D LstPrf          s             10a
007100060225     D CntHdl          s             20a   Inz
007200060225     **
007300060225     D RqsLst          Ds                  Qualified
007400060225     D  NbrRqs                       10i 0
007500060225     D  RqsEnt                       10a   Dim( 3 )
007600060217     **-- List record:
007700060217     D LstRcd          Ds                  Qualified
007800060217     D  AutLst                       10a
007900060225     D  ObjOwn                        4a
008000060217     D  AutVal                       10a
008100060217     D  AutFlg
008200060217     D  AutlMgt                       1a   Overlay( AutFlg: 1 )
008300060217     D  ObjOpr                        1a   Overlay( AutFlg: *Next )
008400060217     D  ObjMgt                        1a   Overlay( AutFlg: *Next )
008500060217     D  ObjExs                        1a   Overlay( AutFlg: *Next )
008600060217     D  ObjAlt                        1a   Overlay( AutFlg: *Next )
008700060217     D  ObjRef                        1a   Overlay( AutFlg: *Next )
008800060217     D  DtaRead                       1a   Overlay( AutFlg: *Next )
008900060217     D  DtaAdd                        1a   Overlay( AutFlg: *Next )
009000060217     D  DtaUpd                        1a   Overlay( AutFlg: *Next )
009100060217     D  DtaDlt                        1a   Overlay( AutFlg: *Next )
009200060217     D  DtaExe                        1a   Overlay( AutFlg: *Next )
009300050801     **-- Entry format OBJA0200:
009400050801     D OBJA0200        Ds                  Qualified  Based( pLstEnt )
009500050801     D  ObjNam                       10a
009600050801     D  ObjLib                       10a
009700050801     D  ObjTyp                       10a
009800050801     D  AutHlr                        1a
009900050801     D  ObjOwn                        1a
010000050801     D  AutVal                       10a
010100050801     D  AutlMgt                       1a
010200050801     D  ObjOpr                        1a
010300050801     D  ObjMgt                        1a
010400050303     D  ObjExs                        1a
010500050303     D  DtaRead                       1a
010600050303     D  DtaAdd                        1a
010700050303     D  DtaUpd                        1a
010800050303     D  DtaDlt                        1a
010900050303     D  DtaExe                        1a
011000050303     D                               10a
011100050303     D  ObjAlt                        1a
011200050303     D  ObjRef                        1a
011300050801     D  AspDevLib                    10a
011400050801     D  AspDevObj                    10a
011500050801     **-- API input parameter information:
011600050801     D InpPrm          Ds                  Qualified  Based( pInpPrm )
011700050801     D  UsrSpc                       10a
011800050801     D  UsrSpcLib                    10a
011900050801     D  FmtNam                        8a
012000050801     D  UsrPrf                       10a
012100050801     D  ObjTyp                       10a
012200050801     D  RtnObj                       10a
012300050801     D  CntHdl                       20a
012400050801     D  OfsRqsLst                    10i 0
012500050801     D  NbrLstEnt                    10i 0
012600050801     D  RqsLst                       30a
012700050801     **-- API header information:
012800050801     D HdrInf          Ds                  Qualified  Based( pHdrInf )
012900050801     D  UsrPrf                       10a
013000050801     D  CntHdl                       20a
013100050801     D  RsnCod                       10i 0
013200050303     **-- User space generic header:
013300050303     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
013400050801     D  OfsInp                       10i 0 Overlay( UsrSpc: 109 )
013500050303     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
013600050303     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
013700050303     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
013800050303     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
013900050303     **-- Space pointers:
014000050303     D pUsrSpc         s               *   Inz( *Null )
014100050801     D pInpPrm         s               *   Inz( *Null )
014200050801     D pHdrInf         s               *   Inz( *Null )
014300050303     D pLstEnt         s               *   Inz( *Null )
014400060226
014500060226     **-- Sort API parameters:
014600060226     D SrtApi          Ds                  Qualified  Inz
014700060226     D  DtaBufLen                    10i 0
014800060226     D  DtaRtnLen                    10i 0
014900060226     D  Omit                         16a
015000060226     **
015100060226     D RqsCtlBlk       Ds                  Qualified  Inz
015200060226     D  BlkLen                       10i 0
015300060226     D  RqsTyp                       10i 0 Inz( 8 )
015400060226     D                               10i 0
015500060226     D  Options                      10i 0
015600060226     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
015700060226     D  RcdCnt                       10i 0
015800060226     D  KeyOfs                       10i 0 Inz( KEY_OFS )
015900060226     D  KeyNbr                       10i 0
016000060226     D  NlsOfs                       10i 0
016100060226     D  InpFlsOfs                    10i 0
016200060226     D  InpFlsNbr                    10i 0
016300060226     D  OutFlsOfs                    10i 0
016400060226     D  OutFlsNbr                    10i 0
016500060226     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
016600060226     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
016700060226     D  InpFenLen                    10i 0
016800060226     D  OutFenLen                    10i 0
016900060226     D  NlbMapOfs                    10i 0
017000060226     D  VlrAciOfs                    10i 0
017100060226     D                               10i 0
017200060226     **
017300060226     D SrtKeyInf                     20a   Dim( NBR_KEY )
017400060226     **
017500060226     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
017600060226     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
017700060226     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
017800060226     D SrtSeqTbl                    256a
017900060226     **
018000060226     D SrtKeyInfDs     Ds                  Qualified  Inz
018100060226     D  KeyStrPos                    10i 0
018200060226     D  KeySize                      10i 0
018300060226     D  KeyDtaTyp                    10i 0
018400060226     D  KeyOrder                     10i 0
018500060226     D  KeyOrdPos                    10i 0
018600060226     **
018700060226     D RqsCtlBlkIo     Ds                  Qualified
018800060226     D  RqsTyp                       10i 0 Inz
018900060226     D                               10i 0 Inz
019000060226     D  RcdLen                       10i 0 Inz
019100060226     D  RcdCnt                       10i 0 Inz
019200060226     **
019300060226     D DtaBufInf       Ds                  Qualified
019400060226     D  RcdPrc                       10i 0
019500060226     D  RcdAvl                       10i 0 Inz( *Zero )
019600060226     D                                8a
019700050801
019800060218     **-- Retrieve user information:
019900060218     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
020000060218     D  RcvVar                    32767a          Options( *VarSize )
020100060218     D  RcvVarLen                    10i 0 Const
020200060218     D  FmtNam                       10a   Const
020300060218     D  UsrPrf                       10a   Const
020400060218     D  Error                     32767a          Options( *VarSize )
020500050303     **-- List authorized users:
020600050801     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
020700060217     D  SpcNamQ                      20a   Const
020800060217     D  FmtNam                        8a   Const
020900060217     D  UsrPrf                       10a   Const
021000060217     D  ObjTyp                       10a   Const
021100060217     D  RtnObj                       10a   Const
021200060217     D  CntHdl                       20a   Const
021300060217     D  Error                     32767a          Options( *VarSize )
021400060217     D  RqsLst                       30a          Options( *VarSize: *NoPass )
021500050303     **-- Create user space:
021600050303     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
021700060217     D  SpcNamQ                      20a   Const
021800060217     D  ExtAtr                       10a   Const
021900060217     D  InzSiz                       10i 0 Const
022000060217     D  InzVal                        1a   Const
022100060217     D  PubAut                       10a   Const
022200060217     D  Text                         50a   Const
022300060217     D  Replace                      10a   Const  Options( *NoPass )
022400060217     D  Error                     32767a          Options( *NoPass: *VarSize )
022500060217     D  Domain                       10a   Const  Options( *NoPass )
022600060217     D  TfrSizRqs                    10i 0 Const  Options( *NoPass )
022700060217     D  OptSpcAlg                     1a   Const  Options( *NoPass )
022800050303     **-- Retrieve pointer to user space:
022900050303     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
023000060217     D  SpcNamQ                      20a   Const
023100060217     D  Pointer                        *
023200060217     D  Error                     32767a          Options( *NoPass: *VarSize )
023300050303     **-- Delete user space:
023400050303     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
023500060217     D  SpcNamQ                      20a   Const
023600060217     D  Error                     32767a          Options( *VarSize )
023700060226     **-- Initialize sort:
023800060226     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
023900060226     D  RqsCtlBlk                    80a   Const  Options( *VarSize )
024000060226     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
024100060226     D  OutDtaBuf                 65535a          Options( *VarSize )
024200060226     D  OutDtaLen                    10i 0 Const
024300060226     D  RtnDtaLen                    10i 0
024400060226     D  Error                     32767a          Options( *VarSize )
024500060226     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
024600060226     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
024700060226     **-- Sort input/output:
024800060226     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
024900060226     D  RqsCtlBlk                    16a   Const
025000060226     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
025100060226     D  OutDtaBuf                 65535a          Options( *VarSize )
025200060226     D  OutDtaLen                    10i 0 Const
025300060226     D  OutDtaInf                    16a
025400060226     D  Error                     32767a          Options( *VarSize )
025500060226     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
025600060226     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
025700050306     **-- Send program message:
025800050306     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
025900060217     D  MsgId                         7a   Const
026000060217     D  MsgFq                        20a   Const
026100060217     D  MsgDta                      128a   Const
026200060217     D  MsgDtaLen                    10i 0 Const
026300060217     D  MsgTyp                       10a   Const
026400060217     D  CalStkE                      10a   Const  Options( *VarSize )
026500060217     D  CalStkCtr                    10i 0 Const
026600060217     D  MsgKey                        4a
026700060217     D  Error                      1024a          Options( *VarSize )
026800060217     **-- Retrieve net attribute:
026900060217     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
027000060217     D  RcvVar                    32767a          Options( *VarSize )
027100060217     D  RcvVarLen                    10i 0 Const
027200060217     D  NbrNetAtr                    10i 0 Const
027300060217     D  NetAtr                       10a   Const  Dim( 256 )
027400060217     D                                            Options( *VarSize )
027500060217     D  Error                     32767a          Options( *VarSize )
027600060217
027700060218     **-- Get group profiles:
027800060218     D GetGrpPrf       Pr            10a   Dim( MAX_GRPPRF )
027900060218     D  PxUsrPrf                     10a   Const
028000060217     **-- Get system name:
028100060217     D GetSysNam       Pr             8a   Varying
028200060217     **-- Write detail line:
028300060217     D WrtDtlLin       Pr
028400060217     **-- Write list header:
028500060217     D WrtLstHdr       Pr
028600060217     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
028700060217     **-- Write list trailer:
028800060217     D WrtLstTrl       Pr
028900060217     D  PxTrlTxt                     32a   Const
029000050306     **-- Send escape message:
029100050306     D SndEscMsg       Pr            10i 0
029200050306     D  PxMsgId                       7a   Const
029300050306     D  PxMsgF                       10a   Const
029400050306     D  PxMsgDta                    512a   Const  Varying
029500050306     **-- Send completion message:
029600050306     D SndCmpMsg       Pr            10i 0
029700050306     D  PxMsgDta                    512a   Const  Varying
029800050303
029900060217     D CBX956          Pr
030000050407     D  PxUsrPrf                     10a
030100060218     D  PxIncGrp                      1a
030200041212     **
030300060217     D CBX956          Pi
030400050407     D  PxUsrPrf                     10a
030500060218     D  PxIncGrp                      1a
030600041211
030700041211      /Free
030800060218
030900050801        CrtUsrSpc( USR_SPC_Q
031000050801                 : *Blanks
031100050801                 : 65535
031200050801                 : x'00'
031300050801                 : '*CHANGE'
031400050801                 : *Blanks
031500050801                 : '*YES'
031600050801                 : ERRC0100
031700050801                 );
031800050801
031900050801        RtvPtrSpc( USR_SPC_Q: pUsrSpc );
032000050801
032100060225        RqsLst.NbrRqs = 3;
032200060225        RqsLst.RqsEnt(1) = '*OBJAUT';
032300060225        RqsLst.RqsEnt(2) = '*OBJOWN';
032400060225        RqsLst.RqsEnt(3) = '*OBJPGP';
032500060225
032600060218        UsrPrf = PxUsrPrf;
032700060218        LstPrf = UsrPrf;
032800060218        GrpPrf = '*NONE';
032900060218
033000060218        ExSr  GetObjLst;
033100060218
033200060218        If  PxIncGrp = 'Y';
033300060218          GrpPrfLst = GetGrpPrf( PxUsrPrf );
033400060218
033500060218          For  GrpIdx = 1  to  %Elem( GrpPrfLst );
033600060218
033700060218            If  GrpPrfLst(GrpIdx) = *Blanks;
033800060218              Leave;
033900060218            EndIf;
034000060218
034100060218            GrpPrf = GrpPrfLst(GrpIdx);
034200060218            LstPrf = GrpPrf;
034300060218
034400060218            ExSr  GetObjLst;
034500060218
034600060218          EndFor;
034700060218        EndIf;
034800060218
034900060218        WrtLstTrl( '***  E N D  O F  L I S T  ***' );
035000060218
035100060218        SndCmpMsg( 'Authorization lists printed for user profile ' +
035200060218                   %TrimR( PxUsrPrf )                             +
035300060218                   '.'
035400060218                 );
035500060218
035600060218        DltUsrSpc( USR_SPC_Q: ERRC0100 );
035700050306
035800041211        *InLr = *On;
035900041211        Return;
036000041211
036100060218        BegSr  GetObjLst;
036200060218
036300060218          WrtLstHdr( *Omit );
036400060218
036500060218          DoU  CntHdl = *Blanks;
036600060218
036700060218            LstUsrObj( USR_SPC_Q
036800060218                     : 'OBJA0200'
036900060218                     : LstPrf
037000060218                     : '*AUTL'
037100060225                     : '*REQLIST'
037200060218                     : CntHdl
037300060218                     : ERRC0100
037400060225                     : RqsLst
037500060218                     );
037600060218
037700060218            If  ERRC0100.BytAvl > *Zero;
037800060218              ExSr  SndErrMsg;
037900060218
038000060218            Else;
038100060218              ExSr  GetUsrObj;
038200060218            EndIf;
038300060218          EndDo;
038400060218
038500060226          ExSr  WrtSrtLst;
038600060226
038700060218        EndSr;
038800060218
038900050801        BegSr  GetUsrObj;
039000050303
039100050801          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
039200050303          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
039300050303          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
039400050303
039500060218          If  UsrSpc.NumLstEnt = *Zero;
039600060218
039700060218          Else;
039800060218            For  Idx = 1  To  UsrSpc.NumLstEnt;
039900060218
040000060226              ExSr  AddSrtLst;
040100060218
040200060218              If  Idx < UsrSpc.NumLstEnt;
040300060218                pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
040400060218              EndIf;
040500060218            EndFor;
040600060218          EndIf;
040700050801
040800050801          CntHdl = InpPrm.CntHdl;
040900050303
041000050303        EndSr;
041100060226
041200060226        BegSr  InzSrtLst;
041300060226
041400060226          SrtKeyInfDs.KeySize   = %Size( LstRcd.AutLst );
041500060226          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
041600060226          SrtKeyInfDs.KeyOrder  = ASCEND;
041700060226          SrtKeyInfDs.KeyStrPos = 1;
041800060226
041900060226          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
042000060226
042100060226          RqsCtlBlk.NlsOfs = KEY_OFS +
042200060226                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
042300060226
042400060226          RqsCtlBlk.BlkLen = KEY_OFS +
042500060226                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
042600060226                             SIZ_NLS_INF;
042700060226
042800060226          RqsCtlBlk.KeyNbr = NBR_KEY;
042900060226
043000060226          InzSort( RqsCtlBlk
043100060226                 : SrtApi.Omit
043200060226                 : SrtApi.Omit
043300060226                 : SrtApi.DtaBufLen
043400060226                 : SrtApi.DtaRtnLen
043500060226                 : ERRC0100
043600060226                 );
043700060226
043800060226          If  ERRC0100.BytAvl = *Zero;
043900060226            SrtAct = *On;
044000060226          EndIf;
044100060226
044200060226        EndSr;
044300060226
044400060226        BegSr  AddSrtLst;
044500060226
044600060226          If  SrtAct = *Off;
044700060226            ExSr  InzSrtLst;
044800060226          EndIf;
044900060226
045000060226          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
045100060226          RqsCtlBlkIo.RcdCnt = 1;
045200060226          RqsCtlBlkIo.RqsTyp = SRT_PUT;
045300060226
045400060226          LstRcd.AutLst  =  OBJA0200.ObjNam;
045500060226
045600060226          Select;
045700060226          When  OBJA0200.ObjOwn = 'Y';
045800060226            LstRcd.ObjOwn  =  '*YES';
045900060226          When  OBJA0200.ObjOwn = 'G';
046000060226            LstRcd.ObjOwn  =  '*PGP';
046100060226          When  OBJA0200.ObjOwn = 'N';
046200060226            LstRcd.ObjOwn  =  '*NO';
046300060226          Other;
046400060226            LstRcd.ObjOwn  =  '*';
046500060226          EndSl;
046600060226
046700060226          LstRcd.AutVal  =  OBJA0200.AutVal;
046800060226          LstRcd.AutlMgt =  OBJA0200.AutlMgt;
046900060226          LstRcd.ObjOpr  =  OBJA0200.ObjOpr;
047000060226          LstRcd.ObjMgt  =  OBJA0200.ObjMgt;
047100060226          LstRcd.ObjExs  =  OBJA0200.ObjExs;
047200060226          LstRcd.ObjAlt  =  OBJA0200.ObjAlt;
047300060226          LstRcd.ObjRef  =  OBJA0200.ObjRef;
047400060226          LstRcd.DtaRead =  OBJA0200.DtaRead;
047500060226          LstRcd.DtaAdd  =  OBJA0200.DtaAdd;
047600060226          LstRcd.DtaUpd  =  OBJA0200.DtaUpd;
047700060226          LstRcd.DtaDlt  =  OBJA0200.DtaDlt;
047800060226          LstRcd.DtaExe  =  OBJA0200.DtaExe;
047900060226
048000060226          LstRcd.AutFlg = %Xlate( 'YN': 'X ': LstRcd.AutFlg );
048100060226
048200060226          SortIo( RqsCtlBlkIo
048300060226                : LstRcd
048400060226                : SrtApi.Omit
048500060226                : SrtApi.DtaBufLen
048600060226                : DtaBufInf
048700060226                : ERRC0100
048800060226                );
048900060226
049000060226        EndSr;
049100060226
049200060226        BegSr  WrtSrtLst;
049300060226
049400060226          ExSr  EndSrtLst;
049500060226
049600060226          If  DtaBufInf.RcdAvl = *Zero;
049700060226            WrtLstTrl( '(No authorization lists found)' );
049800060226
049900060226          Else;
050000060226            RqsCtlBlkIo.RqsTyp = SRT_GET;
050100060226
050200060226            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
050300060226
050400060226            SortIo( RqsCtlBlkIo
050500060226                  : SrtApi.Omit
050600060226                  : LstRcd
050700060226                  : SrtApi.DtaBufLen
050800060226                  : DtaBufInf
050900060226                  : ERRC0100
051000060226                  );
051100060226
051200060226            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;
051300060226
051400060226              WrtDtlLin();
051500060226
051600060226              SortIo( RqsCtlBlkIo
051700060226                    : SrtApi.Omit
051800060226                    : LstRcd
051900060226                    : SrtApi.DtaBufLen
052000060226                    : DtaBufInf
052100060226                    : ERRC0100
052200060226                    );
052300060226            EndDo;
052400060226          EndIf;
052500060226
052600060226        EndSr;
052700060226
052800060226        BegSr  EndSrtLst;
052900060226
053000060226          RqsCtlBlkIo.RqsTyp = SRT_END;
053100060226
053200060226          SortIo( RqsCtlBlkIo
053300060226                : SrtApi.Omit
053400060226                : SrtApi.Omit
053500060226                : SrtApi.DtaBufLen
053600060226                : DtaBufInf
053700060226                : ERRC0100
053800060226                );
053900060226
054000060226          If  ERRC0100.BytAvl = *Zero;
054100060226            SrtAct = *Off;
054200060226          EndIf;
054300060226
054400060226        EndSr;
054500060218
054600060218        BegSr  SndErrMsg;
054700060218
054800060218          If  ERRC0100.BytAvl < OFS_MSGDTA;
054900060218            ERRC0100.BytAvl = OFS_MSGDTA;
055000060218          EndIf;
055100060218
055200060218          SndEscMsg( ERRC0100.MsgId
055300060218                   : 'QCPFMSG'
055400060218                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
055500060218                   );
055600060218
055700060218        EndSr;
055800050304
055900060217        BegSr  *InzSr;
056000060217
056100060217          LstTim = %Int( %Char( %Time(): *ISO0));
056200060217          SysNam = GetSysNam();
056300060217
056400060217        EndSr;
056500060217
056600060217      /End-Free
056700060217
056800060217     **-- Printer file definition:  ------------------------------------------**
056900060217     OQSYSPRT   EF           Header         2  2
057000060217     O                       UDATE         Y      8
057100060217     O                       LstTim              18 '  :  :  '
057200060217     O                                           36 'System:'
057300060217     O                       SysNam              45
057400060219     O                                           85 'User Authorization Lists'
057500060217     O                                          107 'Program:'
057600060217     O                       PgmSts.PgmNam      118
057700060217     O                                          126 'Page:'
057800060217     O                       PAGE             +   1
057900060217     **
058000060218     OQSYSPRT   EF           LstHdr         1
058100060217     O                                           26 'User profile . . . . . . :'
058200060218     O                       UsrPrf              38
058300060218     OQSYSPRT   EF           LstHdr         1
058400060218     O                                           26 '  Group profile  . . . . :'
058500060218     O                       GrpPrf              38
058600060218     OQSYSPRT   EF           LstHdr      1  1
058700060217     O                                           13 'Authorization'
058800060217     O                                           44 'List'
058900060217     O                                           83 '------------- Object ------
059000060217     O                                              ---------'
059100060217     O                                          123 '--------------- Data ------
059200060217     O                                              ----------'
059300060217     OQSYSPRT   EF           LstHdr         1
059400060217     O                                            4 'List'
059500060217     O                                           20 'Owner'
059600060217     O                                           33 'Authority'
059700060217     O                                           43 'Mgt'
059800060217     O                                           51 'Opr'
059900060217     O                                           59 'Mgt'
060000060217     O                                           68 'Exist'
060100060217     O                                           76 'Alter'
060200060217     O                                           83 'Ref'
060300060217     O                                           91 'Read'
060400060217     O                                           99 'Add'
060500060217     O                                          107 'Upd'
060600060217     O                                          115 'Dlt'
060700060217     O                                          123 'Exe'
060800060217     **
060900060217     OQSYSPRT   EF           DtlLin         1
061000060217     O                       LstRcd.AutLst       10
061100060225     O                       LstRcd.ObjOwn       19
061200060217     O                       LstRcd.AutVal       34
061300060217     O                       LstRcd.AutlMgt      42
061400060217     O                       LstRcd.ObjOpr       50
061500060217     O                       LstRcd.ObjMgt       58
061600060217     O                       LstRcd.ObjExs       66
061700060217     O                       LstRcd.ObjAlt       74
061800060217     O                       LstRcd.ObjRef       82
061900060217     O                       LstRcd.DtaRead      90
062000060217     O                       LstRcd.DtaAdd       98
062100060217     O                       LstRcd.DtaUpd      106
062200060217     O                       LstRcd.DtaDlt      114
062300060217     O                       LstRcd.DtaExe      122
062400060217     **
062500060219     OQSYSPRT   EF           LstTrl      1  1
062600060217     O                       TrlTxt              34
062700060217
062800060217     **-- Send escape message:
062900050306     P SndEscMsg       B
063000050306     D                 Pi            10i 0
063100050306     D  PxMsgId                       7a   Const
063200050306     D  PxMsgF                       10a   Const
063300050306     D  PxMsgDta                    512a   Const  Varying
063400050306     **
063500050306     D MsgKey          s              4a
063600050306
063700050306      /Free
063800050306
063900050306        SndPgmMsg( PxMsgId
064000050306                 : PxMsgF + '*LIBL'
064100050306                 : PxMsgDta
064200050306                 : %Len( PxMsgDta )
064300050306                 : '*ESCAPE'
064400050306                 : '*PGMBDY'
064500050306                 : 1
064600050306                 : MsgKey
064700050306                 : ERRC0100
064800050306                 );
064900050306
065000050306        If  ERRC0100.BytAvl > *Zero;
065100050306          Return  -1;
065200050306
065300050306        Else;
065400050306          Return   0;
065500050306        EndIf;
065600050306
065700050306      /End-Free
065800050306
065900050306     P SndEscMsg       E
066000060217     **-- Send completion message:
066100050306     P SndCmpMsg       B
066200050306     D                 Pi            10i 0
066300050306     D  PxMsgDta                    512a   Const  Varying
066400050306     **
066500050306     D MsgKey          s              4a
066600050306
066700050306      /Free
066800050306
066900050306        SndPgmMsg( 'CPF9897'
067000050306                 : 'QCPFMSG   *LIBL'
067100050306                 : PxMsgDta
067200050306                 : %Len( PxMsgDta )
067300050306                 : '*COMP'
067400050306                 : '*PGMBDY'
067500050306                 : 1
067600050306                 : MsgKey
067700050306                 : ERRC0100
067800050306                 );
067900050306
068000050306        If  ERRC0100.BytAvl > *Zero;
068100050306          Return  -1;
068200050306
068300050306        Else;
068400050306          Return  0;
068500050306
068600050306        EndIf;
068700050306
068800050306      /End-Free
068900050306
069000050306     **
069100050306     P SndCmpMsg       E
069200060217     **-- Write detail line:
069300060217     P WrtDtlLin       B
069400060217     D                 Pi
069500060217
069600060217      /Free
069700060217
069800060217        WrtLstHdr( 3 );
069900060217
070000060217        Except  DtlLin;
070100060217
070200060217      /End-Free
070300060217
070400060217     P WrtDtlLin       E
070500060217     **-- Write list header:
070600060217     P WrtLstHdr       B
070700060217     D                 Pi
070800060217     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
070900060217
071000060217      /Free
071100060217
071200060217        If  %Addr( PxOvrFlwRel) = *Null;
071300060217
071400060217          Except  Header;
071500060217          Except  LstHdr;
071600060217        Else;
071700060217
071800060217          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
071900060217
072000060217            Except  Header;
072100060217            Except  LstHdr;
072200060217          EndIf;
072300060217        EndIf;
072400060217
072500060217      /End-Free
072600060217
072700060217     P WrtLstHdr       E
072800060217     **-- Write list trailer:
072900060217     P WrtLstTrl       B
073000060217     D                 Pi
073100060217     D  PxTrlTxt                     32a   Const
073200060217
073300060217      /Free
073400060217
073500060217        TrlTxt = PxTrlTxt;
073600060217
073700060217        Except  LstTrl;
073800060217
073900060217      /End-Free
074000060217
074100060217     P WrtLstTrl       E
074200060217     **-- Get system name:
074300060217     P GetSysNam       B
074400060217     D                 Pi             8a   Varying
074500060217
074600060217     **-- Local variables:
074700060217     D Idx             s             10i 0
074800060217     D SysNam          s              8a   Varying
074900060217     **
075000060217     D RtnAtrLen       s             10i 0
075100060217     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
075200060217     D NetAtr          s             10a   Dim( 1 )
075300060217     **
075400060217     D RtnVar          Ds                  Qualified
075500060217     D  RtnVarNbr                    10i 0
075600060217     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
075700060217     D  RtnVarDta                  1024a
075800060217
075900060217     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
076000060217     D  AtrNam                       10a
076100060217     D  DtaTyp                        1a
076200060217     D  InfSts                        1a
076300060217     D  AtrLen                       10i 0
076400060217     D  Atr                        1008a
076500060217
076600060217      /Free
076700060217
076800060217        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
076900060217
077000060217        NetAtr(1) = 'SYSNAME';
077100060217
077200060217        RtvNetAtr( RtnVar
077300060217                 : RtnAtrLen
077400060217                 : NetAtrNbr
077500060217                 : NetAtr
077600060217                 : ERRC0100
077700060217                 );
077800060217
077900060217        If  ERRC0100.BytAvl > *Zero;
078000060217          SysNam = '';
078100060217
078200060217        Else;
078300060217          For  Idx = 1  to RtnVar.RtnVarNbr;
078400060217
078500060217            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
078600060217
078700060217            If  RtnAtr.AtrNam = 'SYSNAME';
078800060217              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
078900060217            EndIf;
079000060217
079100060217          EndFor;
079200060217        EndIf;
079300060217
079400060217        Return  SysNam;
079500060217
079600060217      /End-Free
079700060217
079800060217     P GetSysNam       E
079900060218     **-- Get group profiles:
080000060218     P GetGrpPrf       B                   Export
080100060218     D                 Pi            10a   Dim( MAX_GRPPRF )
080200060218     D  PxUsrPrf                     10a   Const
080300060218
080400060218     **-- Local declarations:
080500060218     D MAX_SUPGRP      c                   15
080600060218     D MAX_SPCAUT      c                   15
080700060218     D GrpPrf          s             10a   Inz  Dim( MAX_GRPPRF )
080800060218     D GrpIdx          s             10i 0 Inz
080900060218     D Idx             s             10i 0
081000060218     **-- User information structure:
081100060218     D USRI0200        Ds           512    Qualified
081200060218     D  BytRtn                       10i 0
081300060218     D  BytAvl                       10i 0
081400060218     D  UsrPrf                       10a
081500060218     D  SpcAut                        1a   Overlay( USRI0200: 29 )
081600060218     D                                     Dim( MAX_SPCAUT )
081700060218     D  GrpPrf                       10a   Overlay( USRI0200: 44 )
081800060218     D  SupGrpOfs                    10i 0 Overlay( USRI0200: 97 )
081900060218     D  SupGrpNbr                    10i 0 Overlay( USRI0200: 101 )
082000060218     **
082100060218     D SupGrpPrf       s             10a   Based( pSupGrpPrf )
082200060218     D                                     Dim( MAX_SUPGRP )
082300060218
082400060218      /Free
082500060218
082600060218        RtvUsrInf( USRI0200
082700060218                 : %Size( USRI0200 )
082800060218                 : 'USRI0200'
082900060218                 : PxUsrPrf
083000060218                 : ERRC0100
083100060218                 );
083200060218
083300060218        If  ERRC0100.BytAvl = *Zero;
083400060218          pSupGrpPrf = %Addr( USRI0200 ) + USRI0200.SupGrpOfs;
083500060218
083600060218          If  USRI0200.GrpPrf <> '*NONE';
083700060218            GrpIdx += 1;
083800060218            GrpPrf(GrpIdx) = USRI0200.GrpPrf;
083900060218          EndIf;
084000060218
084100060218          For  Idx = 1 to  USRI0200.SupGrpNbr;
084200060218            GrpIdx += 1;
084300060218            GrpPrf(GrpIdx) = SupGrpPrf(Idx);
084400060218          EndFor;
084500060218        EndIf;
084600060218
084700060218        Return  GrpPrf;
084800060218
084900060218      /End-Free
085000060218
085100060218     P GetGrpPrf       E
