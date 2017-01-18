000100040408/*-------------------------------------------------------------------*/
000200040408/*                                                                   */
000300040408/*  Compile options:                                                 */
000400040408/*                                                                   */
000500051022/*    CrtCmd Cmd( ANZPRFUSG )                                        */
000600051022/*           Pgm( CBX948 )                                           */
000700051022/*           SrcMbr( CBX948X )                                       */
000800051022/*           HlpPnlGrp( CBX948H )                                    */
000900040408/*           HlpId( *CMD )                                           */
001000040408/*                                                                   */
001100040408/*-------------------------------------------------------------------*/
001200051022          Cmd      Prompt( 'Analyze User Profile Usage' )
001300050506
001400051022          Parm     INACTDAYS     *Dec      ( 3  0 )             +
001500051022                   Range( 1  366 )                              +
001600051022                   Min( 1 )                                     +
001700051022                   Expr( *YES )                                 +
001800051022                   Prompt( 'Number of inactive days' )
001900051022
002000051022          Parm     INACTCHECK    *Char      10                  +
002100051022                   Dft( *LASTUSED )                             +
002200051022                   Rstd( *YES )                                 +
002300051022                   SpcVal(( *LASTUSED  )                        +
002400051022                          ( *PRVSIGNON ))                       +
002500051022                   Expr( *YES )                                 +
002600051022                   Prompt( 'Inactive check attribute' )
002700051022
002800051029          Parm     ACTION        *Char      10                  +
002900051029                   Dft( *NONE )                                 +
003000051029                   Rstd( *YES )                                 +
003100051029                   SpcVal(( *NONE    )                          +
003200051029                          ( *DISABLE ))                         +
003300051029                   Expr( *YES )                                 +
003400051029                   Prompt( 'User profile action' )
003500051029
003600051022          Parm     USRCLS        *Generic   10                  +
003700051022                   Dft( *ALL )                                  +
003800051022                   Max( 5 )                                     +
003900051022                   Rstd( *YES )                                 +
004000051022                   SpcVal(( *USER    )                          +
004100051022                          ( *PGMR    )                          +
004200051022                          ( *SYSOPR  )                          +
004300051022                          ( *SECADM  )                          +
004400051022                          ( *SECOFR  ))                         +
004500051022                   SngVal(( *ALL     )                          +
004600051022                          ( *NONUSER ))                         +
004700051022                   Expr( *YES )                                 +
004800051022                   Prompt( 'User classes to select' )
004900051022
005000051022          Parm     EXCLUDE       *Generic   10                  +
005100051022                   Dft( *NONE )                                 +
005200051022                   Max( 30 )                                    +
005300051029                   SngVal(( *NONE ))                            +
005400051022                   Expr( *YES )                                 +
005500051022                   Prompt( 'Exclude user profiles' )
005600050306
005700051029          Parm     STATUS        *Char      10                  +
005800051029                   Dft( *ANY )                                  +
005900051029                   Rstd( *YES )                                 +
006000051029                   SpcVal(( *ANY      )                         +
006100051029                          ( *ENABLED  )                         +
006200051029                          ( *DISABLED ))                        +
006300051029                   Expr( *YES )                                 +
006400051029                   PmtCtl( *PMTRQS )                            +
006500051029                   Prompt( 'User profile status' )
006600051029
006700051029          Parm     SYSPRF        *Char       4                  +
006800051029                   Dft( *NO )                                   +
006900051029                   Rstd( *YES )                                 +
007000051029                   SpcVal(( *NO  )                              +
007100051029                          ( *YES ))                             +
007200051029                   Expr( *YES )                                 +
007300051029                   PmtCtl( *PMTRQS )                            +
007400051029                   Prompt( 'Include system profiles' )
007500051029
