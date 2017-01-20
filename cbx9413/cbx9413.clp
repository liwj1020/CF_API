/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9413                                            */
/*  Description : Break handling exit program:                       */
/*                Forward message to E-mail                          */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Program summary:                                                 */
/*    Receives messages from a monitored message queue as they       */
/*    arrive.  The SMTP-address of the current job user is then      */
/*    retrieved from the system directory.                           */
/*                                                                   */
/*    If an SMTP-address is found the incoming message will be       */
/*    forwarded to that address and subsequently removed from        */
/*    the message queue.                                             */
/*                                                                   */
/*    To notify the user of the event the message text is also       */
/*    sent as a status message appearing at the bottom of the        */
/*    current screen.                                                */
/*                                                                   */
/*                                                                   */
/*  Parameters:                                                      */
/*    MsgQ        INPUT      Name of the message queue receiving     */
/*                           the message.                            */
/*                                                                   */
/*    MsgQlib     INPUT      The name of the library containing      */
/*                           the message queue.                      */
/*                                                                   */
/*    MsgKey      INPUT      The message reference key of the        */
/*                           message received.                       */
/*                                                                   */
/*                                                                   */
/*  Activation of break message handling:                            */
/*    CHGMSGQ    MSGQ( message-queue-name )                          */
/*               DLVRY( *BREAK )                                     */
/*               PGM( CBX9413 *ALWRPY )                              */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX9413 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm       ( &MsgQ  &MsgQlib  &MsgKey )

/*-- Parameters:                                                   --*/
     Dcl        &MsgQ        *Char    10
     Dcl        &MsgQlib     *Char    10
     Dcl        &MsgKey      *Char     4

/*-- Global variables:                                             --*/
     Dcl        &Msg         *Char   512
     Dcl        &MsgId       *Char     7
     Dcl        &Sev         *Dec   (  2 0 )
     Dcl        &Sender      *Char    80
     Dcl        &RtnType     *Char     2
     Dcl        &SndUser     *Char    10
     Dcl        &SmtpAddr    *Char    63

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *None      GoTo EndPgm


/*-- Receive message and keep on queue:                            --*/
     RcvMsg     MsgQ( &MsgQlib/&MsgQ )                          +
                MsgKey( &MsgKey )                               +
                Rmv( *NO )                                      +
                Msg( &Msg )                                     +
                MsgId( &MsgId )                                 +
                Sev( &Sev )                                     +
                Sender( &Sender )                               +
                RtnType( &RtnType )

/*-- Get SMTP-address:                                             --*/
     RtvDirSmtp User( *CURRENT )                                +
                SmtpAddr( &SmtpAddr )

     If      (( &SmtpAddr *NE '*NONE' )   *And                  +
              ( &SmtpAddr *NE '*BLANK' )) Do

/*-- Retrieve sender user-id:                                      --*/
     ChgVar     &SndUser        %Sst( &Sender  11 10 )

/*-- Send message to SMTP-address and remove from queue:           --*/
     SndDst     Type( *LMSG )                                   +
                ToIntNet(( &SmtpAddr ))                         +
                DstD( &MsgQ                    *Tcat ':' *Bcat  +
                      %Sst( &Msg  1  32 ))                      +
                LongMsg( ':/N'                           *Bcat  +
                         'Sending user  . . :'           *Bcat  +
                          &SndUser                       *Bcat  +
                         ':/N'                           *Bcat  +
                         'Target queue  . . :'           *Bcat  +
                          &MsgQ                          *Bcat  +
                         ':/P'                           *Bcat  +
                         'Message text  . . :'           *Bcat  +
                          &Msg                                  )

     RmvMsg     MsgQ( &MsgQlib/&MsgQ )                          +
                MsgKey( &MsgKey )                               +
                Clear( *BYKEY )
     EndDo

/*-- Send message to bottom of screen:                             --*/
     SndPgmMsg  MsgId( CPF9897 )                                +
                MsgF( QCPFMSG )                                 +
                MsgDta( &Msg )                                  +
                ToPgmQ( *EXT )                                  +
                MsgType( *STATUS )

 EndPgm:
     EndPgm
