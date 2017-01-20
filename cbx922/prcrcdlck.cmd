/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( PRCRCDLCK )                                        */
/*           Pgm( CBX922 )                                           */
/*           SrcMbr( CBX922X )                                       */
/*           AlwLmtUsr( *NO )                                        */
/*           HlpPnlGrp( CBX922H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
        Cmd      Prompt( 'Process Record Locks' )


        Parm     FILE          Q0001             +
                 Min( 1 )                        +
                 File( *UNSPFD )                 +
                 Choice( *NONE )                 +
                 Prompt( 'Physical file' )

        Parm     MBR           *Name    10       +
                 Dft( *FIRST )                   +
                 SpcVal(( *FIRST ))              +
                 Expr( *YES )                    +
                 Prompt( 'Member' )

        Parm     RCDNBR        *UINT4            +
                 Dft( *ALL )                     +
                 Range( 1 4294967288 )           +
                 SpcVal(( *ALL 0 ))              +
                 Expr( *YES )                    +
                 Choice( '1-4294967288' )        +
                 Prompt( 'Record number' )

        Parm     ACTION        *Char     7       +
                 Dft( *BRKMSG )                  +
                 Rstd( *YES )                    +
                 SpcVal(( *BRKMSG )              +
                        ( *ENDJOB ))             +
                 Expr( *YES )                    +
                 Prompt( 'Action to perform' )

        Parm     MSG          *Char    512       +
                 Expr( *YES )                    +
                 Vary( *YES *INT2 )              +
                 PmtCtl( P0001 )                 +
                 Prompt( 'Message text' )

        Parm     MSGTO         *Char     5       +
                 Dft( *JOB )                     +
                 Rstd( *YES )                    +
                 SpcVal(( *JOB )                 +
                        ( *USER ))               +
                 Expr( *YES )                    +
                 PmtCtl( P0001 )                 +
                 Prompt( 'Send message to' )

        Parm     ENDOPT        *Char     7       +
                 Rstd( *YES )                    +
                 Dft( *CNTRLD )                  +
                 SpcVal(( *CNTRLD )              +
                        ( *IMMED  ))             +
                 Expr( *YES )                    +
                 PmtCtl( P0002 )                 +
                 Prompt( 'How to end' )

        Parm     DELAY         *Int4             +
                 DFT( 30 )                       +
                 Range( 1 999999 )               +
                 Expr( *YES )                    +
                 PmtCtl( P0002 )                 +
                 Choice( 'Seconds' )             +
                 Prompt( 'Delay time, if *CNTRLD' )


Q0001:  Qual                  *Name     10       +
                 Min( 1 )                        +
                 Expr( *YES )

        Qual                  *Name     10       +
                 Dft( *LIBL )                    +
                 SpcVal(( *LIBL )                +
                        ( *CURLIB ))             +
                 Expr( *YES )                    +
                 Prompt( 'Library' )


P0001:  PmtCtl   Ctl( ACTION )                   +
                 Cond(( *EQ *BRKMSG ))

P0002:  PmtCtl   Ctl( ACTION )                   +
                 Cond(( *EQ *ENDJOB ))


        Dep      Ctl( &ACTION *EQ '*BRKMSG' )    +
                 Parm(( MSG ))                   +
                 NbrTrue( *EQ 1 )                +
                 MsgId( CPF1EBD )

        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
                 Parm(( MSG ))                   +
                 NbrTrue( *EQ 0 )                +
                 MsgId( CPE3028 )

        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
                 Parm(( MSGTO ))                 +
                 NbrTrue( *EQ 0 )

        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
                 Parm(( ENDOPT ))                +
                 NbrTrue( *EQ 0 )                +

        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
                 Parm(( DELAY ))                 +
                 NbrTrue( *EQ 0 )                +

        Dep      Ctl( &ENDOPT *NE '*CNTRLD' )    +
                 Parm(( DELAY ))                 +
                 NbrTrue( *EQ 0 )                +

