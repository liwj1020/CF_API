000100031113/*-------------------------------------------------------------------*/
000200031113/*                                                                   */
000300031113/*  Compile options:                                                 */
000400031113/*                                                                   */
000500070423/*    CrtCmd Cmd( WRKJOB2 )                                          */
000600070423/*           Pgm( CBX969 )                                           */
000700070423/*           SrcMbr( CBX969X )                                       */
000800060603/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
000900070423/*           VldCkr( CBX969V )                                       */
001000070423/*           MsgF( CBX969M )                                         */
001100070423/*           HlpPnlGrp( CBX969H )                                    */
001200031113/*           HlpId( *CMD )                                           */
001300031113/*                                                                   */
001400031113/*-------------------------------------------------------------------*/
001500070423             Cmd        Prompt( 'Work with Job 2' )
001600930930
001700060508             Parm       JOB         *Generic     10                  +
001800060508                        Dft( *ALL )                                  +
001900060508                        SpcVal(( *ALL ) ( *CURRENT ))                +
002000060508                        Prompt('Job name')
002100060508
002200060508             Parm       USER        *Generic     10                  +
002300070423                        Dft( *CURRENT )                              +
002400060508                        SpcVal(( *ALL ) ( *CURRENT ) ( *CURUSR ))    +
002500060508                        Prompt( 'User name' )
002600060508
002700060508             Parm       STATUS      *Char        10                  +
002800060508                        Rstd(*YES)                                   +
002900070423                        Dft( *ALL )                                  +
003000060516                        SpcVal(( *ACTIVE ) ( *JOBQ ) ( *OUTQ )       +
003100060516                               ( *ALL ) ( *NONOUTQ ))                +
003200060508                        Prompt( 'Job status')
003300060508
003400060508             Parm       JOBTYPE     *Char         1                  +
003500060508                        Rstd( *YES )                                 +
003600060508                        Dft( *ALL )                                  +
003700060509                        SpcVal(( *ALL    '*' )                       +
003800060509                               ( *AUTO   'A' )                       +
003900060509                               ( *BATCH  'B' )                       +
004000060509                               ( *INTER  'I' )                       +
004100060509                               ( *SBSMON 'M' )                       +
004200060509                               ( *SPLRDR 'R' )                       +
004300060509                               ( *SPLWTR 'W' )                       +
004400060509                               ( *SYS    'S' )                       +
004500060509                               ( *SCPF   'X' ))                      +
004600060508                        Prompt( 'Job type' )
004700060508
004800070423             Parm       CURUSR      *Sname       10                  +
004900060512                        Dft( *NOCHK )                                +
005000060512                        SpcVal(( *NOCHK  ' ' ))                      +
005100060508                        PmtCtl( P0001 )                              +
005200060508                        Prompt( 'Current user' )
005300060508
005400060508             Parm       COMPSTS     *Char        10                  +
005500060508                        Rstd( *YES )                                 +
005600060508                        Dft( *ALL )                                  +
005700060508                        SpcVal(( *ALL ) ( *NORMAL ) ( *ABNORMAL ))   +
005800070411                        PmtCtl( P0002 )                              +
005900060508                        Prompt( 'Completion status' )
006000060508
006100070411             Parm       PERIOD      E0001                            +
006200070411                        Choice( *NONE )                              +
006300070411                        PmtCtl( *PMTRQS )                            +
006400070411                        Prompt( 'Time period for job selection' )
006500070411
006600070411
006700070306E0001:       Elem                   E0011                            +
006800070306                        Choice( *NONE )                              +
006900070306                        Prompt( 'Start time and date' )
007000070306
007100070306             Elem                   E0012                            +
007200070306                        Choice( *NONE )                              +
007300070306                        Prompt( 'End time and date' )
007400070306
007500070306E0011:       Elem                   *Time                            +
007600070306                        Dft( *AVAIL )                                +
007700070306                        SpcVal(( *AVAIL 000000 ))                    +
007800070306                        Expr( *YES )                                 +
007900070306                        Prompt( 'Beginning time' )
008000070306
008100070306             Elem                   *Date                            +
008200070423                        Dft( *CURRENT )                              +
008300070306                        SpcVal(( *CURRENT 000001 )                   +
008400070306                               ( *BEGIN   000002 ))                  +
008500070306                        Expr( *YES )                                 +
008600070306                        Prompt( 'Beginning date' )
008700070306
008800070306E0012:       Elem                   *Time                            +
008900070306                        Dft( *AVAIL )                                +
009000070306                        SpcVal(( *AVAIL 235959 ))                    +
009100070306                        Expr( *YES )                                 +
009200070306                        Prompt( 'Ending time' )
009300070306
009400070306             Elem                   *Date                            +
009500070423                        Dft( *CURRENT )                              +
009600070306                        SpcVal(( *CURRENT 000001 )                   +
009700070306                               ( *END     000003 ))                  +
009800070306                        Expr( *YES )                                 +
009900070306                        Prompt( 'Ending date' )
010000070306
010100070306
010200060508P0001:       PmtCtl     Ctl( USER )                                  +
010300060508                        Cond(( *EQ '*CURUSR' ))
010400060508
010500060508P0002:       PmtCtl     Ctl( STATUS )                                +
010600060508                        Cond(( *EQ '*OUTQ' ))
010700060508
010800060508
010900060508             Dep        Ctl( &USER *NE '*CURUSR' )                   +
011000060508                        Parm(( CURUSR ))                             +
011100060515                        NbrTrue( *EQ 0 )                             +
011200060515                        MsgId( CBX0101 )
011300060508
011400060508             Dep        Ctl( &USER *EQ '*CURUSR' )                   +
011500060508                        Parm(( &STATUS *EQ '*ACTIVE' ))              +
011600060515                        NbrTrue( *EQ 1 )                             +
011700060515                        MsgId( CBX0102 )
011800060508
011900060512             Dep        Ctl( &USER *EQ '*CURUSR' )                   +
012000060512                        Parm(( &CURUSR *EQ ' ' ))                    +
012100060515                        NbrTrue( *EQ 0 )                             +
012200060515                        MsgId( CBX0103 )
012300060512
012400060508             Dep        Ctl( &STATUS *NE '*OUTQ' )                   +
012500060508                        Parm(( COMPSTS ))                            +
012600060515                        NbrTrue( *EQ 0 )                             +
012700060515                        MsgId( CBX0111 )
012800060508
012900060515             Dep        Ctl( &JOB *EQ '*ALL' )                       +
013000060515                        Parm(( &USER *EQ '*ALL' )                    +
013100060515                             ( &STATUS *EQ '*ALL' ))                 +
013200060515                        NbrTrue( *LE 1 )                             +
013300060520                        MsgId( CBX0121 )
013400060515
013500060515             Dep        Ctl( &JOB *EQ '*ALL' )                       +
013600060515                        Parm(( &USER *EQ '*ALL' )                    +
013700060515                             ( &STATUS *EQ '*OUTQ' ))                +
013800060515                        NbrTrue( *LE 1 )                             +
013900060515                        MsgId( CBX0122 )
014000060508
