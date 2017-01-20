     **
     **  Program . . : CBX919V
     **  Description : Remove ARP table entry - VCP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Programmer's notes:
     **    To ensure a complete list *EXECUTE authority is required for the
     **    job queues involved.
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX919V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX919V )
     **              Module( CBX919V )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  ExcpId                        7a
     D                                1a
     D  ExcpDta                     512a
     **-- Global variables:
     D addr            s             10u 0
     **-- IP address values:
     D INADDR_NONE     c                   4294967295

     **-- Convert an address from dotted-decimal format:
     D inet_addr       Pr            10u 0 ExtProc( 'inet_addr' )
     D  char_addr                      *   Value  Options( *String )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                    1024a          Options( *VarSize )

     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX919V         Pr
     D  PxLinNam                     10a
     D  PxIntNetAdr                  15a
     D  PxEntTyp                     10a
     **
     D CBX919V         Pi
     D  PxLinNam                     10a
     D  PxIntNetAdr                  15a
     D  PxEntTyp                     10a

      /Free

        If  PxIntNetAdr <> '255.255.255.255';

          addr = inet_addr( %Trim( PxIntNetAdr ));

          If  addr = INADDR_NONE;

            SndDiagMsg( 'CPD0006'
                      : '0000' + 'Invalid internet address.'
                      );

            SndEscMsg( 'CPF0002'
                     : ''
                     );

          EndIf;
        EndIf;

        *InLr = *On;

        Return;


      /End-Free

     **-- Send diagnostic message:  ------------------------------------------**
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*DIAG'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndDiagMsg      E
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
