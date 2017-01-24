/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPCCSID )                                         */
/*           Pgm( CBX916 )                                           */
/*           SrcMbr( CBX916X )                                       */
/*           HlpPnlGrp( CBX916H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Cmd        Prompt( 'Display language default CCSID' )
 
     Parm       LNGID           *CHAR        3        +
                Min( 1 )                              +
                Choice( *PGM )                        +
                ChoicePgm( CBX916C  )                 +
                Prompt( 'Language ID')
 
