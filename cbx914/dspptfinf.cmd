/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( DSPPTFINF )                                        */
/*           Pgm( CBX914 )                                           */
/*           SrcMbr( CBX914X )                                       */
/*           HlpPnlGrp( CBX914H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Cmd        Prompt( 'Display PTF Information' )
 
     Parm       PTF         *Char       7                  +
                Min( 1 )                                   +
                Full( *YES )                               +
                Prompt( 'PTF' )
 
     Parm       OPTION      *Char       4                  +
                Rstd( *YES )                               +
                Dft( *VFY )                                +
                SpcVal(( *VFY ) ( *DSP ) ( *CVR ))         +
                Prompt( 'Display option' )
 
