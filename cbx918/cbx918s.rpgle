000100951011     **-----------------------------------------------------------------------**
000200030829     **
000300040711     **  Program . . : CBX918S
000400040711     **  Description : Retrieve & set encrypted user password - services
000500030829     **  Author  . . : Carsten Flensburg
000600030829     **
000700031119     **
000800031119     **  Compile options required:
000900040716     **
001000040714     **    CrtRpgMod  Module( CBX918S )
001100040714     **               DbgView( *NONE )
001200031119     **
001300040714     **    CrtSrvPgm  SrvPgm( CBX918S )
001400040714     **               Module( CBX918S )
001500040714     **               Export( *ALL )
001600040712     **               ActGrp( *CALLER )
001700031119     **
001800040716     **    - Ensure that service program CBX918S uses adopted authority,
001900040716     **      if necessary run the following command:
002000031119     **
002100040716     **        ChgSrvPgm  SrvPgm( CLIB/CBX918S )  UseAdpAut( *YES )
002200040716     **
002300040716     **
002400951011     **-- Header Specifications:  --------------------------------------------**
002500040716     H NoMain  Option( *SrcStmt )  BndDir( 'QC2LE' )
002600040711     **-- API Error Data Structure:
002700000320     D ApiError        Ds                  Inz
002800000320     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
002900000320     D  AeBytAvl                     10i 0
003000030804     D  AeMsgId                       7a
003100000320     D                                1a
003200030804     D  AeMsgDta                    256a
003300040711     **-- Product information:
003400040711     D PRDR0100        Ds                  Qualified
003500040711     D  BytPrv                       10i 0
003600040711     D  BytRtn                       10i 0
003700040711     D                               10i 0
003800040711     D  PrdId                         7a
003900040711     D  Release                       6a
004000040711     D  PrdOpt                        4a
004100040711     D  LodId                         4a
004200040711     D  LodTyp                       10a
004300040711     D  SymLodStt                    10a
004400040711     D  LodErrInd                    10a
004500040711     D  LodStt                        2a
004600040711     D  SupFlg                        1a
004700040711     D  RegTyp                        2a
004800040711     D  RegVal                       14a
004900040711     D                                2a
005000040711     D  OfsAddInf                    10i 0
005100040711     D  PriLodId                      4a
005200040711     D  MinTrgRel                     6a
005300040711     D  MinVrmBas                     6a
005400040711     D  RqmBasOpt                     1a
005500040711     D  Level                         3a
005600040711     **-- Copy memory:
005700040711     D memcpy          Pr              *   ExtProc( 'memcpy' )
005800040714     D  pOutMem                        *   Value
005900040714     D  pInpMem                        *   Value
006000040714     D  iMemSiz                      10u 0 Value
006100040711     **-- Get system value:
006200040711     D GetSysVal       Pr                  ExtPgm( 'QWCRSVAL' )
006300040711     D  GsRcvVar                  32767a          Options( *VarSize )
006400040711     D  GsRcvVarLen                  10i 0 Const
006500040711     D  GsNbrSysVal                  10i 0 Const
006600040711     D  GsSysVal                     10a   Const  Dim( 256 )
006700040711     D                                            Options( *VarSize )
006800040711     D  GsError                   32767a          Options( *VarSize )
006900040711     **-- Retrieve net attribute:
007000040711     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
007100040711     D  RnRcvVar                  32767a          Options( *VarSize )
007200040711     D  RnRcvVarLen                  10i 0 Const
007300040711     D  RnNbrNetAtr                  10i 0 Const
007400040711     D  RnNetAtr                     10a   Const  Dim( 256 )
007500040711     D                                            Options( *VarSize )
007600040711     D  RnError                   32767a          Options( *VarSize )
007700040711     **-- Retrieve product information:
007800040711     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
007900040711     D  PiDta                              Like( PRDR0100 )
008000040711     D  PiDtaLen                     10i 0 Const
008100040711     D  PiFmtNam                      8a   Const
008200040711     D  PiPrdInf                     27a   Const
008300040711     D  PiError                    1024a         Options( *VarSize )
008400040711     **-- Retrieve user information:
008500040711     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
008600040711     D  RuRcvVar                  32767a          Options( *VarSize )
008700040711     D  RuRcvVarLen                  10i 0 Const
008800040711     D  RuFmtNam                     10a   Const
008900040711     D  RuUsrPrf                     10a   Const
009000040711     D  RuError                   32767a          Options( *VarSize )
009100040711     **-- Convert date & time:
009200040711     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
009300040711     D  CdInpFmt                     10a   Const
009400040711     D  CdInpVar                     17a   Const  Options( *VarSize )
009500040711     D  CdOutFmt                     10a   Const  Options( *VarSize )
009600040711     D  CdOutVar                     17a   Const  Options( *VarSize )
009700040711     D  CdError                   32767a          Options( *VarSize )
009800040714     **-- Send message:
009900040714     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
010000040714     D  SmMsgId                       7a   Const
010100040714     D  SmMsgFq                      20a   Const
010200040714     D  SmMsgDta                    512a   Const  Options( *VarSize )
010300040714     D  SmMsgDtaLen                  10i 0 Const
010400040714     D  SmMsgTyp                     10a   Const
010500040714     D  SmMsgQq                    1000a   Const  Options( *VarSize )
010600040714     D  SmMsgQnbr                    10i 0 Const
010700040714     D  SmMsgQrpy                    20a   Const
010800040714     D  SmMsgKey                      4a
010900040714     D  SmError                   32767a          Options( *VarSize )
011000040714     D  SmCcsId                      10i 0 Const  Options( *NoPass )
011100040711     **
011200040711     **-- Get system password level:
011300040711     D GetPwdLvl       Pr            10i 0
011400040711     **-- Get system name:
011500040711     D GetSysNam       Pr             8a   Varying
011600040711     **-- Get system release level:
011700040711     D GetRlsLvl       Pr             6a
011800040711     **-- Get user last password change timestamp:
011900040711     D GetPwdDts       Pr              z
012000040711     D  PxUsrPrf                     10a   Value
012100040712     **-- Get user class:
012200040712     D GetUsrCls       Pr            10a   Varying
012300040712     D  PxUsrPrf                     10a   Value
012400040714     **-- Send error message:
012500040714     D SndErrMsg       Pr            10i 0
012600040714     D  PxUsrPrf                     10a   Const
012700040714     D  PxMsgDta                    512a   Const  Varying
012800040714     **
012900040711     **-- Get system password level:
013000040711     P GetPwdLvl       B                   Export
013100040711     D                 Pi            10i 0
013200040711     **
013300030804     **-- Local variables:
013400040711     D Idx             s             10i 0
013500040711     D PwdLvl          s             10i 0
013600040711     **
013700040711     D RsRtnVarLen     s             10i 0
013800040711     D RsSysValNbr     s             10i 0 Inz( %Elem( RsSysVal ))
013900040711     D RsSysVal        s             10a   Dim( 1 )
014000040711     ***
014100040711     D RsRtnVar        Ds          1024
014200040711     D  RsRtnVarNbr                  10i 0
014300040711     D  RsRtnVarOfs                  10i 0 Dim( %Elem( RsSysVal ))
014400040711     D  RsRtnVarDta                1008a
014500040711     **
014600040711     D RsSysValInf     Ds                  Based( pSysVal )
014700040711     D  RsSysValKwd                  10a
014800040711     D  RsDtaTyp                      1a
014900040711     D  RsInfSts                      1a
015000040711     D  RsDtaLen                     10i 0
015100040711     D  RsDta                       512a
015200040711
015300040711      /Free
015400040711
015500040714        RsRtnVarLen = %Elem( RsSysVal ) * 24 + %Size( PwdLvl ) + 4;
015600040714        RsSysVal(1) = 'QPWDLVL';
015700040711
015800040714        GetSysVal( RsRtnVar
015900040714                 : RsRtnVarLen
016000040714                 : RsSysValNbr
016100040714                 : RsSysVal
016200040714                 : ApiError
016300040714                 );
016400040711
016500040714        If  AeBytAvl > *Zero;
016600040714          PwdLvl = -1;
016700040711
016800040714        Else;
016900040714          For  Idx = 1  to RsRtnVarNbr;
017000040711
017100040714            pSysVal = %Addr( RsRtnVar ) + RsRtnVarOfs(Idx);
017200040711
017300040714            If  RsSysValKwd = 'QPWDLVL';
017400040714              MemCpy( %Addr( PwdLvl ): %Addr( RsDta ): %Size( PwdLvl ));
017500040714            EndIf;
017600040711
017700040714          EndFor;
017800040714        EndIf;
017900040711
018000040714        Return  PwdLvl;
018100040711
018200040711      /End-Free
018300040711
018400040711     P GetPwdLvl       E
018500040711     **-- Get system name:  --------------------------------------------------**
018600040711     P GetSysNam       B                   Export
018700040711     D                 Pi             8a   Varying
018800040711     **
018900040711     **-- Local variables:
019000040711     D Idx             s             10i 0
019100040711     D SysNam          s              8a   Varying
019200040711     **
019300040711     D RnRtnAtrLen     s             10i 0
019400040711     D RnNetAtrNbr     s             10i 0 Inz( %Elem( RnNetAtr ))
019500040711     D RnNetAtr        s             10a   Dim( 1 )
019600040711     **
019700040711     D RnRtnVar        Ds
019800040711     D  RnRtnVarNbr                  10i 0
019900040711     D  RnRtnVarOfs                  10i 0 Dim( %Elem( RnNetAtr ))
020000040711     D  RnRtnVarDta                1024a
020100040711     **
020200040711     D RnRtnAtr        Ds                  Based( RtnValPtr )
020300040711     D  RnAtrNam                     10a
020400040711     D  RnDtaTyp                      1a
020500040711     D  RnInfSts                      1a
020600040711     D  RnAtrLen                     10i 0
020700040711     D  RnAtr                      1008a
020800040711
020900040711      /Free
021000040711
021100040714        RnRtnAtrLen = %Elem( RnNetAtr ) * 24 + ( %Size( SysNam )) + 4;
021200040711
021300040714        RnNetAtr(1) = 'SYSNAME';
021400040711
021500040714        RtvNetAtr( RnRtnVar
021600040714                 : RnRtnAtrLen
021700040714                 : RnNetAtrNbr
021800040714                 : RnNetAtr
021900040714                 : ApiError
022000040714                 );
022100040711
022200040714        If  AeBytAvl > *Zero;
022300040714          SysNam = '';
022400040711
022500040714        Else;
022600040714          For  Idx = 1  to RnRtnVarNbr;
022700040711
022800040714            RtnValPtr = %Addr( RnRtnVar ) + RnRtnVarOfs(Idx);
022900040711
023000040714            If  RnAtrNam = 'SYSNAME';
023100040714              SysNam      = %SubSt( RnAtr: 1: RnAtrLen );
023200040714            EndIf;
023300040711
023400040714          EndFor;
023500040714        EndIf;
023600040711
023700040714        Return  SysNam;
023800040711
023900040711      /End-Free
024000040711
024100040711     P GetSysNam       E
024200040711     **-- Get system release level:  -----------------------------------------**
024300040711     P GetRlsLvl       B                   Export
024400040711     D                 Pi             6a
024500040711
024600040711      /Free
024700040711
024800040714        RtvPrdInf( PRDR0100
024900040714                 : %Size( PRDR0100 )
025000040714                 : 'PRDR0100'
025100040714                 : '*OPSYS *CUR  0000*CODE    '
025200040714                 : ApiError
025300040714                 );
025400040711
025500040714        If  AeBytAvl > *Zero;
025600040714          PRDR0100.Release = *Blanks;
025700040714        EndIf;
025800040711
025900040714        Return  PRDR0100.Release;
026000040711
026100040711      /End-Free
026200040711
026300040711     P GetRlsLvl       E
026400040711     **-- Get user last password change timestamp:  --------------------------**
026500040711     P GetPwdDts       B                   Export
026600040711     D                 Pi              z
026700040711     D  PxUsrPrf                     10a   Value
026800040711     **
026900040711     D PwdChgDts       Ds            17
027000040711     D  PcChgDat                      8a
027100040711     D  PcChgTim                      6a
027200040711     **
027300040711     D USRI0100        Ds                  Qualified
027400040711     D  BytRtn                       10i 0
027500040711     D  BytAvl                       10i 0
027600040711     D  UsrPrf                       10a
027700040711     D  PwdChgDts                     8a    Overlay( USRI0100: 47 )
027800040711
027900040711      /Free
028000040711
028100040714        RtvUsrInf( USRI0100
028200040714                 : %Size( USRI0100 )
028300040714                 : 'USRI0100'
028400040714                 : PxUsrPrf
028500040714                 : ApiError
028600040714                 );
028700040711
028800040714        If  AeBytAvl > *Zero;
028900040714          Return *LoVal;
029000040711
029100040714        Else;
029200040714          CvtDtf( '*DTS'
029300040714                : USRI0100.PwdChgDts
029400040714                : '*YYMD'
029500040714                : PwdChgDts
029600040714                : ApiError
029700040714                );
029800040711
029900040714          Return  %Date( PcChgDat: *ISO0 ) + %Time( PcChgTim: *HMS0 );
030000040714        EndIf;
030100040711
030200040711      /End-Free
030300040711
030400040711     P GetPwdDts       E
030500040712     **-- Get user class:  ---------------------------------------------------**
030600040712     P GetUsrCls       B                   Export
030700040712     D                 Pi            10a   Varying
030800040712     D  PxUsrPrf                     10a   Value
030900040712     **
031000040712     D USRI0200        Ds                  Qualified
031100040712     D  BytRtn                       10i 0
031200040712     D  BytAvl                       10i 0
031300040712     D  UsrPrf                       10a
031400040712     D  UsrCls                       10a   Overlay( USRI0200: 19 )
031500040712
031600040712      /Free
031700040712
031800040714        RtvUsrInf( USRI0200
031900040714                 : %Size( USRI0200 )
032000040714                 : 'USRI0200'
032100040714                 : PxUsrPrf
032200040714                 : ApiError
032300040714                 );
032400040712
032500040714        If  AeBytAvl > *Zero;
032600040714          USRI0200.UsrCls = *Blanks;
032700040714        EndIf;
032800040714
032900040714        Return  %Trim( USRI0200.UsrCls );
033000040712
033100040712      /End-Free
033200040712
033300040712     P GetUsrCls       E
033400040714     **-- Send error message:  -----------------------------------------------**
033500040714     P SndErrMsg       B                   Export
033600040714     D                 Pi            10i 0
033700040714     D  PxUsrPrf                     10a   Const
033800040714     D  PxMsgDta                    512a   Const  Varying
033900040714     **
034000040714     D MsgKey          s              4a
034100040714
034200040714      /Free
034300040714
034400040714        SndMsg( 'CPF9898'
034500040714              : 'QCPFMSG   *LIBL'
034600040714              : PxMsgDta
034700040714              : %Len( PxMsgDta )
034800040714              : '*INFO'
034900040714              : PxUsrPrf + '*LIBL'
035000040714              : 1
035100040714              : *Blanks
035200040714              : MsgKey
035300040714              : ApiError
035400040714              );
035500040714
035600040714        If  AeBytAvl > *Zero;
035700040714          Return -1;
035800040714
035900040714        Else;
036000040714          Return  0;
036100040714        EndIf;
036200040714
036300040714      /End-Free
036400040714
036500040714     **
036600040714     P SndErrMsg       E
