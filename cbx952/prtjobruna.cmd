/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTJOBRUNA )                                       */
/*           Pgm( CBX9521 )                                          */
/*           SrcMbr( CBX952X )                                       */
/*           VldCkr( CBX952V )                                       */
/*           HlpPnlGrp( CBX952H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print Job Run Attributes' )

          Parm     JOBTYP      *Char       1                    +
                   Dft( *ALL )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *ALL       '*' )                    +
                          ( *AUTOSTART 'A' )                    +
                          ( *BATCH     'B' )                    +
                          ( *INTERACT  'I' )                    +
                          ( *SYSTEM    'S' ))                   +
                   Expr( *YES )                                 +
                   Prompt( 'Job type' )

          Parm     CPUTIMLMT   *INT4                            +
                   Dft( *NONE )                                 +
                   SpcVal(( *NONE  -1 ))                        +
                   Expr( *YES )                                 +
                   Prompt( 'CPU time limit in millisecs' )

          Parm     TMPSTGLMT   *INT4                            +
                   Dft( *NONE )                                 +
                   SpcVal(( *NONE  -1 ))                        +
                   Expr( *YES )                                 +
                   Prompt( 'Temporary storage limit in Mb' )

          Parm     AUXIOLMT    *INT4                            +
                   Dft( *NONE )                                 +
                   SpcVal(( *NONE  -1 ))                        +
                   Expr( *YES )                                 +
                   Prompt( 'Auxiliary I/O limit in 1000' )

          Parm     ORDER       E0001                            +
                   Prompt( 'Printing order' )

          Parm     JOBD        Q0001                            +
                   Dft( *USRPRF )                               +
                   SngVal(( *USRPRF ))                          +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Job description' )

          Parm     OUTQ        Q0001                            +
                   Dft( *CURRENT )                              +
                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Output queue' )



 E0001:   Elem                 *Char      10                    +
                   Dft( *CPUTIM )                               +
                   Rstd( *YES )                                 +
                   SpcVal(( *CPUTIM )                           +
                          ( *TMPSTG )                           +
                          ( *AUXIO  ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Sort fields' )

          Elem                 *Char      10                    +
                   Dft( *DESCEND )                              +
                   Rstd( *YES )                                 +
                   SpcVal(( *ASCEND )                           +
                          ( *DESCEND ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Sequence' )

 Q0001:   Qual                 *Name      10                    +
                   Expr( *Yes )

          Qual                 *Name      10                    +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )



