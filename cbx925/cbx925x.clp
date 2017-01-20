/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX925X                                            */
/*  Description : Receive IFS journal entry exit program - setup     */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*  Programmer's note:                                               */
/*    This program expects two parameters:                           */
/*                                                                   */
/*      &AppLib : The library to contain all the objects that are    */
/*                created and compiled by this program               */
/*                                                                   */
/*      &IfsDir : The IFS directory to start journaling.             */
/*                                                                   */
/*    To ensure that the &IfsDir parameter is passed correctly if    */
/*    you call this program from the command line, you will need     */
/*    to place the right apostrophe at the end of the parameter      */
/*    prompt:                                                        */
/*                                                                   */
/*    Call Pgm( CBX925X )                                            */
/*         Parm( 'JRNLIB    '                                        */
/*               '/QOpenSys/IFSDIR                                ') */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm    Pgm( CBX925X )                                     */
/*                SrcFile( QCLSRC )                                  */
/*                SrcMbr( *PGM )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &AppLib  &IfsDir )

/*-- Parameter - library to contain log system:  --------------------*/
     Dcl        &AppLib      *Char    10
     Dcl        &IfsDir      *Char    48


     MonMsg     CPF0000      *N       GoTo Error


     CrtDtaAra  &AppLib/CBX925D       *Dec    10   Value( 0 )

     CrtJrnRcv  &AppLib/CBXIFS0001    Threshold( 1000000 )

     CrtJrn     &AppLib/CBXIFSJRN     +
                &AppLib/CBXIFS0001    +
                MngRcv( *System )     +
                RcvSizOpt( *MaxOpt2 )

     STRJRN     Obj(( &IfsDir  *INCLUDE ))             +
                Jrn( '/QSYS.LIB/'    *Cat              +
                     &AppLib         *Tcat             +
                     '.LIB/CBXIFSJRN.JRN' )            +
                SubTree( *NONE )                       +
                Inherit( *NO )                         +
                Images( *BOTH )                        +
                OmtJrnE( *OPNCLOSYN )

     CrtClPgm   &AppLib/CBX925C                  +
                SrcFile( &AppLib/QCLSRC )        +
                SrcMbr( *Pgm )

     CrtRpgMod  &AppLib/CBX925                   +
                SrcFile( &AppLib/QRPGLESRC )     +
                SrcMbr( *Module )

     CrtPgm     &AppLib/CBX925

     SndPgmMsg   Msg( 'IFS journal monitor has been'     *Bcat  +
                      'successfully created in library'  *Bcat  +
                      &AppLib                            *Tcat  +
                      '.' )                                     +
                 MsgType( *COMP )


 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                                  +
                             '*DIAG'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )

     Call      QMHRSNEM    ( '    '                                  +
                             x'0000000800000000'                     +
                           )

 EndPgm:
     EndPgm
