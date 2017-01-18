000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050318/*    CrtCmd Cmd( PRTSAVINF )                                        */
000600050428/*           Pgm( CBX9321 )                                          */
000700050318/*           SrcMbr( CBX932X )                                       */
000800050415/*           VldCkr( CBX932V )                                       */
000900050318/*           HlpPnlGrp( CBX932H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050318          Cmd      Prompt( 'Print save information' )
001400040311
001500050415          Parm     LIB         *Generic   10                    +
001600041201                   Min( 1 )                                     +
001700050415                   SpcVal(( *ALL     )                          +
001800050415                          ( *ALLUSR  )                          +
001900050415                          ( *IBM     )                          +
002000050415                          ( *USRLIBL )                          +
002100050415                          ( *CURLIB  )                          +
002200050415                          ( *LIBL    ))                         +
002300041201                   Expr( *YES )                                 +
002400050415                   Vary( *YES *INT2 )                           +
002500050415                   Prompt( 'Library' )
002600050319
002700050415          Parm     LEVEL       *Char      10                    +
002800050417                   Dft( *LIB )                                  +
002900050415                   Rstd( *YES )                                 +
003000050415                   SpcVal(( *LIB )                              +
003100050415                          ( *OBJ ))                             +
003200050415                   Expr( *YES )                                 +
003300050415                   Prompt( 'Information level' )
003400050415
003500050415          Parm     INCLUDE     E0001                            +
003600050319                   Dft( *NOCHK )                                +
003700050319                   SngVal(( *NOCHK 000000 ))                    +
003800050319                   Prompt( 'Include' )
003900041212
004000050415          Parm     ORDER       E0002                            +
004100050319                   Prompt( 'Printing order' )
004200050319
004300050417          Parm     JOBD        Q0001                            +
004400050415                   Dft( *USRPRF )                               +
004500050415                   SngVal(( *USRPRF ))                          +
004600050415                   PmtCtl( *PMTRQS )                            +
004700050415                   Prompt( 'Job description' )
004800050415
004900050417          Parm     OUTQ        Q0001                            +
005000050415                   Dft( *CURRENT )                              +
005100050415                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
005200050415                   PmtCtl( *PMTRQS )                            +
005300050415                   Prompt( 'Output queue' )
005400050415
005500050319
005600050415 E0001:   Elem                 *Date                            +
005700050319                   SpcVal(( *CURRENT 000001 ))                  +
005800050319                   Expr( *YES )                                 +
005900050319                   Prompt( 'Save date' )
006000050319
006100050415          Elem                 *Char      10                    +
006200050319                   Dft( *BEFORE )                               +
006300050319                   SpcVal(( *BEFORE ) ( *AFTER ))               +
006400050319                   Rstd( *Yes )                                 +
006500050319                   Expr( *Yes )                                 +
006600050319                   Prompt( 'Relation' )
006700041212
006800050415 E0002:   Elem                 *Char      10                    +
006900050415                   Dft( *LIBOBJ )                               +
007000050319                   Rstd( *YES )                                 +
007100050415                   SpcVal(( *LIBOBJ )                           +
007200050417                          ( *LIBSAV ))                          +
007300050319                   Expr( *YES )                                 +
007400050415                   Prompt( 'Sort fields' )
007500050319
007600050415          Elem                 *Char      10                    +
007700050319                   Dft( *ASCEND )                               +
007800050319                   Rstd( *YES )                                 +
007900050319                   SpcVal(( *ASCEND )                           +
008000050319                          ( *DESCEND ))                         +
008100050319                   Expr( *YES )                                 +
008200050319                   Prompt( 'Sequence' )
008300050319
008400050417 Q0001:   Qual                 *Name      10                    +
008500050415                   Expr( *Yes )
008600050415
008700050415          Qual                 *Name      10                    +
008800050415                   Dft( *LIBL )                                 +
008900050415                   SpcVal(( *LIBL ) ( *CURLIB ))                +
009000050415                   Expr( *Yes )                                 +
009100050415                   Prompt( 'Library' )
009200050415
009300050318
009400050415          Dep      Ctl( &LEVEL *EQ '*OBJ' )                     +
009500050415                   Parm(( &LIB *EQ '*IBM' ))                    +
009600050415                   NbrTrue( *EQ 0 )
009700050415
009800050415          Dep      Ctl( &LEVEL *EQ '*LIB' )                     +
009900050415                   Parm(( &LIB *EQ '*LIBL'    )                 +
010000050415                        ( &LIB *EQ '*CURLIB'  )                 +
010100050415                        ( &LIB *EQ '*USRLIBL' ))                +
010200050415                   NbrTrue( *EQ 0 )
010300050415
