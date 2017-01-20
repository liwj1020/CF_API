/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVSPCAUT )                                        */
/*           Pgm( CBX9281 )                                          */
/*           SrcMbr( CBX9281X )                                      */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX9281H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve Special Authorities' )

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

          Parm     AUTIND      *Char       1                    +
                   Min( 1 )                                     +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for AUTIND        (1)' )

