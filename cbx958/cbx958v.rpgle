000100041110     **
000200060728     **  Program . . : CBX958V
000300060623     **  Description : Work with NetServer user - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500041110     **
000600041110     **
000700041110     **  Program description:
000800060421     **    Validity checking program for user profile existence in case of
000900060623     **    specific user profile name.
001000050804     **
001100050804     **
001200031115     **  Compile options:
001300060728     **    CrtRpgMod Module( CBX958V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600060728     **    CrtPgm    Pgm( CBX958V )
001700060728     **              Module( CBX958V )
001800060728     **              BndSrvPgm( CBX958 )
001900060729     **              ActGrp( QILE )
002000031115     **
002100031115     **
002200040605     **-- Control specification:  --------------------------------------------**
002300050804     H Option( *SrcStmt )
002400040722
002500060421     **-- System information:
002600060421     D PgmSts         SDs                  Qualified
002700060421     D  PgmNam           *Proc
002800060421     D  CurJob                       10a   Overlay( PgmSts: 244 )
002900060421     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
003000060421     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003100060421     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003200040728     **-- API error data structure:
003300040728     D ERRC0100        Ds                  Qualified
003400040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003500040728     D  BytAvl                       10i 0
003600040728     D  ExcpId                        7a
003700040728     D                                1a
003800040728     D  ExcpDta                     512a
003900060407
004000060407     **-- Global constants:
004100060407     D ADP_PRV_INVLVL  c                   1
004200060407     **-- Global variables:
004300060407     D AutFlg          s              1a
004400060407     D SpcAut          s             10a   Dim( 8 )
004500050731
004600060407     **-- Check special authority
004700060407     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
004800060407     D  AutInf                        1a
004900060407     D  UsrPrf                       10a   Const
005000060407     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
005100060407     D  NbrAut                       10i 0 Const
005200060407     D  CalLvl                       10i 0 Const
005300060407     D  Error                     32767a          Options( *VarSize )
005400060623     **-- Retrieve object description:
005500060623     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
005600060623     D  RcvVar                    32767a          Options( *VarSize )
005700060623     D  RcvVarLen                    10i 0 Const
005800060623     D  FmtNam                        8a   Const
005900060623     D  ObjNamQ                      20a   Const
006000060623     D  ObjTyp                       10a   Const
006100060623     D  Error                     32767a          Options( *VarSize )
006200040728     **-- Send program message:
006300040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
006400050802     D  MsgId                         7a   Const
006500050802     D  MsgFq                        20a   Const
006600050802     D  MsgDta                      128a   Const
006700050802     D  MsgDtaLen                    10i 0 Const
006800050802     D  MsgTyp                       10a   Const
006900050802     D  CalStkE                      10a   Const  Options( *VarSize )
007000050802     D  CalStkCtr                    10i 0 Const
007100050802     D  MsgKey                        4a
007200050802     D  Error                      1024a          Options( *VarSize )
007300040722
007400060316     **-- Check object existence:
007500060316     D ChkObj          Pr              n
007600060316     D  PxObjNam                     10a   Const
007700060316     D  PxObjLib                     10a   Const
007800060316     D  PxObjTyp                     10a   Const
007900060401
008000040728     **-- Send diagnostic message:
008100040728     D SndDiagMsg      Pr            10i 0
008200040722     D  PxMsgId                       7a   Const
008300040722     D  PxMsgDta                    512a   Const  Varying
008400040728     **-- Send escape message:
008500040728     D SndEscMsg       Pr            10i 0
008600040728     D  PxMsgId                       7a   Const
008700040728     D  PxMsgDta                    512a   Const  Varying
008800040722
008900040722     **-- Entry parameters:
009000060728     D CBX958V         Pr
009100060316     D  PxUsrPrf                     10a
009200060729     D  PxStatus                     10a
009300060729     D  PxOutOpt                      3a
009400050731     **
009500060728     D CBX958V         Pi
009600060316     D  PxUsrPrf                     10a
009700060729     D  PxStatus                     10a
009800060729     D  PxOutOpt                      3a
009900040721
010000040724      /Free
010100060316
010200060730        SpcAut( 1 ) = '*IOSYSCFG';
010300060407
010400060407        ChkSpcAut( AutFlg
010500060407                 : PgmSts.UsrPrf
010600060407                 : SpcAut
010700060623                 : 1
010800060407                 : ADP_PRV_INVLVL
010900060407                 : ERRC0100
011000060407                 );
011100060407
011200060407        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
011300060407          SndDiagMsg( 'CPD0006'
011400060730                    : '0000Special authority *IOSYSCFG required.'
011500060407                    );
011600060407
011700060407          SndEscMsg( 'CPF0002': '' );
011800060407        EndIf;
011900060407
012000060623        If  %Scan( '*': PxUsrPrf ) = *Zero;
012100060421
012200060421          If  ChkObj( PxUsrPrf: '*LIBL': '*USRPRF' ) = *Off;
012300060421            SndDiagMsg( 'CPD0006'
012400060421                      : '0000User profile '   +
012500060421                         %Trim( PxUsrPrf )    +
012600060421                        ' does not exist.'
012700060421                      );
012800060421
012900060421            SndEscMsg( 'CPF0002': '' );
013000060421          EndIf;
013100060421        EndIf;
013200050408
013300040605        *InLr = *On;
013400040605        Return;
013500040605
013600040721      /End-Free
013700040721
013800060623     **-- Check object existence:  -------------------------------------------**
013900060623     P ChkObj          B                   Export
014000060623     D                 Pi              n
014100060623     D  PxObjNam                     10a   Const
014200060623     D  PxObjLib                     10a   Const
014300060623     D  PxObjTyp                     10a   Const
014400060623     **
014500060623     D OBJD0100        Ds                  Qualified
014600060623     D  BytRtn                       10i 0
014700060623     D  BytAvl                       10i 0
014800060623     D  ObjNam                       10a
014900060623     D  ObjLib                       10a
015000060623     D  ObjTyp                       10a
015100060623
015200060623      /Free
015300060623
015400060623         RtvObjD( OBJD0100
015500060623                : %Size( OBJD0100 )
015600060623                : 'OBJD0100'
015700060623                : PxObjNam + PxObjLib
015800060623                : PxObjTyp
015900060623                : ERRC0100
016000060623                );
016100060623
016200060623         If  ERRC0100.BytAvl > *Zero;
016300060623           Return  *Off;
016400060623
016500060623         Else;
016600060623           Return  *On;
016700060623         EndIf;
016800060623
016900060623      /End-Free
017000060623
017100060623     P ChkObj          E
017200060316     **-- Send diagnostic message:
017300040728     P SndDiagMsg      B
017400040722     D                 Pi            10i 0
017500040722     D  PxMsgId                       7a   Const
017600040722     D  PxMsgDta                    512a   Const  Varying
017700040722     **
017800040722     D MsgKey          s              4a
017900040722
018000040722      /Free
018100040722
018200040722        SndPgmMsg( PxMsgId
018300040722                 : 'QCPFMSG   *LIBL'
018400040722                 : PxMsgDta
018500040722                 : %Len( PxMsgDta )
018600040728                 : '*DIAG'
018700040722                 : '*PGMBDY'
018800040722                 : 1
018900040722                 : MsgKey
019000040722                 : ERRC0100
019100040722                 );
019200040722
019300040722        If  ERRC0100.BytAvl > *Zero;
019400040722          Return  -1;
019500040722
019600040722        Else;
019700040722          Return   0;
019800040722        EndIf;
019900040722
020000040722      /End-Free
020100040722
020200040728     P SndDiagMsg      E
020300060316     **-- Send escape message:
020400040728     P SndEscMsg       B
020500040728     D                 Pi            10i 0
020600040728     D  PxMsgId                       7a   Const
020700040728     D  PxMsgDta                    512a   Const  Varying
020800040728     **
020900040728     D MsgKey          s              4a
021000040728
021100040728      /Free
021200040728
021300040728        SndPgmMsg( PxMsgId
021400040728                 : 'QCPFMSG   *LIBL'
021500040728                 : PxMsgDta
021600040728                 : %Len( PxMsgDta )
021700040728                 : '*ESCAPE'
021800040728                 : '*PGMBDY'
021900040728                 : 1
022000040728                 : MsgKey
022100040728                 : ERRC0100
022200040728                 );
022300040728
022400040728        If  ERRC0100.BytAvl > *Zero;
022500040728          Return  -1;
022600040728
022700040728        Else;
022800040728          Return   0;
022900040728        EndIf;
023000040728
023100040728      /End-Free
023200040728
023300040728     P SndEscMsg       E
