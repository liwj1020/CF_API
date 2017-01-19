000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050209/*    CrtCmd Cmd( RTVUSRSPCA )                                       */
000600050210/*           Pgm( CBX929 )                                           */
000700050210/*           SrcMbr( CBX929X )                                       */
000800041201/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
000900050210/*           HlpPnlGrp( CBX929H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050209          Cmd      Prompt( 'Retrieve User Special Auth')
001400040311
001500041201          Parm     USRPRF        *Name                          +
001600041201                   Min( 1 )                                     +
001700041201                   SpcVal(( *CURRENT ))                         +
001800041201                   Expr( *YES )                                 +
001900041201                   Prompt( 'User profile' )
002000041201
002100050209          Parm     OPTION        *Char    10                    +
002200050209                   Dft( *USRPRF )                               +
002300041201                   Rstd( *YES )                                 +
002400050209                   SpcVal(( *USRPRF )                           +
002500050209                          ( *GRPPRF )                           +
002600050209                          ( *SUPGRP )                           +
002700050209                          ( *ALL ))                             +
002800041201                   Expr( *YES )                                 +
002900050209                   Prompt( 'Option' )
003000040723
003100050209          Parm     SPCAUT      *Char     150                    +
003200041201                   RtnVal( *YES )                               +
003300050210                   Prompt( 'CL var for SPCAUT      (150)' )
003400041201
