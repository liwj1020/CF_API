000100031114/*-------------------------------------------------------------------*/
000200031114/*                                                                   */
000300050210/*  Program . . : CBX930V                                            */
000400050122/*  Description : Print programs adopting special authorities - VCP  */
000500050122/*  Author  . . : Carsten Flensburg                                  */
000600031114/*                                                                   */
000700050122/*                                                                   */
000800031114/*  Programmer's notes:                                              */
000900031115/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000031115/*    message is mandatory for a command validity checking program.  */
001100031114/*                                                                   */
001200031114/*                                                                   */
001300031114/*  Compile options:                                                 */
001400050210/*    CrtClPgm   Pgm( CBX930V )                                      */
001500031114/*               SrcFile( QCLSRC )                                   */
001600031114/*               SrcMbr( *PGM )                                      */
001700031114/*                                                                   */
001800031114/*-------------------------------------------------------------------*/
001900050122     Pgm      ( &PgmLib           +
002000050122                &SpcAutL          +
002100050122                &SrtOrd           +
002200050306                &SysObj           +
002300110604                &GrpPrf           +
002400050122                &JobD_q           +
002500050122                &OutQ_q           +
002600050122              )
002700960301
002800991109/*-- Parameters:  ---------------------------------------------------*/
002900050122     Dcl        &PgmLib     *Char    10
003000050122     Dcl        &SpcAutL    *Char    82
003100050306     Dcl        &SysObj     *Char     4
003200110604     Dcl        &GrpPrf     *Char     4
003300050306     Dcl        &SrtOrd     *Char    10
003400050122     Dcl        &JobD_q     *Char    20
003500050122     Dcl        &OutQ_q     *Char    20
003600991109
003700050122/*-- Global variables:  ---------------------------------------------*/
003800050122     Dcl        &JobD       *Char    10
003900050122     Dcl        &JobD_l     *Char    10
004000050122     Dcl        &OutQ       *Char    10
004100050122     Dcl        &OutQ_l     *Char    10
004200991109
004300000906     Dcl        &Msg        *Char    80
004400960229
004500940809/*-- Global error monitoring:  --------------------------------------*/
004600000906     MonMsg     CPF0000     *N       GoTo Error
004700991109
004800991109/*-- Mainline -------------------------------------------------------*/
004900050122
005000050122     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
005100050122     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )
005200050122
005300050122     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
005400050122     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )
005500031114
005600050122     If       ( %Sst( &PgmLib  1  1 ) *NE '*' )   Do
005700050122
005800050226     ChkObj     Obj( &PgmLib )         +
005900050122                ObjType( *LIB )
006000050122     EndDo
006100991109
006200050122     If       ( %Sst( &JobD    1  1 ) *NE '*' )   Do
006300050122
006400050226     ChkObj     Obj( &JobD_l/&JobD )   +
006500050122                ObjType( *JOBD )
006600050122     EndDo
006700050122
006800050122     If       ( %Sst( &OutQ    1  1 ) *NE '*' )   Do
006900050122
007000050226     ChkObj     Obj( &OutQ_l/&OutQ )   +
007100050211                ObjType( *OUTQ )
007200050122     EndDo
007300050122
007400991109 Return:
007500991109     Return
007600960228
007700991109/*-- Error processor ------------------------------------------------*/
007800991109 Error:
007900031116     RcvMsg     MsgType( *EXCP )                      +
008000991109                Msg( &Msg )
008100031114
008200991109     ChgVar     &Msg         ( '0000' *Cat  &Msg )
008300031114
008400031116     SndPgmMsg  MsgId( CPD0006 )                      +
008500031116                MsgF( QCPFMSG )                       +
008600031116                MsgDta( &Msg )                        +
008700991109                MsgType( *DIAG )
008800031114
008900031116     SndPgmMsg  MsgId( CPF0002 )                      +
009000031116                MsgF( QCPFMSG )                       +
009100991109                MsgType( *ESCAPE )
009200960301
009300960229 EndPgm:
009400960301     EndPgm
