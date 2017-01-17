000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500060314/*    CrtCmd Cmd( ADDGRPPRF )                                        */
000600060314/*           Pgm( CBX953 )                                           */
000700060314/*           SrcMbr( CBX953X )                                       */
000800060314/*           VldCkr( CBX953V )                                       */
000900060314/*           HlpPnlGrp( CBX953H )                                    */
001000040408/*           HlpId( *CMD )                                           */
001100040408/*                                                                   */
001200040408/*-------------------------------------------------------------------*/
001300060314          Cmd      Prompt( 'Add Group Profile' )
001400040311
001500060314          Parm     USRPRF      *Generic   10                    +
001600060314                   Min( 1 )                                     +
001700060321                   SpcVal(( *FILE ) ( *ALL ))                   +
001800041201                   Expr( *YES )                                 +
001900060314                   Prompt( 'User profile' )
002000050319
002100060320          Parm     NEWGRPPRF   *Sname     10                    +
002200060314                   Min( 1 )                                     +
002300060314                   Expr( *YES )                                 +
002400060320                   Prompt( 'Group profile to add' )
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
004900060320          Parm     GRPPRF      *Sname     10                    +
005000060320                   Dft( *ANY )                                  +
005100060320                   SpcVal(( *ANY  )                             +
005200060320                          ( *NONE ))                            +
005300060320                   Expr( *YES )                                 +
005400060320                   Prompt( 'Group profile to select' )
005500060321
005600060323          Parm     REPLACE     *Char       4                    +
005700060321                   Dft( *NO )                                   +
005800060321                   Rstd( *YES )                                 +
005900060323                   SpcVal(( *YES )                              +
006000060323                          ( *NO  ))                             +
006100060321                   Expr( *YES )                                 +
006200060321                   PmtCtl( *PMTRQS )                            +
006300060321                   Prompt( 'Replace primary group' )
006400060323
006500060323          Parm     OPTION      *Char       7                    +
006600060323                   Rstd( *YES )                                 +
006700060323                   Dft( *UPDATE )                               +
006800060323                   SpcVal(( *UPDATE )                           +
006900060323                          ( *VERIFY ))                          +
007000060323                   PmtCtl( *PMTRQS )                            +
007100060323                   Prompt( 'User profile option' )
007200050415
007300060314          Parm     FILE        Q0001                            +
007400060315                   File( *UNSPFD )                              +
007500060314                   PmtCtl( P0001 )                              +
007600060315                   Prompt( 'File' )
007700041212
007800050319
007900060216 Q0001:   Qual                 *Name      10                    +
008000060216                   Expr( *Yes )
008100060216
008200060216          Qual                 *Name      10                    +
008300060216                   Dft( *LIBL )                                 +
008400060314                   SpcVal(( *LIBL ))                            +
008500060216                   Expr( *Yes )                                 +
008600060216                   Prompt( 'Library' )
008700060216
008800060216
008900060324 P0001:   PmtCtl   Ctl( USRPRF )                                +
009000060324                   Cond(( *EQ '*FILE' ))
009100060314
009200060314
009300060324          Dep      Ctl( &USRPRF *EQ '*FILE' )                   +
009400060324                   Parm(( FILE ))                               +
009500060324                   NbrTrue( *EQ 1 )
009600050415
009700060324          Dep      Ctl( &USRPRF *NE '*FILE' )                   +
009800060324                   Parm(( FILE ))                               +
009900060324                   NbrTrue( *EQ 0 )
010000060315
