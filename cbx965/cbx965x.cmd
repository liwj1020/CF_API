/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPUSRJOB )                                        */
/*           Pgm( CBX865 )                                           */
/*           SrcMbr( CBX965X )                                       */
/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
/*           VldCkr( CBX965V )                                       */
/*           MsgF( CBX965M )                                         */
/*           HlpPnlGrp( CBX965H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Display User Job' )

             Parm       JOB         *Generic     10                  +
                        Dft( *ALL )                                  +
                        SpcVal(( *ALL ))                             +
                        Prompt( 'Job name' )

             Parm       STATUS      *Char        10                  +
                        Rstd(*YES)                                   +
                        Dft( *ACTIVE )                               +
                        SpcVal(( *ACTIVE ) ( *JOBQ ) ( *OUTQ )       +
                               ( *ALL ) ( *NONOUTQ ))                +
                        Prompt( 'Job status')

             Parm       JOBTYPE     *Char         1                  +
                        Rstd( *YES )                                 +
                        Dft( *ALL )                                  +
                        SpcVal(( *ALL    '*' )                       +
                               ( *AUTO   'A' )                       +
                               ( *BATCH  'B' )                       +
                               ( *INTER  'I' )                       +
                               ( *SBSMON 'M' )                       +
                               ( *SPLRDR 'R' )                       +
                               ( *SPLWTR 'W' )                       +
                               ( *SYS    'S' )                       +
                               ( *SCPF   'X' ))                      +
                        Prompt( 'Job type' )

             Parm       CURUSR      *Char        10                  +
                        Dft( *ALL )                                  +
                        SpcVal(( *ALL  ' ' ))                        +
                        Prompt( 'Current user' )

             Parm       COMPSTS     *Char        10                  +
                        Rstd( *YES )                                 +
                        Dft( *ALL )                                  +
                        SpcVal(( *ALL ) ( *NORMAL ) ( *ABNORMAL ))   +
                        PmtCtl( P0001 )                              +
                        Prompt( 'Completion status' )


P0001:       PmtCtl     Ctl( STATUS )                                +
                        Cond(( *EQ '*OUTQ' ))


             Dep        Ctl( CURUSR )                                +
                        Parm(( &STATUS *EQ '*ACTIVE' ))              +
                        NbrTrue( *EQ 1 )                             +
                        MsgId( CBX0102 )

             Dep        Ctl( &STATUS *NE '*OUTQ' )                   +
                        Parm(( COMPSTS ))                            +
                        NbrTrue( *EQ 0 )                             +
                        MsgId( CBX0111 )

