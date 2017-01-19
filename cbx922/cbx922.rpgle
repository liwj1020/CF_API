000100040808     **
000200040831     **  Program . . : CBX922
000300040831     **  Description : Process record locks - CPP
000400040808     **  Author  . . : Carsten Flensburg
000500040808     **
000600040808     **
000700040808     **  Compile options:
000800040831     **    CrtRpgMod Module( CBX922 )
000900040808     **              DbgView( *LIST )
001000040808     **
001100040831     **    CrtPgm    Pgm( CBX922 )
001200040831     **              Module( CBX922 )
001300040808     **              ActGrp( QILE )
001400040808     **
001500040702     **
001600040702     **
001700000810     **-- Header specifications:  --------------------------------------------**
001800010806     H Option( *SrcStmt )
001900040808     **-- System information:
002000040808     D PgmSts         Sds
002100040808     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
002200040808     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
002300040808     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
002400040808     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
002500040831     **-- Global variables:
002600040806     D JobIdx          s             10u 0
002700040831     **
002800040807     D FncRqs          s             10i 0
002900040807     D MsgSntInd       s             10i 0
003000040808     **
003100040807     D CmdStr          s            512a   Varying
003200040807     D MsgTyps         s             10a   Dim( 4 )
003300040806     **-- Api error data structure:
003400040806     D ERRC0100        Ds                  Qualified
003500040806     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
003600040806     D  BytAvl                       10i 0 Inz
003700040806     D  MsgId                         7a
003800010329     D                                1a
003900040806     D  MsgDta                      128a
004000040831     **-- Record lock information:  ------------------------------------------**
004100040831     D RRCD0100        Ds         65535    Qualified
004200040831     D  JobAvl                       10i 0
004300040831     D  JobRtn                       10i 0
004400040831     D  OfsJobInf                    10i 0
004500040831     D  SizJobInf                    10i 0
004600040831     **
004700040831     D JobInf          Ds                  Qualified  Based( pJobInf )
004800040831     D  JobNam                       10a
004900040831     D  JobUsr                       10a
005000040831     D  JobNbr                        6a
005100040831     D  LckSts                        1a
005200040831     D  LckStt                        1a
005300040831     D  LckRrn                       10u 0
005400040831     D  ThrId                         8a
005500040831     D  ThrHdl                       10u 0
005600040831     **-- Retrieve record locks:
005700040831     D RtvRcdLck       Pr                  ExtPgm( 'QDBRRCDL' )
005800040831     D  RlRcvVar                  65535a         Options( *VarSize )
005900040831     D  RlRcvVarLen                  10i 0 Const
006000040831     D  RlFmtNam                      8a   Const
006100040831     D  RlRcdIdInf                   48a   Const Options( *VarSize )
006200040831     D  RlMbrNam                     10a   Const
006300040831     D  RlRcdRrn                     10u 0 Const
006400040831     D  RlError                   32767a         Options( *VarSize )
006500040808     **-- Retrieve user information:
006600040808     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
006700040808     D  RuRcvVar                  32767a          Options( *VarSize )
006800040808     D  RuRcvVarLen                  10i 0 Const
006900040808     D  RuFmtNam                     10a   Const
007000040808     D  RuUsrPrf                     10a   Const
007100040808     D  RuError                   32767a          Options( *VarSize )
007200040901     **-- Retrieve object description:
007300040901     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
007400040901     D  RoRcvVar                  32767a          Options( *VarSize )
007500040901     D  RoRcvVarLen                  10i 0 Const
007600040901     D  RoFmtNam                      8a   Const
007700040901     D  RoObjNamQ                    20a   Const
007800040901     D  RoObjTyp                     10a   Const
007900040901     D  RoError                   32767a          Options( *VarSize )
008000040901     **-- Retrieve database file description:
008100040901     D RtvDbfDsc       Pr                  ExtPgm( 'QDBRTVFD' )
008200040901     D  RdRcvVar                  32767a          Options( *VarSize )
008300040901     D  RdRcvVarLen                  10i 0 Const
008400040901     D  RdFilNamRtnQ                 20a
008500040901     D  RdFmtNam                      8a   Const
008600040901     D  RdFilNamQ                    20a   Const
008700040901     D  RdRcdFmtNam                  10a   Const
008800040901     D  RdOvrPrc                      1a   Const
008900040901     D  RdSystem                     10a   Const
009000040901     D  RdFmtTyp                     10a   Const
009100040901     D  RdError                   32767a          Options( *VarSize )
009200040807     **-- Execute command:
009300040807     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
009400040807     D  XcCmd                       512a   Const  Options( *VarSize )
009500040807     D  XcCmdLen                     15p 5 Const
009600040807     D  XcCmdIGC                      3a   Const  Options( *NoPass )
009700040806     **-- Send break message:
009800040806     D SndBrkMsg       Pr                  ExtPgm( 'QMHSNDBM' )
009900040806     D  SbMsgTxt                   6000a   Const  Options( *VarSize )
010000040806     D  SbMsgTxtLen                  10i 0 Const
010100040806     D  SbMsgTyp                     10a   Const
010200040806     D  SbMsgQueQ                    20a   Const  Options( *VarSize )  Dim( 50 )
010300040806     D  SbMsgQueNbr                  10i 0 Const
010400040806     D  SbMsgQueRpy                  20a   Const
010500040806     D  SbError                   32767a          Options( *VarSize )
010600040806     D  SbCcsId                      10i 0 Const  Options( *NoPass )
010700040807     **-- Send message:
010800040807     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
010900040807     D  SmMsgTyp                     10a   Const
011000040807     D  SmDlvMod                     10a   Const
011100040807     D  SmMsgTxt                    494a   Const  Options( *VarSize )
011200040807     D  SmMsgTxtLen                  10i 0 Const
011300040813     D  SmMsgRcv                     10a   Const  Options( *VarSize ) Dim( 299 )
011400040807     D  SmMsgRcvNbr                  10i 0 Const
011500040807     D  SmMsgSntInd                  10i 0
011600040807     D  SmFncRqs                     10i 0
011700040807     D  SmError                   32767a          Options( *VarSize )
011800040807     D  SmShwSndMsgDs                 1a   Const  Options( *NoPass )
011900040807     D  SmMsgQueNam                  20a   Const  Options( *NoPass )
012000040807     D  SmNamTypInd                   4a   Const  Options( *NoPass )
012100040807     D  SmCcsId                      10i 0 Const  Options( *NoPass )
012200040807     **-- Send program message:
012300040807     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
012400040807     D  SpMsgId                       7a   Const
012500040807     D  SpMsgFq                      20a   Const
012600040807     D  SpMsgDta                    128a   Const
012700040807     D  SpMsgDtaLen                  10i 0 Const
012800040807     D  SpMsgTyp                     10a   Const
012900040807     D  SpCalStkE                    10a   Const  Options( *VarSize )
013000040807     D  SpCalStkCtr                  10i 0 Const
013100040807     D  SpMsgKey                      4a
013200040807     D  SpError                    1024a          Options( *VarSize )
013300040807     **-- Move program messages:
013400040807     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
013500040807     D  MpMsgKey                      4a   Const
013600040807     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
013700040807     D  MpNbrMsgTyps                 10i 0 Const
013800040807     D  MpToCalStkE                4102a   Const  Options( *VarSize )
013900040807     D  MpToCalStkCnt                10i 0 Const
014000040807     D  MpError                   32767a          Options( *VarSize )
014100040807     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
014200040807     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
014300040807     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
014400040807     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
014500040807     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )
014600040807
014700040808     **-- Validate special authority:
014800040808     D ValSpcAut       Pr            10i 0
014900040808     D  PxUsrPrf                     10a   Value
015000040808     D  PxSpcAut                     10a   Value
015100040901     **-- Retrieve object attribute:
015200040901     D RtvObjAtr       Pr            10a
015300040901     D  RaObjNamQ                    20a   Const
015400040901     D  RaObjTyp                     10a   Const
015500040901     **-- Get physical file name from logical:
015600040901     D GetPhyFil       Pr            20a
015700040901     D  GpFilNamQ                    20a   Const
015800040807     **-- Send escape message:
015900040807     D SndEscMsg       Pr            10i 0
016000040807     D  PxMsgId                       7a   Const
016100040807     D  PxMsgF                       10a   Const
016200040807     D  PxMsgDta                    512a   Const  Varying
016300040813     **-- Send message by type:
016400040808     D SndMsgTyp       Pr            10i 0
016500040807     D  PxMsgDta                    512a   Const  Varying
016600040808     D  PxMsgTyp                     10a   Const
016700040807
016800040807     **-- Entry parameters:
016900040831     D CBX922          Pr
017000040807     D  PxFilNamQ                    20a
017100040831     D  PxMbrNam                     10a
017200040831     D  PxRrn                        10u 0
017300040807     D  PxAction                      7a
017400040807     D  PxMsgTxt                    512a   Varying
017500040807     D  PxMsgTo                       5a
017600040813     D  PxEndOpt                      7a
017700040813     D  PxDelay                      10i 0
017800040807     **
017900040831     D CBX922          Pi
018000040807     D  PxFilNamQ                    20a
018100040831     D  PxMbrNam                     10a
018200040831     D  PxRrn                        10u 0
018300040807     D  PxAction                      7a
018400040807     D  PxMsgTxt                    512a   Varying
018500040807     D  PxMsgTo                       5a
018600040813     D  PxEndOpt                      7a
018700040813     D  PxDelay                      10i 0
018800040806
018900040806      /Free
019000040806
019100040808        If  ValSpcAut( PsUsrPrf: '*JOBCTL' ) = -1;
019200040808
019300040808          SndEscMsg( 'CPFB0CE'
019400040808                   : 'QCPFMSG'
019500040808                   : '*JOBCTL'
019600040808                   );
019700040808        Else;
019800040901          If  RtvObjAtr( PxFilNamQ: '*FILE' ) = 'LF';
019900040901            Eval  PxFilNamQ = GetPhyFil( PxFilNamQ );
020000040901          EndIf;
020100040806
020200040831          RtvRcdLck( RRCD0100
020300040831                   : %Size( RRCD0100 )
020400040831                   : 'RRCD0100'
020500040831                   : PxFilNamQ
020600040831                   : PxMbrNam
020700040831                   : PxRrn
020800040831                   : ERRC0100
020900040831                   );
021000040806
021100040808          If  ERRC0100.BytAvl = *Zero;
021200040808            ExSr  PrcLstEnt;
021300040808
021400040808          Else;
021500040808            SndEscMsg( ERRC0100.MsgId
021600040808                     : 'QCPFMSG'
021700040808                     : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
021800040808                     );
021900040807
022000040808          EndIf;
022100040808        EndIf;
022200040806
022300040807        *InLr = *On;
022400040807
022500040806        Return;
022600040806
022700040806        BegSr  PrcLstEnt;
022800040806
022900040831          pJobInf = %Addr( RRCD0100 ) + RRCD0100.OfsJobInf;
023000040806
023100040831          For  JobIdx = 1  to RRCD0100.JobRtn;
023200040806
023300040831            If  PxAction = '*BRKMSG';
023400040831              ExSr  SndNtfMsg;
023500040807
023600040831            Else;
023700040831              ExSr  RunEndJob;
023800040831            EndIf;
023900040806
024000040831            If  JobIdx < RRCD0100.JobRtn;
024100040831              pJobInf = pJobInf + RRCD0100.SizJobInf;
024200040806            EndIf;
024300040806          EndFor;
024400040806
024500040808          SndMsgTyp( 'Lock processing completed normally.': '*COMP' );
024600040808
024700040806        EndSr;
024800040806
024900040807        BegSr  RunEndJob;
025000040808
025100040831          CmdStr = 'ENDJOB JOB('                      +
025200040831                    %Trim( JobInf.JobNbr )            + '/'  +
025300040831                    %Trim( JobInf.JobUsr )            + '/'  +
025400040831                    %Trim( JobInf.JobNam )            + ') ' +
025500040831                   'OPTION(' + %Trim( PxEndOpt )      + ') ' +
025600040831                   'DELAY(' + %Char( PxDelay )        + ') ' +
025700040831                   'SPLFILE(*NO) LOGLMT(*SAME) ADLINTJOBS(*NONE)';
025800040813
025900040831          Monitor;
026000040831            ExcCmd( CmdStr: %Len( CmdStr ));
026100040807
026200040831          On-Error;
026300040831            MsgTyps(1) = '*DIAG';
026400040831            MsgTyps(2) = '*ESCAPE';
026500040807
026600040831            MovPgmMsg( *Blanks
026700040831                     : MsgTyps
026800040831                     : 2
026900040831                     : '*PGMBDY'
027000040831                     : 1
027100040831                     : ERRC0100
027200040831                     );
027300040807
027400040831            LeaveSr;
027500040831          EndMon;
027600040813
027700040831            MovPgmMsg( *Blanks
027800040831                     : '*COMP'
027900040831                     : 1
028000040831                     : '*PGMBDY'
028100040831                     : 1
028200040831                     : ERRC0100
028300040831                     );
028400040808
028500040807        EndSr;
028600040807
028700040807        BegSr  SndNtfMsg;
028800040807
028900040807          If  PxMsgTo = '*JOB';
029000040807
029100040807            SndBrkMsg( PxMsgTxt
029200040807                     : %Len( PxMsgTxt )
029300040807                     : '*INFO'
029400040831                     : JobInf.JobNam + '*LIBL'
029500040807                     : 1
029600040807                     : ' '
029700040807                     : ERRC0100
029800040807                     );
029900040820
030000040831            If  ERRC0100.BytAvl > *Zero;
030100040831
030200040831              MovPgmMsg( *Blanks
030300040831                       : '*DIAG'
030400040831                       : 1
030500040831                       : '*PGMBDY'
030600040831                       : 1
030700040831                       : ERRC0100
030800040831                       );
030900040831            EndIf;
031000040820
031100040807          Else;
031200040807
031300040807            SndMsg( '*INFO'
031400040807                  : '*BREAK'
031500040807                  : PxMsgTxt
031600040807                  : %Len( PxMsgTxt )
031700040831                  : JobInf.JobUsr
031800040807                  : 1
031900040807                  : MsgSntInd
032000040807                  : FncRqs
032100040807                  : ERRC0100
032200040807                  : 'N'
032300040807                  : *Blanks
032400040807                  : '*USR'
032500040807                  );
032600040831          EndIf;
032700040820
032800040806        EndSr;
032900040806
033000040806      /End-Free
033100040807
033200040807     **-- Send escape message:  ----------------------------------------------**
033300040807     P SndEscMsg       B
033400040807     D                 Pi            10i 0
033500040807     D  PxMsgId                       7a   Const
033600040807     D  PxMsgF                       10a   Const
033700040807     D  PxMsgDta                    512a   Const  Varying
033800040807     **
033900040807     D MsgKey          s              4a
034000040807
034100040807      /Free
034200040807
034300040807        SndPgmMsg( PxMsgId
034400040807                 : PxMsgF + '*LIBL'
034500040807                 : PxMsgDta
034600040807                 : %Len( PxMsgDta )
034700040807                 : '*ESCAPE'
034800040807                 : '*PGMBDY'
034900040807                 : 1
035000040807                 : MsgKey
035100040807                 : ERRC0100
035200040807                 );
035300040807
035400040807        If  ERRC0100.BytAvl > *Zero;
035500040807          Return  -1;
035600040807
035700040807        Else;
035800040807          Return   0;
035900040807        EndIf;
036000040807
036100040807      /End-Free
036200040807
036300040807     P SndEscMsg       E
036400040813     **-- Send message by type:  ---------------------------------------------**
036500040808     P SndMsgTyp       B
036600040807     D                 Pi            10i 0
036700040807     D  PxMsgDta                    512a   Const  Varying
036800040808     D  PxMsgTyp                     10a   Const
036900040807     **
037000040807     D MsgKey          s              4a
037100040807
037200040807      /Free
037300040807
037400040807        SndPgmMsg( 'CPF9897'
037500040807                 : 'QCPFMSG   *LIBL'
037600040807                 : PxMsgDta
037700040807                 : %Len( PxMsgDta )
037800040808                 : PxMsgTyp
037900040807                 : '*PGMBDY'
038000040807                 : 1
038100040807                 : MsgKey
038200040807                 : ERRC0100
038300040807                 );
038400040807
038500040807        If  ERRC0100.BytAvl > *Zero;
038600040807          Return  -1;
038700040807
038800040807        Else;
038900040807          Return   0;
039000040807        EndIf;
039100040807
039200040807      /End-Free
039300040807
039400040808     P SndMsgTyp       E
039500040808     **-- Validate special authority:  ---------------------------------------**
039600040808     P ValSpcAut       B                   Export
039700040808     D                 Pi            10i 0
039800040808     D  PxUsrPrf                     10a   Value
039900040808     D  PxSpcAut                     10a   Value
040000040808     **
040100040808     D USRI0200        Ds                  Qualified
040200040808     D  BytRtn                       10i 0
040300040808     D  BytAvl                       10i 0
040400040808     D  UsrPrf                       10a
040500040808     D  SpcAut                       15a   Overlay( USRI0200: 29 )
040600040808     D   AllObj                       1a   Overlay( SpcAut: 1 )
040700040808     D   SecAdm                       1a   Overlay( SpcAut: *Next )
040800040808     D   JobCtl                       1a   Overlay( SpcAut: *Next )
040900040808     D   SplCtl                       1a   Overlay( SpcAut: *Next )
041000040808     D   SavSys                       1a   Overlay( SpcAut: *Next )
041100040808     D   Service                      1a   Overlay( SpcAut: *Next )
041200040808     D   Audit                        1a   Overlay( SpcAut: *Next )
041300040808     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )
041400040808
041500040808      /Free
041600040808
041700040808        RtvUsrInf( USRI0200
041800040808                 : %Size( USRI0200 )
041900040808                 : 'USRI0200'
042000040808                 : PxUsrPrf
042100040808                 : ERRC0100
042200040808                 );
042300040808
042400040808        Select;
042500040808        When  ERRC0100.BytAvl > *Zero;
042600040808          Return -1;
042700040808
042800040808        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
042900040808          Return  0;
043000040808
043100040808        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
043200040808          Return  0;
043300040808
043400040808        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
043500040808          Return  0;
043600040808
043700040808        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
043800040808          Return  0;
043900040808
044000040808        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
044100040808          Return  0;
044200040808
044300040808        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
044400040808          Return  0;
044500040808
044600040808        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
044700040808          Return  0;
044800040808
044900040808        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
045000040808          Return  0;
045100040808
045200040808        Other;
045300040808          Return -1;
045400040808        EndSl;
045500040808
045600040808      /End-Free
045700040808
045800040808     P ValSpcAut       E
045900040901     **-- Retrieve object attribute:  ----------------------------------------**
046000040901     P RtvObjAtr       B                   Export
046100040901     D                 Pi            10a
046200040901     D  RaObjNamQ                    20a   Const
046300040901     D  RaObjTyp                     10a   Const
046400040901     **
046500040901     D OBJD0200        Ds                  Qualified
046600040901     D  BytRtn                       10i 0
046700040901     D  BytAvl                       10i 0
046800040901     D  ObjNam                       10a
046900040901     D  ObjLib                       10a
047000040901     D  ObjTypRt                     10a
047100040901     D  ObjLibRt                     10a
047200040901     D  ObjASP                       10i 0
047300040901     D  ObjOwn                       10a
047400040901     D  ObjDmn                        2a
047500040901     D  ObjCrtDT                     13a
047600040901     D  ObjChgDT                     13a
047700040901     D  ExtAtr                       10a
047800040901     D  TxtDsc                       50a
047900040901     D  SrcF                         10a
048000040901     D  SrcLib                       10a
048100040901     D  SrcMbr                       10a
048200040901
048300040901      /Free
048400040901
048500040901         RtvObjD( OBJD0200
048600040901                : %Size( OBJD0200 )
048700040901                : 'OBJD0200'
048800040901                : RaObjNamQ
048900040901                : RaObjTyp
049000040901                : ERRC0100
049100040901                );
049200040901
049300040901         If  ERRC0100.BytAvl > *Zero;
049400040901           Return  *Blanks;
049500040901
049600040901         Else;
049700040901           Return  OBJD0200.ExtAtr;
049800040901         EndIf;
049900040901
050000040901      /End-Free
050100040901
050200040901     P RtvObjAtr       E
050300040901     **-- Get physical file name from logical:  ------------------------------**
050400040901     P GetPhyFil       B                   Export
050500040901     D                 Pi            20a
050600040901     D  GpObjNamQ                    20a   Const
050700040901
050800040901     **-- Local variables:
050900040901     D PhyFilNamQ      s             20a   Inz
051000040901     D FilNamRtnQ      s             20a
051100040901     D ApiRcvSiz       s             10u 0
051200040901     D Idx             s             10i 0
051300040901     **-- FILD0100 formats:
051400040901     D Qdb_Qdbfh       Ds                  Based( pQdb_Qdbfh )  Qualified
051500040901     D  Qdbfyret                     10i 0
051600040901     D  Qdbfyavl                     10i 0
051700040901     D  Qdbfhflg                      2a
051800040901     D*  Reserved_1    :2
051900040901     D*  Qdbfhfpl      :1
052000040901     D*  Reserved_2    :1
052100040901     D*  Qdbfhfsu      :1
052200040901     D*  Reserved_3    :1
052300040901     D*  Qdbfhfky      :1
052400040901     D*  Reserved_4    :1
052500040901     D*  Qdbfhflc      :1
052600040901     D*  Qdbfkfso      :1
052700040901     D*  Reserved_5    :4
052800040901     D*  Qdbfigcd      :1
052900040901     D*  Qdbfigcl      :1
053000040901     D  Reserved_7                    4a
053100040901     D  Qdbflbnum                     5i 0
053200040901     D  Qdbfkdat                     14a
053300040901     D  Qdbfknum                      5i 0 Overlay( Qdbfkdat: 1 )
053400040901     D  Qdbfkmxl                      5i 0 Overlay( Qdbfkdat: *Next )
053500040901     D  Qdbfkflg                      1a   Overlay( Qdbfkdat: *Next )
053600040901     D*  Reserved_8    :1
053700040901     D*  Qdbfkfcs      :1
053800040901     D*  Reserved_9    :4
053900040901     D*  Qdbfkfrc      :1
054000040901     D*  Qdbfkflt      :1
054100040901     D  Qdbfkfdm                      1a   Overlay( Qdbfkdat: *Next )
054200040901     D  Reserved_10                   8a   Overlay( Qdbfkdat: *Next )
054300040901     D  Qdbfhaut                     10a
054400040901     D  Qdbfhupl                      1a
054500040901     D  Qdbfhmxm                      5i 0
054600040901     D  Qdbfwtfi                      5i 0
054700040901     D  Qdbfhfrt                      5i 0
054800040901     D  Qdbfhmnum                     5i 0
054900040901     D  Reserved_11                   9a
055000040901     D  Qdbfbrwt                      5i 0
055100040901     D  Qaaf                          1a
055200040901     D*  Reserved_12   :7
055300040901     D*  Qdbfpgmd      :1
055400040901     D  Qdbffmtnum                    5i 0
055500040901     D  Qdbfhfl2                      2a
055600040901     D*  Qdbfjnap      :1
055700040901     D*  Reserved_13   :1
055800040901     D*  Qdbfrdcp      :1
055900040901     D*  Qdbfwtcp      :1
056000040901     D*  Qdbfupcp      :1
056100040901     D*  Qdbfdlcp      :1
056200040901     D*  Reserved_14   :9
056300040901     D*  Qdbfkfnd      :1
056400040901     D  Qdbfvrm                       5i 0
056500040901     D  Qaaf2                         2a
056600040901     D*  Qdbfhmcs      :1
056700040901     D*  Reserved_15   :1
056800040901     D*  Qdbfknll      :1
056900040901     D*  Qdbf_nfld     :1
057000040901     D*  Qdbfvfld      :1
057100040901     D*  Qdbftfld      :1
057200040901     D*  Qdbfgrph      :1
057300040901     D*  Qdbfpkey      :1
057400040901     D*  Qdbfunqc      :1
057500040901     D*  Reserved_118  :2
057600040901     D*  Qdbfapsz      :1
057700040901     D*  Qdbfdisf      :1
057800040901     D*  Reserved_68   :1
057900040901     D*  Reserved_69   :1
058000040901     D*  Reserved_70   :1
058100040901     D  Qdbfhcrt                     13a
058200040901     D  Qdbfhtx                      52a
058300040901     D   Reserved_18                  2a   Overlay( Qdbfhtx: 1 )
058400040901     D   Qdbfhtxt                    50a   Overlay( Qdbfhtx: *Next )
058500040901     D  Reserved_19                  13a
058600040901     D  Qdbfsrc                      30a
058700040901     D   Qdbfsrcf                    10a   Overlay( Qdbfsrc: 1 )
058800040901     D   Qdbfsrcm                    10a   Overlay( Qdbfsrc: *Next )
058900040901     D   Qdbfsrcl                    10a   Overlay( Qdbfsrc: *Next )
059000040901     D  Qdbfkrcv                      1a
059100040901     D  Reserved_20                  23a
059200040901     D  Qdbftcid                      5i 0
059300040901     D  Qdbfasp                       2a
059400040901     D  Qdbfnbit                      1a
059500040901     D*  Qdbfhudt      :1
059600040901     D*  Qdbfhlob      :1
059700040901     D*  Qdbfhdtl      :1
059800040901     D*  Qdbfhudf      :1
059900040901     D*  Qdbfhlon      :1
060000040901     D*  Qdbfhlop      :1
060100040901     D*  Qdbfhdll      :1
060200040901     D*  Reserved_21   :1
060300040901     D  Qdbfmxfnum                    5i 0
060400040901     D  Reserved_22                  76a
060500040901     D  Qdbfodic                     10i 0
060600040901     D  Reserved_23                  14a
060700040901     D  Qdbffigl                      5i 0
060800040901     D  Qdbfmxrl                      5i 0
060900040901     D  Reserved_24                   8a
061000040901     D  Qdbfgkct                      5i 0
061100040901     D  Qdbfos                       10i 0
061200040901     D  Reserved_25                   8a
061300040901     D  Qdbfocs                      10i 0
061400040901     D  Reserved_26                   4a
061500040901     D  Qdbfpact                      2a
061600040901     D  Qdbfhrls                      6a
061700040901     D  Reserved_27                  20a
061800040901     D  Qdbpfof                      10i 0
061900040901     D  Qdblfof                      10i 0
062000040901     D  Qdbfssfp                      6a
062100040901     D   Qdbfnlsb                     1a   Overlay( Qdbfssfp: 1 )
062200040901     D*   Qdbfsscs     :3
062300040901     D*   Reserved_103 :5
062400040901     D   Qdbflang                     3a   Overlay( Qdbfssfp: *Next )
062500040901     D   Qdbfcnty                     2a   Overlay( Qdbfssfp: *Next )
062600040901     D  Qdbfjorn                     10i 0
062700040901     D  Qdbfevid                     10i 0
062800040901     D  Reserved_28                  14a
062900040901     **
063000040901     D Qdb_Qdbfb       Ds                  Qualified  Based( pQdb_Qdbfb )
063100040901     D  Reserved_48                  48a
063200040901     D  Qdbfbf                       10a
063300040901     D  Qdbfbfl                      10a
063400040901     D  Qdbft                        10a
063500040901     D  Reserved_49                  37a
063600040901     D  Qdbfbgky                      5i 0
063700040901     D  Reserved_50                   2a
063800040901     D  Qdbfblky                      5i 0
063900040901     D  Reserved_51                   2a
064000040901     D  Qdbffogl                      5i 0
064100040901     D  Reserved_52                   3a
064200040901     D  Qdbfsoon                      5i 0
064300040901     D  Qdbfsoof                     10i 0
064400040901     D  Qdbfksof                     10i 0
064500040901     D  Qdbfkyct                      5i 0
064600040901     D  Qdbfgenf                      5i 0
064700040901     D  Qdbfodis                     10i 0
064800040901     D  Reserved_53                  14a
064900040901
065000040901      /Free
065100040901
065200040901        PhyFilNamQ = GpObjNamQ;
065300040901
065400040901        ApiRcvSiz  = 65535;
065500040901        pQdb_Qdbfh = %Alloc( ApiRcvSiz );
065600040901
065700040901        DoU  Qdb_Qdbfh.Qdbfyavl <= ApiRcvSiz;
065800040901
065900040901          If  Qdb_Qdbfh.Qdbfyavl > ApiRcvSiz;
066000040901            ApiRcvSiz = Qdb_Qdbfh.Qdbfyavl;
066100040901            pQdb_Qdbfh  = %ReAlloc( pQdb_Qdbfh: ApiRcvSiz );
066200040901          EndIf;
066300040901
066400040901          RtvDbfDsc( Qdb_Qdbfh
066500040901                   : ApiRcvSiz
066600040901                   : FilNamRtnQ
066700040901                   : 'FILD0100'
066800040901                   : GpObjNamQ
066900040901                   : '*FIRST'
067000040901                   : '0'
067100040901                   : '*LCL'
067200040901                   : '*EXT'
067300040901                   : ERRC0100
067400040901                   );
067500040901        EndDo;
067600040901
067700040901        If  ERRC0100.BytAvl = *Zero;
067800040901
067900040901          pQdb_Qdbfb = pQdb_Qdbfh + Qdb_Qdbfh.Qdbfos;
068000040901
068100040901          If  Qdb_Qdbfh.Qdbflbnum = 1;
068200040901
068300040901            PhyFilNamQ = Qdb_Qdbfb.Qdbfbf + Qdb_Qdbfb.Qdbfbfl;
068400040901          EndIf;
068500040901        EndIf;
068600040901
068700040901        DeAlloc  pQdb_Qdbfh;
068800040901
068900040901        Return  PhyFilNamQ;
069000040901
069100040901      /End-Free
069200040901
069300040901     P GetPhyFil       E
