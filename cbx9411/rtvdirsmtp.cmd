/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVDIRSMTP )                                       */
/*           Pgm( CBX9411 )                                          */
/*           SrcMbr( CBX9411X )                                      */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX9411H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve Dir Entry SMTP Addr' )

          Parm     USRID       E0001                            +
                   Dft( *USRPRF )                               +
                   SngVal(( *USRPRF ))                          +
                   Prompt( 'User identifier' )

          Parm     USER        *Name      10                    +
                   Dft( *CURRENT )                              +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )

          Parm     SMTPADDR    *Char      63                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for SMTPADDR     (63)' )


E0001:    Elem                 *Char       8                    +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'User ID' )

          Elem                 *Char       8                    +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'Address' )

          Dep      Ctl( USER )                                  +
                   Parm(( USRID ))                              +
                   NbrTrue( *EQ 0 )                             +
                   MsgId( CPD9105 )

