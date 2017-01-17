000100041110     **
000200070125     **  Program . . : CBX966V
000300061122     **  Description : Display Subsystem Activity - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500070102     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060525     **    This program checks the existence of the specified objects.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300070102     **    CrtRpgMod Module( CBX966V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600070102     **    CrtPgm    Pgm( CBX966V )
001700070102     **              Module( CBX966V )
001800070127     **              ActGrp( QILE )
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
009100070102     D CBX966V         Pr
009200060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
009300060506     D  PxExcLib                     10a
009400040722     **
009500070102     D CBX966V         Pi
009600060506     D  PxSbsNam_q                         LikeDs( ObjNam_q )
009700060506     D  PxExcLib                     10a
009800040721
009900040724      /Free
010000040728
010100060518        If  %Scan( '*': PxSbsNam_q.ObjNam ) = *Zero;
010200060506
010300060506          If  ChkObj( PxSbsNam_q: '*SBSD' ) = *Off;
010400060506
010500060506            SndDiagMsg( 'CPD0006'
010600060506                      : '0000' +
010700060506                        RtvMsg( 'CPF2105': PxSbsNam_q + 'SBSD' )
010800060506                      );
010900060506
011000060506            SndEscMsg( 'CPF0002': '' );
011100060506          EndIf;
011200060506        EndIf;
011300060506
011400060506        If  PxExcLib > *Blanks  And  %Scan( '*': PxExcLib: 2 ) = *Zero;
011500060506
011600060512          If  ChkObj( PxExcLib + '*LIBL': '*LIB' ) = *Off;
011700060506
011800060506            SndDiagMsg( 'CPD0006'
011900060506                      : '0000' +
012000060506                        RtvMsg( 'CPF2105': PxExcLib + 'LIB' )
012100060506                      );
012200060506
012300060506            SndEscMsg( 'CPF0002': '' );
012400060506          EndIf;
012500060506        EndIf;
012600050408
012700040605        *InLr = *On;
012800040605        Return;
012900040605
013000040721      /End-Free
013100040721
013200050408     **-- Check object existence:  -------------------------------------------**
013300050408     P ChkObj          B                   Export
013400050408     D                 Pi              n
013500050408     D  PxObjNam_q                   20a   Const
013600050408     D  PxObjTyp                     10a   Const
013700050408     **
013800050408     D OBJD0100        Ds                  Qualified
013900050408     D  BytRtn                       10i 0
014000050408     D  BytAvl                       10i 0
014100050408     D  ObjNam                       10a
014200050408     D  ObjLib                       10a
014300050408     D  ObjTyp                       10a
014400050408
014500050408      /Free
014600050408
014700050408         RtvObjD( OBJD0100
014800050408                : %Size( OBJD0100 )
014900050408                : 'OBJD0100'
015000050408                : PxObjNam_q
015100050408                : PxObjTyp
015200050408                : ERRC0100
015300050408                );
015400050408
015500050408         If  ERRC0100.BytAvl > *Zero;
015600050408           Return  *Off;
015700050408
015800050408         Else;
015900050408           Return  *On;
016000050408         EndIf;
016100050408
016200050408      /End-Free
016300050408
016400050408     P ChkObj          E
016500060430     **-- Retrieve message:
016600050408     P RtvMsg          B
016700050408     D                 Pi          4096a   Varying
016800050408     D  PxMsgId                       7a   Const
016900050408     D  PxMsgDta                    512a   Const  Varying
017000050408     **
017100050408     D RTVM0100        Ds                  Qualified
017200050408     D  BytRtn                       10i 0
017300050408     D  BytAvl                       10i 0
017400050408     D  RtnMsgLen                    10i 0
017500050408     D  RtnMsgAvl                    10i 0
017600050408     D  RtnHlpLen                    10i 0
017700050408     D  RtnHlpAvl                    10i 0
017800050408     D  Msg                        4096a
017900050408     **
018000050408     D RPL_SUB_VAL     c                   '*YES'
018100050408     D NOT_FMT_CTL     c                   '*NO'
018200050408
018300050408      /Free
018400050408
018500050408        RtvMsgD( RTVM0100
018600050408               : %Size( RTVM0100 )
018700050408               : 'RTVM0100'
018800050408               : PxMsgId
018900050408               : 'QCPFMSG   *LIBL'
019000050408               : PxMsgDta
019100050408               : %Len( PxMsgDta )
019200050408               : RPL_SUB_VAL
019300050408               : NOT_FMT_CTL
019400050408               : ERRC0100
019500050408               );
019600050408
019700050408        Select;
019800050408        When  ERRC0100.BytAvl > *Zero;
019900050408          Return  NULL;
020000050408
020100050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
020200050408          Return  %Subst( RTVM0100.Msg
020300050408                        : RTVM0100.RtnMsgLen + 1
020400050408                        : RTVM0100.RtnHlpLen
020500050408                        );
020600050408
020700050408        Other;
020800050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
020900050408        EndSl;
021000050408
021100050408      /End-Free
021200050408
021300050408     P RtvMsg          E
021400060430     **-- Send diagnostic message:
021500040728     P SndDiagMsg      B
021600040722     D                 Pi            10i 0
021700040722     D  PxMsgId                       7a   Const
021800040722     D  PxMsgDta                    512a   Const  Varying
021900040722     **
022000040722     D MsgKey          s              4a
022100040722
022200040722      /Free
022300040722
022400040722        SndPgmMsg( PxMsgId
022500040722                 : 'QCPFMSG   *LIBL'
022600040722                 : PxMsgDta
022700040722                 : %Len( PxMsgDta )
022800040728                 : '*DIAG'
022900040722                 : '*PGMBDY'
023000040722                 : 1
023100040722                 : MsgKey
023200040722                 : ERRC0100
023300040722                 );
023400040722
023500040722        If  ERRC0100.BytAvl > *Zero;
023600040722          Return  -1;
023700040722
023800040722        Else;
023900040722          Return   0;
024000040722        EndIf;
024100040722
024200040722      /End-Free
024300040722
024400040728     P SndDiagMsg      E
024500060430     **-- Send escape message:
024600040728     P SndEscMsg       B
024700040728     D                 Pi            10i 0
024800040728     D  PxMsgId                       7a   Const
024900040728     D  PxMsgDta                    512a   Const  Varying
025000040728     **
025100040728     D MsgKey          s              4a
025200040728
025300040728      /Free
025400040728
025500040728        SndPgmMsg( PxMsgId
025600040728                 : 'QCPFMSG   *LIBL'
025700040728                 : PxMsgDta
025800040728                 : %Len( PxMsgDta )
025900040728                 : '*ESCAPE'
026000040728                 : '*PGMBDY'
026100040728                 : 1
026200040728                 : MsgKey
026300040728                 : ERRC0100
026400040728                 );
026500040728
026600040728        If  ERRC0100.BytAvl > *Zero;
026700040728          Return  -1;
026800040728
026900040728        Else;
027000040728          Return   0;
027100040728        EndIf;
027200040728
027300040728      /End-Free
027400040728
027500040728     P SndEscMsg       E
