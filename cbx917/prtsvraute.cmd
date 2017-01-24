/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTSVRAUTE )                                       */
/*           Pgm( CBX917 )                                           */
/*           SrcMbr( CBX917X )                                       */
/*           HlpPnlGrp( CBX917H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Cmd        Prompt( 'Print server auth entries' )
 
     Parm       USRPRF        *SNAME      10        +
                Min( 1 )                            +
                Expr( *YES )                        +
                SpcVal(( *ALL ) ( *CURRENT ))       +
                Prompt( 'User profile' )
 
