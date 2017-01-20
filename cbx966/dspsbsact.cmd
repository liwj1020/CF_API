/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPSBSACT )                                        */
/*           Pgm( CBX966 )                                           */
/*           SrcMbr( CBX966X )                                       */
/*           VldCkr( CBX966V )                                       */
/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX966H )                                    */
/*           HlpId( *CMD )                                           */
/*           Aut( *EXCLUDE )                                         */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Display Subsystem Activity' )

             Parm       SBS         Q0001                            +
                        Dft( *ACTIVE )                               +
                        SngVal(( *ACTIVE ))                          +
                        Prompt( 'Subsystem' )

             Parm       EXCLUDE     *Generic    10                   +
                        Dft( *NONE )                                 +
                        SpcVal(( *NONE  ' ' ))                       +
                        Prompt( 'Exclude subsystem library' )


 Q0001:      Qual                   *Generic    10                   +
                        SpcVal(( *ALL  *ALL ))                       +
                        Expr( *YES )

             Qual                   *Name                            +
                        Dft( *LIBL )                                 +
                        SpcVal(( *LIBL    )                          +
                               ( *CURLIB  )                          +
                               ( *USRLIBL )                          +
                               ( *ALLUSR  )                          +
                               ( *ALL     ))                         +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )

