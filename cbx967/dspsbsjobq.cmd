/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPSBSJOBQ )                                       */
/*           Pgm( CBX967 )                                           */
/*           SrcMbr( CBX967X )                                       */
/*           VldCkr( CBX967V )                                       */
/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX967H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Display Subsystem Job Queues' )

             Parm       SBS         Q0001                            +
                        Min( 1 )                                     +
                        Prompt( 'Subsystem' )


 Q0001:      Qual                   *Name                            +
                        Expr( *YES )

             Qual                   *Name                            +
                        Dft( *LIBL )                                 +
                        SpcVal(( *LIBL ) ( *CURLIB ))                +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )

