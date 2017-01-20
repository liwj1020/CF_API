/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ADDGRPPRF )                                        */
/*           Pgm( CBX953 )                                           */
/*           SrcMbr( CBX953X )                                       */
/*           VldCkr( CBX953V )                                       */
/*           HlpPnlGrp( CBX953H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Add Group Profile' )

          Parm     USRPRF      *Generic   10                    +
                   Min( 1 )                                     +
                   SpcVal(( *FILE ) ( *ALL ))                   +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )

          Parm     NEWGRPPRF   *Sname     10                    +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'Group profile to add' )

          Parm     GRPOWNER    *Char      10                    +
                   Dft( *SAME )                                 +
                   Rstd( *YES )                                 +
                   SpcVal(( *SAME )                             +
                          ( *YES  )                             +
                          ( *NO   ))                            +
                   Expr( *YES )                                 +
                   Prompt( 'Group ownership' )

          Parm     USRCLS      *Generic   10                    +
                   Dft( *ALL )                                  +
                   Max( 5 )                                     +
                   Rstd( *YES )                                 +
                   SpcVal(( *USER    )                          +
                          ( *PGMR    )                          +
                          ( *SYSOPR  )                          +
                          ( *SECADM  )                          +
                          ( *SECOFR  ))                         +
                   SngVal(( *ALL     )                          +
                          ( *NONUSER ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User classes to select' )

          Parm     GRPPRF      *Sname     10                    +
                   Dft( *ANY )                                  +
                   SpcVal(( *ANY  )                             +
                          ( *NONE ))                            +
                   Expr( *YES )                                 +
                   Prompt( 'Group profile to select' )

          Parm     REPLACE     *Char       4                    +
                   Dft( *NO )                                   +
                   Rstd( *YES )                                 +
                   SpcVal(( *YES )                              +
                          ( *NO  ))                             +
                   Expr( *YES )                                 +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Replace primary group' )

          Parm     OPTION      *Char       7                    +
                   Rstd( *YES )                                 +
                   Dft( *UPDATE )                               +
                   SpcVal(( *UPDATE )                           +
                          ( *VERIFY ))                          +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'User profile option' )

          Parm     FILE        Q0001                            +
                   File( *UNSPFD )                              +
                   PmtCtl( P0001 )                              +
                   Prompt( 'File' )


 Q0001:   Qual                 *Name      10                    +
                   Expr( *Yes )

          Qual                 *Name      10                    +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ))                            +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )


 P0001:   PmtCtl   Ctl( USRPRF )                                +
                   Cond(( *EQ '*FILE' ))


          Dep      Ctl( &USRPRF *EQ '*FILE' )                   +
                   Parm(( FILE ))                               +
                   NbrTrue( *EQ 1 )

          Dep      Ctl( &USRPRF *NE '*FILE' )                   +
                   Parm(( FILE ))                               +
                   NbrTrue( *EQ 0 )

