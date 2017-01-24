/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9071C                                           */
/*  Description : Process and print QHST log performance entries     */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Program description:                                             */
/*    This program lists all history log files to an outfile and     */
/*    subsequently calls, for each file, a program to process the    */
/*    log file records.                                              */
/*                                                                   */
/*    To ensure that all current history log records are forced      */
/*    to the history log file prior to processing it, a DSPLOG       */
/*    command is issued, specifying a fictitious message id. The     */
/*    resulting spooled file is deleted to avoid any confusion.      */
/*                                                                   */
/*    Initially the existence of the user space that the history     */
/*    log processing program uses to keep track of the files and     */
/*    records already processed is checked and, if necessary, the    */
/*    user space is created.                                         */
/*                                                                   */
/*    When all files have been processed the list program is         */
/*    called one last time to close the print file that is kept      */
/*    open between calls to allow the printed information to be      */
/*    written to the same spooled file.                              */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX9071C )                                     */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm
 
     Dcl        &PxUsrPrf    *Char     10    'KH101'
     Dcl        &PxNbrDays   *Char      3    '010'
 
/*-- Input file:  ---------------------------------------------------*/
     DclF       QAFDBASI
 
/*-- Global error monitor:  -----------------------------------------*/
     MonMsg     CPF0000      *N       GoTo Error
 
 
/*-- Check history log offset user space:  --*/
     ChkObj     *CURLIB/CBX9071U      *USRSPC
 
     MonMsg     CPF9801      *N       Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
 
     Call       QUSCRTUS    Parm( 'CBX9071U  *CURLIB   '             +
                                  'HSTLOG    '                       +
                                  x'00000021'                        +
                                  ' '                                +
                                  '*CHANGE   '                       +
                                  'History log offset'               +
                                )
     EndDo
 
/*-- Flush history log records:  --*/
 
     OvrPrtF    File( QPDSPLOG )  Hold( *YES )  Secure( *YES )
     DspLog     OutPut( *PRINT )  MsgId( QQQ0000 )
 
     DltSplF    File( QPDSPLOG )  SplNbr( *LAST )
     DltOvr     File( QPDSPLOG )
 
/*-- List history log files:  --*/
 
     DspFd      File( QSYS/QHST* )                                   +
                Type( *BASATR )                                      +
                OutPut( *OUTFILE )                                   +
                FileAtr( *PF )                                       +
                OutFile( QTEMP/QAFDBASI )
 
     OvrDbf     QAFDBASI     ToFile( QTEMP/QAFDBASI )
 
 RcvF:
     RcvF
     MonMsg     CPF0864      *N      GoTo EoF
 
     Call       CBX9071      Parm( &ATFILE  &PxUsrPrf  &PxNbrDays )
 
     GoTo       RcvF
 
 EoF:
     DltOvr     QAFDBASI
 
     Call       CBX9071
 
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
