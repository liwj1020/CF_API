/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX933V                                            */
/*  Description : Start journal for library - VCP                    */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
/*    message is mandatory for a command validity checking program.  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX933V )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &LibNam           +
                &JrnNam_q         +
                &ObjNam           +
                &ObjTyp           +
                &Images           +
                &OmtJrnE          +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &LibNam     *Char    10
     Dcl        &JrnNam_q   *Char    20
     Dcl        &ObjNam     *Char    10
     Dcl        &ObjTyp     *Char    10
     Dcl        &Images     *Char     6
     Dcl        &OmtJrnE    *Char    10

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JrnNam     *Char    10
     Dcl        &JrnNam_l   *Char    10

     Dcl        &Msg        *Char    80

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error

/*-- Mainline -------------------------------------------------------*/

     ChgVar     &JrnNam      %SSt( &JrnNam_q   1  10 )
     ChgVar     &JrnNam_l    %SSt( &JrnNam_q  11  10 )

     ChkObj     Obj( &LibNam )             +
                ObjType( *LIB )

     ChkObj     Obj( &JrnNam_l/&JrnNam )   +
                ObjType( *JRN )

 Return:
     Return

/*-- Error processor ------------------------------------------------*/
 Error:
     RcvMsg     MsgType( *EXCP )                      +
                Msg( &Msg )

     ChgVar     &Msg         ( '0000' *Cat  &Msg )

     SndPgmMsg  MsgId( CPD0006 )                      +
                MsgF( QCPFMSG )                       +
                MsgDta( &Msg )                        +
                MsgType( *DIAG )

     SndPgmMsg  MsgId( CPF0002 )                      +
                MsgF( QCPFMSG )                       +
                MsgType( *ESCAPE )

 EndPgm:
     EndPgm
