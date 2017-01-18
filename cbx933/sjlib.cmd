000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050325/*    CrtCmd Cmd( STRJRNLIB )                                        */
000600050325/*           Pgm( CBX933 )                                           */
000700050325/*           SrcMbr( CBX933X )                                       */
000800050325/*           VldCkr( CBX933V )                                       */
000900050325/*           HlpPnlGrp( CBX933H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050327          Cmd      Prompt( 'Start Journal for Library' )
001400040311
001500050325          Parm     LIB         *Name       10                   +
001600041201                   Min( 1 )                                     +
001700041201                   Expr( *YES )                                 +
001800050325                   Prompt( 'Library' 1 )
001900041201
002000050325          Parm     JRN         Q0001                            +
002100050325                   Min( 1 )                                     +
002200050325                   Choice( *NONE )                              +
002300050325                   Prompt( 'Journal' 4 )
002400050325
002500050325          Parm     OBJ         *Generic    10                   +
002600050325                   Dft( *ALL )                                  +
002700050325                   SpcVal(( *ALL ))                             +
002800050325                   Prompt( 'Object' 2 )
002900050325
003000050325          Parm     OBJTYPE     *Char       10                   +
003100041201                   Rstd( *YES )                                 +
003200050325                   Dft( *ALL )                                  +
003300050325                   SpcVal(( *ALL    )                           +
003400050325                          ( *FILE   )                           +
003500050325                          ( *DTAQ   )                           +
003600050325                          ( *DTAARA ))                          +
003700041201                   Expr( *YES )                                 +
003800050325                   Prompt( 'Object type' 3 )
003900050325
004000050325          Parm     IMAGES      *Char        6                   +
004100050325                   RstD( *YES )                                 +
004200050325                   Dft( *AFTER )                                +
004300050325                   SpcVal(( *AFTER ) ( *BOTH ))                 +
004400050325                   Expr( *YES )                                 +
004500050325                   Prompt( 'Record images' 5 )
004600050325
004700050325          Parm     OMTJRNE     *Char       10                   +
004800050325                   Rstd( *YES )                                 +
004900050325                   Dft( *NONE )                                 +
005000050325                   SpcVal(( *NONE ) ( *OPNCLO ))                +
005100050325                   Expr( *YES )                                 +
005200050325                   PmtCtl( P0001 )                              +
005300050325                   Prompt( 'Journal entries to be omitted' 6 )
005400050306
005500041212
005600050325 Q0001:   Qual                 *Name       10                   +
005700050325                   Expr( *Yes )
005800050325
005900050325          Qual                 *Name       10                   +
006000050325                   Dft( *LIBL )                                 +
006100050325                   SpcVal(( *LIBL ) ( *CURLIB ))                +
006200050325                   Expr( *Yes )                                 +
006300050325                   Prompt( 'Library' )
006400041212
006500050325
006600050325 P0001:   PmtCtl   Ctl( OBJTYPE )                               +
006700050325                   Cond(( *EQ '*ALL' ))
006800050325
006900050325          PmtCtl   Ctl( OBJTYPE )                               +
007000050325                   Cond(( *EQ '*FILE' ))                        +
007100050325                   LglRel( *OR )
007200050325
007300050325
007400050325          Dep      Ctl( &OBJTYPE *EQ '*DTAQ' )                  +
007500050325                   Parm(( &IMAGES *EQ '*BOTH' ))                +
007600050326                   NbrTrue( *EQ 0 )                             +
007700050325                   MsgId( CPD7013 )
007800050325
