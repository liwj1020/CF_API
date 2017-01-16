000100041110     **
000200070123     **  Program . . : CBX968V
000300061114     **  Description : Display Job Queue Jobs - validity checking program
000400041110     **  Author  . . : Carsten Flensburg
000500070326     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060430     **    This program checks the existence of the specified object.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300070123     **    CrtRpgMod Module( CBX968V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600070123     **    CrtPgm    Pgm( CBX968V )
001700070123     **              Module( CBX968V )
001800060518     **              ActGrp( *CALLER )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200041110     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002300040722
002400040728     **-- API error data structure:
002500040728     D ERRC0100        Ds                  Qualified
002600040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002700040728     D  BytAvl                       10i 0
002800040728     D  ExcpId                        7a
002900040728     D                                1a
003000040728     D  ExcpDta                     512a
003100050408     **-- Global constants:
003200050408     D NULL            c                   ''
003300060430     **-- Global variables:
003400050408     D ObjNam_q        Ds
003500050408     D  ObjNam                       10a
003600050408     D  ObjLib                       10a
003700040728
003800050408     **-- Retrieve object description:
003900050408     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
004000060430     D  RcvVar                    32767a          Options( *VarSize )
004100060430     D  RcvVarLen                    10i 0 Const
004200060430     D  FmtNam                        8a   Const
004300060430     D  ObjNamQ                      20a   Const
004400060430     D  ObjTyp                       10a   Const
004500060430     D  Error                     32767a          Options( *VarSize )
004600060430     **-- Retrieve message description:
004700060430     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
004800060430     D  RcvVar                    32767a          Options( *VarSize )
004900060430     D  RcvVarLen                    10i 0 Const
005000060430     D  FmtNam                       10a   Const
005100060430     D  MsgId                         7a   Const
005200060430     D  MsgFq                        20a   Const
005300060430     D  MsgDta                      512a   Const  Options( *VarSize )
005400060430     D  MsgDtaLen                    10i 0 Const
005500060430     D  RplSubVal                    10a   Const
005600060430     D  RtnFmtChr                    10a   Const
005700060430     D  Error                     32767a          Options( *VarSize )
005800060430     D  RtvOpt                       10a   Const  Options( *NoPass )
005900060430     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
006000060430     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
006100040728     **-- Send program message:
006200040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
006300060430     D  MsgId                         7a   Const
006400060430     D  MsgFq                        20a   Const
006500060430     D  MsgDta                      128a   Const
006600060430     D  MsgDtaLen                    10i 0 Const
006700060430     D  MsgTyp                       10a   Const
006800060430     D  CalStkE                      10a   Const  Options( *VarSize )
006900060430     D  CalStkCtr                    10i 0 Const
007000060430     D  MsgKey                        4a
007100060430     D  Error                      1024a          Options( *VarSize )
007200040722
007300050408     **-- Check object existence:
007400050408     D ChkObj          Pr              n
007500050408     D  PxObjNam_q                   20a   Const
007600050408     D  PxObjTyp                     10a   Const
007700060430     **-- Retrieve message:
007800060430     D RtvMsg          Pr          4096a   Varying
007900060430     D  PxMsgId                       7a   Const
008000060430     D  PxMsgDta                    512a   Const  Varying
008100040728     **-- Send diagnostic message:
008200040728     D SndDiagMsg      Pr            10i 0
008300040722     D  PxMsgId                       7a   Const
008400040722     D  PxMsgDta                    512a   Const  Varying
008500040728     **-- Send escape message:
008600040728     D SndEscMsg       Pr            10i 0
008700040728     D  PxMsgId                       7a   Const
008800040728     D  PxMsgDta                    512a   Const  Varying
008900040722
009000040722     **-- Entry parameters:
009100070123     D CBX968V         Pr
009200060430     D  PxJobQue_q                         LikeDs( ObjNam_q )
009300040722     **
009400070123     D CBX968V         Pi
009500060430     D  PxJobQue_q                         LikeDs( ObjNam_q )
009600040721
009700040724      /Free
009800040728
009900060430        If  ChkObj( PxJobQue_q: '*JOBQ' ) = *Off;
010000050408
010100050408          SndDiagMsg( 'CPD0006'
010200050408                    : '0000' +
010300060430                      RtvMsg( 'CPF2105': PxJobQue_q + 'JOBQ' )
010400050408                    );
010500050408
010600050408          SndEscMsg( 'CPF0002': '' );
010700050408        EndIf;
010800050408
010900040605        *InLr = *On;
011000040605        Return;
011100040605
011200040721      /End-Free
011300040721
011400050408     **-- Check object existence:  -------------------------------------------**
011500050408     P ChkObj          B                   Export
011600050408     D                 Pi              n
011700050408     D  PxObjNam_q                   20a   Const
011800050408     D  PxObjTyp                     10a   Const
011900050408     **
012000050408     D OBJD0100        Ds                  Qualified
012100050408     D  BytRtn                       10i 0
012200050408     D  BytAvl                       10i 0
012300050408     D  ObjNam                       10a
012400050408     D  ObjLib                       10a
012500050408     D  ObjTyp                       10a
012600050408
012700050408      /Free
012800050408
012900050408         RtvObjD( OBJD0100
013000050408                : %Size( OBJD0100 )
013100050408                : 'OBJD0100'
013200050408                : PxObjNam_q
013300050408                : PxObjTyp
013400050408                : ERRC0100
013500050408                );
013600050408
013700050408         If  ERRC0100.BytAvl > *Zero;
013800050408           Return  *Off;
013900050408
014000050408         Else;
014100050408           Return  *On;
014200050408         EndIf;
014300050408
014400050408      /End-Free
014500050408
014600050408     P ChkObj          E
014700060430     **-- Retrieve message:
014800050408     P RtvMsg          B
014900050408     D                 Pi          4096a   Varying
015000050408     D  PxMsgId                       7a   Const
015100050408     D  PxMsgDta                    512a   Const  Varying
015200050408     **
015300050408     D RTVM0100        Ds                  Qualified
015400050408     D  BytRtn                       10i 0
015500050408     D  BytAvl                       10i 0
015600050408     D  RtnMsgLen                    10i 0
015700050408     D  RtnMsgAvl                    10i 0
015800050408     D  RtnHlpLen                    10i 0
015900050408     D  RtnHlpAvl                    10i 0
016000050408     D  Msg                        4096a
016100050408     **
016200050408     D RPL_SUB_VAL     c                   '*YES'
016300050408     D NOT_FMT_CTL     c                   '*NO'
016400050408
016500050408      /Free
016600050408
016700050408        RtvMsgD( RTVM0100
016800050408               : %Size( RTVM0100 )
016900050408               : 'RTVM0100'
017000050408               : PxMsgId
017100050408               : 'QCPFMSG   *LIBL'
017200050408               : PxMsgDta
017300050408               : %Len( PxMsgDta )
017400050408               : RPL_SUB_VAL
017500050408               : NOT_FMT_CTL
017600050408               : ERRC0100
017700050408               );
017800050408
017900050408        Select;
018000050408        When  ERRC0100.BytAvl > *Zero;
018100050408          Return  NULL;
018200050408
018300050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
018400050408          Return  %Subst( RTVM0100.Msg
018500050408                        : RTVM0100.RtnMsgLen + 1
018600050408                        : RTVM0100.RtnHlpLen
018700050408                        );
018800050408
018900050408        Other;
019000050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
019100050408        EndSl;
019200050408
019300050408      /End-Free
019400050408
019500050408     P RtvMsg          E
019600060430     **-- Send diagnostic message:
019700040728     P SndDiagMsg      B
019800040722     D                 Pi            10i 0
019900040722     D  PxMsgId                       7a   Const
020000040722     D  PxMsgDta                    512a   Const  Varying
020100040722     **
020200040722     D MsgKey          s              4a
020300040722
020400040722      /Free
020500040722
020600040722        SndPgmMsg( PxMsgId
020700040722                 : 'QCPFMSG   *LIBL'
020800040722                 : PxMsgDta
020900040722                 : %Len( PxMsgDta )
021000040728                 : '*DIAG'
021100040722                 : '*PGMBDY'
021200040722                 : 1
021300040722                 : MsgKey
021400040722                 : ERRC0100
021500040722                 );
021600040722
021700040722        If  ERRC0100.BytAvl > *Zero;
021800040722          Return  -1;
021900040722
022000040722        Else;
022100040722          Return   0;
022200040722        EndIf;
022300040722
022400040722      /End-Free
022500040722
022600040728     P SndDiagMsg      E
022700060430     **-- Send escape message:
022800040728     P SndEscMsg       B
022900040728     D                 Pi            10i 0
023000040728     D  PxMsgId                       7a   Const
023100040728     D  PxMsgDta                    512a   Const  Varying
023200040728     **
023300040728     D MsgKey          s              4a
023400040728
023500040728      /Free
023600040728
023700040728        SndPgmMsg( PxMsgId
023800040728                 : 'QCPFMSG   *LIBL'
023900040728                 : PxMsgDta
024000040728                 : %Len( PxMsgDta )
024100040728                 : '*ESCAPE'
024200040728                 : '*PGMBDY'
024300040728                 : 1
024400040728                 : MsgKey
024500040728                 : ERRC0100
024600040728                 );
024700040728
024800040728        If  ERRC0100.BytAvl > *Zero;
024900040728          Return  -1;
025000040728
025100040728        Else;
025200040728          Return   0;
025300040728        EndIf;
025400040728
025500040728      /End-Free
025600040728
025700040728     P SndEscMsg       E
