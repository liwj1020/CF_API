000100030809/*-------------------------------------------------------------------*/
000200030809/*                                                                   */
000300030809/*  Compile options:                                                 */
000400030809/*                                                                   */
000500050917/*    CrtCmd Cmd( CHGPRFEXIT )                                       */
000600050917/*           Pgm( CBX945 )                                           */
000700050917/*           SrcMbr( CBX945X )                                       */
000800050917/*           HlpPnlGrp( CBX945H )                                    */
000900030809/*           HlpId( *CMD )                                           */
001000050917/*           PmtOvrPgm( CBX945O )                                    */
001100030809/*                                                                   */
001200030809/*-------------------------------------------------------------------*/
001300050917        Cmd        Prompt( 'Change Profile Exit Program' )
001400961106
001500050917        Parm       USRPRF        *Name                     +
001600050917                   Min( 1 )                                +
001700050917                   SpcVal(( *CURRENT ))                    +
001800050917                   Expr( *YES )                            +
001900050917                   Keyparm( *YES )                         +
002000050917                   Prompt( 'User profile' )
002100050917
002200050917        Parm       FORMAT        *Char      8              +
002300050917                   Rstd( *YES )                            +
002400050917                   Dft( *SYSRQS )                          +
002500050917                   SpcVal(( *SYSRQS  SREQ0100 )            +
002600050917                          ( *ATTN    ATTN0100 ))           +
002700050917                   Expr( *YES )                            +
002800050917                   Keyparm( *YES )                         +
002900050917                   Prompt( 'Exit program format' )
003000050917
003100050917        Parm       EXITPGM       E0001                     +
003200050917                   Prompt( 'Exit program option' )
003300050917
003400050917
003500050917E0001:  Elem                    *INT4                           +
003600050917                   Rstd( *YES )                                 +
003700050917                   Dft( *SAME )                                 +
003800050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
003900050917                   Expr( *YES )                                 +
004000050917                   Prompt( 'Program 1' )
004100050917
004200050917        Elem                    *INT4                           +
004300050917                   Rstd( *YES )                                 +
004400050917                   Dft( *SAME )                                 +
004500050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
004600050917                   Expr(*YES)                                   +
004700050917                   Prompt( 'Program 2' )
004800050917
004900050917        Elem                    *INT4                           +
005000050917                   Rstd( *YES )                                 +
005100050917                   Dft( *SAME )                                 +
005200050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
005300050917                   Expr( *YES )                                 +
005400050917                   Prompt( 'Program 3' )
005500050917
005600050917        Elem                    *INT4                           +
005700050917                   Rstd( *YES )                                 +
005800050917                   Dft( *SAME )                                 +
005900050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
006000050917                   Expr( *YES )                                 +
006100050917                   Prompt( 'Program 4' )
006200050917
006300050917        Elem                    *INT4                           +
006400050917                   Rstd( *YES )                                 +
006500050917                   Dft( *SAME )                                 +
006600050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
006700050917                   Expr( *YES )                                 +
006800050917                   Prompt( 'Program 5' )
006900050917
007000050917        Elem                    *INT4                           +
007100050917                   Rstd( *YES )                                 +
007200050917                   Dft( *SAME )                                 +
007300050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
007400050917                   Expr( *YES )                                 +
007500050917                   Prompt( 'Program 6' )
007600050917
007700050917        Elem                    *INT4                           +
007800050917                   Rstd( *YES )                                 +
007900050917                   Dft( *SAME )                                 +
008000050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
008100050917                   Expr( *YES )                                 +
008200050917                   Prompt( 'Program 7' )
008300050917
008400050917        Elem                    *INT4                           +
008500050917                   Rstd( *YES )                                 +
008600050917                   Dft( *SAME )                                 +
008700050917                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
008800050917                   Expr( *YES )                                 +
008900050917                   Prompt( 'Program 8' )
009000050917
