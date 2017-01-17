000100041002/*-------------------------------------------------------------------*/
000200041002/*                                                                   */
000300061106/*  Program . . : CBX963M                                            */
000400061106/*  Description : Display Server Sharre - Create command             */
000500041002/*  Author  . . : Carsten Flensburg                                  */
000600061106/*  Published . : System iNetwork Systems Management Tips Newsletter */
000700041002/*                                                                   */
000800041002/*                                                                   */
000900041207/*  Program function:  Compiles, creates and configures all the      */
001000061106/*                     Display Server Share command objects.         */
001100041207/*                                                                   */
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
002200061106/*    CrtClPgm    Pgm( CBX963M )                                     */
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
003400061106     CrtMsgF     MsgF( &UtlLib/CBX963M )  Aut( *USE )
003500060415
003600170117     AddMsgD    CBX0001 MsgF( &UtlLib/CBX963M ) Msg( 'Display entire path' ) SecLvl( *NONE )
004000060415
004100170117     AddMsgD    CBX0002 MsgF( &UtlLib/CBX963M ) Msg( 'Display file extensions' ) SecLvl( *NONE +
004200170117                  )
004500051129
004600061106
004700170117     CrtRpgMod  &UtlLib/CBX963 SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )
005100041207
005200170117     CrtPgm     &UtlLib/CBX963 Module( &UtlLib/CBX963 ) ActGrp( *NEW )
005500060407
005600170117     CrtRpgMod  &UtlLib/CBX963E SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )
006000060415
006100170117     CrtPgm     &UtlLib/CBX963E Module( &UtlLib/CBX963E ) ActGrp( *CALLER )
006400060415
006500170117     CrtRpgMod  &UtlLib/CBX963V SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )
006900061106
007000170117     CrtPgm     &UtlLib/CBX963V Module( &UtlLib/CBX963V ) ActGrp( *CALLER )
007300061106
007400041207
007500170117     CrtPnlGrp  &UtlLib/CBX963H SrcFile( OSSILESRC/CBX963 ) SrcMbr( *PNLGRP )
007800060407
007900170117     CrtPnlGrp  &UtlLib/CBX963P SrcFile( OSSILESRC/CBX963 ) SrcMbr( *PNLGRP )
008200060415
008300060407
008400170117     CrtCmd     Cmd( &UtlLib/DSPSVRSHR ) Pgm( CBX963 ) VldCkr( CBX963V ) SrcFile( +
008500170117                  OSSILESRC/CBX963 ) SrcMbr( CBX963X ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX963H ) +
008600170117                  HlpId( *CMD )
009200060407
009300060407
009400061106     SndPgmMsg   Msg( 'Display Server Share command'        *Bcat +
009500060407                      'successfully created in library'     *Bcat +
009600060407                      &UtlLib                               *Tcat +
009700060407                      '.' )                                       +
009800041010                 MsgType( *COMP )
009900050110
010000050110
010100050110     Call        QMHMOVPM    ( '    '                 +
010200050110                               '*COMP'                +
010300050110                               x'00000001'            +
010400050110                               '*PGMBDY'              +
010500050110                               x'00000001'            +
010600050110                               x'0000000800000000'    +
010700060113                             )
010800051204
010900051204     RmvMsg      Clear( *ALL )
011000050110
011100030905     Return
011200030905
011300030905/*-- Error handling:  -----------------------------------------------*/
011400030905 Error:
011500041002     Call        QMHMOVPM    ( '    '                 +
011600041002                               '*DIAG'                +
011700041002                               x'00000001'            +
011800041002                               '*PGMBDY'              +
011900041002                               x'00000001'            +
012000041002                               x'0000000800000000'    +
012100041002                             )
012200030905
012300041002     Call        QMHRSNEM    ( '    '                 +
012400041002                               x'0000000800000000'    +
012500041002                             )
012600030905
012700030905 EndPgm:
012800030905     EndPgm
