000100041002/*-------------------------------------------------------------------*/
000200041002/*                                                                   */
000300070526/*  Program . . : CBX971M                                            */
000400070526/*  Description : Work with Output Queue Authorities - Create Command*/
000500041002/*  Author  . . : Carsten Flensburg                                  */
000600070429/*  Published . : System iNetwork Systems Management Tips Newsletter */
000700041002/*                                                                   */
000800041002/*                                                                   */
000900041207/*  Program function:  Compiles, creates and configures all the      */
001000140101/*                     Work with Output Queue Authorities            */
001100140101/*                     (WRKOUTQAUT) command objects.                 */
001200070526/*                                                                   */
001300041002/*                     This program expects a single parameter       */
001400041002/*                     specifying the library to contain the         */
001500041002/*                     command objects.                              */
001600041002/*                                                                   */
001700041002/*                     Object sources must exist in the respective   */
001800041002/*                     source type default source files in the       */
001900041002/*                     command object library.                       */
002000041002/*                                                                   */
002100060103/*                                                                   */
002200041002/*  Compile options:                                                 */
002300070526/*    CrtClPgm    Pgm( CBX971M )                                     */
002400041002/*                SrcFile( QCLSRC )                                  */
002500041002/*                SrcMbr( *PGM )                                     */
002600041002/*                                                                   */
002700041002/*-------------------------------------------------------------------*/
002800041002     Pgm    &UtlLib
002900030905
003000041002     Dcl    &UtlLib         *Char     10
003100030909
003200041002     MonMsg      CPF0000    *N        GoTo Error
003300051129
003400140101
003500140101     CrtMsgF     MsgF( &UtlLib/CBX971M )  Aut( *USE )
003600140101
003700170116     AddMsgD    CBX0001 MsgF( &UtlLib/CBX971M ) Msg( 'Supplemental groups' ) SecLvl( *NONE )
004100060407
004200170116     AddMsgD    CBX0002 MsgF( &UtlLib/CBX971M ) Msg( 'Output queue attributes' ) SecLvl( *NONE +
004300170116                  )
004600140420
004700051129
004800170116     CrtRpgMod  &UtlLib/CBX971 SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )
005200041207
005300170116     CrtPgm     &UtlLib/CBX971 Module( &UtlLib/CBX971 ) ActGrp( *NEW )
005600060407
005700060525
005800170116     CrtRpgMod  &UtlLib/CBX971V SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )
006200070520
006300170116     CrtPgm     &UtlLib/CBX971V Module( &UtlLib/CBX971V ) ActGrp( *CALLER )
006600070520
006700170116     CrtRpgMod  &UtlLib/CBX971E SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )
007100140101
007200170116     CrtPgm     &UtlLib/CBX971E Module( &UtlLib/CBX971E ) ActGrp( *NEW )
007500140101
007600060525
007700170116     CrtPnlGrp  &UtlLib/CBX971H SrcFile( OSSILESRC/CBX971 ) SrcMbr( *PNLGRP )
008000060407
008100170116     CrtPnlGrp  &UtlLib/CBX971P SrcFile( OSSILESRC/CBX971 ) SrcMbr( *PNLGRP )
008400060415
008500060407
008600170116     CrtCmd     Cmd( &UtlLib/WRKOUTQAUT ) Pgm( CBX971 ) SrcFile( OSSILESRC/CBX971 ) SrcMbr( +
008700170116                  CBX971X ) VldCkr( CBX971V ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX971H ) HlpId( +
008800170116                  *CMD )
009400060407
009500060407
009600070526     SndPgmMsg   Msg( 'Work with Output Queue Autorities'    *Bcat +
009700060825                      'cmd successfully created in library'  *Bcat +
009800060525                      &UtlLib                                *Tcat +
009900060525                      '.' )                                        +
010000041010                 MsgType( *COMP )
010100050110
010200050110
010300050110     Call        QMHMOVPM    ( '    '                 +
010400050110                               '*COMP'                +
010500050110                               x'00000001'            +
010600050110                               '*PGMBDY'              +
010700050110                               x'00000001'            +
010800050110                               x'0000000800000000'    +
010900060113                             )
011000051204
011100051204     RmvMsg      Clear( *ALL )
011200050110
011300030905     Return
011400030905
011500030905/*-- Error handling:  -----------------------------------------------*/
011600030905 Error:
011700041002     Call        QMHMOVPM    ( '    '                 +
011800041002                               '*DIAG'                +
011900041002                               x'00000001'            +
012000041002                               '*PGMBDY'              +
012100041002                               x'00000001'            +
012200041002                               x'0000000800000000'    +
012300041002                             )
012400030905
012500041002     Call        QMHRSNEM    ( '    '                 +
012600041002                               x'0000000800000000'    +
012700041002                             )
012800030905
012900030905 EndPgm:
013000030905     EndPgm
