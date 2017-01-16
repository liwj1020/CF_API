000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500070519/*    CrtCmd Cmd( WRKOUTQAUT )                                       */
000600070519/*           Pgm( CBX971 )                                           */
000700070519/*           SrcMbr( CBX971X )                                       */
000800070519/*           VldCkr( CBX971V )                                       */
000900060519/*           AlwLmtUsr( *NO )                                        */
001000070519/*           HlpPnlGrp( CBX971H )                                    */
001100031113/*           HlpId( *CMD )                                           */
001200031113/*                                                                   */
001300031113/*-------------------------------------------------------------------*/
001400140101          Cmd      Prompt( 'Work with Output Queue Auth' )      +
001500140101                   MaxPos( 3 )                                  +
001600140101                   AlwLmtUsr( *NO )                             +
001700140101                   VldCkr( CBX971V )                            +
001800140101                   HlpId( *CMD )                                +
001900140101                   HlpPnlGrp( CBX971H )                         +
002000140101                   Text( 'Work with Output Queue Auth' )
002100930930
002200070519          Parm     OUTQ        Q0001                            +
002300070519                   Min( 1 )                                     +
002400070519                   Prompt( 'Output queue' )
002500040925
002600070519          Parm     USRPRF      *Generic   10                    +
002700070519                   Dft( *ALL )                                  +
002800070519                   Expr( *YES )                                 +
002900070519                   SpcVal(( *ALL ))                             +
003000070519                   Prompt( 'User profile' )
003100070519
003200070519          Parm     OUTPUT      *Char       3                    +
003300070519                   Rstd( *YES )                                 +
003400070519                   Dft( * )                                     +
003500070519                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
003600070519                   Prompt( 'Output' )
003700070519
003800040926
003900070519 Q0001:   Qual                 *Name                            +
004000070519                   Expr( *YES )
004100040926
004200070519          Qual                 *Name                            +
004300070519                   Dft( *LIBL )                                 +
004400070519                   SpcVal(( *LIBL ) ( *CURLIB ))                +
004500070519                   Expr( *YES )                                 +
004600070519                   Prompt( 'Library' )
004700040925
