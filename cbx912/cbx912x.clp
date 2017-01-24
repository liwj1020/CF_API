/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX912X                                            */
/*  Description : Delete journal receiver exit program - Test setup  */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX912X )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm
 
/*-- Global variables:  ---------------------------------------------*/
     Dcl        &CurLib      *Char    10
 
     MonMsg     CPF0000      *N       GoTo Error
 
 
     RtvJoba    CurLib( &CurLib )
     If       ( &CurLib  = '*NONE' )  ChgVar   &CurLib  'QGPL'
 
     CrtJrnRcv  &CurLib/CBXJRN0001    Threshold( 1000000 )
 
     CrtJrn     &CurLib/CBXJRN              +
                &CurLib/CBXJRN0001          +
                MngRcv( *System )           +
                RcvSizOpt( *MaxOpt2 )
 
     ChgJrn     &CurLib/CBXJRN              +
                JrnRcv( *GEN )
 
     ChgJrn     &CurLib/CBXJRN              +
                JrnRcv( *GEN )
 
     CrtSavF    QTEMP/CBXJRNRCV
 
     SavObj     CBXJRN0002                  +
                Lib( &CurLib )              +
                Dev( *SAVF )                +
                ObjType( *JRNRCV )          +
                SavF( QTEMP/CBXJRNRCV )
 
     DltF       QTEMP/CBXJRNRCV
 
     Call       QMHMOVPM    ( '    '                                 +
                              '*COMP'                                +
                              x'00000001'                            +
                              '*PGMBDY'                              +
                              x'00000001'                            +
                              x'0000000800000000'                    +
                            )
 
 Return:
     Return
 
/*-- Error handling:  -----------------------------------------------*/
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
