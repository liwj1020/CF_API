000100041110     **
000200070429     **  Program . . : CBX970V
000300070502     **  Description : Work with Journal 2 - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500070429     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060525     **    This program checks the existence of the specified objects.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300070429     **    CrtRpgMod Module( CBX970V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600070429     **    CrtPgm    Pgm( CBX970V )
001700070429     **              Module( CBX970V )
001800070429     **              ActGrp( *CALLER )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200060504     H Option( *SrcStmt )
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
008600070125     **-- Entry parameters:
008700070125     D ObjNam_q        Ds
008800070125     D  ObjNam                       10a
008900070125     D  ObjLib                       10a
009000070125     **
009100070429     D CBX970V         Pr
009200070429     D  PxJrnNam_q                         LikeDs( ObjNam_q )
009300070429     D  PxLstOrd                     10a
009400070429     D  PxOutOpt                      3a
009500040722     **
009600070429     D CBX970V         Pi
009700070429     D  PxJrnNam_q                         LikeDs( ObjNam_q )
009800070429     D  PxLstOrd                     10a
009900070429     D  PxOutOpt                      3a
010000040721
010100040724      /Free
010200040728
010300070429        If  %Scan( '*': PxJrnNam_q.ObjNam ) = *Zero  And
010400070429            %Scan( '*': PxJrnNam_q.ObjLib ) = *Zero;
010500060506
010600070429          If  ChkObj( PxJrnNam_q: '*JRN' ) = *Off;
010700060506
010800060506            SndDiagMsg( 'CPD0006'
010900060506                      : '0000' +
011000070429                        RtvMsg( 'CPF2105': PxJrnNam_q + 'JRN' )
011100060506                      );
011200060506
011300060506            SndEscMsg( 'CPF0002': '' );
011400060506          EndIf;
011500060506        EndIf;
011600050408
011700040605        *InLr = *On;
011800040605        Return;
011900040605
012000040721      /End-Free
012100040721
012200050408     **-- Check object existence:  -------------------------------------------**
012300050408     P ChkObj          B                   Export
012400050408     D                 Pi              n
012500050408     D  PxObjNam_q                   20a   Const
012600050408     D  PxObjTyp                     10a   Const
012700050408     **
012800050408     D OBJD0100        Ds                  Qualified
012900050408     D  BytRtn                       10i 0
013000050408     D  BytAvl                       10i 0
013100050408     D  ObjNam                       10a
013200050408     D  ObjLib                       10a
013300050408     D  ObjTyp                       10a
013400050408
013500050408      /Free
013600050408
013700050408         RtvObjD( OBJD0100
013800050408                : %Size( OBJD0100 )
013900050408                : 'OBJD0100'
014000050408                : PxObjNam_q
014100050408                : PxObjTyp
014200050408                : ERRC0100
014300050408                );
014400050408
014500050408         If  ERRC0100.BytAvl > *Zero;
014600050408           Return  *Off;
014700050408
014800050408         Else;
014900050408           Return  *On;
015000050408         EndIf;
015100050408
015200050408      /End-Free
015300050408
015400050408     P ChkObj          E
015500060430     **-- Retrieve message:
015600050408     P RtvMsg          B
015700050408     D                 Pi          4096a   Varying
015800050408     D  PxMsgId                       7a   Const
015900050408     D  PxMsgDta                    512a   Const  Varying
016000050408     **
016100050408     D RTVM0100        Ds                  Qualified
016200050408     D  BytRtn                       10i 0
016300050408     D  BytAvl                       10i 0
016400050408     D  RtnMsgLen                    10i 0
016500050408     D  RtnMsgAvl                    10i 0
016600050408     D  RtnHlpLen                    10i 0
016700050408     D  RtnHlpAvl                    10i 0
016800050408     D  Msg                        4096a
016900050408     **
017000050408     D RPL_SUB_VAL     c                   '*YES'
017100050408     D NOT_FMT_CTL     c                   '*NO'
017200050408
017300050408      /Free
017400050408
017500050408        RtvMsgD( RTVM0100
017600050408               : %Size( RTVM0100 )
017700050408               : 'RTVM0100'
017800050408               : PxMsgId
017900050408               : 'QCPFMSG   *LIBL'
018000050408               : PxMsgDta
018100050408               : %Len( PxMsgDta )
018200050408               : RPL_SUB_VAL
018300050408               : NOT_FMT_CTL
018400050408               : ERRC0100
018500050408               );
018600050408
018700050408        Select;
018800050408        When  ERRC0100.BytAvl > *Zero;
018900050408          Return  NULL;
019000050408
019100050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
019200050408          Return  %Subst( RTVM0100.Msg
019300050408                        : RTVM0100.RtnMsgLen + 1
019400050408                        : RTVM0100.RtnHlpLen
019500050408                        );
019600050408
019700050408        Other;
019800050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
019900050408        EndSl;
020000050408
020100050408      /End-Free
020200050408
020300050408     P RtvMsg          E
020400060430     **-- Send diagnostic message:
020500040728     P SndDiagMsg      B
020600040722     D                 Pi            10i 0
020700040722     D  PxMsgId                       7a   Const
020800040722     D  PxMsgDta                    512a   Const  Varying
020900040722     **
021000040722     D MsgKey          s              4a
021100040722
021200040722      /Free
021300040722
021400040722        SndPgmMsg( PxMsgId
021500040722                 : 'QCPFMSG   *LIBL'
021600040722                 : PxMsgDta
021700040722                 : %Len( PxMsgDta )
021800040728                 : '*DIAG'
021900040722                 : '*PGMBDY'
022000040722                 : 1
022100040722                 : MsgKey
022200040722                 : ERRC0100
022300040722                 );
022400040722
022500040722        If  ERRC0100.BytAvl > *Zero;
022600040722          Return  -1;
022700040722
022800040722        Else;
022900040722          Return   0;
023000040722        EndIf;
023100040722
023200040722      /End-Free
023300040722
023400040728     P SndDiagMsg      E
023500060430     **-- Send escape message:
023600040728     P SndEscMsg       B
023700040728     D                 Pi            10i 0
023800040728     D  PxMsgId                       7a   Const
023900040728     D  PxMsgDta                    512a   Const  Varying
024000040728     **
024100040728     D MsgKey          s              4a
024200040728
024300040728      /Free
024400040728
024500040728        SndPgmMsg( PxMsgId
024600040728                 : 'QCPFMSG   *LIBL'
024700040728                 : PxMsgDta
024800040728                 : %Len( PxMsgDta )
024900040728                 : '*ESCAPE'
025000040728                 : '*PGMBDY'
025100040728                 : 1
025200040728                 : MsgKey
025300040728                 : ERRC0100
025400040728                 );
025500040728
025600040728        If  ERRC0100.BytAvl > *Zero;
025700040728          Return  -1;
025800040728
025900040728        Else;
026000040728          Return   0;
026100040728        EndIf;
026200040728
026300040728      /End-Free
026400040728
026500040728     P SndEscMsg       E
