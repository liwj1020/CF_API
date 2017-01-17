000100060216/*-------------------------------------------------------------------*/
000200060216/*                                                                   */
000300060505/*  Program . . : CBX955T                                            */
000400060505/*  Description : Test the SCAN CL command.                          */
000500060216/*  Author  . . : Carsten Flensburg                                  */
000600060216/*                                                                   */
000700060216/*                                                                   */
000800060216/*  Compile options:                                                 */
000900060216/*                                                                   */
001000060505/*    CrtClPgm   Pgm( CBX955T )                                      */
001100060216/*               SrcFile( QCLSRC )                                   */
001200060216/*               SrcMbr( *PGM )                                      */
001300060216/*                                                                   */
001400060216/*-------------------------------------------------------------------*/
001500070807     Pgm
001600060216
001700060216     Dcl        &Pos        *Dec      3
001800070807     Dcl        &PosAlf     *Char     3
001900940414
002000070807
002100060216/*-- Global error monitoring:  --------------------------------------*/
002200060216     MonMsg     CPF0000     *N       GoTo Error
002300940408
002400070807
002500070807     Scan       String( 'This is a very simple SCAN test.' )    +
002600070807                Pattern( TEST )                                 +
002700070807                Translate( *YES )                               +
002800060505                Result( &Pos )
002900940408
003000070807/*-- Variable &Pos now contains the string location of the pattern --*/
003100070807
003200070807     ChgVar     &PosAlf    &Pos
003300070807
003400070807     SndPgmMsg  Msg( 'Pattern found in position' *Bcat &PosAlf )    +
003500070807                ToPgmQ( *PRV )
003600070807
003700060216 Return:
003800060216     Return
003900060216
004000060216/*-- Resend system error messages:  ---------------------------------*/
004100060216 Error:
004200060216     Call       QMHMOVPM    ( '    '                            +
004300060216                              '*DIAG'                           +
004400060216                              x'00000001'                       +
004500060216                              '*PGMBDY'                         +
004600060216                              x'00000001'                       +
004700060216                              x'0000000800000000'               +
004800060216                            )
004900060216
005000060216     Call       QMHRSNEM    ( '    '                            +
005100060216                              x'0000000800000000'               +
005200060216                            )
005300060216
005400060216 EndPgm:
005500060216     EndPgm
