000100050513/*-------------------------------------------------------------------*/
000200050513/*                                                                   */
000300050513/*  Compile options:                                                 */
000400050513/*                                                                   */
000500051218/*    CrtCmd Cmd( DSPJOBIFSL )                                       */
000600051218/*           Pgm( CBX950 )                                           */
000700051218/*           SrcMbr( CBX950X )                                       */
000800050513/*           Mode( *PROD )                                           */
000900051218/*           HlpPnlGrp( CBX950H )                                    */
001000050513/*           HlpId( *CMD )                                           */
001100050513/*                                                                   */
001200050513/*-------------------------------------------------------------------*/
001300051218    Cmd        Prompt( 'Display job IFS object locks' )
001400020815
001500051218    Parm       JOB      JOB001                        +
001600051221               Dft( * )                               +
001700051221               SngVal(( * ))                          +
001800051218               Choice(*NONE)                          +
001900020815               Prompt('Job name')
002000020815
002100051218    Parm       OUTPUT     *Char        3              +
002200051218               Rstd( *YES )                           +
002300051218               Dft( * )                               +
002400051218               SpcVal(( *  DSP ) ( *PRINT  PRT ))     +
002500051218               Prompt( 'Output' )
002600051218
002700051222    Parm       LONGPATH   *Char        1              +
002800051222               Rstd( *YES )                           +
002900051222               Dft( *PARTIAL )                        +
003000051222               SpcVal(( *PARTIAL P ) ( *FULL F ))     +
003100051222               Prompt( 'Long path name' )
003200051222
003300050320
003400051218JOB001:                                               +
003500051218    Qual                *Name        10               +
003600051218               Min( 1 )                               +
003700020815               Expr( *YES )
003800020815
003900051218    Qual                *Name        10               +
004000051218               Expr( *YES )                           +
004100020815               Prompt( 'User' )
004200020815
004300051218    Qual                *Char         6               +
004400051218               Range( '000000' '999999' )             +
004500051218               Full( *YES )                           +
004600051218               Expr( *YES )                           +
004700020815               Prompt( 'Number' )
004800050320