000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300050328/*  Program . . : CBX934V                                            */
000400050328/*  Description : End journal for library - VCP                      */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400050328/*    CrtClPgm   Pgm( CBX934V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900050325     Pgm      ( &LibNam           +
002000050325                &ObjNam           +
002100050328                &ObjTyp           +
002200050328                &JrnNam_q         +
002300050122              )
002400960301
002500991109/*-- Parameters:  ---------------------------------------------------*/
002600050325     Dcl        &LibNam     *Char    10
002700050325     Dcl        &ObjNam     *Char    10
002800050325     Dcl        &ObjTyp     *Char    10
002900050328     Dcl        &JrnNam_q   *Char    20
003000991109
003100050122/*-- Global variables:  ---------------------------------------------*/
003200050325     Dcl        &JrnNam     *Char    10
003300050325     Dcl        &JrnNam_l   *Char    10
003400991109
003500000906     Dcl        &Msg        *Char    80
003600960229
003700940809/*-- Global error monitoring:  --------------------------------------*/
003800000906     MonMsg     CPF0000     *N       GoTo Error
003900991109
004000991109/*-- Mainline -------------------------------------------------------*/
004100050122
004200050325     ChgVar     &JrnNam      %SSt( &JrnNam_q   1  10 )
004300050325     ChgVar     &JrnNam_l    %SSt( &JrnNam_q  11  10 )
004400050325
004500050408     ChkObj     Obj( &LibNam )     ObjType( *LIB )
004600050408
004700050408     If       ( &JrnNam *NE '*OBJ' )       Do
004800050408
004900050408     ChkObj     Obj( &JrnNam_l/&JrnNam )   ObjType( *JRN )
005000050408     EndDo
005100050122
005200991109 Return:
005300991109     Return
005400960228
005500991109/*-- Error processor ------------------------------------------------*/
005600991109 Error:
005700031116     RcvMsg     MsgType( *EXCP )                      +
005800991109                Msg( &Msg )
005900031114
006000991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
006100031114
006200031116     SndPgmMsg  MsgId( CPD0006 )                      +
006300031116                MsgF( QCPFMSG )                       +
006400031116                MsgDta( &Msg )                        +
006500991109                MsgType( *DIAG )
006600031114
006700031116     SndPgmMsg  MsgId( CPF0002 )                      +
006800031116                MsgF( QCPFMSG )                       +
006900991109                MsgType( *ESCAPE )
007000960301
007100960229 EndPgm:
007200960301     EndPgm
