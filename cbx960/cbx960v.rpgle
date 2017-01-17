000100041110     **
000200060923     **  Program . . : CBX960V
000300060923     **  Description : Add Server Share - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500041110     **
000600041110     **
000700041110     **  Program description:
000800060923     **    This program checks the existence of a specified IFS object or
000900060923     **    a specified output queue
001000060923     **
001100040724     **
001200031115     **  Compile options:
001300060923     **    CrtRpgMod Module( CBX960V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600060923     **    CrtPgm    Pgm( CBX960V )
001700060923     **              Module( CBX960V )
001800041203     **              ActGrp( QILE )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200041110     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002300040722
002400040728     **-- API error data structure:
002500040728     D ERRC0100        Ds                  Qualified
002600040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002700040728     D  BytAvl                       10i 0
002800060924     D  MsgId                         7a
002900040728     D                                1a
003000060924     D  MsgDta                      512a
003100041110     **-- access API constants:
003200041110     D F_OK            c                   0
003300041110     D X_OK            c                   1
003400041110     D W_OK            c                   2
003500041110     D R_OK            c                   4
003600040728
003700041110     **-- IFS file functions:
003800041110     D access          Pr            10i 0 ExtProc( 'access' )
003900041110     D   Path                          *   Value  Options( *String )
004000041110     D   Amode                       10i 0 Value
004100041110     **-- Error number:
004200041110     D sys_errno       Pr              *    ExtProc( '__errno' )
004300041110     **-- Error string:
004400041110     D sys_strerror    Pr              *    ExtProc( 'strerror' )
004500041110     D  errno                        10i 0  Value
004600040728     **-- Send program message:
004700060923     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004800060923     D  MsgId                         7a   Const
004900060923     D  MsgFq                        20a   Const
005000060923     D  MsgDta                      128a   Const
005100060923     D  MsgDtaLen                    10i 0 Const
005200060923     D  MsgTyp                       10a   Const
005300060923     D  CalStkE                      10a   Const  Options( *VarSize )
005400060923     D  CalStkCtr                    10i 0 Const
005500060923     D  MsgKey                        4a
005600060923     D  Error                      1024a          Options( *VarSize )
005700060923     **-- Retrieve object description:
005800060923     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
005900060923     D  RcvVar                    32767a          Options( *VarSize )
006000060923     D  RcvVarLen                    10i 0 Const
006100060923     D  FmtNam                        8a   Const
006200060923     D  ObjNamQ                      20a   Const
006300060923     D  ObjTyp                       10a   Const
006400060923     D  Error                     32767a          Options( *VarSize )
006500060923     **-- Retrieve message description:
006600060923     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
006700060923     D  RcvVar                    32767a          Options( *VarSize )
006800060923     D  RcvVarLen                    10i 0 Const
006900060923     D  FmtNam                       10a   Const
007000060923     D  MsgId                         7a   Const
007100060923     D  MsgF_q                       20a   Const
007200060923     D  MsgDta                      512a   Const  Options( *VarSize )
007300060923     D  MsgDtaLen                    10i 0 Const
007400060923     D  RplSubVal                    10a   Const
007500060923     D  RtnFmtChr                    10a   Const
007600060923     D  Error                     32767a          Options( *VarSize )
007700060923     D  RtvOpt                       10a   Const  Options( *NoPass )
007800060923     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
007900060923     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
008000040722
008100060923     **-- Check object existence:
008200060923     D ChkObj          Pr              n
008300060923     D  PxObjNam_q                   20a   Const
008400060923     D  PxObjTyp                     10a   Const
008500060923     **-- Retrieve message:
008600060923     D RtvMsg          Pr          4096a   Varying
008700060923     D  PxMsgId                       7a   Const
008800060923     D  PxMsgDta                    512a   Const  Varying
008900040728     **-- Send diagnostic message:
009000040728     D SndDiagMsg      Pr            10i 0
009100040722     D  PxMsgId                       7a   Const
009200040722     D  PxMsgDta                    512a   Const  Varying
009300040728     **-- Send escape message:
009400040728     D SndEscMsg       Pr            10i 0
009500040728     D  PxMsgId                       7a   Const
009600040728     D  PxMsgDta                    512a   Const  Varying
009700041110     **-- Error identification:
009800041110     D errno           Pr            10i 0
009900041110     D strerror        Pr           128a   Varying
010000040722
010100060923     **-- Entry parameters:
010200060923     D ObjNam_q        Ds                  Qualified
010300060923     D  ObjNam                       10a
010400060923     D  ObjLib                       10a
010500060923     **
010600060923     D FilExt          Ds                  Qualified
010700060923     D  NbrExt                        5i 0
010800060923     D  FilExt                       46a   Varying  Dim( 128 )
010900060923     **
011000060923     D CBX960V         Pr
011100060923     D  PxShare                      12a
011200060923     D  PxShrTyp                     10a
011300060923     D  PxPthNam                   1024a   Varying
011400060923     D  PxTxtDsc                     50a
011500060923     D  PxPermis                     10i 0
011600060923     D  PxMaxUsr                     10i 0
011700060923     D  PxCcsId                      10i 0
011800060923     D  PxCnvTxt                      1a
011900060923     D  PxFilExt                           LikeDs( FilExt )
012000060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
012100060923     D  PxSpfTyp                     10i 0
012200060923     D  PxPrtDrv                     50a
012300060923     D  PxPrtF_q                           LikeDs( ObjNam_q )
012400060923     D  PxPublish                     1a
012500040722     **
012600060923     D CBX960V         Pi
012700060923     D  PxShare                      12a
012800060923     D  PxShrTyp                     10a
012900060923     D  PxPthNam                   1024a   Varying
013000060923     D  PxTxtDsc                     50a
013100060923     D  PxPermis                     10i 0
013200060923     D  PxMaxUsr                     10i 0
013300060923     D  PxCcsId                      10i 0
013400060923     D  PxCnvTxt                      1a
013500060923     D  PxFilExt                           LikeDs( FilExt )
013600060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
013700060923     D  PxSpfTyp                     10i 0
013800060923     D  PxPrtDrv                     50a
013900060923     D  PxPrtF_q                           LikeDs( ObjNam_q )
014000060923     D  PxPublish                     1a
014100060923
014200040724      /Free
014300040728
014400060923        If  PxShrTyp = '*FILE';
014500060923
014600060923          If  access( PxPthNam: F_OK ) = -1;
014700060923            SndDiagMsg( 'CPD0006': '0000' + %Char( errno ) + ': ' + strerror );
014800060923
014900060923            SndEscMsg( 'CPF0002': '' );
015000060923          EndIf;
015100060923        EndIf;
015200060923
015300060923        If  PxShrTyp = '*PRINT';
015400060923
015500060923          If  ChkObj( PxOutQue_q: '*OUTQ' ) = *Off;
015600060923            SndDiagMsg( 'CPD0006'
015700060923                      : '0000' +
015800060923                        RtvMsg( 'CPF2105': PxOutQue_q + 'OUTQ' )
015900060923                      );
016000060923
016100060923            SndEscMsg( 'CPF0002': '' );
016200060923          EndIf;
016300060923
016400060923          If  PxPrtF_q.ObjNam > *Blanks;
016500060923
016600060923            If  ChkObj( PxPrtF_q: '*FILE' ) = *Off;
016700060923              SndDiagMsg( 'CPD0006'
016800060923                        : '0000' +
016900060923                          RtvMsg( 'CPF2105': PxPrtF_q + 'FILE' )
017000060923                        );
017100060923
017200060923              SndEscMsg( 'CPF0002': '' );
017300060923            EndIf;
017400060923          EndIf;
017500060923        EndIf;
017600040728
017700040605        *InLr = *On;
017800040605        Return;
017900040605
018000040605
018100040721      /End-Free
018200040721
018300060923     **-- Check object existence:  -------------------------------------------**
018400060923     P ChkObj          B                   Export
018500060923     D                 Pi              n
018600060923     D  PxObjNam_q                   20a   Const
018700060923     D  PxObjTyp                     10a   Const
018800060923
018900060923     **-- Local variables:
019000060923     D OBJD0100        Ds                  Qualified
019100060923     D  BytRtn                       10i 0
019200060923     D  BytAvl                       10i 0
019300060923     D  ObjNam                       10a
019400060923     D  ObjLib                       10a
019500060923     D  ObjTyp                       10a
019600060923
019700060923      /Free
019800060923
019900060923         RtvObjD( OBJD0100
020000060923                : %Size( OBJD0100 )
020100060923                : 'OBJD0100'
020200060923                : PxObjNam_q
020300060923                : PxObjTyp
020400060923                : ERRC0100
020500060923                );
020600060923
020700060923         If  ERRC0100.BytAvl > *Zero;
020800060923           Return  *Off;
020900060923
021000060923         Else;
021100060923           Return  *On;
021200060923         EndIf;
021300060923
021400060923      /End-Free
021500060923
021600060923     P ChkObj          E
021700060923     **-- Retrieve message:  -------------------------------------------------**
021800060923     P RtvMsg          B
021900060923     D                 Pi          4096a   Varying
022000060923     D  PxMsgId                       7a   Const
022100060923     D  PxMsgDta                    512a   Const  Varying
022200060923
022300060923     **-- Local variables:
022400060923     D RTVM0100        Ds                  Qualified
022500060923     D  BytRtn                       10i 0
022600060923     D  BytAvl                       10i 0
022700060923     D  RtnMsgLen                    10i 0
022800060923     D  RtnMsgAvl                    10i 0
022900060923     D  RtnHlpLen                    10i 0
023000060923     D  RtnHlpAvl                    10i 0
023100060923     D  Msg                        4096a
023200060923     **
023300060923     D NULL            c                   ''
023400060923     D RPL_SUB_VAL     c                   '*YES'
023500060923     D NOT_FMT_CTL     c                   '*NO'
023600060923
023700060923      /Free
023800060923
023900060923        RtvMsgD( RTVM0100
024000060923               : %Size( RTVM0100 )
024100060923               : 'RTVM0100'
024200060923               : PxMsgId
024300060923               : 'QCPFMSG   *LIBL'
024400060923               : PxMsgDta
024500060923               : %Len( PxMsgDta )
024600060923               : RPL_SUB_VAL
024700060923               : NOT_FMT_CTL
024800060923               : ERRC0100
024900060923               );
025000060923
025100060923        Select;
025200060923        When  ERRC0100.BytAvl > *Zero;
025300060923          Return  NULL;
025400060923
025500060923        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
025600060923          Return  %Subst( RTVM0100.Msg
025700060923                        : RTVM0100.RtnMsgLen + 1
025800060923                        : RTVM0100.RtnHlpLen
025900060923                        );
026000060923
026100060923        Other;
026200060923          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
026300060923        EndSl;
026400060923
026500060923      /End-Free
026600060923
026700060923     P RtvMsg          E
026800041110     **-- Get runtime error number:  -----------------------------------------**
026900041110     P errno           B
027000041110     D                 Pi            10i 0
027100060923
027200060923     **-- Local variables:
027300041110     D Error           s             10i 0  Based( pError )  NoOpt
027400041110
027500041110      /Free
027600041110
027700041110        pError = sys_errno;
027800041110
027900041110        Return  Error;
028000041110
028100041110      /End-Free
028200041110
028300041110     P errno           E
028400041110     **-- Get runtime error text:  -------------------------------------------**
028500041110     P strerror        B
028600041110     D                 Pi           128a    Varying
028700041110
028800041110      /Free
028900041110
029000041110        Return  %Str( sys_strerror( errno ));
029100041110
029200041110      /End-Free
029300041110
029400041110     P strerror        E
029500040728     **-- Send diagnostic message:  ------------------------------------------**
029600040728     P SndDiagMsg      B
029700040722     D                 Pi            10i 0
029800040722     D  PxMsgId                       7a   Const
029900040722     D  PxMsgDta                    512a   Const  Varying
030000060923
030100060923     **-- Local variables:
030200040722     D MsgKey          s              4a
030300040722
030400040722      /Free
030500040722
030600040722        SndPgmMsg( PxMsgId
030700040722                 : 'QCPFMSG   *LIBL'
030800040722                 : PxMsgDta
030900040722                 : %Len( PxMsgDta )
031000040728                 : '*DIAG'
031100040722                 : '*PGMBDY'
031200040722                 : 1
031300040722                 : MsgKey
031400040722                 : ERRC0100
031500040722                 );
031600040722
031700040722        If  ERRC0100.BytAvl > *Zero;
031800040722          Return  -1;
031900040722
032000040722        Else;
032100040722          Return   0;
032200040722        EndIf;
032300040722
032400040722      /End-Free
032500040722
032600040728     P SndDiagMsg      E
032700040728     **-- Send escape message:  ----------------------------------------------**
032800040728     P SndEscMsg       B
032900040728     D                 Pi            10i 0
033000040728     D  PxMsgId                       7a   Const
033100040728     D  PxMsgDta                    512a   Const  Varying
033200060923
033300060923     **-- Local variables:
033400040728     D MsgKey          s              4a
033500040728
033600040728      /Free
033700040728
033800040728        SndPgmMsg( PxMsgId
033900040728                 : 'QCPFMSG   *LIBL'
034000040728                 : PxMsgDta
034100040728                 : %Len( PxMsgDta )
034200040728                 : '*ESCAPE'
034300040728                 : '*PGMBDY'
034400040728                 : 1
034500040728                 : MsgKey
034600040728                 : ERRC0100
034700040728                 );
034800040728
034900040728        If  ERRC0100.BytAvl > *Zero;
035000040728          Return  -1;
035100040728
035200040728        Else;
035300040728          Return   0;
035400040728        EndIf;
035500040728
035600040728      /End-Free
035700040728
035800040728     P SndEscMsg       E
