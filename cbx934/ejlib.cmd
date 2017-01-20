/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ENDJRNLIB )                                        */
/*           Pgm( CBX934 )                                           */
/*           SrcMbr( CBX934X )                                       */
/*           VldCkr( CBX934V )                                       */
/*           HlpPnlGrp( CBX934H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'End Journal for Library' )

          Parm     LIB         *Name       10                   +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'Library' 1 )

          Parm     OBJ         *Generic    10                   +
                   Dft( *ALL )                                  +
                   SpcVal(( *ALL ))                             +
                   Prompt( 'Object' 2 )

          Parm     OBJTYPE     *Char       10                   +
                   Rstd( *YES )                                 +
                   Dft( *ALL )                                  +
                   SpcVal(( *ALL    )                           +
                          ( *FILE   )                           +
                          ( *DTAQ   )                           +
                          ( *DTAARA ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Object type' 3 )

          Parm     JRN         Q0001                            +
                   Dft( *OBJ )                                  +
                   SngVal(( *OBJ ))                             +
                   Choice( *NONE )                              +
                   Prompt( 'Journal' 4 )


 Q0001:   Qual                 *Name       10                   +
                   Expr( *Yes )

          Qual                 *Name       10                   +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )


