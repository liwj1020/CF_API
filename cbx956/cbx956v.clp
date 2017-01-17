000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300060217/*  Program . . : CBX956V                                            */
000400060217/*  Description : Print User Authorization Lists - VCP               */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400060217/*    CrtClPgm   Pgm( CBX956V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900060219     Pgm      ( &UsrPrf  &IncGrp )
002000960301
002100991109/*-- Parameters:  ---------------------------------------------------*/
002200060217     Dcl        &UsrPrf     *Char    10
002300060219     Dcl        &IncGrp     *Char     1
002400991109
002500050122/*-- Global variables:  ---------------------------------------------*/
002600000906     Dcl        &Msg        *Char    80
002700960229
002800940809/*-- Global error monitoring:  --------------------------------------*/
002900000906     MonMsg     CPF0000     *N       GoTo Error
003000991109
003100050122
003200060217     ChkObj     Obj( &UsrPrf )  ObjType( *USRPRF )
003300050122
003400991109 Return:
003500991109     Return
003600960228
003700991109/*-- Error processor ------------------------------------------------*/
003800991109 Error:
003900031116     RcvMsg     MsgType( *EXCP )                      +
004000991109                Msg( &Msg )
004100031114
004200991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
004300031114
004400031116     SndPgmMsg  MsgId( CPD0006 )                      +
004500031116                MsgF( QCPFMSG )                       +
004600031116                MsgDta( &Msg )                        +
004700991109                MsgType( *DIAG )
004800031114
004900031116     SndPgmMsg  MsgId( CPF0002 )                      +
005000031116                MsgF( QCPFMSG )                       +
005100991109                MsgType( *ESCAPE )
005200960301
005300960229 EndPgm:
005400960301     EndPgm
