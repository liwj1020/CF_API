/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHGUSRSTS )                                        */
/*           Pgm( CBX923 )                                           */
/*           SrcMbr( CBX923X )                                       */
/*           AlwLmtUsr( *YES )                                       */
/*           HlpPnlGrp( CBX923H )                                    */
/*           HlpId( *CMD )                                           */
/*           Aut( CHGUSRSTS )                                        */
/*                                                                   */
/*  Prerequisite:                                                    */
/*                                                                   */
/*     Prior to compiling the command you must create the            */
/*     the authorization list specified on the AUT parameter         */
/*     of the above CRTCMD command:                                  */
/*                                                                   */
/*       CrtAutL AutL( CHGUSRSTS )                                   */
/*               Aut( *EXCLUDE )                                     */
/*                                                                   */
/*     Only user profiles explicitely authorized to this             */
/*     authorization list will be able to run the CHGUSRSTS          */
/*     command, unless they have *ALLOBJ and *SECADM special         */
/*     authority.                                                    */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
        Cmd      Prompt( 'Change user status' )


        Parm     USRPRF        *Name             +
                 Min( 1 )                        +
                 Expr( *YES )                    +
                 Prompt( 'User profile' )

        Parm     RESET         *Char     4       +
                 Dft( *NO )                      +
                 Rstd( *YES )                    +
                 SpcVal(( *NO  )                 +
                        ( *YES ))                +
                 Expr( *YES )                    +
                 Prompt( 'Reset password' )

        Parm     ENABLE        *Char     4       +
                 Dft( *NO )                      +
                 Rstd( *YES )                    +
                 SpcVal(( *NO  )                 +
                        ( *YES ))                +
                 Expr( *YES )                    +
                 Prompt( 'Enable user profile' )


        Dep      Ctl( &RESET *EQ '*NO' )         +
                 Parm(( &ENABLE *EQ '*NO' ))     +
                 NbrTrue( *EQ 0 )

