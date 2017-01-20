/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPATR )                                           */
/*           Pgm( CBX927 )                                           */
/*           SrcMbr( CBX927X )                                       */
/*           VldCkr( CBX927V )                                       */
/*           HlpPnlGrp( CBX927H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Cmd        Prompt( 'Display Attributes' )

     Parm       OBJ        *Pname    5000             +
                Min( 1 )                              +
                Vary( *YES *INT2 )                    +
                Case( *MIXED )                        +
                Keyparm( *YES )                       +
                Prompt( 'Object' )

     Parm       OUTPUT     *Char        3             +
                Rstd( *YES )                          +
                Dft( * )                              +
                SpcVal(( *  DSP ) ( *PRINT  PRT ))    +
                Prompt( 'Output' )

