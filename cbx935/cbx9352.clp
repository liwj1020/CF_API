/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9352                                            */
/*  Description : Get serviced job ID                                */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9352 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &JobId )

     Dcl        &JobId        *Char       26

     DclF       QATRCJOB      AlwVarLen( *YES )


     MonMsg     CPF0000       *N        GoTo Error


     TrcJob     Set( *ON )                                 +
                TrcType( *FLOW )                           +
                MaxStg( 1024 )                             +
                SltPrc( *NONE )

     TrcJob     Set( *OFF )                 +
                OutPut( *OUTFILE )          +
                OutFile( QTEMP/QATRCJOB )

     RcvMsg     MsgType( *LAST )        Rmv( *YES )
     RcvMsg     MsgType( *LAST )        Rmv( *YES )

     OvrDbf     QATRCJOB                    +
                ToFile( QTEMP/QATRCJOB )    +
                OvrScope( *CALLLVL )

     RcvF
     MonMsg     CPF0864       *N        GoTo EoF

     If      (( &SCFUNC  =  5 )    *And     +
              ( &SCSTYP  =  1 ))        Do

     ChgVar     &JobId      ( &SCFLD1 *Cat &SCFLD2 *CAT &SCFLD3 )

     GoTo       Return
     EndDo

EoF:
     ChgVar     &JobId        '*NONE'

Return:
     DltOvr     QATRCJOB      Lvl( * )

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
