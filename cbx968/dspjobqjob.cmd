000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500061114/*    CrtCmd Cmd( DSPJOBQJOB )                                       */
000600070123/*           Pgm( CBX968 )                                           */
000700070123/*           SrcMbr( CBX968X )                                       */
000800070123/*           VldCkr( CBX968V )                                       */
000900060519/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
001000060519/*           AlwLmtUsr( *NO )                                        */
001100070123/*           HlpPnlGrp( CBX968H )                                    */
001200031113/*           HlpId( *CMD )                                           */
001300031113/*                                                                   */
001400031113/*-------------------------------------------------------------------*/
001500061114             Cmd        Prompt( 'Display Job Queue Jobs' )
001600930930
001700060506             Parm       JOBQ        Q0001                            +
001800040925                        Min( 1 )                                     +
001900060430                        Prompt( 'Job queue' )
002000040925
002100040926
002200040926 Q0001:      Qual                   *Name                            +
002300040926                        Expr( *YES )
002400040926
002500040926             Qual                   *Name                            +
002600040926                        Dft( *LIBL )                                 +
002700040926                        SpcVal(( *LIBL ) ( *CURLIB ))                +
002800040926                        Expr( *YES )                                 +
002900040926                        Prompt( 'Library' )
003000040925
