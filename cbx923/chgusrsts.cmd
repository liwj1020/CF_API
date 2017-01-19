000100040606/*-------------------------------------------------------------------*/
000200040606/*                                                                   */
000300040606/*  Compile options:                                                 */
000400040606/*                                                                   */
000500040828/*    CrtCmd Cmd( CHGUSRSTS )                                        */
000600040919/*           Pgm( CBX923 )                                           */
000700040919/*           SrcMbr( CBX923X )                                       */
000800040828/*           AlwLmtUsr( *YES )                                       */
000900040919/*           HlpPnlGrp( CBX923H )                                    */
001000040606/*           HlpId( *CMD )                                           */
001100040924/*           Aut( CHGUSRSTS )                                        */
001200040924/*                                                                   */
001300040924/*  Prerequisite:                                                    */
001400040924/*                                                                   */
001500040924/*     Prior to compiling the command you must create the            */
001600040924/*     the authorization list specified on the AUT parameter         */
001700040924/*     of the above CRTCMD command:                                  */
001800040924/*                                                                   */
001900040924/*       CrtAutL AutL( CHGUSRSTS )                                   */
002000040924/*               Aut( *EXCLUDE )                                     */
002100040924/*                                                                   */
002200040924/*     Only user profiles explicitely authorized to this             */
002300040924/*     authorization list will be able to run the CHGUSRSTS          */
002400040924/*     command, unless they have *ALLOBJ and *SECADM special         */
002500040924/*     authority.                                                    */
002600040924/*                                                                   */
002700040828/*                                                                   */
002800040606/*-------------------------------------------------------------------*/
002900040828        Cmd      Prompt( 'Change user status' )
003000961213
003100040807
003200040827        Parm     USRPRF        *Name             +
003300040807                 Min( 1 )                        +
003400040827                 Expr( *YES )                    +
003500040827                 Prompt( 'User profile' )
003600040807
003700040827        Parm     RESET         *Char     4       +
003800040827                 Dft( *NO )                      +
003900040807                 Rstd( *YES )                    +
004000040827                 SpcVal(( *NO  )                 +
004100040827                        ( *YES ))                +
004200040807                 Expr( *YES )                    +
004300040827                 Prompt( 'Reset password' )
004400040807
004500040827        Parm     ENABLE        *Char     4       +
004600040827                 Dft( *NO )                      +
004700040827                 Rstd( *YES )                    +
004800040827                 SpcVal(( *NO  )                 +
004900040827                        ( *YES ))                +
005000040827                 Expr( *YES )                    +
005100040827                 Prompt( 'Enable user profile' )
005200040807
005300040807
005400040827        Dep      Ctl( &RESET *EQ '*NO' )         +
005500040827                 Parm(( &ENABLE *EQ '*NO' ))     +
005600040919                 NbrTrue( *EQ 0 )
005700040807
