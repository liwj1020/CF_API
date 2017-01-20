     Pgm      ( &JobId  &CmdStr )

     Dcl        &JobId        *Char       26
     Dcl        &JobName      *Char       10
     Dcl        &UsrName      *Char       10
     Dcl        &JobNbr       *Char        6
     Dcl        &CmdStr       *Char     1024

     Dcl        &Dta          *Char     4096
     Dcl        &DtaLen       *Dec         5     1024
     Dcl        &Key          *Char       26
     Dcl        &KeyLen       *Dec         3       26
     Dcl        &Snd          *Char        1
     Dcl        &SndLen       *Dec         3        0
     Dcl        &Wait         *Dec         5       25
     Dcl        &XitPgmLib    *Char       10    'QGPL'

     MonMsg     CPF0000       *N        GoTo Error

     ChgVar     &JobName     %Sst( &JobId   1  10 )
     ChgVar     &UsrName     %Sst( &JobId  11  10 )
     ChgVar     &JobNbr      %Sst( &JobId  21   6 )

     ChkObj     &XitPgmLib/TRC001DQ     *DTAQ
     MonMsg     CPF9801          *N     Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

     CrtDtaQ    &XitPgmLib/TRC001DQ     +
                MaxLen( 4096 )          +
                Seq( *KEYED )           +
                KeyLen( 26 )            +
                AutoRcl( *YES )
     RcvMsg     MsgType( *LAST )  Rmv( *YES )
     EndDo

     ChgVar     &Key         &JobId
     ChgVar     &Dta         &CmdStr

     Call       QSNDDTAQ   ( 'TRC001DQ'     +
                             &XitPgmLib     +
                             &DtaLen        +
                             &Dta           +
                             &KeyLen        +
                             &Key           +
                           )

     If      (( &JobNbr  > ' ' )  *And      +
              ( &JobName > ' ' ))      Do

     StrSrvJob  Job( &JobNbr/&UsrName/&JobName )
     EndDo
     Else If  ( &JobName > ' ' )       Do

     StrSrvJob  Job( &UsrName/&JobName )  DupJobOpt( *Select )
     EndDo
     Else Do

     StrSrvJob  Job( &JobName )  DupJobOpt( *Select )
     EndDo

     TrcJob     MaxStg( 1024 )  ExitPgm( QGPL/CBX9352 )

     ChgVar     &Key       ( 'RUNJOBCMD ' *Cat &UsrName *Cat &JobNbr )

     SndPgmMsg  MsgId( CPF9897 )                                  +
                MsgF( QCPFMSG )                                   +
                MsgDta( 'Running command, please wait.' )         +
                ToPgmQ( *EXT )                                    +
                MsgType( *STATUS )

     Call       QRCVDTAQ   ( 'TRC001DQ'     +
                             'QGPL'         +
                             &DtaLen        +
                             &Dta           +
                             &Wait          +
                             'EQ'           +
                             &KeyLen        +
                             &Key           +
                             &SndLen        +
                             &Snd           +
                           )

     DlyJob     1

     TrcJob     Set( *END )  MaxStg( 1024 )

     EndSrvJob

     ChgVar      &Dta       %Sst( &Dta  1  &DtaLen )

     If        ( &Dta    =  '0' )      Do

     SndPgmMsg  Msg( 'Command ran succesfully.' )                 +
                ToPgmQ( *PRV )                                    +
                MsgType( *COMP )
     EndDo
     Else Do

     SndPgmMsg  Msg( 'Command ended in error.' )                  +
                ToPgmQ( *PRV )                                    +
                MsgType( *COMP )
     EndDo

     GoTo        EndPgm

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
