/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHKCRPSPT )                                        */
/*           Pgm( CBX940 )                                           */
/*           SrcMbr( CBX940X )                                       */
/*           HlpPnlGrp( CBX940H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Check cryptographic support' )

          Parm     ALGORITHM     *INT2                          +
                   Dft( *LIST )                                 +
                   Rstd( *YES )                                 +
                   SpcVal(( *LIST    0 )                        +
                          ( *MAC     1 )                        +
                          ( *MD5     2 )                        +
                          ( *SHA_1   3 )                        +
                          ( *DES_E   4 )                        +
                          ( *DES     5 )                        +
                          ( *RC4     6 )                        +
                          ( *RC5     7 )                        +
                          ( *DESX    8 )                        +
                          ( *TDES    9 )                        +
                          ( *DSA    10 )                        +
                          ( *RSA    11 )                        +
                          ( *DIFHEL 12 )                        +
                          ( *CDMF   13 )                        +
                          ( *RC2    14 )                        +
                          ( *AES    15 ))                       +
                   Expr( *YES )                                 +
                   Prompt( 'Cryptographic algorithm' )

