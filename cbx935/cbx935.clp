/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX9351                                            */
/*  Description : Run job command - CPP                              */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX9351 )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*               Option( *NOSRCDBG )                                 */
/*               Log( *NO )                                          */
/*               AlwRtvSrc( *NO )                                    */
/*                                                                   */
/*    ChgPgm     Pgm( CBX9351 )                                      */
/*               RmvObs( *ALL )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &PxJobId  &PxCmdStr  &PxRqsTmo )

     Dcl        &PxJobId      *Char       26
     Dcl        &PxCmdStr     *Char     3002
     Dcl        &PxRqsTmo     *Dec         5

     Dcl        &JobNam       *Char       10
     Dcl        &UsrPrf       *Char       10
     Dcl        &JobNbr       *Char        6

     Dcl        &Dta          *Char     4096
     Dcl        &DtaLen       *Dec         5
     Dcl        &Key          *Char       26
     Dcl        &KeyLen       *Dec         3       26
     Dcl        &Snd          *Char        1
     Dcl        &SndLen       *Dec         3        0

     Dcl        &AutInd       *Char        1
     Dcl        &GetSrvJob    *Lgl

     Dcl        &XitPgmLib    *Char       10    'QGPL'
     Dcl        &DtaQ         *Char       10    'CBX935DQ'

     MonMsg     CPF0000       *N        GoTo Error


     RtvSpcAut  UsrPrf( *CURRENT )          +
                SpcAut( *ALLOBJ *JOBCTL )   +
                AutInd( &AutInd )

     If       ( &AutInd *NE 'Y' ) Do

     SndPgmMsg  MsgId( CPFB304 )       +
                MsgF( QCPFMSG )        +
                MsgType( *ESCAPE )
     EndDo

     ChgVar     &JobNam      %Sst( &PxJobId   1  10 )
     ChgVar     &UsrPrf      %Sst( &PxJobId  11  10 )
     ChgVar     &JobNbr      %Sst( &PxJobId  21   6 )

     If       ( &JobNbr    = ' ' )      Do

     ChgVar     &JobNbr      '*N'
     ChgVar     &GetSrvJob   '1'
     EndDo

     If       ( &UsrPrf    = ' ' )      Do

     ChgVar     &UsrPrf      '*N'
     ChgVar     &GetSrvJob   '1'
     EndDo

     ChkObj     &XitPgmLib/&DtaQ        *DTAQ
     MonMsg     CPF9801          *N     Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

     CrtDtaQ    &XitPgmLib/&DtaQ        +
                MaxLen( 4096 )          +
                Seq( *KEYED )           +
                KeyLen( 26 )            +
                AutoRcl( *YES )
     RcvMsg     MsgType( *LAST )  Rmv( *YES )
     EndDo

     StrSrvJob  Job( &JobNbr/&UsrPrf/&JobNam )

     If       ( &GetSrvJob = '1' )      Do

     SndPgmMsg  MsgId( CPF9897 )                           +
                MsgF( QCPFMSG )                            +
                MsgDta( 'Retrieving selected job ID.' )    +
                ToPgmQ( *EXT )                             +
                MsgType( *STATUS )

     Call       CBX9352      Parm( &PxJobId )

     ChgVar     &UsrPrf      %Sst( &PxJobId  11  10 )
     ChgVar     &JobNbr      %Sst( &PxJobId  21   6 )

     DltF       QTEMP/QATRCJOB
     MonMsg     CPF0000
     RcvMsg     MsgType( *LAST )        Rmv( *YES )
     EndDo

     ChgVar     &Key         &PxJobId
     ChgVar     &DtaLen      %Bin( &PxCmdStr  1  2 )
     ChgVar     &Dta         %Sst( &PxCmdStr  3  3000 )

     Call       QSNDDTAQ   ( &DtaQ          +
                             &XitPgmLib     +
                             &DtaLen        +
                             &Dta           +
                             &KeyLen        +
                             &Key           +
                           )

     TrcJob     Set( *ON )                                 +
                TrcType( *FLOW )                           +
                MaxStg( 1024 )                             +
                ExitPgm( &XitPgmLib/CBX9353 )              +
                SltPrc( *NONE )

     SndPgmMsg  MsgId( CPF9897 )                           +
                MsgF( QCPFMSG )                            +
                MsgDta( 'Running command, please wait.' )  +
                ToPgmQ( *EXT )                             +
                MsgType( *STATUS )

     ChgVar     &Key      ( 'RUNJOBCMD ' *Cat &UsrPrf *Cat &JobNbr )

     Call       QRCVDTAQ   ( &DtaQ          +
                             &XitPgmLib     +
                             &DtaLen        +
                             &Dta           +
                             &PxRqsTmo      +
                             'EQ'           +
                             &KeyLen        +
                             &Key           +
                             &SndLen        +
                             &Snd           +
                           )

     DlyJob     1

     TrcJob     Set( *END )

     EndSrvJob

     If        ( &DtaLen = 0 )         Do

     SndPgmMsg  Msg( 'Request timed out.' )                +
                ToPgmQ( *PRV )                             +
                MsgType( *COMP )
     EndDo
     Else Do

     ChgVar      &Dta       %Sst( &Dta  1  &DtaLen )

     If        ( &Dta    =  '0' )      Do

     SndPgmMsg  Msg( 'Command ran succesfully.' )          +
                ToPgmQ( *PRV )                             +
                MsgType( *COMP )
     EndDo
     Else Do

     SndPgmMsg  Msg( 'Command ended in error.' )           +
                ToPgmQ( *PRV )                             +
                MsgType( *COMP )
     EndDo
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
