000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050626/*    CrtCmd Cmd( RTVSYSDTA )                                        */
000600050625/*           Pgm( CBX939 )                                           */
000700050625/*           SrcMbr( CBX939X )                                       */
000800041201/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
000900050625/*           HlpPnlGrp( CBX939H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050626          Cmd      Prompt( 'Retrieve System Data')
001400040723
001500050626          Parm     RESET         *Char    10                    +
001600050626                   Dft( *NO )                                   +
001700050626                   Rstd( *YES )                                 +
001800050626                   SpcVal(( *NO  )                              +
001900050626                          ( *YES ))                             +
002000050626                   Expr( *YES )                                 +
002100050626                   Prompt( 'Reset statistics' )
002200050626
002300050625          Parm     PRCTYPE     *Char       4                    +
002400050625                   RtnVal( *YES )                               +
002500050625                   Prompt( 'CL var for PRCTYPE       (4)' )
002600050625
002700050625          Parm     PRCGROUP    *Char       4                    +
002800050625                   RtnVal( *YES )                               +
002900050625                   Prompt( 'CL var for PRCGROUP      (4)' )
003000050625
003100050626          Parm     MAINSTGSIZ  *Dec     ( 10 0 )                +
003200050625                   RtnVal( *YES )                               +
003300050626                   Prompt( 'CL var for MAINSTGSIZ (10 0)' )
003400050625
003500050625          Parm     TOTAUXSTG   *Dec     ( 10 0 )                +
003600050625                   RtnVal( *YES )                               +
003700050625                   Prompt( 'CL var for TOTAUXSTG  (10 0)' )
003800050625
003900050625          Parm     SYSASPSIZ   *Dec     ( 10 0 )                +
004000050625                   RtnVal( *YES )                               +
004100050625                   Prompt( 'CL var for SYSASPSIZ  (10 0)' )
004200050625
004300050626          Parm     SYSASPUSED  *Dec     (  7 4 )                +
004400050625                   RtnVal( *YES )                               +
004500050626                   Prompt( 'CL var for SYSASPUSED  (7 4)' )
004600050625
004700050625          Parm     SYSASPTHR   *Dec     (  4 1 )                +
004800050625                   RtnVal( *YES )                               +
004900050625                   Prompt( 'CL var for SYSASPTHR   (4 1)' )
005000050625
005100050625          Parm     CPUPCTUSED  *Dec     (  4 1 )                +
005200050625                   RtnVal( *YES )                               +
005300050625                   Prompt( 'CL var for CPUPCTUSED  (4 1)' )
005400050625
005500050625          Parm     DBCAPUSED   *Dec     (  4 1 )                +
005600050625                   RtnVal( *YES )                               +
005700050625                   Prompt( 'CL var for DBCAPUSED   (4 1)' )
005800050625
005900050625          Parm     PRCINTTHR   *Dec     (  4 1 )                +
006000050625                   RtnVal( *YES )                               +
006100050625                   Prompt( 'CL var for PRCINTTHR   (4 1)' )
006200050625
006300050625          Parm     PRCINTLMT   *Dec     (  4 1 )                +
006400050625                   RtnVal( *YES )                               +
006500050625                   Prompt( 'CL var for PRCINTLMT   (4 1)' )
006600050625
006700050625          Parm     DBCAPTHR    *Dec     (  4 1 )                +
006800050625                   RtnVal( *YES )                               +
006900050625                   Prompt( 'CL var for DBCAPTHR    (4 1)' )
007000050625
007100050625          Parm     DBCAPLMT    *Dec     (  4 1 )                +
007200050625                   RtnVal( *YES )                               +
007300050625                   Prompt( 'CL var for DBCAPLMT    (4 1)' )
007400050625
007500050625          Parm     OSREL       *Char       6                    +
007600050625                   RtnVal( *YES )                               +
007700050625                   Prompt( 'CL var for OSREL         (6)' )
007800050625
007900050625          Parm     SYSSTT      *Char       1                  +
008000050625                   RtnVal( *YES )                             +
008100050625                   Prompt( 'CL var for SYSSTT        (1)' )
008200050625
008300050625          Parm     TCPSTS      *Char       1                    +
008400050625                   RtnVal( *YES )                               +
008500050625                   Prompt( 'CL var for TCPSTS        (1)' )
008600050625
008700050625          Parm     IPLDTS      *Char      17                    +
008800050625                   RtnVal( *YES )                               +
008900050625                   Prompt( 'CL var for IPLDTS       (17)' )
009000050625
009100050625          Parm     CURIPLTYP   *Char       1                    +
009200050625                   RtnVal( *YES )                               +
009300050625                   Prompt( 'CL var for CURIPLTYP     (1)' )
009400050625
009500050625          Parm     PNLKEYPOS   *Char       6                    +
009600050625                   RtnVal( *YES )                               +
009700050625                   Prompt( 'CL var for PNLKEYPOS     (6)' )
009800041201
