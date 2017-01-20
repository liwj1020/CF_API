/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RTVDEVIP )                                         */
/*           Pgm( CBX9421 )                                          */
/*           SrcMbr( CBX9421X )                                      */
/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
/*           HlpPnlGrp( CBX9421H )                                   */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Retrieve Device IP Address' )

          Parm     DEV         *Name      10                    +
                   Dft( *CURRENT )                              +
                   SpcVal(( *CURRENT ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Device' )

          Parm     IPADDR      *Char      15                    +
                   RtnVal( *YES )                               +
                   Prompt( 'CL var for IPADDR       (15)' )

