/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9422                                            */
/*  Description : Display device IP address - CPP                    */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9422 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm        &Device

     Dcl        &Device      *Char       10
     Dcl        &DevIp       *Char       15

     MonMsg     CPF0000       *N         GoTo Error


     If       ( &Device = '*CURRENT' )   Do
     RtvJobA    Job( &Device )
     EndDo

     Else Do
     ChkObj     &Device       *DEVD
     EndDo

     RtvDevIp   Dev( &Device )  IpAddr( &DevIp )

     SndPgmMsg  Msg( 'Device'         *Bcat  &Device *Bcat       +
                     'has IP address' *Bcat  &DevIp  *Tcat '.' ) +
                ToPgmQ( *PRV )                                   +
                MsgType( *COMP )

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
