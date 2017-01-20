/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX931V                                            */
/*  Description : Change object authority - VCP                      */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
/*    message is mandatory for a command validity checking program.  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX931V )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &ObjNam_q         +
                &ObjTyp           +
                &UsrPrf           +
                &CurAut           +
                &NewAut           +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &ObjNam_q   *Char    20
     Dcl        &ObjTyp     *Char     7
     Dcl        &UsrPrf     *Char    10
     Dcl        &CurAut     *Char   102
     Dcl        &NewAut     *Char   102

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &Msg        *Char    80

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error

/*-- Mainline -------------------------------------------------------*/

     If       ( %Sst( &UsrPrf  1  1 ) *NE '*' )   Do

     ChkObj     Obj( &UsrPrf )         +
                ObjType( *USRPRF )
     EndDo

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
