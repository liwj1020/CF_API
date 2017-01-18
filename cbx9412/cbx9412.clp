000100050320/*-------------------------------------------------------------------*/
000200050320/*                                                                   */
000300050724/*  Program . . : CBX9412                                            */
000400050724/*  Description : Display directory entry SMTP name - CPP            */
000500050320/*  Author  . . : Carsten Flensburg                                  */
000600050320/*                                                                   */
000700050320/*                                                                   */
000800050320/*  Compile options:                                                 */
000900050320/*                                                                   */
001000050724/*    CrtClPgm   Pgm( CBX9412 )                                      */
001100050320/*               SrcFile( QCLSRC )                                   */
001200050320/*               SrcMbr( *PGM )                                      */
001300050320/*                                                                   */
001400050320/*                                                                   */
001500050320/*-------------------------------------------------------------------*/
001600050724     Pgm      ( &PxUsrId  &PxUsrPrf )
001700021113
001800050724     Dcl        &PxUsrId      *Char       18
001900050724     Dcl        &PxUsrPrf     *Char       10
002000050322
002100050724     Dcl        &NbrElm       *Dec         5
002200050724     Dcl        &UserId       *Char        8
002300050724     Dcl        &UserAddr     *Char        8
002400050726     Dcl        &SmtpAddr     *Char       63
002500021113
002600050724     MonMsg     CPF0000       *N        GoTo Error
002700050321
002800050724
002900050724     ChgVar     &NbrElm       %Bin( &PxUsrId   1  2 )
003000050724     ChgVar     &UserId       %Sst( &PxUsrId   3  8 )
003100050724     ChgVar     &UserAddr     %Sst( &PxUsrId  11  8 )
003200050322
003300050724     If       ( &UserId = '*USRPRF' )     Do
003400050725
003500050724     RtvDirSmtp User( &PxUsrPrf )         +
003600050726                SmtpAddr( &SmtpAddr )
003700050725
003800050725     If       ( &PxUsrPrf = '*CURRENT' )  RtvJobA  CurUser( &PxUsrPrf )
003900050725
004000050726     SndPgmMsg  MsgId( CPF9897 )                                +
004100050726                MsgF( QCPFMSG )                                 +
004200050809                MsgDta( 'User profile '    *Cat &PxUsrPrf *Bcat +
004300050726                        'SMTP address is ' *Cat &SmtpAddr  )    +
004400050726                ToPgmQ( *PRV )                                  +
004500050725                MsgType( *COMP )
004600050724     EndDo
004700050724     Else Do
004800050322
004900050724     RtvDirSmtp UsrId( &UserId &UserAddr )  +
005000050726                SmtpAddr( &SmtpAddr )
005100050725
005200050726     SndPgmMsg  MsgId( CPF9897 )                                +
005300050726                MsgF( QCPFMSG )                                 +
005400050726                MsgDta( 'User ID '                 *Bcat        +
005500050726                        &UserId  *Bcat  &UserAddr  *Bcat        +
005600050726                        'SMTP address is ' *Cat &SmtpAddr  )    +
005700050726                ToPgmQ( *PRV )                                  +
005800050725                MsgType( *COMP )
005900050724     EndDo
006000050301
006100050320Return:
006200050320     Return
006300021114
006400021114Error:
006500050301     Call       QMHMOVPM    ( '    '                  +
006600050301                              '*DIAG'                 +
006700050301                              x'00000001'             +
006800050301                              '*PGMBDY'               +
006900050301                              x'00000001'             +
007000050301                              x'0000000800000000'     +
007100050301                            )
007200050301
007300050301     Call       QMHRSNEM    ( '    '                  +
007400050301                              x'0000000800000000'     +
007500050301                            )
007600021113EndPgm:
007700021113     EndPgm
