/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPIDXECNT )                                       */
/*           Pgm( CBX2063 )                                          */
/*           SrcMbr( CBX2063X )                                      */
/*           VldCkr( CBX2063V )                                      */
/*           HlpPnlGrp( CBX2063H )                                   */
/*           HlpId( *CMD )                                           */
/*           PrdLib( <library> )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Display Index Entry Count' )

          Parm     IDX         Q0001                            +
                   Min( 1 )                                     +
                   Choice( *NONE )                              +
                   Prompt( 'Index' )

          Parm     TYPE        *Char        10                  +
                   Min( 1 )                                     +
                   Choice( *PGM )                               +
                   ChoicePgm( CBX2063C )                         +
                   Prompt('Index type')


 Q0001:   Qual                 *Name       10                   +
                   Min( 1 )                                     +
                   Expr( *YES )

          Qual                 *Name                            +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL    )                          +
                          ( *CURLIB  *CURLIB ))                 +
                   Expr( *YES )                                 +
                   Prompt( 'Library' )

