/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX971M                                            */
/*  Description : Work with Output Queue Authorities - Create Command*/
/*  Author  . . : Carsten Flensburg                                  */
/*  Published . : System iNetwork Systems Management Tips Newsletter */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Work with Output Queue Authorities            */
/*                     (WRKOUTQAUT) command objects.                 */
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
/*    CrtClPgm    Pgm( CBX971M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX971M )  Aut( *USE )

     AddMsgD    CBX0001 MsgF( &UtlLib/CBX971M ) Msg( 'Supplemental groups' ) SecLvl( *NONE )

     AddMsgD    CBX0002 MsgF( &UtlLib/CBX971M ) Msg( 'Output queue attributes' ) SecLvl( *NONE +
                  )


     CrtRpgMod  &UtlLib/CBX971 SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX971 Module( &UtlLib/CBX971 ) ActGrp( *NEW )


     CrtRpgMod  &UtlLib/CBX971V SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX971V Module( &UtlLib/CBX971V ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX971E SrcFile( OSSILESRC/CBX971 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX971E Module( &UtlLib/CBX971E ) ActGrp( *NEW )


     CrtPnlGrp  &UtlLib/CBX971H SrcFile( OSSILESRC/CBX971 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX971P SrcFile( OSSILESRC/CBX971 ) SrcMbr( *PNLGRP )


     CrtCmd     Cmd( &UtlLib/WRKOUTQAUT ) Pgm( CBX971 ) SrcFile( OSSILESRC/CBX971 ) SrcMbr( +
                  CBX971X ) VldCkr( CBX971V ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX971H ) HlpId( +
                  *CMD )


     SndPgmMsg   Msg( 'Work with Output Queue Autorities'    *Bcat +
                      'cmd successfully created in library'  *Bcat +
                      &UtlLib                                *Tcat +
                      '.' )                                        +
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
