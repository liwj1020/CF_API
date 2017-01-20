/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9412                                            */
/*  Description : Display directory entry SMTP name - CPP            */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9412 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &PxUsrId  &PxUsrPrf )

     Dcl        &PxUsrId      *Char       18
     Dcl        &PxUsrPrf     *Char       10

     Dcl        &NbrElm       *Dec         5
     Dcl        &UserId       *Char        8
     Dcl        &UserAddr     *Char        8
     Dcl        &SmtpAddr     *Char       63

     MonMsg     CPF0000       *N        GoTo Error


     ChgVar     &NbrElm       %Bin( &PxUsrId   1  2 )
     ChgVar     &UserId       %Sst( &PxUsrId   3  8 )
     ChgVar     &UserAddr     %Sst( &PxUsrId  11  8 )

     If       ( &UserId = '*USRPRF' )     Do

     RtvDirSmtp User( &PxUsrPrf )         +
                SmtpAddr( &SmtpAddr )

     If       ( &PxUsrPrf = '*CURRENT' )  RtvJobA  CurUser( &PxUsrPrf )

     SndPgmMsg  MsgId( CPF9897 )                                +
                MsgF( QCPFMSG )                                 +
                MsgDta( 'User profile '    *Cat &PxUsrPrf *Bcat +
                        'SMTP address is ' *Cat &SmtpAddr  )    +
                ToPgmQ( *PRV )                                  +
                MsgType( *COMP )
     EndDo
     Else Do

     RtvDirSmtp UsrId( &UserId &UserAddr )  +
                SmtpAddr( &SmtpAddr )

     SndPgmMsg  MsgId( CPF9897 )                                +
                MsgF( QCPFMSG )                                 +
                MsgDta( 'User ID '                 *Bcat        +
                        &UserId  *Bcat  &UserAddr  *Bcat        +
                        'SMTP address is ' *Cat &SmtpAddr  )    +
                ToPgmQ( *PRV )                                  +
                MsgType( *COMP )
     EndDo

Return:
     Return

Error:
     Call       QMHMOVPM    ( '    '                  +
                              '*DIAG'                 +
                              x'00000001'             +
                              '*PGMBDY'               +
                              x'00000001'             +
                              x'0000000800000000'     +
                            )

     Call       QMHRSNEM    ( '    '                  +
                              x'0000000800000000'     +
                            )
EndPgm:
     EndPgm
