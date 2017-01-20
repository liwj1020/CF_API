/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPJOBQJOB )                                       */
/*           Pgm( CBX968 )                                           */
/*           SrcMbr( CBX968X )                                       */
/*           VldCkr( CBX968V )                                       */
/*           Allow( *INTERACT *IPGM *IREXX *IMOD )                   */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX968H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Display Job Queue Jobs' )

             Parm       JOBQ        Q0001                            +
                        Min( 1 )                                     +
                        Prompt( 'Job queue' )


 Q0001:      Qual                   *Name                            +
                        Expr( *YES )

             Qual                   *Name                            +
                        Dft( *LIBL )                                 +
                        SpcVal(( *LIBL ) ( *CURLIB ))                +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )

