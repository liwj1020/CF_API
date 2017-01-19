000100040808     **
000200040808     **  Program . . : CBX920
000300040808     **  Description : Process file locks - CPP
000400040808     **  Author  . . : Carsten Flensburg
000500040808     **
000600040808     **
000700040808     **  Compile options:
000800040808     **    CrtRpgMod Module( CBX920 )
000900040808     **              DbgView( *LIST )
001000040808     **
001100040808     **    CrtPgm    Pgm( CBX920 )
001200040808     **              Module( CBX920 )
001300040808     **              ActGrp( QILE )
001400040808     **
001500040808     **
001600040808     **  PTF issues for QDBRJBRL API:
001700040808     **    V4R5: SA95609, SA95800
001800040808     **    V5R1: SE07985
001900040702     **
002000040702     **
002100000810     **-- Header specifications:  --------------------------------------------**
002200010806     H Option( *SrcStmt )
002300040808     **-- System information:
002400040808     D PgmSts         Sds
002500040808     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
002600040808     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
002700040808     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
002800040808     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
002900040806     **-- Global variables & constants:
003000040806     D JobIdx          s             10u 0
003100040806     D RcdIdx          s             10u 0
003200040807     D PrcIdx          s             10u 0
003300040808     D MaxIdx          s             10u 0
003400040808     **
003500040807     D FncRqs          s             10i 0
003600040807     D MsgSntInd       s             10i 0
003700040808     **
003800040806     D PrdRcdLck       s               n
003900040807     D CmdStr          s            512a   Varying
004000040807     D MsgTyps         s             10a   Dim( 4 )
004100040808     D PrcJobIds       s             26a   Dim( 4096 )
004200040806     **
004300040806     D USRSPC          c                   'LSTOBJLCK QTEMP'
004400040806     D PROD_LIB        c                   '0'
004500040806     **-- Api error data structure:
004600040806     D ERRC0100        Ds                  Qualified
004700040806     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
004800040806     D  BytAvl                       10i 0 Inz
004900040806     D  MsgId                         7a
005000010329     D                                1a
005100040806     D  MsgDta                      128a
005200040806     **-- API header information:
005300040806     D ApiHdrInf       Ds                  Qualified  Based( pHdrInf )
005400040806     D  UsrSpcU                      10a
005500040806     D  UsrLibU                      10a
005600040806     D  ObjNamU                      10a
005700040806     D  ObjLibU                      10a
005800040806     D  ObjTypR                      10a
005900040806     D  ObjExtAtr                    10a
006000040806     D  ShrFilNam                    10a
006100040806     D  ShrFilLib                    10a
006200040806     D  OfsPthNamU                   10i 0
006300040806     D  LenPthNamU                   10i 0
006400040806     D  ObjNamAspU                   10a
006500040806     D  ObjLibAspU                   10a
006600040806     **-- User space generic header:
006700040806     D UsrSpcHdr       Ds                  Qualified  Based( pUsrSpc )
006800040806     D  OfsHdr                       10i 0 Overlay( UsrSpcHdr: 117 )
006900040806     D  OfsLst                       10i 0 Overlay( UsrSpcHdr: 125 )
007000040806     D  NumLstEnt                    10i 0 Overlay( UsrSpcHdr: 133 )
007100040806     D  SizLstEnt                    10i 0 Overlay( UsrSpcHdr: 137 )
007200040806     **-- User space pointers:
007300010806     D pUsrSpc         s               *   Inz( *Null )
007400010806     D pHdrInf         s               *   Inz( *Null )
007500010806     D pLstEnt         s               *   Inz( *Null )
007600040806     **-- Object lock entry:
007700040806     D OBJL0100        DS                  Qualified  Based( pLstEnt )
007800040806     D  JobNamQ                      26a
007900040806     D   JobNam                      10a   Overlay( JobNamQ:  1 )
008000040806     D   JobUsr                      10a   Overlay( JobNamQ: 11 )
008100040806     D   JobNbr                       6a   Overlay( JobNamQ: 21 )
008200040806     D  LckStt                       10a
008300040806     D  LckSts                       10i 0
008400040806     D  LckTyp                       10i 0
008500040806     D  MbrNam                       10a
008600040806     D  Share                         1a
008700040806     D  LckScp                        1a
008800040806     D  ThdId                         8a
008900040806     **-- Job lock information:
009000040806     D RJBL0100        Ds         65535    Qualified
009100040806     D  LckAvl                       10i 0
009200040806     D  LckRtn                       10i 0
009300040806     D  OfsLckInf                    10i 0
009400040806     D  SizLckInf                    10i 0
009500040806     **
009600040806     D LckInf          Ds                  Qualified  Based( pLckInf )
009700040806     D  DbFilNam                     10a
009800040806     D  DbFilLib                     10a
009900040806     D  DbFilMbr                     10a
010000040806     D  LckSts                        1a
010100040806     D  LckStt                        1a
010200040806     D  LckRrn                       10u 0
010300040806     **-- Library information:
010400040806     D LibInf          Ds                  Qualified
010500040806     D  BytRtn                       10i 0
010600040806     D  BytAvl                       10i 0
010700040806     D  VarRtn                       10i 0
010800040806     D  VarAvl                       10i 0
010900040806     **
011000040806     D  RtnDtaLen                    10i 0
011100040806     D  KeyId                        10i 0
011200040806     D  FldSiz                       10i 0
011300040806     D  LibTyp                        1a
011400040806     **
011500040806     D RcvAtr          Ds                  Qualified
011600040806     D  NbrAtr                       10i 0 Inz( 1 )
011700040806     D  AtrAvl                       10i 0 Inz( 1 )
011800040806     **-- Create user space:
011900000726     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
012000000726     D  CsSpcNamQ                    20a   Const
012100000726     D  CsExtAtr                     10a   Const
012200000726     D  CsInzSiz                     10i 0 Const
012300000726     D  CsInzVal                      1a   Const
012400000726     D  CsPubAut                     10a   Const
012500000726     D  CsText                       50a   Const
012600040808     D  CsReplace                    10a   Const  Options( *NoPass )
012700040808     D  CsError                   32767a          Options( *NoPass: *VarSize )
012800040808     D  CsDomain                     10a   Const  Options( *NoPass )
012900040806     **-- Delete user space:
013000000726     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
013100000726     D  DsSpcNamQ                    20a   Const
013200040808     D  DsError                   32767a          Options( *VarSize )
013300040806     **-- Retrieve pointer to user space:
013400010806     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
013500010806     D  RpSpcNamQ                    20a   Const
013600010806     D  RpPointer                      *
013700040808     D  RpError                   32767a          Options( *NoPass: *VarSize )
013800040806     **-- List object locks:
013900030602     D LstObjLck       Pr                  ExtPgm( 'QWCLOBJL' )
014000030602     D  OlSpcNamQ                    20a   Const
014100030602     D  OlFmtNam                      8a   Const
014200030602     D  OlObjNamQ                    20a   Const
014300030602     D  OlObjTyp                     10a   Const
014400030602     D  OlMbrNam                     10a   Const
014500030602     D  OlError                   32767a          Options( *VarSize )
014600030602     D  OlPthNam                   1024a   Const  Options( *NoPass:  *VarSize )
014700030602     D  OlPthNamLen                  10i 0 Const  Options( *NoPass )
014800030602     D  OlObjAspQ                    10a   Const  Options( *NoPass )
014900040806     **-- Retrieve job record locks:
015000040806     D RtvJobLck       Pr                  ExtPgm( 'QDBRJBRL' )
015100040806     D  JlRcvVar                  65535a          Options( *VarSize )
015200040806     D  JlRcvVarLen                  10i 0 Const
015300040806     D  JlFmtNam                      8a   Const
015400040806     D  JlJobNam                     26a   Const
015500040806     D  JlError                   32767a          Options( *VarSize )
015600040808     **-- Retrieve user information:
015700040808     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
015800040808     D  RuRcvVar                  32767a          Options( *VarSize )
015900040808     D  RuRcvVarLen                  10i 0 Const
016000040808     D  RuFmtNam                     10a   Const
016100040808     D  RuUsrPrf                     10a   Const
016200040808     D  RuError                   32767a          Options( *VarSize )
016300040806     **-- Retrieve library information:
016400040806     D RtvLibInf       Pr                  ExtPgm( 'QLIRLIBD' )
016500040806     D  RlRcvVar                   1024a          Options( *VarSize )
016600040806     D  RlRcvVarLen                  10i 0 Const
016700040806     D  RlLibNam                     10a   Const
016800040806     D  RlRcvAtr                   1024a   Const  Options( *VarSize )
016900040806     D  RlError                   32767a          Options( *VarSize )
017000040807     **-- Retrieve object description:
017100040807     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
017200040807     D  RoRcvVar                  32767a          Options( *VarSize )
017300040807     D  RoRcvVarLen                  10i 0 Const
017400040807     D  RoFmtNam                      8a   Const
017500040807     D  RoObjNamQ                    20a   Const
017600040807     D  RoObjTyp                     10a   Const
017700040807     D  RoError                   32767a          Options( *VarSize )
017800040807     **-- Execute command:
017900040807     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
018000040807     D  XcCmd                       512a   Const  Options( *VarSize )
018100040807     D  XcCmdLen                     15p 5 Const
018200040807     D  XcCmdIGC                      3a   Const  Options( *NoPass )
018300040806     **-- Send break message:
018400040806     D SndBrkMsg       Pr                  ExtPgm( 'QMHSNDBM' )
018500040806     D  SbMsgTxt                   6000a   Const  Options( *VarSize )
018600040806     D  SbMsgTxtLen                  10i 0 Const
018700040806     D  SbMsgTyp                     10a   Const
018800040806     D  SbMsgQueQ                    20a   Const  Options( *VarSize )  Dim( 50 )
018900040806     D  SbMsgQueNbr                  10i 0 Const
019000040806     D  SbMsgQueRpy                  20a   Const
019100040806     D  SbError                   32767a          Options( *VarSize )
019200040806     D  SbCcsId                      10i 0 Const  Options( *NoPass )
019300040807     **-- Send message:
019400040807     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
019500040807     D  SmMsgTyp                     10a   Const
019600040807     D  SmDlvMod                     10a   Const
019700040807     D  SmMsgTxt                    494a   Const  Options( *VarSize )
019800040807     D  SmMsgTxtLen                  10i 0 Const
019900040813     D  SmMsgRcv                     10a   Const  Options( *VarSize ) Dim( 299 )
020000040807     D  SmMsgRcvNbr                  10i 0 Const
020100040807     D  SmMsgSntInd                  10i 0
020200040807     D  SmFncRqs                     10i 0
020300040807     D  SmError                   32767a          Options( *VarSize )
020400040807     D  SmShwSndMsgDs                 1a   Const  Options( *NoPass )
020500040807     D  SmMsgQueNam                  20a   Const  Options( *NoPass )
020600040807     D  SmNamTypInd                   4a   Const  Options( *NoPass )
020700040807     D  SmCcsId                      10i 0 Const  Options( *NoPass )
020800040807     **-- Send program message:
020900040807     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
021000040807     D  SpMsgId                       7a   Const
021100040807     D  SpMsgFq                      20a   Const
021200040807     D  SpMsgDta                    128a   Const
021300040807     D  SpMsgDtaLen                  10i 0 Const
021400040807     D  SpMsgTyp                     10a   Const
021500040807     D  SpCalStkE                    10a   Const  Options( *VarSize )
021600040807     D  SpCalStkCtr                  10i 0 Const
021700040807     D  SpMsgKey                      4a
021800040807     D  SpError                    1024a          Options( *VarSize )
021900040807     **-- Move program messages:
022000040807     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
022100040807     D  MpMsgKey                      4a   Const
022200040807     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
022300040807     D  MpNbrMsgTyps                 10i 0 Const
022400040807     D  MpToCalStkE                4102a   Const  Options( *VarSize )
022500040807     D  MpToCalStkCnt                10i 0 Const
022600040807     D  MpError                   32767a          Options( *VarSize )
022700040807     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
022800040807     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
022900040807     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
023000040807     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
023100040807     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )
023200040807
023300040808     **-- Validate special authority:
023400040808     D ValSpcAut       Pr            10i 0
023500040808     D  PxUsrPrf                     10a   Value
023600040808     D  PxSpcAut                     10a   Value
023700040808     **-- Set member option:
023800040808     D SetMbrOpt       Pr            10a
023900040808     D  RaFilNamQ                    20a   Const
024000040807     **-- Send escape message:
024100040807     D SndEscMsg       Pr            10i 0
024200040807     D  PxMsgId                       7a   Const
024300040807     D  PxMsgF                       10a   Const
024400040807     D  PxMsgDta                    512a   Const  Varying
024500040813     **-- Send message by type:
024600040808     D SndMsgTyp       Pr            10i 0
024700040807     D  PxMsgDta                    512a   Const  Varying
024800040808     D  PxMsgTyp                     10a   Const
024900040807
025000040807     **-- Entry parameters:
025100040807     D CBX920          Pr
025200040807     D  PxFilNamQ                    20a
025300040807     D  PxAction                      7a
025400040807     D  PxMsgTxt                    512a   Varying
025500040807     D  PxMsgTo                       5a
025600040813     D  PxEndOpt                      7a
025700040813     D  PxDelay                      10i 0
025800040807     D  PxIgnRcdLck                   4a
025900040807     **
026000040807     D CBX920          Pi
026100040807     D  PxFilNamQ                    20a
026200040807     D  PxAction                      7a
026300040807     D  PxMsgTxt                    512a   Varying
026400040807     D  PxMsgTo                       5a
026500040813     D  PxEndOpt                      7a
026600040813     D  PxDelay                      10i 0
026700040807     D  PxIgnRcdLck                   4a
026800040806
026900040806      /Free
027000040806
027100040808        If  ValSpcAut( PsUsrPrf: '*JOBCTL' ) = -1;
027200040808
027300040808          SndEscMsg( 'CPFB0CE'
027400040808                   : 'QCPFMSG'
027500040808                   : '*JOBCTL'
027600040808                   );
027700040808        Else;
027800040808
027900040808          CrtUsrSpc( USRSPC
028000040808                   : *Blanks
028100040808                   : 65535
028200040808                   : x'00'
028300040808                   : '*CHANGE'
028400040808                   : *Blanks
028500040808                   : '*YES'
028600040808                   : ERRC0100
028700040808                   );
028800040806
028900040808          LstObjLck( USRSPC
029000040808                   : 'OBJL0100'
029100040808                   : PxFilNamQ
029200040808                   : '*FILE'
029300040808                   : SetMbrOpt( PxFilNamQ )
029400040808                   : ERRC0100
029500040808                   );
029600040806
029700040808          If  ERRC0100.BytAvl = *Zero;
029800040808            ExSr  PrcLstEnt;
029900040808
030000040808          Else;
030100040808            SndEscMsg( ERRC0100.MsgId
030200040808                     : 'QCPFMSG'
030300040808                     : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
030400040808                     );
030500040807
030600040808          EndIf;
030700040808        EndIf;
030800040806
030900040806        DltUsrSpc( USRSPC: ERRC0100 );
031000040806
031100040807        *InLr = *On;
031200040807
031300040806        Return;
031400040806
031500040806        BegSr  PrcLstEnt;
031600040806
031700040806          RtvPtrSpc( USRSPC: pUsrSpc );
031800040806
031900040806          pHdrInf = pUsrSpc + UsrSpcHdr.OfsHdr;
032000040806          pLstEnt = pUsrSpc + UsrSpcHdr.OfsLst;
032100040806
032200040806          For  JobIdx = 1  to UsrSpcHdr.NumLstEnt;
032300040806
032400040808            If  %Lookup( OBJL0100.JobNamQ: PrcJobIds: 1: MaxIdx ) = *Zero;
032500040807
032600040808              ExSr  LodJobId;
032700040807
032800040807              If  PxAction = '*BRKMSG';
032900040807                ExSr  SndNtfMsg;
033000040807
033100040807              Else;
033200040807                ExSr  RunEndJob;
033300040807              EndIf;
033400040807            EndIf;
033500040806
033600040806            If  JobIdx < UsrSpcHdr.NumLstEnt;
033700040806              pLstEnt = pLstEnt + UsrSpcHdr.SizLstEnt;
033800040806            EndIf;
033900040806          EndFor;
034000040806
034100040808          SndMsgTyp( 'Lock processing completed normally.': '*COMP' );
034200040808
034300040806        EndSr;
034400040808
034500040808        BegSr  LodJobId;
034600040808
034700040808          If  PrcIdx < %Elem( PrcJobIds );
034800040808            PrcIdx = PrcIdx + 1;
034900040808
035000040808            If  PrcIdx > MaxIdx;
035100040808              MaxIdx = PrcIdx;
035200040808            EndIf;
035300040808
035400040808          Else;
035500040808            PrcIdx = 1;
035600040808          EndIf;
035700040808
035800040808          PrcJobIds(PrcIdx) = OBJL0100.JobNamQ;
035900040808
036000040808        EndSr;
036100040806
036200040807        BegSr  RunEndJob;
036300040808
036400040808          If  PxIgnRcdLck = '*NO';
036500040808            ExSr  ChkRcdLck;
036600040808          EndIf;
036700040807
036800040808          If  PxIgnRcdLck = '*YES'  Or
036900040808              PrdRcdLck   = *Off;
037000040808
037100040808            CmdStr = 'ENDJOB JOB('                       +
037200040808                      %Trim( OBJL0100.JobNbr )           + '/'  +
037300040808                      %Trim( OBJL0100.JobUsr )           + '/'  +
037400040808                      %Trim( OBJL0100.JobNam )           + ') ' +
037500040813                     'OPTION(' + %Trim( PxEndOpt )       + ') ' +
037600040813                     'DELAY(' + %Char( PxDelay )         + ') ' +
037700040813                     'SPLFILE(*NO) LOGLMT(*SAME) ADLINTJOBS(*NONE)';
037800040813
037900040808            Monitor;
038000040808              ExcCmd( CmdStr: %Len( CmdStr ));
038100040807
038200040808            On-Error;
038300040808              MsgTyps(1) = '*DIAG';
038400040808              MsgTyps(2) = '*ESCAPE';
038500040807
038600040808              MovPgmMsg( *Blanks
038700040808                       : MsgTyps
038800040808                       : 2
038900040808                       : '*PGMBDY'
039000040808                       : 1
039100040808                       : ERRC0100
039200040808                       );
039300040807
039400040813              LeaveSr;
039500040808            EndMon;
039600040813
039700040808              MovPgmMsg( *Blanks
039800040808                       : '*COMP'
039900040808                       : 1
040000040808                       : '*PGMBDY'
040100040808                       : 1
040200040808                       : ERRC0100
040300040808                       );
040400040808          EndIf;
040500040808
040600040807        EndSr;
040700040807
040800040806        BegSr  ChkRcdLck;
040900040806
041000040806          Eval  PrdRcdLck = *Off;
041100040806
041200040806          RtvJobLck( RJBL0100
041300040806                   : %Size( RJBL0100 )
041400040806                   : 'RJBL0100'
041500040806                   : OBJL0100.JobNam + OBJL0100.JobUsr + OBJL0100.JobNbr
041600040806                   : ERRC0100
041700040806                   );
041800040806
041900040806          If  ERRC0100.BytAvl = *Zero;
042000040806            ExSr  PrcJobLck;
042100040806          EndIf;
042200040806
042300040807        EndSr;
042400040807
042500040807        BegSr  SndNtfMsg;
042600040807
042700040807          If  PxMsgTo = '*JOB';
042800040807
042900040807            SndBrkMsg( PxMsgTxt
043000040807                     : %Len( PxMsgTxt )
043100040807                     : '*INFO'
043200040807                     : OBJL0100.JobNam + '*LIBL'
043300040807                     : 1
043400040807                     : ' '
043500040807                     : ERRC0100
043600040807                     );
043700040820
043800040820        If  ERRC0100.BytAvl > *Zero;
043900040820
044000040820          MovPgmMsg( *Blanks
044100040820                   : '*DIAG'
044200040820                   : 1
044300040820                   : '*PGMBDY'
044400040820                   : 1
044500040820                   : ERRC0100
044600040820                   );
044700040820        EndIf;
044800040820
044900040807          Else;
045000040807
045100040807            SndMsg( '*INFO'
045200040807                  : '*BREAK'
045300040807                  : PxMsgTxt
045400040807                  : %Len( PxMsgTxt )
045500040807                  : OBJL0100.JobUsr
045600040807                  : 1
045700040807                  : MsgSntInd
045800040807                  : FncRqs
045900040807                  : ERRC0100
046000040807                  : 'N'
046100040807                  : *Blanks
046200040807                  : '*USR'
046300040807                  );
046400040807        EndIf;
046500040820
046600040806        EndSr;
046700040806
046800040806        BegSr  PrcJobLck;
046900040806
047000040806          pLckInf = %Addr( RJBL0100 ) + RJBL0100.OfsLckInf;
047100040806
047200040806          For  RcdIdx = 1  to RJBL0100.LckRtn;
047300040806
047400040806            RtvLibInf( LibInf
047500040806                     : %Size( LibInf )
047600040806                     : LckInf.DbFilLib
047700040806                     : RcvAtr
047800040806                     : ERRC0100
047900040806                     );
048000040806
048100040806            If  ERRC0100.BytAvl = *Zero  And
048200040806                LibInf.LibTyp   = PROD_LIB;
048300040806
048400040808              SndMsgTyp( 'Job '              + %TrimR( OBJL0100.JobNam ) +
048500040808                         ' has locked file ' + %TrimR( LckInf.DbFilNam ) +
048600040808                         ' record number '   + %Char( LckInf.LckRrn )    +
048700040808                         ', job not ended.'
048800040808                       : '*INFO'
048900040808                       );
049000040808
049100040808              Eval  PrdRcdLck = *On;
049200040806              Leave;
049300040806            EndIf;
049400040806
049500040806            If  RcdIdx < RJBL0100.LckRtn;
049600040806              Eval  pLckInf = pLckInf + RJBL0100.SizLckInf;
049700040806            EndIf;
049800040806          EndFor;
049900040806
050000040806        EndSr;
050100040806
050200040806      /End-Free
050300040807
050400040807     **-- Send escape message:  ----------------------------------------------**
050500040807     P SndEscMsg       B
050600040807     D                 Pi            10i 0
050700040807     D  PxMsgId                       7a   Const
050800040807     D  PxMsgF                       10a   Const
050900040807     D  PxMsgDta                    512a   Const  Varying
051000040807     **
051100040807     D MsgKey          s              4a
051200040807
051300040807      /Free
051400040807
051500040807        SndPgmMsg( PxMsgId
051600040807                 : PxMsgF + '*LIBL'
051700040807                 : PxMsgDta
051800040807                 : %Len( PxMsgDta )
051900040807                 : '*ESCAPE'
052000040807                 : '*PGMBDY'
052100040807                 : 1
052200040807                 : MsgKey
052300040807                 : ERRC0100
052400040807                 );
052500040807
052600040807        If  ERRC0100.BytAvl > *Zero;
052700040807          Return  -1;
052800040807
052900040807        Else;
053000040807          Return   0;
053100040807        EndIf;
053200040807
053300040807      /End-Free
053400040807
053500040807     P SndEscMsg       E
053600040813     **-- Send message by type:  ---------------------------------------------**
053700040808     P SndMsgTyp       B
053800040807     D                 Pi            10i 0
053900040807     D  PxMsgDta                    512a   Const  Varying
054000040808     D  PxMsgTyp                     10a   Const
054100040807     **
054200040807     D MsgKey          s              4a
054300040807
054400040807      /Free
054500040807
054600040807        SndPgmMsg( 'CPF9897'
054700040807                 : 'QCPFMSG   *LIBL'
054800040807                 : PxMsgDta
054900040807                 : %Len( PxMsgDta )
055000040808                 : PxMsgTyp
055100040807                 : '*PGMBDY'
055200040807                 : 1
055300040807                 : MsgKey
055400040807                 : ERRC0100
055500040807                 );
055600040807
055700040807        If  ERRC0100.BytAvl > *Zero;
055800040807          Return  -1;
055900040807
056000040807        Else;
056100040807          Return   0;
056200040807        EndIf;
056300040807
056400040807      /End-Free
056500040807
056600040808     P SndMsgTyp       E
056700040808     **-- Set member option:  ------------------------------------------------**
056800040808     P SetMbrOpt       B                   Export
056900040807     D                 Pi            10a
057000040808     D  RaFilNamQ                    20a   Const
057100040807     **
057200040807     D OBJD0200        Ds                  Qualified
057300040807     D  BytRtn                       10i 0
057400040807     D  BytAvl                       10i 0
057500040807     D  ObjNam                       10a
057600040807     D  ObjLib                       10a
057700040807     D  ObjTypRt                     10a
057800040807     D  ObjLibRt                     10a
057900040807     D  ObjASP                       10i 0
058000040807     D  ObjOwn                       10a
058100040807     D  ObjDmn                        2a
058200040807     D  ObjCrtDT                     13a
058300040807     D  ObjChgDT                     13a
058400040807     D  ExtAtr                       10a
058500040807     D  TxtDsc                       50a
058600040807     D  SrcF                         10a
058700040807     D  SrcLib                       10a
058800040807     D  SrcMbr                       10a
058900040807
059000040807      /Free
059100040807
059200040807         RtvObjD( OBJD0200
059300040807                : %Size( OBJD0200 )
059400040807                : 'OBJD0200'
059500040808                : RaFilNamQ
059600040808                : '*FILE'
059700040807                : ERRC0100
059800040807                );
059900040807
060000040808         Select;
060100040808         When  ERRC0100.BytAvl > *Zero;
060200040808           Return  '*NONE';
060300040808
060400040808         When  OBJD0200.ExtAtr = 'PF'  Or
060500040808               OBJD0200.ExtAtr = 'LF';
060600040808           Return  '*ALL';
060700040808
060800040808         Other;
060900040808           Return  '*NONE';
061000040808         EndSl;
061100040807
061200040807         Return    OBJD0200.ExtAtr;
061300040807
061400040807      /End-Free
061500040807
061600040808     P SetMbrOpt       E
061700040808     **-- Validate special authority:  ---------------------------------------**
061800040808     P ValSpcAut       B                   Export
061900040808     D                 Pi            10i 0
062000040808     D  PxUsrPrf                     10a   Value
062100040808     D  PxSpcAut                     10a   Value
062200040808     **
062300040808     D USRI0200        Ds                  Qualified
062400040808     D  BytRtn                       10i 0
062500040808     D  BytAvl                       10i 0
062600040808     D  UsrPrf                       10a
062700040808     D  SpcAut                       15a   Overlay( USRI0200: 29 )
062800040808     D   AllObj                       1a   Overlay( SpcAut: 1 )
062900040808     D   SecAdm                       1a   Overlay( SpcAut: *Next )
063000040808     D   JobCtl                       1a   Overlay( SpcAut: *Next )
063100040808     D   SplCtl                       1a   Overlay( SpcAut: *Next )
063200040808     D   SavSys                       1a   Overlay( SpcAut: *Next )
063300040808     D   Service                      1a   Overlay( SpcAut: *Next )
063400040808     D   Audit                        1a   Overlay( SpcAut: *Next )
063500040808     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )
063600040808
063700040808      /Free
063800040808
063900040808        RtvUsrInf( USRI0200
064000040808                 : %Size( USRI0200 )
064100040808                 : 'USRI0200'
064200040808                 : PxUsrPrf
064300040808                 : ERRC0100
064400040808                 );
064500040808
064600040808        Select;
064700040808        When  ERRC0100.BytAvl > *Zero;
064800040808          Return -1;
064900040808
065000040808        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
065100040808          Return  0;
065200040808
065300040808        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
065400040808          Return  0;
065500040808
065600040808        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
065700040808          Return  0;
065800040808
065900040808        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
066000040808          Return  0;
066100040808
066200040808        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
066300040808          Return  0;
066400040808
066500040808        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
066600040808          Return  0;
066700040808
066800040808        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
066900040808          Return  0;
067000040808
067100040808        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
067200040808          Return  0;
067300040808
067400040808        Other;
067500040808          Return -1;
067600040808        EndSl;
067700040808
067800040808      /End-Free
067900040808
068000040808     P ValSpcAut       E
