000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050508/*    CrtCmd Cmd( ANZUSRPRF )                                        */
000600050506/*           Pgm( CBX936 )                                           */
000700050506/*           SrcMbr( CBX936X )                                       */
000800050506/*           HlpPnlGrp( CBX936H )                                    */
000900040408/*           HlpId( *CMD )                                           */
001000040408/*                                                                   */
001100040408/*-------------------------------------------------------------------*/
001200050508          Cmd      Prompt( 'Analyze User Profiles' )
001300050506
001400050507          Parm     SELECT        *Char    10                    +
001500050506                   Min( 1 )                                     +
001600050506                   Rstd( *YES )                                 +
001700050506                   SpcVal(( *DISABLED  )                        +
001800050506                          ( *EXPIRED   )                        +
001900050506                          ( *INVSIGNON )                        +
002000050506                          ( *NOGROUP   )                        +
002100050506                          ( *NOPWD     )                        +
002200050506                          ( *NOTLMTCAP ))                       +
002300041201                   Expr( *YES )                                 +
002400050507                   Prompt( 'Select' )
002500041219
002600050506          Parm     SYSPRF        *Char     4                    +
002700050306                   Dft( *YES )                                  +
002800050306                   Rstd( *YES )                                 +
002900050306                   SpcVal(( *YES )                              +
003000050306                          ( *NO  ))                             +
003100050306                   Expr( *YES )                                 +
003200050506                   Prompt( 'Include system profiles' )
003300050306
