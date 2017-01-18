000100050722/*-------------------------------------------------------------------*/
000200050722/*                                                                   */
000300050722/*  Compile options:                                                 */
000400050722/*                                                                   */
000500050724/*    CrtCmd Cmd( DSPDIRSMTP )                                       */
000600050724/*           Pgm( CBX9412 )                                          */
000700050724/*           SrcMbr( CBX9412X )                                      */
000800050724/*           HlpPnlGrp( CBX9412H )                                   */
000900050722/*           HlpId( *CMD )                                           */
001000050722/*                                                                   */
001100050722/*-------------------------------------------------------------------*/
001200050726          Cmd      Prompt( 'Display Dir Entry SMTP Addr' )
001300050722
001400050722          Parm     USRID       E0001                            +
001500050722                   Dft( *USRPRF )                               +
001600050722                   SngVal(( *USRPRF ))                          +
001700050722                   Prompt( 'User identifier' )
001800050722
001900050722          Parm     USER        *Name      10                    +
002000050722                   Dft( *CURRENT )                              +
002100050722                   SpcVal(( *CURRENT ))                         +
002200050722                   Expr( *YES )                                 +
002300050722                   Prompt( 'User profile' )
002400050722
002500050722
002600050722E0001:    Elem                 *Char       8                    +
002700050722                   Min( 1 )                                     +
002800050722                   Expr( *YES )                                 +
002900050722                   Prompt( 'User ID' )
003000050722
003100050722          Elem                 *Char       8                    +
003200050722                   Min( 1 )                                     +
003300050722                   Expr( *YES )                                 +
003400050722                   Prompt( 'Address' )
003500050722
003600050722          Dep      Ctl( USER )                                  +
003700050722                   Parm(( USRID ))                              +
003800050722                   NbrTrue( *EQ 0 )                             +
003900050722                   MsgId( CPD9105 )
004000050722