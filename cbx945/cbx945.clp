/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX945                                             */
/*  Description : Change profile exit program - CPP                  */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*    Currently supported by the profile exit APIs are the           */
/*    preattention and presystem request exit points                 */
/*    QIBM_QWT_PREATTNPGMS respectively QIBM_QWT_SYSREQPGMS.         */
/*    Both are managed through either the WRKREGINF facility         */
/*    or the ADDEXITPGM and RMVEXITPGM commands.                     */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX945 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &UsrPrf                +
                &XitFmt                +
                &XitOpt                +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &UsrPrf      *Char    10
     Dcl        &XitFmt      *Char     8
     Dcl        &XitOpt      *Char    34

     Dcl        &PgmNbr      *Char     4   x'00000008'
     Dcl        &Flags       *Char    32

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error


     RtvUsrPrf  &UsrPrf       RtnUsrPrf( &UsrPrf )

     ChgVar     &Flags        %Sst( &XitOpt  3  32 )

     Call       QWTSETPX    ( &PgmNbr            +
                              &Flags             +
                              &XitFmt            +
                              &UsrPrf            +
                              x'00000000'        +
                            )

     SndPgmMsg  Msg( 'Profile exit programs have been changed.' )   +
                MsgType( *COMP )

 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                                  +
                             '*DIAG'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )

     Call      QMHRSNEM    ( '    '                                  +
                             x'0000000800000000'                     +
                           )

 EndPgm:
     EndPgm
