/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX969M                                            */
/*  Description : Work with Jobs - Create command                    */
/*  Author  . . : Carsten Flensburg                                  */
/*  Published . : System iNetwork Systems Management Tips Newsletter */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Work with Jobs command objects.               */
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
/*    CrtClPgm    Pgm( CBX969M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX969M )  Aut( *USE )

     AddMsgD    CBX0101 MsgF( &UtlLib/CBX969M ) Msg( 'User name must be *CURUSR if CURUSR is +
                  specified.' ) SecLvl( *NONE )

     AddMsgD    CBX0102 MsgF( &UtlLib/CBX969M ) Msg( 'Current user can only be specified if +
                  STATUS(*ACTIVE) is requested.' ) SecLvl( *NONE )

     AddMsgD    CBX0103 MsgF( &UtlLib/CBX969M ) Msg( 'Please specify current user.' ) SecLvl( +
                  *NONE )

     AddMsgD    CBX0111 MsgF( &UtlLib/CBX969M ) Msg( 'Completion status can only be specified +
                  if STATUS(*OUTQ) is requested.' ) SecLvl( *NONE )

     AddMsgD    CBX0121 MsgF( &UtlLib/CBX969M ) Msg( 'If JOB(*ALL) and USER(*ALL) is +
                  specified, STATUS must be *ACTIVE or *JOBQ.' ) SecLvl( *NONE )


     CrtRpgMod  &UtlLib/CBX969 SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX969 Module( &UtlLib/CBX969 ) ActGrp( *NEW )

     CrtRpgMod  &UtlLib/CBX969E SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX969E Module( &UtlLib/CBX969E ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX969L SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX969L Module( &UtlLib/CBX969L ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX969V SrcFile( OSSILESRC/CBX969 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX969V Module( &UtlLib/CBX969V ) ActGrp( *CALLER )


     CrtPnlGrp  &UtlLib/CBX969H SrcFile( OSSILESRC/CBX969 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX969P SrcFile( OSSILESRC/CBX969 ) SrcMbr( *PNLGRP )


     CrtCmd     Cmd( &UtlLib/WRKJOB2 ) Pgm( CBX969 ) SrcFile( OSSILESRC/CBX969 ) SrcMbr( +
                  CBX969X ) Allow( *INTERACT *IPGM *IREXX *IMOD ) AlwLmtUsr( *NO ) MsgF( +
                  &UtlLib/CBX969M ) HlpPnlGrp( CBX969H ) HlpId( *CMD )


     SndPgmMsg   Msg( 'Work with Job 2 command successfully'  *Bcat +
                      'created in library'                    *Bcat +
                      &UtlLib                                 *Tcat +
                      '.' )                                         +
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
