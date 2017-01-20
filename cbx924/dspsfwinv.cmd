/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPSFWINV )                                        */
/*           Pgm( CBX924 )                                           */
/*           SrcMbr( CBX924X )                                       */
/*           HlpPnlGrp( CBX924H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
        Cmd      Prompt( 'Display Software Inventory' )


        Parm     OUTPUT     *Char      1              +
                 Dft( * )                             +
                 Rstd( *YES )                         +
                 SpcVal(( *      'D' )                +
                        ( *PRINT 'P' ))               +
                 Expr( *YES )                         +
                 Prompt( 'Output' )

