000100050602     **
000200050602     **  Program . . : CBX937
000300050602     **  Description : Display PTF CUM level - CPP
000400050602     **  Author  . . : Carsten Flensburg
000500050602     **
000600050602     **
000700050602     **  Compile and setup instructions:
000800050602     **    CrtRpgMod   Module( CBX937 )
000900050602     **                DbgView( *LIST )
001000050602     **
001100050602     **    CrtPgm      Pgm( CBX937 )
001200050602     **                Module( CBX937 )
001300050602     **                ActGrp( *NEW )
001400050602     **                BndSrvPgm( QPZLSTFX )
001500050602     **
001600050602     **
001700050602     **-- Control specification:  --------------------------------------------**
001800050602     H Option( *SrcStmt )
001900050527     **-- API error information:
002000050527     D ERRC0100        Ds                  Qualified
002100050527     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
002200050527     D  BytAvl                       10i 0
002300050527     D  MsgId                         7a
002400050527     D                                1a
002500050527     D  MsgDta                      256a
002600050527     **-- Global constants:
002700050527     D USRSPC_Q        c                   'LSTPTFS   QTEMP'
002800050527     **-- Global variables:
002900050527     D Idx             s             10u 0
003000050527     D CumLvl          s              5s 0 Inz
003100050527     D MsgDta          s            128a   Varying
003200050527     D MsgKey          s              4a
003300050527     **
003400050527     D IplDts          Ds            17    Qualified
003500050527     D  Date                          8a
003600050527     D  Time                          6a
003700050527     **-- API header information:
003800050527     D HdrInf          Ds                  Qualified  Based( pHdrInf )
003900050527     D  UsrSpcNamSp                  10a
004000050527     D  UsrSpcLibSp                  10a
004100050527     **-- User space generic header:
004200050527     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
004300050527     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
004400050527     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
004500050527     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
004600050527     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
004700050527     **-- User space pointers:
004800021210     D pUsrSpc         s               *   Inz( *Null )
004900021210     D pHdrInf         s               *   Inz( *Null )
005000021210     D pLstEnt         s               *   Inz( *Null )
005100050527     **-- Inz status record:
005200050527     D MatInzSts       Ds                  Qualified
005300050527     D  BytPrv                       10i 0 Inz( %Size( MatInzSts ))
005400050527     D  BytAvl                       10i 0
005500050527     D  StrIpl                        8a   Overlay( MatInzSts: 441 )
005600050527     **-- Product information - QSZRTVPR:
005700050527     D PRDR0100        Ds                  Qualified
005800050527     D  BytPrv                       10i 0
005900050527     D  BytRtn                       10i 0
006000021210     D                               10i 0
006100050527     D  PrdId                         7a
006200050527     D  Release                       6a
006300050527     D  PrdOpt                        4a
006400050527     D  LodId                         4a
006500050527     D  LodTyp                       10a
006600050527     D  SymLodStt                    10a
006700050527     D  LodErrInd                    10a
006800050527     D  LodStt                        2a
006900050527     D  SupFlg                        1a
007000050527     D  RegTyp                        2a
007100050527     D  RegVal                       14a
007200021210     D                                2a
007300050527     D  OfsAddInf                    10i 0
007400050527     D  PriLodId                      4a
007500050527     D  MinTrgRel                     6a
007600050527     D  MinVrmBas                     6a
007700050527     D  RqmBasOpt                     1a
007800050527     D  Level                         3a
007900050527     **-- PTF product information
008000050527     D PtfPrdInf       Ds                  Qualified
008100050527     D  PrdId                         7a
008200050527     D  Release                       6a
008300050527     D  PrdOpt                        4a
008400050527     D  LodId                        10a
008500050527     D  IncSpsPtf                     1a   Inz( '0' )
008600021210     D                               22a   Inz( *Allx'00' )
008700050527     **-- PTF list entry:
008800050527     D PTFL0100        Ds                  Qualified  Based( pLstEnt )
008900050527     D  PtfId                         7a
009000050527     D   PtfPfx                       2a   Overlay( PtfId: 1 )
009100050527     D   PtfCum                       1a   Overlay( PtfId: 2 )
009200050527     D   PtfNbr                       5s 0 Overlay( PtfId: 3 )
009300050527     D  RelLvlPtf                     6a
009400050527     D   RelV                         1a   Overlay( RelLvlPtf: 2 )
009500050527     D   RelR                         1a   Overlay( RelLvlPtf: 4 )
009600050527     D   RelM                         1a   Overlay( RelLvlPtf: 6 )
009700050527     D  PrdOptPtf                     4a
009800050527     D  PrdLodPtf                     4a
009900050527     D  LodSts                        1a
010000050527     D  SvfSts                        1a
010100050527     D  CvrSts                        1a
010200050527     D  OrdSts                        1a
010300050527     D  IplAct                        1a
010400050527     D  ActPnd                        1a
010500050527     D  ActReq                        1a
010600050527     D  IplReq                        1a
010700050527     D  PtfRls                        1a
010800050527     D  MinLvl                        2a
010900050527     D  MaxLvl                        2a
011000050527     D  StsDts                       13a
011100050527     D   StsDat                       7a   Overlay( StsDts: 1 )
011200050527     D   StsTim                       6a   Overlay( StsDts: 8 )
011300050527     D  SpsPtfId                      7a
011400050527     **-- Create user space:
011500021210     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
011600050527     D  SpcNamQ                      20a   Const
011700050527     D  ExtAtr                       10a   Const
011800050527     D  InzSiz                       10i 0 Const
011900050527     D  InzVal                        1a   Const
012000050527     D  PubAut                       10a   Const
012100050527     D  Text                         50a   Const
012200050527     **
012300050527     D  Replace                      10a   Const Options( *NoPass )
012400050527     D  Error                     32767a         Options( *NoPass: *VarSize )
012500050527     **
012600050527     D  Domain                       10a   Const Options( *NoPass )
012700050527     **-- Delete user space:
012800021210     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
012900050527     D  SpcNamQ                      20a   Const
013000050527     D  Error                     32767a         Options( *VarSize )
013100050527     **-- Retrieve pointer to user space:
013200021210     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
013300050527     D  SpcNamQ                      20a   Const
013400050527     D  Pointer                        *
013500050527     D  Error                     32767a         Options( *NoPass: *VarSize )
013600050527     **-- Retrieve product information:
013700021210     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
013800050527     D  Dta                                Like( PRDR0100 )
013900050527     D  DtaLen                       10i 0 Const
014000050527     D  FmtNam                        8a   Const
014100050527     D  PrdInf                       27a   Const
014200050527     D  Error                      1024a         Options( *VarSize )
014300050527     **-- List PTFs:
014400021210     D LstPtfs         Pr                  ExtProc( 'QpzListPTF' )
014500050527     D  SpcNamQ                      20a   Const
014600050527     D  PrdId                        50a   Const
014700050527     D  FmtNam                        8a   Const
014800050527     D  Error                     32767a         Options( *VarSize )
014900050527     **-- Materialize machine attributes:
015000050527     D MatMatr         PR                  ExtProc( '_MATMATR1' )
015100030212     D  Atr                                Like( MatInzSts )
015200030212     D  Opt                           2a   Const
015300050527     **-- Convert date & time:
015400030212     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
015500050527     D  InpFmt                       10a   Const
015600050527     D  InpVar                       17a   Const  Options( *VarSize )
015700050527     D  OutFmt                       10a   Const
015800050527     D  OutVar                       17a          Options( *VarSize )
015900050527     D  Error                        10i 0 Const
016000050527     **-- Send program message:
016100021210     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
016200050527     D  MsgId                         7a   Const
016300050527     D  MsgFq                        20a   Const
016400050527     D  MsgDta                      128a   Const
016500050527     D  MsgDtaLen                    10i 0 Const
016600050527     D  MsgTyp                       10a   Const
016700050527     D  CalStkE                      10a   Const Options( *VarSize )
016800050527     D  CalStkCtr                    10i 0 Const
016900050527     D  MsgKey                        4a
017000050527     D  Error                      1024a         Options( *VarSize )
017100021210     **
017200050527     D  CalStkElen                   10i 0 Const Options( *NoPass )
017300050527     D  CalStkEq                     20a   Const Options( *NoPass )
017400050527     D  DspWait                      10i 0 Const Options( *NoPass )
017500021210     **
017600050527     D  CalStkEtyp                   20a   Const Options( *NoPass )
017700050527     D  CcsId                        10i 0 Const Options( *NoPass )
017800050527
017900050527      /Free
018000050527
018100050527        RtvPrdInf( PRDR0100
018200050527                 : %Size( PRDR0100 )
018300050527                 : 'PRDR0100'
018400050527                 : '*OPSYS *CUR  0000*CODE    '
018500050527                 : ERRC0100
018600050527                 );
018700050527
018800050527        If  ERRC0100.BytAvl = *Zero;
018900050527
019000050527          CrtUsrSpc( USRSPC_Q
019100050527                   : *Blanks
019200050527                   : 65535
019300050527                   : x'00'
019400050527                   : '*CHANGE'
019500050527                   : *Blanks
019600050527                   : '*YES'
019700050527                   : ERRC0100
019800050527                   );
019900050527
020000050527          If  ERRC0100.BytAvl = *Zero;
020100050527
020200050527            PtfPrdInf.PrdId   = PRDR0100.PrdId;
020300050527            PtfPrdInf.Release = PRDR0100.Release;
020400050527            PtfPrdInf.PrdOpt  = PRDR0100.PrdOpt;
020500050527            PtfPrdInf.LodId   = PRDR0100.LodId;
020600050527
020700050527            LstPtfs( USRSPC_Q: PtfPrdInf: 'PTFL0100': ERRC0100 );
020800050527
020900050527            If  ERRC0100.BytAvl = *Zero;
021000050527              ExSr  GetPtfLvl;
021100050527
021200050527              MatMatr( MatInzSts: x'0108' );
021300050527
021400050527              CvtDtf( '*DTS': MatInzSts.StrIpl: '*YYMD': IplDts: 0 );
021500050527
021600050527              MsgDta = 'Cum level '                                       +
021700050527                       PTFL0100.PtfCum + %Char( CumLvl )                  +
021800050527                       PTFL0100.RelV + PTFL0100.RelR + PTFL0100.RelM      +
021900050527                       ' of '                                             +
022000050527                       %Char( %Date( PTFL0100.StsDat: *CYMD0 ): *JOBRUN ) +
022100050527                       ' at '                                             +
022200050527                       %Char( %Time( PTFL0100.StsTim: *HMS0 ): *JOBRUN )  +
022300050602                       ' last IPL on '                                    +
022400050527                       %Char( %Date( IplDts.Date: *ISO0 ): *JOBRUN )      +
022500050901                       ' at '                                             +
022600050901                       %Char( %Time( IplDts.Time: *HMS0 ): *JOBRUN )      +
022700050901                       '.';
022800050527
022900050527              SndPgmMsg( 'CPF9897'
023000050527                       : 'QCPFMSG   *LIBL'
023100050527                       : MsgDta
023200050527                       : %Len( MsgDta )
023300050527                       : '*INFO'
023400050527                       : '*PGMBDY'
023500050527                       : 1
023600050527                       : MsgKey
023700050527                       : ERRC0100
023800050527                       );
023900050527
024000050527            EndIf;
024100050527
024200050527            DltUsrSpc( USRSPC_Q: ERRC0100 );
024300050527
024400050527          EndIf;
024500050527        EndIf;
024600050527
024700050527        *InLr = *On;
024800050527        Return;
024900050527
025000050527        BegSr  GetPtfLvl;
025100050527
025200050527          RtvPtrSpc( USRSPC_Q: pUsrSpc );
025300050527
025400050527          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
025500050527          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
025600050527
025700050527          For  Idx = 1  to UsrSpc.NumLstEnt;
025800050527
025900050527            If  PTFL0100.PtfPfx = 'TC';
026000050527
026100050527              If  PTFL0100.PtfNbr > CumLvl;
026200050527
026300050527                CumLvl = PTFL0100.PtfNbr;
026400050527              EndIf;
026500050527            EndIf;
026600050527
026700050527            If  Idx < UsrSpc.NumLstEnt;
026800050527              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
026900050527            EndIf;
027000050527          EndFor;
027100050527
027200050527        EndSr;
027300050527
027400050527      /End-Free
