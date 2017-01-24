/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX912C                                            */
/*  Description : Delete journal receiver exit program - Test        */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Program description:                                             */
/*                                                                   */
/*    To perform a test of the Delete journal receiver exit program  */
/*    the following steps should be taken:                           */
/*                                                                   */
/*    1. Compile and run the program CBX912X - this will create and  */
/*       setup the necessary test objects.                           */
/*                                                                   */
/*    2. Replace <jrnname> and <libname> in the CBX912 source member */
/*       by the journal name CBXJRN and the name of the library that */
/*       CBX912X created the test objects in.  CBX912X creates all   */
/*       objects in the current library of the job running it.  If   */
/*       no current library is available, library QGPL will be used. */
/*                                                                   */
/*    3. Compile program CBX912.                                     */
/*                                                                   */
/*    4. Register CBX912 as a Delete journal receiver exit program   */
/*       as described in the source header of CBX912.                */
/*                                                                   */
/*    5. Compile and run this program, and notice the resulting      */
/*       error messages, hopefully indicating that the deletion      */
/*       of the detached journal receivers of the CBXJRN receiver    */
/*       directory was prevented by the registered exit program.     */
/*                                                                   */
/*    6. To inspect the CBXJRN receiver directory run the command:   */
/*       WRKJRNA CBXJRN - then press F15.                            */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX912C )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm
 
     MonMsg     CPF0000      *N       GoTo Error
 
 
     DltJrnRcv  *CURLIB/CBXJRN*       +
                DltOpt( *IGNINQMSG )
     MonMsg     CPF2117
 
     Call       QMHMOVPM    ( '    '                                 +
                              '*DIAG     *ESCAPE'                    +
                              x'00000002'                            +
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
