000100060922/*-------------------------------------------------------------------*/
000200060922/*                                                                   */
000300060922/*  Compile options:                                                 */
000400060922/*                                                                   */
000500060922/*    CrtCmd Cmd( ADDSVRSHR )                                        */
000600060922/*           Pgm( CBX960 )                                           */
000700060922/*           SrcMbr( CBX960X )                                       */
000800060922/*           VldCkr( CBX960V )                                       */
000900060922/*           HlpPnlGrp( CBX960H )                                    */
001000060922/*           HlpId( *CMD )                                           */
001100060922/*                                                                   */
001200060922/*-------------------------------------------------------------------*/
001300060818             Cmd        Prompt( 'Add Server Share' )
001400060818
001500060818             Parm       SHARE       *Char       12         +
001600060818                        Min( 1 )                           +
001700060818                        Expr( *YES )                       +
001800060818                        Prompt( 'Share' )
001900060818
002000060818             Parm       TYPE        *Char       10         +
002100060818                        Rstd( *YES )                       +
002200060818                        SpcVal(( *FILE ) ( *PRINT ))       +
002300060818                        Min( 1 )                           +
002400060818                        Prompt( 'Share type' )
002500060818
002600060818             Parm       PATH        *Pname     1024        +
002700060818                        Expr( *YES )                       +
002800060818                        Vary( *YES *INT2 )                 +
002900060818                        Case( *MIXED )                     +
003000060818                        PmtCtl( P0001 )                    +
003100060818                        Prompt( 'Path' )
003200060818
003300060818             Parm       TEXT        *Char        50        +
003400060818                        Dft( *BLANK )                      +
003500060818                        SpcVal(( *BLANK  ' ' ))            +
003600060818                        Expr( *YES )                       +
003700060818                        Prompt( 'Text ''description''' )
003800060818
003900060818             PARM       PERMISSION  *Int4                  +
004000060818                        Rstd( *YES )                       +
004100060818                        Dft( *READONLY )                   +
004200060818                        SpcVal(( *READONLY  1 )            +
004300060818                               ( *READWRITE 2 ))           +
004400060818                        PmtCtl( P0001 )                    +
004500060818                        Prompt( 'Share permissions' )
004600060818
004700060818             Parm       MAXUSERS    *Int4                  +
004800060818                        Dft( *NOMAX )                      +
004900060818                        Rel( *GT  0 )                      +
005000060818                        SpcVal(( *NOMAX  -1 ))             +
005100060818                        PmtCtl( P0001 )                    +
005200060818                        Prompt( 'Maximum users' )
005300060818
005400060818             Parm       CCSID       *Int4                  +
005500060818                        Dft( *SVRCCSID )                   +
005600060818                        Range( 1  65535 )                  +
005700060818                        SpcVal(( *SVRCCSID  0 ))           +
005800060918                        PmtCtl( P0001 )                    +
005900060818                        Prompt( 'Text conversion CCSID' )
006000060818
006100060818             Parm       CVTTXT      *Char         1        +
006200060918                        Rstd( *YES )                       +
006300060818                        Dft( *NO )                         +
006400060818                        SpcVal(( *NO    '0' )              +
006500060818                               ( *YES   '1' )              +
006600060818                               ( *MIXED '2' ))             +
006700060818                        Expr( *YES )                       +
006800060918                        PmtCtl( P0001 )                    +
006900060818                        Prompt( 'Text conversion' )
007000060818
007100060818             Parm       FILEXT      *Char        46        +
007200060818                        Dft( *NONE )                       +
007300060818                        SngVal(( *NONE  ' ' )              +
007400060918                               ( *ALL   '*' )              +
007500060918                               ( *NOEXT '.' ))             +
007600060918                        Max( 128 )                         +
007700060818                        Vary( *YES *INT2 )                 +
007800060818                        PmtCtl( P0001 )                    +
007900060818                        Prompt( 'File extensions' )
008000060818
008100060918             Parm       OUTQ        Q0001                  +
008200060818                        Choice( *NONE )                    +
008300060818                        PmtCtl( P0002 )                    +
008400060818                        Prompt('Output queue')
008500060818
008600060818             Parm       SPLFTYPE    *Int4                  +
008700060818                        Rstd( *YES )                       +
008800060818                        Dft( *AUTO )                       +
008900060818                        SpcVal(( *USERASCII 1 )            +
009000060818                               ( *AFPDS     2 )            +
009100060818                               ( *SCS       3 )            +
009200060818                               ( *AUTO      4 ))           +
009300060818                        PmtCtl( P0002 )                    +
009400060818                        Prompt( 'Spooled file type' )
009500060818
009600060818             Parm       PRTDRV         *Char     50        +
009700060918                        Dft( *BLANK )                      +
009800060918                        SpcVal(( *BLANK ' ' ))             +
009900060818                        PmtCtl( P0002 )                    +
010000060924                        Prompt( 'Print driver type' )
010100060818
010200060818             Parm       PRTF           Q0001               +
010300060818                        Dft( *NONE )                       +
010400060923                        SngVal(( *NONE ' ' ))              +
010500060918                        PmtCtl( P0002 )                    +
010600060818                        Prompt( 'Printer file' )
010700060818
010800060818             Parm       PUBLISH        *Char      1        +
010900060818                        Rstd( *YES )                       +
011000060818                        Dft( *NO )                         +
011100060818                        SpcVal(( *NO  '0' )                +
011200060818                               ( *YES '1' ))               +
011300060818                        PmtCtl( P0002 )                    +
011400060818                        Prompt( 'Publish print share' )
011500060818
011600060922
011700060818Q0001:       Qual                   *Name        10        +
011800060818                        Min( 1 )                           +
011900060818                        Expr( *YES )
012000060818
012100060818             Qual                   *Name        10        +
012200060818                        Dft( *LIBL )                       +
012300060818                        SpcVal(( *LIBL ) ( *CURLIB ))      +
012400060818                        Expr( *YES )                       +
012500060818                        Prompt( 'Library' )
012600060818
012700060922
012800060818P0001:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*FILE' ))
012900060818
013000060818P0002:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*PRINT' ))
013100060818
013200060922
013300060918             Dep        Ctl( &TYPE *EQ '*FILE' )           +
013400060918                        Parm(( PATH ))                     +
013500060924                        NbrTrue( *ALL )                    +
013600060924                        MsgId( CPFA094 )
013700060922
013800060923             Dep        Ctl( PATH )                        +
013900060923                        Parm(( &TYPE *EQ '*FILE' ))        +
014000060923                        NbrTrue( *ALL )
014100060923
014200060922             Dep        Ctl( &TYPE *EQ '*PRINT' )          +
014300060922                        Parm(( OUTQ ))                     +
014400060922                        NbrTrue( *ALL )
014500060922
014600060923             Dep        Ctl( OUTQ )                        +
014700060923                        Parm(( &TYPE *EQ '*PRINT' ))       +
014800060923                        NbrTrue( *ALL )
014900060923
015000060923             Dep        Ctl( &TYPE *EQ '*PRINT' )          +
015100060923                        Parm(( OUTQ ))                     +
015200060923                        NbrTrue( *ALL )
015300060923
015400060923             Dep        Ctl( PRTF )                        +
015500060923                        Parm(( &TYPE *EQ '*PRINT' ))       +
015600060923                        NbrTrue( *ALL )
015700060923
