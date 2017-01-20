/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9421                                            */
/*  Description : Retrieve device IP address - CPP                   */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9421 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &Device  &DevIp )

     Dcl        &Device      *Char       10
     Dcl        &DevIp       *Char       15

     Dcl        &DevCtg      *Char       10
     Dcl        &DevInf      *Char     2048
     Dcl        &RcvLen      *Char        4   x'00000800'

     Dcl        &IP_NONE     *Char       15   x'000000000000000000000000000000'
     Dcl        &IP_BLANK    *Char       15   ' '

     MonMsg     CPF0000       *N         GoTo Error


     ChgVar     &DevIp       ' '

     If       ( &Device = '*CURRENT' )   Do
     RtvJobA    Job( &Device )
     EndDo

     Call       QDCRDEVD     Parm( &DevInf         +
                                   &RcvLen         +
                                   'DEVD0100'      +
                                   &Device         +
                                   x'00000000'     +
                                 )

     ChgVar     &DevCtg      %Sst( &DevInf   32 10 )

     If       ( &DevCtg = '*DSP' )       Do

     Call       QDCRDEVD     Parm( &DevInf         +
                                   &RcvLen         +
                                   'DEVD0600'      +
                                   &Device         +
                                   x'00000000'     +
                                 )

     ChgVar     &DevIp       %Sst( &DevInf  878 15 )
     EndDo

     Else If  ( &DevCtg = '*PRT' )       Do

     Call       QDCRDEVD     Parm( &DevInf         +
                                   &RcvLen         +
                                   'DEVD1100'      +
                                   &Device         +
                                   x'00000000'     +
                                 )

     ChgVar     &DevIp       %Sst( &DevInf 1405 15 )
     EndDo

     If       ( &DevIp = &IP_NONE )      Do
     ChgVar     &DevIp       '*NONE'
     EndDo

     Else If  ( &DevIp = &IP_BLANK )     Do
     ChgVar     &DevIp       '*NONE'
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
