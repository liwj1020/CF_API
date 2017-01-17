000100041110     **
000200060623     **  Program . . : CBX957V
000300060624     **  Description : Change NetServer user - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500041110     **
000600041110     **
000700041110     **  Program description:
000800060624     **    Validity checking program for user profile existence.
000900050804     **
001000050804     **
001100031115     **  Compile options:
001200060623     **    CrtRpgMod Module( CBX957V )
001300040722     **              DbgView( *LIST )
001400031115     **
001500060624     **    CrtPgm    Pgm( CBX957V )
001600060624     **              Module( CBX957V )
001700060624     **              ActGrp( *CALLER )
001800031115     **
001900031115     **
002000040605     **-- Control specification:  --------------------------------------------**
002100050804     H Option( *SrcStmt )
002200040722
002300060421     **-- System information:
002400060421     D PgmSts         SDs                  Qualified
002500060421     D  PgmNam           *Proc
002600060421     D  CurJob                       10a   Overlay( PgmSts: 244 )
002700060421     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002800060421     D  JobNbr                        6a   Overlay( PgmSts: 264 )
002900060421     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003000040728     **-- API error data structure:
003100040728     D ERRC0100        Ds                  Qualified
003200040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003300040728     D  BytAvl                       10i 0
003400040728     D  ExcpId                        7a
003500040728     D                                1a
003600040728     D  ExcpDta                     512a
003700060407
003800060407     **-- Global constants:
003900060407     D ADP_PRV_INVLVL  c                   1
004000060407     **-- Global variables:
004100060407     D AutFlg          s              1a
004200060407     D SpcAut          s             10a   Dim( 8 )
004300050731
004400060407     **-- Check special authority
004500060407     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
004600060407     D  AutInf                        1a
004700060407     D  UsrPrf                       10a   Const
004800060407     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
004900060407     D  NbrAut                       10i 0 Const
005000060407     D  CalLvl                       10i 0 Const
005100060407     D  Error                     32767a          Options( *VarSize )
005200060623     **-- Retrieve object description:
005300060623     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
005400060623     D  RcvVar                    32767a          Options( *VarSize )
005500060623     D  RcvVarLen                    10i 0 Const
005600060623     D  FmtNam                        8a   Const
005700060623     D  ObjNamQ                      20a   Const
005800060623     D  ObjTyp                       10a   Const
005900060623     D  Error                     32767a          Options( *VarSize )
006000040728     **-- Send program message:
006100040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
006200050802     D  MsgId                         7a   Const
006300050802     D  MsgFq                        20a   Const
006400050802     D  MsgDta                      128a   Const
006500050802     D  MsgDtaLen                    10i 0 Const
006600050802     D  MsgTyp                       10a   Const
006700050802     D  CalStkE                      10a   Const  Options( *VarSize )
006800050802     D  CalStkCtr                    10i 0 Const
006900050802     D  MsgKey                        4a
007000050802     D  Error                      1024a          Options( *VarSize )
007100040722
007200060316     **-- Check object existence:
007300060316     D ChkObj          Pr              n
007400060316     D  PxObjNam                     10a   Const
007500060316     D  PxObjLib                     10a   Const
007600060316     D  PxObjTyp                     10a   Const
007700060401
007800040728     **-- Send diagnostic message:
007900040728     D SndDiagMsg      Pr            10i 0
008000040722     D  PxMsgId                       7a   Const
008100040722     D  PxMsgDta                    512a   Const  Varying
008200040728     **-- Send escape message:
008300040728     D SndEscMsg       Pr            10i 0
008400040728     D  PxMsgId                       7a   Const
008500040728     D  PxMsgDta                    512a   Const  Varying
008600040722
008700040722     **-- Entry parameters:
008800060623     D CBX957V         Pr
008900060624     D  PxUsrPrf                     10a   Varying
009000060623     D  PxStatus                      1a
009100050731     **
009200060623     D CBX957V         Pi
009300060624     D  PxUsrPrf                     10a   Varying
009400060623     D  PxStatus                      1a
009500040721
009600040724      /Free
009700060316
009800060624        SpcAut( 1 ) = '*SECADM';
009900060624        SpcAut( 2 ) = '*IOSYSCFG';
010000060407
010100060407        ChkSpcAut( AutFlg
010200060407                 : PgmSts.UsrPrf
010300060407                 : SpcAut
010400060624                 : 2
010500060407                 : ADP_PRV_INVLVL
010600060407                 : ERRC0100
010700060407                 );
010800060407
010900060407        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
011000060407          SndDiagMsg( 'CPD0006'
011100060624                    : '0000Special authority *SECADM and *IOSYSCFG required.'
011200060407                    );
011300060407
011400060407          SndEscMsg( 'CPF0002': '' );
011500060407        EndIf;
011600060407
011700060624
011800060624        If  ChkObj( PxUsrPrf: '*LIBL': '*USRPRF' ) = *Off;
011900060624          SndDiagMsg( 'CPD0006'
012000060624                    : '0000User profile '   +
012100060624                       %Trim( PxUsrPrf )    +
012200060624                      ' does not exist.'
012300060624                    );
012400060624
012500060624          SndEscMsg( 'CPF0002': '' );
012600060624        EndIf;
012700050408
012800040605        *InLr = *On;
012900040605        Return;
013000040605
013100040721      /End-Free
013200040721
013300060623     **-- Check object existence:  -------------------------------------------**
013400060623     P ChkObj          B                   Export
013500060623     D                 Pi              n
013600060623     D  PxObjNam                     10a   Const
013700060623     D  PxObjLib                     10a   Const
013800060623     D  PxObjTyp                     10a   Const
013900060623     **
014000060623     D OBJD0100        Ds                  Qualified
014100060623     D  BytRtn                       10i 0
014200060623     D  BytAvl                       10i 0
014300060623     D  ObjNam                       10a
014400060623     D  ObjLib                       10a
014500060623     D  ObjTyp                       10a
014600060623
014700060623      /Free
014800060623
014900060623         RtvObjD( OBJD0100
015000060623                : %Size( OBJD0100 )
015100060623                : 'OBJD0100'
015200060623                : PxObjNam + PxObjLib
015300060623                : PxObjTyp
015400060623                : ERRC0100
015500060623                );
015600060623
015700060623         If  ERRC0100.BytAvl > *Zero;
015800060623           Return  *Off;
015900060623
016000060623         Else;
016100060623           Return  *On;
016200060623         EndIf;
016300060623
016400060623      /End-Free
016500060623
016600060623     P ChkObj          E
016700060316     **-- Send diagnostic message:
016800040728     P SndDiagMsg      B
016900040722     D                 Pi            10i 0
017000040722     D  PxMsgId                       7a   Const
017100040722     D  PxMsgDta                    512a   Const  Varying
017200040722     **
017300040722     D MsgKey          s              4a
017400040722
017500040722      /Free
017600040722
017700040722        SndPgmMsg( PxMsgId
017800040722                 : 'QCPFMSG   *LIBL'
017900040722                 : PxMsgDta
018000040722                 : %Len( PxMsgDta )
018100040728                 : '*DIAG'
018200040722                 : '*PGMBDY'
018300040722                 : 1
018400040722                 : MsgKey
018500040722                 : ERRC0100
018600040722                 );
018700040722
018800040722        If  ERRC0100.BytAvl > *Zero;
018900040722          Return  -1;
019000040722
019100040722        Else;
019200040722          Return   0;
019300040722        EndIf;
019400040722
019500040722      /End-Free
019600040722
019700040728     P SndDiagMsg      E
019800060316     **-- Send escape message:
019900040728     P SndEscMsg       B
020000040728     D                 Pi            10i 0
020100040728     D  PxMsgId                       7a   Const
020200040728     D  PxMsgDta                    512a   Const  Varying
020300040728     **
020400040728     D MsgKey          s              4a
020500040728
020600040728      /Free
020700040728
020800040728        SndPgmMsg( PxMsgId
020900040728                 : 'QCPFMSG   *LIBL'
021000040728                 : PxMsgDta
021100040728                 : %Len( PxMsgDta )
021200040728                 : '*ESCAPE'
021300040728                 : '*PGMBDY'
021400040728                 : 1
021500040728                 : MsgKey
021600040728                 : ERRC0100
021700040728                 );
021800040728
021900040728        If  ERRC0100.BytAvl > *Zero;
022000040728          Return  -1;
022100040728
022200040728        Else;
022300040728          Return   0;
022400040728        EndIf;
022500040728
022600040728      /End-Free
022700040728
022800040728     P SndEscMsg       E
