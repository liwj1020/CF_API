/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( RMVJRNRCV )                                        */
/*           Pgm( CBX959 )                                           */
/*           SrcMbr( CBX959X )                                       */
/*           VldCkr( CBX959V )                                       */
/*           HlpPnlGrp( CBX959H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'Remove Journal Receivers' )

             Parm       JRN           Q0001                          +
                        Min( 1 )                                     +
                        Prompt( 'Journal' )

             Parm       DAYS          *Int2                          +
                        Range( 1  999 )                              +
                        Dft( *NONE )                                 +
                        SpcVal(( *NONE  -1 ))                        +
                        Prompt( 'Journal receiver retain days' )

             Parm       RETAIN        *Int2                          +
                        Range( 1  999 )                              +
                        Dft( *NONE )                                 +
                        SpcVal(( *NONE  -1 ))                        +
                        Prompt( 'Journal receivers to retain' )

             Parm       FORCE         *Char    3                     +
                        Rstd( *YES )                                 +
                        Dft( *NO )                                   +
                        SpcVal(( *NO   NO  )                         +
                               ( *YES  YES ))                        +
                        Prompt( 'Force receiver deletion' )

             Parm       CHGJRN        *Char    3                     +
                        Rstd( *YES )                                 +
                        Dft( *NO )                                   +
                        SpcVal(( *NO   NO  )                         +
                               ( *YES  YES ))                        +
                        Prompt( 'Change journal receiver' )

             Parm       JRNRCV        E0002                          +
                        Dft( *SAME )                                 +
                        SngVal(( *SAME ))                            +
                        PmtCtl( CHGJRNRCV )                          +
                        Prompt( 'Journal receiver' )

             Parm       SEQOPT        *Char    6                     +
                        Rstd( *YES )                                 +
                        Dft( *CONT )                                 +
                        SpcVal(( *CONT ) ( *RESET ))                 +
                        Expr( *YES )                                 +
                        PmtCtl( CHGJRNRCV )                          +
                        Prompt( 'Sequence option' )

 Q0001:      Qual                   *Name                            +
                        Expr( *YES )

             Qual                   *Name                            +
                        Dft( *LIBL )                                 +
                        SpcVal(( *LIBL ) ( *CURLIB ))                +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )

 Q0002:      Qual                     *Name      10                  +
                        Expr( *YES )

             Qual                     *Name      10                  +
                        Dft( *LIBL )                                 +
                        Rel( *NE QTEMP )                             +
                        SpcVal(( *LIBL ) ( *CURLIB ))                +
                        Expr( *YES )                                 +
                        Prompt('Library')

 E0002:      Elem                     Q0002                          +
                        SngVal(( *GEN ))                             +
                        Prompt( 'Journal receiver' )

             Elem                     Q0002                          +
                        SngVal(( *GEN ))                             +
                        Prompt( 'Journal receiver' )


 CHGJRNRCV:  PmtCtl     Ctl( CHGJRN )                                +
                        Cond(( *EQ YES ))

             Dep        Ctl( &CHGJRN *EQ 'NO ' )                     +
                        Parm(( JRNRCV ))                             +
                        NbrTrue( *EQ 0 )

             Dep        Ctl( &CHGJRN *EQ 'NO ' )                     +
                        Parm(( SEQOPT ))                             +
                        NbrTrue( *EQ 0 )

             Dep        Ctl( &CHGJRN *EQ 'YES' )                     +
                        Parm(( &JRNRCV *EQ '*SAME' ))                +
                        NbrTrue( *EQ 0 )

