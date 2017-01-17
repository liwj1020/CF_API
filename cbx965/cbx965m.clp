000100041002/*-------------------------------------------------------------------*/
000200041002/*                                                                   */
000300070101/*  Program . . : CBX965M                                            */
000400061116/*  Description : Display User Jobs - Create command                 */
000500041002/*  Author  . . : Carsten Flensburg                                  */
000600041002/*                                                                   */
000700041002/*                                                                   */
000800041207/*  Program function:  Compiles, creates and configures all the      */
000900061116/*                     Display User Jobs command objects.            */
001000041207/*                                                                   */
001100041002/*                     This program expects a single parameter       */
001200041002/*                     specifying the library to contain the         */
001300041002/*                     command objects.                              */
001400041002/*                                                                   */
001500041002/*                     Object sources must exist in the respective   */
001600041002/*                     source type default source files in the       */
001700041002/*                     command object library.                       */
001800041002/*                                                                   */
001900060103/*                                                                   */
002000041002/*  Compile options:                                                 */
002100070101/*    CrtClPgm    Pgm( CBX965M )                                     */
002200041002/*                SrcFile( QCLSRC )                                  */
002300041002/*                SrcMbr( *PGM )                                     */
002400041002/*                                                                   */
002500041002/*-------------------------------------------------------------------*/
002600041002     Pgm    &UtlLib
002700030905
002800041002     Dcl    &UtlLib         *Char     10
002900030909
003000041002     MonMsg      CPF0000    *N        GoTo Error
003100051129
003200060407
003300070101     CrtMsgF     MsgF( &UtlLib/CBX965M )  Aut( *USE )
003400060415
003500170117     AddMsgD    CBX0101 MsgF( &UtlLib/CBX965M ) Msg( 'User name must be *CURUSR if CURUSR is +
003600170117                  specified.' ) SecLvl( *NONE )
004000060415
004100170117     AddMsgD    CBX0102 MsgF( &UtlLib/CBX965M ) Msg( 'Current user can only be specified if +
004200170117                  STATUS(*ACTIVE) is requested.' ) SecLvl( *NONE )
004600060518
004700170117     AddMsgD    CBX0103 MsgF( &UtlLib/CBX965M ) Msg( 'Please specify current user.' ) SecLvl( +
004800170117                  *NONE )
005100060518
005200170117     AddMsgD    CBX0111 MsgF( &UtlLib/CBX965M ) Msg( 'Completion status can only be specified +
005300170117                  if STATUS(*OUTQ) is requested.' ) SecLvl( *NONE )
005700060518
005800170117     AddMsgD    CBX0121 MsgF( &UtlLib/CBX965M ) Msg( 'If USER(*ALL) is specified, STATUS must +
005900170117                  be *ACTIVE or *JOBQ.' ) SecLvl( *NONE )
006300060518
006400060520
006500170117     CrtRpgMod  &UtlLib/CBX965 SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )
006900041207
007000170117     CrtPgm     &UtlLib/CBX965 Module( &UtlLib/CBX965 ) ActGrp( *NEW )
007300060407
007400170117     CrtRpgMod  &UtlLib/CBX965E SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )
007800060415
007900170117     CrtPgm     &UtlLib/CBX965E Module( &UtlLib/CBX965E ) ActGrp( *CALLER )
008200060415
008300170117     CrtRpgMod  &UtlLib/CBX965L SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )
008700060518
008800170117     CrtPgm     &UtlLib/CBX965L Module( &UtlLib/CBX965L ) ActGrp( *CALLER )
009100060518
009200170117     CrtRpgMod  &UtlLib/CBX965V SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )
009600060518
009700170117     CrtPgm     &UtlLib/CBX965V Module( &UtlLib/CBX965V ) ActGrp( QILE )
010000060518
010100041207
010200170117     CrtPnlGrp  &UtlLib/CBX965H SrcFile( OSSILESRC/CBX965 ) SrcMbr( *PNLGRP )
010500060407
010600170117     CrtPnlGrp  &UtlLib/CBX965P SrcFile( OSSILESRC/CBX965 ) SrcMbr( *PNLGRP )
010900060415
011000060407
011100170117     CrtCmd     Cmd( &UtlLib/DSPUSRJOB ) Pgm( CBX965 ) SrcFile( OSSILESRC/CBX965 ) SrcMbr( +
011200170117                  CBX965X ) Allow( *INTERACT *IPGM *IREXX *IMOD ) AlwLmtUsr( *NO ) MsgF( +
011300170117                  &UtlLib/CBX965M ) HlpPnlGrp( CBX965H ) HlpId( *CMD ) Aut( *EXCLUDE )
012100070127
012200060407
012300061116     SndPgmMsg   Msg( 'Display User Jobs command successfully' *Bcat +
012400061116                      'created in library'                     *Bcat +
012500061116                      &UtlLib                                  *Tcat +
012600061116                      '.' )                                          +
012700041010                 MsgType( *COMP )
012800050110
012900050110
013000050110     Call        QMHMOVPM    ( '    '                 +
013100050110                               '*COMP'                +
013200050110                               x'00000001'            +
013300050110                               '*PGMBDY'              +
013400050110                               x'00000001'            +
013500050110                               x'0000000800000000'    +
013600060113                             )
013700051204
013800051204     RmvMsg      Clear( *ALL )
013900050110
014000030905     Return
014100030905
014200030905/*-- Error handling:  -----------------------------------------------*/
014300030905 Error:
014400041002     Call        QMHMOVPM    ( '    '                 +
014500041002                               '*DIAG'                +
014600041002                               x'00000001'            +
014700041002                               '*PGMBDY'              +
014800041002                               x'00000001'            +
014900041002                               x'0000000800000000'    +
015000041002                             )
015100030905
015200041002     Call        QMHRSNEM    ( '    '                 +
015300041002                               x'0000000800000000'    +
015400041002                             )
015500030905
015600030905 EndPgm:
015700030905     EndPgm
