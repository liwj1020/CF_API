/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( SCAN )                                             */
/*           Pgm( CBX955 )                                           */
/*           SrcMbr( CBX955X )                                       */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX955H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
    Cmd        Prompt( 'Scan String' )

    Parm       STRING     *Char      999              +
               Min( 1 )                               +
               Expr( *YES )                           +
               Vary( *YES )                           +
               Prompt( 'String to scan' )

    Parm       PATTERN    *Char      999              +
               Min( 1 )                               +
               Expr( *YES )                           +
               Vary( *YES )                           +
               Prompt( 'Pattern to scan for' )

    Parm       START      *Dec         3              +
               Dft( *START )                          +
               Range( 1  999 )                        +
               SpcVal(( *START  1 ))                  +
               Expr( *YES )                           +
               Prompt( 'Starting position' )

    Parm       TRANSLATE  *Char        1              +
               Dft( *NO )                             +
               Rstd( *YES )                           +
               SpcVal(( *NO  '0' ) ( *YES  '1' ))     +
               Expr( *YES )                           +
               Prompt( 'Translate characters' )

    Parm       TRIM       *Char        1              +
               Dft( *NO )                             +
               Rstd( *YES )                           +
               SpcVal(( *NO  '0' ) ( *YES  '1' ))     +
               Expr( *YES )                           +
               Prompt( 'Trim trailing blanks' )

    Parm       WILDCARD   *Char        1              +
               Dft( *NONE )                           +
               SpcVal(( *NONE ' ' ))                  +
               Expr( *YES )                           +
               Prompt( 'Wildcard character' )

    Parm       RESULT     *Dec         3              +
               RtnVal( *YES )                         +
               Prompt( 'Result' )

