/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTPGMADPS )                                       */
/*           Pgm( CBX9301 )                                          */
/*           SrcMbr( CBX930X )                                       */
/*           VldCkr( CBX930V )                                       */
/*           HlpPnlGrp( CBX930H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print pgms adopting spec auth' )

          Parm     PGMLIB        *Name                          +
                   Min( 1 )                                     +
                   SpcVal(( *USRLIBL )                          +
                          ( *ALLUSR  )                          +
                          ( *ALL     ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Program library' )

          Parm     SPCAUT        *Char    10                    +
                   Min( 1 )                                     +
                   Max( 8 )                                     +
                   Rstd( *YES )                                 +
                   SpcVal(( *ALLOBJ )                           +
                          ( *AUDIT )                            +
                          ( *IOSYSCFG )                         +
                          ( *JOBCTL )                           +
                          ( *SAVSYS )                           +
                          ( *SECADM )                           +
                          ( *SERVICE )                          +
                          ( *SPLCTL ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Special authority' )

          Parm     ORDER         *Char    10                    +
                   Dft( *LIBOBJ )                               +
                   Rstd( *YES )                                 +
                   SpcVal(( *LIBOBJ )                           +
                          ( *OBJ    )                           +
                          ( *ADPPRF )                           +
                          ( *CRTPRF )                           +
                          ( *TYPOBJ ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Printing order' )

          Parm     SYSOBJ        *Char     4                    +
                   Dft( *YES )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *YES )                              +
                          ( *NO  ))                             +
                   Expr( *YES )                                 +
                   Prompt( 'Include system objects' )

          Parm     JOBD          Q001                           +
                   Dft( *USRPRF )                               +
                   SngVal(( *USRPRF ))                          +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Job description' )

          Parm     OUTQ          Q001                           +
                   Dft( *CURRENT )                              +
                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Output queue' )


 Q001:    Qual                   *Name    10                    +
                   Expr( *Yes )

          Qual                   *Name    10                    +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )

