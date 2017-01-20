/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHKSPCAUT )                                        */
/*           Pgm( CBX9282 )                                          */
/*           SrcMbr( CBX9282X )                                      */
/*           HlpPnlGrp( CBX9282H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Check User Special Authorities' )

          Parm     USRPRF        *Name                          +
                   Min( 1 )                                     +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )

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

