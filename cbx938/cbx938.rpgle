000100050528     **
000200050528     **  Program . . : CBX938
000300050528     **  Description : Print journal receiver information - CPP
000400050528     **  Author  . . : Carsten Flensburg
000500050528     **
000600050528     **
000700050528     **  Program description:
000800050605     **    This program prints a list of the specified journals and their
000900050605     **    journal receiver directories.  The list contains information
001000050605     **    about journal and journal receiver size and status.
001100050528     **
001200050528     **
001300050528     **  Compile and setup instructions:
001400050603     **    CrtRpgMod   Module( CBX938 )
001500050603     **                DbgView( *LIST )
001600050528     **                Aut( *USE )
001700050528     **
001800050603     **    CrtPgm      Pgm( CBX938 )
001900050603     **                Module( CBX938 )
002000050528     **                ActGrp( *NEW )
002100050528     **
002200050528     **
002300050528     **-- Control specification:  --------------------------------------------**
002400050602     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
002500050602     **-- Printer file:
002600050602     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002700050602     **-- Printer file information:
002800050602     D PrtLinInf       Ds                  Qualified
002900050602     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
003000050602     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
003100050602     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
003200050602     **-- System information:
003300050602     D PgmSts         SDs                  Qualified
003400050602     D  PgmNam           *Proc
003500040709     **-- Global declarations:
003600020509     D Idx             s             10u 0
003700040709     D ApiRcvSiz       s             10u 0
003800050528     **
003900050528     D ObjNam_q        Ds
004000050528     D  ObjNam                       10a
004100050528     D  ObjLib                       10a
004200040709     **-- Api error data structure:
004300040710     D ERRC0100        Ds                  Qualified
004400040710     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
004500040710     D  BytAvl                       10i 0 Inz
004600040710     D  MsgId                         7a
004700010329     D                                1a
004800040710     D  MsgDta                      128a
004900050528
005000050602     **-- Global variables:
005100050602     D LstTim          s              6s 0
005200050602     D SysNam          s              8a
005300050602     D TrlTxt          s             32a
005400050603     **-- List header record:
005500050603     D HdrRcd          Ds                  Qualified
005600050603     D  JrnNam                       10a
005700050603     D  JrnLib                       10a
005800050603     D  JrnTxt                       50a
005900050603     D  JrnTyp                        7a
006000050603     D  MsqNam                       10a
006100050603     D  MsqLib                       10a
006200050603     D  MngRcv                        7a
006300050603     D  DltRcv                        4a
006400050604     D  RcvOpt                       30a
006500050603     D  NbrRcv                       10i 0
006600050604     D  RcvSiz                       20i 0
006700050602     **-- List record:
006800050602     D LstRcd          Ds                  Qualified
006900050603     D  RcvNam                       10a
007000050603     D  RcvLib                       10a
007100050604     D  RcvThh                       10a
007200050603     D  RcvSiz                       10i 0
007300050603     D  RcvSts                       10a
007400050603     D  FstSeq                       10i 0
007500050603     D  NbrEnt                       10i 0
007600050603     D  AtcDat                        8a
007700050603     D  AtcTim                        8a
007800050603     D  DtcDat                        8a
007900050603     D  DtcTim                        8a
008000050603     D  SavDat                        8a
008100050603     D  SavTim                        8a
008200050528     **-- List API parameters:
008300050528     D LstApi          Ds                  Qualified  Inz
008400050528     D  RtnRcdNbr                    10i 0
008500050528     D  NbrKeyRtn                    10i 0 Inz( 0 )
008600050528     D  KeyFld                       10i 0 Dim( 1 )
008700050528     **-- Object information:
008800050528     D ObjInf          Ds          4096    Qualified
008900050528     D  ObjNam                       10a
009000050528     D  ObjLib                       10a
009100050528     D  ObjTyp                       10a
009200050528     D  InfSts                        1a
009300050528     D                                1a
009400050528     D  FldNbrRtn                    10i 0
009500050528     D  Data                               Like( KeyInf )
009600050528     **-- Key information:
009700050528     D KeyInf          Ds                  Qualified  Based( pKeyInf )
009800050528     D  FldInfLen                    10i 0
009900050528     D  KeyFld                       10i 0
010000050528     D  DtaTyp                        1a
010100050528     D                                3a
010200050528     D  DtaLen                       10i 0
010300050528     D  Data                        256a
010400050528     **-- List information:
010500050528     D LstInf          Ds                  Qualified
010600050528     D  RcdNbrTot                    10i 0
010700050528     D  RcdNbrRtn                    10i 0
010800050528     D  Handle                        4a
010900050528     D  RcdLen                       10i 0
011000050528     D  InfSts                        1a
011100050528     D  Dts                          13a
011200050528     D  LstSts                        1a
011300050528     D                                1a
011400050528     D  InfLen                       10i 0
011500050528     D  Rcd1                         10i 0
011600050528     D                               40a
011700050528     **-- Sort information:
011800050528     D SrtInf          Ds                  Qualified
011900050528     D  NbrKeys                      10i 0 Inz( 0 )
012000050528     D  SrtInf                       12a   Dim( 10 )
012100050528     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
012200050528     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
012300050528     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
012400050528     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
012500050528     D   Rsv                          1a   Overlay( SrtInf: *Next )
012600050528     **-- Authority control:
012700050528     D AutCtl          Ds                  Qualified
012800050528     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
012900050528     D  CalLvl                       10i 0 Inz( 0 )
013000050528     D  DplObjAut                    10i 0 Inz( 0 )
013100050528     D  NbrObjAut                    10i 0 Inz( 0 )
013200050528     D  DplLibAut                    10i 0 Inz( 0 )
013300050528     D  NbrLibAut                    10i 0 Inz( 0 )
013400050528     D                               10i 0 Inz( 0 )
013500050528     D  ObjAut                       10a   Dim( 10 )
013600050528     D  LibAut                       10a   Dim( 10 )
013700050528     **-- Selection control:
013800050528     D SltCtl          Ds
013900050528     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
014000050528     D  SltOmt                       10i 0 Inz( 0 )
014100050528     D  DplSts                       10i 0 Inz( 20 )
014200050528     D  NbrSts                       10i 0 Inz( 1 )
014300050528     D                               10i 0 Inz( 0 )
014400050528     D  Status                        1a   Inz( '*' )
014500040709     **-- Journal information:
014600040710     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
014700040710     D  BytRtn                       10i 0
014800040710     D  BytAvl                       10i 0
014900040710     D  OfsKeyInf                    10i 0
015000040710     D  JrnNam                       10a
015100040710     D  JrnLib                       10a
015200040710     D  ASP                          10i 0
015300040710     D  MsgQnam                      10a
015400040710     D  MsgQlib                      10a
015500040710     D  MngRcvOpt                     1a
015600040710     D  DltRcvOpt                     1a
015700040710     D  RsoRit                        1a
015800040710     D  RsoMfl                        1a
015900040710     D  RsoMo1                        1a
016000040710     D  RsoMo2                        1a
016100040710     D  Rsv1                          3a
016200040710     D  JrnTyp                        1a
016300040710     D  RmtJrnTyp                     1a
016400040710     D  JrnStt                        1a
016500040710     D  JrnDlvMod                     1a
016600040710     D  LocJrnNam                    10a
016700040710     D  LocJrnLib                    10a
016800040710     D  LocJrnSys                     8a
016900040710     D  SrcJrnNam                    10a
017000040710     D  SrcJrnLib                    10a
017100040710     D  SrcJrnSys                     8a
017200040710     D  RdrRcvLib                    10a
017300040710     D  JrnTxt                       50a
017400040710     D  MinEntDtaAr                   1a
017500040710     D  MinEntFiles                   1a
017600040710     D  Rsv2                          9a
017700040710     D  NbrAtcRcv                    10i 0
017800040710     D  AtcRcvNam                    10a
017900040710     D  AtcRcvLib                    10a
018000040710     D  AtcLocSys                     8a
018100040710     D  AtcSrcSys                     8a
018200040710     D  AtcRcvNamDu                  10a
018300040710     D  AtcRcvLibDu                  10a
018400040710     D  Rsv3                        192a
018500040710     D  NbrKey                       10i 0
018600020509     **
018700040710     D JrnKey          Ds                  Based( pJrnKey )  Qualified
018800040710     D  Key                          10i 0
018900040710     D  OfsKeyInf                    10i 0
019000040710     D  KeyHdrSecLn                  10i 0
019100040710     D  NbrEnt                       10i 0
019200040710     D  KeyInfEntLn                  10i 0
019300020509     **
019400040710     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
019500040710     D  RcvNbrTot                    10i 0
019600040710     D  RcvSizTot                    10i 0
019700040710     D  RcvSizMtp                    10i 0
019800040710     D  Rsv                           8a
019900020509     **
020000040710     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
020100040710     D  RcvNam                       10a
020200040710     D  RcvLib                       10a
020300040710     D  RcvNbr                        5a
020400040710     D  RcvAtcDts                    13a
020500040710     D  RcvSts                        1a
020600040710     D  RcvSavDts                    13a
020700040710     D  LocJrnSys                     8a
020800040710     D  SrcJrnSys                     8a
020900040710     D  RcvSiz                       10i 0
021000040710     D  Rsv                          56a
021100040709     **-- Journal information specification:
021200040710     D JrnInfRtv       Ds                  Qualified
021300040710     D  NbrVarRcd                    10i 0 Inz( 1 )
021400040710     D  VarRcdLen                    10i 0 Inz( 12 )
021500040710     D  Key                          10i 0 Inz( 1 )
021600040710     D  DtaLen                       10i 0 Inz( 0 )
021700020509     **
021800040710     D JrnInfRtv2      Ds                  Qualified
021900040710     D  NbrVarRcd                    10i 0 Inz( 1 )
022000040710     D  VarRcdLen                    10i 0 Inz( 22 )
022100040710     D  Key                          10i 0 Inz( 2 )
022200040710     D  DtaLen                       10i 0 Inz( %Size( JrnInfRtv2.Dta ))
022300040710     D  Dta
022400040710     D   JrnObjInf                   10a   Overlay( Dta )
022500020509     **
022600040710     D JrnInfRtv3      Ds                  Qualified
022700040710     D  NbrVarRcd                    10i 0 Inz( 1 )
022800040710     D  VarRcdLen                    10i 0 Inz( 60 )
022900040710     D  Key                          10i 0 Inz( 3 )
023000040710     D  DtaLen                       10i 0 Inz( %Size( JrnInfRtv3.Dta ))
023100040710     D  Dta
023200040710     D   RdbDirEinf                  18a   Overlay( Dta )
023300040710     D   RmtJrnNam                   20a   Overlay( Dta: *Next )
023400040709     **-- Receiver information:
023500040710     D RRCV0100        Ds                  Qualified
023600040710     D  BytRtn                       10i 0
023700040710     D  BytAvl                       10i 0
023800040710     D  RcvNam                       10a
023900040710     D  RcvLib                       10a
024000040710     D  JrnNam                       10a
024100040710     D  JrnLib                       10a
024200040710     D  Thh                          10i 0
024300040710     D  Siz                          10i 0
024400040710     D  ASP                          10i 0
024500040710     D  NbrJrnEnt                    10i 0
024600040710     D  MaxEspDtaLn                  10i 0
024700040710     D  MaxNulInd                    10i 0
024800040710     D  FstSeqNbr                    10i 0
024900040710     D  MinEntDtaAr                   1a
025000040710     D  MinEntFiles                   1a
025100040710     D  Rsv1                          2a
025200040710     D  LstSeqNbr                    10i 0
025300040710     D  Rsv2                         10i 0
025400040710     D  Sts                           1a
025500040710     D  MinFxlVal                     1a
025600040710     D  RcvMaxOpt                     1a
025700040710     D  Rsv3                          4a
025800040710     D  AtcDts                       13a
025900050603     D   AtcDat                       7a   Overlay( AtcDts: 1 )
026000050604     D   AtcTim                       6a   Overlay( AtcDts: 8 )
026100040710     D  DtcDts                       13a
026200050603     D   DtcDat                       7a   Overlay( DtcDts: 1 )
026300050604     D   DtcTim                       6a   Overlay( DtcDts: 8 )
026400040710     D  SavDts                       13a
026500050603     D   SavDat                       7a   Overlay( SavDts: 1 )
026600050604     D   SavTim                       6a   Overlay( SavDts: 8 )
026700040710     D  Txt                          50a
026800040710     D  PndTrn                        1a
026900040710     D  RmtJrnTyp                     1a
027000040710     D  LocJrnNam                    10a
027100040710     D  LocJrnLib                    10a
027200040710     D  LocJrnSys                     8a
027300040710     D  LocRcvLib                    10a
027400040710     D  SrcJrnNam                    10a
027500040710     D  SrcJrnLib                    10a
027600040710     D  SrcJrnSys                     8a
027700040710     D  SrcRcvLib                    10a
027800040710     D  RdcRcvLib                    10a
027900040710     D  DuaRcvNam                    10a
028000040710     D  DuaRcvLib                    10a
028100040710     D  PrvRcvNam                    10a
028200040710     D  PrvRcvLib                    10a
028300040710     D  PrvRcvNamDu                  10a
028400040710     D  PrvRcvLibDu                  10a
028500040710     D  NxtRcvNam                    10a
028600040710     D  NxtRcvLib                    10a
028700040710     D  NxtRcvNamDu                  10a
028800040710     D  NxtRcvLibDu                  10a
028900040710     D  NbrJrnEntL                   20s 0
029000040710     D  MaxEspDtlL                   20s 0
029100040710     D  FstSeqNbrL                   20s 0
029200040710     D  LstSeqNbrL                   20s 0
029300040710     D  AspDevNam                    10a
029400040710     D  LocJrnAspGn                  10a
029500040710     D  SrcJrnAspGn                  10a
029600040710     D  FldJob                        1a
029700040710     D  FldUsr                        1a
029800040710     D  FldPgm                        1a
029900040710     D  FldPgmLib                     1a
030000040710     D  FldSysSeq                     1a
030100040710     D  FldRmtAdr                     1a
030200040710     D  FldThd                        1a
030300040710     D  FldLuw                        1a
030400040710     D  FldXid                        1a
030500040710     D  Rsv4                         21a
030600050528
030700050528     **-- Open list of objects:
030800050528     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
030900050528     D  LoRcvVar                  65535a          Options( *VarSize )
031000050528     D  LoRcvVarLen                  10i 0 Const
031100050528     D  LoLstInf                     80a
031200050528     D  LoNbrRcdRtn                  10i 0 Const
031300050528     D  LoSrtInf                   1024a   Const  Options( *VarSize )
031400050528     D  LoObjNam_q                   20a   Const
031500050528     D  LoObjTyp                     10a   Const
031600050528     D  LoAutCtl                   1024a   Const  Options( *VarSize )
031700050528     D  LoSltCtl                   1024a   Const  Options( *VarSize )
031800050528     D  LoNbrKeyRtn                  10i 0 Const
031900050528     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
032000050528     D  LoError                    1024a          Options( *VarSize )
032100050528     **
032200050528     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
032300050528     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
032400050528     **
032500050528     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
032600050528     **-- Get list entry:
032700050528     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
032800050528     D  GlRcvVar                  65535a          Options( *VarSize )
032900050528     D  GlRcvVarLen                  10i 0 Const
033000050528     D  GlHandle                      4a   Const
033100050528     D  GlLstInf                     80a
033200050528     D  GlNbrRcdRtn                  10i 0 Const
033300050528     D  GlRtnRcdNbr                  10i 0 Const
033400050528     D  GlError                    1024a          Options( *VarSize )
033500050528     **-- Close list:
033600050528     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
033700050528     D  ClHandle                      4a   Const
033800050528     D  ClError                    1024a          Options( *VarSize )
033900040709     **-- Retrieve journal information:
034000020509     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
034100020509     D                                     Information' )
034200020509     D  JiRcvVar                  65535a         Options( *VarSize )
034300020509     D  JiRcvVarLen                  10i 0 Const
034400020509     D  JiJrnNam                     20a   Const
034500020509     D  JiFmtNam                      8a   Const
034600020509     D  JiInfRtv                  65535a   Const Options( *VarSize )
034700040511     D  JiError                   32767a         Options( *VarSize: *Omit )
034800040709     **-- Retrieve journal receiver information:
034900020509     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
035000020509     D                                     Information' )
035100020509     D  RiRcvVar                  65535a         Options( *VarSize )
035200020509     D  RiRcvVarLen                  10i 0 Const
035300020509     D  RiRcvNam                     20a   Const
035400020509     D  RiFmtNam                      8a   Const
035500040511     D  RiError                   32767a         Options( *VarSize: *Omit )
035600050602     **-- Retrieve net attribute:
035700050602     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
035800050602     D  RnRcvVar                  32767a          Options( *VarSize )
035900050602     D  RnRcvVarLen                  10i 0 Const
036000050602     D  RnNbrNetAtr                  10i 0 Const
036100050602     D  RnNetAtr                     10a   Const  Dim( 256 )
036200050602     D                                            Options( *VarSize )
036300050602     D  RnError                   32767a          Options( *VarSize )
036400050602     **-- Send program message:
036500050602     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
036600050602     D  SpMsgId                       7a   Const
036700050602     D  SpMsgFq                      20a   Const
036800050602     D  SpMsgDta                    128a   Const
036900050602     D  SpMsgDtaLen                  10i 0 Const
037000050602     D  SpMsgTyp                     10a   Const
037100050602     D  SpCalStkE                    10a   Const  Options( *VarSize )
037200050602     D  SpCalStkCtr                  10i 0 Const
037300050602     D  SpMsgKey                      4a
037400050602     D  SpError                    1024a          Options( *VarSize )
037500050528
037600050528     **-- Send completion message:
037700050528     D SndCmpMsg       Pr            10i 0
037800050528     D  PxMsgDta                    512a   Const  Varying
037900050602     **-- Write detail line:
038000050602     D WrtDtlLin       Pr
038100050602     **-- Write list header:
038200050602     D WrtLstHdr       Pr
038300050603     **-- Write detail header:
038400050603     D WrtDtlHdr       Pr
038500050603     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
038600050602     **-- Write list trailer:
038700050602     D WrtLstTrl       Pr
038800050602     D  PxTrlTxt                     32a   Const
038900050602     **-- Get system name:
039000050602     D GetSysNam       Pr             8a   Varying
039100050528
039200050528     D CBX938          Pr
039300050528     D  PxJrnNam                           LikeDs( ObjNam_q )
039400050528     **
039500050528     D CBX938          Pi
039600050528     D  PxJrnNam                           LikeDs( ObjNam_q )
039700050528
039800050528      /Free
039900050528
040000050528        SrtInf.NbrKeys      = 0;
040100050528        SrtInf.KeyFldOfs(1) = 0;
040200050528        SrtInf.KeyFldLen(1) = 0;
040300050528        SrtInf.KeyFldTyp(1) = 0;
040400050528        SrtInf.SrtOrd(1)    = '1';
040500050528        SrtInf.Rsv(1)       = x'00';
040600050528
040700050528        LstApi.RtnRcdNbr = 1;
040800050528
040900050528        LstObjs( ObjInf
041000050528               : %Size( ObjInf )
041100050528               : LstInf
041200050528               : 1
041300050528               : SrtInf
041400050528               : PxJrnNam.ObjNam + PxJrnNam.ObjLib
041500050528               : '*JRN'
041600050528               : AutCtl
041700050528               : SltCtl
041800050528               : LstApi.NbrKeyRtn
041900050528               : LstApi.KeyFld
042000050528               : ERRC0100
042100050528               );
042200050528
042300050528        If  ERRC0100.BytAvl = *Zero;
042400050528
042500050528          DoW  LstInf.LstSts <> '2'  Or
042600050528               LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
042700050528
042800050528            ExSr  GetJrnInf;
042900050528
043000050528            LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
043100050528
043200050528            GetLstEnt( ObjInf
043300050528                     : %Size( ObjInf )
043400050528                     : LstInf.Handle
043500050528                     : LstInf
043600050528                     : 1
043700050528                     : LstApi.RtnRcdNbr
043800050528                     : ERRC0100
043900050528                     );
044000050528
044100050528            If  ERRC0100.BytAvl > *Zero;
044200050528              Leave;
044300050528            EndIf;
044400050528          EndDo;
044500050528
044600050528          CloseLst( LstInf.Handle: ERRC0100 );
044700050528        EndIf;
044800050528
044900050528        SndCmpMsg( 'List has been printed.' );
045000050528
045100050528        *InLr = *On;
045200050528        Return;
045300050528
045400040709
045500050528        BegSr GetJrnInf;
045600050528
045700050528          ApiRcvSiz = 10240;
045800050528          pJrnInf   = %Alloc( ApiRcvSiz );
045900050528
046000050528          DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
046100050528               ERRC0100.BytAvl  > *Zero;
046200050528
046300050528            If  RJRN0100.BytAvl > ApiRcvSiz;
046400050528              ApiRcvSiz  = RJRN0100.BytAvl;
046500050528              pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
046600050528            EndIf;
046700050528
046800050528            RtvJrnInf( RJRN0100
046900050528                     : ApiRcvSiz
047000050528                     : ObjInf.ObjNam + ObjInf.ObjLib
047100050528                     : 'RJRN0100'
047200050528                     : JrnInfRtv
047300050528                     : ERRC0100
047400050528                     );
047500050528          EndDo;
047600050528
047700050528          If  ERRC0100.BytAvl = *Zero;
047800050528            ExSr PrcKeyEnt;
047900050528          EndIf;
048000050528
048100050528          DeAlloc  pJrnInf;
048200050528
048300050528        EndSr;
048400040709
048500050528        BegSr PrcKeyEnt;
048600050528
048700050528          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );
048800050528
048900050528          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
049000050528          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );
049100050603
049200050603          WrtLstHdr();
049300050528
049400050528          For  Idx = 1  to JrnKey.NbrEnt;
049500050528
049600050528            RtvRcvInf( RRCV0100
049700050528                     : %Size( RRCV0100 )
049800050528                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
049900050528                     : 'RRCV0100'
050000050528                     : ERRC0100
050100050528                     );
050200050528
050300050528            If  ERRC0100.BytAvl = *Zero;
050400050528
050500050603              WrtDtlLin();
050600050528            EndIf;
050700050528
050800050528            If  Idx < JrnKey.NbrEnt;
050900050528              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
051000050528            EndIf;
051100050528          EndFor;
051200050604
051300050604          WrtLstTrl( '**  END OF RECEIVER DIRECTORY **' );
051400050528
051500050528        EndSr;
051600050604
051700050604        BegSr  *InzSr;
051800050604
051900050604          LstTim = %Int( %Char( %Time(): *ISO0));
052000050604          SysNam = GetSysNam();
052100050604
052200050604        EndSr;
052300050604
052400050528
052500050528      /End-Free
052600050528
052700050602     **-- Printer file definition:  ------------------------------------------**
052800050602     OQSYSPRT   EF           Header         2  2
052900050602     O                       UDATE         Y      8
053000050602     O                       LstTim              18 '  :  :  '
053100050602     O                                           36 'System:'
053200050602     O                       SysNam              45
053300050603     O                                           82 'Print journal receivers'
053400050602     O                                          107 'Program:'
053500050602     O                       PgmSts.PgmNam      118
053600050602     O                                          126 'Page:'
053700050602     O                       PAGE             +   1
053800050602     **
053900050603     OQSYSPRT   EF           LstHdr         1
054000050603     O                                           20 'Journal name . . . :'
054100050603     O                       HdrRcd.JrnNam       32
054200050604     O                                           60 'Text . . . . . . . :'
054300050604     O                       HdrRcd.JrnTxt      112
054400050603     OQSYSPRT   EF           LstHdr         1
054500050603     O                                           20 '  Library name . . :'
054600050604     O                       HdrRcd.JrnLib       34
054700050604     O                                           60 'Journal type . . . :'
054800050604     O                       HdrRcd.JrnTyp       69
054900050604     O                                          100 'Number of receivers . :'
055000050604     O                       HdrRcd.NbrRcv 3    112
055100050603     OQSYSPRT   EF           LstHdr         1
055200050603     O                                           20 'Message queue  . . :'
055300050603     O                       HdrRcd.MsqNam       32
055400050604     O                                           60 'Manage receivers . :'
055500050604     O                       HdrRcd.MngRcv       69
055600050604     O                                          100 'Total size (K)  . . . :'
055700050604     O                       HdrRcd.RcvSiz 3    122
055800050603     OQSYSPRT   EF           LstHdr         2
055900050603     O                                           20 '  Library name . . :'
056000050604     O                       HdrRcd.MsqLib       34
056100050604     O                                           60 'Delete receivers . :'
056200050604     O                       HdrRcd.DltRcv       66
056300050604     O                                          100 'Receiver options  . . :'
056400050604     O                       HdrRcd.RcvOpt      132
056500050602     **
056600050603     OQSYSPRT   EF           DtlHdr         1
056700050603     O                                            8 'Receiver'
056800050604     O                                           19 'Library'
056900050604     O                                           33 'Threshold'
057000050604     O                                           44 'Size (K)'
057100050604     O                                           52 'Status'
057200050604     O                                           64 'Seq. nbr.'
057300050604     O                                           75 'Entries'
057400050604     O                                           93 'Attach timestamp'
057500050604     O                                          112 'Detach timestamp'
057600050604     O                                          129 'Save timestamp'
057700050603     **
057800050602     OQSYSPRT   EF           DtlLin         1
057900050603     O                       LstRcd.RcvNam       10
058000050603     O                       LstRcd.RcvLib       22
058100050604     O                       LstRcd.RcvThh       33
058200050604     O                       LstRcd.RcvSiz 3     44
058300050604     O                       LstRcd.RcvSts       56
058400050604     O                       LstRcd.FstSeq 3     64
058500050604     O                       LstRcd.NbrEnt 3     75
058600050604     O                       LstRcd.AtcDat       85
058700050604     O                       LstRcd.AtcTim       94
058800050604     O                       LstRcd.DtcDat      104
058900050604     O                       LstRcd.DtcTim      113
059000050604     O                       LstRcd.SavDat      123
059100050603     O                       LstRcd.SavTim      132
059200050602     **
059300050602     OQSYSPRT   EF           LstTrl         1
059400050602     O                       TrlTxt              34
059500050602     **-- Write detail line:  ------------------------------------------------**
059600050602     P WrtDtlLin       B
059700050602     D                 Pi
059800050602
059900050602      /Free
060000050602
060100050604        WrtDtlHdr( 3 );
060200050603
060300050604        LstRcd.RcvNam = RRCV0100.RcvNam;
060400050604        LstRcd.RcvLib = RRCV0100.RcvLib;
060500050604        LstRcd.RcvSiz = RRCV0100.Siz;
060600050604        LstRcd.FstSeq = RRCV0100.FstSeqNbr;
060700050604        LstRcd.NbrEnt = RRCV0100.NbrJrnEnt;
060800050603
060900050604        If  RRCV0100.Thh = *Zero;
061000050604          LstRcd.RcvThh = ' *NONE';
061100050604        Else;
061200050604          LstRcd.RcvThh = %EditC( RRCV0100.Thh: '3' );
061300050604        EndIf;
061400050604
061500050603        Select;
061600050603        When  RRCV0100.Sts = '1';
061700050603          LstRcd.RcvSts = 'ATTACHED';
061800050603
061900050603        When  RRCV0100.Sts = '2';
062000050603          LstRcd.RcvSts = 'ONLINE';
062100050603
062200050603        When  RRCV0100.Sts = '3';
062300050603          LstRcd.RcvSts = 'SAVED';
062400050603
062500050603        When  RRCV0100.Sts = '4';
062600050603          LstRcd.RcvSts = 'FREED';
062700050603
062800050603        When  RRCV0100.Sts = '5';
062900050603          LstRcd.RcvSts = 'PARTIAL';
063000050603
063100050603        Other;
063200050603          LstRcd.RcvSts = *Blanks;
063300050603        EndSl;
063400050603
063500050604        If  RRCV0100.AtcDts = *Zeros;
063600050603          LstRcd.AtcDat = *Blanks;
063700050603          LstRcd.AtcTim = *Blanks;
063800050603        Else;
063900050603          LstRcd.AtcDat = %Char( %Date( RRCV0100.AtcDat: *CYMD0 ): *JOBRUN );
064000050603          LstRcd.AtcTim = %Char( %Time( RRCV0100.AtcTim: *HMS0 ): *JOBRUN );
064100050603        EndIf;
064200050603
064300050604        If  RRCV0100.DtcDts = *Zeros;
064400050603          LstRcd.DtcDat = *Blanks;
064500050603          LstRcd.DtcTim = *Blanks;
064600050603        Else;
064700050603          LstRcd.DtcDat = %Char( %Date( RRCV0100.DtcDat: *CYMD0 ): *JOBRUN );
064800050603          LstRcd.DtcTim = %Char( %Time( RRCV0100.DtcTim: *HMS0 ): *JOBRUN );
064900050603        EndIf;
065000050603
065100050604        If  RRCV0100.SavDts = *Zeros;
065200050603          LstRcd.SavDat = *Blanks;
065300050603          LstRcd.SavTim = *Blanks;
065400050603        Else;
065500050603          LstRcd.SavDat = %Char( %Date( RRCV0100.SavDat: *CYMD0 ): *JOBRUN );
065600050603          LstRcd.SavTim = %Char( %Time( RRCV0100.SavTim: *HMS0 ): *JOBRUN );
065700050603        EndIf;
065800050602
065900050602        Except  DtlLin;
066000050602
066100050602      /End-Free
066200050602
066300050602     P WrtDtlLin       E
066400050603     **-- Write list header:  ------------------------------------------------**
066500050603     P WrtLstHdr       B
066600050603     D                 Pi
066700050603
066800050603      /Free
066900050603
067000050603        Clear  HdrRcd;
067100050603
067200050604        HdrRcd.JrnNam = RJRN0100.JrnNam;
067300050604        HdrRcd.JrnLib = RJRN0100.JrnLib;
067400050604        HdrRcd.JrnTxt = RJRN0100.JrnTxt;
067500050604        HdrRcd.MsqNam = RJRN0100.MsgQnam;
067600050604        HdrRcd.MsqLib = RJRN0100.MsgQlib;
067700050604        HdrRcd.NbrRcv = JrnKeyHdr1.RcvNbrTot;
067800050604        HdrRcd.RcvSiz = JrnKeyHdr1.RcvSizTot * JrnKeyHdr1.RcvSizMtp;
067900050604
068000050603        Select;
068100050603        When  RJRN0100.JrnTyp = '0';
068200050603          HdrRcd.JrnTyp = '*LOCAL';
068300050603
068400050603        When  RJRN0100.JrnTyp = '1';
068500050603          HdrRcd.JrnTyp = '*REMOTE';
068600050603        EndSl;
068700050603
068800050603        Select;
068900050603        When  RJRN0100.MngRcvOpt = '0';
069000050603          HdrRcd.MngRcv = '*USER';
069100050603
069200050603        When  RJRN0100.MngRcvOpt = '1';
069300050603          HdrRcd.MngRcv = '*SYSTEM';
069400050603        EndSl;
069500050603
069600050603        Select;
069700050603        When  RJRN0100.DltRcvOpt = '0';
069800050603          HdrRcd.DltRcv = '*NO';
069900050603
070000050603        When  RJRN0100.DltRcvOpt = '1';
070100050603          HdrRcd.DltRcv = '*YES';
070200050603        EndSl;
070300050603
070400050604        If  RJRN0100.RsoRit = '1';
070500050604          HdrRcd.RcvOpt = '*RMVINTENT';
070600050604        EndIf;
070700050603
070800050604        If  RJRN0100.RsoMfl = '1';
070900050604          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MINFIXLEN';
071000050604        EndIf;
071100050604
071200050604        If  RJRN0100.RsoMo1 = '1';
071300050604          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MAXOPT1';
071400050604        EndIf;
071500050604
071600050604        If  RJRN0100.RsoMo2 = '1';
071700050604          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MAXOPT2';
071800050604        EndIf;
071900050604
072000050604        HdrRcd.RcvOpt = %TrimL( HdrRcd.RcvOpt );
072100050604
072200050603        Except  Header;
072300050603        Except  LstHdr;
072400050603        Except  DtlHdr;
072500050603
072600050603      /End-Free
072700050603
072800050603     P WrtLstHdr       E
072900050603     **-- Write detail header:  ----------------------------------------------**
073000050603     P WrtDtlHdr       B
073100050603     D                 Pi
073200050603     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
073300050603
073400050603      /Free
073500050603
073600050603        If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
073700050603
073800050603          Except  Header;
073900050603          Except  DtlHdr;
074000050603        EndIf;
074100050603
074200050603      /End-Free
074300050603
074400050603     P WrtDtlHdr       E
074500050602     **-- Write list trailer:  -----------------------------------------------**
074600050602     P WrtLstTrl       B
074700050602     D                 Pi
074800050602     D  PxTrlTxt                     32a   Const
074900050602
075000050602      /Free
075100050602
075200050602        TrlTxt = PxTrlTxt;
075300050602
075400050602        Except  LstTrl;
075500050602
075600050602      /End-Free
075700050602
075800050602     P WrtLstTrl       E
075900050528     **-- Send completion message:  ------------------------------------------**
076000050528     P SndCmpMsg       B
076100050528     D                 Pi            10i 0
076200050528     D  PxMsgDta                    512a   Const  Varying
076300050528     **
076400050528     D MsgKey          s              4a
076500050528
076600050528      /Free
076700050528
076800050528        SndPgmMsg( 'CPF9897'
076900050528                 : 'QCPFMSG   *LIBL'
077000050528                 : PxMsgDta
077100050528                 : %Len( PxMsgDta )
077200050528                 : '*COMP'
077300050528                 : '*PGMBDY'
077400050528                 : 1
077500050528                 : MsgKey
077600050528                 : ERRC0100
077700050528                 );
077800050528
077900050528        If  ERRC0100.BytAvl > *Zero;
078000050528          Return  -1;
078100050528
078200050528        Else;
078300050528          Return  0;
078400050528
078500050528        EndIf;
078600050528
078700050528      /End-Free
078800050528
078900050528     **
079000050528     P SndCmpMsg       E
079100050602     **-- Get system name:  --------------------------------------------------**
079200050602     P GetSysNam       B
079300050602     D                 Pi             8a   Varying
079400050602     **
079500050602     **-- Local variables:
079600050602     D Idx             s             10i 0
079700050602     D SysNam          s              8a   Varying
079800050602     **
079900050602     D RtnAtrLen       s             10i 0
080000050602     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
080100050602     D NetAtr          s             10a   Dim( 1 )
080200050602     **
080300050602     D RtnVar          Ds                  Qualified
080400050602     D  RtnVarNbr                    10i 0
080500050602     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
080600050602     D  RtnVarDta                  1024a
080700050602
080800050602     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
080900050602     D  AtrNam                       10a
081000050602     D  DtaTyp                        1a
081100050602     D  InfSts                        1a
081200050602     D  AtrLen                       10i 0
081300050602     D  Atr                        1008a
081400050602
081500050602      /Free
081600050602
081700050602        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
081800050602
081900050602        NetAtr(1) = 'SYSNAME';
082000050602
082100050602        RtvNetAtr( RtnVar
082200050602                 : RtnAtrLen
082300050602                 : NetAtrNbr
082400050602                 : NetAtr
082500050602                 : ERRC0100
082600050602                 );
082700050602
082800050602        If  ERRC0100.BytAvl > *Zero;
082900050602          SysNam = '';
083000050602
083100050602        Else;
083200050602          For  Idx = 1  to RtnVar.RtnVarNbr;
083300050602
083400050602            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
083500050602
083600050602            If  RtnAtr.AtrNam = 'SYSNAME';
083700050602              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
083800050602            EndIf;
083900050602
084000050602          EndFor;
084100050602        EndIf;
084200050602
084300050602        Return  SysNam;
084400050602
084500050602      /End-Free
084600050602
084700050602     P GetSysNam       E
