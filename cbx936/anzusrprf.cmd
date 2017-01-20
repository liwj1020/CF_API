/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ANZUSRPRF )                                        */
/*           Pgm( CBX936 )                                           */
/*           SrcMbr( CBX936X )                                       */
/*           HlpPnlGrp( CBX936H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Analyze User Profiles' )

          Parm     SELECT        *Char    10                    +
                   Min( 1 )                                     +
                   Rstd( *YES )                                 +
                   SpcVal(( *DISABLED  )                        +
                          ( *EXPIRED   )                        +
                          ( *INVSIGNON )                        +
                          ( *NOGROUP   )                        +
                          ( *NOPWD     )                        +
                          ( *NOTLMTCAP ))                       +
                   Expr( *YES )                                 +
                   Prompt( 'Select' )

          Parm     SYSPRF        *Char     4                    +
                   Dft( *YES )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *YES )                              +
                          ( *NO  ))                             +
                   Expr( *YES )                                 +
                   Prompt( 'Include system profiles' )

