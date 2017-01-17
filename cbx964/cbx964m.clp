000100041002/*-------------------------------------------------------------------*/
000200041002/*                                                                   */
000300061106/*  Program . . : CBX964M                                            */
000400061106/*  Description : Work with Server Shares - Create command           */
000500041002/*  Author  . . : Carsten Flensburg                                  */
000600061106/*  Published . : System iNetwork Systems Management Tips Newsletter */
000700041002/*                                                                   */
000800041002/*                                                                   */
000900041207/*  Program function:  Compiles, creates and configures all the      */
001000061106/*                     Work with Server Shares command objects.      */
001100060616/*                                                                   */
001200041002/*                     This program expects a single parameter       */
001300041002/*                     specifying the library to contain the         */
001400041002/*                     command objects.                              */
001500041002/*                                                                   */
001600041002/*                     Object sources must exist in the respective   */
001700041002/*                     source type default source files in the       */
001800041002/*                     command object library.                       */
001900041002/*                                                                   */
002000060103/*                                                                   */
002100041002/*  Compile options:                                                 */
002200061106/*    CrtClPgm    Pgm( CBX964M )                                     */
002300041002/*                SrcFile( QCLSRC )                                  */
002400041002/*                SrcMbr( *PGM )                                     */
002500041002/*                                                                   */
002600041002/*-------------------------------------------------------------------*/
002700041002     Pgm    &UtlLib
002800030905
002900041002     Dcl    &UtlLib         *Char     10
003000030909
003100041002     MonMsg      CPF0000    *N        GoTo Error
003200051129
003300060407
003400061126     CrtMsgF     MsgF( &UtlLib/CBX964M )  Aut( *USE )
003500061126
003600170117     AddMsgD    CBX0001 MsgF( &UtlLib/CBX964M ) Msg( 'No server shares match specified +
003700170117                  criteria' ) SecLvl( *NONE )
004000061126
004100170117     AddMsgD    CBX0011 MsgF( &UtlLib/CBX964M ) Msg( 'Specified share type is not valid.' ) +
004200170117                  SecLvl( '&N Cause . . . . . :   The share type that you specified is not +
004300170117                  allowed. &N Recovery  . . . :   Specify either *ALL, *FILE or *PRINT for the +
004400170117                  share type.' )
004800051129
004900061202
005000170117     CrtRpgMod  &UtlLib/CBX964 SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )
005400041207
005500170117     CrtPgm     &UtlLib/CBX964 Module( &UtlLib/CBX964 ) ActGrp( *NEW )
005800060407
005900060525
006000170117     CrtRpgMod  &UtlLib/CBX964E SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )
006400060415
006500170117     CrtPgm     &UtlLib/CBX964E Module( &UtlLib/CBX964E ) ActGrp( *CALLER )
006800060415
006900041207
007000170117     CrtRpgMod  &UtlLib/CBX964V SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )
007400060525
007500170117     CrtPgm     &UtlLib/CBX964V Module( &UtlLib/CBX964V ) ActGrp( *CALLER )
007800060525
007900060525
008000170117     CrtPnlGrp  &UtlLib/CBX964H SrcFile( OSSILESRC/CBX964 ) SrcMbr( *PNLGRP )
008300060407
008400170117     CrtPnlGrp  &UtlLib/CBX964P SrcFile( OSSILESRC/CBX964 ) SrcMbr( *PNLGRP )
008700060415
008800060407
008900170117     CrtCmd     Cmd( &UtlLib/WRKSVRSHR ) Pgm( CBX964 ) SrcFile( OSSILESRC/CBX964 ) SrcMbr( +
009000170117                  CBX964X ) VldCkr( CBX964V ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX964H ) HlpId( +
009100170117                  *CMD )
009700060407
009800060407
009900061106     SndPgmMsg   Msg( 'Work with Server Shares command'   *Bcat +
010000060730                      'successfully created in library'   *Bcat +
010100060730                      &UtlLib                             *Tcat +
010200060730                      '.' )                                     +
010300041010                 MsgType( *COMP )
010400050110
010500050110
010600050110     Call        QMHMOVPM    ( '    '                 +
010700050110                               '*COMP'                +
010800050110                               x'00000001'            +
010900050110                               '*PGMBDY'              +
011000050110                               x'00000001'            +
011100050110                               x'0000000800000000'    +
011200060113                             )
011300051204
011400051204     RmvMsg      Clear( *ALL )
011500050110
011600030905     Return
011700030905
011800030905/*-- Error handling:  -----------------------------------------------*/
011900030905 Error:
012000041002     Call        QMHMOVPM    ( '    '                 +
012100041002                               '*DIAG'                +
012200041002                               x'00000001'            +
012300041002                               '*PGMBDY'              +
012400041002                               x'00000001'            +
012500041002                               x'0000000800000000'    +
012600041002                             )
012700030905
012800041002     Call        QMHRSNEM    ( '    '                 +
012900041002                               x'0000000800000000'    +
013000041002                             )
013100030905
013200030905 EndPgm:
013300030905     EndPgm
