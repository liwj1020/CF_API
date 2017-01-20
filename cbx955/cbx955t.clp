/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX955T                                            */
/*  Description : Test the SCAN CL command.                          */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX955T )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm

     Dcl        &Pos        *Dec      3
     Dcl        &PosAlf     *Char     3


/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error


     Scan       String( 'This is a very simple SCAN test.' )    +
                Pattern( TEST )                                 +
                Translate( *YES )                               +
                Result( &Pos )

/*-- Variable &Pos now contains the string location of the pattern --*/

     ChgVar     &PosAlf    &Pos

     SndPgmMsg  Msg( 'Pattern found in position' *Bcat &PosAlf )    +
                ToPgmQ( *PRV )

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
