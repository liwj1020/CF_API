000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500041202/*    CrtCmd Cmd( RTVSPCAUT )                                        */
000600041202/*           Pgm( CBX9281 )                                          */
000700041202/*           SrcMbr( CBX9281X )                                      */
000800041201/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
000900041202/*           HlpPnlGrp( CBX9281H )                                   */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050209          Cmd      Prompt( 'Retrieve Special Authorities' )
001400040311
001500041201          Parm     USRPRF        *Name                          +
001600041201                   Min( 1 )                                     +
001700041201                   SpcVal(( *CURRENT ))                         +
001800041201                   Expr( *YES )                                 +
001900041201                   Prompt( 'User profile' )
002000041201
002100041201          Parm     SPCAUT        *Char    10                    +
002200041201                   Min( 1 )                                     +
002300041201                   Max( 8 )                                     +
002400041201                   Rstd( *YES )                                 +
002500041201                   SpcVal(( *ALLOBJ )                           +
002600041201                          ( *AUDIT )                            +
002700041201                          ( *IOSYSCFG )                         +
002800041201                          ( *JOBCTL )                           +
002900041201                          ( *SAVSYS )                           +
003000041201                          ( *SECADM )                           +
003100041201                          ( *SERVICE )                          +
003200041201                          ( *SPLCTL ))                          +
003300041201                   Expr( *YES )                                 +
003400041201                   Prompt( 'Special authority' )
003500040723
003600041201          Parm     AUTIND      *Char       1                    +
003700041201                   Min( 1 )                                     +
003800041201                   RtnVal( *YES )                               +
003900041201                   Prompt( 'CL var for AUTIND        (1)' )
004000041201
