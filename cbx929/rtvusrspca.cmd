/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVUSRSPCA )                                       */
/*           Pgm( CBX929 )                                           */
/*           SrcMbr( CBX929X )                                       */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX929H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve User Special Auth')

          Parm     USRPRF        *Name                          +
                   Min( 1 )                                     +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'User profile' )

          Parm     OPTION        *Char    10                    +
                   Dft( *USRPRF )                               +
                   Rstd( *YES )                                 +
                   SpcVal(( *USRPRF )                           +
                          ( *GRPPRF )                           +
                          ( *SUPGRP )                           +
                          ( *ALL ))                             +
                   Expr( *YES )                                 +
                   Prompt( 'Option' )

          Parm     SPCAUT      *Char     150                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for SPCAUT      (150)' )

