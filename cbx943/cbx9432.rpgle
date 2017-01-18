000100041212     **
000200050825     **  Program . . : CBX9432
000300050825     **  Description : Print journal report - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Program description:
000800050825     **    This program will produce a list of all objects currently either
000900050825     **    being journaled or not being journaled.
001000041212     **
001100041218     **
001200041212     **  Authority and security restrictions:
001300041212     **
001400050825     **
001500041212     **  Compile and setup instructions:
001600050825     **    CrtRpgMod   Module( CBX9432 )
001700050825     **                DbgView( *LIST )
001800041212     **
001900050825     **    CrtPgm      Pgm( CBX9432 )
002000050825     **                Module( CBX9432 )
002100041212     **                ActGrp( *NEW )
002200041212     **
002300041212     **
002400041212     **-- Control specification:  --------------------------------------------**
002500041212     H Option( *SrcStmt: *NoDebugIo )
002600050825
002700041212     **-- Printer file:
002800041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002900050825
003000041212     **-- Printer file information:
003100050212     D PrtLinInf       Ds                  Qualified
003200050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
003300050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
003400050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
003500041212     **-- System information:
003600050825     D PgmSts         sDs                  Qualified
003700050825     D  PgmNam           *Proc
003800050825
003900041211     **-- API error data structure:
004000041211     D ERRC0100        Ds                  Qualified
004100041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
004200041211     D  BytAvl                       10i 0
004300041211     D  MsgId                         7a
004400990921     D                                1a
004500041211     D  MsgDta                      128a
004600050212     **-- Global constants:
004700050826     D OBJ_JRN         c                   '1'
004800050826     D OBJ_NOT_JRN     c                   '0'
004900050306     D NBR_KEY         c                   2
005000050212     D KEY_OFS         c                   80
005100050212     D SIZ_NLS_INF     c                   290
005200050212     D JOB_RUN         c                   0
005300050212     D CHAR_NLS        c                   4
005400050212     D ASCEND          c                   1
005500050212     D DESCEND         c                   2
005600050212     **
005700050212     D SRT_PUT         c                   1
005800050212     D SRT_END         c                   2
005900050212     D SRT_GET         c                   3
006000050212     D SRT_CNL         c                   4
006100041212     **-- Global variables:
006200041212     D LstTim          s              6s 0
006300041211     D Idx             s             10i 0
006400050212     D SrtAct          s               n
006500050122     **-- List record:
006600050122     D LstRcd          Ds                  Qualified
006700050122     D  ObjNam                       10a
006800050122     D  LibNam                       10a
006900050826     D  ObjTyp                       10a
007000050122     D  ObjTxt                       50a
007100050313     D  CrtPrf                       10a
007200050826     D  JrnSts                        8a
007300050826     D  JrnNam                       10a
007400050826     D  JrnLib                       10a
007500050825
007600050212     **-- List API parameters:
007700050212     D LstApi          Ds                  Qualified  Inz
007800050212     D  RtnRcdNbr                    10i 0
007900050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
008000050826     D  KeyFld                       10i 0 Dim( 6 )
008100050212     D  ObjTyp                       10a
008200040426     **-- Object information:
008300041211     D ObjInf          Ds          4096    Qualified
008400041212     D  ObjNam                       10a
008500041212     D  ObjLib                       10a
008600041212     D  ObjTyp                       10a
008700041211     D  InfSts                        1a
008800040426     D                                1a
008900041211     D  FldNbrRtn                    10i 0
009000041211     D  Data                               Like( KeyInf )
009100040426     **-- Key information:
009200041211     D KeyInf          Ds                  Qualified  Based( pKeyInf )
009300041211     D  FldInfLen                    10i 0
009400041211     D  KeyFld                       10i 0
009500041211     D  DtaTyp                        1a
009600041211     D                                3a
009700041211     D  DtaLen                       10i 0
009800041211     D  Data                        256a
009900040426     **-- List information:
010000041211     D LstInf          Ds                  Qualified
010100041211     D  RcdNbrTot                    10i 0
010200041211     D  RcdNbrRtn                    10i 0
010300041211     D  Handle                        4a
010400041211     D  RcdLen                       10i 0
010500041211     D  InfSts                        1a
010600041211     D  Dts                          13a
010700041211     D  LstSts                        1a
010800040426     D                                1a
010900041211     D  InfLen                       10i 0
011000041211     D  Rcd1                         10i 0
011100040426     D                               40a
011200040426     **-- Sort information:
011300041211     D SrtInf          Ds                  Qualified
011400041211     D  NbrKeys                      10i 0 Inz( 0 )
011500041211     D  SrtInf                       12a   Dim( 10 )
011600041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
011700041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
011800041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
011900041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
012000041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
012100040426     **-- Authority control:
012200041211     D AutCtl          Ds                  Qualified
012300041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
012400041211     D  CalLvl                       10i 0 Inz( 0 )
012500041211     D  DplObjAut                    10i 0 Inz( 0 )
012600041211     D  NbrObjAut                    10i 0 Inz( 0 )
012700041211     D  DplLibAut                    10i 0 Inz( 0 )
012800041211     D  NbrLibAut                    10i 0 Inz( 0 )
012900040426     D                               10i 0 Inz( 0 )
013000041211     D  ObjAut                       10a   Dim( 10 )
013100041211     D  LibAut                       10a   Dim( 10 )
013200040426     **-- Selection control:
013300041211     D SltCtl          Ds
013400041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
013500041211     D  SltOmt                       10i 0 Inz( 0 )
013600041211     D  DplSts                       10i 0 Inz( 20 )
013700041211     D  NbrSts                       10i 0 Inz( 1 )
013800040426     D                               10i 0 Inz( 0 )
013900041211     D  Status                        1a   Inz( '*' )
014000040426     **-- Object information key fields:
014100050826     D KeyFld          Ds                  Qualified
014200050826     D  TxtDsc                       50a
014300050826     D  ExtObjAtr                    10a
014400050826     D  ObjOwn                       10a
014500050826     D  CrtPrf                       10a
014600050826     D  JrnSts                        1a
014700050826     D  JrnNam                       10a
014800050826     D  JrnLib                       10a
014900050122     **-- Sort API parameters:
015000050212     D SrtApi          Ds                  Qualified  Inz
015100050212     D  DtaBufLen                    10i 0
015200050212     D  DtaRtnLen                    10i 0
015300050212     D  Omit                         16a
015400050122     **
015500050122     D RqsCtlBlk       Ds                  Qualified  Inz
015600050122     D  BlkLen                       10i 0
015700050122     D  RqsTyp                       10i 0 Inz( 8 )
015800050122     D                               10i 0
015900050122     D  Options                      10i 0
016000050122     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
016100050122     D  RcdCnt                       10i 0
016200050122     D  KeyOfs                       10i 0 Inz( KEY_OFS )
016300050122     D  KeyNbr                       10i 0
016400050122     D  NlsOfs                       10i 0
016500050122     D  InpFlsOfs                    10i 0
016600050122     D  InpFlsNbr                    10i 0
016700050122     D  OutFlsOfs                    10i 0
016800050122     D  OutFlsNbr                    10i 0
016900050122     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
017000050122     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
017100050122     D  InpFenLen                    10i 0
017200050122     D  OutFenLen                    10i 0
017300050122     D  NlbMapOfs                    10i 0
017400050122     D  VlrAciOfs                    10i 0
017500050122     D                               10i 0
017600050122     **
017700050122     D SrtKeyInf                     20a   Dim( NBR_KEY )
017800050122     **
017900050122     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
018000050122     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
018100050122     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
018200050122     D SrtSeqTbl                    256a
018300050122     **
018400050122     D SrtKeyInfDs     Ds                  Qualified  Inz
018500050122     D  KeyStrPos                    10i 0
018600050122     D  KeySize                      10i 0
018700050122     D  KeyDtaTyp                    10i 0
018800050122     D  KeyOrder                     10i 0
018900050122     D  KeyOrdPos                    10i 0
019000050122     **
019100050122     D RqsCtlBlkIo     Ds                  Qualified
019200050122     D  RqsTyp                       10i 0 Inz
019300050122     D                               10i 0 Inz
019400050122     D  RcdLen                       10i 0 Inz
019500050122     D  RcdCnt                       10i 0 Inz
019600050122     **
019700050122     D DtaBufInf       Ds                  Qualified
019800050122     D  RcdPrc                       10i 0
019900050122     D  RcdAvl                       10i 0
020000050122     D                                8a
020100050825
020200041211     **-- Open list of objects:
020300040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
020400050826     D  RcvVar                    65535a          Options( *VarSize )
020500050826     D  RcvVarLen                    10i 0 Const
020600050826     D  LstInf                       80a
020700050826     D  NbrRcdRtn                    10i 0 Const
020800050826     D  SrtInf                     1024a   Const  Options( *VarSize )
020900050826     D  ObjNam_q                     20a   Const
021000050826     D  ObjTyp                       10a   Const
021100050826     D  AutCtl                     1024a   Const  Options( *VarSize )
021200050826     D  SltCtl                     1024a   Const  Options( *VarSize )
021300050826     D  NbrKeyRtn                    10i 0 Const
021400050826     D  KeyFld                       10i 0 Const  Options( *VarSize )  Dim( 32 )
021500050826     D  Error                      1024a          Options( *VarSize )
021600020531     **
021700050826     D  JobIdInf                    256a          Options( *NoPass: *VarSize )
021800050826     D  JobIdFmt                      8a   Const  Options( *NoPass )
021900050826     **
022000050826     D  AspCtl                      256a          Options( *NoPass: *VarSize )
022100041212     **-- Get list entry:
022200020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
022300050826     D  RcvVar                    65535a          Options( *VarSize )
022400050826     D  RcvVarLen                    10i 0 Const
022500050826     D  Handle                        4a   Const
022600050826     D  LstInf                       80a
022700050826     D  NbrRcdRtn                    10i 0 Const
022800050826     D  RtnRcdNbr                    10i 0 Const
022900050826     D  Error                      1024a          Options( *VarSize )
023000041212     **-- Close list:
023100020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
023200050826     D  Handle                        4a   Const
023300050826     D  Error                      1024a          Options( *VarSize )
023400050122     **-- Initialize sort:
023500050122     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
023600050826     D  RqsCtlBlk                    80a   Const  Options( *VarSize )
023700050826     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
023800050826     D  OutDtaBuf                 65535a          Options( *VarSize )
023900050826     D  OutDtaLen                    10i 0 Const
024000050826     D  RtnDtaLen                    10i 0
024100050826     D  Error                     32767a          Options( *VarSize )
024200050826     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
024300050826     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
024400050122     **-- Sort input/output:
024500050122     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
024600050826     D  RqsCtlBlk                    16a   Const
024700050826     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
024800050826     D  OutDtaBuf                 65535a          Options( *VarSize )
024900050826     D  OutDtaLen                    10i 0 Const
025000050826     D  OutDtaInf                    16a
025100050826     D  Error                     32767a          Options( *VarSize )
025200050826     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
025300050826     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
025400041212
025500041216     **-- Write detail line:
025600041216     D WrtDtlLin       Pr
025700041212     **-- Write list header:
025800041212     D WrtLstHdr       Pr
025900041212     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
026000041216     **-- Write list trailer:
026100041216     D WrtLstTrl       Pr
026200041212
026300050825     D CBX9432         Pr
026400050825     D  PxObjLib                     10a
026500050825     D  PxObjTyp                     10a
026600050826     D  PxRptTyp                     10a
026700050122     D  PxSrtOrd                     10a
026800041212     **
026900050825     D CBX9432         Pi
027000050825     D  PxObjLib                     10a
027100050825     D  PxObjTyp                     10a
027200050826     D  PxRptTyp                     10a
027300050825     D  PxSrtOrd                     10a
027400041211
027500041211      /Free
027600041211
027700050826        LstApi.KeyFld(1) = 202;
027800050826        LstApi.KeyFld(2) = 203;
027900050826        LstApi.KeyFld(3) = 405;
028000050826        LstApi.KeyFld(4) = 513;
028100050826        LstApi.KeyFld(5) = 514;
028200050826        LstApi.KeyFld(6) = 515;
028300041211
028400041211        SrtInf.NbrKeys      = 0;
028500041211        SrtInf.KeyFldOfs(1) = 0;
028600041211        SrtInf.KeyFldLen(1) = 0;
028700041211        SrtInf.KeyFldTyp(1) = 0;
028800041211        SrtInf.SrtOrd(1)    = '1';
028900041211        SrtInf.Rsv(1)       = x'00';
029000041211
029100050826        If  PxObjTyp = '*FILE'  Or  PxObjTyp = '*ALL';
029200050826          LstApi.ObjTyp = '*FILE';
029300050826
029400050826          ExSr  GetObjLst;
029500050826        EndIf;
029600041211
029700050826        If  PxObjTyp = '*DTAARA'  Or  PxObjTyp = '*ALL';
029800050826          LstApi.ObjTyp = '*DTAARA';
029900050826
030000050826          ExSr  GetObjLst;
030100050826        EndIf;
030200050826
030300050826        If  PxObjTyp = '*DTAQ'  Or  PxObjTyp = '*ALL';
030400050826          LstApi.ObjTyp = '*DTAQ';
030500050826
030600050826          ExSr  GetObjLst;
030700050826        EndIf;
030800050122
030900050122        ExSr  WrtSrtLst;
031000041216
031100041211        *InLr = *On;
031200041211
031300041211        Return;
031400041211
031500050825        BegSr  GetObjLst;
031600050825
031700050825          LstApi.RtnRcdNbr = 1;
031800050825
031900050825          LstObjs( ObjInf
032000050825                 : %Size( ObjInf )
032100050825                 : LstInf
032200050825                 : 1
032300050825                 : SrtInf
032400050826                 : '*ALL      ' + PxObjLib
032500050825                 : LstApi.ObjTyp
032600050825                 : AutCtl
032700050825                 : SltCtl
032800050825                 : LstApi.NbrKeyRtn
032900050825                 : LstApi.KeyFld
033000050825                 : ERRC0100
033100050825                 );
033200050825
033300050825          If  ERRC0100.BytAvl = *Zero;
033400050825
033500050825            DoW  LstInf.LstSts <> '2'  Or
033600050825                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
033700050825
033800050825              ExSr  GetKeyDta;
033900050825
034000050826              ExSr  ChkJrnSts;
034100050825
034200050825              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
034300050825
034400050825              GetLstEnt( ObjInf
034500050825                       : %Size( ObjInf )
034600050825                       : LstInf.Handle
034700050825                       : LstInf
034800050825                       : 1
034900050825                       : LstApi.RtnRcdNbr
035000050825                       : ERRC0100
035100050825                       );
035200050825
035300050825              If  ERRC0100.BytAvl > *Zero;
035400050825                Leave;
035500050825              EndIf;
035600050825            EndDo;
035700050825
035800050825            CloseLst( LstInf.Handle: ERRC0100 );
035900050825          EndIf;
036000050825
036100050825        EndSr;
036200050825
036300041211        BegSr  GetKeyDta;
036400041211
036500041211          pKeyInf = %Addr( ObjInf.Data );
036600041211
036700041211          For  Idx = 1  To ObjInf.FldNbrRtn;
036800041211
036900041211            Select;
037000050826            When  KeyInf.KeyFld = 202;
037100050826              KeyFld.ExtObjAtr = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
037200050826
037300050826            When  KeyInf.KeyFld = 203;
037400050826              KeyFld.TxtDsc = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
037500050306
037600050306            When  KeyInf.KeyFld = 405;
037700050826              KeyFld.CrtPrf = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
037800050826
037900050826            When  KeyInf.KeyFld = 513;
038000050826              KeyFld.JrnSts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
038100050826
038200050826            When  KeyInf.KeyFld = 514;
038300050826              KeyFld.JrnNam = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
038400050826
038500050826            When  KeyInf.KeyFld = 515;
038600050826              KeyFld.JrnLib = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
038700041211            EndSl;
038800041211
038900041211            If  Idx < ObjInf.FldNbrRtn;
039000041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
039100041211            EndIf;
039200041211          EndFor;
039300041211
039400041211        EndSr;
039500041211
039600050826        BegSr  ChkJrnSts;
039700041212
039800050826          If  ObjInf.ObjTyp = '*FILE'   And  KeyFld.ExtObjAtr  = 'PF'        Or
039900050826              ObjInf.ObjTyp = '*DTAQ'   And  KeyFld.ExtObjAtr <> 'DDMDTAQUE' Or
040000050826              ObjInf.ObjTyp = '*DTAARA' And  KeyFld.ExtObjAtr <> 'DDMDTAARA';
040100050826
040200050826            Select;
040300050826            When  PxRptTyp = '*JRN'  And  KeyFld.JrnSts = OBJ_JRN;
040400050826              ExSr AddSrtLst;
040500050826
040600050826            When  PxRptTyp = '*NOTJRN'  And  KeyFld.JrnSts = OBJ_NOT_JRN;
040700050826              ExSr AddSrtLst;
040800050826            EndSl;
040900050826          EndIf;
041000041212
041100041212        EndSr;
041200041212
041300050122        BegSr  InzSrtLst;
041400050122
041500050122          SrtKeyInfDs.KeySize   = 10;
041600050122          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
041700050122          SrtKeyInfDs.KeyOrder  = ASCEND;
041800050122
041900050122          Select;
042000050122          When  PxSrtOrd = '*LIBOBJ';
042100050122            SrtKeyInfDs.KeyStrPos = 11;
042200050122
042300050122          When  PxSrtOrd = '*OBJ   ';
042400050122            SrtKeyInfDs.KeyStrPos = 1;
042500050122
042600050826          When  PxSrtOrd = '*JRNLIB';
042700050826            SrtKeyInfDs.KeyStrPos = 99;
042800050122
042900050313          When  PxSrtOrd = '*CRTPRF';
043000050826            SrtKeyInfDs.KeyStrPos = 81;
043100050313
043200050122          When  PxSrtOrd = '*TYPOBJ';
043300050122            SrtKeyInfDs.KeyStrPos = 21;
043400050122          EndSl;
043500050122
043600050122          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
043700050122
043800050122          Select;
043900050122          When  PxSrtOrd = '*LIBOBJ';
044000050122            SrtKeyInfDs.KeyStrPos = 1;
044100050122
044200050122          When  PxSrtOrd = '*OBJ   ';
044300050122            SrtKeyInfDs.KeyStrPos = 11;
044400050122
044500050826          When  PxSrtOrd = '*JRNLIB';
044600050122            SrtKeyInfDs.KeyStrPos = 1;
044700050122
044800050313          When  PxSrtOrd = '*CRTPRF';
044900050313            SrtKeyInfDs.KeyStrPos = 1;
045000050313
045100050122          When  PxSrtOrd = '*TYPOBJ';
045200050122            SrtKeyInfDs.KeyStrPos = 1;
045300050122          EndSl;
045400050122
045500050122          RqsCtlBlk.SrtKeyInf(2) = SrtKeyInfDs;
045600050122
045700050122          RqsCtlBlk.NlsOfs = KEY_OFS +
045800050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
045900050122
046000050122          RqsCtlBlk.BlkLen = KEY_OFS +
046100050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
046200050122                             SIZ_NLS_INF;
046300050122
046400050122          RqsCtlBlk.KeyNbr = NBR_KEY;
046500050122
046600050122          InzSort( RqsCtlBlk
046700050212                 : SrtApi.Omit
046800050212                 : SrtApi.Omit
046900050212                 : SrtApi.DtaBufLen
047000050212                 : SrtApi.DtaRtnLen
047100050122                 : ERRC0100
047200050122                 );
047300050122
047400050122          If  ERRC0100.BytAvl = *Zero;
047500050212            SrtAct = *On;
047600050122          EndIf;
047700050122
047800050122        EndSr;
047900050122
048000050122        BegSr  AddSrtLst;
048100050122
048200050212          If  SrtAct = *Off;
048300050122            ExSr  InzSrtLst;
048400050122          EndIf;
048500050122
048600050122          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
048700050122          RqsCtlBlkIo.RcdCnt = 1;
048800050122          RqsCtlBlkIo.RqsTyp = SRT_PUT;
048900050122
049000050122          LstRcd.ObjNam = ObjInf.ObjNam;
049100050122          LstRcd.LibNam = ObjInf.ObjLib;
049200050826          LstRcd.ObjTyp = ObjInf.ObjTyp;
049300050826          LstRcd.ObjTxt = KeyFld.TxtDsc;
049400050826          LstRcd.CrtPrf = KeyFld.CrtPrf;
049500050826          LstRcd.JrnNam = KeyFld.JrnNam;
049600050826          LstRcd.JrnLib = KeyFld.JrnLib;
049700050826
049800050826          If  KeyFld.JrnSts = OBJ_JRN;
049900050826            LstRcd.JrnSts = '*JRN';
050000050826          Else;
050100050826            LstRcd.JrnSts = '*NOTJRN';
050200050826          EndIf;
050300050826
050400050122          SortIo( RqsCtlBlkIo
050500050122                : LstRcd
050600050212                : SrtApi.Omit
050700050212                : SrtApi.DtaBufLen
050800050122                : DtaBufInf
050900050122                : ERRC0100
051000050122                );
051100050122
051200050122        EndSr;
051300050122
051400050122        BegSr  WrtSrtLst;
051500050122
051600050122          ExSr  EndSrtLst;
051700050122
051800050319          If  DtaBufInf.RcdAvl > *Zero;
051900050319
052000050319            RqsCtlBlkIo.RqsTyp = SRT_GET;
052100050319
052200050319            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
052300050319
052400050319            SortIo( RqsCtlBlkIo
052500050319                  : SrtApi.Omit
052600050319                  : LstRcd
052700050319                  : SrtApi.DtaBufLen
052800050319                  : DtaBufInf
052900050319                  : ERRC0100
053000050319                  );
053100050319
053200050319            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;
053300050319
053400050319              WrtDtlLin();
053500050319
053600050319              SortIo( RqsCtlBlkIo
053700050319                    : SrtApi.Omit
053800050319                    : LstRcd
053900050319                    : SrtApi.DtaBufLen
054000050319                    : DtaBufInf
054100050319                    : ERRC0100
054200050319                    );
054300050319
054400050319            EndDo;
054500050319          EndIf;
054600050122
054700050122          WrtLstTrl();
054800050122
054900050122        EndSr;
055000050122
055100050122        BegSr  EndSrtLst;
055200050122
055300050122          RqsCtlBlkIo.RqsTyp = SRT_END;
055400050122
055500050122          SortIo( RqsCtlBlkIo
055600050212                : SrtApi.Omit
055700050212                : SrtApi.Omit
055800050212                : SrtApi.DtaBufLen
055900050122                : DtaBufInf
056000050122                : ERRC0100
056100050122                );
056200050122
056300050122        EndSr;
056400050122
056500041212        BegSr  *InzSr;
056600041212
056700041212          LstTim = %Int( %Char( %Time(): *ISO0));
056800041212
056900041212          WrtLstHdr();
057000041212
057100041212        EndSr;
057200041212
057300050122      /End-Free
057400050122
057500041212     **-- Printer file definition:  ------------------------------------------**
057600041212     OQSYSPRT   EF           Header         2  2
057700041212     O                       UDATE         Y      8
057800041212     O                       LstTim              18 '  :  :  '
057900050826     O                                           65 'Journal report'
058000041212     O                                          107 'Program:'
058100050826     O                       PgmSts.PgmNam      118
058200041212     O                                          126 'Page:'
058300041212     O                       PAGE             +   1
058400041216     **
058500041212     OQSYSPRT   EF           LstHdr         1
058600050826     O                                           27 'Object library  . . . . . -
058700041216     O                                              :'
058800050826     O                       PxObjLib            39
058900041216     **
059000041212     OQSYSPRT   EF           LstHdr         2
059100050826     O                                           27 'List type . . . . . . . . -
059200041216     O                                              :'
059300050826     O                       PxRptTyp            39
059400041216     **
059500041212     OQSYSPRT   EF           LstHdr         1
059600041212     O                                            6 'Object'
059700041212     O                                           19 'Library'
059800041216     O                                           28 'Type'
059900050826     O                                           40 'Text'
060000050826     O                                           95 'Creator'
060100050826     O                                          106 'Status'
060200050826     O                                          117 'Journal'
060300050826     O                                          129 'Library'
060400041216     **
060500041212     OQSYSPRT   EF           DtlLin         1
060600050122     O                       LstRcd.ObjNam       10
060700050122     O                       LstRcd.LibNam       22
060800050826     O                       LstRcd.ObjTyp       34
060900050826     O                       LstRcd.ObjTxt       86
061000050826     O                       LstRcd.CrtPrf       98
061100050826     O                       LstRcd.JrnSts      108
061200050826     O                       LstRcd.JrnNam      120
061300050826     O                       LstRcd.JrnLib      132
061400041212     **
061500050123     OQSYSPRT   EF           LstTrl         1
061600041212     O                                           30 '***  E N D  O F  L I S T  -
061700041212     O                                              ***'
061800041216     **-- Write detail line:  ------------------------------------------------**
061900041216     P WrtDtlLin       B
062000041212     D                 Pi
062100041212
062200041212      /Free
062300041212
062400041216        WrtLstHdr( 3 );
062500041212
062600041216        Except  DtlLin;
062700041212
062800041212      /End-Free
062900041212
063000041216     P WrtDtlLin       E
063100041212     **-- Write list header:  ------------------------------------------------**
063200041212     P WrtLstHdr       B
063300041212     D                 Pi
063400041212     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
063500041212
063600041212      /Free
063700041212
063800041212        If  %Parms = *Zero;
063900041212
064000041212          Except  Header;
064100041212          Except  LstHdr;
064200041212        Else;
064300041212
064400050212          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
064500041212
064600041212            Except  Header;
064700041212            Except  LstHdr;
064800041212          EndIf;
064900041212        EndIf;
065000041212
065100041212      /End-Free
065200041212
065300041212     P WrtLstHdr       E
065400041216     **-- Write list trailer:  -----------------------------------------------**
065500041216     P WrtLstTrl       B
065600041216     D                 Pi
065700041216
065800041216      /Free
065900041216
066000041216        Except  LstTrl;
066100041216
066200041216      /End-Free
066300041216
066400041216     P WrtLstTrl       E
