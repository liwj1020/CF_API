000100041110     **
000200061014     **  Program . . : CBX962V
000300061014     **  Description : Change Server Share - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500041110     **
000600061023     **
000700041110     **
000800041110     **  Program description:
000900060923     **    This program checks the existence of a specified IFS object or
001000060923     **    a specified output queue
001100060923     **
001200040724     **
001300031115     **  Compile options:
001400061014     **    CrtRpgMod Module( CBX962V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700061014     **    CrtPgm    Pgm( CBX962V )
001800061014     **              Module( CBX962V )
001900041203     **              ActGrp( QILE )
002000031115     **
002100031115     **
002200040605     **-- Control specification:  --------------------------------------------**
002300041110     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002400040722
002500040728     **-- API error data structure:
002600040728     D ERRC0100        Ds                  Qualified
002700040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002800040728     D  BytAvl                       10i 0
002900060924     D  MsgId                         7a
003000040728     D                                1a
003100060924     D  MsgDta                      512a
003200041110     **-- access API constants:
003300041110     D F_OK            c                   0
003400041110     D X_OK            c                   1
003500041110     D W_OK            c                   2
003600041110     D R_OK            c                   4
003700040728
003800041110     **-- IFS file functions:
003900041110     D access          Pr            10i 0 ExtProc( 'access' )
004000041110     D   Path                          *   Value  Options( *String )
004100041110     D   Amode                       10i 0 Value
004200041110     **-- Error number:
004300041110     D sys_errno       Pr              *    ExtProc( '__errno' )
004400041110     **-- Error string:
004500041110     D sys_strerror    Pr              *    ExtProc( 'strerror' )
004600041110     D  errno                        10i 0  Value
004700040728     **-- Send program message:
004800060923     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004900060923     D  MsgId                         7a   Const
005000060923     D  MsgFq                        20a   Const
005100060923     D  MsgDta                      128a   Const
005200060923     D  MsgDtaLen                    10i 0 Const
005300060923     D  MsgTyp                       10a   Const
005400060923     D  CalStkE                      10a   Const  Options( *VarSize )
005500060923     D  CalStkCtr                    10i 0 Const
005600060923     D  MsgKey                        4a
005700060923     D  Error                      1024a          Options( *VarSize )
005800060923     **-- Retrieve object description:
005900060923     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
006000060923     D  RcvVar                    32767a          Options( *VarSize )
006100060923     D  RcvVarLen                    10i 0 Const
006200060923     D  FmtNam                        8a   Const
006300060923     D  ObjNamQ                      20a   Const
006400060923     D  ObjTyp                       10a   Const
006500060923     D  Error                     32767a          Options( *VarSize )
006600060923     **-- Retrieve message description:
006700060923     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
006800060923     D  RcvVar                    32767a          Options( *VarSize )
006900060923     D  RcvVarLen                    10i 0 Const
007000060923     D  FmtNam                       10a   Const
007100060923     D  MsgId                         7a   Const
007200060923     D  MsgF_q                       20a   Const
007300060923     D  MsgDta                      512a   Const  Options( *VarSize )
007400060923     D  MsgDtaLen                    10i 0 Const
007500060923     D  RplSubVal                    10a   Const
007600060923     D  RtnFmtChr                    10a   Const
007700060923     D  Error                     32767a          Options( *VarSize )
007800060923     D  RtvOpt                       10a   Const  Options( *NoPass )
007900060923     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
008000060923     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
008100040722
008200060923     **-- Check object existence:
008300060923     D ChkObj          Pr              n
008400060923     D  PxObjNam_q                   20a   Const
008500060923     D  PxObjTyp                     10a   Const
008600060923     **-- Retrieve message:
008700060923     D RtvMsg          Pr          4096a   Varying
008800060923     D  PxMsgId                       7a   Const
008900060923     D  PxMsgDta                    512a   Const  Varying
009000040728     **-- Send diagnostic message:
009100040728     D SndDiagMsg      Pr            10i 0
009200040722     D  PxMsgId                       7a   Const
009300040722     D  PxMsgDta                    512a   Const  Varying
009400040728     **-- Send escape message:
009500040728     D SndEscMsg       Pr            10i 0
009600040728     D  PxMsgId                       7a   Const
009700040728     D  PxMsgDta                    512a   Const  Varying
009800041110     **-- Error identification:
009900041110     D errno           Pr            10i 0
010000041110     D strerror        Pr           128a   Varying
010100040722
010200060923     **-- Entry parameters:
010300060923     D ObjNam_q        Ds                  Qualified
010400060923     D  ObjNam                       10a
010500060923     D  ObjLib                       10a
010600060923     **
010700060923     D FilExt          Ds                  Qualified
010800060923     D  NbrExt                        5i 0
010900060923     D  FilExt                       46a   Varying  Dim( 128 )
011000060923     **
011100061014     D CBX962V         Pr
011200060923     D  PxShare                      12a
011300060923     D  PxShrTyp                     10a
011400060923     D  PxPthNam                   1024a   Varying
011500060923     D  PxTxtDsc                     50a
011600060923     D  PxPermis                     10i 0
011700060923     D  PxMaxUsr                     10i 0
011800060923     D  PxCcsId                      10i 0
011900060923     D  PxCnvTxt                      1a
012000060923     D  PxFilExt                           LikeDs( FilExt )
012100060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
012200060923     D  PxSpfTyp                     10i 0
012300060923     D  PxPrtDrv                     50a
012400061015     D  PxPrtFil_q                         LikeDs( ObjNam_q )
012500060923     D  PxPublish                     1a
012600040722     **
012700061014     D CBX962V         Pi
012800060923     D  PxShare                      12a
012900060923     D  PxShrTyp                     10a
013000060923     D  PxPthNam                   1024a   Varying
013100060923     D  PxTxtDsc                     50a
013200060923     D  PxPermis                     10i 0
013300060923     D  PxMaxUsr                     10i 0
013400060923     D  PxCcsId                      10i 0
013500060923     D  PxCnvTxt                      1a
013600060923     D  PxFilExt                           LikeDs( FilExt )
013700060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
013800060923     D  PxSpfTyp                     10i 0
013900060923     D  PxPrtDrv                     50a
014000061015     D  PxPrtFil_q                         LikeDs( ObjNam_q )
014100060923     D  PxPublish                     1a
014200060923
014300040724      /Free
014400040728
014500060923        If  PxShrTyp = '*FILE';
014600060923
014700061015          If  PxPthNam <> '*SAME';
014800061015
014900061015            If  access( PxPthNam: F_OK ) = -1;
015000061015              SndDiagMsg( 'CPD0006'
015100061015                        : '0000' + %Char( errno ) + ': ' + strerror
015200061015                        );
015300061015
015400061015              SndEscMsg( 'CPF0002': '' );
015500061015            EndIf;
015600061015          EndIf;
015700060923        EndIf;
015800060923
015900060923        If  PxShrTyp = '*PRINT';
016000060923
016100061015          If  PxOutQue_q <> '*SAME';
016200061015
016300061015            If  ChkObj( PxOutQue_q: '*OUTQ' ) = *Off;
016400061015              SndDiagMsg( 'CPD0006'
016500061015                        : '0000' +
016600061015                          RtvMsg( 'CPF2105': PxOutQue_q + 'OUTQ' )
016700061015                        );
016800061015
016900061015              SndEscMsg( 'CPF0002': '' );
017000061015            EndIf;
017100060923          EndIf;
017200060923
017300061015          If  PxPrtFil_q <> '*SAME';
017400061015
017500061015            If  PxPrtFil_q.ObjNam > *Blanks;
017600061015
017700061015              If  ChkObj( PxPrtFil_q: '*FILE' ) = *Off;
017800061015                SndDiagMsg( 'CPD0006'
017900061015                          : '0000' +
018000061015                            RtvMsg( 'CPF2105': PxPrtFil_q + 'FILE' )
018100061015                          );
018200061015
018300061015                SndEscMsg( 'CPF0002': '' );
018400061015              EndIf;
018500061015            EndIf;
018600061015          EndIf;
018700060923        EndIf;
018800040728
018900040605        *InLr = *On;
019000040605        Return;
019100040605
019200040605
019300040721      /End-Free
019400040721
019500060923     **-- Check object existence:  -------------------------------------------**
019600060923     P ChkObj          B                   Export
019700060923     D                 Pi              n
019800060923     D  PxObjNam_q                   20a   Const
019900060923     D  PxObjTyp                     10a   Const
020000060923
020100060923     **-- Local variables:
020200060923     D OBJD0100        Ds                  Qualified
020300060923     D  BytRtn                       10i 0
020400060923     D  BytAvl                       10i 0
020500060923     D  ObjNam                       10a
020600060923     D  ObjLib                       10a
020700060923     D  ObjTyp                       10a
020800060923
020900060923      /Free
021000060923
021100060923         RtvObjD( OBJD0100
021200060923                : %Size( OBJD0100 )
021300060923                : 'OBJD0100'
021400060923                : PxObjNam_q
021500060923                : PxObjTyp
021600060923                : ERRC0100
021700060923                );
021800060923
021900060923         If  ERRC0100.BytAvl > *Zero;
022000060923           Return  *Off;
022100060923
022200060923         Else;
022300060923           Return  *On;
022400060923         EndIf;
022500060923
022600060923      /End-Free
022700060923
022800060923     P ChkObj          E
022900060923     **-- Retrieve message:  -------------------------------------------------**
023000060923     P RtvMsg          B
023100060923     D                 Pi          4096a   Varying
023200060923     D  PxMsgId                       7a   Const
023300060923     D  PxMsgDta                    512a   Const  Varying
023400060923
023500060923     **-- Local variables:
023600060923     D RTVM0100        Ds                  Qualified
023700060923     D  BytRtn                       10i 0
023800060923     D  BytAvl                       10i 0
023900060923     D  RtnMsgLen                    10i 0
024000060923     D  RtnMsgAvl                    10i 0
024100060923     D  RtnHlpLen                    10i 0
024200060923     D  RtnHlpAvl                    10i 0
024300060923     D  Msg                        4096a
024400060923     **
024500060923     D NULL            c                   ''
024600060923     D RPL_SUB_VAL     c                   '*YES'
024700060923     D NOT_FMT_CTL     c                   '*NO'
024800060923
024900060923      /Free
025000060923
025100060923        RtvMsgD( RTVM0100
025200060923               : %Size( RTVM0100 )
025300060923               : 'RTVM0100'
025400060923               : PxMsgId
025500060923               : 'QCPFMSG   *LIBL'
025600060923               : PxMsgDta
025700060923               : %Len( PxMsgDta )
025800060923               : RPL_SUB_VAL
025900060923               : NOT_FMT_CTL
026000060923               : ERRC0100
026100060923               );
026200060923
026300060923        Select;
026400060923        When  ERRC0100.BytAvl > *Zero;
026500060923          Return  NULL;
026600060923
026700060923        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
026800060923          Return  %Subst( RTVM0100.Msg
026900060923                        : RTVM0100.RtnMsgLen + 1
027000060923                        : RTVM0100.RtnHlpLen
027100060923                        );
027200060923
027300060923        Other;
027400060923          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
027500060923        EndSl;
027600060923
027700060923      /End-Free
027800060923
027900060923     P RtvMsg          E
028000041110     **-- Get runtime error number:  -----------------------------------------**
028100041110     P errno           B
028200041110     D                 Pi            10i 0
028300060923
028400060923     **-- Local variables:
028500041110     D Error           s             10i 0  Based( pError )  NoOpt
028600041110
028700041110      /Free
028800041110
028900041110        pError = sys_errno;
029000041110
029100041110        Return  Error;
029200041110
029300041110      /End-Free
029400041110
029500041110     P errno           E
029600041110     **-- Get runtime error text:  -------------------------------------------**
029700041110     P strerror        B
029800041110     D                 Pi           128a    Varying
029900041110
030000041110      /Free
030100041110
030200041110        Return  %Str( sys_strerror( errno ));
030300041110
030400041110      /End-Free
030500041110
030600041110     P strerror        E
030700040728     **-- Send diagnostic message:  ------------------------------------------**
030800040728     P SndDiagMsg      B
030900040722     D                 Pi            10i 0
031000040722     D  PxMsgId                       7a   Const
031100040722     D  PxMsgDta                    512a   Const  Varying
031200060923
031300060923     **-- Local variables:
031400040722     D MsgKey          s              4a
031500040722
031600040722      /Free
031700040722
031800040722        SndPgmMsg( PxMsgId
031900040722                 : 'QCPFMSG   *LIBL'
032000040722                 : PxMsgDta
032100040722                 : %Len( PxMsgDta )
032200040728                 : '*DIAG'
032300040722                 : '*PGMBDY'
032400040722                 : 1
032500040722                 : MsgKey
032600040722                 : ERRC0100
032700040722                 );
032800040722
032900040722        If  ERRC0100.BytAvl > *Zero;
033000040722          Return  -1;
033100040722
033200040722        Else;
033300040722          Return   0;
033400040722        EndIf;
033500040722
033600040722      /End-Free
033700040722
033800040728     P SndDiagMsg      E
033900040728     **-- Send escape message:  ----------------------------------------------**
034000040728     P SndEscMsg       B
034100040728     D                 Pi            10i 0
034200040728     D  PxMsgId                       7a   Const
034300040728     D  PxMsgDta                    512a   Const  Varying
034400060923
034500060923     **-- Local variables:
034600040728     D MsgKey          s              4a
034700040728
034800040728      /Free
034900040728
035000040728        SndPgmMsg( PxMsgId
035100040728                 : 'QCPFMSG   *LIBL'
035200040728                 : PxMsgDta
035300040728                 : %Len( PxMsgDta )
035400040728                 : '*ESCAPE'
035500040728                 : '*PGMBDY'
035600040728                 : 1
035700040728                 : MsgKey
035800040728                 : ERRC0100
035900040728                 );
036000040728
036100040728        If  ERRC0100.BytAvl > *Zero;
036200040728          Return  -1;
036300040728
036400040728        Else;
036500040728          Return   0;
036600040728        EndIf;
036700040728
036800040728      /End-Free
036900040728
037000040728     P SndEscMsg       E
