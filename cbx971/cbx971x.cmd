/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( WRKOUTQAUT )                                       */
/*           Pgm( CBX971 )                                           */
/*           SrcMbr( CBX971X )                                       */
/*           VldCkr( CBX971V )                                       */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX971H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Work with Output Queue Auth' )      +
                   MaxPos( 3 )                                  +
                   AlwLmtUsr( *NO )                             +
                   VldCkr( CBX971V )                            +
                   HlpId( *CMD )                                +
                   HlpPnlGrp( CBX971H )                         +
                   Text( 'Work with Output Queue Auth' )

          Parm     OUTQ        Q0001                            +
                   Min( 1 )                                     +
                   Prompt( 'Output queue' )

          Parm     USRPRF      *Generic   10                    +
                   Dft( *ALL )                                  +
                   Expr( *YES )                                 +
                   SpcVal(( *ALL ))                             +
                   Prompt( 'User profile' )

          Parm     OUTPUT      *Char       3                    +
                   Rstd( *YES )                                 +
                   Dft( * )                                     +
                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
                   Prompt( 'Output' )


 Q0001:   Qual                 *Name                            +
                   Expr( *YES )

          Qual                 *Name                            +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *YES )                                 +
                   Prompt( 'Library' )

