000100041002/*-------------------------------------------------------------------*/
000200041002/*                                                                   */
000300070423/*  Program . . : CBX969M                                            */
000400060518/*  Description : Work with Jobs - Create command                    */
000500041002/*  Author  . . : Carsten Flensburg                                  */
000600070423/*  Published . : System iNetwork Systems Management Tips Newsletter */
000700041002/*                                                                   */
000800041002/*                                                                   */
000900041207/*  Program function:  Compiles, creates and configures all the      */
001000060518/*                     Work with Jobs command objects.               */
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
002200070423/*    CrtClPgm    Pgm( CBX969M )                                     */
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
003400070423     CrtMsgF     MsgF( &UtlLib/CBX969M )  Aut( *USE )
003500060415
003600170116     AddMsgD    CBX0101 MsgF( &UtlLib/CBX969M ) Msg( 'User name must be *CURUSR if CURUSR is +
003700170116                  specified.' ) SecLvl( *NONE )
004100060415
004200170116     AddMsgD    CBX0102 MsgF( &UtlLib/CBX969M ) Msg( 'Current user can only be specified if +
004300170116                  STATUS(*ACTIVE) is requested.' ) SecLvl( *NONE )
004700060518
004800170116     AddMsgD    CBX0103 MsgF( &UtlLib/CBX969M ) Msg( 'Please specify current user.' ) SecLvl( +
004900170116                  *NONE )
005200060518
005300170116     AddMsgD    CBX0111 MsgF( &UtlLib/CBX969M ) Msg( 'Completion status can only be specified +
005400170116                  if STATUS(*OUTQ) is requested.' ) SecLvl( *NONE )
005800060518
005900170116     AddMsgD    CBX0121 MsgF( &UtlLib/CBX969M ) Msg( 'If JOB(*ALL) and USER(*ALL) is +
006000170116                  specified, STATUS must be *ACTIVE or *JOBQ.' ) SecLvl( *NONE )
006400060518
006500060520
006600170116     CrtRpgMod  &UtlLib/CBX969 SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )
007000041207
007100170116     CrtPgm     &UtlLib/CBX969 Module( &UtlLib/CBX969 ) ActGrp( *NEW )
007400060407
007500170116     CrtRpgMod  &UtlLib/CBX969E SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )
007900060415
008000170116     CrtPgm     &UtlLib/CBX969E Module( &UtlLib/CBX969E ) ActGrp( *CALLER )
008300060415
008400170116     CrtRpgMod  &UtlLib/CBX969L SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )
008800060518
008900170116     CrtPgm     &UtlLib/CBX969L Module( &UtlLib/CBX969L ) ActGrp( *CALLER )
009200060518
009300170116     CrtRpgMod  &UtlLib/CBX969V SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )
009700060518
009800170116     CrtPgm     &UtlLib/CBX969V Module( &UtlLib/CBX969V ) ActGrp( *CALLER )
010100060518
010200041207
010300170116     CrtPnlGrp  &UtlLib/CBX969H SrcFile( OSSILESRC/CBX969 ) SrcMbr( *PNLGRP )
010600060407
010700170116     CrtPnlGrp  &UtlLib/CBX969P SrcFile( OSSILESRC/CBX969 ) SrcMbr( *PNLGRP )
011000060415
011100060407
011200170116     CrtCmd     Cmd( &UtlLib/WRKJOB2 ) Pgm( CBX969 ) SrcFile( OSSILESRC/CBX969 ) SrcMbr( +
011300170116                  CBX969X ) Allow( *INTERACT *IPGM *IREXX *IMOD ) AlwLmtUsr( *NO ) MsgF( +
011400170116                  &UtlLib/CBX969M ) HlpPnlGrp( CBX969H ) HlpId( *CMD )
012100060407
012200060407
012300070423     SndPgmMsg   Msg( 'Work with Job 2 command successfully'  *Bcat +
012400070423                      'created in library'                    *Bcat +
012500070423                      &UtlLib                                 *Tcat +
012600070423                      '.' )                                         +
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
