000100041212     **
000200050210     **  Program . . : CBX9302
000300041212     **  Description : Print programs adopting special authorities - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Program description:
000800050122     **    This program will produce a list of all objects adopting the
000900050122     **    special authorities specified.
001000041212     **
001100041212     **
001200041212     **  Programmer's notes:
001300050226     **    Although Structured Query Language (SQL) packages also are
001400050122     **    capable of adopting special and private authorities, currently
001500050122     **    no programmatical method exists to identify object of type
001600050122     **    *SQLPKG that adopts authority:
001700050122     **
001800041218     **    http://www-912.ibm.com/s_dir/slkbase.nsf/1ac66549a21402188625680b0002037e/
001900041218     **      9fe5eef9a3d096c7862565c2007cef34?OpenDocument
002000041218     **
002100041212     **
002200041212     **  Authority and security restrictions:
002300041212     **    To successfully run this program *ALLOBJ special authority is
002400041212     **    necessary.  The required authority can be obtained by means of
002500041212     **    adopted authority:
002600041212     **
002700041212     **    -  Change the program object's USRPRF attribute to *OWNER using
002800041212     **       the CHGPGM command.
002900041212     **
003000041212     **    -  Change the program object owner to QSECOFR using the CHGOBJOWN
003100041212     **       command.
003200041212     **
003300041212     **    If you successfully follow the compile and setup instructions below,
003400041212     **    the program will be capable of performing the necessary operations.
003500041212     **
003600041212     **
003700041212     **  Compile and setup instructions:
003800050210     **    CrtRpgMod   Module( CBX9302 )
003900041212     **                DbgView( *NONE )
004000041212     **                Aut( *USE )
004100041212     **
004200050210     **    CrtPgm      Pgm( CBX9302 )
004300050210     **                Module( CBX9302 )
004400041212     **                ActGrp( *NEW )
004500041212     **                UsrPrf( *OWNER )
004600041212     **                Aut( *USE )
004700041212     **
004800050210     **    ChgObjOwn   Obj( CBX9302 )
004900041212     **                ObjType( *PGM )
005000041212     **                NewOwn( QSECOFR )
005100041212     **
005200041212     **
005300041212     **-- Control specification:  --------------------------------------------**
005400041212     H Option( *SrcStmt: *NoDebugIo )
005500041212     **-- Printer file:
005600041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
005700041212     **-- Printer file information:
005800050212     D PrtLinInf       Ds                  Qualified
005900050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
006000050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
006100050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
006200041212     **-- System information:
006300041212     D                SDs
006400041212     D  PsPgmNam         *Proc
006500041211     **-- API error data structure:
006600041211     D ERRC0100        Ds                  Qualified
006700041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
006800041211     D  BytAvl                       10i 0
006900041211     D  MsgId                         7a
007000990921     D                                1a
007100041211     D  MsgDta                      128a
007200050212     **-- Global constants:
007300050212     D ADP_PRV_INVLVL  c                   1
007400050306     D NBR_KEY         c                   2
007500050212     D KEY_OFS         c                   80
007600050212     D SIZ_NLS_INF     c                   290
007700050212     D JOB_RUN         c                   0
007800050212     D CHAR_NLS        c                   4
007900050212     D ASCEND          c                   1
008000050212     D DESCEND         c                   2
008100050212     **
008200050212     D SRT_PUT         c                   1
008300050212     D SRT_END         c                   2
008400050212     D SRT_GET         c                   3
008500050212     D SRT_CNL         c                   4
008600041212     **-- Global variables:
008700041212     D LstTim          s              6s 0
008800041212     D SpcAutL         s             88a   Varying
008900050122     D ObjItr          s             10i 0
009000041211     D Idx             s             10i 0
009100041212     D AutFlg          s              1a
009200050212     D SrtAct          s               n
009300050122     **
009400050122     D SpcAut          Ds                  Qualified
009500050122     D  NbrAut                        5i 0
009600050122     D  AutVal                       10a   Dim( 8 )
009700050122     **-- List record:
009800050122     D LstRcd          Ds                  Qualified
009900050122     D  ObjNam                       10a
010000050122     D  LibNam                       10a
010100050122     D  PgmTyp                       10a
010200050122     D  ObjAtr                       10a
010300050122     D  ObjTxt                       50a
010400050313     D  AdpPrf                       10a
010500050313     D  CrtPrf                       10a
010600050212     **-- List API parameters:
010700050212     D LstApi          Ds                  Qualified  Inz
010800050212     D  RtnRcdNbr                    10i 0
010900050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
011000050306     D  KeyFld                       10i 0 Dim( 3 )
011100050212     D  ObjTyp                       10a
011200040426     **-- Object information:
011300041211     D ObjInf          Ds          4096    Qualified
011400041212     D  ObjNam                       10a
011500041212     D  ObjLib                       10a
011600041212     D  ObjTyp                       10a
011700041211     D  InfSts                        1a
011800040426     D                                1a
011900041211     D  FldNbrRtn                    10i 0
012000041211     D  Data                               Like( KeyInf )
012100040426     **-- Key information:
012200041211     D KeyInf          Ds                  Qualified  Based( pKeyInf )
012300041211     D  FldInfLen                    10i 0
012400041211     D  KeyFld                       10i 0
012500041211     D  DtaTyp                        1a
012600041211     D                                3a
012700041211     D  DtaLen                       10i 0
012800041211     D  Data                        256a
012900040426     **-- List information:
013000041211     D LstInf          Ds                  Qualified
013100041211     D  RcdNbrTot                    10i 0
013200041211     D  RcdNbrRtn                    10i 0
013300041211     D  Handle                        4a
013400041211     D  RcdLen                       10i 0
013500041211     D  InfSts                        1a
013600041211     D  Dts                          13a
013700041211     D  LstSts                        1a
013800040426     D                                1a
013900041211     D  InfLen                       10i 0
014000041211     D  Rcd1                         10i 0
014100040426     D                               40a
014200040426     **-- Sort information:
014300041211     D SrtInf          Ds                  Qualified
014400041211     D  NbrKeys                      10i 0 Inz( 0 )
014500041211     D  SrtInf                       12a   Dim( 10 )
014600041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
014700041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
014800041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
014900041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
015000041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
015100040426     **-- Authority control:
015200041211     D AutCtl          Ds                  Qualified
015300041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
015400041211     D  CalLvl                       10i 0 Inz( 0 )
015500041211     D  DplObjAut                    10i 0 Inz( 0 )
015600041211     D  NbrObjAut                    10i 0 Inz( 0 )
015700041211     D  DplLibAut                    10i 0 Inz( 0 )
015800041211     D  NbrLibAut                    10i 0 Inz( 0 )
015900040426     D                               10i 0 Inz( 0 )
016000041211     D  ObjAut                       10a   Dim( 10 )
016100041211     D  LibAut                       10a   Dim( 10 )
016200040426     **-- Selection control:
016300041211     D SltCtl          Ds
016400041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
016500041211     D  SltOmt                       10i 0 Inz( 0 )
016600041211     D  DplSts                       10i 0 Inz( 20 )
016700041211     D  NbrSts                       10i 0 Inz( 1 )
016800040426     D                               10i 0 Inz( 0 )
016900041211     D  Status                        1a   Inz( '*' )
017000040426     **-- Object information key fields:
017100041211     D KEY0200         Ds                  Qualified
017200041211     D  InfSts                        1a
017300041211     D  ExtObjAtr                    10a
017400041211     D  TxtDsc                       50a
017500041211     D  UsrDfnAtr                    10a
017600041211     D  OrdLibL                      10i 0
017700040426     D                                5a
017800041211     **
017900041211     D ObjOwn          s             10a
018000050313     D CrtPrf          s             10a
018100050122     **-- Sort API parameters:
018200050212     D SrtApi          Ds                  Qualified  Inz
018300050212     D  DtaBufLen                    10i 0
018400050212     D  DtaRtnLen                    10i 0
018500050212     D  Omit                         16a
018600050122     **
018700050122     D RqsCtlBlk       Ds                  Qualified  Inz
018800050122     D  BlkLen                       10i 0
018900050122     D  RqsTyp                       10i 0 Inz( 8 )
019000050122     D                               10i 0
019100050122     D  Options                      10i 0
019200050122     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
019300050122     D  RcdCnt                       10i 0
019400050122     D  KeyOfs                       10i 0 Inz( KEY_OFS )
019500050122     D  KeyNbr                       10i 0
019600050122     D  NlsOfs                       10i 0
019700050122     D  InpFlsOfs                    10i 0
019800050122     D  InpFlsNbr                    10i 0
019900050122     D  OutFlsOfs                    10i 0
020000050122     D  OutFlsNbr                    10i 0
020100050122     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
020200050122     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
020300050122     D  InpFenLen                    10i 0
020400050122     D  OutFenLen                    10i 0
020500050122     D  NlbMapOfs                    10i 0
020600050122     D  VlrAciOfs                    10i 0
020700050122     D                               10i 0
020800050122     **
020900050122     D SrtKeyInf                     20a   Dim( NBR_KEY )
021000050122     **
021100050122     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
021200050122     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
021300050122     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
021400050122     D SrtSeqTbl                    256a
021500050122     **
021600050122     D SrtKeyInfDs     Ds                  Qualified  Inz
021700050122     D  KeyStrPos                    10i 0
021800050122     D  KeySize                      10i 0
021900050122     D  KeyDtaTyp                    10i 0
022000050122     D  KeyOrder                     10i 0
022100050122     D  KeyOrdPos                    10i 0
022200050122     **
022300050122     D RqsCtlBlkIo     Ds                  Qualified
022400050122     D  RqsTyp                       10i 0 Inz
022500050122     D                               10i 0 Inz
022600050122     D  RcdLen                       10i 0 Inz
022700050122     D  RcdCnt                       10i 0 Inz
022800050122     **
022900050122     D DtaBufInf       Ds                  Qualified
023000050122     D  RcdPrc                       10i 0
023100050122     D  RcdAvl                       10i 0
023200050122     D                                8a
023300041211     **-- Open list of objects:
023400040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
023500040426     D  LoRcvVar                  65535a          Options( *VarSize )
023600040426     D  LoRcvVarLen                  10i 0 Const
023700040426     D  LoLstInf                     80a
023800040426     D  LoNbrRcdRtn                  10i 0 Const
023900040426     D  LoSrtInf                   1024a   Const  Options( *VarSize )
024000040426     D  LoObjNam_q                   20a   Const
024100040426     D  LoObjTyp                     10a   Const
024200040426     D  LoAutCtl                   1024a   Const  Options( *VarSize )
024300040426     D  LoSltCtl                   1024a   Const  Options( *VarSize )
024400041211     D  LoNbrKeyRtn                  10i 0 Const
024500041211     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
024600040426     D  LoError                    1024a          Options( *VarSize )
024700020531     **
024800040426     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
024900040426     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
025000040426     **
025100040426     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
025200041212     **-- Get list entry:
025300020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
025400020531     D  GlRcvVar                  65535a          Options( *VarSize )
025500020531     D  GlRcvVarLen                  10i 0 Const
025600020531     D  GlHandle                      4a   Const
025700020531     D  GlLstInf                     80a
025800020531     D  GlNbrRcdRtn                  10i 0 Const
025900020531     D  GlRtnRcdNbr                  10i 0 Const
026000020531     D  GlError                    1024a          Options( *VarSize )
026100041212     **-- Close list:
026200020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
026300020531     D  ClHandle                      4a   Const
026400020531     D  ClError                    1024a          Options( *VarSize )
026500041212     **-- Retrieve program information:
026600041211     D RtvPgmInf       Pr                  ExtPgm( 'QCLRPGMI' )
026700041211     D  PiRcvVar                  32767a          Options( *VarSize )
026800041211     D  PiRcvVarLen                  10i 0 Const
026900041211     D  PiFmtNam                      8a   Const
027000041211     D  PiPgmNamQ                    20a   Const
027100041211     D  PiError                   32767a          Options( *VarSize )
027200041212     **-- Retrieve service program information:
027300041211     D RtvSrvPgmI      Pr                  ExtPgm( 'QBNRSPGM' )
027400041211     D  SiRcvVar                  32767a          Options( *VarSize )
027500041211     D  SiRcvVarLen                  10i 0 Const
027600041211     D  SiFmtNam                      8a   Const
027700041211     D  SiPgmNamQ                    20a   Const
027800041211     D  SiError                   32767a          Options( *VarSize )
027900041212     **-- Check user special authority
028000041212     D ChkUsrSpcAut    Pr                  ExtPgm( 'QSYCUSRS' )
028100041212     D  CsAutInf                      1a
028200041212     D  CsUsrPrf                     10a   Const
028300041212     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
028400041212     D  CsNbrAut                     10i 0 Const
028500041212     D  CsCalLvl                     10i 0 Const
028600041212     D  CsError                   32767a          Options( *VarSize )
028700050122     **-- Initialize sort:
028800050122     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
028900050122     D  IsRqsCtlBlk                  80a   Const  Options( *VarSize )
029000050122     D  IsInpDtaBuf               65535a   Const  Options( *VarSize )
029100050122     D  IsOutDtaBuf               65535a          Options( *VarSize )
029200050122     D  IsOutDtaLen                  10i 0 Const
029300050122     D  IsRtnDtaLen                  10i 0
029400050122     D  IsError                   32767a          Options( *VarSize )
029500050122     D  IsRtnRcdFb                  144a          Options( *VarSize: *NoPass )
029600050122     D  IsRtnRcdFbLen                10i 0 Const  Options( *NoPass )
029700050122     **-- Sort input/output:
029800050122     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
029900050122     D  IoRqsCtlBlk                  16a   Const
030000050122     D  IoInpDtaBuf               65535a   Const  Options( *VarSize )
030100050122     D  IoOutDtaBuf               65535a          Options( *VarSize )
030200050122     D  IoOutDtaLen                  10i 0 Const
030300050122     D  IoOutDtaInf                  16a
030400050122     D  IoError                   32767a          Options( *VarSize )
030500050122     D  IoRtnRcdFb                  144a          Options( *VarSize: *NoPass )
030600050122     D  IoRtnRcdFbLen                10i 0 Const  Options( *NoPass )
030700041212
030800041212     **-- Retrieve program user profile attribute - by type:
030900041212     D RtvPgmUpaTyp    Pr            10a
031000041212     D  PxPgmNam                     10a   Const
031100041212     D  PxPgmLib                     10a   Const
031200041212     D  PxPgmTyp                     10a   Const
031300041212     **-- Retrieve program user profile attribute:
031400041212     D RtvPgmUpa       Pr            10a
031500041218     D  PxPgmNam                     10a   Const
031600041218     D  PxPgmLib                     10a   Const
031700041212     **-- Retrieve service program user profile attribute:
031800041212     D RtvSrvPgmUpa    Pr            10a
031900041218     D  PxPgmNam                     10a   Const
032000041218     D  PxPgmLib                     10a   Const
032100041216     **-- Write detail line:
032200041216     D WrtDtlLin       Pr
032300041212     **-- Write list header:
032400041212     D WrtLstHdr       Pr
032500041212     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
032600041216     **-- Write list trailer:
032700041216     D WrtLstTrl       Pr
032800041212
032900050210     D CBX9302         Pr
033000041212     D  PxPgmLib                     10a
033100041212     D  PxSpcAut                           LikeDs( SpcAut )
033200050122     D  PxSrtOrd                     10a
033300050306     D  PxSysObj                      4a
033400041212     **
033500050210     D CBX9302         Pi
033600041212     D  PxPgmLib                     10a
033700041212     D  PxSpcAut                           LikeDs( SpcAut )
033800050122     D  PxSrtOrd                     10a
033900050306     D  PxSysObj                      4a
034000041211
034100041211      /Free
034200041211
034300050212        LstApi.KeyFld(1) = 200;
034400050212        LstApi.KeyFld(2) = 302;
034500050306        LstApi.KeyFld(3) = 405;
034600041211
034700041211        SrtInf.NbrKeys      = 0;
034800041211        SrtInf.KeyFldOfs(1) = 0;
034900041211        SrtInf.KeyFldLen(1) = 0;
035000041211        SrtInf.KeyFldTyp(1) = 0;
035100041211        SrtInf.SrtOrd(1)    = '1';
035200041211        SrtInf.Rsv(1)       = x'00';
035300041211
035400050122        For  ObjItr = 1  To 2;
035500041211
035600041211          Select;
035700050122          When  ObjItr = 1;
035800050212            LstApi.ObjTyp = '*PGM';
035900041211
036000050122          When  ObjItr = 2;
036100050212            LstApi.ObjTyp = '*SRVPGM';
036200041211          EndSl;
036300041211
036400050212          LstApi.RtnRcdNbr = 1;
036500041211
036600041211          LstObjs( ObjInf
036700041211                 : %Size( ObjInf )
036800041211                 : LstInf
036900041211                 : 1
037000041211                 : SrtInf
037100041212                 : '*ALL      ' + PxPgmLib
037200050212                 : LstApi.ObjTyp
037300041211                 : AutCtl
037400041211                 : SltCtl
037500050212                 : LstApi.NbrKeyRtn
037600050212                 : LstApi.KeyFld
037700041211                 : ERRC0100
037800041211                 );
037900041211
038000041211          If  ERRC0100.BytAvl = *Zero;
038100041211
038200041211            DoW  LstInf.LstSts <> '2'  Or
038300050212                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
038400041211
038500041211              ExSr  GetKeyDta;
038600050306
038700050313              If    PxSysObj = '*YES'  Or  CrtPrf <> '*IBM';
038800050306                ExSr  ChkPgmAdp;
038900050306              EndIf;
039000041211
039100050212              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
039200041211
039300041211              GetLstEnt( ObjInf
039400041211                       : %Size( ObjInf )
039500041211                       : LstInf.Handle
039600041211                       : LstInf
039700041211                       : 1
039800050212                       : LstApi.RtnRcdNbr
039900041211                       : ERRC0100
040000041211                       );
040100050122
040200050122              If  ERRC0100.BytAvl > *Zero;
040300050122                Leave;
040400050122              EndIf;
040500041211            EndDo;
040600041211
040700041211            CloseLst( LstInf.Handle: ERRC0100 );
040800041211
040900041211          EndIf;
041000041211        EndFor;
041100050122
041200050122        ExSr  WrtSrtLst;
041300041216
041400041211        *InLr = *On;
041500041211
041600041211        Return;
041700041211
041800041211        BegSr  GetKeyDta;
041900041211
042000041211          pKeyInf = %Addr( ObjInf.Data );
042100041211
042200041211          For  Idx = 1  To ObjInf.FldNbrRtn;
042300041211
042400041211            Select;
042500041211            When  KeyInf.KeyFld = 200;
042600041211
042700041211              KEY0200 = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
042800041211
042900041211            When  KeyInf.KeyFld = 302;
043000041211
043100041211              ObjOwn = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
043200050306
043300050306            When  KeyInf.KeyFld = 405;
043400050306
043500050313              CrtPrf = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
043600041211            EndSl;
043700041211
043800041211            If  Idx < ObjInf.FldNbrRtn;
043900041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
044000041211            EndIf;
044100041211          EndFor;
044200041211
044300041211        EndSr;
044400041211
044500041212        BegSr  ChkPgmAdp;
044600041212
044700041212          If  RtvPgmUpaTyp( ObjInf.ObjNam
044800041212                          : ObjInf.ObjLib
044900041212                          : ObjInf.ObjTyp
045000041212                          ) = '*OWNER';
045100041212
045200041212            ChkUsrSpcAut( AutFlg
045300041212                        : ObjOwn
045400041212                        : PxSpcAut.AutVal
045500041212                        : PxSpcAut.NbrAut
045600041212                        : ADP_PRV_INVLVL
045700041212                        : ERRC0100
045800041212                        );
045900041212
046000041212            If  ERRC0100.BytAvl = *Zero;
046100041212
046200041212              If  AutFlg = 'Y';
046300050122
046400050122                ExSr AddSrtLst;
046500041212              EndIf;
046600041212            EndIf;
046700041212          EndIf;
046800041212
046900041212        EndSr;
047000041212
047100050122        BegSr  InzSrtLst;
047200050122
047300050122          SrtKeyInfDs.KeySize   = 10;
047400050122          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
047500050122          SrtKeyInfDs.KeyOrder  = ASCEND;
047600050122
047700050122          Select;
047800050122          When  PxSrtOrd = '*LIBOBJ';
047900050122            SrtKeyInfDs.KeyStrPos = 11;
048000050122
048100050122          When  PxSrtOrd = '*OBJ   ';
048200050122            SrtKeyInfDs.KeyStrPos = 1;
048300050122
048400050122          When  PxSrtOrd = '*ADPPRF';
048500050122            SrtKeyInfDs.KeyStrPos = 91;
048600050122
048700050313          When  PxSrtOrd = '*CRTPRF';
048800050313            SrtKeyInfDs.KeyStrPos = 101;
048900050313
049000050122          When  PxSrtOrd = '*TYPOBJ';
049100050122            SrtKeyInfDs.KeyStrPos = 21;
049200050122          EndSl;
049300050122
049400050122          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;
049500050122
049600050122          Select;
049700050122          When  PxSrtOrd = '*LIBOBJ';
049800050122            SrtKeyInfDs.KeyStrPos = 1;
049900050122
050000050122          When  PxSrtOrd = '*OBJ   ';
050100050122            SrtKeyInfDs.KeyStrPos = 11;
050200050122
050300050122          When  PxSrtOrd = '*ADPPRF';
050400050122            SrtKeyInfDs.KeyStrPos = 1;
050500050122
050600050313          When  PxSrtOrd = '*CRTPRF';
050700050313            SrtKeyInfDs.KeyStrPos = 1;
050800050313
050900050122          When  PxSrtOrd = '*TYPOBJ';
051000050122            SrtKeyInfDs.KeyStrPos = 1;
051100050122          EndSl;
051200050122
051300050122          RqsCtlBlk.SrtKeyInf(2) = SrtKeyInfDs;
051400050122
051500050122          RqsCtlBlk.NlsOfs = KEY_OFS +
051600050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );
051700050122
051800050122          RqsCtlBlk.BlkLen = KEY_OFS +
051900050122                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
052000050122                             SIZ_NLS_INF;
052100050122
052200050122          RqsCtlBlk.KeyNbr = NBR_KEY;
052300050122
052400050122          InzSort( RqsCtlBlk
052500050212                 : SrtApi.Omit
052600050212                 : SrtApi.Omit
052700050212                 : SrtApi.DtaBufLen
052800050212                 : SrtApi.DtaRtnLen
052900050122                 : ERRC0100
053000050122                 );
053100050122
053200050122          If  ERRC0100.BytAvl = *Zero;
053300050212            SrtAct = *On;
053400050122          EndIf;
053500050122
053600050122        EndSr;
053700050122
053800050122        BegSr  AddSrtLst;
053900050122
054000050212          If  SrtAct = *Off;
054100050122            ExSr  InzSrtLst;
054200050122          EndIf;
054300050122
054400050122          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
054500050122          RqsCtlBlkIo.RcdCnt = 1;
054600050122          RqsCtlBlkIo.RqsTyp = SRT_PUT;
054700050122
054800050122          LstRcd.ObjNam = ObjInf.ObjNam;
054900050122          LstRcd.LibNam = ObjInf.ObjLib;
055000050122          LstRcd.PgmTyp = ObjInf.ObjTyp;
055100050122          LstRcd.ObjAtr = KEY0200.ExtObjAtr;
055200050122          LstRcd.ObjTxt = KEY0200.TxtDsc;
055300050313          LstRcd.AdpPrf = ObjOwn;
055400050313          LstRcd.CrtPrf = CrtPrf;
055500050122
055600050122          SortIo( RqsCtlBlkIo
055700050122                : LstRcd
055800050212                : SrtApi.Omit
055900050212                : SrtApi.DtaBufLen
056000050122                : DtaBufInf
056100050122                : ERRC0100
056200050122                );
056300050122
056400050122        EndSr;
056500050122
056600050122        BegSr  WrtSrtLst;
056700050122
056800050122          ExSr  EndSrtLst;
056900050122
057000050319          If  DtaBufInf.RcdAvl > *Zero;
057100050319
057200050319            RqsCtlBlkIo.RqsTyp = SRT_GET;
057300050319
057400050319            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;
057500050319
057600050319            SortIo( RqsCtlBlkIo
057700050319                  : SrtApi.Omit
057800050319                  : LstRcd
057900050319                  : SrtApi.DtaBufLen
058000050319                  : DtaBufInf
058100050319                  : ERRC0100
058200050319                  );
058300050319
058400050319            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;
058500050319
058600050319              WrtDtlLin();
058700050319
058800050319              SortIo( RqsCtlBlkIo
058900050319                    : SrtApi.Omit
059000050319                    : LstRcd
059100050319                    : SrtApi.DtaBufLen
059200050319                    : DtaBufInf
059300050319                    : ERRC0100
059400050319                    );
059500050319
059600050319            EndDo;
059700050319          EndIf;
059800050122
059900050122          WrtLstTrl();
060000050122
060100050122        EndSr;
060200050122
060300050122        BegSr  EndSrtLst;
060400050122
060500050122          RqsCtlBlkIo.RqsTyp = SRT_END;
060600050122
060700050122          SortIo( RqsCtlBlkIo
060800050212                : SrtApi.Omit
060900050212                : SrtApi.Omit
061000050212                : SrtApi.DtaBufLen
061100050122                : DtaBufInf
061200050122                : ERRC0100
061300050122                );
061400050122
061500050122        EndSr;
061600050122
061700041212        BegSr  *InzSr;
061800041212
061900041212          LstTim = %Int( %Char( %Time(): *ISO0));
062000041212
062100041212          SpcAutL = PxSpcAut.AutVal(1);
062200041212          For  Idx = 2  To PxSpcAut.NbrAut;
062300041212
062400041212            SpcAutL = SpcAutL + ' ' + PxSpcAut.AutVal(Idx);
062500041212          EndFor;
062600041212
062700041212          WrtLstHdr();
062800041212
062900041212        EndSr;
063000041212
063100050122      /End-Free
063200050122
063300041212     **-- Printer file definition:  ------------------------------------------**
063400041212     OQSYSPRT   EF           Header         2  2
063500041212     O                       UDATE         Y      8
063600041212     O                       LstTim              18 '  :  :  '
063700041212     O                                           75 'Programs adopting special -
063800041212     O                                              authorities'
063900041212     O                                          107 'Program:'
064000041212     O                       PsPgmNam           118
064100041212     O                                          126 'Page:'
064200041212     O                       PAGE             +   1
064300041216     **
064400041212     OQSYSPRT   EF           LstHdr         1
064500041216     O                                           27 'Program library . . . . . -
064600041216     O                                              :'
064700041216     O                       PxPgmLib            39
064800041216     **
064900041212     OQSYSPRT   EF           LstHdr         2
065000041216     O                                           27 'Special authorities . . . -
065100041216     O                                              :'
065200041216     O                       SpcAutL            117
065300041216     **
065400041212     OQSYSPRT   EF           LstHdr         1
065500041212     O                                            6 'Object'
065600041212     O                                           19 'Library'
065700041216     O                                           28 'Type'
065800041216     O                                           45 'Attribute'
065900041216     O                                           52 'Text'
066000041216     O                                          114 'User profile'
066100050306     O                                          125 'Creator'
066200041216     **
066300041212     OQSYSPRT   EF           DtlLin         1
066400050122     O                       LstRcd.ObjNam       10
066500050122     O                       LstRcd.LibNam       22
066600050122     O                       LstRcd.PgmTyp       34
066700050122     O                       LstRcd.ObjAtr       46
066800050122     O                       LstRcd.ObjTxt       98
066900050313     O                       LstRcd.AdpPrf      112
067000050313     O                       LstRcd.CrtPrf      128
067100041212     **
067200050123     OQSYSPRT   EF           LstTrl         1
067300041212     O                                           30 '***  E N D  O F  L I S T  -
067400041212     O                                              ***'
067500041212     **-- Retrieve program user profile attribute - by type:  ----------------**
067600041212     P RtvPgmUpaTyp    B                   Export
067700041212     D                 Pi            10a
067800041212     D  PxPgmNam                     10a   Const
067900041212     D  PxPgmLib                     10a   Const
068000041212     D  PxPgmTyp                     10a   Const
068100041212     **
068200041212
068300041212      /Free
068400041212
068500041212        Select;
068600041212        When  PxPgmTyp = '*PGM';
068700041212
068800041212          Return  RtvPgmUpa( PxPgmNam: PxPgmLib );
068900041212
069000041212        When  PxPgmTyp = '*SRVPGM';
069100041212
069200041212          Return  RtvSrvPgmUpa( PxPgmNam: PxPgmLib );
069300041212
069400041212        Other;
069500041212          Return  *Blanks;
069600041212        EndSl;
069700041212
069800041212      /End-Free
069900041212
070000041212     P RtvPgmUpaTyp    E
070100041212     **-- Retrieve program user profile attribute:  --------------------------**
070200041212     P RtvPgmUpa       B                   Export
070300041211     D                 Pi            10a
070400041212     D  PxPgmNam                     10a   Const
070500041212     D  PxPgmLib                     10a   Const
070600041211     **
070700041211     D PGMI0100        Ds                  Qualified
070800041211     D  BytRtn                       10i 0
070900041211     D  BytAvl                       10i 0
071000041211     D  PgmNam                       10a
071100041211     D  PgmLib                       10a
071200041211     D  PgmOwn                       10a
071300041211     D  PgmAtr                       10a
071400041211     D  UsrPrf                        1a   Overlay( PGMI0100: 106 )
071500041211     D  UseAdpAut                     1a   Overlay( PGMI0100: 107 )
071600041211     D  LogCmd                        1a   Overlay( PGMI0100: 108 )
071700041211     D  AlwRtvSrc                     1a   Overlay( PGMI0100: 109 )
071800041212
071900041212      /Free
072000041212
072100041212        RtvPgmInf( PGMI0100
072200041212                 : %Size( PGMI0100 )
072300041212                 : 'PGMI0100'
072400041212                 : PxPgmNam + PxPgmLib
072500041212                 : ERRC0100
072600041212                 );
072700041212
072800041212        Select;
072900041212        When  ERRC0100.BytAvl > *Zero;
073000041212          Return  *Blanks;
073100041212
073200041212        When  PGMI0100.UsrPrf = 'U';
073300041212          Return  '*USER';
073400041212
073500041212        When  PGMI0100.UsrPrf = 'O';
073600041212          Return  '*OWNER';
073700041212
073800041212        Other;
073900041212          Return  *Blanks;
074000041212        EndSl;
074100041212
074200041212      /End-Free
074300041212
074400041212     P RtvPgmUpa       E
074500041212     **-- Retrieve service program user profile attribute:  ------------------**
074600041212     P RtvSrvPgmUpa    B                   Export
074700041211     D                 Pi            10a
074800041212     D  PxPgmNam                     10a   Const
074900041212     D  PxPgmLib                     10a   Const
075000041211     **
075100041211     D SPGI0100        Ds                  Qualified
075200041211     D  BytRtn                       10i 0
075300041211     D  BytAvl                       10i 0
075400041211     D  PgmNam                       10a
075500041211     D  PgmLib                       10a
075600041211     D  PgmOwn                       10a
075700041211     D  PgmAtr                       10a
075800041211     D  UsrPrf                        1a   Overlay( SPGI0100: 138 )
075900041211     D  TxtDsc                       50a   Overlay( SPGI0100: 157 )
076000041211     D  UseAdpAut                     1a   Overlay( SPGI0100: 213 )
076100041211     D  PgmStt                        1a   Overlay( SPGI0100: 307 )
076200041211     D  PgmDmn                        1a   Overlay( SPGI0100: 308 )
076300041212
076400041212      /Free
076500041212
076600041212        RtvSrvPgmI( SPGI0100
076700041212                  : %Size( SPGI0100 )
076800041212                  : 'SPGI0100'
076900041212                  : PxPgmNam + PxPgmLib
077000041212                  : ERRC0100
077100041212                  );
077200041212
077300041212        Select;
077400041212        When  ERRC0100.BytAvl > *Zero;
077500041212          Return  *Blanks;
077600041212
077700041212        When  SPGI0100.UsrPrf = 'U';
077800041212          Return  '*USER';
077900041212
078000041212        When  SPGI0100.UsrPrf = 'O';
078100041212          Return  '*OWNER';
078200041212
078300041212        Other;
078400041212          Return  *Blanks;
078500041212        EndSl;
078600041212
078700041212      /End-Free
078800041212
078900041212     P RtvSrvPgmUpa    E
079000041216     **-- Write detail line:  ------------------------------------------------**
079100041216     P WrtDtlLin       B
079200041212     D                 Pi
079300041212
079400041212      /Free
079500041212
079600041216        WrtLstHdr( 3 );
079700041212
079800041216        Except  DtlLin;
079900041212
080000041212      /End-Free
080100041212
080200041216     P WrtDtlLin       E
080300041212     **-- Write list header:  ------------------------------------------------**
080400041212     P WrtLstHdr       B
080500041212     D                 Pi
080600041212     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
080700041212
080800041212      /Free
080900041212
081000041212        If  %Parms = *Zero;
081100041212
081200041212          Except  Header;
081300041212          Except  LstHdr;
081400041212        Else;
081500041212
081600050212          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
081700041212
081800041212            Except  Header;
081900041212            Except  LstHdr;
082000041212          EndIf;
082100041212        EndIf;
082200041212
082300041212      /End-Free
082400041212
082500041212     P WrtLstHdr       E
082600041216     **-- Write list trailer:  -----------------------------------------------**
082700041216     P WrtLstTrl       B
082800041216     D                 Pi
082900041216
083000041216      /Free
083100041216
083200041216        Except  LstTrl;
083300041216
083400041216      /End-Free
083500041216
083600041216     P WrtLstTrl       E
