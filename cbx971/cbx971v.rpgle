000100041110     **
000200070518     **  Program . . : CBX971V
000300070518     **  Description : Work with Output Queue Authorities - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500070518     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700070504     **
000800041110     **
000900041110     **  Program description:
001000070518     **    This program checks the existence of the specified objects.
001100050804     **
001200050804     **
001300031115     **  Compile options:
001400070518     **    CrtRpgMod Module( CBX971V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700070518     **    CrtPgm    Pgm( CBX971V )
001800070518     **              Module( CBX971V )
001900061203     **              ActGrp( *CALLER )
002000031115     **
002100031115     **
002200040605     **-- Control specification:  --------------------------------------------**
002300050804     H Option( *SrcStmt )
002400040722
002500070520     **-- System information:
002600070520     D PgmSts         SDs                  Qualified
002700070520     D  PgmNam           *Proc
002800070520     D  CurJob                       10a   Overlay( PgmSts: 244 )
002900070520     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
003000070520     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003100070520     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003200040728     **-- API error data structure:
003300040728     D ERRC0100        Ds                  Qualified
003400040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003500040728     D  BytAvl                       10i 0
003600061203     D  MsgId                         7a
003700040728     D                                1a
003800061203     D  MsgDta                      512a
003900060407
004000070520     **-- Global constants:
004100070520     D ADP_PRV_INVLVL  c                   1
004200070520     **-- Global variables:
004300070520     D AutFlg          s              1a
004400070520     D SpcAut          s             10a   Dim( 8 )
004500070520
004600070520     **-- Check special authority
004700070520     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
004800070520     D  AutInf                        1a
004900070520     D  UsrPrf                       10a   Const
005000070520     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
005100070520     D  NbrAut                       10i 0 Const
005200070520     D  CalLvl                       10i 0 Const
005300070520     D  Error                     32767a          Options( *VarSize )
005400070427     **-- Retrieve object description:
005500070427     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
005600070520     D  RcvVar                    32767a          Options( *VarSize )
005700070520     D  RcvVarLen                    10i 0 Const
005800070520     D  FmtNam                        8a   Const
005900070520     D  ObjNamQ                      20a   Const
006000070520     D  ObjTyp                       10a   Const
006100070520     D  Error                     32767a          Options( *VarSize )
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
007300070518     **-- Retrieve message description:
007400070518     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
007500070518     D  RcvVar                    32767a          Options( *VarSize )
007600070518     D  RcvVarLen                    10i 0 Const
007700070518     D  FmtNam                       10a   Const
007800070518     D  MsgId                         7a   Const
007900070518     D  MsgFq                        20a   Const
008000070518     D  MsgDta                      512a   Const  Options( *VarSize )
008100070518     D  MsgDtaLen                    10i 0 Const
008200070518     D  RplSubVal                    10a   Const
008300070518     D  RtnFmtChr                    10a   Const
008400070518     D  Error                     32767a          Options( *VarSize )
008500070518     D  RtvOpt                       10a   Const  Options( *NoPass )
008600070518     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
008700070518     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
008800040722
008900070427     **-- Check object existence:
009000070427     D ChkObj          Pr              n
009100070518     D  PxObjNam                     10a   Const
009200070518     D  PxObjLib                     10a   Const
009300070427     D  PxObjTyp                     10a   Const
009400070518     **-- Retrieve message:
009500070518     D RtvMsg          Pr          4096a   Varying
009600070518     D  PxMsgId                       7a   Const
009700070518     D  PxMsgDta                    512a   Const  Varying
009800040728     **-- Send diagnostic message:
009900040728     D SndDiagMsg      Pr            10i 0
010000040722     D  PxMsgId                       7a   Const
010100040722     D  PxMsgDta                    512a   Const  Varying
010200040728     **-- Send escape message:
010300040728     D SndEscMsg       Pr            10i 0
010400040728     D  PxMsgId                       7a   Const
010500040728     D  PxMsgDta                    512a   Const  Varying
010600040722
010700040722     **-- Entry parameters:
010800070518     D ObjNam_q        Ds
010900070518     D  ObjNam                       10a
011000070518     D  ObjLib                       10a
011100070518     **
011200070518     D CBX971V         Pr
011300070518     D  PxOutQue_q                         LikeDs( ObjNam_q )
011400070427     D  PxUsrPrf                     10a
011500060729     D  PxOutOpt                      3a
011600050731     **
011700070518     D CBX971V         Pi
011800070518     D  PxOutQue_q                         LikeDs( ObjNam_q )
011900070427     D  PxUsrPrf                     10a
012000060729     D  PxOutOpt                      3a
012100040721
012200040724      /Free
012300060407
012400070520        SpcAut( 1 ) = '*SECADM';
012500070520        SpcAut( 2 ) = '*ALLOBJ';
012600070520
012700070520        ChkSpcAut( AutFlg
012800070520                 : PgmSts.UsrPrf
012900070520                 : SpcAut
013000070520                 : 2
013100070520                 : ADP_PRV_INVLVL
013200070520                 : ERRC0100
013300070520                 );
013400070520
013500070520        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
013600070520          SndDiagMsg( 'CPD0006'
013700070520                    : '0000Special authority *SECADM and *ALLOBJ required.'
013800070520                    );
013900070520
014000070520          SndEscMsg( 'CPF0002': '' );
014100070520        EndIf;
014200070520
014300070518        If  ChkObj( PxOutQue_q.ObjNam: PxOutQue_q.ObjLib: '*OUTQ' ) = *Off;
014400070518
014500070518          SndDiagMsg( 'CPD0006'
014600070518                    : '0000' +
014700070518                      RtvMsg( 'CPF2105': PxOutQue_q + 'OUTQ' )
014800070518                    );
014900070518
015000070518          SndEscMsg( 'CPF0002': '' );
015100070518        EndIf;
015200070518
015300070427        If  %Scan( '*': PxUsrPrf ) = *Zero;
015400060421
015500070427          If  ChkObj( PxUsrPrf: '*LIBL': '*USRPRF' ) = *Off;
015600070518
015700070427            SndDiagMsg( 'CPD0006'
015800070427                      : '0000User profile '   +
015900070427                         %Trim( PxUsrPrf )    +
016000070427                        ' does not exist.'
016100070427                      );
016200070427
016300070427            SndEscMsg( 'CPF0002': '' );
016400070427          EndIf;
016500060421        EndIf;
016600050408
016700040605        *InLr = *On;
016800040605        Return;
016900040605
017000040721      /End-Free
017100040721
017200070427     **-- Check object existence:
017300070427     P ChkObj          B
017400070427     D                 Pi              n
017500070427     D  PxObjNam                     10a   Const
017600070427     D  PxObjLib                     10a   Const
017700070427     D  PxObjTyp                     10a   Const
017800070427     **
017900070427     D OBJD0100        Ds                  Qualified
018000070427     D  BytRtn                       10i 0
018100070427     D  BytAvl                       10i 0
018200070427     D  ObjNam                       10a
018300070427     D  ObjLib                       10a
018400070427     D  ObjTyp                       10a
018500070427
018600070427      /Free
018700070427
018800070427         RtvObjD( OBJD0100
018900070427                : %Size( OBJD0100 )
019000070427                : 'OBJD0100'
019100070427                : PxObjNam + PxObjLib
019200070427                : PxObjTyp
019300070427                : ERRC0100
019400070427                );
019500070427
019600070427         If  ERRC0100.BytAvl > *Zero;
019700070427           Return  *Off;
019800070427
019900070427         Else;
020000070427           Return  *On;
020100070427         EndIf;
020200070427
020300070427      /End-Free
020400070427
020500070427     P ChkObj          E
020600070518     **-- Retrieve message:
020700070518     P RtvMsg          B
020800070518     D                 Pi          4096a   Varying
020900070518     D  PxMsgId                       7a   Const
021000070518     D  PxMsgDta                    512a   Const  Varying
021100070518     **
021200070518     D RTVM0100        Ds                  Qualified
021300070518     D  BytRtn                       10i 0
021400070518     D  BytAvl                       10i 0
021500070518     D  RtnMsgLen                    10i 0
021600070518     D  RtnMsgAvl                    10i 0
021700070518     D  RtnHlpLen                    10i 0
021800070518     D  RtnHlpAvl                    10i 0
021900070518     D  Msg                        4096a
022000070518     **
022100070518     D NULL            c                   ''
022200070518     D RPL_SUB_VAL     c                   '*YES'
022300070518     D NOT_FMT_CTL     c                   '*NO'
022400070518
022500070518      /Free
022600070518
022700070518        RtvMsgD( RTVM0100
022800070518               : %Size( RTVM0100 )
022900070518               : 'RTVM0100'
023000070518               : PxMsgId
023100070518               : 'QCPFMSG   *LIBL'
023200070518               : PxMsgDta
023300070518               : %Len( PxMsgDta )
023400070518               : RPL_SUB_VAL
023500070518               : NOT_FMT_CTL
023600070518               : ERRC0100
023700070518               );
023800070518
023900070518        Select;
024000070518        When  ERRC0100.BytAvl > *Zero;
024100070518          Return  NULL;
024200070518
024300070518        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
024400070518          Return  %Subst( RTVM0100.Msg
024500070518                        : RTVM0100.RtnMsgLen + 1
024600070518                        : RTVM0100.RtnHlpLen
024700070518                        );
024800070518
024900070518        Other;
025000070518          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
025100070518        EndSl;
025200070518
025300070518      /End-Free
025400070518
025500070518     P RtvMsg          E
025600060316     **-- Send diagnostic message:
025700040728     P SndDiagMsg      B
025800040722     D                 Pi            10i 0
025900040722     D  PxMsgId                       7a   Const
026000040722     D  PxMsgDta                    512a   Const  Varying
026100040722     **
026200040722     D MsgKey          s              4a
026300040722
026400040722      /Free
026500040722
026600040722        SndPgmMsg( PxMsgId
026700040722                 : 'QCPFMSG   *LIBL'
026800040722                 : PxMsgDta
026900040722                 : %Len( PxMsgDta )
027000040728                 : '*DIAG'
027100040722                 : '*PGMBDY'
027200040722                 : 1
027300040722                 : MsgKey
027400040722                 : ERRC0100
027500040722                 );
027600040722
027700040722        If  ERRC0100.BytAvl > *Zero;
027800040722          Return  -1;
027900040722
028000040722        Else;
028100040722          Return   0;
028200040722        EndIf;
028300040722
028400040722      /End-Free
028500040722
028600040728     P SndDiagMsg      E
028700060316     **-- Send escape message:
028800040728     P SndEscMsg       B
028900040728     D                 Pi            10i 0
029000040728     D  PxMsgId                       7a   Const
029100040728     D  PxMsgDta                    512a   Const  Varying
029200040728     **
029300040728     D MsgKey          s              4a
029400040728
029500040728      /Free
029600040728
029700040728        SndPgmMsg( PxMsgId
029800040728                 : 'QCPFMSG   *LIBL'
029900040728                 : PxMsgDta
030000040728                 : %Len( PxMsgDta )
030100040728                 : '*ESCAPE'
030200040728                 : '*PGMBDY'
030300040728                 : 1
030400040728                 : MsgKey
030500040728                 : ERRC0100
030600040728                 );
030700040728
030800040728        If  ERRC0100.BytAvl > *Zero;
030900040728          Return  -1;
031000040728
031100040728        Else;
031200040728          Return   0;
031300040728        EndIf;
031400040728
031500040728      /End-Free
031600040728
031700040728     P SndEscMsg       E
