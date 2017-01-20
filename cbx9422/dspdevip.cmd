/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPDEVIP )                                         */
/*           Pgm( CBX9422 )                                          */
/*           SrcMbr( CBX9422X )                                      */
/*           HlpPnlGrp( CBX9422H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Display Device IP Address' )

          Parm     DEV         *Name      10                    +
                   Dft( *CURRENT )                              +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Device' )

