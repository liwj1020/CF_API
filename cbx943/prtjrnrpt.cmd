000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500050825/*    CrtCmd Cmd( PRTJRNRPT )                                        */
000600050825/*           Pgm( CBX9431 )                                          */
000700050825/*           SrcMbr( CBX943X )                                       */
000800050825/*           VldCkr( CBX943V )                                       */
000900050825/*           HlpPnlGrp( CBX943H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300050825          Cmd      Prompt( 'Print Journal Report' )
001400040311
001500050830          Parm     OBJLIB        *Name                          +
001600041201                   Min( 1 )                                     +
001700050827                   SpcVal(( *LIBL    )                          +
001800050827                          ( *CURLIB  )                          +
001900050827                          ( *USRLIBL )                          +
002000050827                          ( *ALLUSR  )                          +
002100041212                          ( *ALL     ))                         +
002200041201                   Expr( *YES )                                 +
002300050826                   Prompt( 'Object library' )
002400050825
002500050825          Parm     OBJTYP        *Char    10                    +
002600050825                   Dft( *ALL )                                  +
002700050825                   Rstd( *YES )                                 +
002800050825                   SpcVal(( *ALL    )                           +
002900050825                          ( *FILE   )                           +
003000050825                          ( *DTAQ   )                           +
003100050825                          ( *DTAARA ))                          +
003200050825                   Expr( *YES )                                 +
003300050825                   Prompt( 'Object type' )
003400050825
003500050825          Parm     RPTTYP        *Char    10                    +
003600050826                   Dft( *NOTJRN )                               +
003700050825                   Rstd( *YES )                                 +
003800050825                   SpcVal(( *JRN )                              +
003900050826                          ( *NOTJRN ))                          +
004000050825                   Expr( *YES )                                 +
004100050825                   Prompt( 'Report type' )
004200041212
004300041219          Parm     ORDER         *Char    10                    +
004400041219                   Dft( *LIBOBJ )                               +
004500041219                   Rstd( *YES )                                 +
004600041219                   SpcVal(( *LIBOBJ )                           +
004700041219                          ( *OBJ    )                           +
004800050825                          ( *JRNLIB )                           +
004900050313                          ( *CRTPRF )                           +
005000050313                          ( *TYPOBJ ))                          +
005100041219                   Expr( *YES )                                 +
005200041219                   Prompt( 'Printing order' )
005300041219
005400041212          Parm     JOBD          Q001                           +
005500041212                   Dft( *USRPRF )                               +
005600041212                   SngVal(( *USRPRF ))                          +
005700041212                   PmtCtl( *PMTRQS )                            +
005800041212                   Prompt( 'Job description' )
005900041212
006000041212          Parm     OUTQ          Q001                           +
006100041212                   Dft( *CURRENT )                              +
006200041212                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
006300041212                   PmtCtl( *PMTRQS )                            +
006400041212                   Prompt( 'Output queue' )
006500041212
006600041212
006700041212 Q001:    Qual                   *Name    10                    +
006800041212                   Expr( *Yes )
006900041212
007000041212          Qual                   *Name    10                    +
007100041212                   Dft( *LIBL )                                 +
007200041212                   SpcVal(( *LIBL ) ( *CURLIB ))                +
007300041212                   Expr( *Yes )                                 +
007400041212                   Prompt( 'Library' )
007500041212
