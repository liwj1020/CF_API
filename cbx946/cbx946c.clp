000100030823/*-------------------------------------------------------------------*/
000200030829/*                                                                   */
000300030829/*  Program function:  Setup enhanced system request menu options    */
000400030830/*                     and exit point program.                       */
000500030830/*                                                                   */
000600050917/*                                                                   */
000700030829/*  Parameter:                                                       */
000800030829/*    SrqLib     INPUT      System request application library.      */
000900030829/*                                                                   */
001000030829/*                          Specify the library that contains the    */
001100050917/*                          CBX946 and CBX946S programs. This is     */
001200030829/*                          where the command message file will      */
001300030829/*                          be created as well.                      */
001400030829/*                                                                   */
001500050917/*                                                                   */
001600030823/*  Compile options:                                                 */
001700050917/*    CrtClPgm   Pgm( CBX946C )                                      */
001800030823/*               SrcFile( QCLSRC )                                   */
001900030823/*               SrcMbr( *PGM )                                      */
002000030823/*                                                                   */
002100030823/*-------------------------------------------------------------------*/
002200030829     Pgm      ( &SrqLib )
002300000212
002400000315/*-- Parameters:  ---------------------------------------------------*/
002500030829     Dcl        &SrqLib      *Char     10
002600051009     Dcl        &UsrPrf      *Char     10
002700960724
002800000315/*-- Global error monitoring:  --------------------------------------*/
002900030805     MonMsg     CPF0000      *N        GoTo Error
003000030805
003100050917
003200030829     CrtMsgF    &SrqLib/SRQMSGF                                 +
003300030805                Text( 'System request menu - additional options' )
003400030805
003500030805     AddMsgD    SRQ0000                                         +
003600030829                MsgF( &SrqLib/SRQMSGF )                         +
003700030805                Msg( 'WRKMSGD MSGF(SRQMSGF)' )
003800030805
003900030805     AddMsgD    SRQ0021                                         +
004000030829                MsgF( &SrqLib/SRQMSGF )                         +
004100030805                Msg( 'WRKJOB' )
004200000319
004300030805     AddMsgD    SRQ0022                                         +
004400030829                MsgF( &SrqLib/SRQMSGF )                         +
004500030805                Msg( 'DSPJOBLOG' )
004600030805
004700030805     AddMsgD    SRQ0023                                         +
004800030829                MsgF( &SrqLib/SRQMSGF )                         +
004900030805                Msg( 'DSPLIBL' )
005000030805
005100030805     AddMsgD    SRQ0024                                         +
005200030829                MsgF( &SrqLib/SRQMSGF )                         +
005300030805                Msg( 'EDTLIBL' )
005400030805
005500030805     AddMsgD    SRQ0025                                         +
005600030829                MsgF( &SrqLib/SRQMSGF )                         +
005700030805                Msg( 'CHGCURLIB CURLIB(&1)' )                   +
005800030805                Fmt(( *CHAR 10 ))
005900030805
006000030805     AddMsgD    SRQ0026                                         +
006100030829                MsgF( &SrqLib/SRQMSGF )                         +
006200030805                Msg( 'WRKSBMJOB SBMFROM(*JOB)' )
006300030805
006400030805     AddMsgD    SRQ0027                                         +
006500030829                MsgF( &SrqLib/SRQMSGF )                         +
006600030805                Msg( 'WRKUSRJOB USER(&1) STATUS(*ACTIVE)' )     +
006700030805                Fmt(( *CHAR 10 ))
006800030805
006900030805     AddMsgD    SRQ0030                                         +
007000030829                MsgF( &SrqLib/SRQMSGF )                         +
007100030805                Msg( '&1' )                                     +
007200030805                Fmt(( *CHAR 128 ))
007300030805
007400030805     AddMsgD    SRQ0031                                         +
007500030829                MsgF( &SrqLib/SRQMSGF )                         +
007600030805                Msg( 'CALL PGM(&1)' )                           +
007700030805                Fmt(( *CHAR 10 ))
007800030805
007900030805     AddMsgD    SRQ0032                                         +
008000030829                MsgF( &SrqLib/SRQMSGF )                         +
008100030805                Msg( 'GO MENU(&1)' )                            +
008200030805                Fmt(( *CHAR 10 ))
008300030805
008400030805     AddMsgD    SRQ0035                                         +
008500030829                MsgF( &SrqLib/SRQMSGF )                         +
008600030829                Msg( 'RUNQRY QRY(*NONE) QRYFILE(&1) RCDSLT(*YES)' )       +
008700030805                Fmt(( *CHAR 10 ))
008800030806
008900030806     AddMsgD    SRQ0036                                         +
009000030829                MsgF( &SrqLib/SRQMSGF )                         +
009100030806                Msg( 'CPYTOIMPF FROMFILE(&1) TOSTMF(''/QOpenSys/&1.txt'') +
009200030806                      STMFCODPAG(819) RCDDLM(*CRLF)' )          +
009300030806                Fmt(( *CHAR 10 ))
009400030805
009500030805
009600050917     SndPgmMsg  Msg( 'System request command message file created.' )     +
009700050917                MsgType( *COMP )
009800030829
009900030829
010000030829     AddExitPgm ExitPnt( QIBM_QWT_SYSREQPGMS )                  +
010100030829                Format( SREQ0100 )                              +
010200030829                PgmNbr( 1 )                                     +
010300050917                Pgm( &SrqLib/CBX946 )                           +
010400030829                PgmDta( *JOB *CALC 1 )                          +
010500030829                Text( 'Enhanced system request menu' )
010600000319
010700050917     SndPgmMsg  Msg( 'System request exit point program registered.' )    +
010800050917                MsgType( *COMP )
010900030829
011000051009
011100051009     RtvJobA    User( &UsrPrf )
011200051009
011300051009     ChgPrfExit UsrPrf( &UsrPrf )  Format( *SYSRQS )  ExitPgm( *ON )
011400051009
011500051009     SndPgmMsg  Msg( 'System request exit point activated for' *Bcat +
011600051009                     &UsrPrf                                   *Tcat +
011700051009                     '.' )                                           +
011800051009                MsgType( *COMP )
011900051009
012000000315 Return:
012100000315     Return
012200000315
012300000315/*-- Error handling:  -----------------------------------------------*/
012400000315 Error:
012500030829     Call      QMHMOVPM    ( '    '                             +
012600030829                             '*DIAG'                            +
012700030829                             x'00000001'                        +
012800030829                             '*PGMBDY   '                       +
012900030829                             x'00000001'                        +
013000030829                             x'0000000800000000'                +
013100030805                           )
013200030805
013300030829     Call      QMHRSNEM    ( '    '                             +
013400030829                             x'0000000800000000'                +
013500030805                           )
013600000212
013700000315 EndPgm:
013800000315     EndPgm
