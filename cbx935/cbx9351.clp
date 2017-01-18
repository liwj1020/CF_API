000100021114     Pgm      ( &JobId  &CmdStr )
000200021113
000300021114     Dcl        &JobId        *Char       26
000400021113     Dcl        &JobName      *Char       10
000500021113     Dcl        &UsrName      *Char       10
000600021113     Dcl        &JobNbr       *Char        6
000700021114     Dcl        &CmdStr       *Char     1024
000800000000
000900021114     Dcl        &Dta          *Char     4096
001000050301     Dcl        &DtaLen       *Dec         5     1024
001100050301     Dcl        &Key          *Char       26
001200050301     Dcl        &KeyLen       *Dec         3       26
001300021113     Dcl        &Snd          *Char        1
001400050301     Dcl        &SndLen       *Dec         3        0
001500050301     Dcl        &Wait         *Dec         5       25
001600050301     Dcl        &XitPgmLib    *Char       10    'QGPL'
001700021113
001800050314     MonMsg     CPF0000       *N        GoTo Error
001900000000
002000021114     ChgVar     &JobName     %Sst( &JobId   1  10 )
002100021114     ChgVar     &UsrName     %Sst( &JobId  11  10 )
002200021114     ChgVar     &JobNbr      %Sst( &JobId  21   6 )
002300021114
002400050301     ChkObj     &XitPgmLib/TRC001DQ     *DTAQ
002500021114     MonMsg     CPF9801          *N     Do
002600021114     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
002700021114
002800050301     CrtDtaQ    &XitPgmLib/TRC001DQ     +
002900050301                MaxLen( 4096 )          +
003000050301                Seq( *KEYED )           +
003100050301                KeyLen( 26 )            +
003200021114                AutoRcl( *YES )
003300021114     RcvMsg     MsgType( *LAST )  Rmv( *YES )
003400021114     EndDo
003500021114
003600050301     ChgVar     &Key         &JobId
003700021114     ChgVar     &Dta         &CmdStr
003800000000
003900021113     Call       QSNDDTAQ   ( 'TRC001DQ'     +
004000050301                             &XitPgmLib     +
004100021113                             &DtaLen        +
004200021113                             &Dta           +
004300021113                             &KeyLen        +
004400021113                             &Key           +
004500021113                           )
004600021113
004700050320     If      (( &JobNbr  > ' ' )  *And      +
004800050320              ( &JobName > ' ' ))      Do
004900050320
005000021113     StrSrvJob  Job( &JobNbr/&UsrName/&JobName )
005100050320     EndDo
005200050320     Else If  ( &JobName > ' ' )       Do
005300050320
005400050320     StrSrvJob  Job( &UsrName/&JobName )  DupJobOpt( *Select )
005500050320     EndDo
005600050320     Else Do
005700050320
005800050320     StrSrvJob  Job( &JobName )  DupJobOpt( *Select )
005900050320     EndDo
006000021114
006100050301     TrcJob     MaxStg( 1024 )  ExitPgm( QGPL/CBX9352 )
006200000000
006300021113     ChgVar     &Key       ( 'RUNJOBCMD ' *Cat &UsrName *Cat &JobNbr )
006400021113
006500050301     SndPgmMsg  MsgId( CPF9897 )                                  +
006600050301                MsgF( QCPFMSG )                                   +
006700050301                MsgDta( 'Running command, please wait.' )         +
006800050301                ToPgmQ( *EXT )                                    +
006900050301                MsgType( *STATUS )
007000050301
007100021113     Call       QRCVDTAQ   ( 'TRC001DQ'     +
007200021113                             'QGPL'         +
007300021113                             &DtaLen        +
007400021113                             &Dta           +
007500021113                             &Wait          +
007600021113                             'EQ'           +
007700021113                             &KeyLen        +
007800021113                             &Key           +
007900021113                             &SndLen        +
008000021113                             &Snd           +
008100021114                           )
008200030528
008300050301     DlyJob     1
008400021114
008500021113     TrcJob     Set( *END )  MaxStg( 1024 )
008600050301
008700021113     EndSrvJob
008800000000
008900021114     ChgVar      &Dta       %Sst( &Dta  1  &DtaLen )
009000050314
009100050301     If        ( &Dta    =  '0' )      Do
009200021114
009300021114     SndPgmMsg  Msg( 'Command ran succesfully.' )                 +
009400021114                ToPgmQ( *PRV )                                    +
009500021114                MsgType( *COMP )
009600021114     EndDo
009700050301     Else Do
009800050301
009900050301     SndPgmMsg  Msg( 'Command ended in error.' )                  +
010000050301                ToPgmQ( *PRV )                                    +
010100050301                MsgType( *COMP )
010200050301     EndDo
010300050301
010400021114     GoTo        EndPgm
010500021114
010600021114Error:
010700050301     Call       QMHMOVPM    ( '    '                  +
010800050301                              '*DIAG'                 +
010900050301                              x'00000001'             +
011000050301                              '*PGMBDY'               +
011100050301                              x'00000001'             +
011200050301                              x'0000000800000000'     +
011300050301                            )
011400050301
011500050301     Call       QMHRSNEM    ( '    '                  +
011600050301                              x'0000000800000000'     +
011700050301                            )
011800050301
011900021114
012000021113EndPgm:
012100021113     EndPgm
