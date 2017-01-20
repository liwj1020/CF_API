/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( WRKNETUSR )                                        */
/*           Pgm( CBX958 )                                           */
/*           VldCkr( CBX958V )                                       */
/*           SrcMbr( CBX958X )                                       */
/*           HlpPnlGrp( CBX958H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Work with NetServer Users' )

          Parm     USRPRF      *Generic   10                    +
                   Dft( *ALL )                                  +
                   Expr( *YES )                                 +
                   SpcVal(( *ALL ))                             +
                   Prompt( 'User profile' )

          Parm     STATUS      *Char      10                    +
                   Dft( *DISABLED )                             +
                   Rstd( *YES )                                 +
                   SpcVal(( *DISABLED ))                        +
                   Expr( *YES )                                 +
                   Prompt( 'Status' )

          Parm     OUTPUT      *Char       3                    +
                   Rstd( *YES )                                 +
                   Dft( * )                                     +
                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
                   Prompt( 'Output' )

