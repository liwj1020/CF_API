000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300050825/*  Program . . : CBX943V                                            */
000400050825/*  Description : Print journal report - VCP                         */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400050825/*    CrtClPgm   Pgm( CBX943V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900050825     Pgm      ( &ObjLib           +
002000050825                &ObjTyp           +
002100050825                &RptTyp           +
002200050122                &SrtOrd           +
002300050122                &JobD_q           +
002400050122                &OutQ_q           +
002500050122              )
002600960301
002700991109/*-- Parameters:  ---------------------------------------------------*/
002800050825     Dcl        &ObjLib     *Char    10
002900050825     Dcl        &ObjTyp     *Char    10
003000050825     Dcl        &RptTyp     *Char    10
003100050306     Dcl        &SrtOrd     *Char    10
003200050122     Dcl        &JobD_q     *Char    20
003300050122     Dcl        &OutQ_q     *Char    20
003400991109
003500050122/*-- Global variables:  ---------------------------------------------*/
003600050122     Dcl        &JobD       *Char    10
003700050122     Dcl        &JobD_l     *Char    10
003800050122     Dcl        &OutQ       *Char    10
003900050122     Dcl        &OutQ_l     *Char    10
004000991109
004100000906     Dcl        &Msg        *Char    80
004200960229
004300940809/*-- Global error monitoring:  --------------------------------------*/
004400000906     MonMsg     CPF0000     *N       GoTo Error
004500991109
004600991109/*-- Mainline -------------------------------------------------------*/
004700050122
004800050122     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
004900050122     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )
005000050122
005100050122     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
005200050122     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )
005300031114
005400050825     If       ( %Sst( &ObjLib  1  1 ) *NE '*' )   Do
005500050122
005600050825     ChkObj     Obj( &ObjLib )         +
005700050122                ObjType( *LIB )
005800050830     EndDo
005900991109
006000050122     If       ( %Sst( &JobD    1  1 ) *NE '*' )   Do
006100050122
006200050226     ChkObj     Obj( &JobD_l/&JobD )   +
006300050122                ObjType( *JOBD )
006400050122     EndDo
006500050122
006600050122     If       ( %Sst( &OutQ    1  1 ) *NE '*' )   Do
006700050122
006800050226     ChkObj     Obj( &OutQ_l/&OutQ )   +
006900050211                ObjType( *OUTQ )
007000050122     EndDo
007100050122
007200991109 Return:
007300991109     Return
007400960228
007500991109/*-- Error processor ------------------------------------------------*/
007600991109 Error:
007700031116     RcvMsg     MsgType( *EXCP )                      +
007800991109                Msg( &Msg )
007900031114
008000991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
008100031114
008200031116     SndPgmMsg  MsgId( CPD0006 )                      +
008300031116                MsgF( QCPFMSG )                       +
008400031116                MsgDta( &Msg )                        +
008500991109                MsgType( *DIAG )
008600031114
008700031116     SndPgmMsg  MsgId( CPF0002 )                      +
008800031116                MsgF( QCPFMSG )                       +
008900991109                MsgType( *ESCAPE )
009000960301
009100960229 EndPgm:
009200960301     EndPgm
