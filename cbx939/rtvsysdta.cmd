/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVSYSDTA )                                        */
/*           Pgm( CBX939 )                                           */
/*           SrcMbr( CBX939X )                                       */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX939H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve System Data')

          Parm     RESET         *Char    10                    +
                   Dft( *NO )                                   +
                   Rstd( *YES )                                 +
                   SpcVal(( *NO  )                              +
                          ( *YES ))                             +
                   Expr( *YES )                                 +
                   Prompt( 'Reset statistics' )

          Parm     PRCTYPE     *Char       4                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for PRCTYPE       (4)' )

          Parm     PRCGROUP    *Char       4                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for PRCGROUP      (4)' )

          Parm     MAINSTGSIZ  *Dec     ( 10 0 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for MAINSTGSIZ (10 0)' )

          Parm     TOTAUXSTG   *Dec     ( 10 0 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for TOTAUXSTG  (10 0)' )

          Parm     SYSASPSIZ   *Dec     ( 10 0 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for SYSASPSIZ  (10 0)' )

          Parm     SYSASPUSED  *Dec     (  7 4 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for SYSASPUSED  (7 4)' )

          Parm     SYSASPTHR   *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for SYSASPTHR   (4 1)' )

          Parm     CPUPCTUSED  *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for CPUPCTUSED  (4 1)' )

          Parm     DBCAPUSED   *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for DBCAPUSED   (4 1)' )

          Parm     PRCINTTHR   *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for PRCINTTHR   (4 1)' )

          Parm     PRCINTLMT   *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for PRCINTLMT   (4 1)' )

          Parm     DBCAPTHR    *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for DBCAPTHR    (4 1)' )

          Parm     DBCAPLMT    *Dec     (  4 1 )                +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for DBCAPLMT    (4 1)' )

          Parm     OSREL       *Char       6                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for OSREL         (6)' )

          Parm     SYSSTT      *Char       1                  +
                   RtnVal( *YES )                             +
                   Prompt( 'CL var for SYSSTT        (1)' )

          Parm     TCPSTS      *Char       1                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for TCPSTS        (1)' )

          Parm     IPLDTS      *Char      17                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for IPLDTS       (17)' )

          Parm     CURIPLTYP   *Char       1                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for CURIPLTYP     (1)' )

          Parm     PNLKEYPOS   *Char       6                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for PNLKEYPOS     (6)' )

