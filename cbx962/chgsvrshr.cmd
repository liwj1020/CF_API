/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHGSVRSHR )                                        */
/*           Pgm( CBX962 )                                           */
/*           SrcMbr( CBX962X )                                       */
/*           VldCkr( CBX962V )                                       */
/*           HlpPnlGrp( CBX962H )                                    */
/*           HlpId( *CMD )                                           */
/*           PmtOvrPgm( CBX962O )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Change Server Share' )

             Parm       SHARE       *Char       12         +
                        Min( 1 )                           +
                        Expr( *YES )                       +
                        Keyparm( *YES )                    +
                        Prompt( 'Share' )

             Parm       TYPE        *Char       10         +
                        Rstd( *YES )                       +
                        SpcVal(( *FILE ) ( *PRINT ))       +
                        Min( 1 )                           +
                        Keyparm( *YES )                    +
                        Prompt( 'Share type' )

             Parm       PATH        *Pname     1024        +
                        Dft( *SAME )                       +
                        SpcVal( *SAME )                    +
                        Expr( *YES )                       +
                        Vary( *YES *INT2 )                 +
                        Case( *MIXED )                     +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Path' )

             Parm       TEXT        *Char        50        +
                        Dft( *SAME )                       +
                        SpcVal(( *BLANK  ' ' ) ( *SAME ))  +
                        Expr( *YES )                       +
                        Prompt( 'Text ''description''' )

             PARM       PERMISSION  *Int4                  +
                        Rstd( *YES )                       +
                        Dft( *SAME )                       +
                        SpcVal(( *SAME      0 )            +
                               ( *READONLY  1 )            +
                               ( *READWRITE 2 ))           +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Share permissions' )

             Parm       MAXUSERS    *Int4                  +
                        Dft( *SAME )                       +
                        Rel( *GT  0 )                      +
                        SpcVal(( *SAME    0 )              +
                               ( *NOMAX  -1 ))             +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Maximum users' )

             Parm       CCSID       *Int4                  +
                        Dft( *SAME )                       +
                        Range( 1  65535 )                  +
                        SpcVal(( *SAME     -1 )            +
                               ( *SVRCCSID  0 ))           +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Text conversion CCSID' )

             Parm       CVTTXT      *Char         1        +
                        Rstd( *YES )                       +
                        Dft( *SAME )                       +
                        SpcVal(( *SAME  '*' )              +
                               ( *NO    '0' )              +
                               ( *YES   '1' )              +
                               ( *MIXED '2' ))             +
                        Expr( *YES )                       +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Text conversion' )

             Parm       FILEXT      *Char        46        +
                        Dft( *SAME )                       +
                        SngVal(( *SAME      )              +
                               ( *NONE  ' ' )              +
                               ( *ALL   '*' )              +
                               ( *NOEXT '.' ))             +
                        Max( 128 )                         +
                        Vary( *YES *INT2 )                 +
                        PmtCtl( P0001 )                    +
                        Prompt( 'File extensions' )

             Parm       OUTQ        Q0001                  +
                        Dft( *SAME )                       +
                        SngVal(( *SAME ))                  +
                        Choice( *NONE )                    +
                        PmtCtl( P0002 )                    +
                        Prompt('Output queue')

             Parm       SPLFTYPE    *Int4                  +
                        Rstd( *YES )                       +
                        Dft( *SAME )                       +
                        SpcVal(( *SAME      0 )            +
                               ( *USERASCII 1 )            +
                               ( *AFPDS     2 )            +
                               ( *SCS       3 )            +
                               ( *AUTO      4 ))           +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Spooled file type' )

             Parm       PRTDRV         *Char     50        +
                        Dft( *SAME )                       +
                        SpcVal(( *SAME      )              +
                               ( *BLANK ' ' ))             +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Print driver type' )

             Parm       PRTF           Q0001               +
                        Dft( *SAME )                       +
                        SngVal(( *SAME     )               +
                               ( *NONE ' ' ))              +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Printer file' )

             Parm       PUBLISH        *Char      1        +
                        Rstd( *YES )                       +
                        Dft( *SAME )                       +
                        SpcVal(( *SAME '*' )               +
                               ( *NO   '0' )               +
                               ( *YES  '1' ))              +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Publish print share' )


Q0001:       Qual                   *Name        10        +
                        Expr( *YES )

             Qual                   *Name        10        +
                        Dft( *LIBL )                       +
                        SpcVal(( *LIBL ) ( *CURLIB ))      +
                        Expr( *YES )                       +
                        Prompt( 'Library' )


P0001:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*FILE' ))

P0002:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*PRINT' ))

