/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX965M                                            */
/*  Description : Display User Jobs - Create command                 */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Display User Jobs command objects.            */
/*                                                                   */
/*                     This program expects a single parameter       */
/*                     specifying the library to contain the         */
/*                     command objects.                              */
/*                                                                   */
/*                     Object sources must exist in the respective   */
/*                     source type default source files in the       */
/*                     command object library.                       */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm    Pgm( CBX965M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX965M )  Aut( *USE )

     AddMsgD    CBX0101 MsgF( &UtlLib/CBX965M ) Msg( 'User name must be *CURUSR if CURUSR is +
                  specified.' ) SecLvl( *NONE )

     AddMsgD    CBX0102 MsgF( &UtlLib/CBX965M ) Msg( 'Current user can only be specified if +
                  STATUS(*ACTIVE) is requested.' ) SecLvl( *NONE )

     AddMsgD    CBX0103 MsgF( &UtlLib/CBX965M ) Msg( 'Please specify current user.' ) SecLvl( +
                  *NONE )

     AddMsgD    CBX0111 MsgF( &UtlLib/CBX965M ) Msg( 'Completion status can only be specified +
                  if STATUS(*OUTQ) is requested.' ) SecLvl( *NONE )

     AddMsgD    CBX0121 MsgF( &UtlLib/CBX965M ) Msg( 'If USER(*ALL) is specified, STATUS must +
                  be *ACTIVE or *JOBQ.' ) SecLvl( *NONE )


     CrtRpgMod  &UtlLib/CBX965 SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX965 Module( &UtlLib/CBX965 ) ActGrp( *NEW )

     CrtRpgMod  &UtlLib/CBX965E SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX965E Module( &UtlLib/CBX965E ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX965L SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX965L Module( &UtlLib/CBX965L ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX965V SrcFile( OSSILESRC/CBX965 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX965V Module( &UtlLib/CBX965V ) ActGrp( QILE )


     CrtPnlGrp  &UtlLib/CBX965H SrcFile( OSSILESRC/CBX965 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX965P SrcFile( OSSILESRC/CBX965 ) SrcMbr( *PNLGRP )


     CrtCmd     Cmd( &UtlLib/DSPUSRJOB ) Pgm( CBX965 ) SrcFile( OSSILESRC/CBX965 ) SrcMbr( +
                  CBX965X ) Allow( *INTERACT *IPGM *IREXX *IMOD ) AlwLmtUsr( *NO ) MsgF( +
                  &UtlLib/CBX965M ) HlpPnlGrp( CBX965H ) HlpId( *CMD ) Aut( *EXCLUDE )


     SndPgmMsg   Msg( 'Display User Jobs command successfully' *Bcat +
                      'created in library'                     *Bcat +
                      &UtlLib                                  *Tcat +
                      '.' )                                          +
                 MsgType( *COMP )


     Call        QMHMOVPM    ( '    '                 +
                               '*COMP'                +
                               x'00000001'            +
                               '*PGMBDY'              +
                               x'00000001'            +
                               x'0000000800000000'    +
                             )

     RmvMsg      Clear( *ALL )

     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call        QMHMOVPM    ( '    '                 +
                               '*DIAG'                +
                               x'00000001'            +
                               '*PGMBDY'              +
                               x'00000001'            +
                               x'0000000800000000'    +
                             )

     Call        QMHRSNEM    ( '    '                 +
                               x'0000000800000000'    +
                             )

 EndPgm:
     EndPgm
