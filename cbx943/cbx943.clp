/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9431                                            */
/*  Description : Print journal report - CPP                         */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9431 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &ObjLib           +
                &ObjTyp           +
                &RptTyp           +
                &SrtOrd           +
                &JobD_q           +
                &OutQ_q           +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &ObjLib     *Char    10
     Dcl        &ObjTyp     *Char    10
     Dcl        &RptTyp     *Char    10
     Dcl        &SrtOrd     *Char    10
     Dcl        &JobD_q     *Char    20
     Dcl        &OutQ_q     *Char    20

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JobD       *Char    10
     Dcl        &JobD_l     *Char    10
     Dcl        &OutQ       *Char    10
     Dcl        &OutQ_l     *Char    10

     Dcl        &AutInd     *Char     1
     Dcl        &JobTyp     *Char     1

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error


     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )

     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )

     If       ( &JobD_l = ' ' )    Do
     ChgVar     &JobD_l   '*N'
     EndDo

     Else Do
     ChkObj     &JobD_l/&JobD      *JOBD
     EndDo

     If       ( &OutQ_l = ' ' )    Do
     ChgVar     &OutQ_l   '*N'
     EndDo

     Else Do
     ChkObj     &OutQ_l/&OutQ      *OUTQ
     EndDo

     RtvJobA    Type( &JobTyp )

     If       ( &JobTyp   =  '1' )     Do

        SbmJob     Cmd( Call Pgm( CBX943 ) Parm( &ObjLib &ObjTyp &RptTyp &SrtOrd &JobD_q +
                     &OutQ_q )) Job( PRTJRNRPT ) JobD( &JobD_l/&JobD ) OutQ( &OutQ_l/&OutQ )

     Call       QMHMOVPM    ( '    '                                 +
                             '*COMP'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )

     EndDo

     Else If  ( &JobTyp   =  '0' )     Do

     Call       Pgm( CBX9432 )              +
                Parm( &ObjLib  &ObjTyp  &RptTyp  &SrtOrd )

     EndDo

 Return:
     Return

/*-- Resend system error messages:  ---------------------------------*/
 Error:
     Call       QMHMOVPM    ( '    '                                 +
                              '*DIAG'                                +
                              x'00000001'                            +
                              '*PGMBDY'                              +
                              x'00000001'                            +
                              x'0000000800000000'                    +
                            )

     Call       QMHRSNEM    ( '    '                                 +
                              x'0000000800000000'                    +
                            )

 EndPgm:
     EndPgm
