000100031115     **
000200040731     **  Program . . : CBX919
000300040731     **  Description : Remove ARP table entry - CPP
000400031115     **  Author  . . : Carsten Flensburg
000500031115     **
000600040724     **
000700031115     **  Compile options:
000800031115     **
000900040728     **    CrtRpgMod Module( CBX919 )
001000040722     **              DbgView( *LIST )
001100031115     **
001200040728     **    CrtPgm    Pgm( CBX919 )
001300040728     **              Module( CBX919 )
001400031115     **
001500031115     **
001600040605     **-- Control specification:  --------------------------------------------**
001700020723     H Option( *SrcStmt )
001800040722
001900040605     **-- API error data structure:
002000040721     D ERRC0100        Ds                  Qualified
002100040721     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002200040721     D  BytAvl                       10i 0
002300040728     D  MsgId                         7a
002400040728     D   MsgPfx                       3a   Overlay( MsgId: 1 )
002500990921     D                                1a
002600040728     D  MsgDta                      512a
002700040728     **-- Global variables:
002800040728     D ErrHdrLen       s             10i 0 Inz( 16 )
002900040728     D ErrMsgF         s             10a   Inz( 'QCPFMSG' )
003000040722
003100040728     **-- Convert an address from dotted-decimal format:
003200040728     D inet_addr       Pr            10u 0 ExtProc( 'inet_addr' )
003300040728     D  char_addr                      *   Value  Options( *String )
003400040721     **-- Open list of job queues:
003500040728     D RmvArpTblE      Pr                  ExtProc( 'QtocRmvARPTblE' )
003600040728     D  RaLinNam                     10a   Const
003700040728     D  RaIntNetAdr                  10u 0 Const
003800040728     D  RaEntTyp                     10a   Const
003900040728     D  RaError                    1024a          Options( *VarSize )
004000040605     **-- Send program message:
004100031113     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004200031113     D  SpMsgId                       7a   Const
004300031113     D  SpMsgFq                      20a   Const
004400031113     D  SpMsgDta                    128a   Const
004500031113     D  SpMsgDtaLen                  10i 0 Const
004600031113     D  SpMsgTyp                     10a   Const
004700031115     D  SpCalStkE                    10a   Const  Options( *VarSize )
004800031113     D  SpCalStkCtr                  10i 0 Const
004900031113     D  SpMsgKey                      4a
005000040721     D  SpError                    1024a          Options( *VarSize )
005100040722
005200040722     **-- Send escape message:
005300040722     D SndEscMsg       Pr            10i 0
005400040722     D  PxMsgId                       7a   Const
005500040728     D  PxMsgF                       10a   Const
005600040722     D  PxMsgDta                    512a   Const  Varying
005700040728     **-- Send completion message:
005800040728     D SndCmpMsg       Pr            10i 0
005900040728     D  PxMsgDta                    512a   Const  Varying
006000040722
006100040722     **-- Entry parameters:
006200040728     D CBX919          Pr
006300040728     D  PxLinNam                     10a
006400040728     D  PxIntNetAdr                  15a
006500040728     D  PxEntTyp                     10a
006600040728     **
006700040728     D CBX919          Pi
006800040728     D  PxLinNam                     10a
006900040728     D  PxIntNetAdr                  15a
007000040728     D  PxEntTyp                     10a
007100040721
007200040724      /Free
007300040728
007400040728        RmvArpTblE( PxLinNam
007500040728                  : inet_addr( %Trim( PxIntNetAdr ))
007600040728                  : PxEntTyp
007700040728                  : ERRC0100
007800040728                  );
007900040605
008000040722        If  ERRC0100.BytAvl  > *Zero;
008100040728
008200040728          If  ERRC0100.BytAvl  < 16;
008300040728            ErrHdrLen = ERRC0100.BytAvl;
008400040728          EndIf;
008500040728
008600040728          If  ERRC0100.MsgPfx  = 'TCP';
008700040728            ErrMsgF   = 'QTCPMSG';
008800040728          EndIf;
008900040728
009000040728          SndEscMsg( ERRC0100.MsgId
009100040728                   : ErrMsgF
009200040728                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - ErrHdrLen )
009300040728                   );
009400040728
009500040722        Else;
009600040722
009700040728          SndCmpMsg( 'ARP table entry '   +
009800040728                      %TrimR( PxEntTyp )  +
009900040728                     ' has been removed.'
010000040728                   );
010100040728
010200040728        EndIf;
010300040605
010400040605        *InLr = *On;
010500040605
010600040605        Return;
010700040605
010800040721      /End-Free
010900040721
011000040722     **-- Send escape message:  ----------------------------------------------**
011100040722     P SndEscMsg       B
011200040722     D                 Pi            10i 0
011300040722     D  PxMsgId                       7a   Const
011400040728     D  PxMsgF                       10a   Const
011500040722     D  PxMsgDta                    512a   Const  Varying
011600040722     **
011700040722     D MsgKey          s              4a
011800040722
011900040722      /Free
012000040722
012100040722        SndPgmMsg( PxMsgId
012200040728                 : PxMsgF + '*LIBL'
012300040722                 : PxMsgDta
012400040722                 : %Len( PxMsgDta )
012500040722                 : '*ESCAPE'
012600040722                 : '*PGMBDY'
012700040722                 : 1
012800040722                 : MsgKey
012900040722                 : ERRC0100
013000040722                 );
013100040722
013200040722        If  ERRC0100.BytAvl > *Zero;
013300040722          Return  -1;
013400040722
013500040722        Else;
013600040722          Return   0;
013700040722        EndIf;
013800040722
013900040722      /End-Free
014000040722
014100040722     P SndEscMsg       E
014200040728     **-- Send completion message:  ------------------------------------------**
014300040728     P SndCmpMsg       B
014400040728     D                 Pi            10i 0
014500040728     D  PxMsgDta                    512a   Const  Varying
014600040728     **
014700040728     D MsgKey          s              4a
014800040728
014900040728      /Free
015000040728
015100040728        SndPgmMsg( 'CPF9897'
015200040728                 : 'QCPFMSG   *LIBL'
015300040728                 : PxMsgDta
015400040728                 : %Len( PxMsgDta )
015500040729                 : '*COMP'
015600040728                 : '*PGMBDY'
015700040728                 : 1
015800040728                 : MsgKey
015900040728                 : ERRC0100
016000040728                 );
016100040728
016200040728        If  ERRC0100.BytAvl > *Zero;
016300040728          Return  -1;
016400040728
016500040728        Else;
016600040728          Return   0;
016700040728        EndIf;
016800040728
016900040728      /End-Free
017000040728
017100040728     P SndCmpMsg       E
