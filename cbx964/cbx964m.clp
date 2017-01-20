/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX964M                                            */
/*  Description : Work with Server Shares - Create command           */
/*  Author  . . : Carsten Flensburg                                  */
/*  Published . : System iNetwork Systems Management Tips Newsletter */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Work with Server Shares command objects.      */
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
/*    CrtClPgm    Pgm( CBX964M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX964M )  Aut( *USE )

     AddMsgD    CBX0001 MsgF( &UtlLib/CBX964M ) Msg( 'No server shares match specified +
                  criteria' ) SecLvl( *NONE )

     AddMsgD    CBX0011 MsgF( &UtlLib/CBX964M ) Msg( 'Specified share type is not valid.' ) +
                  SecLvl( '&N Cause . . . . . :   The share type that you specified is not +
                  allowed. &N Recovery  . . . :   Specify either *ALL, *FILE or *PRINT for the +
                  share type.' )


     CrtRpgMod  &UtlLib/CBX964 SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX964 Module( &UtlLib/CBX964 ) ActGrp( *NEW )


     CrtRpgMod  &UtlLib/CBX964E SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX964E Module( &UtlLib/CBX964E ) ActGrp( *CALLER )


     CrtRpgMod  &UtlLib/CBX964V SrcFile( OSSILESRC/CBX964 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX964V Module( &UtlLib/CBX964V ) ActGrp( *CALLER )


     CrtPnlGrp  &UtlLib/CBX964H SrcFile( OSSILESRC/CBX964 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX964P SrcFile( OSSILESRC/CBX964 ) SrcMbr( *PNLGRP )


     CrtCmd     Cmd( &UtlLib/WRKSVRSHR ) Pgm( CBX964 ) SrcFile( OSSILESRC/CBX964 ) SrcMbr( +
                  CBX964X ) VldCkr( CBX964V ) AlwLmtUsr( *NO ) HlpPnlGrp( CBX964H ) HlpId( +
                  *CMD )


     SndPgmMsg   Msg( 'Work with Server Shares command'   *Bcat +
                      'successfully created in library'   *Bcat +
                      &UtlLib                             *Tcat +
                      '.' )                                     +
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
