000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500170117/*    CrtCmd Cmd( DSPUSRJOB )                                        */
000600111128/*           Pgm( CBX865 )                                           */
000700170117/*           SrcMbr( CBX965X )                                       */
000800060603/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
000900170117/*           VldCkr( CBX965V )                                       */
001000170117/*           MsgF( CBX965M )                                         */
001100170117/*           HlpPnlGrp( CBX965H )                                    */
001200031113/*           HlpId( *CMD )                                           */
001300031113/*                                                                   */
001400031113/*-------------------------------------------------------------------*/
001500170117             Cmd        Prompt( 'Display User Job' )
001600930930
001700111128             Parm       JOB         *Generic     10                  +
001800111128                        Dft( *ALL )                                  +
001900111128                        SpcVal(( *ALL ))                             +
002000111128                        Prompt( 'Job name' )
002100060508
002200060508             Parm       STATUS      *Char        10                  +
002300060508                        Rstd(*YES)                                   +
002400060520                        Dft( *ACTIVE )                               +
002500060516                        SpcVal(( *ACTIVE ) ( *JOBQ ) ( *OUTQ )       +
002600060516                               ( *ALL ) ( *NONOUTQ ))                +
002700060508                        Prompt( 'Job status')
002800060508
002900060508             Parm       JOBTYPE     *Char         1                  +
003000060508                        Rstd( *YES )                                 +
003100060508                        Dft( *ALL )                                  +
003200060509                        SpcVal(( *ALL    '*' )                       +
003300060509                               ( *AUTO   'A' )                       +
003400060509                               ( *BATCH  'B' )                       +
003500060509                               ( *INTER  'I' )                       +
003600060509                               ( *SBSMON 'M' )                       +
003700060509                               ( *SPLRDR 'R' )                       +
003800060509                               ( *SPLWTR 'W' )                       +
003900060509                               ( *SYS    'S' )                       +
004000060509                               ( *SCPF   'X' ))                      +
004100060508                        Prompt( 'Job type' )
004200060508
004300060508             Parm       CURUSR      *Char        10                  +
004400111128                        Dft( *ALL )                                  +
004500111128                        SpcVal(( *ALL  ' ' ))                        +
004600060508                        Prompt( 'Current user' )
004700060508
004800060508             Parm       COMPSTS     *Char        10                  +
004900060508                        Rstd( *YES )                                 +
005000060508                        Dft( *ALL )                                  +
005100060508                        SpcVal(( *ALL ) ( *NORMAL ) ( *ABNORMAL ))   +
005200111128                        PmtCtl( P0001 )                              +
005300060508                        Prompt( 'Completion status' )
005400060508
005500060508
005600111128P0001:       PmtCtl     Ctl( STATUS )                                +
005700060508                        Cond(( *EQ '*OUTQ' ))
005800060508
005900060508
006000111128             Dep        Ctl( CURUSR )                                +
006100060508                        Parm(( &STATUS *EQ '*ACTIVE' ))              +
006200060515                        NbrTrue( *EQ 1 )                             +
006300060515                        MsgId( CBX0102 )
006400111128
006500060508             Dep        Ctl( &STATUS *NE '*OUTQ' )                   +
006600060508                        Parm(( COMPSTS ))                            +
006700060515                        NbrTrue( *EQ 0 )                             +
006800060515                        MsgId( CBX0111 )
006900060508
