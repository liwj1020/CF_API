000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500061122/*    CrtCmd Cmd( DSPSBSACT )                                        */
000600070102/*           Pgm( CBX966 )                                           */
000700070102/*           SrcMbr( CBX966X )                                       */
000800070102/*           VldCkr( CBX966V )                                       */
000900060519/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
001000070128/*           AlwLmtUsr( *NO )                                        */
001100070102/*           HlpPnlGrp( CBX966H )                                    */
001200031113/*           HlpId( *CMD )                                           */
001300070127/*           Aut( *EXCLUDE )                                         */
001400070127/*                                                                   */
001500031113/*-------------------------------------------------------------------*/
001600061122             Cmd        Prompt( 'Display Subsystem Activity' )
001700930930
001800060506             Parm       SBS         Q0001                            +
001900060519                        Dft( *ACTIVE )                               +
002000060519                        SngVal(( *ACTIVE ))                          +
002100060504                        Prompt( 'Subsystem' )
002200040925
002300060506             Parm       EXCLUDE     *Generic    10                   +
002400060506                        Dft( *NONE )                                 +
002500060506                        SpcVal(( *NONE  ' ' ))                       +
002600060525                        Prompt( 'Exclude subsystem library' )
002700060506
002800040926
002900060506 Q0001:      Qual                   *Generic    10                   +
003000060506                        SpcVal(( *ALL  *ALL ))                       +
003100040926                        Expr( *YES )
003200040926
003300040926             Qual                   *Name                            +
003400040926                        Dft( *LIBL )                                 +
003500060512                        SpcVal(( *LIBL    )                          +
003600060512                               ( *CURLIB  )                          +
003700060512                               ( *USRLIBL )                          +
003800060512                               ( *ALLUSR  )                          +
003900060512                               ( *ALL     ))                         +
004000040926                        Expr( *YES )                                 +
004100040926                        Prompt( 'Library' )
004200040925
