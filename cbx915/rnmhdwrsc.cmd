/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RNMHDWRSC )                                        */
/*           Pgm( CBX915 )                                           */
/*           SrcMbr( CBX915X )                                       */
/*           HlpPnlGrp( CBX915H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
      Cmd        Prompt( 'Rename Hardware Resource' )
 
      Parm       HDWRSC        *Name                          +
                 Min( 1 )                                     +
                 Prompt( 'Resource' )
 
      Parm       NEWHDWRSC     *Name                          +
                 Min( 1 )                                     +
                 Prompt( 'New resource' )
 
