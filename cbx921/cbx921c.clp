000100040828/*-------------------------------------------------------------------*/
000200040828/*                                                                   */
000300040828/*  Program . . : CBX921CL                                           */
000400040828/*  Description : User profile initial program - sample              */
000500040828/*  Author  . . : Carsten Flensburg                                  */
000600040828/*                                                                   */
000700040828/*                                                                   */
000800040828/*  Compile options:                                                 */
000900040828/*                                                                   */
001000040828/*    CrtClPgm   Pgm( CBX921CL )                                     */
001100040828/*               SrcFile( QCLSRC )                                   */
001200040828/*               SrcMbr( *PGM )                                      */
001300040828/*                                                                   */
001400040828/*                                                                   */
001500040828/*-------------------------------------------------------------------*/
001600991125     Pgm
001700980212
001800040828/*-- Global variables:  ---------------------------------------------*/
001900040828     Dcl        &WksMsgQ     *Char     10
002000040828     Dcl        &UsrMsgQ     *Char     10
002100040828     Dcl        &UsrMsgQlib  *Char     10
002200040828
002300040828     Dcl        &BrkHdlPgm   *Char     10     'CBX921'
002400040828     Dcl        &BrkHdlLib   *Char     10     'QGPL'
002500980212
002600040828/*-- Global error monitor:  -----------------------------------------*/
002700040828     MonMsg     CPF0000
002800040825
002900040828
003000040828/*-- Work station message queue:  -----------------------------------*/
003100040828     RtvJobA    Job( &WksMsgQ )
003200040828
003300040828     AlcObj     Obj(( &WksMsgQ  *MSGQ  *EXCL ))   Wait( 0 )
003400040828     MonMsg   ( CPF1002  CPF1085 )     *N     Do
003500040828
003600040828     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
003700040828     GoTo       SkpWksMsgQ
003800040825     EndDo
003900040828
004000040828     DlcObj     Obj(( &WksMsgQ  *MSGQ  *EXCL ))
004100040825
004200040828     ChgMsgQ    MsgQ( *WRKSTN )                            +
004300040828                Dlvry( *BREAK )                            +
004400040828                Pgm( &BrkHdlLib/&BrkHdlPgm  *NOALWRPY )
004500040828
004600040825     MonMsg     CPF2451
004700040828SkpWksMsgQ:
004800040828
004900040828/*-- User profile message queue:  -----------------------------------*/
005000040828     RtvUsrPrf  MsgQ( &UsrMsgQ )  MsgQlib( &UsrMsgQlib )
005100040828
005200040828     AlcObj     Obj(( &UsrMsgQlib/&UsrMsgQ  *MSGQ  *EXCL ))  Wait( 0 )
005300040828     MonMsg   ( CPF1002  CPF1085 )     *N     Do
005400040828
005500040828     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
005600040828     GoTo       SkpUsrMsgQ
005700040828     EndDo
005800040828
005900040828     DlcObj     Obj(( &UsrMsgQlib/&UsrMsgQ  *MSGQ  *EXCL ))
006000040828
006100040828     ChgMsgQ    MsgQ( *USRPRF )                            +
006200040828                Dlvry( *BREAK )                            +
006300040828                Pgm( &BrkHdlLib/&BrkHdlPgm  *NOALWRPY )
006400040828
006500040828     MonMsg     CPF2451
006600040828SkpUsrMsgQ:
006700040828
006800040828/*-- Perform other job initialization tasks:  -----------------------*/
006900040828
007000040828
007100040828
007200040828
007300040828/*-- End of initial program:  ---------------------------------------*/
007400040828EndPgm:
007500991125     EndPgm
