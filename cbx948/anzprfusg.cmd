/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ANZPRFUSG )                                        */
/*           Pgm( CBX948 )                                           */
/*           SrcMbr( CBX948X )                                       */
/*           HlpPnlGrp( CBX948H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Analyze User Profile Usage' )

          Parm     INACTDAYS     *Dec      ( 3  0 )             +
                   Range( 1  366 )                              +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'Number of inactive days' )

          Parm     INACTCHECK    *Char      10                  +
                   Dft( *LASTUSED )                             +
                   Rstd( *YES )                                 +
                   SpcVal(( *LASTUSED  )                        +
                          ( *PRVSIGNON ))                       +
                   Expr( *YES )                                 +
                   Prompt( 'Inactive check attribute' )

          Parm     ACTION        *Char      10                  +
                   Dft( *NONE )                                 +
                   Rstd( *YES )                                 +
                   SpcVal(( *NONE    )                          +
                          ( *DISABLE ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User profile action' )

          Parm     USRCLS        *Generic   10                  +
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

          Parm     EXCLUDE       *Generic   10                  +
                   Dft( *NONE )                                 +
                   Max( 30 )                                    +
                   SngVal(( *NONE ))                            +
                   Expr( *YES )                                 +
                   Prompt( 'Exclude user profiles' )

          Parm     STATUS        *Char      10                  +
                   Dft( *ANY )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *ANY      )                         +
                          ( *ENABLED  )                         +
                          ( *DISABLED ))                        +
                   Expr( *YES )                                 +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'User profile status' )

          Parm     SYSPRF        *Char       4                  +
                   Dft( *NO )                                   +
                   Rstd( *YES )                                 +
                   SpcVal(( *NO  )                              +
                          ( *YES ))                             +
                   Expr( *YES )                                 +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Include system profiles' )

