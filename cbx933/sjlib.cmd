/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( STRJRNLIB )                                        */
/*           Pgm( CBX933 )                                           */
/*           SrcMbr( CBX933X )                                       */
/*           VldCkr( CBX933V )                                       */
/*           HlpPnlGrp( CBX933H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Start Journal for Library' )

          Parm     LIB         *Name       10                   +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'Library' 1 )

          Parm     JRN         Q0001                            +
                   Min( 1 )                                     +
                   Choice( *NONE )                              +
                   Prompt( 'Journal' 4 )

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

          Parm     IMAGES      *Char        6                   +
                   RstD( *YES )                                 +
                   Dft( *AFTER )                                +
                   SpcVal(( *AFTER ) ( *BOTH ))                 +
                   Expr( *YES )                                 +
                   Prompt( 'Record images' 5 )

          Parm     OMTJRNE     *Char       10                   +
                   Rstd( *YES )                                 +
                   Dft( *NONE )                                 +
                   SpcVal(( *NONE ) ( *OPNCLO ))                +
                   Expr( *YES )                                 +
                   PmtCtl( P0001 )                              +
                   Prompt( 'Journal entries to be omitted' 6 )


 Q0001:   Qual                 *Name       10                   +
                   Expr( *Yes )

          Qual                 *Name       10                   +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )


 P0001:   PmtCtl   Ctl( OBJTYPE )                               +
                   Cond(( *EQ '*ALL' ))

          PmtCtl   Ctl( OBJTYPE )                               +
                   Cond(( *EQ '*FILE' ))                        +
                   LglRel( *OR )


          Dep      Ctl( &OBJTYPE *EQ '*DTAQ' )                  +
                   Parm(( &IMAGES *EQ '*BOTH' ))                +
                   NbrTrue( *EQ 0 )                             +
                   MsgId( CPD7013 )

