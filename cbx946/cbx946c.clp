/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program function:  Setup enhanced system request menu options    */
/*                     and exit point program.                       */
/*                                                                   */
/*                                                                   */
/*  Parameter:                                                       */
/*    SrqLib     INPUT      System request application library.      */
/*                                                                   */
/*                          Specify the library that contains the    */
/*                          CBX946 and CBX946S programs. This is     */
/*                          where the command message file will      */
/*                          be created as well.                      */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX946C )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &SrqLib )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &SrqLib      *Char     10
     Dcl        &UsrPrf      *Char     10

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error


     CrtMsgF    &SrqLib/SRQMSGF                                 +
                Text( 'System request menu - additional options' )

     AddMsgD    SRQ0000                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'WRKMSGD MSGF(SRQMSGF)' )

     AddMsgD    SRQ0021                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'WRKJOB' )

     AddMsgD    SRQ0022                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'DSPJOBLOG' )

     AddMsgD    SRQ0023                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'DSPLIBL' )

     AddMsgD    SRQ0024                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'EDTLIBL' )

     AddMsgD    SRQ0025                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'CHGCURLIB CURLIB(&1)' )                   +
                Fmt(( *CHAR 10 ))

     AddMsgD    SRQ0026                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'WRKSBMJOB SBMFROM(*JOB)' )

     AddMsgD    SRQ0027                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'WRKUSRJOB USER(&1) STATUS(*ACTIVE)' )     +
                Fmt(( *CHAR 10 ))

     AddMsgD    SRQ0030                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( '&1' )                                     +
                Fmt(( *CHAR 128 ))

     AddMsgD    SRQ0031                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'CALL PGM(&1)' )                           +
                Fmt(( *CHAR 10 ))

     AddMsgD    SRQ0032                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'GO MENU(&1)' )                            +
                Fmt(( *CHAR 10 ))

     AddMsgD    SRQ0035                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'RUNQRY QRY(*NONE) QRYFILE(&1) RCDSLT(*YES)' )       +
                Fmt(( *CHAR 10 ))

     AddMsgD    SRQ0036                                         +
                MsgF( &SrqLib/SRQMSGF )                         +
                Msg( 'CPYTOIMPF FROMFILE(&1) TOSTMF(''/QOpenSys/&1.txt'') +
                      STMFCODPAG(819) RCDDLM(*CRLF)' )          +
                Fmt(( *CHAR 10 ))


     SndPgmMsg  Msg( 'System request command message file created.' )     +
                MsgType( *COMP )


     AddExitPgm ExitPnt( QIBM_QWT_SYSREQPGMS )                  +
                Format( SREQ0100 )                              +
                PgmNbr( 1 )                                     +
                Pgm( &SrqLib/CBX946 )                           +
                PgmDta( *JOB *CALC 1 )                          +
                Text( 'Enhanced system request menu' )

     SndPgmMsg  Msg( 'System request exit point program registered.' )    +
                MsgType( *COMP )


     RtvJobA    User( &UsrPrf )

     ChgPrfExit UsrPrf( &UsrPrf )  Format( *SYSRQS )  ExitPgm( *ON )

     SndPgmMsg  Msg( 'System request exit point activated for' *Bcat +
                     &UsrPrf                                   *Tcat +
                     '.' )                                           +
                MsgType( *COMP )

 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                             +
                             '*DIAG'                            +
                             x'00000001'                        +
                             '*PGMBDY   '                       +
                             x'00000001'                        +
                             x'0000000800000000'                +
                           )

     Call      QMHRSNEM    ( '    '                             +
                             x'0000000800000000'                +
                           )

 EndPgm:
     EndPgm
