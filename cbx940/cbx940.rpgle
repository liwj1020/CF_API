     **
     **   MMTR_TEMPL_T.BYTPRV = 394
     **   MMTR_TEMPL_T.BYTAVL = 1077952576
     **   MMTR_TEMPL_T.NBRENT = 14
     **   MMTR_TEMPL_T.MMTR_01C8_T =
     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(1) = ' '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(1) = 1024
     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(1) = '@ '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(2) = ' '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(2) = 0
     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(2) = 'æ '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(3) = ' '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(3) = 0
     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(3) = 'æ '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(4) = ' '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(4) = 56
     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(4) = '@ '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.CRPALG(5) = ' '
     **   MMTR_TEMPL_T.CRYPTO_ATTR.KEYLEN(5) = 56
     **   MMTR_TEMPL_T.CRYPTO_ATTR.SRVPVD(5) = 'æ '
     **
     **   MAC     Hex 0001 =  MAC - Message Authentication Code
     **   MD5     Hex 0002 =  MD5
     **   SHA_1   Hex 0003 =  SHA-1 - Secure Hash Algorithm
     **   DES_E   Hex 0004 =  DES (encrypt only) - Data Encryption Standard
     **   DES     Hex 0005 =  DES (encrypt and decrypt)
     **   RC4     Hex 0006 =  RC4
     **   RC5     Hex 0007 =  RC5
     **   DESX    Hex 0008 =  DESX
     **   TDES    Hex 0009 =  Triple-DES
     **   DSA     Hex 000A =  DSA - Digital Signature Algorithm
     **   RSA     Hex 000B =  RSA - Rivest-Shamir-Adleman
     **   DIFHEL  Hex 000C =  Diffie-Hellman
     **   CDMF    Hex 000D =  CDMF - Commercial Data Masking Facility
     **   RC2     Hex 000E =  RC2
     **   AES     Hex 000F =  AES - Advanced Encryption Standard
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a
     **-- Algorithm name conversion:
     D NamDfn          Ds
     D  NamHex                       30a   Inz( x'0001000200030004000500060007-
     D                                     00080009000A000B000C000D000E000F' )
     D  NamTxt                       90a   Inz( 'MAC   -
     D                                     MD5   -
     D                                     SHA_1 -
     D                                     DES_E -
     D                                     DES   -
     D                                     RC4   -
     D                                     RC5   -
     D                                     DESX  -
     D                                     TDES  -
     D                                     DSA   -
     D                                     RSA   -
     D                                     DIFHEL-
     D                                     CDMF  -
     D                                     RC2   -
     D                                     AES   ' )
     D  NamHexA                       2a   Dim( 15 )  Overlay( NamDfn: 1 )
     D  NamTxtA                       6a   Dim( 15 )  Overlay( NamDfn: 31 )
     **-- Global variables:
     D Idx             s             10i 0
     D Alg             s             10i 0
     **-- Global constants:
     D MMTR_CRYPTO     c                   x'01C8'
     D ALG_LIST        c                   x'0000'
     **-- Machine attributes template:
     D MMTR_Templ_T    Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_Templ_T ))          D  MatActLen
     D  BytAvl                       10i 0
     D  MMTR_01C8_T
     D   NbrEnt                       5u 0 Overlay( MMTR_01C8_T: 1 )            D  MatActLen
     D   Crypto_Attr                       Overlay( MMTR_01C8_T: 3 )
     D                                     LikeDs( Crypto_Attr_T )
     D                                     Dim( 64 )
     **
     D Crypto_Attr_T   Ds
     D  CrpAlg                        2a
     D  KeyLen                        5u 0
     D  SrvPvd                        2a
     **-- Materialize machine attributes:
     D MatMatr         PR                  ExtProc('_MATMATR1')
     D  Atr                                Like( MMTR_Templ_T )
     D  Opt                           2a   Const
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                    1024a          Options( *VarSize )

     **-- Send information message:
     D SndInfMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX940          Pr
     D  PxAlgHex                      2a
     **
     D CBX940          Pi
     D  PxAlgHex                      2a

      /Free

        MatMatr( MMTR_Templ_T: MMTR_CRYPTO );

        If  PxAlgHex = ALG_LIST;

          For  Alg = 1  to  MMTR_Templ_T.NbrEnt;

            Idx = %LookUp( MMTR_Templ_T.Crypto_Attr(Alg).CrpAlg: NamHexA );

            If  Idx > *Zero;
              SndInfMsg( %Trim( NamTxtA(Idx))                              +
                         ' algorithm supported with maximum key length '   +
                         %Char( MMTR_Templ_T.Crypto_Attr(Alg).KeyLen )     +
                         '.'
                       );
            EndIf;
          EndFor;
        Else;

          Idx = %LookUp( PxAlgHex: NamHexA );

          If  Idx > *Zero;
            For  Alg = 1  to  MMTR_Templ_T.NbrEnt;

              If  MMTR_Templ_T.Crypto_Attr(Alg).CrpAlg = PxAlgHex;
                SndInfMsg( %Trim( NamTxtA(Idx))                              +
                           ' algorithm supported with maximum key length '   +
                           %Char( MMTR_Templ_T.Crypto_Attr(Alg).KeyLen )     +
                           '.'
                         );
                Leave;
              EndIf;

              If  Alg = MMTR_Templ_T.NbrEnt;
                SndInfMsg( %Trim( NamTxtA(Idx)) + ' algorithm not supported.' );
              EndIf;
            EndFor;
          EndIf;
        EndIf;

        Return;

      /End-Free

     **-- Send information message:  -----------------------------------------**
     P SndInfMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*INFO'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndInfMsg       E
