/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( VALCCSID )                                         */
/*           Pgm( CBX911 )                                           */
/*           SrcMbr( CBX911X )                                       */
/*           HlpPnlGrp( CBX911H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd        Prompt( 'Validate CCSID' )
 
          Parm       CCSID         *INT4              +
                     Min( 1 )                         +
                     Range( 1  65535 )                +
                     Expr( *YES )                     +
                     Prompt( 'Coded character set ID' )
 
