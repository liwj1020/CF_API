000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300050305/*  Program . . : CBX931V                                            */
000400050303/*  Description : Change object authority - VCP                      */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400050305/*    CrtClPgm   Pgm( CBX931V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900050303     Pgm      ( &ObjNam_q         +
002000050303                &ObjTyp           +
002100050303                &UsrPrf           +
002200050303                &CurAut           +
002300050303                &NewAut           +
002400050122              )
002500960301
002600991109/*-- Parameters:  ---------------------------------------------------*/
002700050303     Dcl        &ObjNam_q   *Char    20
002800050303     Dcl        &ObjTyp     *Char     7
002900050303     Dcl        &UsrPrf     *Char    10
003000050303     Dcl        &CurAut     *Char   102
003100050303     Dcl        &NewAut     *Char   102
003200991109
003300050122/*-- Global variables:  ---------------------------------------------*/
003400000906     Dcl        &Msg        *Char    80
003500960229
003600940809/*-- Global error monitoring:  --------------------------------------*/
003700000906     MonMsg     CPF0000     *N       GoTo Error
003800991109
003900991109/*-- Mainline -------------------------------------------------------*/
004000050122
004100050303     If       ( %Sst( &UsrPrf  1  1 ) *NE '*' )   Do
004200050122
004300050303     ChkObj     Obj( &UsrPrf )         +
004400050303                ObjType( *USRPRF )
004500050122     EndDo
004600050122
004700991109 Return:
004800991109     Return
004900960228
005000991109/*-- Error processor ------------------------------------------------*/
005100991109 Error:
005200031116     RcvMsg     MsgType( *EXCP )                      +
005300991109                Msg( &Msg )
005400031114
005500991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
005600031114
005700031116     SndPgmMsg  MsgId( CPD0006 )                      +
005800031116                MsgF( QCPFMSG )                       +
005900031116                MsgDta( &Msg )                        +
006000991109                MsgType( *DIAG )
006100031114
006200031116     SndPgmMsg  MsgId( CPF0002 )                      +
006300031116                MsgF( QCPFMSG )                       +
006400991109                MsgType( *ESCAPE )
006500960301
006600960229 EndPgm:
006700960301     EndPgm
