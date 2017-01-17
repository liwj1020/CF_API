000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500060520/*    CrtCmd Cmd( RMVGRPPRF )                                        */
000600060520/*           Pgm( CBX954 )                                           */
000700060520/*           SrcMbr( CBX954X )                                       */
000800060520/*           VldCkr( CBX954V )                                       */
000900060520/*           HlpPnlGrp( CBX954H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300060520          Cmd      Prompt( 'Remove Group Profile' )
001400040311
001500060314          Parm     USRPRF      *Generic   10                    +
001600060314                   Min( 1 )                                     +
001700060321                   SpcVal(( *FILE ) ( *ALL ))                   +
001800041201                   Expr( *YES )                                 +
001900060314                   Prompt( 'User profile' )
002000050319
002100060520          Parm     RMVGRPPRF   *Sname     10                    +
002200060314                   Min( 1 )                                     +
002300060314                   Expr( *YES )                                 +
002400060520                   Prompt( 'Group profile to remove' )
002500060320
002600060322          Parm     GRPOWNER    *Char      10                    +
002700060322                   Dft( *SAME )                                 +
002800060322                   Rstd( *YES )                                 +
002900060322                   SpcVal(( *SAME )                             +
003000060322                          ( *YES  )                             +
003100060322                          ( *NO   ))                            +
003200060322                   Expr( *YES )                                 +
003300060322                   Prompt( 'Group ownership' )
003400060322
003500060320          Parm     USRCLS      *Generic   10                    +
003600060320                   Dft( *ALL )                                  +
003700060320                   Max( 5 )                                     +
003800060320                   Rstd( *YES )                                 +
003900060320                   SpcVal(( *USER    )                          +
004000060320                          ( *PGMR    )                          +
004100060320                          ( *SYSOPR  )                          +
004200060320                          ( *SECADM  )                          +
004300060320                          ( *SECOFR  ))                         +
004400060320                   SngVal(( *ALL     )                          +
004500060320                          ( *NONUSER ))                         +
004600060320                   Expr( *YES )                                 +
004700060320                   Prompt( 'User classes to select' )
004800060320
004900060520          Parm     PROMOTE     *Sname     10                    +
005000060320                   Dft( *ANY )                                  +
005100060520                   SpcVal(( *ANY  ))                            +
005200060320                   Expr( *YES )                                 +
005300060520                   Prompt( 'Promote to primary group' )
005400060321
005500060323          Parm     OPTION      *Char       7                    +
005600060323                   Rstd( *YES )                                 +
005700060323                   Dft( *UPDATE )                               +
005800060323                   SpcVal(( *UPDATE )                           +
005900060323                          ( *VERIFY ))                          +
006000060323                   PmtCtl( *PMTRQS )                            +
006100060323                   Prompt( 'User profile option' )
006200050415
006300060314          Parm     FILE        Q0001                            +
006400060315                   File( *UNSPFD )                              +
006500060314                   PmtCtl( P0001 )                              +
006600060315                   Prompt( 'File' )
006700041212
006800050319
006900060216 Q0001:   Qual                 *Name      10                    +
007000060216                   Expr( *Yes )
007100060216
007200060216          Qual                 *Name      10                    +
007300060216                   Dft( *LIBL )                                 +
007400060314                   SpcVal(( *LIBL ))                            +
007500060216                   Expr( *Yes )                                 +
007600060216                   Prompt( 'Library' )
007700060216
007800060216
007900060324 P0001:   PmtCtl   Ctl( USRPRF )                                +
008000060324                   Cond(( *EQ '*FILE' ))
008100060314
008200060314
008300060324          Dep      Ctl( &USRPRF *EQ '*FILE' )                   +
008400060324                   Parm(( FILE ))                               +
008500060324                   NbrTrue( *EQ 1 )
008600050415
008700060324          Dep      Ctl( &USRPRF *NE '*FILE' )                   +
008800060324                   Parm(( FILE ))                               +
008900060324                   NbrTrue( *EQ 0 )
009000060315
