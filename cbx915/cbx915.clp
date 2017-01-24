/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX915                                             */
/*  Description : Rename Hardware Resource - CPP                     */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX915 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &RscFrmName  &RscToName )
 
/*-- Variables:  ----------------------------------------------------*/
     Dcl        &RscFrmName  *Char    10
     Dcl        &RscToName   *Char    10
 
     Dcl        &RscVar      *Char    64
     Dcl        &FmtName     *Char     8      'CHGE0100'
     Dcl        &ErrorCode   *Char     4      X'00000000'
 
/*-- Error monitor:  ------------------------------------------------*/
     MonMsg     CPF0000      *N         GoTo Error
 
 
     ChkObj     QRZCHGE      *PGM       Aut( *USE )
 
     ChgVar     %Sst( &RscVar     1  10 )    &RscFrmName
     ChgVar     %Sst( &RscVar    33  10 )    &RscToName
 
     Call       QRZCHGE        ( &RscVar     +
                                 &FmtName    +
                                 &ErrorCode  +
                               )
 
     SndPgmMsg  Msg( 'Resource'              *Bcat  +
                     &RscFrmName             *Bcat  +
                     'has been renamed'      *Bcat  +
                     &RscToName              *Tcat  +
                     '.' )                          +
                MsgType( *COMP )
 
Return:
     Return
 
/*-- Error handling:  -----------------------------------------------*/
Error:
     Call       QMHMOVPM    ( '    '                                 +
                              '*DIAG'                                +
                              x'00000001'                            +
                              '*PGMBDY'                              +
                              x'00000001'                            +
                              x'0000000800000000'                    +
                            )
 
     Call       QMHRSNEM    ( '    '                                 +
                              x'0000000800000000'                    +
                            )
 
EndPgm:
     EndPgm
