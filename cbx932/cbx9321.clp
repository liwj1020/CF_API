000100041212/*-------------------------------------------------------------------*/
000200041212/*                                                                   */
000300050415/*  Program . . : CBX9321                                            */
000400050415/*  Description : Print save information - CPP                       */
000500041212/*  Author  . . : Carsten Flensburg                                  */
000600041212/*                                                                   */
000700041212/*                                                                   */
000800041212/*  Compile options:                                                 */
000900041212/*                                                                   */
001000050415/*    CrtClPgm   Pgm( CBX9321 )                                      */
001100041212/*               SrcFile( QCLSRC )                                   */
001200041212/*               SrcMbr( *PGM )                                      */
001300041212/*                                                                   */
001400041212/*                                                                   */
001500041212/*-------------------------------------------------------------------*/
001600050415     Pgm      ( &LibNam           +
001700050415                &ObjLvl           +
001800050415                &IncDat           +
001900050122                &SrtOrd           +
002000000906                &JobD_q           +
002100041212                &OutQ_q           +
002200041212              )
002300960301
002400991109/*-- Parameters:  ---------------------------------------------------*/
002500050415     Dcl        &LibNam     *Char    12
002600050415     Dcl        &ObjLvl     *Char    10
002700050415     Dcl        &IncDat     *Char    19
002800050415     Dcl        &SrtOrd     *Char    22
002900050415     Dcl        &JobD_q     *Char    20
003000050415     Dcl        &OutQ_q     *Char    20
003100991109
003200991109/*-- Global variables:  ---------------------------------------------*/
003300000906     Dcl        &JobD       *Char    10
003400000906     Dcl        &JobD_l     *Char    10
003500041212     Dcl        &OutQ       *Char    10
003600041212     Dcl        &OutQ_l     *Char    10
003700050415
003800050415     Dcl        &ChkLib     *Char    10
003900050415     Dcl        &ChkSiz     *Dec      5
004000041212
004100000906     Dcl        &JobTyp     *Char     1
004200000906
004300940809/*-- Global error monitoring:  --------------------------------------*/
004400000906     MonMsg     CPF0000     *N       GoTo Error
004500991109
004600050122
004700041212     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
004800041212     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )
004900041212
005000041212     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
005100041212     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )
005200041212
005300041212     If       ( &JobD_l = ' ' )    Do
005400041212     ChgVar     &JobD_l   '*N'
005500041212     EndDo
005600041212
005700041212     If       ( &OutQ_l = ' ' )    Do
005800041212     ChgVar     &OutQ_l   '*N'
005900041212     EndDo
006000050415
006100000906     RtvJobA    Type( &JobTyp )
006200041212
006300050421     If       ( &JobTyp   =  '1' )     Do
006400000906
006500050415     SbmJob     Cmd( Call Pgm( CBX9322 )                        +
006600050415                          Parm( &LibNam                         +
006700050415                                &ObjLvl                         +
006800050415                                &IncDat                         +
006900050415                                &SrtOrd ))                      +
007000050415                Job( PRTSAVINF )                                +
007100050415                JobD( &JobD_l/&JobD )                           +
007200041212                OutQ( &OutQ_l/&OutQ )
007300000906
007400050415     Call       QMHMOVPM    ( '    '                            +
007500050415                             '*COMP'                            +
007600050415                             x'00000001'                        +
007700050415                             '*PGMBDY'                          +
007800050415                             x'00000001'                        +
007900050415                             x'0000000800000000'                +
008000041212                           )
008100000906
008200000906     EndDo
008300041212
008400050421     Else If  ( &JobTyp   =  '0' )     Do
008500050415
008600050415     Call       Pgm( CBX9322 )                                  +
008700050415                Parm( &LibNam &ObjLvl &IncDat &SrtOrd )
008800050415
008900050415     EndDo
009000041212
009100991109 Return:
009200991109     Return
009300960228
009400041212/*-- Resend system error messages:  ---------------------------------*/
009500991109 Error:
009600050415     Call       QMHMOVPM    ( '    '                            +
009700050415                              '*DIAG'                           +
009800050415                              x'00000001'                       +
009900050415                              '*PGMBDY'                         +
010000050415                              x'00000001'                       +
010100050415                              x'0000000800000000'               +
010200041212                            )
010300041212
010400050415     Call       QMHRSNEM    ( '    '                            +
010500050415                              x'0000000800000000'               +
010600041212                            )
010700041212
010800960229 EndPgm:
010900960301     EndPgm
