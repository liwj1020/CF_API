000100050602     **
000200051001     **  Program . . : CBX947
000300050901     **  Description : Check PTF status - CPP
000400050602     **  Author  . . : Carsten Flensburg
000500050602     **
000600050602     **
000700050602     **  Compile and setup instructions:
000800051001     **    CrtRpgMod   Module( CBX947 )
000900050602     **                DbgView( *LIST )
001000050602     **
001100051001     **    CrtPgm      Pgm( CBX947 )
001200051001     **                Module( CBX947 )
001300051027     **                BndSrvPgm( QPZLSTFX )
001400050602     **                ActGrp( *NEW )
001500050602     **
001600050602     **
001700050602     **-- Control specification:  --------------------------------------------**
001800051015     H Option( *SrcStmt )  BndDir( 'QC2LE' )
001900050901
002000050527     **-- API error information:
002100050527     D ERRC0100        Ds                  Qualified
002200050527     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
002300050527     D  BytAvl                       10i 0
002400050527     D  MsgId                         7a
002500050527     D                                1a
002600050527     D  MsgDta                      256a
002700051015     **-- system function error ID:
002800051015     D SysError        s              7a   Import( '_EXCP_MSGID' )
002900051015
003000050527     **-- Global constants:
003100050901     D USRSPC_Q        c                   'LSTPTFS   QTEMP'
003200050901     D LST_RCDS        c                   1024
003300050901     D PRD_BASE        c                   '0000'
003400050527     **-- Global variables:
003500050901     D IdxPrd          s             10u 0
003600050901     D IdxPtf          s             10u 0
003700051017     D PtfStsTxt       s             32a   Varying
003800051017     D ChkSavF         s             10a   Inz
003900051017     D ChkOnOrd        s             10a   Inz
004000051017     D ChkCvrOnl       s             10a   Inz
004100051017     D ChkNotApy       s             10a   Inz
004200051017     D ChkActRqd       s             10a   Inz
004300051017     **
004400051017     D PtfSts          Ds                  Qualified
004500051017     D  NbrSts                        5i 0
004600051017     D  StsVal                       10a   Dim( 5 )
004700050901
004800050901     **-- API header information:
004900050901     D HdrInf          Ds                  Qualified  Based( pHdrInf )
005000050901     D  UsrSpcNamSp                  10a
005100050901     D  UsrSpcLibSp                  10a
005200051015     D  CurIplSrc                     1a
005300051015     D  CurSvrIplSrc                  1a
005400051015     D  HpvSts                        1a
005500050901     **-- User space generic header:
005600050901     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
005700050901     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
005800050901     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
005900050901     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
006000050901     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
006100050901     **-- User space pointers:
006200050901     D pUsrSpc         s               *   Inz( *Null )
006300050901     D pHdrInf         s               *   Inz( *Null )
006400050901     D pLstEnt         s               *   Inz( *Null )
006500050901
006600050901     **-- Product information:
006700050901     D PRDS0200        Ds                  Qualified  Based( pPRDS0200 )
006800050901     D  PrdId                         7a
006900050901     D  PrdOpt                        5a
007000050901     D  RlsLvl                        6a
007100050901     D                                2a
007200050901     D  DscMsgId                      7a
007300050901     D  DscObjNam                    10a
007400050901     D  DscObjLib                    10a
007500050901     D  InsFlg                        1a
007600050901     D  SptFlg                        1a
007700050901     D  RegTyp                        2a
007800050901     D  RegVal                       14a
007900050901     D  DscTxt                      132a
008000050901     **-- Input information:
008100050901     D InpInf          Ds                  Qualified
008200050901     D  NbrRcdRtn                    10i 0 Inz( LST_RCDS )
008300050901     D  NbrPrdSlt                    10a   Inz( '*ALL' )
008400090715     D  InzPnlView                    1a   Inz( '2' )
008500050901     D  AlwExit                       1a   Inz( '1' )
008600050901     D  PrdOptDsp                    10a   Inz( '*BASE' )
008700050901     D  PrdOpt                       10a   Inz( '*INSTLD' )
008800050901     D  LstRcd                       10i 0 Inz( 0 )
008900050901     **-- Input list:
009000050901     D InpLst          Ds                  Qualified
009100050901     D  PrdId                         7a
009200050901     D  PrdOpt                        5a
009300050901     D  RlsLvl                        6a
009400050901     **-- Output information:
009500050901     D OutInf          Ds                  Qualified
009600050901     D  RcdSiz                       10i 0
009700050901     D  RcdAvl                       10i 0
009800050901     D  Action                       10i 0
009900050901
010000050901     **-- PTF product information
010100050901     D PtfPrdInf       Ds                  Qualified
010200050901     D  PrdId                         7a
010300050901     D  Release                       6a
010400050901     D  PrdOpt                        4a
010500050901     D  LodId                        10a
010600050911     D  IncSpsPtf                     1a   Inz( '1' )
010700050901     D                               22a   Inz( *Allx'00' )
010800050527     **-- PTF list entry:
010900050901     D PTFL0100        Ds                  Qualified  Based( pLstEnt )
011000050527     D  PtfId                         7a
011100050527     D  RelLvlPtf                     6a
011200050527     D  PrdOptPtf                     4a
011300050527     D  PrdLodPtf                     4a
011400050527     D  LodSts                        1a
011500050527     D  SvfSts                        1a
011600050527     D  CvrSts                        1a
011700050527     D  OrdSts                        1a
011800050527     D  IplAct                        1a
011900050527     D  ActPnd                        1a
012000050527     D  ActReq                        1a
012100050527     D  IplReq                        1a
012200050527     D  PtfRls                        1a
012300050527     D  MinLvl                        2a
012400050527     D  MaxLvl                        2a
012500050527     D  StsDts                       13a
012600050527     D   StsDat                       7a   Overlay( StsDts: 1 )
012700050527     D   StsTim                       6a   Overlay( StsDts: 8 )
012800050527     D  SpsPtfId                      7a
012900051015     D  SvrIplReq                     1a
013000051015     D  CrtDts                       13a
013100051015     D   CrtDat                       7a   Overlay( CrtDts: 1 )
013200051015     D   CrtTim                       6a   Overlay( CrtDts: 8 )
013300050901
013400050527     **-- Create user space:
013500021210     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
013600050527     D  SpcNamQ                      20a   Const
013700050527     D  ExtAtr                       10a   Const
013800050527     D  InzSiz                       10i 0 Const
013900050527     D  InzVal                        1a   Const
014000050527     D  PubAut                       10a   Const
014100050527     D  Text                         50a   Const
014200050527     **
014300050527     D  Replace                      10a   Const Options( *NoPass )
014400050527     D  Error                     32767a         Options( *NoPass: *VarSize )
014500050527     **
014600050527     D  Domain                       10a   Const Options( *NoPass )
014700050527     **-- Delete user space:
014800021210     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
014900050527     D  SpcNamQ                      20a   Const
015000050527     D  Error                     32767a         Options( *VarSize )
015100050527     **-- Retrieve pointer to user space:
015200021210     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
015300050527     D  SpcNamQ                      20a   Const
015400050527     D  Pointer                        *
015500050527     D  Error                     32767a         Options( *NoPass: *VarSize )
015600050901     **-- Select products:
015700050901     D SltPrds         Pr                  ExtPgm( 'QSZSLTPR' )
015800050901     D  OutLst                    32767a          Options( *VarSize )
015900050901     D  InpInf                       40a   Const
016000050901     D  FmtNam                        8a   Const
016100050901     D  InpLst                       18a   Const  Dim( 1024 )
016200050901     D                                            Options( *VarSize )
016300050901     D  OutInf                    32767a          Options( *VarSize )
016400050901     D  Error                     32767a          Options( *VarSize )
016500050527     **-- List PTFs:
016600021210     D LstPtfs         Pr                  ExtProc( 'QpzListPTF' )
016700050527     D  SpcNamQ                      20a   Const
016800050527     D  PrdId                        50a   Const
016900050527     D  FmtNam                        8a   Const
017000050527     D  Error                     32767a         Options( *VarSize )
017100050527     **-- Send program message:
017200021210     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
017300050527     D  MsgId                         7a   Const
017400050527     D  MsgFq                        20a   Const
017500050527     D  MsgDta                      128a   Const
017600050527     D  MsgDtaLen                    10i 0 Const
017700050527     D  MsgTyp                       10a   Const
017800050527     D  CalStkE                      10a   Const Options( *VarSize )
017900050527     D  CalStkCtr                    10i 0 Const
018000050527     D  MsgKey                        4a
018100050527     D  Error                      1024a         Options( *VarSize )
018200050527     D  CalStkElen                   10i 0 Const Options( *NoPass )
018300050527     D  CalStkEq                     20a   Const Options( *NoPass )
018400050527     D  DspWait                      10i 0 Const Options( *NoPass )
018500050527     D  CalStkEtyp                   20a   Const Options( *NoPass )
018600050527     D  CcsId                        10i 0 Const Options( *NoPass )
018700051015     **-- Run system command:
018800051015     D system          Pr            10i 0 ExtProc( 'system' )
018900051015     D  command                        *   Value  Options( *String )
019000050901
019100050901     **-- Get PTF status:
019200050911     D GetPtfSts       Pr            32a   Varying
019300050901     D  PxLodSts                      1a   Const
019400050901     D  PxSvfSts                      1a   Const
019500050901     D  PxCvrSts                      1a   Const
019600050901     D  PxOrdSts                      1a   Const
019700051015     D  PxIplAct                      1a   Const
019800050901     **-- Send information message:
019900050901     D SndInfMsg       Pr            10i 0
020000050901     D  PxMsgDta                    512a   Const  Varying
020100050901     **-- Send completion message:
020200050901     D SndCmpMsg       Pr            10i 0
020300050901     D  PxMsgDta                    512a   Const  Varying
020400050527
020500051001     D CBX947          Pr
020600051017     D  PxPtfSts                           LikeDs( PtfSts )
020700051015     D  PxPtfOpt                      4a
020800090715     D  PxSltPrd                      4a
020900050911     **
021000051001     D CBX947          Pi
021100051017     D  PxPtfSts                           LikeDs( PtfSts )
021200090715     D  PxPtfOpt                      4a
021300090715     D  PxSltPrd                      4a
021400050911
021500050527      /Free
021600050527
021700050901        CrtUsrSpc( USRSPC_Q
021800050901                 : *Blanks
021900050901                 : 65535
022000050901                 : x'00'
022100050901                 : '*CHANGE'
022200050901                 : *Blanks
022300050901                 : '*YES'
022400050901                 : ERRC0100
022500050901                 );
022600050527
022700050901        pPRDS0200 = %Alloc( LST_RCDS * %Size( PRDS0200 ));
022800090715
022900090715        InpInf.NbrPrdSlt = PxSltPrd;
023000050901
023100050901        SltPrds( PRDS0200
023200050901               : InpInf
023300050901               : 'PRDS0200'
023400050901               : InpLst
023500050901               : OutInf
023600050901               : ERRC0100
023700050901               );
023800050901
023900050901        If  ERRC0100.BytAvl = *Zero;
024000050901
024100050901          For  IdxPrd = 1  to  OutInf.RcdAvl;
024200050901
024300050901            PtfPrdInf.PrdId   = PRDS0200.PrdId;
024400050901            PtfPrdInf.Release = '*ALL';
024500050901            PtfPrdInf.PrdOpt  = '*ALL';
024600050901            PtfPrdInf.LodId   = '*ALL';
024700050901
024800050901            LstPtfs( USRSPC_Q: PtfPrdInf: 'PTFL0100': ERRC0100 );
024900050901
025000050901            If  ERRC0100.BytAvl = *Zero;
025100050901              ExSr  ChkPtfSts;
025200050901            EndIf;
025300050901
025400050901            If  IdxPrd < OutInf.RcdAvl;
025500050901              Eval pPRDS0200 += OutInf.RcdSiz;
025600050901            EndIf;
025700050901          EndFor;
025800050901        EndIf;
025900050901
026000050901        DltUsrSpc( USRSPC_Q: ERRC0100 );
026100050911
026200090715        If  OutInf.Action < 0;
026300090715          SndCmpMsg( 'PTF check cancelled.' );
026400090715        Else;
026500090715          SndCmpMsg( 'PTF check completed.' );
026600090715        EndIf;
026700050527
026800050527        *InLr = *On;
026900050527        Return;
027000050527
027100050901        BegSr  ChkPtfSts;
027200050527
027300050901          RtvPtrSpc( USRSPC_Q: pUsrSpc );
027400050527
027500050901          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
027600050901          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
027700050527
027800050901          For  IdxPtf = 1  to UsrSpc.NumLstEnt;
027900050527
028000050912            Select;
028100051017            When  ChkSavF   = '*PTFSAVF'   And
028200051017                  PTFL0100.LodSts = '0'    And
028300051017                  PTFL0100.SvfSts = '1'    Or
028400050912
028500051017                  ChkCvrOnl = '*COVERONLY' And
028600051017                  PTFL0100.LodSts = '0'    And
028700051017                  PTFL0100.SvfSts = '0'    And
028800051017                  PTFL0100.CvrSts = '1'    Or
028900050912
029000051017                  ChkOnOrd  = '*ONORDER'   And
029100051017                  PTFL0100.LodSts = '0'    And
029200051017                  PTFL0100.SvfSts = '0'    And
029300051017                  PTFL0100.CvrSts = '0'    And
029400051017                  PTFL0100.OrdSts = '1'    Or
029500051015
029600051017                  ChkNotApy = '*NOTAPY'    And
029700051017                  PTFL0100.LodSts = '1'    Or
029800050912
029900051017                  ChkActRqd = '*ACTRQD'    And
030000051017                  PTFL0100.ActReq > '0'    And
030100051015                  PTFL0100.ActPnd > '0';
030200050912
030300051015              ExSr  RunPtfOpt;
030400050912
030500050912            EndSl;
030600050527
030700050901            If  IdxPtf < UsrSpc.NumLstEnt;
030800050901              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
030900050527            EndIf;
031000050527          EndFor;
031100050527
031200050527        EndSr;
031300050912
031400051015        BegSr  RunPtfOpt;
031500051015
031600051015          Select;
031700051015          When  PxPtfOpt = '*MSG';
031800051015            ExSr  SndPtfSts;
031900051015
032000051015          When  PxPtfOpt = '*DSP';
032100051015            ExSr  RunDspPtf;
032200051015          EndSl;
032300051015
032400051015        EndSr;
032500051015
032600050912        BegSr  SndPtfSts;
032700050912
032800051017          PtfStsTxt = GetPtfSts( PTFL0100.LodSts
032900051017                               : PTFL0100.SvfSts
033000051017                               : PTFL0100.CvrSts
033100051017                               : PTFL0100.OrdSts
033200051017                               : PTFL0100.IplAct
033300051017                               );
033400050912
033500050912          SndInfMsg( 'PTF '                                 +
033600050912                     PtfPrdInf.PrdId                        +
033700050912                     '-'                                    +
033800050912                     PTFL0100.PtfId                         +
033900050912                     ' currently has status '''             +
034000051017                     PtfStsTxt                              +
034100050912                     '''.'
034200050912                   );
034300050912
034400050912        EndSr;
034500051015
034600051015        BegSr  RunDspPtf;
034700051015
034800051015          system( 'DSPPTF LICPGM('                          +
034900051015                   %TrimR( PtfPrdInf.PrdId )                +
035000051015                  ') SELECT('                               +
035100051015                   %TrimR( PTFL0100.PtfId )                 +
035200051015                  ') COVERONLY(*NO)'
035300051015                );
035400051015
035500051015        EndSr;
035600051017
035700051017        BegSr  *InzSr;
035800051017
035900051020          If  PxPtfSts.NbrSts = 1  And  PxPtfSts.StsVal(1) = '*NONAPY';
036000051020            ChkSavF   = '*PTFSAVF';
036100051020            ChkOnOrd  = '*ONORDER';
036200051020            ChkCvrOnl = '*COVERONLY';
036300051020            ChkNotApy = '*NOTAPY';
036400051020            ChkActRqd = '*ACTRQD';
036500051020
036600051020          Else;
036700051020            For  IdxPtf = 1  To  PxPtfSts.NbrSts;
036800051020
036900051020              Select;
037000051020              When  PxPtfSts.StsVal(IdxPtf) = '*PTFSAVF';
037100051020                ChkSavF   = '*PTFSAVF';
037200051020
037300051020              When  PxPtfSts.StsVal(IdxPtf) = '*ONORDER';
037400051020                ChkOnOrd  = '*ONORDER';
037500051020
037600051020              When  PxPtfSts.StsVal(IdxPtf) = '*COVERONLY';
037700051020                ChkCvrOnl = '*COVERONLY';
037800051020
037900051020              When  PxPtfSts.StsVal(IdxPtf) = '*NOTAPY';
038000051020                ChkNotApy = '*NOTAPY';
038100051020
038200051020              When  PxPtfSts.StsVal(IdxPtf) = '*ACTRQD';
038300051020                ChkActRqd = '*ACTRQD';
038400051020              EndSl;
038500051020            EndFor;
038600051020          EndIf;
038700051017
038800051017        EndSr;
038900050912
039000050527      /End-Free
039100050901
039200050901     **-- Get PTF status:  ---------------------------------------------------**
039300050901     P GetPtfSts       B
039400050901     D                 Pi            32a   Varying
039500050901     D  PxLodSts                      1a   Const
039600050901     D  PxSvfSts                      1a   Const
039700050901     D  PxCvrSts                      1a   Const
039800050901     D  PxOrdSts                      1a   Const
039900051015     D  PxIplAct                      1a   Const
040000050901
040100050901      /Free
040200050901
040300050911        Select;
040400050901        When  PxLodSts = '0'  And  PxSvfSts = '1';
040500050901          Return  'Save file only';
040600050901
040700050901        When  PxLodSts = '0'  And  PxCvrSts = '1';
040800050901          Return  'Cover letter only';
040900050901
041000050901        When  PxLodSts = '0'  And  PxOrdSts = '1';
041100050901          Return  'On order only';
041200050901
041300051015        When  PxLodSts = '1'  And  PxIplAct > '0';
041400051015          Return  'Not applied - IPL action';
041500051015
041600051015        When  PxLodSts = '1';
041700051015          Return  'Not applied';
041800050911
041900050911        Other;
042000050911          Return  'Undefined';
042100050901        EndSl;
042200050901
042300050901      /End-Free
042400050901
042500050901     P GetPtfSts       E
042600050901     **-- Send information message:  -----------------------------------------**
042700050901     P SndInfMsg       B
042800050901     D                 Pi            10i 0
042900050901     D  PxMsgDta                    512a   Const  Varying
043000050901     **
043100050901     D MsgKey          s              4a
043200050901
043300050901      /Free
043400050901
043500050901        SndPgmMsg( 'CPF9897'
043600050901                 : 'QCPFMSG   *LIBL'
043700050901                 : PxMsgDta
043800050901                 : %Len( PxMsgDta )
043900050901                 : '*INFO'
044000050901                 : '*PGMBDY'
044100050901                 : 1
044200050901                 : MsgKey
044300050901                 : ERRC0100
044400050901                 );
044500050901
044600050901        If  ERRC0100.BytAvl > *Zero;
044700050901          Return  -1;
044800050901
044900050901        Else;
045000050901          Return  0;
045100050901
045200050901        EndIf;
045300050901
045400050901      /End-Free
045500050901
045600050901     P SndInfMsg       E
045700050901     **-- Send completion message:  ------------------------------------------**
045800050901     P SndCmpMsg       B
045900050901     D                 Pi            10i 0
046000050901     D  PxMsgDta                    512a   Const  Varying
046100050901     **
046200050901     D MsgKey          s              4a
046300050901
046400050901      /Free
046500050901
046600050901        SndPgmMsg( 'CPF9897'
046700050901                 : 'QCPFMSG   *LIBL'
046800050901                 : PxMsgDta
046900050901                 : %Len( PxMsgDta )
047000050901                 : '*COMP'
047100050901                 : '*PGMBDY'
047200050901                 : 1
047300050901                 : MsgKey
047400050901                 : ERRC0100
047500050901                 );
047600050901
047700050901        If  ERRC0100.BytAvl > *Zero;
047800050901          Return  -1;
047900050901
048000050901        Else;
048100050901          Return  0;
048200050901
048300050901        EndIf;
048400050901
048500050901      /End-Free
048600050901
048700050901     P SndCmpMsg       E
