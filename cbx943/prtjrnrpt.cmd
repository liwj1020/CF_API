/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRTJRNRPT )                                        */
/*           Pgm( CBX9431 )                                          */
/*           SrcMbr( CBX943X )                                       */
/*           VldCkr( CBX943V )                                       */
/*           HlpPnlGrp( CBX943H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Print Journal Report' )

          Parm     OBJLIB        *Name                          +
                   Min( 1 )                                     +
                   SpcVal(( *LIBL    )                          +
                          ( *CURLIB  )                          +
                          ( *USRLIBL )                          +
                          ( *ALLUSR  )                          +
                          ( *ALL     ))                         +
                   Expr( *YES )                                 +
                   Prompt( 'Object library' )

          Parm     OBJTYP        *Char    10                    +
                   Dft( *ALL )                                  +
                   Rstd( *YES )                                 +
                   SpcVal(( *ALL    )                           +
                          ( *FILE   )                           +
                          ( *DTAQ   )                           +
                          ( *DTAARA ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Object type' )

          Parm     RPTTYP        *Char    10                    +
                   Dft( *NOTJRN )                               +
                   Rstd( *YES )                                 +
                   SpcVal(( *JRN )                              +
                          ( *NOTJRN ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Report type' )

          Parm     ORDER         *Char    10                    +
                   Dft( *LIBOBJ )                               +
                   Rstd( *YES )                                 +
                   SpcVal(( *LIBOBJ )                           +
                          ( *OBJ    )                           +
                          ( *JRNLIB )                           +
                          ( *CRTPRF )                           +
                          ( *TYPOBJ ))                          +
                   Expr( *YES )                                 +
                   Prompt( 'Printing order' )

          Parm     JOBD          Q001                           +
                   Dft( *USRPRF )                               +
                   SngVal(( *USRPRF ))                          +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Job description' )

          Parm     OUTQ          Q001                           +
                   Dft( *CURRENT )                              +
                   SngVal(( *CURRENT ) ( *JOBD ) ( *USRPRF ))   +
                   PmtCtl( *PMTRQS )                            +
                   Prompt( 'Output queue' )


 Q001:    Qual                   *Name    10                    +
                   Expr( *Yes )

          Qual                   *Name    10                    +
                   Dft( *LIBL )                                 +
                   SpcVal(( *LIBL ) ( *CURLIB ))                +
                   Expr( *Yes )                                 +
                   Prompt( 'Library' )

