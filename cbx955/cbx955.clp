/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX955                                             */
/*  Description : Scan string - CPP                                  */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX955 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &ChrStr           +
                &ChrPat           +
                &StrPos           +
                &TrnChr           +
                &Trim             +
                &WldChr           +
                &PatPos           +
              )

     Dcl        &ChrStr     *Char  1001
     Dcl        &ChrPat     *Char  1001
     Dcl        &StrPos     *Dec      3
     Dcl        &TrnChr     *Char     1
     Dcl        &Trim       *Char     1
     Dcl        &WldChr     *Char     1
     Dcl        &PatPos     *Dec      3

     Dcl        &StrLen     *Dec      3
     Dcl        &PatLen     *Dec      3
     Dcl        &ScnStr     *Char   999
     Dcl        &PatStr     *Char   999

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error


     ChgVar     &StrLen        %Bin( &ChrStr  1    2 )
     ChgVar     &ScnStr        %Sst( &ChrStr  3  999 )
     ChgVar     &PatLen        %Bin( &ChrPat  1    2 )
     ChgVar     &PatStr        %Sst( &ChrPat  3  999 )

     Call       QCLSCAN        Parm( &ScnStr                    +
                                     &StrLen                    +
                                     &StrPos                    +
                                     &PatStr                    +
                                     &PatLen                    +
                                     &TrnChr                    +
                                     &Trim                      +
                                     &WldChr                    +
                                     &PatPos                    +
                                   )

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
