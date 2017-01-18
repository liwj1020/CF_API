000100050722/*-------------------------------------------------------------------*/
000200050722/*                                                                   */
000300050722/*  Compile options:                                                 */
000400050722/*                                                                   */
000500050722/*    CrtCmd Cmd( RTVDIRSMTP )                                       */
000600050729/*           Pgm( CBX9411 )                                          */
000700050729/*           SrcMbr( CBX9411X )                                      */
000800050722/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
000900050729/*           HlpPnlGrp( CBX9411H )                                   */
001000050722/*           HlpId( *CMD )                                           */
001100050722/*                                                                   */
001200050722/*-------------------------------------------------------------------*/
001300050726          Cmd      Prompt( 'Retrieve Dir Entry SMTP Addr' )
001400050722
001500050722          Parm     USRID       E0001                            +
001600050722                   Dft( *USRPRF )                               +
001700050722                   SngVal(( *USRPRF ))                          +
001800050722                   Prompt( 'User identifier' )
001900050722
002000050722          Parm     USER        *Name      10                    +
002100050722                   Dft( *CURRENT )                              +
002200050722                   SpcVal(( *CURRENT ))                         +
002300050722                   Expr( *YES )                                 +
002400050722                   Prompt( 'User profile' )
002500050722
002600050726          Parm     SMTPADDR    *Char      63                    +
002700050722                   RtnVal( *YES )                               +
002800050726                   Prompt( 'CL var for SMTPADDR     (63)' )
002900050722
003000050722
003100050722E0001:    Elem                 *Char       8                    +
003200050722                   Min( 1 )                                     +
003300050722                   Expr( *YES )                                 +
003400050722                   Prompt( 'User ID' )
003500050722
003600050722          Elem                 *Char       8                    +
003700050722                   Min( 1 )                                     +
003800050722                   Expr( *YES )                                 +
003900050722                   Prompt( 'Address' )
004000050722
004100050722          Dep      Ctl( USER )                                  +
004200050722                   Parm(( USRID ))                              +
004300050722                   NbrTrue( *EQ 0 )                             +
004400050722                   MsgId( CPD9105 )
004500050722
