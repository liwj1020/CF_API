000100040808     **
000200050911     **  Program . . : CBX944
000300050826     **  Description : Process object locks - CPP
000400040808     **  Author  . . : Carsten Flensburg
000500040808     **
000600040808     **
000700040808     **  Compile options:
000800050911     **    CrtRpgMod Module( CBX944 )
000900040808     **              DbgView( *LIST )
001000040808     **
001100050911     **    CrtPgm    Pgm( CBX944 )
001200050911     **              Module( CBX944 )
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
002300050826
002400040808     **-- System information:
002500050826     D PgmSts         Sds                  Qualified
002600050826     D  CurJob                       10a   Overlay( PgmSts: 244 )
002700050826     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002800050826     D  JobNbr                        6a   Overlay( PgmSts: 264 )
002900050826     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003000050826
003100040806     **-- Global variables & constants:
003200040806     D JobIdx          s             10u 0
003300040806     D RcdIdx          s             10u 0
003400040807     D PrcIdx          s             10u 0
003500040808     D MaxIdx          s             10u 0
003600040808     **
003700040807     D FncRqs          s             10i 0
003800040807     D MsgSntInd       s             10i 0
003900040808     **
004000040806     D PrdRcdLck       s               n
004100040807     D CmdStr          s            512a   Varying
004200040807     D MsgTyps         s             10a   Dim( 4 )
004300040808     D PrcJobIds       s             26a   Dim( 4096 )
004400040806     **
004500040806     D USRSPC          c                   'LSTOBJLCK QTEMP'
004600040806     D PROD_LIB        c                   '0'
004700050826
004800040806     **-- Api error data structure:
004900040806     D ERRC0100        Ds                  Qualified
005000040806     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
005100040806     D  BytAvl                       10i 0 Inz
005200040806     D  MsgId                         7a
005300010329     D                                1a
005400040806     D  MsgDta                      128a
005500040806     **-- API header information:
005600040806     D ApiHdrInf       Ds                  Qualified  Based( pHdrInf )
005700040806     D  UsrSpcU                      10a
005800040806     D  UsrLibU                      10a
005900040806     D  ObjNamU                      10a
006000040806     D  ObjLibU                      10a
006100040806     D  ObjTypR                      10a
006200040806     D  ObjExtAtr                    10a
006300040806     D  ShrFilNam                    10a
006400040806     D  ShrFilLib                    10a
006500040806     D  OfsPthNamU                   10i 0
006600040806     D  LenPthNamU                   10i 0
006700040806     D  ObjNamAspU                   10a
006800040806     D  ObjLibAspU                   10a
006900040806     **-- User space generic header:
007000040806     D UsrSpcHdr       Ds                  Qualified  Based( pUsrSpc )
007100040806     D  OfsHdr                       10i 0 Overlay( UsrSpcHdr: 117 )
007200040806     D  OfsLst                       10i 0 Overlay( UsrSpcHdr: 125 )
007300040806     D  NumLstEnt                    10i 0 Overlay( UsrSpcHdr: 133 )
007400040806     D  SizLstEnt                    10i 0 Overlay( UsrSpcHdr: 137 )
007500040806     **-- User space pointers:
007600010806     D pUsrSpc         s               *   Inz( *Null )
007700010806     D pHdrInf         s               *   Inz( *Null )
007800010806     D pLstEnt         s               *   Inz( *Null )
007900040806     **-- Object lock entry:
008000040806     D OBJL0100        DS                  Qualified  Based( pLstEnt )
008100040806     D  JobNamQ                      26a
008200040806     D   JobNam                      10a   Overlay( JobNamQ:  1 )
008300040806     D   JobUsr                      10a   Overlay( JobNamQ: 11 )
008400040806     D   JobNbr                       6a   Overlay( JobNamQ: 21 )
008500040806     D  LckStt                       10a
008600040806     D  LckSts                       10i 0
008700040806     D  LckTyp                       10i 0
008800040806     D  MbrNam                       10a
008900040806     D  Share                         1a
009000040806     D  LckScp                        1a
009100040806     D  ThdId                         8a
009200040806     **-- Job lock information:
009300040806     D RJBL0100        Ds         65535    Qualified
009400040806     D  LckAvl                       10i 0
009500040806     D  LckRtn                       10i 0
009600040806     D  OfsLckInf                    10i 0
009700040806     D  SizLckInf                    10i 0
009800040806     **
009900040806     D LckInf          Ds                  Qualified  Based( pLckInf )
010000040806     D  DbFilNam                     10a
010100040806     D  DbFilLib                     10a
010200040806     D  DbFilMbr                     10a
010300040806     D  LckSts                        1a
010400040806     D  LckStt                        1a
010500040806     D  LckRrn                       10u 0
010600040806     **-- Library information:
010700040806     D LibInf          Ds                  Qualified
010800040806     D  BytRtn                       10i 0
010900040806     D  BytAvl                       10i 0
011000040806     D  VarRtn                       10i 0
011100040806     D  VarAvl                       10i 0
011200040806     **
011300040806     D  RtnDtaLen                    10i 0
011400040806     D  KeyId                        10i 0
011500040806     D  FldSiz                       10i 0
011600040806     D  LibTyp                        1a
011700040806     **
011800040806     D RcvAtr          Ds                  Qualified
011900040806     D  NbrAtr                       10i 0 Inz( 1 )
012000040806     D  AtrAvl                       10i 0 Inz( 1 )
012100050826
012200040806     **-- Create user space:
012300000726     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
012400050826     D  SpcNamQ                      20a   Const
012500050826     D  ExtAtr                       10a   Const
012600050826     D  InzSiz                       10i 0 Const
012700050826     D  InzVal                        1a   Const
012800050826     D  PubAut                       10a   Const
012900050826     D  Text                         50a   Const
013000050826     D  Replace                      10a   Const  Options( *NoPass )
013100050826     D  Error                     32767a          Options( *NoPass: *VarSize )
013200050826     D  Domain                       10a   Const  Options( *NoPass )
013300040806     **-- Delete user space:
013400000726     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
013500050826     D  SpcNamQ                      20a   Const
013600050826     D  Error                     32767a          Options( *VarSize )
013700040806     **-- Retrieve pointer to user space:
013800010806     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
013900050826     D  SpcNamQ                      20a   Const
014000050826     D  Pointer                        *
014100050826     D  Error                     32767a          Options( *NoPass: *VarSize )
014200040806     **-- List object locks:
014300030602     D LstObjLck       Pr                  ExtPgm( 'QWCLOBJL' )
014400050826     D  SpcNamQ                      20a   Const
014500050826     D  FmtNam                        8a   Const
014600050826     D  ObjNamQ                      20a   Const
014700050826     D  ObjTyp                       10a   Const
014800050826     D  MbrNam                       10a   Const
014900050826     D  Error                     32767a          Options( *VarSize )
015000050826     D  PthNam                     1024a   Const  Options( *NoPass:  *VarSize )
015100050826     D  PthNamLen                    10i 0 Const  Options( *NoPass )
015200050826     D  ObjAspQ                      10a   Const  Options( *NoPass )
015300040806     **-- Retrieve job record locks:
015400040806     D RtvJobLck       Pr                  ExtPgm( 'QDBRJBRL' )
015500050826     D  RcvVar                    65535a          Options( *VarSize )
015600050826     D  RcvVarLen                    10i 0 Const
015700050826     D  FmtNam                        8a   Const
015800050826     D  JobNam                       26a   Const
015900050826     D  Error                     32767a          Options( *VarSize )
016000040808     **-- Retrieve user information:
016100040808     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
016200050826     D  RcvVar                    32767a          Options( *VarSize )
016300050826     D  RcvVarLen                    10i 0 Const
016400050826     D  FmtNam                       10a   Const
016500050826     D  UsrPrf                       10a   Const
016600050826     D  Error                     32767a          Options( *VarSize )
016700040806     **-- Retrieve library information:
016800040806     D RtvLibInf       Pr                  ExtPgm( 'QLIRLIBD' )
016900050826     D  RcvVar                     1024a          Options( *VarSize )
017000050826     D  RcvVarLen                    10i 0 Const
017100050826     D  LibNam                       10a   Const
017200050826     D  RcvAtr                     1024a   Const  Options( *VarSize )
017300050826     D  Error                     32767a          Options( *VarSize )
017400040807     **-- Retrieve object description:
017500040807     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
017600050826     D  RcvVar                    32767a          Options( *VarSize )
017700050826     D  RcvVarLen                    10i 0 Const
017800050826     D  FmtNam                        8a   Const
017900050826     D  ObjNamQ                      20a   Const
018000050826     D  ObjTyp                       10a   Const
018100050826     D  Error                     32767a          Options( *VarSize )
018200040807     **-- Execute command:
018300040807     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
018400050826     D  Cmd                         512a   Const  Options( *VarSize )
018500050826     D  CmdLen                       15p 5 Const
018600050826     D  CmdIGC                        3a   Const  Options( *NoPass )
018700040806     **-- Send break message:
018800040806     D SndBrkMsg       Pr                  ExtPgm( 'QMHSNDBM' )
018900050826     D  MsgTxt                     6000a   Const  Options( *VarSize )
019000050826     D  MsgTxtLen                    10i 0 Const
019100050826     D  MsgTyp                       10a   Const
019200050826     D  MsgQueQ                      20a   Const  Options( *VarSize )  Dim( 50 )
019300050826     D  MsgQueNbr                    10i 0 Const
019400050826     D  MsgQueRpy                    20a   Const
019500050826     D  Error                     32767a          Options( *VarSize )
019600050826     D  CcsId                        10i 0 Const  Options( *NoPass )
019700040807     **-- Send message:
019800040807     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
019900050826     D  MsgTyp                       10a   Const
020000050826     D  DlvMod                       10a   Const
020100050826     D  MsgTxt                      494a   Const  Options( *VarSize )
020200050826     D  MsgTxtLen                    10i 0 Const
020300050826     D  MsgRcv                       10a   Const  Options( *VarSize ) Dim( 299 )
020400050826     D  MsgRcvNbr                    10i 0 Const
020500050826     D  MsgSntInd                    10i 0
020600050826     D  FncRqs                       10i 0
020700050826     D  Error                     32767a          Options( *VarSize )
020800050826     D  ShwSndMsgDsp                  1a   Const  Options( *NoPass )
020900050826     D  MsgQueNam                    20a   Const  Options( *NoPass )
021000050826     D  NamTypInd                     4a   Const  Options( *NoPass )
021100050826     D  CcsId                        10i 0 Const  Options( *NoPass )
021200040807     **-- Send program message:
021300040807     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
021400050826     D  MsgId                         7a   Const
021500050826     D  MsgFq                        20a   Const
021600050826     D  MsgDta                      128a   Const
021700050826     D  MsgDtaLen                    10i 0 Const
021800050826     D  MsgTyp                       10a   Const
021900050826     D  CalStkE                      10a   Const  Options( *VarSize )
022000050826     D  CalStkCtr                    10i 0 Const
022100050826     D  MsgKey                        4a
022200050826     D  Error                      1024a          Options( *VarSize )
022300040807     **-- Move program messages:
022400040807     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
022500050826     D  MsgKey                        4a   Const
022600050826     D  MsgTyps                      10a   Const  Options( *VarSize )  Dim( 4 )
022700050826     D  NbrMsgTyps                   10i 0 Const
022800050826     D  ToCalStkE                  4102a   Const  Options( *VarSize )
022900050826     D  ToCalStkCnt                  10i 0 Const
023000050826     D  Error                     32767a          Options( *VarSize )
023100050826     D  ToCalStkLen                  10i 0 Const  Options( *NoPass )
023200050826     D  ToCalStkEq                   20a   Const  Options( *NoPass )
023300050826     D  ToCalStkEdt                  10a   Const  Options( *NoPass )
023400050826     D  FrCalStkEad                    *   Const  Options( *NoPass )
023500050826     D  FrCalStkCnt                  10i 0 Const  Options( *NoPass )
023600040807
023700040808     **-- Validate special authority:
023800040808     D ValSpcAut       Pr            10i 0
023900040808     D  PxUsrPrf                     10a   Value
024000040808     D  PxSpcAut                     10a   Value
024100040808     **-- Set member option:
024200040808     D SetMbrOpt       Pr            10a
024300081002     D  PxObjNamQ                    20a   Const
024400081002     D  PxObjTyp                     10a   Const
024500040807     **-- Send escape message:
024600040807     D SndEscMsg       Pr            10i 0
024700040807     D  PxMsgId                       7a   Const
024800040807     D  PxMsgF                       10a   Const
024900040807     D  PxMsgDta                    512a   Const  Varying
025000040813     **-- Send message by type:
025100040808     D SndMsgTyp       Pr            10i 0
025200040807     D  PxMsgDta                    512a   Const  Varying
025300040808     D  PxMsgTyp                     10a   Const
025400040807
025500040807     **-- Entry parameters:
025600050911     D CBX944          Pr
025700050826     D  PxObjNamQ                    20a
025800050826     D  PxObjTyp                      7a
025900040807     D  PxAction                      7a
026000040807     D  PxMsgTxt                    512a   Varying
026100040807     D  PxMsgTo                       5a
026200040813     D  PxEndOpt                      7a
026300040813     D  PxDelay                      10i 0
026400040807     D  PxIgnRcdLck                   4a
026500040807     **
026600050911     D CBX944          Pi
026700050826     D  PxObjNamQ                    20a
026800050826     D  PxObjTyp                      7a
026900040807     D  PxAction                      7a
027000040807     D  PxMsgTxt                    512a   Varying
027100040807     D  PxMsgTo                       5a
027200040813     D  PxEndOpt                      7a
027300040813     D  PxDelay                      10i 0
027400040807     D  PxIgnRcdLck                   4a
027500040806
027600040806      /Free
027700040806
027800050826        If  ValSpcAut( PgmSts.UsrPrf: '*JOBCTL' ) = -1;
027900040808
028000040808          SndEscMsg( 'CPFB0CE'
028100040808                   : 'QCPFMSG'
028200040808                   : '*JOBCTL'
028300040808                   );
028400040808        Else;
028500040808
028600040808          CrtUsrSpc( USRSPC
028700040808                   : *Blanks
028800040808                   : 65535
028900040808                   : x'00'
029000040808                   : '*CHANGE'
029100040808                   : *Blanks
029200040808                   : '*YES'
029300040808                   : ERRC0100
029400040808                   );
029500040806
029600040808          LstObjLck( USRSPC
029700040808                   : 'OBJL0100'
029800050826                   : PxObjNamQ
029900050826                   : PxObjTyp
030000081002                   : SetMbrOpt( PxObjNamQ: PxObjTyp )
030100040808                   : ERRC0100
030200040808                   );
030300040806
030400040808          If  ERRC0100.BytAvl = *Zero;
030500040808            ExSr  PrcLstEnt;
030600040808
030700040808          Else;
030800040808            SndEscMsg( ERRC0100.MsgId
030900040808                     : 'QCPFMSG'
031000040808                     : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
031100040808                     );
031200040807
031300040808          EndIf;
031400040808        EndIf;
031500040806
031600040806        DltUsrSpc( USRSPC: ERRC0100 );
031700040806
031800040807        *InLr = *On;
031900040807
032000040806        Return;
032100040806
032200040806        BegSr  PrcLstEnt;
032300040806
032400040806          RtvPtrSpc( USRSPC: pUsrSpc );
032500040806
032600040806          pHdrInf = pUsrSpc + UsrSpcHdr.OfsHdr;
032700040806          pLstEnt = pUsrSpc + UsrSpcHdr.OfsLst;
032800040806
032900040806          For  JobIdx = 1  to UsrSpcHdr.NumLstEnt;
033000040806
033100040808            If  %Lookup( OBJL0100.JobNamQ: PrcJobIds: 1: MaxIdx ) = *Zero;
033200040807
033300040808              ExSr  LodJobId;
033400040807
033500040807              If  PxAction = '*BRKMSG';
033600040807                ExSr  SndNtfMsg;
033700040807
033800040807              Else;
033900040807                ExSr  RunEndJob;
034000040807              EndIf;
034100040807            EndIf;
034200040806
034300040806            If  JobIdx < UsrSpcHdr.NumLstEnt;
034400040806              pLstEnt = pLstEnt + UsrSpcHdr.SizLstEnt;
034500040806            EndIf;
034600040806          EndFor;
034700040806
034800040808          SndMsgTyp( 'Lock processing completed normally.': '*COMP' );
034900040808
035000040806        EndSr;
035100040808
035200040808        BegSr  LodJobId;
035300040808
035400040808          If  PrcIdx < %Elem( PrcJobIds );
035500040808            PrcIdx = PrcIdx + 1;
035600040808
035700040808            If  PrcIdx > MaxIdx;
035800040808              MaxIdx = PrcIdx;
035900040808            EndIf;
036000040808
036100040808          Else;
036200040808            PrcIdx = 1;
036300040808          EndIf;
036400040808
036500040808          PrcJobIds(PrcIdx) = OBJL0100.JobNamQ;
036600040808
036700040808        EndSr;
036800040806
036900040807        BegSr  RunEndJob;
037000040808
037100040808          If  PxIgnRcdLck = '*NO';
037200040808            ExSr  ChkRcdLck;
037300040808          EndIf;
037400040807
037500040808          If  PxIgnRcdLck = '*YES'  Or
037600040808              PrdRcdLck   = *Off;
037700040808
037800040808            CmdStr = 'ENDJOB JOB('                       +
037900040808                      %Trim( OBJL0100.JobNbr )           + '/'  +
038000040808                      %Trim( OBJL0100.JobUsr )           + '/'  +
038100040808                      %Trim( OBJL0100.JobNam )           + ') ' +
038200040813                     'OPTION(' + %Trim( PxEndOpt )       + ') ' +
038300040813                     'DELAY(' + %Char( PxDelay )         + ') ' +
038400040813                     'SPLFILE(*NO) LOGLMT(*SAME) ADLINTJOBS(*NONE)';
038500040813
038600040808            Monitor;
038700040808              ExcCmd( CmdStr: %Len( CmdStr ));
038800040807
038900040808            On-Error;
039000040808              MsgTyps(1) = '*DIAG';
039100040808              MsgTyps(2) = '*ESCAPE';
039200040807
039300040808              MovPgmMsg( *Blanks
039400040808                       : MsgTyps
039500040808                       : 2
039600040808                       : '*PGMBDY'
039700040808                       : 1
039800040808                       : ERRC0100
039900040808                       );
040000040807
040100040813              LeaveSr;
040200040808            EndMon;
040300040813
040400040808              MovPgmMsg( *Blanks
040500040808                       : '*COMP'
040600040808                       : 1
040700040808                       : '*PGMBDY'
040800040808                       : 1
040900040808                       : ERRC0100
041000040808                       );
041100040808          EndIf;
041200040808
041300040807        EndSr;
041400040807
041500040806        BegSr  ChkRcdLck;
041600040806
041700040806          Eval  PrdRcdLck = *Off;
041800040806
041900040806          RtvJobLck( RJBL0100
042000040806                   : %Size( RJBL0100 )
042100040806                   : 'RJBL0100'
042200040806                   : OBJL0100.JobNam + OBJL0100.JobUsr + OBJL0100.JobNbr
042300040806                   : ERRC0100
042400040806                   );
042500040806
042600040806          If  ERRC0100.BytAvl = *Zero;
042700040806            ExSr  PrcJobLck;
042800040806          EndIf;
042900040806
043000040807        EndSr;
043100040807
043200040807        BegSr  SndNtfMsg;
043300040807
043400040807          If  PxMsgTo = '*JOB';
043500040807
043600040807            SndBrkMsg( PxMsgTxt
043700040807                     : %Len( PxMsgTxt )
043800040807                     : '*INFO'
043900040807                     : OBJL0100.JobNam + '*LIBL'
044000040807                     : 1
044100040807                     : ' '
044200040807                     : ERRC0100
044300040807                     );
044400040820
044500040820        If  ERRC0100.BytAvl > *Zero;
044600040820
044700040820          MovPgmMsg( *Blanks
044800040820                   : '*DIAG'
044900040820                   : 1
045000040820                   : '*PGMBDY'
045100040820                   : 1
045200040820                   : ERRC0100
045300040820                   );
045400040820        EndIf;
045500040820
045600040807          Else;
045700040807
045800040807            SndMsg( '*INFO'
045900040807                  : '*BREAK'
046000040807                  : PxMsgTxt
046100040807                  : %Len( PxMsgTxt )
046200040807                  : OBJL0100.JobUsr
046300040807                  : 1
046400040807                  : MsgSntInd
046500040807                  : FncRqs
046600040807                  : ERRC0100
046700040807                  : 'N'
046800040807                  : *Blanks
046900040807                  : '*USR'
047000040807                  );
047100040807        EndIf;
047200040820
047300040806        EndSr;
047400040806
047500040806        BegSr  PrcJobLck;
047600040806
047700040806          pLckInf = %Addr( RJBL0100 ) + RJBL0100.OfsLckInf;
047800040806
047900040806          For  RcdIdx = 1  to RJBL0100.LckRtn;
048000040806
048100040806            RtvLibInf( LibInf
048200040806                     : %Size( LibInf )
048300040806                     : LckInf.DbFilLib
048400040806                     : RcvAtr
048500040806                     : ERRC0100
048600040806                     );
048700040806
048800040806            If  ERRC0100.BytAvl = *Zero  And
048900040806                LibInf.LibTyp   = PROD_LIB;
049000040806
049100040808              SndMsgTyp( 'Job '              + %TrimR( OBJL0100.JobNam ) +
049200040808                         ' has locked file ' + %TrimR( LckInf.DbFilNam ) +
049300040808                         ' record number '   + %Char( LckInf.LckRrn )    +
049400040808                         ', job not ended.'
049500040808                       : '*INFO'
049600040808                       );
049700040808
049800040808              Eval  PrdRcdLck = *On;
049900040806              Leave;
050000040806            EndIf;
050100040806
050200040806            If  RcdIdx < RJBL0100.LckRtn;
050300040806              Eval  pLckInf = pLckInf + RJBL0100.SizLckInf;
050400040806            EndIf;
050500040806          EndFor;
050600040806
050700040806        EndSr;
050800040806
050900040806      /End-Free
051000040807
051100040807     **-- Send escape message:  ----------------------------------------------**
051200040807     P SndEscMsg       B
051300040807     D                 Pi            10i 0
051400040807     D  PxMsgId                       7a   Const
051500040807     D  PxMsgF                       10a   Const
051600040807     D  PxMsgDta                    512a   Const  Varying
051700040807     **
051800040807     D MsgKey          s              4a
051900040807
052000040807      /Free
052100040807
052200040807        SndPgmMsg( PxMsgId
052300040807                 : PxMsgF + '*LIBL'
052400040807                 : PxMsgDta
052500040807                 : %Len( PxMsgDta )
052600040807                 : '*ESCAPE'
052700040807                 : '*PGMBDY'
052800040807                 : 1
052900040807                 : MsgKey
053000040807                 : ERRC0100
053100040807                 );
053200040807
053300040807        If  ERRC0100.BytAvl > *Zero;
053400040807          Return  -1;
053500040807
053600040807        Else;
053700040807          Return   0;
053800040807        EndIf;
053900040807
054000040807      /End-Free
054100040807
054200040807     P SndEscMsg       E
054300040813     **-- Send message by type:  ---------------------------------------------**
054400040808     P SndMsgTyp       B
054500040807     D                 Pi            10i 0
054600040807     D  PxMsgDta                    512a   Const  Varying
054700040808     D  PxMsgTyp                     10a   Const
054800040807     **
054900040807     D MsgKey          s              4a
055000040807
055100040807      /Free
055200040807
055300040807        SndPgmMsg( 'CPF9897'
055400040807                 : 'QCPFMSG   *LIBL'
055500040807                 : PxMsgDta
055600040807                 : %Len( PxMsgDta )
055700040808                 : PxMsgTyp
055800040807                 : '*PGMBDY'
055900040807                 : 1
056000040807                 : MsgKey
056100040807                 : ERRC0100
056200040807                 );
056300040807
056400040807        If  ERRC0100.BytAvl > *Zero;
056500040807          Return  -1;
056600040807
056700040807        Else;
056800040807          Return   0;
056900040807        EndIf;
057000040807
057100040807      /End-Free
057200040807
057300040808     P SndMsgTyp       E
057400040808     **-- Set member option:  ------------------------------------------------**
057500040808     P SetMbrOpt       B                   Export
057600040807     D                 Pi            10a
057700081002     D  PxObjNamQ                    20a   Const
057800081002     D  PxObjTyp                     10a   Const
057900040807     **
058000040807     D OBJD0200        Ds                  Qualified
058100040807     D  BytRtn                       10i 0
058200040807     D  BytAvl                       10i 0
058300040807     D  ObjNam                       10a
058400040807     D  ObjLib                       10a
058500040807     D  ObjTypRt                     10a
058600040807     D  ObjLibRt                     10a
058700040807     D  ObjASP                       10i 0
058800040807     D  ObjOwn                       10a
058900040807     D  ObjDmn                        2a
059000040807     D  ObjCrtDT                     13a
059100040807     D  ObjChgDT                     13a
059200040807     D  ExtAtr                       10a
059300040807     D  TxtDsc                       50a
059400040807     D  SrcF                         10a
059500040807     D  SrcLib                       10a
059600040807     D  SrcMbr                       10a
059700040807
059800040807      /Free
059900040807
060000040807         RtvObjD( OBJD0200
060100040807                : %Size( OBJD0200 )
060200040807                : 'OBJD0200'
060300081002                : PxObjNamQ
060400081002                : PxObjTyp
060500040807                : ERRC0100
060600040807                );
060700040807
060800040808         Select;
060900040808         When  ERRC0100.BytAvl > *Zero;
061000040808           Return  '*NONE';
061100040808
061200040808         When  OBJD0200.ExtAtr = 'PF'  Or
061300040808               OBJD0200.ExtAtr = 'LF';
061400040808           Return  '*ALL';
061500040808
061600040808         Other;
061700040808           Return  '*NONE';
061800040808         EndSl;
061900040807
062000040807         Return    OBJD0200.ExtAtr;
062100040807
062200040807      /End-Free
062300040807
062400040808     P SetMbrOpt       E
062500040808     **-- Validate special authority:  ---------------------------------------**
062600040808     P ValSpcAut       B                   Export
062700040808     D                 Pi            10i 0
062800040808     D  PxUsrPrf                     10a   Value
062900040808     D  PxSpcAut                     10a   Value
063000040808     **
063100040808     D USRI0200        Ds                  Qualified
063200040808     D  BytRtn                       10i 0
063300040808     D  BytAvl                       10i 0
063400040808     D  UsrPrf                       10a
063500040808     D  SpcAut                       15a   Overlay( USRI0200: 29 )
063600040808     D   AllObj                       1a   Overlay( SpcAut: 1 )
063700040808     D   SecAdm                       1a   Overlay( SpcAut: *Next )
063800040808     D   JobCtl                       1a   Overlay( SpcAut: *Next )
063900040808     D   SplCtl                       1a   Overlay( SpcAut: *Next )
064000040808     D   SavSys                       1a   Overlay( SpcAut: *Next )
064100040808     D   Service                      1a   Overlay( SpcAut: *Next )
064200040808     D   Audit                        1a   Overlay( SpcAut: *Next )
064300040808     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )
064400040808
064500040808      /Free
064600040808
064700040808        RtvUsrInf( USRI0200
064800040808                 : %Size( USRI0200 )
064900040808                 : 'USRI0200'
065000040808                 : PxUsrPrf
065100040808                 : ERRC0100
065200040808                 );
065300040808
065400040808        Select;
065500040808        When  ERRC0100.BytAvl > *Zero;
065600040808          Return -1;
065700040808
065800040808        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
065900040808          Return  0;
066000040808
066100040808        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
066200040808          Return  0;
066300040808
066400040808        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
066500040808          Return  0;
066600040808
066700040808        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
066800040808          Return  0;
066900040808
067000040808        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
067100040808          Return  0;
067200040808
067300040808        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
067400040808          Return  0;
067500040808
067600040808        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
067700040808          Return  0;
067800040808
067900040808        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
068000040808          Return  0;
068100040808
068200040808        Other;
068300040808          Return -1;
068400040808        EndSl;
068500040808
068600040808      /End-Free
068700040808
068800040808     P ValSpcAut       E
