000100031115     **
000200040728     **  Program . . : CBX919V
000300040728     **  Description : Remove ARP table entry - VCP
000400031115     **  Author  . . : Carsten Flensburg
000500031115     **
000600031115     **
000700031115     **  Programmer's notes:
000800040722     **    To ensure a complete list *EXECUTE authority is required for the
000900040722     **    job queues involved.
001000031115     **
001100040724     **
001200031115     **  Compile options:
001300031115     **
001400040728     **    CrtRpgMod Module( CBX919V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700040728     **    CrtPgm    Pgm( CBX919V )
001800040728     **              Module( CBX919V )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200040728     H Option( *SrcStmt )
002300040722
002400040728     **-- API error data structure:
002500040728     D ERRC0100        Ds                  Qualified
002600040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002700040728     D  BytAvl                       10i 0
002800040728     D  ExcpId                        7a
002900040728     D                                1a
003000040728     D  ExcpDta                     512a
003100040722     **-- Global variables:
003200040728     D addr            s             10u 0
003300040728     **-- IP address values:
003400040728     D INADDR_NONE     c                   4294967295
003500040728
003600040728     **-- Convert an address from dotted-decimal format:
003700040728     D inet_addr       Pr            10u 0 ExtProc( 'inet_addr' )
003800040728     D  char_addr                      *   Value  Options( *String )
003900040728     **-- Send program message:
004000040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004100040728     D  SpMsgId                       7a   Const
004200040728     D  SpMsgFq                      20a   Const
004300040728     D  SpMsgDta                    128a   Const
004400040728     D  SpMsgDtaLen                  10i 0 Const
004500040728     D  SpMsgTyp                     10a   Const
004600040728     D  SpCalStkE                    10a   Const  Options( *VarSize )
004700040728     D  SpCalStkCtr                  10i 0 Const
004800040728     D  SpMsgKey                      4a
004900040728     D  SpError                    1024a          Options( *VarSize )
005000040722
005100040728     **-- Send diagnostic message:
005200040728     D SndDiagMsg      Pr            10i 0
005300040722     D  PxMsgId                       7a   Const
005400040722     D  PxMsgDta                    512a   Const  Varying
005500040728     **-- Send escape message:
005600040728     D SndEscMsg       Pr            10i 0
005700040728     D  PxMsgId                       7a   Const
005800040728     D  PxMsgDta                    512a   Const  Varying
005900040722
006000040722     **-- Entry parameters:
006100040728     D CBX919V         Pr
006200040728     D  PxLinNam                     10a
006300040728     D  PxIntNetAdr                  15a
006400040728     D  PxEntTyp                     10a
006500040722     **
006600040728     D CBX919V         Pi
006700040728     D  PxLinNam                     10a
006800040728     D  PxIntNetAdr                  15a
006900040728     D  PxEntTyp                     10a
007000040721
007100040724      /Free
007200040722
007300040728        If  PxIntNetAdr <> '255.255.255.255';
007400040728
007500040728          addr = inet_addr( %Trim( PxIntNetAdr ));
007600040728
007700040728          If  addr = INADDR_NONE;
007800040728
007900040728            SndDiagMsg( 'CPD0006'
008000040728                      : '0000' + 'Invalid internet address.'
008100040728                      );
008200040728
008300040728            SndEscMsg( 'CPF0002'
008400040728                     : ''
008500040728                     );
008600040605
008700040728          EndIf;
008800040728        EndIf;
008900040728
009000040605        *InLr = *On;
009100040605
009200040605        Return;
009300040605
009400040605
009500040721      /End-Free
009600040721
009700040728     **-- Send diagnostic message:  ------------------------------------------**
009800040728     P SndDiagMsg      B
009900040722     D                 Pi            10i 0
010000040722     D  PxMsgId                       7a   Const
010100040722     D  PxMsgDta                    512a   Const  Varying
010200040722     **
010300040722     D MsgKey          s              4a
010400040722
010500040722      /Free
010600040722
010700040722        SndPgmMsg( PxMsgId
010800040722                 : 'QCPFMSG   *LIBL'
010900040722                 : PxMsgDta
011000040722                 : %Len( PxMsgDta )
011100040728                 : '*DIAG'
011200040722                 : '*PGMBDY'
011300040722                 : 1
011400040722                 : MsgKey
011500040722                 : ERRC0100
011600040722                 );
011700040722
011800040722        If  ERRC0100.BytAvl > *Zero;
011900040722          Return  -1;
012000040722
012100040722        Else;
012200040722          Return   0;
012300040722        EndIf;
012400040722
012500040722      /End-Free
012600040722
012700040728     P SndDiagMsg      E
012800040728     **-- Send escape message:  ----------------------------------------------**
012900040728     P SndEscMsg       B
013000040728     D                 Pi            10i 0
013100040728     D  PxMsgId                       7a   Const
013200040728     D  PxMsgDta                    512a   Const  Varying
013300040728     **
013400040728     D MsgKey          s              4a
013500040728
013600040728      /Free
013700040728
013800040728        SndPgmMsg( PxMsgId
013900040728                 : 'QCPFMSG   *LIBL'
014000040728                 : PxMsgDta
014100040728                 : %Len( PxMsgDta )
014200040728                 : '*ESCAPE'
014300040728                 : '*PGMBDY'
014400040728                 : 1
014500040728                 : MsgKey
014600040728                 : ERRC0100
014700040728                 );
014800040728
014900040728        If  ERRC0100.BytAvl > *Zero;
015000040728          Return  -1;
015100040728
015200040728        Else;
015300040728          Return   0;
015400040728        EndIf;
015500040728
015600040728      /End-Free
015700040728
015800040728     P SndEscMsg       E
