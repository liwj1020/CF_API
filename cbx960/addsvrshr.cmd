/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ADDSVRSHR )                                        */
/*           Pgm( CBX960 )                                           */
/*           SrcMbr( CBX960X )                                       */
/*           VldCkr( CBX960V )                                       */
/*           HlpPnlGrp( CBX960H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Add Server Share' )

             Parm       SHARE       *Char       12         +
                        Min( 1 )                           +
                        Expr( *YES )                       +
                        Prompt( 'Share' )

             Parm       TYPE        *Char       10         +
                        Rstd( *YES )                       +
                        SpcVal(( *FILE ) ( *PRINT ))       +
                        Min( 1 )                           +
                        Prompt( 'Share type' )

             Parm       PATH        *Pname     1024        +
                        Expr( *YES )                       +
                        Vary( *YES *INT2 )                 +
                        Case( *MIXED )                     +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Path' )

             Parm       TEXT        *Char        50        +
                        Dft( *BLANK )                      +
                        SpcVal(( *BLANK  ' ' ))            +
                        Expr( *YES )                       +
                        Prompt( 'Text ''description''' )

             PARM       PERMISSION  *Int4                  +
                        Rstd( *YES )                       +
                        Dft( *READONLY )                   +
                        SpcVal(( *READONLY  1 )            +
                               ( *READWRITE 2 ))           +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Share permissions' )

             Parm       MAXUSERS    *Int4                  +
                        Dft( *NOMAX )                      +
                        Rel( *GT  0 )                      +
                        SpcVal(( *NOMAX  -1 ))             +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Maximum users' )

             Parm       CCSID       *Int4                  +
                        Dft( *SVRCCSID )                   +
                        Range( 1  65535 )                  +
                        SpcVal(( *SVRCCSID  0 ))           +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Text conversion CCSID' )

             Parm       CVTTXT      *Char         1        +
                        Rstd( *YES )                       +
                        Dft( *NO )                         +
                        SpcVal(( *NO    '0' )              +
                               ( *YES   '1' )              +
                               ( *MIXED '2' ))             +
                        Expr( *YES )                       +
                        PmtCtl( P0001 )                    +
                        Prompt( 'Text conversion' )

             Parm       FILEXT      *Char        46        +
                        Dft( *NONE )                       +
                        SngVal(( *NONE  ' ' )              +
                               ( *ALL   '*' )              +
                               ( *NOEXT '.' ))             +
                        Max( 128 )                         +
                        Vary( *YES *INT2 )                 +
                        PmtCtl( P0001 )                    +
                        Prompt( 'File extensions' )

             Parm       OUTQ        Q0001                  +
                        Choice( *NONE )                    +
                        PmtCtl( P0002 )                    +
                        Prompt('Output queue')

             Parm       SPLFTYPE    *Int4                  +
                        Rstd( *YES )                       +
                        Dft( *AUTO )                       +
                        SpcVal(( *USERASCII 1 )            +
                               ( *AFPDS     2 )            +
                               ( *SCS       3 )            +
                               ( *AUTO      4 ))           +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Spooled file type' )

             Parm       PRTDRV         *Char     50        +
                        Dft( *BLANK )                      +
                        SpcVal(( *BLANK ' ' ))             +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Print driver type' )

             Parm       PRTF           Q0001               +
                        Dft( *NONE )                       +
                        SngVal(( *NONE ' ' ))              +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Printer file' )

             Parm       PUBLISH        *Char      1        +
                        Rstd( *YES )                       +
                        Dft( *NO )                         +
                        SpcVal(( *NO  '0' )                +
                               ( *YES '1' ))               +
                        PmtCtl( P0002 )                    +
                        Prompt( 'Publish print share' )


Q0001:       Qual                   *Name        10        +
                        Min( 1 )                           +
                        Expr( *YES )

             Qual                   *Name        10        +
                        Dft( *LIBL )                       +
                        SpcVal(( *LIBL ) ( *CURLIB ))      +
                        Expr( *YES )                       +
                        Prompt( 'Library' )


P0001:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*FILE' ))

P0002:       PmtCtl     Ctl( TYPE )  Cond(( *EQ  '*PRINT' ))


             Dep        Ctl( &TYPE *EQ '*FILE' )           +
                        Parm(( PATH ))                     +
                        NbrTrue( *ALL )                    +
                        MsgId( CPFA094 )

             Dep        Ctl( PATH )                        +
                        Parm(( &TYPE *EQ '*FILE' ))        +
                        NbrTrue( *ALL )

             Dep        Ctl( &TYPE *EQ '*PRINT' )          +
                        Parm(( OUTQ ))                     +
                        NbrTrue( *ALL )

             Dep        Ctl( OUTQ )                        +
                        Parm(( &TYPE *EQ '*PRINT' ))       +
                        NbrTrue( *ALL )

             Dep        Ctl( &TYPE *EQ '*PRINT' )          +
                        Parm(( OUTQ ))                     +
                        NbrTrue( *ALL )

             Dep        Ctl( PRTF )                        +
                        Parm(( &TYPE *EQ '*PRINT' ))       +
                        NbrTrue( *ALL )

