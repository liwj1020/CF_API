000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500060623/*    CrtCmd Cmd( WRKNETUSR )                                        */
000600060728/*           Pgm( CBX958 )                                           */
000700060728/*           VldCkr( CBX958V )                                       */
000800060728/*           SrcMbr( CBX958X )                                       */
000900060728/*           HlpPnlGrp( CBX958H )                                    */
001000031113/*           HlpId( *CMD )                                           */
001100031113/*                                                                   */
001200031113/*-------------------------------------------------------------------*/
001300060729          Cmd      Prompt( 'Work with NetServer Users' )
001400930930
001500060728          Parm     USRPRF      *Generic   10                    +
001600060623                   Dft( *ALL )                                  +
001700060623                   Expr( *YES )                                 +
001800060623                   SpcVal(( *ALL ))                             +
001900060623                   Prompt( 'User profile' )
002000060623
002100060729          Parm     STATUS      *Char      10                    +
002200060623                   Dft( *DISABLED )                             +
002300060623                   Rstd( *YES )                                 +
002400060729                   SpcVal(( *DISABLED ))                        +
002500060623                   Expr( *YES )                                 +
002600060623                   Prompt( 'Status' )
002700060623
002800060729          Parm     OUTPUT      *Char       3                    +
002900060729                   Rstd( *YES )                                 +
003000060729                   Dft( * )                                     +
003100060729                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
003200060729                   Prompt( 'Output' )
003300060729