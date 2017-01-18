000100030809/*-------------------------------------------------------------------*/
000200030824/*                                                                   */
000300050917/*  Program . . : CBX945                                             */
000400050917/*  Description : Change profile exit program - CPP                  */
000500030829/*  Author  . . : Carsten Flensburg                                  */
000600030904/*                                                                   */
000700030904/*                                                                   */
000800030829/*  Programmer's notes:                                              */
000900030829/*    Currently supported by the profile exit APIs are the           */
001000030830/*    preattention and presystem request exit points                 */
001100030830/*    QIBM_QWT_PREATTNPGMS respectively QIBM_QWT_SYSREQPGMS.         */
001200030830/*    Both are managed through either the WRKREGINF facility         */
001300030830/*    or the ADDEXITPGM and RMVEXITPGM commands.                     */
001400030829/*                                                                   */
001500030829/*                                                                   */
001600030809/*  Compile options:                                                 */
001700050917/*    CrtClPgm   Pgm( CBX945 )                                       */
001800030809/*               SrcFile( QCLSRC )                                   */
001900030809/*               SrcMbr( *PGM )                                      */
002000030809/*                                                                   */
002100030809/*-------------------------------------------------------------------*/
002200030812     Pgm      ( &UsrPrf                +
002300030812                &XitFmt                +
002400030830                &XitOpt                +
002500030823              )
002600000212
002700000315/*-- Parameters:  ---------------------------------------------------*/
002800030812     Dcl        &UsrPrf      *Char    10
002900030812     Dcl        &XitFmt      *Char     8
003000030812     Dcl        &XitOpt      *Char    34
003100000315
003200000317     Dcl        &PgmNbr      *Char     4   x'00000008'
003300000317     Dcl        &Flags       *Char    32
003400960724
003500000315/*-- Global error monitoring:  --------------------------------------*/
003600000315     MonMsg     CPF0000      *N        GoTo Error
003700030805
003800000315
003900030812     RtvUsrPrf  &UsrPrf       RtnUsrPrf( &UsrPrf )
004000000315
004100030824     ChgVar     &Flags        %Sst( &XitOpt  3  32 )
004200000315
004300000315     Call       QWTSETPX    ( &PgmNbr            +
004400000315                              &Flags             +
004500030812                              &XitFmt            +
004600030812                              &UsrPrf            +
004700030824                              x'00000000'        +
004800030824                            )
004900000319
005000050925     SndPgmMsg  Msg( 'Profile exit programs have been changed.' )   +
005100030824                MsgType( *COMP )
005200000319
005300000315 Return:
005400000315     Return
005500000315
005600000315/*-- Error handling:  -----------------------------------------------*/
005700000315 Error:
005800030805     Call      QMHMOVPM    ( '    '                                  +
005900030805                             '*DIAG'                                 +
006000030805                             x'00000001'                             +
006100030824                             '*PGMBDY'                               +
006200030805                             x'00000001'                             +
006300030829                             x'0000000800000000'                     +
006400030805                           )
006500030805
006600030805     Call      QMHRSNEM    ( '    '                                  +
006700030829                             x'0000000800000000'                     +
006800030805                           )
006900000212
007000000315 EndPgm:
007100000315     EndPgm
