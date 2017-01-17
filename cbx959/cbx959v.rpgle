000100041110     **
000200060819     **  Program . . : CBX959V
000300060819     **  Description : Remove Journal Receivers - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500060824     **  Published . : System iNetwork Systems Management Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060430     **    This program checks the existence of the specified object.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300060819     **    CrtRpgMod Module( CBX959V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600060819     **    CrtPgm    Pgm( CBX959V )
001700060519     **              Module( CBX157V )
001800060616     **              ActGrp( *CALLER )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200060504     H Option( *SrcStmt )
002300040722
002400040728     **-- API error data structure:
002500040728     D ERRC0100        Ds                  Qualified
002600040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002700040728     D  BytAvl                       10i 0
002800060819     D  MsgId                         7a
002900040728     D                                1a
003000060819     D  MsgDta                      512a
003100050408     **-- Global constants:
003200050408     D NULL            c                   ''
003300040728
003400050408     **-- Retrieve object description:
003500050408     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
003600060430     D  RcvVar                    32767a          Options( *VarSize )
003700060430     D  RcvVarLen                    10i 0 Const
003800060430     D  FmtNam                        8a   Const
003900060430     D  ObjNamQ                      20a   Const
004000060430     D  ObjTyp                       10a   Const
004100060430     D  Error                     32767a          Options( *VarSize )
004200060430     **-- Retrieve message description:
004300060430     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
004400060430     D  RcvVar                    32767a          Options( *VarSize )
004500060430     D  RcvVarLen                    10i 0 Const
004600060430     D  FmtNam                       10a   Const
004700060430     D  MsgId                         7a   Const
004800060430     D  MsgFq                        20a   Const
004900060430     D  MsgDta                      512a   Const  Options( *VarSize )
005000060430     D  MsgDtaLen                    10i 0 Const
005100060430     D  RplSubVal                    10a   Const
005200060430     D  RtnFmtChr                    10a   Const
005300060430     D  Error                     32767a          Options( *VarSize )
005400060430     D  RtvOpt                       10a   Const  Options( *NoPass )
005500060430     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
005600060430     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
005700040728     **-- Send program message:
005800040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
005900060430     D  MsgId                         7a   Const
006000060430     D  MsgFq                        20a   Const
006100060430     D  MsgDta                      128a   Const
006200060430     D  MsgDtaLen                    10i 0 Const
006300060430     D  MsgTyp                       10a   Const
006400060430     D  CalStkE                      10a   Const  Options( *VarSize )
006500060430     D  CalStkCtr                    10i 0 Const
006600060430     D  MsgKey                        4a
006700060430     D  Error                      1024a          Options( *VarSize )
006800040722
006900050408     **-- Check object existence:
007000050408     D ChkObj          Pr              n
007100050408     D  PxObjNam_q                   20a   Const
007200050408     D  PxObjTyp                     10a   Const
007300060430     **-- Retrieve message:
007400060430     D RtvMsg          Pr          4096a   Varying
007500060430     D  PxMsgId                       7a   Const
007600060430     D  PxMsgDta                    512a   Const  Varying
007700040728     **-- Send diagnostic message:
007800040728     D SndDiagMsg      Pr            10i 0
007900040722     D  PxMsgId                       7a   Const
008000040722     D  PxMsgDta                    512a   Const  Varying
008100040728     **-- Send escape message:
008200040728     D SndEscMsg       Pr            10i 0
008300040728     D  PxMsgId                       7a   Const
008400040728     D  PxMsgDta                    512a   Const  Varying
008500040722
008600040722     **-- Entry parameters:
008700060819     D ObjNam_q        Ds                  Qualified
008800060819     D  ObjNam                       10a
008900060819     D  ObjLib                       10a
009000060819     **
009100060819     D ObjNam_e        Ds                  Qualified
009200060819     D  NbrObj                        5i 0
009300060921     D  ObjNam_q2                          Like( ObjNam_q )  Dim( 2 )
009400060819     **
009500060921     D CBX959V51       Pr
009600060921     D  PxJrnNam_q                         Like( ObjNam_q )
009700060819     D  PxRcvRtnDays                  5i 0
009800060819     D  PxRcvRtnNbr                   5i 0
009900060819     D  PxForce                       3a
010000060819     D  PxChgJrn                      3a
010100060921     D  PxJrnRcv                           Like( ObjNam_e )
010200060819     D  PxSeqOpt                      6a
010300040722     **
010400060921     D CBX959V51       Pi
010500060921     D  PxJrnNam_q                         Like( ObjNam_q )
010600060819     D  PxRcvRtnDays                  5i 0
010700060819     D  PxRcvRtnNbr                   5i 0
010800060819     D  PxForce                       3a
010900060819     D  PxChgJrn                      3a
011000060921     D  PxJrnRcv                           Like( ObjNam_e )
011100060819     D  PxSeqOpt                      6a
011200040721
011300040724      /Free
011400040728
011500060921        ObjNam_q = PxJrnNam_q;
011600060921        ObjNam_e = PxJrnRcv;
011700060921
011800060819        If  ChkObj( PxJrnNam_q: '*JRN' ) = *Off;
011900050408
012000050408          SndDiagMsg( 'CPD0006'
012100050408                    : '0000' +
012200060819                      RtvMsg( 'CPF2105': PxJrnNam_q + 'JRN' )
012300050408                    );
012400050408
012500050408          SndEscMsg( 'CPF0002': '' );
012600050408        EndIf;
012700050408
012800060921        If  %Scan( '*': ObjNam_q(1).ObjNam ) = *Zero;
012900060820
013000060921          If  ChkObj( ObjNam_q(1): '*JRNRCV' ) = *Off;
013100060820
013200060820            SndDiagMsg( 'CPD0006'
013300060820                      : '0000' +
013400060921                        RtvMsg( 'CPF2105': ObjNam_q(1) + 'JRNRCV' )
013500060820                      );
013600060820
013700060820            SndEscMsg( 'CPF0002': '' );
013800060820          EndIf;
013900060820        EndIf;
014000060820
014100040605        *InLr = *On;
014200040605        Return;
014300040605
014400040721      /End-Free
014500040721
014600050408     **-- Check object existence:  -------------------------------------------**
014700050408     P ChkObj          B                   Export
014800050408     D                 Pi              n
014900050408     D  PxObjNam_q                   20a   Const
015000050408     D  PxObjTyp                     10a   Const
015100050408     **
015200050408     D OBJD0100        Ds                  Qualified
015300050408     D  BytRtn                       10i 0
015400050408     D  BytAvl                       10i 0
015500050408     D  ObjNam                       10a
015600050408     D  ObjLib                       10a
015700050408     D  ObjTyp                       10a
015800050408
015900050408      /Free
016000050408
016100050408         RtvObjD( OBJD0100
016200050408                : %Size( OBJD0100 )
016300050408                : 'OBJD0100'
016400050408                : PxObjNam_q
016500050408                : PxObjTyp
016600050408                : ERRC0100
016700050408                );
016800050408
016900050408         If  ERRC0100.BytAvl > *Zero;
017000050408           Return  *Off;
017100050408
017200050408         Else;
017300050408           Return  *On;
017400050408         EndIf;
017500050408
017600050408      /End-Free
017700050408
017800050408     P ChkObj          E
017900060430     **-- Retrieve message:
018000050408     P RtvMsg          B
018100050408     D                 Pi          4096a   Varying
018200050408     D  PxMsgId                       7a   Const
018300050408     D  PxMsgDta                    512a   Const  Varying
018400050408     **
018500050408     D RTVM0100        Ds                  Qualified
018600050408     D  BytRtn                       10i 0
018700050408     D  BytAvl                       10i 0
018800050408     D  RtnMsgLen                    10i 0
018900050408     D  RtnMsgAvl                    10i 0
019000050408     D  RtnHlpLen                    10i 0
019100050408     D  RtnHlpAvl                    10i 0
019200050408     D  Msg                        4096a
019300050408     **
019400050408     D RPL_SUB_VAL     c                   '*YES'
019500050408     D NOT_FMT_CTL     c                   '*NO'
019600050408
019700050408      /Free
019800050408
019900050408        RtvMsgD( RTVM0100
020000050408               : %Size( RTVM0100 )
020100050408               : 'RTVM0100'
020200050408               : PxMsgId
020300050408               : 'QCPFMSG   *LIBL'
020400050408               : PxMsgDta
020500050408               : %Len( PxMsgDta )
020600050408               : RPL_SUB_VAL
020700050408               : NOT_FMT_CTL
020800050408               : ERRC0100
020900050408               );
021000050408
021100050408        Select;
021200050408        When  ERRC0100.BytAvl > *Zero;
021300050408          Return  NULL;
021400050408
021500050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
021600050408          Return  %Subst( RTVM0100.Msg
021700050408                        : RTVM0100.RtnMsgLen + 1
021800050408                        : RTVM0100.RtnHlpLen
021900050408                        );
022000050408
022100050408        Other;
022200050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
022300050408        EndSl;
022400050408
022500050408      /End-Free
022600050408
022700050408     P RtvMsg          E
022800060430     **-- Send diagnostic message:
022900040728     P SndDiagMsg      B
023000040722     D                 Pi            10i 0
023100040722     D  PxMsgId                       7a   Const
023200040722     D  PxMsgDta                    512a   Const  Varying
023300040722     **
023400040722     D MsgKey          s              4a
023500040722
023600040722      /Free
023700040722
023800040722        SndPgmMsg( PxMsgId
023900040722                 : 'QCPFMSG   *LIBL'
024000040722                 : PxMsgDta
024100040722                 : %Len( PxMsgDta )
024200040728                 : '*DIAG'
024300040722                 : '*PGMBDY'
024400040722                 : 1
024500040722                 : MsgKey
024600040722                 : ERRC0100
024700040722                 );
024800040722
024900040722        If  ERRC0100.BytAvl > *Zero;
025000040722          Return  -1;
025100040722
025200040722        Else;
025300040722          Return   0;
025400040722        EndIf;
025500040722
025600040722      /End-Free
025700040722
025800040728     P SndDiagMsg      E
025900060430     **-- Send escape message:
026000040728     P SndEscMsg       B
026100040728     D                 Pi            10i 0
026200040728     D  PxMsgId                       7a   Const
026300040728     D  PxMsgDta                    512a   Const  Varying
026400040728     **
026500040728     D MsgKey          s              4a
026600040728
026700040728      /Free
026800040728
026900040728        SndPgmMsg( PxMsgId
027000040728                 : 'QCPFMSG   *LIBL'
027100040728                 : PxMsgDta
027200040728                 : %Len( PxMsgDta )
027300040728                 : '*ESCAPE'
027400040728                 : '*PGMBDY'
027500040728                 : 1
027600040728                 : MsgKey
027700040728                 : ERRC0100
027800040728                 );
027900040728
028000040728        If  ERRC0100.BytAvl > *Zero;
028100040728          Return  -1;
028200040728
028300040728        Else;
028400040728          Return   0;
028500040728        EndIf;
028600040728
028700040728      /End-Free
028800040728
028900040728     P SndEscMsg       E
