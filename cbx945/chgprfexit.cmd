/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHGPRFEXIT )                                       */
/*           Pgm( CBX945 )                                           */
/*           SrcMbr( CBX945X )                                       */
/*           HlpPnlGrp( CBX945H )                                    */
/*           HlpId( *CMD )                                           */
/*           PmtOvrPgm( CBX945O )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
        Cmd        Prompt( 'Change Profile Exit Program' )

        Parm       USRPRF        *Name                     +
                   Min( 1 )                                +
                   SpcVal(( *CURRENT ))                    +
                   Expr( *YES )                            +
                   Keyparm( *YES )                         +
                   Prompt( 'User profile' )

        Parm       FORMAT        *Char      8              +
                   Rstd( *YES )                            +
                   Dft( *SYSRQS )                          +
                   SpcVal(( *SYSRQS  SREQ0100 )            +
                          ( *ATTN    ATTN0100 ))           +
                   Expr( *YES )                            +
                   Keyparm( *YES )                         +
                   Prompt( 'Exit program format' )

        Parm       EXITPGM       E0001                     +
                   Prompt( 'Exit program option' )


E0001:  Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 1' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr(*YES)                                   +
                   Prompt( 'Program 2' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 3' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 4' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 5' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 6' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 7' )

        Elem                    *INT4                           +
                   Rstd( *YES )                                 +
                   Dft( *SAME )                                 +
                   SpcVal(( *ON 1 ) ( *OFF 0 ) ( *SAME -1 ))    +
                   Expr( *YES )                                 +
                   Prompt( 'Program 8' )

