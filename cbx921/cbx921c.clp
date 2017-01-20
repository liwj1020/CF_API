/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX921CL                                           */
/*  Description : User profile initial program - sample              */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX921CL )                                     */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &WksMsgQ     *Char     10
     Dcl        &UsrMsgQ     *Char     10
     Dcl        &UsrMsgQlib  *Char     10

     Dcl        &BrkHdlPgm   *Char     10     'CBX921'
     Dcl        &BrkHdlLib   *Char     10     'QGPL'

/*-- Global error monitor:  -----------------------------------------*/
     MonMsg     CPF0000


/*-- Work station message queue:  -----------------------------------*/
     RtvJobA    Job( &WksMsgQ )

     AlcObj     Obj(( &WksMsgQ  *MSGQ  *EXCL ))   Wait( 0 )
     MonMsg   ( CPF1002  CPF1085 )     *N     Do

     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
     GoTo       SkpWksMsgQ
     EndDo

     DlcObj     Obj(( &WksMsgQ  *MSGQ  *EXCL ))

     ChgMsgQ    MsgQ( *WRKSTN )                            +
                Dlvry( *BREAK )                            +
                Pgm( &BrkHdlLib/&BrkHdlPgm  *NOALWRPY )

     MonMsg     CPF2451
SkpWksMsgQ:

/*-- User profile message queue:  -----------------------------------*/
     RtvUsrPrf  MsgQ( &UsrMsgQ )  MsgQlib( &UsrMsgQlib )

     AlcObj     Obj(( &UsrMsgQlib/&UsrMsgQ  *MSGQ  *EXCL ))  Wait( 0 )
     MonMsg   ( CPF1002  CPF1085 )     *N     Do

     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
     GoTo       SkpUsrMsgQ
     EndDo

     DlcObj     Obj(( &UsrMsgQlib/&UsrMsgQ  *MSGQ  *EXCL ))

     ChgMsgQ    MsgQ( *USRPRF )                            +
                Dlvry( *BREAK )                            +
                Pgm( &BrkHdlLib/&BrkHdlPgm  *NOALWRPY )

     MonMsg     CPF2451
SkpUsrMsgQ:

/*-- Perform other job initialization tasks:  -----------------------*/




/*-- End of initial program:  ---------------------------------------*/
EndPgm:
     EndPgm
