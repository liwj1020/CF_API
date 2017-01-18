000100050627     **
000200050627     **   MMTR_TEMPL_T.BYTPRV = 394
000300050627     **   MMTR_TEMPL_T.BYTAVL = 1077952576
000400050627     **   MMTR_TEMPL_T.NBRENT = 14
000500050627     **   MMTR_TEMPL_T.MMTR_01C8_T =
000600050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(1) = ' '
000700050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(1) = 1024
000800050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(1) = '@ '
000900050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(2) = ' '
001000050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(2) = 0
001100050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(2) = 'æ '
001200050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(3) = ' '
001300050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(3) = 0
001400050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(3) = 'æ '
001500050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(4) = ' '
001600050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(4) = 56
001700050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(4) = '@ '
001800050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(5) = ' '
001900050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(5) = 56
002000050627     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(5) = 'æ '
002100050627     **
002200050627     **   MAC     Hex 0001 =  MAC - Message Authentication Code
002300050627     **   MD5     Hex 0002 =  MD5
002400050627     **   SHA_1   Hex 0003 =  SHA-1 - Secure Hash Algorithm
002500050627     **   DES_E   Hex 0004 =  DES (encrypt only) - Data Encryption Standard
002600050627     **   DES     Hex 0005 =  DES (encrypt and decrypt)
002700050627     **   RC4     Hex 0006 =  RC4
002800050627     **   RC5     Hex 0007 =  RC5
002900050627     **   DESX    Hex 0008 =  DESX
003000050627     **   TDES    Hex 0009 =  Triple-DES
003100050627     **   DSA     Hex 000A =  DSA - Digital Signature Algorithm
003200050627     **   RSA     Hex 000B =  RSA - Rivest-Shamir-Adleman
003300050702     **   DIFHEL  Hex 000C =  Diffie-Hellman
003400050627     **   CDMF    Hex 000D =  CDMF - Commercial Data Masking Facility
003500050627     **   RC2     Hex 000E =  RC2
003600050627     **   AES     Hex 000F =  AES - Advanced Encryption Standard
003700050627     **-- Control specification:  --------------------------------------------**
003800050627     H Option( *SrcStmt )
003900050627
004000050627     **-- API error data structure:
004100050627     D ERRC0100        Ds                  Qualified
004200050627     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
004300050627     D  BytAvl                       10i 0
004400050627     D  MsgId                         7a
004500050627     D                                1a
004600050627     D  MsgDta                      512a
004700050627     **-- Algorithm name conversion:
004800050627     D NamDfn          Ds
004900050627     D  NamHex                       30a   Inz( x'0001000200030004000500060007-
005000050627     D                                     00080009000A000B000C000D000E000F' )
005100050702     D  NamTxt                       90a   Inz( 'MAC   -
005200050702     D                                     MD5   -
005300050702     D                                     SHA_1 -
005400050702     D                                     DES_E -
005500050702     D                                     DES   -
005600050702     D                                     RC4   -
005700050702     D                                     RC5   -
005800050702     D                                     DESX  -
005900050702     D                                     TDES  -
006000050702     D                                     DSA   -
006100050702     D                                     RSA   -
006200050702     D                                     DIFHEL-
006300050702     D                                     CDMF  -
006400050702     D                                     RC2   -
006500050702     D                                     AES   ' )
006600050627     D  NamHexA                       2a   Dim( 15 )  Overlay( NamDfn: 1 )
006700050702     D  NamTxtA                       6a   Dim( 15 )  Overlay( NamDfn: 31 )
006800050627     **-- Global variables:
006900050627     D Idx             s             10i 0
007000050627     D Alg             s             10i 0
007100050627     **-- Global constants:
007200050627     D MMTR_CRYPTO     c                   x'01C8'
007300050702     D ALG_LIST        c                   x'0000'
007400050627     **-- Machine attributes template:
007500050627     D MMTR_Templ_T    Ds                  Qualified
007600050627     D  BytPrv                       10i 0 Inz( %Size( MMTR_Templ_T ))          D  MatActLen
007700050627     D  BytAvl                       10i 0
007800050627     D  MMTR_01C8_T
007900050627     D   NbrEnt                       5u 0 Overlay( MMTR_01C8_T: 1 )            D  MatActLen
008000050627     D   Crypto_Attr                       Overlay( MMTR_01C8_T: 3 )
008100050627     D                                     LikeDs( Crypto_Attr_T )
008200050627     D                                     Dim( 64 )
008300050627     **
008400050627     D Crypto_Attr_T   Ds
008500050627     D  CrpAlg                        2a
008600050627     D  KeyLen                        5u 0
008700050627     D  SrvPvd                        2a
008800050627     **-- Materialize machine attributes:
008900000512     D MatMatr         PR                  ExtProc('_MATMATR1')
009000050627     D  Atr                                Like( MMTR_Templ_T )
009100000512     D  Opt                           2a   Const
009200050627     **-- Send program message:
009300050627     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
009400050627     D  SpMsgId                       7a   Const
009500050627     D  SpMsgFq                      20a   Const
009600050627     D  SpMsgDta                    128a   Const
009700050627     D  SpMsgDtaLen                  10i 0 Const
009800050627     D  SpMsgTyp                     10a   Const
009900050627     D  SpCalStkE                    10a   Const  Options( *VarSize )
010000050627     D  SpCalStkCtr                  10i 0 Const
010100050627     D  SpMsgKey                      4a
010200050627     D  SpError                    1024a          Options( *VarSize )
010300050627
010400050627     **-- Send information message:
010500050627     D SndInfMsg       Pr            10i 0
010600050627     D  PxMsgDta                    512a   Const  Varying
010700050702
010800050702     D CBX940          Pr
010900050702     D  PxAlgHex                      2a
011000050702     **
011100050702     D CBX940          Pi
011200050702     D  PxAlgHex                      2a
011300050627
011400050627      /Free
011500050627
011600050702        MatMatr( MMTR_Templ_T: MMTR_CRYPTO );
011700050702
011800050702        If  PxAlgHex = ALG_LIST;
011900050702
012000050702          For  Alg = 1  to  MMTR_Templ_T.NbrEnt;
012100050702
012200050702            Idx = %LookUp( MMTR_Templ_T.Crypto_Attr(Alg).CrpAlg: NamHexA );
012300050702
012400050702            If  Idx > *Zero;
012500050702              SndInfMsg( %Trim( NamTxtA(Idx))                              +
012600050702                         ' algorithm supported with maximum key length '   +
012700050702                         %Char( MMTR_Templ_T.Crypto_Attr(Alg).KeyLen )     +
012800050702                         '.'
012900050702                       );
013000050702            EndIf;
013100050702          EndFor;
013200050702        Else;
013300050702
013400050702          Idx = %LookUp( PxAlgHex: NamHexA );
013500050702
013600050702          If  Idx > *Zero;
013700050702            For  Alg = 1  to  MMTR_Templ_T.NbrEnt;
013800050702
013900050702              If  MMTR_Templ_T.Crypto_Attr(Alg).CrpAlg = PxAlgHex;
014000050702                SndInfMsg( %Trim( NamTxtA(Idx))                              +
014100050702                           ' algorithm supported with maximum key length '   +
014200050702                           %Char( MMTR_Templ_T.Crypto_Attr(Alg).KeyLen )     +
014300050702                           '.'
014400050702                         );
014500050702                Leave;
014600050702              EndIf;
014700050702
014800050702              If  Alg = MMTR_Templ_T.NbrEnt;
014900050702                SndInfMsg( %Trim( NamTxtA(Idx)) + ' algorithm not supported.' );
015000050702              EndIf;
015100050702            EndFor;
015200050702          EndIf;
015300050702        EndIf;
015400050627
015500050627        Return;
015600050627
015700050627      /End-Free
015800050627
015900050627     **-- Send information message:  -----------------------------------------**
016000050627     P SndInfMsg       B
016100050627     D                 Pi            10i 0
016200050627     D  PxMsgDta                    512a   Const  Varying
016300050627     **
016400050627     D MsgKey          s              4a
016500050627
016600050627      /Free
016700050627
016800050627        SndPgmMsg( 'CPF9897'
016900050627                 : 'QCPFMSG   *LIBL'
017000050627                 : PxMsgDta
017100050627                 : %Len( PxMsgDta )
017200050627                 : '*INFO'
017300050627                 : '*PGMBDY'
017400050627                 : 1
017500050627                 : MsgKey
017600050627                 : ERRC0100
017700050627                 );
017800050627
017900050627        If  ERRC0100.BytAvl > *Zero;
018000050627          Return  -1;
018100050627
018200050627        Else;
018300050627          Return   0;
018400050627        EndIf;
018500050627
018600050627      /End-Free
018700050627
018800050627     P SndInfMsg       E
