000100050320/*-------------------------------------------------------------------*/
000200050320/*                                                                   */
000300050320/*  Program . . : CBX9351                                            */
000400050320/*  Description : Run job command - CPP                              */
000500050320/*  Author  . . : Carsten Flensburg                                  */
000600050320/*                                                                   */
000700050320/*                                                                   */
000800050320/*  Compile options:                                                 */
000900050320/*                                                                   */
001000050320/*    CrtClPgm   Pgm( CBX9351 )                                      */
001100050320/*               SrcFile( QCLSRC )                                   */
001200050320/*               SrcMbr( *PGM )                                      */
001300050320/*               Option( *NOSRCDBG )                                 */
001400050320/*               Log( *NO )                                          */
001500050320/*               AlwRtvSrc( *NO )                                    */
001600050320/*                                                                   */
001700050320/*    ChgPgm     Pgm( CBX9351 )                                      */
001800050320/*               RmvObs( *ALL )                                      */
001900050320/*                                                                   */
002000050320/*-------------------------------------------------------------------*/
002100050322     Pgm      ( &PxJobId  &PxCmdStr  &PxRqsTmo )
002200021113
002300050322     Dcl        &PxJobId      *Char       26
002400050322     Dcl        &PxCmdStr     *Char     3002
002500050322     Dcl        &PxRqsTmo     *Dec         5
002600050322
002700050320     Dcl        &JobNam       *Char       10
002800050320     Dcl        &UsrPrf       *Char       10
002900021113     Dcl        &JobNbr       *Char        6
003000000000
003100021114     Dcl        &Dta          *Char     4096
003200050320     Dcl        &DtaLen       *Dec         5
003300050301     Dcl        &Key          *Char       26
003400050301     Dcl        &KeyLen       *Dec         3       26
003500021113     Dcl        &Snd          *Char        1
003600050301     Dcl        &SndLen       *Dec         3        0
003700050320
003800050321     Dcl        &AutInd       *Char        1
003900050322     Dcl        &GetSrvJob    *Lgl
004000050321
004100050301     Dcl        &XitPgmLib    *Char       10    'QGPL'
004200050320     Dcl        &DtaQ         *Char       10    'CBX935DQ'
004300021113
004400050314     MonMsg     CPF0000       *N        GoTo Error
004500050321
004600050322
004700050322     RtvSpcAut  UsrPrf( *CURRENT )          +
004800050322                SpcAut( *ALLOBJ *JOBCTL )   +
004900050321                AutInd( &AutInd )
005000050321
005100050321     If       ( &AutInd *NE 'Y' ) Do
005200050321
005300050324     SndPgmMsg  MsgId( CPFB304 )       +
005400050321                MsgF( QCPFMSG )        +
005500050321                MsgType( *ESCAPE )
005600050321     EndDo
005700000000
005800050322     ChgVar     &JobNam      %Sst( &PxJobId   1  10 )
005900050322     ChgVar     &UsrPrf      %Sst( &PxJobId  11  10 )
006000050322     ChgVar     &JobNbr      %Sst( &PxJobId  21   6 )
006100050320
006200050322     If       ( &JobNbr    = ' ' )      Do
006300050322
006400050322     ChgVar     &JobNbr      '*N'
006500050322     ChgVar     &GetSrvJob   '1'
006600050322     EndDo
006700050322
006800050322     If       ( &UsrPrf    = ' ' )      Do
006900050324
007000050322     ChgVar     &UsrPrf      '*N'
007100050322     ChgVar     &GetSrvJob   '1'
007200050322     EndDo
007300021114
007400050320     ChkObj     &XitPgmLib/&DtaQ        *DTAQ
007500021114     MonMsg     CPF9801          *N     Do
007600021114     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
007700021114
007800050320     CrtDtaQ    &XitPgmLib/&DtaQ        +
007900050301                MaxLen( 4096 )          +
008000050301                Seq( *KEYED )           +
008100050301                KeyLen( 26 )            +
008200021114                AutoRcl( *YES )
008300021114     RcvMsg     MsgType( *LAST )  Rmv( *YES )
008400021114     EndDo
008500021114
008600050322     StrSrvJob  Job( &JobNbr/&UsrPrf/&JobNam )
008700050322
008800050322     If       ( &GetSrvJob = '1' )      Do
008900050324
009000050324     SndPgmMsg  MsgId( CPF9897 )                           +
009100050324                MsgF( QCPFMSG )                            +
009200050324                MsgDta( 'Retrieving selected job ID.' )    +
009300050324                ToPgmQ( *EXT )                             +
009400050324                MsgType( *STATUS )
009500050322
009600050322     Call       CBX9352      Parm( &PxJobId )
009700050322
009800050322     ChgVar     &UsrPrf      %Sst( &PxJobId  11  10 )
009900050322     ChgVar     &JobNbr      %Sst( &PxJobId  21   6 )
010000050324
010100050324     DltF       QTEMP/QATRCJOB
010200050324     MonMsg     CPF0000
010300050324     RcvMsg     MsgType( *LAST )        Rmv( *YES )
010400050322     EndDo
010500050324
010600050322     ChgVar     &Key         &PxJobId
010700050322     ChgVar     &DtaLen      %Bin( &PxCmdStr  1  2 )
010800050322     ChgVar     &Dta         %Sst( &PxCmdStr  3  3000 )
010900000000
011000050320     Call       QSNDDTAQ   ( &DtaQ          +
011100050301                             &XitPgmLib     +
011200021113                             &DtaLen        +
011300021113                             &Dta           +
011400021113                             &KeyLen        +
011500021113                             &Key           +
011600021113                           )
011700021114
011800050324     TrcJob     Set( *ON )                                 +
011900050324                TrcType( *FLOW )                           +
012000050324                MaxStg( 1024 )                             +
012100050324                ExitPgm( &XitPgmLib/CBX9353 )              +
012200050324                SltPrc( *NONE )
012300021113
012400050324     SndPgmMsg  MsgId( CPF9897 )                           +
012500050324                MsgF( QCPFMSG )                            +
012600050324                MsgDta( 'Running command, please wait.' )  +
012700050324                ToPgmQ( *EXT )                             +
012800050301                MsgType( *STATUS )
012900050301
013000050322     ChgVar     &Key      ( 'RUNJOBCMD ' *Cat &UsrPrf *Cat &JobNbr )
013100050322
013200050320     Call       QRCVDTAQ   ( &DtaQ          +
013300050320                             &XitPgmLib     +
013400021113                             &DtaLen        +
013500021113                             &Dta           +
013600050322                             &PxRqsTmo      +
013700021113                             'EQ'           +
013800021113                             &KeyLen        +
013900021113                             &Key           +
014000021113                             &SndLen        +
014100021113                             &Snd           +
014200021114                           )
014300030528
014400050324     DlyJob     1
014500021114
014600050324     TrcJob     Set( *END )
014700050301
014800021113     EndSrvJob
014900000000
015000050320     If        ( &DtaLen = 0 )         Do
015100050320
015200050324     SndPgmMsg  Msg( 'Request timed out.' )                +
015300050324                ToPgmQ( *PRV )                             +
015400050320                MsgType( *COMP )
015500050320     EndDo
015600050320     Else Do
015700050320
015800021114     ChgVar      &Dta       %Sst( &Dta  1  &DtaLen )
015900050314
016000050301     If        ( &Dta    =  '0' )      Do
016100021114
016200050324     SndPgmMsg  Msg( 'Command ran succesfully.' )          +
016300050324                ToPgmQ( *PRV )                             +
016400021114                MsgType( *COMP )
016500021114     EndDo
016600050301     Else Do
016700050301
016800050324     SndPgmMsg  Msg( 'Command ended in error.' )           +
016900050324                ToPgmQ( *PRV )                             +
017000050301                MsgType( *COMP )
017100050301     EndDo
017200050320     EndDo
017300050301
017400050320Return:
017500050320     Return
017600021114
017700021114Error:
017800050301     Call       QMHMOVPM    ( '    '                  +
017900050301                              '*DIAG'                 +
018000050301                              x'00000001'             +
018100050301                              '*PGMBDY'               +
018200050301                              x'00000001'             +
018300050301                              x'0000000800000000'     +
018400050301                            )
018500050301
018600050301     Call       QMHRSNEM    ( '    '                  +
018700050301                              x'0000000800000000'     +
018800050301                            )
018900021113EndPgm:
019000021113     EndPgm
