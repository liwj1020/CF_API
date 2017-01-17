000100041110     **
000200090717     **  Program . . : CBX2063V
000300090715     **  Description : Display Index Entry Count - VCP
000400090523     **  Author  . . : Carsten Flensburg
000500090523     **  Published . : System iNetwork Programming Tips Newsletter
000600090717     **  Date  . . . : July 23, 2009
000700041110     **
000800041110     **
000900041110     **  Program description:
001000060430     **    This program checks the existence of the specified object.
001100040724     **
001200060430     **
001300031115     **  Compile options:
001400090717     **    CrtRpgMod Module( CBX2063V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700090717     **    CrtPgm    Pgm( CBX2063V )
001800090717     **              Module( CBX2063V )
001900090717     **              BndSrvPgm( CBX205 )
002000090221     **              ActGrp( *NEW )
002100031115     **
002200031115     **
002300040605     **-- Control specification:  --------------------------------------------**
002400060504     H Option( *SrcStmt )
002500090222
002600090715     **-- API error data structure:
002700090715     D ERRC0100        Ds                  Qualified
002800090715     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002900090715     D  BytAvl                       10i 0
003000090715     D  MsgId                         7a
003100090715     D                                1a
003200090715     D  MsgDta                      128a
003300090715
003400090715     **-- Global variables:
003500090715     D TypHex          s              2a
003600090719     **-- Global constants:
003700090719     D NULL            c                   ''
003800090715
003900090715     **-- Convert object type to hex:
004000090715     D CvtObjTyp       Pr                  ExtPgm( 'QLICVTTP' )
004100090715     D  CnvOpt                       10a   Const
004200090715     D  ObjSym                       10a   Const
004300090715     D  ObjHex                        2a
004400090715     D  Error                     32767a          Options( *VarSize )
004500090719     **-- Retrieve system value:
004600090719     D RtvSysVal       Pr                  ExtPgm( 'QWCRSVAL' )
004700090719     D  RcvVar                    32767a          Options( *VarSize )
004800090719     D  RcvVarLen                    10i 0 Const
004900090719     D  NbrSysVal                    10i 0 Const
005000090719     D  SysVal                       10a   Const  Dim( 256 )
005100090719     D                                            Options( *VarSize )
005200090719     D  Error                     32767a          Options( *VarSize )
005300090715
005400090222     **-- Check object existence:
005500090222     D ChkObj          Pr              n
005600090410     D  PxObjNam_q                   20a   Const
005700090222     D  PxObjTyp                     10a   Const
005800090523     **-- Retrieve message:
005900090523     D RtvMsg          Pr          4096a   Varying
006000090523     D  PxMsgId                       7a   Const
006100090523     D  PxMsgDta                    512a   Const  Varying
006200040728     **-- Send diagnostic message:
006300040728     D SndDiagMsg      Pr            10i 0
006400040722     D  PxMsgId                       7a   Const
006500040722     D  PxMsgDta                    512a   Const  Varying
006600040728     **-- Send escape message:
006700040728     D SndEscMsg       Pr            10i 0
006800040728     D  PxMsgId                       7a   Const
006900090621     D  PxMsgF                       10a   Const
007000040728     D  PxMsgDta                    512a   Const  Varying
007100090715
007200090715     **-- Get hexadecimal object type:
007300090715     D GetHexTyp       Pr             1a
007400090715     D  PxIdxTyp                     10a   Const
007500090719     **-- Get system value:
007600090719     D GetSysVal       Pr          4096a   Varying
007700090719     D  PxSysVal                     10a   Const
007800040722
007900040722     **-- Entry parameters:
008000090523     D ObjNam_q        Ds
008100090523     D  ObjNam                       10a
008200090523     D  ObjLib                       10a
008300090620     **
008400090717     D CBX2063V        Pr
008500090715     D  PxIdxNam_q                         LikeDs( ObjNam_q )
008600090715     D  PxIdxTyp                     10a
008700040722     **
008800090717     D CBX2063V        Pi
008900090715     D  PxIdxNam_q                         LikeDs( ObjNam_q )
009000090715     D  PxIdxTyp                     10a
009100040721
009200090715      /Free
009300040728
009400090715        Select;
009500090719        When  GetSysVal( 'QSECURITY' ) >= '40';
009600090719          SndDiagMsg( 'CPD0006'
009700090719                    : '0000' +
009800090719                      'This command will only run on ' +
009900090719                      'on security level 30 or lower.'
010000090719                    );
010100090719
010200090719          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );
010300090719
010400090715        When  GetHexTyp( PxIdxTyp ) =  x'00';
010500090715
010600090715          SndDiagMsg( 'CPD0006'
010700090715                    : '0000' +
010800090715                      RtvMsg( 'CPF219E': %Subst( PxIdxTyp: 2 ))
010900090715                    );
011000090715
011100090715          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );
011200090715
011300090715        When  GetHexTyp( PxIdxTyp ) <> x'0E';
011400090715
011500090715          SndDiagMsg( 'CPD0006'
011600090715                    : '0000' +
011700090715                      RtvMsg( 'CPF2160': %Subst( PxIdxTyp: 2 ))
011800090715                    );
011900090715
012000090715          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );
012100090715
012200090715        When  ChkObj( PxIdxNam_q: PxIdxTyp ) = *Off;
012300060506
012400090410          SndDiagMsg( 'CPD0006'
012500090410                    : '0000' +
012600090715                      RtvMsg( 'CPF2105': PxIdxNam_q + %Subst( PxIdxTyp: 2 ))
012700090410                    );
012800060506
012900090621          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );
013000090715        EndSl;
013100090715
013200040605        *InLr = *On;
013300040605        Return;
013400090410
013500040721      /End-Free
013600090715
013700090715     **-- Get hexadecimal object type:
013800090715     P GetHexTyp       B
013900090715     D                 Pi             1a
014000090715     D  PxIdxTyp                     10a   Const
014100090715
014200090715     **-- Local variables:
014300090715     D TypHex          s              2a
014400090715
014500090715      /Free
014600090715
014700090715        CvtObjTyp( '*SYMTOHEX': PxIdxTyp: TypHex: ERRC0100 );
014800090715
014900090715        If  ERRC0100.BytAvl > *Zero;
015000090715          Return  x'00';
015100090715
015200090715        Else;
015300090715          Return  %Subst( TypHex: 1: 1 );
015400090715        EndIf;
015500090715
015600090715      /End-Free
015700090715
015800090715     P GetHexTyp       E
015900090719     **-- Get system value:
016000090719     P GetSysVal       B                   Export
016100090719     D                 Pi          4096a   Varying
016200090719     D  PxSysVal                     10a   Const
016300090719
016400090719     **-- Local variables:
016500090719     D Idx             s             10i 0
016600090719     D SysVal          s           4096a   Varying
016700090719     **
016800090719     D ApiPrm          Ds                  Qualified
016900090719     D  RtnVarLen                    10i 0
017000090719     D  SysValNbr                    10i 0 Inz( %Elem( ApiPrm.SysVal ))
017100090719     D  SysVal                       10a   Dim( 1 )
017200090719     **
017300090719     D RtnVar          Ds                  Qualified
017400090719     D  RtnVarNbr                    10i 0
017500090719     D  RtnVarOfs                    10i 0 Dim( %Elem( ApiPrm.SysVal ))
017600090719     D  RtnVarDta                  4096a
017700090719     **
017800090719     D SysValInf       Ds                  Qualified  Based( pSysVal )
017900090719     D  SysValKwd                    10a
018000090719     D  DtaTyp                        1a
018100090719     D  InfSts                        1a
018200090719     D  DtaLen                       10i 0
018300090719     D  Dta                        4096a
018400090719     D  DtaInt                       10i 0 Overlay( Dta )
018500090719
018600090719      /Free
018700090719
018800090719        ApiPrm.RtnVarLen = %Elem( ApiPrm.SysVal ) * 24 + %Size( SysVal ) + 4;
018900090719        ApiPrm.SysVal(1) = PxSysVal;
019000090719
019100090719        RtvSysVal( RtnVar
019200090719                 : ApiPrm.RtnVarLen
019300090719                 : ApiPrm.SysValNbr
019400090719                 : ApiPrm.SysVal
019500090719                 : ERRC0100
019600090719                 );
019700090719
019800090719        If  ERRC0100.BytAvl > *Zero;
019900090719          SysVal = NULL;
020000090719
020100090719        Else;
020200090719          For  Idx = 1  to RtnVar.RtnVarNbr;
020300090719
020400090719            pSysVal = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
020500090719
020600090719            If  SysValInf.SysValKwd = PxSysVal;
020700090719
020800090719              Select;
020900090719              When  SysValInf.DtaTyp = 'C';
021000090719                SysVal = %Subst( SysValInf.Dta: 1: SysValInf.DtaLen );
021100090719
021200090719              When  SysValInf.DtaTyp = 'B';
021300090719                SysVal = %Char( SysValInf.DtaInt );
021400090719
021500090719              Other;
021600090719                SysVal = NULL;
021700090719              EndSl;
021800090719            EndIf;
021900090719
022000090719          EndFor;
022100090719        EndIf;
022200090719
022300090719        Return  SysVal;
022400090719
022500090719      /End-Free
022600090719
022700090719     P GetSysVal       E
