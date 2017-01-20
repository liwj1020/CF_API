/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd   Cmd( WRKJRN2 )                                        */
/*             Pgm( CBX970 )                                         */
/*             SrcMbr( CBX970X )                                     */
/*             VldCkr( CBX970V )                                     */
/*             AlwLmtUsr( *NO )                                      */
/*             HlpPnlGrp( CBX970H )                                  */
/*             HlpId( *CMD )                                         */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Work with Journal 2' )

          Parm     JRN         Q0001                            +
                   Choice( *NONE )                              +
                   Prompt( 'Journal' )

          Parm     ORDER       *Char       10                   +
                   Dft( *JRN )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *JRN )                              +
                          ( *LIB ))                             +
                   Expr( *YES )                                 +
                   Prompt( 'List order' )

          Parm     OUTPUT      *Char       3                    +
                   Rstd( *YES )                                 +
                   Dft( * )                                     +
                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
                   Prompt( 'Output' )


 Q0001:   Qual                 *Generic    10                   +
                   Dft( *ALL )                                  +
                   SpcVal(( *ALL ))                             +
                   Expr( *YES )

          Qual                 *Name       10                   +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL    )                          +
                          ( *CURLIB  )                          +
                          ( *USRLIBL )                          +
                          ( *ALLUSR  )                          +
                          ( *ALL     ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Library' )

