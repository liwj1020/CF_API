/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( WRKSVRSHR )                                        */
/*           Pgm( CBX964 )                                           */
/*           VldCkr( CBX964V )                                       */
/*           SrcMbr( CBX964X )                                       */
/*           HlpPnlGrp( CBX964H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Work with Server Shares' )

          Parm     SHARE       *Generic   12                    +
                   Dft( *ALL )                                  +
                   Expr( *YES )                                 +
                   SpcVal(( *ALL ))                             +
                   Prompt( 'Share' )

          Parm     TYPE        *Int4                            +
                   Dft( *ALL )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *ALL -1 ) ( *FILE 0 ) ( *PRINT 1 )) +
                   Expr( *YES )                                 +
                   Prompt( 'Type' )

          Parm     OUTPUT      *Char       3                    +
                   Rstd( *YES )                                 +
                   Dft( * )                                     +
                   SpcVal(( * 'DSP' ) ( *PRINT 'PRT' ))         +
                   Prompt( 'Output' )

