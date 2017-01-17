000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500060216/*    CrtCmd Cmd( PRTJOBRUNA )                                       */
000600060216/*           Pgm( CBX9521 )                                          */
000700060216/*           SrcMbr( CBX952X )                                       */
000800060216/*           VldCkr( CBX952V )                                       */
000900060216/*           HlpPnlGrp( CBX952H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300060216          Cmd      Prompt( 'Print Job Run Attributes' )
001400040311
001500060216          Parm     JOBTYP      *Char       1                    +
001600060216                   Dft( *ALL )                                  +
001700060216                   Rstd( *YES )                                 +
001800060216                   SpcVal(( *ALL       '*' )                    +
001900060216                          ( *AUTOSTART 'A' )                    +
002000060216                          ( *BATCH     'B' )                    +
002100060216                          ( *INTERACT  'I' )                    +
002200060216                          ( *SYSTEM    'S' ))                   +
002300041201                   Expr( *YES )                                 +
002400060216                   Prompt( 'Job type' )
002500050319
002600060216          Parm     CPUTIMLMT   *INT4                            +
002700060216                   Dft( *NONE )                                 +
002800060216                   SpcVal(( *NONE  -1 ))                        +
002900050415                   Expr( *YES )                                 +
003000060217                   Prompt( 'CPU time limit in millisecs' )
003100050415
003200060216          Parm     TMPSTGLMT   *INT4                            +
003300060216                   Dft( *NONE )                                 +
003400060216                   SpcVal(( *NONE  -1 ))                        +
003500060216                   Expr( *YES )                                 +
003600060216                   Prompt( 'Temporary storage limit in Mb' )
003700060216
003800100403          Parm     AUXIOLMT    *INT4                            +
003900100403                   Dft( *NONE )                                 +
004000100403                   SpcVal(( *NONE  -1 ))                        +
004100100403                   Expr( *YES )                                 +
004200100403                   Prompt( 'Auxiliary I/O limit in 1000' )
004300100403
004400060216          Parm     ORDER       E0001                            +
004500050319                   Prompt( 'Printing order' )
004600050319
004700050417          Parm     JOBD        Q0001                            +
004800050415                   Dft( *USRPRF )                               +
004900050415                   SngVal(( *USRPRF ))                          +
005000050415                   PmtCtl( *PMTRQS )                            +
005100050415                   Prompt( 'Job description' )
005200050415
005300050417          Parm     OUTQ        Q0001                            +
005400050415                   Dft( *CURRENT )                              +
005500050415                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
005600050415                   PmtCtl( *PMTRQS )                            +
005700050415                   Prompt( 'Output queue' )
005800050415
005900050319
006000041212
006100060216 E0001:   Elem                 *Char      10                    +
006200060217                   Dft( *CPUTIM )                               +
006300050319                   Rstd( *YES )                                 +
006400060217                   SpcVal(( *CPUTIM )                           +
006500100403                          ( *TMPSTG )                           +
006600100403                          ( *AUXIO  ))                          +
006700050319                   Expr( *YES )                                 +
006800050415                   Prompt( 'Sort fields' )
006900050319
007000050415          Elem                 *Char      10                    +
007100060217                   Dft( *DESCEND )                              +
007200050319                   Rstd( *YES )                                 +
007300050319                   SpcVal(( *ASCEND )                           +
007400050319                          ( *DESCEND ))                         +
007500050319                   Expr( *YES )                                 +
007600050319                   Prompt( 'Sequence' )
007700050319
007800060216 Q0001:   Qual                 *Name      10                    +
007900060216                   Expr( *Yes )
008000060216
008100060216          Qual                 *Name      10                    +
008200060216                   Dft( *LIBL )                                 +
008300060216                   SpcVal(( *LIBL ) ( *CURLIB ))                +
008400060216                   Expr( *Yes )                                 +
008500060216                   Prompt( 'Library' )
008600060216
008700060216
008800050415
