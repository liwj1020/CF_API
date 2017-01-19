000100041110     **
000200041127     **  Program . . : CBX927V
000300041203     **  Description : Display attributes - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500041110     **
000600041110     **
000700041110     **  Program description:
000800041203     **    This program checks the existence of the specified IFS object.
000900031115     **
001000040724     **
001100031115     **  Compile options:
001200041127     **    CrtRpgMod Module( CBX927V )
001300040722     **              DbgView( *LIST )
001400031115     **
001500041127     **    CrtPgm    Pgm( CBX927V )
001600041127     **              Module( CBX927V )
001700041203     **              ActGrp( QILE )
001800031115     **
001900031115     **
002000040605     **-- Control specification:  --------------------------------------------**
002100041110     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002200040722
002300040728     **-- API error data structure:
002400040728     D ERRC0100        Ds                  Qualified
002500040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002600040728     D  BytAvl                       10i 0
002700040728     D  ExcpId                        7a
002800040728     D                                1a
002900040728     D  ExcpDta                     512a
003000040722     **-- Global variables:
003100040728     D addr            s             10u 0
003200041110     **-- access API constants:
003300041110     D F_OK            c                   0
003400041110     D X_OK            c                   1
003500041110     D W_OK            c                   2
003600041110     D R_OK            c                   4
003700040728
003800041110     **-- IFS file functions:
003900041110     D access          Pr            10i 0 ExtProc( 'access' )
004000041110     D   Path                          *   Value  Options( *String )
004100041110     D   Amode                       10i 0 Value
004200041110     **-- Error number:
004300041110     D sys_errno       Pr              *    ExtProc( '__errno' )
004400041110     **-- Error string:
004500041110     D sys_strerror    Pr              *    ExtProc( 'strerror' )
004600041110     D  errno                        10i 0  Value
004700040728     **-- Send program message:
004800040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004900040728     D  SpMsgId                       7a   Const
005000040728     D  SpMsgFq                      20a   Const
005100040728     D  SpMsgDta                    128a   Const
005200040728     D  SpMsgDtaLen                  10i 0 Const
005300040728     D  SpMsgTyp                     10a   Const
005400040728     D  SpCalStkE                    10a   Const  Options( *VarSize )
005500040728     D  SpCalStkCtr                  10i 0 Const
005600040728     D  SpMsgKey                      4a
005700040728     D  SpError                    1024a          Options( *VarSize )
005800040722
005900040728     **-- Send diagnostic message:
006000040728     D SndDiagMsg      Pr            10i 0
006100040722     D  PxMsgId                       7a   Const
006200040722     D  PxMsgDta                    512a   Const  Varying
006300040728     **-- Send escape message:
006400040728     D SndEscMsg       Pr            10i 0
006500040728     D  PxMsgId                       7a   Const
006600040728     D  PxMsgDta                    512a   Const  Varying
006700041110     **-- Error identification:
006800041110     D errno           Pr            10i 0
006900041110     D strerror        Pr           128a   Varying
007000040722
007100041127     D*-- Entry parameters:
007200041127     D CBX927V         Pr
007300041110     D  PxIfsObj                   5002a   Varying
007400041127     D  PxOutOpt                      3a
007500040722     **
007600041127     D CBX927V         Pi
007700041110     D  PxIfsObj                   5002a   Varying
007800041127     D  PxOutOpt                      3a
007900040721
008000040724      /Free
008100040728
008200041110        If  access( PxIfsObj: F_OK ) = -1;
008300040728
008400041110          SndDiagMsg( 'CPD0006': '0000' + %Char( errno ) + ': ' + strerror );
008500040728
008600041110          SndEscMsg( 'CPF0002': '' );
008700040605
008800041110        EndIf;
008900040728
009000040605        *InLr = *On;
009100040605
009200040605        Return;
009300040605
009400040605
009500040721      /End-Free
009600040721
009700041110     **-- Get runtime error number:  -----------------------------------------**
009800041110     P errno           B
009900041110     D                 Pi            10i 0
010000041110     **
010100041110     D Error           s             10i 0  Based( pError )  NoOpt
010200041110
010300041110      /Free
010400041110
010500041110        pError = sys_errno;
010600041110
010700041110        Return  Error;
010800041110
010900041110      /End-Free
011000041110
011100041110     P errno           E
011200041110     **-- Get runtime error text:  -------------------------------------------**
011300041110     P strerror        B
011400041110     D                 Pi           128a    Varying
011500041110
011600041110      /Free
011700041110
011800041110        Return  %Str( sys_strerror( errno ));
011900041110
012000041110      /End-Free
012100041110
012200041110     P strerror        E
012300040728     **-- Send diagnostic message:  ------------------------------------------**
012400040728     P SndDiagMsg      B
012500040722     D                 Pi            10i 0
012600040722     D  PxMsgId                       7a   Const
012700040722     D  PxMsgDta                    512a   Const  Varying
012800040722     **
012900040722     D MsgKey          s              4a
013000040722
013100040722      /Free
013200040722
013300040722        SndPgmMsg( PxMsgId
013400040722                 : 'QCPFMSG   *LIBL'
013500040722                 : PxMsgDta
013600040722                 : %Len( PxMsgDta )
013700040728                 : '*DIAG'
013800040722                 : '*PGMBDY'
013900040722                 : 1
014000040722                 : MsgKey
014100040722                 : ERRC0100
014200040722                 );
014300040722
014400040722        If  ERRC0100.BytAvl > *Zero;
014500040722          Return  -1;
014600040722
014700040722        Else;
014800040722          Return   0;
014900040722        EndIf;
015000040722
015100040722      /End-Free
015200040722
015300040728     P SndDiagMsg      E
015400040728     **-- Send escape message:  ----------------------------------------------**
015500040728     P SndEscMsg       B
015600040728     D                 Pi            10i 0
015700040728     D  PxMsgId                       7a   Const
015800040728     D  PxMsgDta                    512a   Const  Varying
015900040728     **
016000040728     D MsgKey          s              4a
016100040728
016200040728      /Free
016300040728
016400040728        SndPgmMsg( PxMsgId
016500040728                 : 'QCPFMSG   *LIBL'
016600040728                 : PxMsgDta
016700040728                 : %Len( PxMsgDta )
016800040728                 : '*ESCAPE'
016900040728                 : '*PGMBDY'
017000040728                 : 1
017100040728                 : MsgKey
017200040728                 : ERRC0100
017300040728                 );
017400040728
017500040728        If  ERRC0100.BytAvl > *Zero;
017600040728          Return  -1;
017700040728
017800040728        Else;
017900040728          Return   0;
018000040728        EndIf;
018100040728
018200040728      /End-Free
018300040728
018400040728     P SndEscMsg       E
