/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9321                                            */
/*  Description : Print save information - CPP                       */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9321 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &LibNam           +
                &ObjLvl           +
                &IncDat           +
                &SrtOrd           +
                &JobD_q           +
                &OutQ_q           +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &LibNam     *Char    12
     Dcl        &ObjLvl     *Char    10
     Dcl        &IncDat     *Char    19
     Dcl        &SrtOrd     *Char    22
     Dcl        &JobD_q     *Char    20
     Dcl        &OutQ_q     *Char    20

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JobD       *Char    10
     Dcl        &JobD_l     *Char    10
     Dcl        &OutQ       *Char    10
     Dcl        &OutQ_l     *Char    10

     Dcl        &ChkLib     *Char    10
     Dcl        &ChkSiz     *Dec      5

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

     If       ( &OutQ_l = ' ' )    Do
     ChgVar     &OutQ_l   '*N'
     EndDo

     RtvJobA    Type( &JobTyp )

     If       ( &JobTyp   =  '1' )     Do

     SbmJob     Cmd( Call Pgm( CBX9322 )                        +
                          Parm( &LibNam                         +
                                &ObjLvl                         +
                                &IncDat                         +
                                &SrtOrd ))                      +
                Job( PRTSAVINF )                                +
                JobD( &JobD_l/&JobD )                           +
                OutQ( &OutQ_l/&OutQ )

     Call       QMHMOVPM    ( '    '                            +
                             '*COMP'                            +
                             x'00000001'                        +
                             '*PGMBDY'                          +
                             x'00000001'                        +
                             x'0000000800000000'                +
                           )

     EndDo

     Else If  ( &JobTyp   =  '0' )     Do

     Call       Pgm( CBX9322 )                                  +
                Parm( &LibNam &ObjLvl &IncDat &SrtOrd )

     EndDo

 Return:
     Return

/*-- Resend system error messages:  ---------------------------------*/
 Error:
     Call       QMHMOVPM    ( '    '                            +
                              '*DIAG'                           +
                              x'00000001'                       +
                              '*PGMBDY'                         +
                              x'00000001'                       +
                              x'0000000800000000'               +
                            )

     Call       QMHRSNEM    ( '    '                            +
                              x'0000000800000000'               +
                            )

 EndPgm:
     EndPgm
