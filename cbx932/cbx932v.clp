000100050415/*-------------------------------------------------------------------*/
000200050415/*                                                                   */
000300050415/*  Program . . : CBX932V                                            */
000400050415/*  Description : Print save information - CPP                       */
000500050415/*  Author  . . : Carsten Flensburg                                  */
000600050415/*                                                                   */
000700050415/*                                                                   */
000800050415/*  Programmer's notes:                                              */
000900050415/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
001000050415/*    message is mandatory for a command validity checking program.  */
001100050415/*                                                                   */
001200050415/*                                                                   */
001300050415/*  Compile options:                                                 */
001400050415/*    CrtClPgm   Pgm( CBX932V )                                      */
001500050415/*               SrcFile( QCLSRC )                                   */
001600050415/*               SrcMbr( *PGM )                                      */
001700050415/*                                                                   */
001800050415/*-------------------------------------------------------------------*/
001900050415     Pgm      ( &LibNam           +
002000050415                &ObjLvl           +
002100050415                &IncDat           +
002200050122                &SrtOrd           +
002300000906                &JobD_q           +
002400041212                &OutQ_q           +
002500041212              )
002600960301
002700991109/*-- Parameters:  ---------------------------------------------------*/
002800050415     Dcl        &LibNam     *Char    12
002900050415     Dcl        &ObjLvl     *Char    10
003000050415     Dcl        &IncDat     *Char    19
003100050415     Dcl        &SrtOrd     *Char    22
003200050415     Dcl        &JobD_q     *Char    20
003300050415     Dcl        &OutQ_q     *Char    20
003400991109
003500991109/*-- Global variables:  ---------------------------------------------*/
003600000906     Dcl        &JobD       *Char    10
003700000906     Dcl        &JobD_l     *Char    10
003800041212     Dcl        &OutQ       *Char    10
003900041212     Dcl        &OutQ_l     *Char    10
004000050415
004100050415     Dcl        &ChkLib     *Char    10
004200050415     Dcl        &ChkSiz     *Dec      5
004300041212
004400050415     Dcl        &Msg        *Char    80
004500000906
004600940809/*-- Global error monitoring:  --------------------------------------*/
004700050415     MonMsg   ( CPF0000  CPD0000 )   *N       GoTo Error
004800991109
004900050122
005000041212     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
005100041212     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )
005200041212
005300041212     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
005400041212     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )
005500041212
005600041212     If       ( &JobD_l = ' ' )    Do
005700041212     ChgVar     &JobD_l   '*N'
005800041212     EndDo
005900041212
006000050415     Else Do
006100050415     ChkObj     &JobD_l/&JobD      *JOBD
006200050415     EndDo
006300041212
006400041212     If       ( &OutQ_l = ' ' )    Do
006500041212     ChgVar     &OutQ_l   '*N'
006600041212     EndDo
006700041212
006800050415     Else Do
006900050415     ChkObj     &OutQ_l/&OutQ      *OUTQ
007000050415     EndDo
007100041212
007200050415     ChgVar     &ChkSiz   %Bin( &LibNam  1  2 )
007300050415     ChgVar     &ChkLib   %Sst( &LibNam  3 10 )
007400050415
007500050415     If      (( %Sst( &ChkLib        1  1 ) *NE '*' )  *And     +
007600050415              ( %Sst( &ChkLib  &ChkSiz  1 ) *NE '*' )) Do
007700050415
007800050415     ChkObj     &ChkLib            *LIB
007900050415     EndDo
008000050415
008100050415     If       ( &ObjLvl *EQ '*OBJ' )                   Do
008200050415
008300050415     If       ( %Sst( &ChkLib  &ChkSiz  1 ) *EQ '*' )  Do
008400050415
008500050415     SndPgmMsg  MsgId( CPD3C45 )                      +
008600050415                MsgF( QCPFMSG )                       +
008700050415                MsgDta( &ChkLib )                     +
008800050415                ToPgmQ( *SAME * )                     +
008900050415                MsgType( *ESCAPE )
009000050415     EndDo
009100050415     EndDo
009200041212
009300050417
009400991109 Return:
009500991109     Return
009600960228
009700050415/*-- Error processor ------------------------------------------------*/
009800050415 Error:
009900050415     RcvMsg     MsgType( *EXCP )                      +
010000050415                Msg( &Msg )
010100050415
010200050415     ChgVar     &Msg         ( '0000' *Cat  &Msg )
010300050415
010400050415     SndPgmMsg  MsgId( CPD0006 )                      +
010500050415                MsgF( QCPFMSG )                       +
010600050415                MsgDta( &Msg )                        +
010700050415                MsgType( *DIAG )
010800050415
010900050415     SndPgmMsg  MsgId( CPF0002 )                      +
011000050415                MsgF( QCPFMSG )                       +
011100050415                MsgType( *ESCAPE )
011200041212
011300960229 EndPgm:
011400960301     EndPgm
