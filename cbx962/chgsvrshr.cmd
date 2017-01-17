000100060922/*-------------------------------------------------------------------*/
000200060922/*                                                                   */
000300060922/*  Compile options:                                                 */
000400060922/*                                                                   */
000500061014/*    CrtCmd Cmd( CHGSVRSHR )                                        */
000600061014/*           Pgm( CBX962 )                                           */
000700061014/*           SrcMbr( CBX962X )                                       */
000800061014/*           VldCkr( CBX962V )                                       */
000900061014/*           HlpPnlGrp( CBX962H )                                    */
001000060922/*           HlpId( *CMD )                                           */
001100061014/*           PmtOvrPgm( CBX962O )                                    */
001200060922/*                                                                   */
001300060922/*-------------------------------------------------------------------*/
001400061014             Cmd        Prompt( 'Change Server Share' )
001500060818
001600060818             Parm       SHARE       *Char       12         +
001700060818                        Min( 1 )                           +
001800060818                        Expr( *YES )                       +
001900061014                        Keyparm( *YES )                    +
002000060818                        Prompt( 'Share' )
002100060818
002200060818             Parm       TYPE        *Char       10         +
002300060818                        Rstd( *YES )                       +
002400060818                        SpcVal(( *FILE ) ( *PRINT ))       +
002500060818                        Min( 1 )                           +
002600061014                        Keyparm( *YES )                    +
002700060818                        Prompt( 'Share type' )
002800060818
002900060818             Parm       PATH        *Pname     1024        +
003000061015                        Dft( *SAME )                       +
003100061015                        SpcVal( *SAME )                    +
003200060818                        Expr( *YES )                       +
003300060818                        Vary( *YES *INT2 )                 +
003400060818                        Case( *MIXED )                     +
003500060818                        PmtCtl( P0001 )                    +
003600060818                        Prompt( 'Path' )
003700060818
003800060818             Parm       TEXT        *Char        50        +
003900061015                        Dft( *SAME )                       +
004000061015                        SpcVal(( *BLANK  ' ' ) ( *SAME ))  +
004100060818                        Expr( *YES )                       +
004200060818                        Prompt( 'Text ''description''' )
004300060818
004400060818             PARM       PERMISSION  *Int4                  +
004500060818                        Rstd( *YES )                       +
004600061015                        Dft( *SAME )                       +
004700061015                        SpcVal(( *SAME      0 )            +
004800061015                               ( *READONLY  1 )            +
004900061015                               ( *READWRITE 2 ))           +
005000060818                        PmtCtl( P0001 )                    +
005100060818                        Prompt( 'Share permissions' )
005200060818
005300060818             Parm       MAXUSERS    *Int4                  +
005400061015                        Dft( *SAME )                       +
005500060818                        Rel( *GT  0 )                      +
005600061015                        SpcVal(( *SAME    0 )              +
005700061015                               ( *NOMAX  -1 ))             +
005800060818                        PmtCtl( P0001 )                    +
005900060818                        Prompt( 'Maximum users' )
006000060818
006100060818             Parm       CCSID       *Int4                  +
006200061015                        Dft( *SAME )                       +
006300060818                        Range( 1  65535 )                  +
006400061015                        SpcVal(( *SAME     -1 )            +
006500061015                               ( *SVRCCSID  0 ))           +
006600060918                        PmtCtl( P0001 )                    +
006700060818                        Prompt( 'Text conversion CCSID' )
006800060818
006900060818             Parm       CVTTXT      *Char         1        +
007000061015                        Rstd( *YES )                       +
007100061015                        Dft( *SAME )                       +
007200061015                        SpcVal(( *SAME  '*' )              +
007300061015                               ( *NO    '0' )              +
007400060818                               ( *YES   '1' )              +
007500060818                               ( *MIXED '2' ))             +
007600060818                        Expr( *YES )                       +
007700060918                        PmtCtl( P0001 )                    +
007800060818                        Prompt( 'Text conversion' )
007900060818
008000060818             Parm       FILEXT      *Char        46        +
008100061015                        Dft( *SAME )                       +
008200061015                        SngVal(( *SAME      )              +
008300061015                               ( *NONE  ' ' )              +
008400060918                               ( *ALL   '*' )              +
008500060918                               ( *NOEXT '.' ))             +
008600060918                        Max( 128 )                         +
008700060818                        Vary( *YES *INT2 )                 +
008800060818                        PmtCtl( P0001 )                    +
008900060818                        Prompt( 'File extensions' )
009000060818
009100060918             Parm       OUTQ        Q0001                  +
009200061015                        Dft( *SAME )                       +
009300061015                        SngVal(( *SAME ))                  +
009400060818                        Choice( *NONE )                    +
009500060818                        PmtCtl( P0002 )                    +
009600060818                        Prompt('Output queue')
009700060818
009800060818             Parm       SPLFTYPE    *Int4                  +
009900060818                        Rstd( *YES )                       +
010000061015                        Dft( *SAME )                       +
010100061015                        SpcVal(( *SAME      0 )            +
010200061015                               ( *USERASCII 1 )            +
010300060818                               ( *AFPDS     2 )            +
010400060818                               ( *SCS       3 )            +
010500060818                               ( *AUTO      4 ))           +
010600060818                        PmtCtl( P0002 )                    +
010700060818                        Prompt( 'Spooled file type' )
010800060818
010900060818             Parm       PRTDRV         *Char     50        +
011000061015                        Dft( *SAME )                       +
011100061015                        SpcVal(( *SAME      )              +
011200061015                               ( *BLANK ' ' ))             +
011300060818                        PmtCtl( P0002 )                    +
011400060924                        Prompt( 'Print driver type' )
011500060818
011600060818             Parm       PRTF           Q0001               +
011700061015                        Dft( *SAME )                       +
011800061015                        SngVal(( *SAME     )               +
011900061015                               ( *NONE ' ' ))              +
012000060918                        PmtCtl( P0002 )                    +
012100060818                        Prompt( 'Printer file' )
012200060818
012300060818             Parm       PUBLISH        *Char      1        +
012400060818                        Rstd( *YES )                       +
012500061015                        Dft( *SAME )                       +
012600061015                        SpcVal(( *SAME '*' )               +
012700061015                               ( *NO   '0' )               +
012800061015                               ( *YES  '1' ))              +
012900060818                        PmtCtl( P0002 )                    +
013000060818                        Prompt( 'Publish print share' )
013100060818
013200060922
013300060818Q0001:       Qual                   *Name        10        +
013400060818                        Expr( *YES )
013500060818
013600060818             Qual                   *Name        10        +
013700060818                        Dft( *LIBL )                       +
013800060818                        SpcVal(( *LIBL ) ( *CURLIB ))      +
013900060818                        Expr( *YES )                       +
014000060818                        Prompt( 'Library' )
014100060818
014200060922
014300060818P0001:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*FILE' ))
014400060818
014500060818P0002:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*PRINT' ))
014600061015
