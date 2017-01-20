/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RMVARPTBLE )                                       */
/*           Pgm( CBX919 )                                           */
/*           SrcMbr( CBX919X )                                       */
/*           VldCkr( CBX919V )                                       */
/*           HlpPnlGrp( CBX919H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
      Cmd        Prompt( 'Remove ARP table entry' )

      Parm       LIND          *Name                          +
                 Min( 1 )                                     +
                 Prompt( 'Line name' )

      Parm       INTNETADR     *Char                          +
                 Len( 15 )                                    +
                 Dft( *NONE )                                 +
                 SpcVal(( *NONE 0 ))                          +
                 Prompt( 'Internet address' )

      Parm       ENTTYP        *Char                          +
                 Dft( *IPADDR )                               +
                 Rstd( *YES )                                 +
                 SpcVal(( *IPADDR )                           +
                        ( *ALL    ))                          +
                 Expr( *YES )                                 +
                 Prompt( 'Entry type' )

      Dep        Ctl( &ENTTYP *EQ '*IPADDR' )                 +
                 Parm(( &INTNETADR *NE 0 ))                   +
                 NbrTrue( *EQ 1 )                             +
                 MsgId( CPDB11B )

