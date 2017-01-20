/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX963M                                            */
/*  Description : Display Server Sharre - Create command             */
/*  Author  . . : Carsten Flensburg                                  */
/*  Published . : System iNetwork Systems Management Tips Newsletter */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Display Server Share command objects.         */
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
/*    CrtClPgm    Pgm( CBX963M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX963M )  Aut( *USE )

     AddMsgD    CBX0001 MsgF( &UtlLib/CBX963M ) Msg( 'Display entire path' ) SecLvl( *NONE )

     AddMsgD    CBX0002 MsgF( &UtlLib/CBX963M ) Msg( 'Display file extensions' ) SecLvl( *NONE +
                  )


     CrtRpgMod  &UtlLib/CBX963 SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX963 Module( &UtlLib/CBX963 ) ActGrp( *NEW )

     CrtRpgMod  &UtlLib/CBX963E SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX963E Module( &UtlLib/CBX963E ) ActGrp( *CALLER )

     CrtRpgMod  &UtlLib/CBX963V SrcFile( OSSILESRC/CBX963 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX963V Module( &UtlLib/CBX963V ) ActGrp( *CALLER )


     CrtPnlGrp  &UtlLib/CBX963H SrcFile( OSSILESRC/CBX963 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX963P SrcFile( OSSILESRC/CBX963 ) SrcMbr( *PNLGRP )


     CrtCmd     Cmd( &UtlLib/DSPSVRSHR ) Pgm( CBX963 ) VldCkr( CBX963V ) SrcFile( +
                  OSSILESRC/CBX963 ) SrcMbr( CBX963X ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX963H ) +
                  HlpId( *CMD )


     SndPgmMsg   Msg( 'Display Server Share command'        *Bcat +
                      'successfully created in library'     *Bcat +
                      &UtlLib                               *Tcat +
                      '.' )                                       +
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
