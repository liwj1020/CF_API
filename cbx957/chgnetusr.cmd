/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHGNETUSR )                                        */
/*           Pgm( CBX957 )                                           */
/*           VldCkr( CBX957V )                                       */
/*           SrcMbr( CBX957X )                                       */
/*           HlpPnlGrp( CBX957H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Change NetServer User' )

          Parm     USRPRF      *Sname     10                    +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Vary( *YES )                                 +
                   Prompt( 'User profile' )

          Parm     STATUS      *Char       1                    +
                   Dft( *SAME )                                 +
                   Rstd( *YES )                                 +
                   SpcVal(( *SAME 'S' ) ( *ENABLED 'E' ))       +
                   Expr( *YES )                                 +
                   Prompt( 'New status' )

