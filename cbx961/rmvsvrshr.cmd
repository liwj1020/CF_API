/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RMVSVRSHR )                                        */
/*           Pgm( CBX961 )                                           */
/*           SrcMbr( CBX961X )                                       */
/*           HlpPnlGrp( CBX961H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Remove Server Share' )

             Parm       SHARE       *Char       12         +
                        Min( 1 )                           +
                        Expr( *YES )                       +
                        Prompt( 'Share' )

