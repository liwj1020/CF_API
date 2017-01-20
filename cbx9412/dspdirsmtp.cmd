/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPDIRSMTP )                                       */
/*           Pgm( CBX9412 )                                          */
/*           SrcMbr( CBX9412X )                                      */
/*           HlpPnlGrp( CBX9412H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Display Dir Entry SMTP Addr' )

          Parm     USRID       E0001                            +
                   Dft( *USRPRF )                               +
                   SngVal(( *USRPRF ))                          +
                   Prompt( 'User identifier' )

          Parm     USER        *Name      10                    +
                   Dft( *CURRENT )                              +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )


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

