000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300050325/*  Program . . : CBX933V                                            */
000400050325/*  Description : Start journal for library - VCP                    */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400050325/*    CrtClPgm   Pgm( CBX933V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900050325     Pgm      ( &LibNam           +
002000050325                &JrnNam_q         +
002100050325                &ObjNam           +
002200050325                &ObjTyp           +
002300050325                &Images           +
002400050325                &OmtJrnE          +
002500050122              )
002600960301
002700991109/*-- Parameters:  ---------------------------------------------------*/
002800050325     Dcl        &LibNam     *Char    10
002900050325     Dcl        &JrnNam_q   *Char    20
003000050325     Dcl        &ObjNam     *Char    10
003100050325     Dcl        &ObjTyp     *Char    10
003200050325     Dcl        &Images     *Char     6
003300050325     Dcl        &OmtJrnE    *Char    10
003400991109
003500050122/*-- Global variables:  ---------------------------------------------*/
003600050325     Dcl        &JrnNam     *Char    10
003700050325     Dcl        &JrnNam_l   *Char    10
003800991109
003900000906     Dcl        &Msg        *Char    80
004000960229
004100940809/*-- Global error monitoring:  --------------------------------------*/
004200000906     MonMsg     CPF0000     *N       GoTo Error
004300991109
004400991109/*-- Mainline -------------------------------------------------------*/
004500050122
004600050325     ChgVar     &JrnNam      %SSt( &JrnNam_q   1  10 )
004700050325     ChgVar     &JrnNam_l    %SSt( &JrnNam_q  11  10 )
004800050122
004900050325     ChkObj     Obj( &LibNam )             +
005000050325                ObjType( *LIB )
005100050325
005200050325     ChkObj     Obj( &JrnNam_l/&JrnNam )   +
005300050325                ObjType( *JRN )
005400050122
005500991109 Return:
005600991109     Return
005700960228
005800991109/*-- Error processor ------------------------------------------------*/
005900991109 Error:
006000031116     RcvMsg     MsgType( *EXCP )                      +
006100991109                Msg( &Msg )
006200031114
006300991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
006400031114
006500031116     SndPgmMsg  MsgId( CPD0006 )                      +
006600031116                MsgF( QCPFMSG )                       +
006700031116                MsgDta( &Msg )                        +
006800991109                MsgType( *DIAG )
006900031114
007000031116     SndPgmMsg  MsgId( CPF0002 )                      +
007100031116                MsgF( QCPFMSG )                       +
007200991109                MsgType( *ESCAPE )
007300960301
007400960229 EndPgm:
007500960301     EndPgm
