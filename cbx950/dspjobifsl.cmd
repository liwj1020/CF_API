/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPJOBIFSL )                                       */
/*           Pgm( CBX950 )                                           */
/*           SrcMbr( CBX950X )                                       */
/*           Mode( *PROD )                                           */
/*           HlpPnlGrp( CBX950H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
    Cmd        Prompt( 'Display job IFS object locks' )

    Parm       JOB      JOB001                        +
               Dft( * )                               +
               SngVal(( * ))                          +
               Choice(*NONE)                          +
               Prompt('Job name')

    Parm       OUTPUT     *Char        3              +
               Rstd( *YES )                           +
               Dft( * )                               +
               SpcVal(( *  DSP ) ( *PRINT  PRT ))     +
               Prompt( 'Output' )

    Parm       LONGPATH   *Char        1              +
               Rstd( *YES )                           +
               Dft( *PARTIAL )                        +
               SpcVal(( *PARTIAL P ) ( *FULL F ))     +
               Prompt( 'Long path name' )


JOB001:                                               +
    Qual                *Name        10               +
               Min( 1 )                               +
               Expr( *YES )

    Qual                *Name        10               +
               Expr( *YES )                           +
               Prompt( 'User' )

    Qual                *Char         6               +
               Range( '000000' '999999' )             +
               Full( *YES )                           +
               Expr( *YES )                           +
               Prompt( 'Number' )

