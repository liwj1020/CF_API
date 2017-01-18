000100050726/*-------------------------------------------------------------------*/
000200050726/*                                                                   */
000300050809/*  Program . . : CBX9413                                            */
000400050726/*  Description : Break handling exit program:                       */
000500050726/*                Forward message to E-mail                          */
000600050726/*  Author  . . : Carsten Flensburg                                  */
000700050726/*                                                                   */
000800010509/*                                                                   */
000900010509/*  Program summary:                                                 */
001000010509/*    Receives messages from a monitored message queue as they       */
001100010509/*    arrive.  The SMTP-address of the current job user is then      */
001200010509/*    retrieved from the system directory.                           */
001300010509/*                                                                   */
001400010509/*    If an SMTP-address is found the incoming message will be       */
001500010509/*    forwarded to that address and subsequently removed from        */
001600010509/*    the message queue.                                             */
001700010509/*                                                                   */
001800010509/*    To notify the user of the event the message text is also       */
001900010509/*    sent as a status message appearing at the bottom of the        */
002000010509/*    current screen.                                                */
002100010509/*                                                                   */
002200010509/*                                                                   */
002300010509/*  Parameters:                                                      */
002400010509/*    MsgQ        INPUT      Name of the message queue receiving     */
002500010509/*                           the message.                            */
002600010509/*                                                                   */
002700010509/*    MsgQlib     INPUT      The name of the library containing      */
002800010509/*                           the message queue.                      */
002900010509/*                                                                   */
003000010509/*    MsgKey      INPUT      The message reference key of the        */
003100010509/*                           message received.                       */
003200010509/*                                                                   */
003300010509/*                                                                   */
003400010509/*  Activation of break message handling:                            */
003500010509/*    CHGMSGQ    MSGQ( message-queue-name )                          */
003600010509/*               DLVRY( *BREAK )                                     */
003700050809/*               PGM( CBX9413 *ALWRPY )                              */
003800010509/*                                                                   */
003900010509/*                                                                   */
004000010509/*  Compile options:                                                 */
004100050809/*    CrtClPgm   Pgm( CBX9413 )                                      */
004200050726/*               SrcFile( QCLSRC )                                   */
004300050726/*               SrcMbr( *PGM )                                      */
004400050726/*                                                                   */
004500010509/*                                                                   */
004600010508/*-------------------------------------------------------------------*/
004700990913     Pgm       ( &MsgQ  &MsgQlib  &MsgKey )
004800940809
004900010509/*-- Parameters:                                                   --*/
005000971010     Dcl        &MsgQ        *Char    10
005100971010     Dcl        &MsgQlib     *Char    10
005200971010     Dcl        &MsgKey      *Char     4
005300971009
005400010509/*-- Global variables:                                             --*/
005500990908     Dcl        &Msg         *Char   512
005600971010     Dcl        &MsgId       *Char     7
005700971010     Dcl        &Sev         *Dec   (  2 0 )
005800971010     Dcl        &Sender      *Char    80
005900971010     Dcl        &RtnType     *Char     2
006000971010     Dcl        &SndUser     *Char    10
006100050726     Dcl        &SmtpAddr    *Char    63
006200940809
006300940809/*-- Global error monitoring:  --------------------------------------*/
006400010508     MonMsg     CPF0000      *None      GoTo EndPgm
006500940809
006600940809
006700010509/*-- Receive message and keep on queue:                            --*/
006800990913     RcvMsg     MsgQ( &MsgQlib/&MsgQ )                          +
006900990913                MsgKey( &MsgKey )                               +
007000010509                Rmv( *NO )                                      +
007100990913                Msg( &Msg )                                     +
007200990913                MsgId( &MsgId )                                 +
007300990913                Sev( &Sev )                                     +
007400990913                Sender( &Sender )                               +
007500990913                RtnType( &RtnType )
007600971009
007700010509/*-- Get SMTP-address:                                             --*/
007800050726     RtvDirSmtp User( *CURRENT )                                +
007900050726                SmtpAddr( &SmtpAddr )
008000990913
008100050809     If      (( &SmtpAddr *NE '*NONE' )   *And                  +
008200050809              ( &SmtpAddr *NE '*BLANK' )) Do
008300971009
008400010509/*-- Retrieve sender user-id:                                      --*/
008500010508     ChgVar     &SndUser        %Sst( &Sender  11 10 )
008600990921
008700010509/*-- Send message to SMTP-address and remove from queue:           --*/
008800990913     SndDst     Type( *LMSG )                                   +
008900010508                ToIntNet(( &SmtpAddr ))                         +
009000000119                DstD( &MsgQ                    *Tcat ':' *Bcat  +
009100050726                      %Sst( &Msg  1  32 ))                      +
009200990913                LongMsg( ':/N'                           *Bcat  +
009300010508                         'Sending user  . . :'           *Bcat  +
009400990913                          &SndUser                       *Bcat  +
009500990913                         ':/N'                           *Bcat  +
009600010508                         'Target queue  . . :'           *Bcat  +
009700990913                          &MsgQ                          *Bcat  +
009800990913                         ':/P'                           *Bcat  +
009900010508                         'Message text  . . :'           *Bcat  +
010000000119                          &Msg                                  )
010100010509
010200010509     RmvMsg     MsgQ( &MsgQlib/&MsgQ )                          +
010300010509                MsgKey( &MsgKey )                               +
010400010509                Clear( *BYKEY )
010500010508     EndDo
010600971103
010700010509/*-- Send message to bottom of screen:                             --*/
010800010508     SndPgmMsg  MsgId( CPF9897 )                                +
010900010509                MsgF( QCPFMSG )                                 +
011000990913                MsgDta( &Msg )                                  +
011100990913                ToPgmQ( *EXT )                                  +
011200990913                MsgType( *STATUS )
011300940809
011400971010 EndPgm:
011500971010     EndPgm
