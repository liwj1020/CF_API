000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500060819/*    CrtCmd Cmd( RMVJRNRCV )                                        */
000600060819/*           Pgm( CBX959 )                                           */
000700060819/*           SrcMbr( CBX959X )                                       */
000800060819/*           VldCkr( CBX959V )                                       */
000900060819/*           HlpPnlGrp( CBX959H )                                    */
001000031113/*           HlpId( *CMD )                                           */
001100031113/*                                                                   */
001200031113/*-------------------------------------------------------------------*/
001300060819             Cmd        Prompt( 'Remove Journal Receivers' )
001400930930
001500040925             Parm       JRN           Q0001                          +
001600040925                        Min( 1 )                                     +
001700040925                        Prompt( 'Journal' )
001800040925
001900041002             Parm       DAYS          *Int2                          +
002000041002                        Range( 1  999 )                              +
002100041002                        Dft( *NONE )                                 +
002200041002                        SpcVal(( *NONE  -1 ))                        +
002300041002                        Prompt( 'Journal receiver retain days' )
002400041002
002500040926             Parm       RETAIN        *Int2                          +
002600040926                        Range( 1  999 )                              +
002700040926                        Dft( *NONE )                                 +
002800040926                        SpcVal(( *NONE  -1 ))                        +
002900040926                        Prompt( 'Journal receivers to retain' )
003000031113
003100040926             Parm       FORCE         *Char    3                     +
003200040926                        Rstd( *YES )                                 +
003300040926                        Dft( *NO )                                   +
003400040926                        SpcVal(( *NO   NO  )                         +
003500040926                               ( *YES  YES ))                        +
003600040926                        Prompt( 'Force receiver deletion' )
003700040926
003800060818             Parm       CHGJRN        *Char    3                     +
003900060818                        Rstd( *YES )                                 +
004000060818                        Dft( *NO )                                   +
004100060818                        SpcVal(( *NO   NO  )                         +
004200060818                               ( *YES  YES ))                        +
004300060818                        Prompt( 'Change journal receiver' )
004400060818
004500060818             Parm       JRNRCV        E0002                          +
004600060818                        Dft( *SAME )                                 +
004700060818                        SngVal(( *SAME ))                            +
004800060818                        PmtCtl( CHGJRNRCV )                          +
004900060818                        Prompt( 'Journal receiver' )
005000060818
005100060818             Parm       SEQOPT        *Char    6                     +
005200060818                        Rstd( *YES )                                 +
005300060818                        Dft( *CONT )                                 +
005400060818                        SpcVal(( *CONT ) ( *RESET ))                 +
005500060818                        Expr( *YES )                                 +
005600060818                        PmtCtl( CHGJRNRCV )                          +
005700060818                        Prompt( 'Sequence option' )
005800040926
005900040926 Q0001:      Qual                   *Name                            +
006000040926                        Expr( *YES )
006100040926
006200040926             Qual                   *Name                            +
006300040926                        Dft( *LIBL )                                 +
006400040926                        SpcVal(( *LIBL ) ( *CURLIB ))                +
006500040926                        Expr( *YES )                                 +
006600040926                        Prompt( 'Library' )
006700961107
006800060818 Q0002:      Qual                     *Name      10                  +
006900060818                        Expr( *YES )
007000060818
007100060818             Qual                     *Name      10                  +
007200060818                        Dft( *LIBL )                                 +
007300060818                        Rel( *NE QTEMP )                             +
007400060818                        SpcVal(( *LIBL ) ( *CURLIB ))                +
007500060818                        Expr( *YES )                                 +
007600060818                        Prompt('Library')
007700060818
007800060818 E0002:      Elem                     Q0002                          +
007900060818                        SngVal(( *GEN ))                             +
008000060818                        Prompt( 'Journal receiver' )
008100060818
008200060818             Elem                     Q0002                          +
008300060818                        SngVal(( *GEN ))                             +
008400060818                        Prompt( 'Journal receiver' )
008500060818
008600031115
008700060818 CHGJRNRCV:  PmtCtl     Ctl( CHGJRN )                                +
008800060818                        Cond(( *EQ YES ))
008900040925
009000060818             Dep        Ctl( &CHGJRN *EQ 'NO ' )                     +
009100060818                        Parm(( JRNRCV ))                             +
009200040925                        NbrTrue( *EQ 0 )
009300040925
009400060818             Dep        Ctl( &CHGJRN *EQ 'NO ' )                     +
009500060818                        Parm(( SEQOPT ))                             +
009600060818                        NbrTrue( *EQ 0 )
009700060818
009800060818             Dep        Ctl( &CHGJRN *EQ 'YES' )                     +
009900060818                        Parm(( &JRNRCV *EQ '*SAME' ))                +
010000060818                        NbrTrue( *EQ 0 )
010100060818
