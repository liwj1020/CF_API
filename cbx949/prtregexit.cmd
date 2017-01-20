/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTREGEXIT )                                       */
/*           Pgm( CBX949 )                                           */
/*           SrcMbr( CBX949X )                                       */
/*           HlpPnlGrp( CBX949H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print Registered Exit Programs' )


          Parm     EXITPNT       *Generic   20                  +
                   Dft( *REGISTERED )                           +
                   SpcVal(( *REGISTERED   )                     +
                          ( *UNREGISTERED )                     +
                          ( *ALL          ))                    +
                   Prompt( 'Exit point' )

