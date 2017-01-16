000100041110     **
000200070423     **  Program . . : CBX969V
000300060512     **  Description : Work with jobs - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500070423     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060430     **    This program checks the existence of the specified object.
001000040724     **
001100060430     **
001200031115     **  Compile options:
001300070423     **    CrtRpgMod Module( CBX969V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600070423     **    CrtPgm    Pgm( CBX969V )
001700070423     **              Module( CBX969V )
001800060517     **              ActGrp( *CALLER )
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
008700070306     D Period          Ds                  Based( pNull )
008800070306     D  NbrElm                        5i 0
008900070308     D  OfsElm1                       5i 0
009000070308     D  OfsElm2                       5i 0
009100070306     D  NbrEnd                        5i 0
009200070308     D  TimEnd                        6a
009300070306     D  DatEnd                        7a
009400070308     D  NbrBeg                        5i 0
009500070308     D  TimBeg                        6a
009600070308     D  DatBeg                        7a
009700070306     **
009800070423     D CBX969V         Pr
009900060512     D  PxJobNam                     10a
010000060512     D  PxUsrPrf                     10a
010100060516     D  PxJobSts                     10a
010200060512     D  PxJobTyp                      1a
010300060512     D  PxCurUsr                     10a
010400060512     D  PxCmpSts                     10a
010500070306     D  PxPeriod                           LikeDs( Period )
010600040722     **
010700070423     D CBX969V         Pi
010800060512     D  PxJobNam                     10a
010900060512     D  PxUsrPrf                     10a
011000060516     D  PxJobSts                     10a
011100060512     D  PxJobTyp                      1a
011200060512     D  PxCurUsr                     10a
011300060512     D  PxCmpSts                     10a
011400070306     D  PxPeriod                           LikeDs( Period )
011500040721
011600040724      /Free
011700040728
011800060516        If  %Scan( '*': PxUsrPrf ) = *Zero;
011900060506
012000060516          If  ChkObj( PxUsrPrf + 'QSYS': '*USRPRF' ) = *Off;
012100060506
012200060506            SndDiagMsg( 'CPD0006'
012300060506                      : '0000' +
012400060516                        RtvMsg( 'CPF2204': PxUsrPrf )
012500060506                      );
012600060506
012700060506            SndEscMsg( 'CPF0002': '' );
012800060506          EndIf;
012900060506        EndIf;
013000060506
013100060516        If  PxCurUsr > *Blanks;
013200060506
013300060516          If  ChkObj( PxCurUsr + 'QSYS' : '*USRPRF' ) = *Off;
013400060506
013500060506            SndDiagMsg( 'CPD0006'
013600060506                      : '0000' +
013700060516                        RtvMsg( 'CPF2204': PxUsrPrf )
013800060506                      );
013900060506
014000060506            SndEscMsg( 'CPF0002': '' );
014100060506          EndIf;
014200060506        EndIf;
014300050408
014400040605        *InLr = *On;
014500040605        Return;
014600040605
014700040721      /End-Free
014800040721
014900050408     **-- Check object existence:  -------------------------------------------**
015000050408     P ChkObj          B                   Export
015100050408     D                 Pi              n
015200050408     D  PxObjNam_q                   20a   Const
015300050408     D  PxObjTyp                     10a   Const
015400050408     **
015500050408     D OBJD0100        Ds                  Qualified
015600050408     D  BytRtn                       10i 0
015700050408     D  BytAvl                       10i 0
015800050408     D  ObjNam                       10a
015900050408     D  ObjLib                       10a
016000050408     D  ObjTyp                       10a
016100050408
016200050408      /Free
016300050408
016400050408         RtvObjD( OBJD0100
016500050408                : %Size( OBJD0100 )
016600050408                : 'OBJD0100'
016700050408                : PxObjNam_q
016800050408                : PxObjTyp
016900050408                : ERRC0100
017000050408                );
017100050408
017200050408         If  ERRC0100.BytAvl > *Zero;
017300050408           Return  *Off;
017400050408
017500050408         Else;
017600050408           Return  *On;
017700050408         EndIf;
017800050408
017900050408      /End-Free
018000050408
018100050408     P ChkObj          E
018200060430     **-- Retrieve message:
018300050408     P RtvMsg          B
018400050408     D                 Pi          4096a   Varying
018500050408     D  PxMsgId                       7a   Const
018600050408     D  PxMsgDta                    512a   Const  Varying
018700050408     **
018800050408     D RTVM0100        Ds                  Qualified
018900050408     D  BytRtn                       10i 0
019000050408     D  BytAvl                       10i 0
019100050408     D  RtnMsgLen                    10i 0
019200050408     D  RtnMsgAvl                    10i 0
019300050408     D  RtnHlpLen                    10i 0
019400050408     D  RtnHlpAvl                    10i 0
019500050408     D  Msg                        4096a
019600050408     **
019700050408     D RPL_SUB_VAL     c                   '*YES'
019800050408     D NOT_FMT_CTL     c                   '*NO'
019900050408
020000050408      /Free
020100050408
020200050408        RtvMsgD( RTVM0100
020300050408               : %Size( RTVM0100 )
020400050408               : 'RTVM0100'
020500050408               : PxMsgId
020600050408               : 'QCPFMSG   *LIBL'
020700050408               : PxMsgDta
020800050408               : %Len( PxMsgDta )
020900050408               : RPL_SUB_VAL
021000050408               : NOT_FMT_CTL
021100050408               : ERRC0100
021200050408               );
021300050408
021400050408        Select;
021500050408        When  ERRC0100.BytAvl > *Zero;
021600050408          Return  NULL;
021700050408
021800050408        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
021900050408          Return  %Subst( RTVM0100.Msg
022000050408                        : RTVM0100.RtnMsgLen + 1
022100050408                        : RTVM0100.RtnHlpLen
022200050408                        );
022300050408
022400050408        Other;
022500050408          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
022600050408        EndSl;
022700050408
022800050408      /End-Free
022900050408
023000050408     P RtvMsg          E
023100060430     **-- Send diagnostic message:
023200040728     P SndDiagMsg      B
023300040722     D                 Pi            10i 0
023400040722     D  PxMsgId                       7a   Const
023500040722     D  PxMsgDta                    512a   Const  Varying
023600040722     **
023700040722     D MsgKey          s              4a
023800040722
023900040722      /Free
024000040722
024100040722        SndPgmMsg( PxMsgId
024200040722                 : 'QCPFMSG   *LIBL'
024300040722                 : PxMsgDta
024400040722                 : %Len( PxMsgDta )
024500040728                 : '*DIAG'
024600040722                 : '*PGMBDY'
024700040722                 : 1
024800040722                 : MsgKey
024900040722                 : ERRC0100
025000040722                 );
025100040722
025200040722        If  ERRC0100.BytAvl > *Zero;
025300040722          Return  -1;
025400040722
025500040722        Else;
025600040722          Return   0;
025700040722        EndIf;
025800040722
025900040722      /End-Free
026000040722
026100040728     P SndDiagMsg      E
026200060430     **-- Send escape message:
026300040728     P SndEscMsg       B
026400040728     D                 Pi            10i 0
026500040728     D  PxMsgId                       7a   Const
026600040728     D  PxMsgDta                    512a   Const  Varying
026700040728     **
026800040728     D MsgKey          s              4a
026900040728
027000040728      /Free
027100040728
027200040728        SndPgmMsg( PxMsgId
027300040728                 : 'QCPFMSG   *LIBL'
027400040728                 : PxMsgDta
027500040728                 : %Len( PxMsgDta )
027600040728                 : '*ESCAPE'
027700040728                 : '*PGMBDY'
027800040728                 : 1
027900040728                 : MsgKey
028000040728                 : ERRC0100
028100040728                 );
028200040728
028300040728        If  ERRC0100.BytAvl > *Zero;
028400040728          Return  -1;
028500040728
028600040728        Else;
028700040728          Return   0;
028800040728        EndIf;
028900040728
029000040728      /End-Free
029100040728
029200040728     P SndEscMsg       E
