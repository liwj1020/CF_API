/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RUNJOBCMD )                                        */
/*           Pgm( CBX9351 )                                          */
/*           SrcMbr( CBX935X )                                       */
/*           Mode( *PROD )                                           */
/*           HlpPnlGrp( CBX935H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
    Cmd        Prompt( 'Run job command' )

    Parm       JOB      Job001              +
               Min(1)                       +
               Choice(*NONE)                +
               Prompt('Job name')

    Parm       CMD      *CmdStr    3000     +
               Vary( *YES *INT2 )           +
               Min( 1 )                     +
               Prompt( 'Command')

    Parm       TIMEOUT  *Dec          5     +
               Dft( 25 )                    +
               Range( 5  3600 )             +
               Expr( *YES )                 +
               Choice( 'Seconds, 5-3600' )   +
               Prompt( 'Request time-out' )

Job001:                                     +
    Qual                *Name        10     +
               Min( 1 )                     +
               Expr( *YES )

    Qual                *Name        10     +
               Expr( *YES )                 +
               Prompt( 'User' )

    Qual                *Char         6     +
               Range( '000000' '999999' )   +
               Full( *YES )                 +
               Expr( *YES )                 +
               Prompt( 'Number' )

