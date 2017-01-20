/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX924                                             */
/*  Description : Display software inventory - initial CPP           */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  The main CPP, the QSFWINV program is documented here:            */
/*             http://publib.boulder.ibm.com/iseries/v5r1/ic2924/    */
/*                    tstudio/tech_ref/invtool/index.htm             */
/*                                                                   */
/*  V4R4 PTF:  SF55269                                               */
/*      APAR:  http://www-912.ibm.com/n_dir/nas4apar.nsf/            */
/*                    c79815e083182fec862564c00079d117/              */
/*                    64c226fdc56df0128625673e0035e8c6?OpenDocument  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX924 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm        &PxOutput

/*- Parameter:  -----------------------------------------------------*/
     Dcl        &PxOutput     *Char    1


/*- Global error monitor:  ------------------------------------------*/
     MonMsg     CPF0000       *N       GoTo  Error


     If       ( &PxOutput = 'P' )      Do

     Call       QSFWINV     '*PRINT'

     SndPgmMsg  Msg( 'Software inventory list has been printed.' ) +
                MsgType( *COMP )
     EndDo
     Else Do

     Call       QSFWINV
     EndDo


Return:
     Return

/*- Error handling:  ------------------------------------------------*/
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
