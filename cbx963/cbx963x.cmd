/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd  Cmd( DSPSVRSHR )                                       */
/*            Pgm( CBX963 )                                          */
/*            VldCkr( CBX963V )                                      */
/*            SrcMbr( CBX963X )                                      */
/*            HlpPnlGrp( CBX963H )                                   */
/*            HlpId( *CMD )                                          */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd      Prompt( 'Display Server Share' )

             Parm     SHARE       *Char       12                +
                      Min( 1 )                                  +
                      Expr( *YES )                              +
                      Prompt( 'Share' )

             Parm     OUTPUT      *Char       3                 +
                      Rstd( *YES )                              +
                      Dft( * )                                  +
                      SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))      +
                      Prompt( 'Output' )

