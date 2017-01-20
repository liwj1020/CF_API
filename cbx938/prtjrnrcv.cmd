/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTJRNRCV )                                        */
/*           Pgm( CBX938 )                                           */
/*           SrcMbr( CBX938X )                                       */
/*           HlpPnlGrp( CBX938H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print journal receivers' )

          Parm     JRN         Q0001                  +
                   Min( 1 )                           +
                   Choice( *NONE )                    +
                   Prompt( 'Journal' )


Q0001:    Qual                 *Generic    10         +
                   SpcVal(( *ALL ))                   +
                   Expr( *YES )

          Qual                 *Name       10         +
                   Dft( *LIBL )                       +
                   SpcVal(( *LIBL    )                +
                          ( *CURLIB  )                +
                          ( *ALL     )                +
                          ( *ALLUSR  )                +
                          ( *USRLIBL ))               +
                   Expr( *YES )                       +
                   Prompt( 'Library' )


