/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTUSRAUTL )                                       */
/*           Pgm( CBX956 )                                           */
/*           SrcMbr( CBX956X )                                       */
/*           VldCkr( CBX956V )                                       */
/*           HlpPnlGrp( CBX956H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print User Authorization Lists' )

          Parm     USRPRF      *Sname     10                    +
                   Min( 1 )                                     +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )

          Parm     INCGRP      *Char       1                    +
                   Dft( *NO )                                   +
                   Rstd( *YES )                                 +
                   SpcVal(( *NO   'N' )                         +
                          ( *YES  'Y' ))                        +
                   Expr( *YES )                                 +
                   Prompt( 'Include group profiles' )

