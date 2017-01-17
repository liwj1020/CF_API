000100050415/*-------------------------------------------------------------------*/
000200050415/*                                                                   */
000300060216/*  Program . . : CBX952V                                            */
000400060216/*  Description : Print job run attributes - CPP                     */
000500050415/*  Author  . . : Carsten Flensburg                                  */
000600050415/*                                                                   */
000700050415/*                                                                   */
000800050415/*  Programmer's notes:                                              */
000900050415/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000050415/*    message is mandatory for a command validity checking program.  */
001100050415/*                                                                   */
001200050415/*                                                                   */
001300050415/*  Compile options:                                                 */
001400060216/*    CrtClPgm   Pgm( CBX952V )                                      */
001500050415/*               SrcFile( QCLSRC )                                   */
001600050415/*               SrcMbr( *PGM )                                      */
001700050415/*                                                                   */
001800050415/*-------------------------------------------------------------------*/
001900060216     Pgm      ( &JobTyp           +
002000060216                &CpuTimLmt        +
002100060216                &TmpStgLmt        +
002200100403                &NbrAuxIo         +
002300050122                &SrtOrd           +
002400000906                &JobD_q           +
002500041212                &OutQ_q           +
002600041212              )
002700960301
002800991109/*-- Parameters:  ---------------------------------------------------*/
002900060216     Dcl        &JobTyp     *Char     1
003000060217     Dcl        &CpuTimLmt  *Char     4
003100060217     Dcl        &TmpStgLmt  *Char     4
003200100403     Dcl        &NbrAuxIo   *Char     4
003300050415     Dcl        &SrtOrd     *Char    22
003400050415     Dcl        &JobD_q     *Char    20
003500050415     Dcl        &OutQ_q     *Char    20
003600991109
003700991109/*-- Global variables:  ---------------------------------------------*/
003800000906     Dcl        &JobD       *Char    10
003900000906     Dcl        &JobD_l     *Char    10
004000041212     Dcl        &OutQ       *Char    10
004100041212     Dcl        &OutQ_l     *Char    10
004200041212
004300050415     Dcl        &Msg        *Char    80
004400000906
004500940809/*-- Global error monitoring:  --------------------------------------*/
004600050415     MonMsg   ( CPF0000  CPD0000 )   *N       GoTo Error
004700991109
004800050122
004900041212     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
005000041212     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )
005100041212
005200041212     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
005300041212     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )
005400041212
005500041212     If       ( &JobD_l = ' ' )    Do
005600041212     ChgVar     &JobD_l   '*N'
005700041212     EndDo
005800041212
005900050415     Else Do
006000050415     ChkObj     &JobD_l/&JobD      *JOBD
006100050415     EndDo
006200041212
006300041212     If       ( &OutQ_l = ' ' )    Do
006400041212     ChgVar     &OutQ_l   '*N'
006500041212     EndDo
006600041212
006700050415     Else Do
006800050415     ChkObj     &OutQ_l/&OutQ      *OUTQ
006900050415     EndDo
007000050417
007100991109 Return:
007200991109     Return
007300960228
007400050415/*-- Error processor ------------------------------------------------*/
007500050415 Error:
007600050415     RcvMsg     MsgType( *EXCP )                      +
007700050415                Msg( &Msg )
007800050415
007900050415     ChgVar     &Msg         ( '0000' *Cat  &Msg )
008000050415
008100050415     SndPgmMsg  MsgId( CPD0006 )                      +
008200050415                MsgF( QCPFMSG )                       +
008300050415                MsgDta( &Msg )                        +
008400050415                MsgType( *DIAG )
008500050415
008600050415     SndPgmMsg  MsgId( CPF0002 )                      +
008700050415                MsgF( QCPFMSG )                       +
008800050415                MsgType( *ESCAPE )
008900041212
009000960229 EndPgm:
009100960301     EndPgm
