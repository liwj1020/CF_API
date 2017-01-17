000100041110     **
000200070101     **  Program . . : CBX965V
000300061116     **  Description : Display User jobs - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500070101     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060430     **    This program checks the existence of the specified object.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300070101     **    CrtRpgMod Module( CBX965V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600070101     **    CrtPgm    Pgm( CBX965V )
001700070101     **              Module( CBX965V )
001800070101     **              ActGrp( QILE )
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
008600040722     **-- Entry parameters:
008700070101     D CBX965V         Pr
008800060512     D  PxUsrPrf                     10a
008900060516     D  PxJobSts                     10a
009000060512     D  PxJobTyp                      1a
009100060512     D  PxCurUsr                     10a
009200060512     D  PxCmpSts                     10a
009300040722     **
009400070101     D CBX965V         Pi
009500060512     D  PxUsrPrf                     10a
009600060516     D  PxJobSts                     10a
009700060512     D  PxJobTyp                      1a
009800060512     D  PxCurUsr                     10a
009900060512     D  PxCmpSts                     10a
010000040721
010100040724      /Free
010200040728
010300060516        If  %Scan( '*': PxUsrPrf ) = *Zero;
010400060506
010500060516          If  ChkObj( PxUsrPrf + 'QSYS': '*USRPRF' ) = *Off;
010600060506
010700060506            SndDiagMsg( 'CPD0006'
010800060506                      : '0000' +
010900060516                        RtvMsg( 'CPF2204': PxUsrPrf )
011000060506                      );
011100060506
011200060506            SndEscMsg( 'CPF0002': '' );
011300060506          EndIf;
011400060506        EndIf;
011500060506
011600060516        If  PxCurUsr > *Blanks;
011700060506
011800060516          If  ChkObj( PxCurUsr + 'QSYS' : '*USRPRF' ) = *Off;
011900060506
012000060506            SndDiagMsg( 'CPD0006'
012100060506                      : '0000' +
012200111128                        RtvMsg( 'CPF2204': PxCurUsr )
012300060506                      );
012400060506
012500060506            SndEscMsg( 'CPF0002': '' );
012600060506          EndIf;
012700060506        EndIf;
012800050408
012900040605        *InLr = *On;
013000040605        Return;
013100040605
013200040721      /End-Free
013300040721
013400050408     **-- Check object existence:  -------------------------------------------**
013500050408     P ChkObj          B                   Export
013600050408     D                 Pi              n
013700050408     D  PxObjNam_q                   20a   Const
013800050408     D  PxObjTyp                     10a   Const
013900050408     **
014000050408     D OBJD0100        Ds                  Qualified
014100050408     D  BytRtn                       10i 0
014200050408     D  BytAvl                       10i 0
014300050408     D  ObjNam                       10a
014400050408     D  ObjLib                       10a
014500050408     D  ObjTyp                       10a
014600050408
014700050408      /Free
014800050408
014900050408         RtvObjD( OBJD0100
015000050408                : %Size( OBJD0100 )
015100050408                : 'OBJD0100'
015200050408                : PxObjNam_q
015300050408                : PxObjTyp
015400050408                : ERRC0100
015500050408                );
015600050408
015700050408         If  ERRC0100.BytAvl > *Zero;
015800050408           Return  *Off;
015900050408
016000050408         Else;
016100050408           Return  *On;
016200050408         EndIf;
016300050408
016400050408      /End-Free
016500050408
016600050408     P ChkObj          E
016700060430     **-- Retrieve message:
016800050408     P RtvMsg          B
016900050408     D                 Pi          4096a   Varying
017000050408     D  PxMsgId                       7a   Const
017100050408     D  PxMsgDta                    512a   Const  Varying
017200050408     **
017300050408     D RTVM0100        Ds                  Qualified
017400050408     D  BytRtn                       10i 0
017500050408     D  BytAvl                       10i 0
017600050408     D  RtnMsgLen                    10i 0
017700050408     D  RtnMsgAvl                    10i 0
017800050408     D  RtnHlpLen                    10i 0
017900050408     D  RtnHlpAvl                    10i 0
018000050408     D  Msg                        4096a
018100050408     **
018200050408     D RPL_SUB_VAL     c                   '*YES'
018300050408     D NOT_FMT_CTL     c                   '*NO'
018400050408
018500050408      /Free
018600050408
018700050408        RtvMsgD( RTVM0100
018800050408               : %Size( RTVM0100 )
018900050408               : 'RTVM0100'
019000050408               : PxMsgId
019100050408               : 'QCPFMSG   *LIBL'
019200050408               : PxMsgDta
019300050408               : %Len( PxMsgDta )
019400050408               : RPL_SUB_VAL
019500050408               : NOT_FMT_CTL
019600050408               : ERRC0100
019700050408               );
019800050408
019900050408        Select;
020000050408        When  ERRC0100.BytAvl > *Zero;
020100050408          Return  NULL;
020200050408
020300050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
020400050408          Return  %Subst( RTVM0100.Msg
020500050408                        : RTVM0100.RtnMsgLen + 1
020600050408                        : RTVM0100.RtnHlpLen
020700050408                        );
020800050408
020900050408        Other;
021000050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
021100050408        EndSl;
021200050408
021300050408      /End-Free
021400050408
021500050408     P RtvMsg          E
021600060430     **-- Send diagnostic message:
021700040728     P SndDiagMsg      B
021800040722     D                 Pi            10i 0
021900040722     D  PxMsgId                       7a   Const
022000040722     D  PxMsgDta                    512a   Const  Varying
022100040722     **
022200040722     D MsgKey          s              4a
022300040722
022400040722      /Free
022500040722
022600040722        SndPgmMsg( PxMsgId
022700040722                 : 'QCPFMSG   *LIBL'
022800040722                 : PxMsgDta
022900040722                 : %Len( PxMsgDta )
023000040728                 : '*DIAG'
023100040722                 : '*PGMBDY'
023200040722                 : 1
023300040722                 : MsgKey
023400040722                 : ERRC0100
023500040722                 );
023600040722
023700040722        If  ERRC0100.BytAvl > *Zero;
023800040722          Return  -1;
023900040722
024000040722        Else;
024100040722          Return   0;
024200040722        EndIf;
024300040722
024400040722      /End-Free
024500040722
024600040728     P SndDiagMsg      E
024700060430     **-- Send escape message:
024800040728     P SndEscMsg       B
024900040728     D                 Pi            10i 0
025000040728     D  PxMsgId                       7a   Const
025100040728     D  PxMsgDta                    512a   Const  Varying
025200040728     **
025300040728     D MsgKey          s              4a
025400040728
025500040728      /Free
025600040728
025700040728        SndPgmMsg( PxMsgId
025800040728                 : 'QCPFMSG   *LIBL'
025900040728                 : PxMsgDta
026000040728                 : %Len( PxMsgDta )
026100040728                 : '*ESCAPE'
026200040728                 : '*PGMBDY'
026300040728                 : 1
026400040728                 : MsgKey
026500040728                 : ERRC0100
026600040728                 );
026700040728
026800040728        If  ERRC0100.BytAvl > *Zero;
026900040728          Return  -1;
027000040728
027100040728        Else;
027200040728          Return   0;
027300040728        EndIf;
027400040728
027500040728      /End-Free
027600040728
027700040728     P SndEscMsg       E
