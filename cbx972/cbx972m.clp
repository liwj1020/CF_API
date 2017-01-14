/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX972M                                            */
/*  Description : Work with Profile Security Attributes - Build cmd. */
/*  Author  . . : Carsten Flensburg                                  */
/*  Published . : System iNetwork Systems Management Tips Newsletter */
/*                                                                   */
/*                                                                   */
/*  Program function:  Compiles, creates and configures all the      */
/*                     Work with Profile Security Attributes         */
/*                     command objects.                              */
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
/*    CrtClPgm    Pgm( CBX972M )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm    &UtlLib

     Dcl    &UtlLib         *Char     10

     MonMsg      CPF0000    *N        GoTo Error


     CrtMsgF     MsgF( &UtlLib/CBX972M )  Aut( *USE )

     AddMsgD    CBX0001 MsgF( &UtlLib/CBX972M ) Msg( 'Display supplemental groups' ) SecLvl( +
                  *NONE )

     AddMsgD    CBX0002 MsgF( &UtlLib/CBX972M ) Msg( 'Display special authority' ) SecLvl( +
                  *NONE )

     AddMsgD    CBX0003 MsgF( &UtlLib/CBX972M ) Msg( 'Display user audit values' ) SecLvl( +
                  *NONE )

     AddMsgD    CBX0101 MsgF( &UtlLib/CBX972M ) Msg( '&1 user profiles were selected.' ) +
                  SecLvl( *NONE ) Fmt(( *BIN 4 ))

     AddMsgD    CBX1001 MsgF( &UtlLib/CBX972M ) Msg( 'PWDTYP(*DFT) only allowed if default +
                  password table is updated.' ) SecLvl( '&N Cause . . . . . :   The specified +
                  password type of *DFT requires the default password table to be updated. &N +
                  Recovery  . . . :   Specify UPDDFTPWD(*YES) to allow the default password +
                  table to be updated, or change or remove the PWDTYP(*DFT) parameter.')


     CrtRpgMod  &UtlLib/CBX9721 SrcFile( OSSILESRC/CBX972 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX9721 Module( &UtlLib/CBX9721 ) ActGrp( *NEW )

     CrtRpgMod  &UtlLib/CBX9722 SrcFile( OSSILESRC/CBX972 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX9722 Module( &UtlLib/CBX9722 ) ActGrp( *CALLER )


     CrtRpgMod  &UtlLib/CBX972E SrcFile( OSSILESRC/CBX972 ) SrcMbr( *Module ) DbgView( *LIST )

     CrtPgm     &UtlLib/CBX972E Module( &UtlLib/CBX972E ) ActGrp( *CALLER )

     CrtPnlGrp  &UtlLib/CBX972H SrcFile( OSSILESRC/CBX972 ) SrcMbr( *PNLGRP )

     CrtPnlGrp  &UtlLib/CBX972P SrcFile( OSSILESRC/CBX972 ) SrcMbr( *PNLGRP )

     CrtCmd     Cmd( &UtlLib/WRKPRFSECA ) Pgm( CBX9721 ) SrcFile( OSSILESRC/CBX972 ) SrcMbr( +
                  CBX972X ) AlwLmtUsr( *NO ) MsgF( CBX972M ) HlpPnlGrp( CBX972H ) HlpId( *CMD +
                  ) PrdLib( &UtlLib ) Aut( *EXCLUDE )

     SndPgmMsg  Msg( 'Work with Profile Security Attributes'  *Bcat 'cmd successfully created +
                  in library' *Bcat &UtlLib *Tcat '.' ) MsgType( *COMP )


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
