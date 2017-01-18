000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500041212/*    CrtCmd Cmd( PRTPGMADPS )                                       */
000600050211/*           Pgm( CBX9301 )                                          */
000700050210/*           SrcMbr( CBX930X )                                       */
000800050210/*           VldCkr( CBX930V )                                       */
000900050210/*           HlpPnlGrp( CBX930H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300041212          Cmd      Prompt( 'Print pgms adopting spec auth' )
001400040311
001500041212          Parm     PGMLIB        *Name                          +
001600041201                   Min( 1 )                                     +
001700041212                   SpcVal(( *USRLIBL )                          +
001800041212                          ( *ALLUSR  )                          +
001900041212                          ( *ALL     ))                         +
002000041201                   Expr( *YES )                                 +
002100041212                   Prompt( 'Program library' )
002200041201
002300041201          Parm     SPCAUT        *Char    10                    +
002400041201                   Min( 1 )                                     +
002500041201                   Max( 8 )                                     +
002600041201                   Rstd( *YES )                                 +
002700041201                   SpcVal(( *ALLOBJ )                           +
002800041201                          ( *AUDIT )                            +
002900041201                          ( *IOSYSCFG )                         +
003000041201                          ( *JOBCTL )                           +
003100041201                          ( *SAVSYS )                           +
003200041201                          ( *SECADM )                           +
003300041201                          ( *SERVICE )                          +
003400041201                          ( *SPLCTL ))                          +
003500041201                   Expr( *YES )                                 +
003600041201                   Prompt( 'Special authority' )
003700041212
003800041219          Parm     ORDER         *Char    10                    +
003900041219                   Dft( *LIBOBJ )                               +
004000041219                   Rstd( *YES )                                 +
004100041219                   SpcVal(( *LIBOBJ )                           +
004200041219                          ( *OBJ    )                           +
004300041219                          ( *ADPPRF )                           +
004400050313                          ( *CRTPRF )                           +
004500050313                          ( *TYPOBJ ))                          +
004600041219                   Expr( *YES )                                 +
004700041219                   Prompt( 'Printing order' )
004800041219
004900050306          Parm     SYSOBJ        *Char     4                    +
005000050306                   Dft( *YES )                                  +
005100050306                   Rstd( *YES )                                 +
005200050306                   SpcVal(( *YES )                              +
005300050306                          ( *NO  ))                             +
005400050306                   Expr( *YES )                                 +
005500050306                   Prompt( 'Include system objects' )
005600050306
005700041212          Parm     JOBD          Q001                           +
005800041212                   Dft( *USRPRF )                               +
005900041212                   SngVal(( *USRPRF ))                          +
006000041212                   PmtCtl( *PMTRQS )                            +
006100041212                   Prompt( 'Job description' )
006200041212
006300041212          Parm     OUTQ          Q001                           +
006400041212                   Dft( *CURRENT )                              +
006500041212                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
006600041212                   PmtCtl( *PMTRQS )                            +
006700041212                   Prompt( 'Output queue' )
006800041212
006900041212
007000041212 Q001:    Qual                   *Name    10                    +
007100041212                   Expr( *Yes )
007200041212
007300041212          Qual                   *Name    10                    +
007400041212                   Dft( *LIBL )                                 +
007500041212                   SpcVal(( *LIBL ) ( *CURLIB ))                +
007600041212                   Expr( *Yes )                                 +
007700041212                   Prompt( 'Library' )
007800041212
