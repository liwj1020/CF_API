/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHKPTFSTS )                                        */
/*           Pgm( CBX947 )                                           */
/*           SrcMbr( CBX947X )                                       */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX947H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
         Cmd      Prompt( 'Check PTF Status' )


         Parm     PTFSTS        *Char    10       +
                  Dft( *NONAPY )                  +
                  Rstd( *YES )                    +
                  SpcVal(( *ACTRQD    )           +
                         ( *NOTAPY    )           +
                         ( *PTFSAVF   )           +
                         ( *COVERONLY )           +
                         ( *ONORDER   ))          +
                  SngVal( *NONAPY )               +
                  Max( 5 )                        +
                  Expr( *YES )                    +
                  Prompt( 'PTF status' )

         Parm     OPTION      *Char       4       +
                  Rstd( *YES )                    +
                  Dft( *MSG )                     +
                  SpcVal(( *MSG ) ( *DSP ))       +
                  Prompt( 'Option' )

         Parm     SELECT      *Char       4       +
                  Rstd( *YES )                    +
                  Dft( *NO  )                     +
                  SpcVal(( *NO  *ALL )            +
                         ( *YES *ANY ))           +
                  PmtCtl( *PMTRQS )               +
                  Prompt( 'Select product' )

