000100041212     **
000200051023     **  Program . . : CBX948
000300051023     **  Description : Analyze user profile usage - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Compile and setup instructions:
000800051023     **    CrtRpgMod   Module( CBX948 )
000900050318     **                DbgView( *LIST )
001000041212     **
001100051023     **    CrtPgm      Pgm( CBX948 )
001200051023     **                Module( CBX948 )
001300041212     **                ActGrp( *NEW )
001400041212     **
001500041212     **
001600041212     **-- Control specification:  --------------------------------------------**
001700050319     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
001800051023
001900041212     **-- Printer file:
002000041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002100051023
002200051101     **-- System information:
002300051101     D PgmSts         Sds                  Qualified
002400051101     D  PgmNam           *Proc
002500051101     D  CurJob                       10a   Overlay( PgmSts: 244 )
002600051101     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002700051101     D  JobNbr                        6a   Overlay( PgmSts: 264 )
002800051101     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002900041212     **-- Printer file information:
003000050212     D PrtLinInf       Ds                  Qualified
003100050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
003200050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
003300050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
003400051023
003500041211     **-- API error data structure:
003600041211     D ERRC0100        Ds                  Qualified
003700041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003800041211     D  BytAvl                       10i 0
003900041211     D  MsgId                         7a
004000990921     D                                1a
004100041211     D  MsgDta                      128a
004200041212     **-- Global variables:
004300051029     D Idx             s             10i 0 Inz
004400051029     D ClsIdx          s             10i 0 Inz
004500051029     D PrfIdx          s             10i 0 Inz
004600051029     D GenIdx          s             10i 0 Inz
004700041212     D LstTim          s              6s 0
004800050319     D SysNam          s              8a
004900050415     D TrlTxt          s             32a
005000051029     D PrfSts          s             10i 0
005100051029     D GenPrfPos       s             10i 0
005200051029     D InactDays       s             10i 0
005300051029     D ObjCrtUsr       s             10a
005400051029     D ObjCrtDat       s               d
005500051101     D ObjRstDat       s               d
005600051029     D ObjLstUsd       s               d
005700051029     D PrvSgnOn        s               d
005800051028     **
005900051028     D UsrCls          Ds                  Qualified
006000051028     D  NbrCls                        5i 0
006100051028     D  ClsVal                       10a   Dim( 5 )
006200051028     **
006300051028     D ExcPrf          Ds                  Qualified
006400051028     D  NbrPrf                        5i 0
006500051028     D  PrfVal                       10a   Dim( 30 )
006600051029     **
006700051029     D ChkUsrCls       s             10a   Dim( 5 )
006800051029     D ChkUsrPrf       s             10a   Dim( 30 )
006900051029     D ChkGenPrf       s             10a   Dim( 30 )  Varying
007000050122     **-- List record:
007100050122     D LstRcd          Ds                  Qualified
007200050507     D  UsrPrf                       10a
007300050507     D  PrfSts                       10a
007400050507     D  PwdExpI                       4a
007500050507     D  PwdExpD                       8a
007600110331     D  InvSgo                        6s 0
007700050507     D  GrpPrf                       10a
007800050507     D  PwdI                          4a
007900050507     D  UsrCls                       10a
008000050507     D  PrvSgoD                       8a
008100051029     D  LstUsdD                       8a
008200050507     D  PwdChgD                       8a
008300051029     D  InactD                        5s 0
008400051029     D  NewSts                        9a
008500050212     **-- List API parameters:
008600050212     D LstApi          Ds                  Qualified  Inz
008700050212     D  RtnRcdNbr                    10i 0
008800050506     D  GrpNam                       10a
008900050506     D  SltCri                       10a
009000040426     **-- List information:
009100041211     D LstInf          Ds                  Qualified
009200041211     D  RcdNbrTot                    10i 0
009300041211     D  RcdNbrRtn                    10i 0
009400041211     D  Handle                        4a
009500041211     D  RcdLen                       10i 0
009600041211     D  InfSts                        1a
009700041211     D  Dts                          13a
009800041211     D  LstSts                        1a
009900040426     D                                1a
010000041211     D  InfLen                       10i 0
010100041211     D  Rcd1                         10i 0
010200040426     D                               40a
010300050507     **-- User information:
010400050507     D AUTU0100        Ds                  Qualified
010500050506     D  UsrPrf                       10a
010600050506     D  UsrGrpI                       1a
010700050506     D  GrpMbrI                       1a
010800050507     **-- User information:
010900050507     D USRI0300        Ds                  Qualified
011000050507     D  BytRtn                       10i 0
011100050507     D  BytAvl                       10i 0
011200050507     D  UsrPrf                       10a
011300050507     D  PrvSgoDts                    13a   Overlay( USRI0300:  19 )
011400050507     D   PrvSgoDat                    7a   Overlay( USRI0300:  19 )
011500050507     D   PrvSgoTim                    6a   Overlay( USRI0300:  26 )
011600050507     D  InvSgo                       10i 0 Overlay( USRI0300:  33 )
011700050507     D  PrfSts                       10a   Overlay( USRI0300:  37 )
011800050507     D  PwdChgDat                     8a   Overlay( USRI0300:  47 )
011900050507     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
012000050507     D  PwdExpDat                     8a   Overlay( USRI0300:  61 )
012100050507     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
012200050507     D  UsrCls                       10a   Overlay( USRI0300:  74 )
012300050507     D  SpcAut                       15a   Overlay( USRI0300:  84 )
012400050507     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
012500050507     D  LmtCap                       10a   Overlay( USRI0300: 189 )
012600051023
012700050506     **-- Open list of authorized users:
012800050506     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
012900051023     D  RcvVar                    65535a          Options( *VarSize )
013000051023     D  RcvVarLen                    10i 0 Const
013100051023     D  LstInf                       80a
013200051023     D  NbrRcdRtn                    10i 0 Const
013300051023     D  FmtNam                        8a   Const
013400051023     D  SltCri                       10a   Const
013500051023     D  GrpNam                       10a   Const
013600051023     D  Error                      1024a          Options( *VarSize )
013700041212     **-- Get list entry:
013800020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
013900051023     D  RcvVar                    65535a          Options( *VarSize )
014000051023     D  RcvVarLen                    10i 0 Const
014100051023     D  Handle                        4a   Const
014200051023     D  LstInf                       80a
014300051023     D  NbrRcdRtn                    10i 0 Const
014400051023     D  RtnRcdNbr                    10i 0 Const
014500051023     D  Error                      1024a          Options( *VarSize )
014600041212     **-- Close list:
014700020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
014800051023     D  Handle                        4a   Const
014900051023     D  Error                      1024a          Options( *VarSize )
015000051028     **-- Process commands:
015100051028     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
015200051028     D  SrcCmd                    32702a   Const  Options( *VarSize )
015300051028     D  SrcCmdLen                    10i 0 Const
015400051028     D  OptCtlBlk                    20a   Const
015500051028     D  OptCtlBlkLn                  10i 0 Const
015600051028     D  OptCtlBlkFm                   8a   Const
015700051028     D  ChgCmd                    32767a          Options( *VarSize )
015800051028     D  ChgCmdLen                    10i 0 Const
015900051028     D  ChgCmdLenAvl                 10i 0
016000051028     D  Error                     32767a          Options( *VarSize )
016100050319     **-- Send program message:
016200050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
016300051023     D  MsgId                         7a   Const
016400051023     D  MsgFq                        20a   Const
016500051023     D  MsgDta                      128a   Const
016600051023     D  MsgDtaLen                    10i 0 Const
016700051023     D  MsgTyp                       10a   Const
016800051023     D  CalStkE                      10a   Const  Options( *VarSize )
016900051023     D  CalStkCtr                    10i 0 Const
017000051023     D  MsgKey                        4a
017100051023     D  Error                     32767a          Options( *VarSize )
017200051101     **-- Send message:
017300051101     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
017400051101     D  MsgId                         7a   Const
017500051101     D  MsgFq                        20a   Const
017600051101     D  MsgDta                      512a   Const  Options( *VarSize )
017700051101     D  MsgDtaLen                    10i 0 Const
017800051101     D  MsgTyp                       10a   Const
017900051101     D  MsgQq                      1000a   Const  Options( *VarSize )
018000051101     D  MsgQnbr                      10i 0 Const
018100051101     D  MsgQrpy                      20a   Const
018200051101     D  MsgKey                        4a
018300051101     D  Error                     32767a          Options( *VarSize )
018400051101     D  CcsId                        10i 0 Const  Options( *NoPass )
018500050318     **-- Convert date & time:
018600050318     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
018700051023     D  InpFmt                       10a   Const
018800051023     D  InpVar                       17a   Const  Options( *VarSize )
018900051023     D  OutFmt                       10a   Const
019000051023     D  OutVar                       17a          Options( *VarSize )
019100051023     D  Error                        10i 0 Const
019200050319     **-- Retrieve net attribute:
019300050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
019400051023     D  RcvVar                    32767a          Options( *VarSize )
019500051023     D  RcvVarLen                    10i 0 Const
019600051023     D  NbrNetAtr                    10i 0 Const
019700051023     D  NetAtr                       10a   Const  Dim( 256 )
019800050319     D                                            Options( *VarSize )
019900051023     D  Error                     32767a          Options( *VarSize )
020000050506     **-- Retrieve user information:
020100050506     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
020200051023     D  RcvVar                    32767a          Options( *VarSize )
020300051023     D  RcvVarLen                    10i 0 Const
020400051023     D  FmtNam                       10a   Const
020500051023     D  UsrPrf                       10a   Const
020600051023     D  Error                     32767a          Options( *VarSize )
020700050506     **-- Retrieve object description:
020800050506     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
020900051023     D  RcvVar                    32767a         Options( *VarSize )
021000051023     D  RcvVarLen                    10i 0 Const
021100051023     D  FmtNam                        8a   Const
021200051023     D  ObjNamQ                      20a   Const
021300051023     D  ObjTyp                       10a   Const
021400051023     D  Error                     32767a         Options( *VarSize )
021500041212
021600050318     **-- Convert system DTS to date:
021700050318     D CvtDtsDat       Pr              d
021800050318     D  PxSysDts                      8a   Value
021900050319     **-- Get system name:
022000050319     D GetSysNam       Pr             8a   Varying
022100051029     **-- Get creating user profile:
022200051029     D GetCrtUsr       Pr            10a
022300050506     D  PxUsrPrf                     10a   Value
022400051029     **-- Get profile creation date:
022500051029     D GetCrtDat       Pr              d
022600051029     D  PxUsrPrf                     10a   Value
022700051101     **-- Get profile restore date:
022800051101     D GetRstDat       Pr              d
022900051101     D  PxUsrPrf                     10a   Value
023000051023     **-- Get user profile last used date:
023100051023     D GetPrfLstUsd    Pr              d
023200051023     D  PxUsrPrf                     10a   Value
023300051028     **-- Process command:
023400051028     D PrcCmd          Pr            10i 0
023500051101     D  PxCmdStr                   1024a   Const  Varying
023600051101     **-- Send user message:
023700051101     D SndUsrMsg       Pr            10i 0
023800051101     D  PxUsrPrf                     10a   Const
023900051101     D  PxMsgDta                    512a   Const  Varying
024000050507     **-- Send completion message:
024100050507     D SndCmpMsg       Pr            10i 0
024200050507     D  PxMsgDta                    512a   Const  Varying
024300051028
024400041216     **-- Write detail line:
024500041216     D WrtDtlLin       Pr
024600050507     **-- Write list header:
024700050507     D WrtLstHdr       Pr
024800050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
024900041216     **-- Write list trailer:
025000041216     D WrtLstTrl       Pr
025100050415     D  PxTrlTxt                     32a   Const
025200041212
025300050319     **-- Entry parameters:
025400051023     D CBX948          Pr
025500051028     D  PxInactDays                   3p 0
025600051028     D  PxInactChk                   10a
025700051028     D  PxAction                     10a
025800051028     D  PxUsrCls                           LikeDs( UsrCls )
025900051028     D  PxExcPrf                           LikeDs( ExcPrf )
026000051029     D  PxPrfSts                     10a
026100051029     D  PxSysPrf                      4a
026200041212     **
026300051023     D CBX948          Pi
026400051028     D  PxInactDays                   3p 0
026500051028     D  PxInactChk                   10a
026600051028     D  PxAction                     10a
026700051028     D  PxUsrCls                           LikeDs( UsrCls )
026800051028     D  PxExcPrf                           LikeDs( ExcPrf )
026900051029     D  PxPrfSts                     10a
027000051029     D  PxSysPrf                      4a
027100041211
027200041211      /Free
027300041211
027400050506        LstApi.RtnRcdNbr = 1;
027500051023        LstApi.SltCri = '*ALL';
027600051023        LstApi.GrpNam = '*NONE';
027700050506
027800050506        LstAutUsr( AUTU0100
027900050506                 : %Size( AUTU0100 )
028000050506                 : LstInf
028100050506                 : 1
028200050506                 : 'AUTU0100'
028300050506                 : LstApi.SltCri
028400050506                 : LstApi.GrpNam
028500050506                 : ERRC0100
028600050506                 );
028700050415
028800050506        If  ERRC0100.BytAvl = *Zero;
028900050506
029000050506          DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
029100050506
029200050507            ExSr  GetPrfInf;
029300050506
029400050506            LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
029500050506
029600050507            GetLstEnt( AUTU0100
029700050507                     : %Size( AUTU0100 )
029800050506                     : LstInf.Handle
029900050506                     : LstInf
030000050506                     : 1
030100050506                     : LstApi.RtnRcdNbr
030200050506                     : ERRC0100
030300050506                     );
030400050506
030500050506            If  ERRC0100.BytAvl > *Zero;
030600050506              Leave;
030700050506            EndIf;
030800050506
030900050506          EndDo;
031000050506
031100050506          CloseLst( LstInf.Handle: ERRC0100 );
031200050506        EndIf;
031300050506
031400050506        WrtLstTrl( '***  E N D  O F  L I S T  ***' );
031500050415
031600050507        SndCmpMsg( 'List has been printed.' );
031700050507
031800050506        *InLr = *On;
031900050506        Return;
032000050506
032100050415
032200050507        BegSr  GetPrfInf;
032300050507
032400050507          RtvUsrInf( USRI0300
032500050507                   : %Size( USRI0300 )
032600050507                   : 'USRI0300'
032700050507                   : AUTU0100.UsrPrf
032800050507                   : ERRC0100
032900050507                   );
033000050507
033100050507          If  ERRC0100.BytAvl = *Zero;
033200050507            ExSr  ChkPrfInf;
033300050507          EndIf;
033400041211
033500041211        EndSr;
033600041211
033700050507        BegSr  ChkPrfInf;
033800050319
033900051029          ObjCrtUsr = GetCrtUsr( USRI0300.UsrPrf );
034000051029          ObjCrtDat = GetCrtDat( USRI0300.UsrPrf );
034100051101          ObjRstDat = GetRstDat( USRI0300.UsrPrf );
034200051029
034300051029          PrfSts = *Zero;
034400051029
034500051029          Select;
034600051029          When  PxSysPrf = '*NO'  And  ObjCrtUsr = '*IBM';
034700051029            PrfSts = 1;
034800051029
034900051029          When  %Lookup( USRI0300.UsrCls: ChkUsrCls: 1: ClsIdx ) = *Zero;
035000051029            PrfSts = 2;
035100051029
035200051029          When  %Lookup( USRI0300.UsrPrf: ChkUsrPrf: 1: PrfIdx ) > *Zero;
035300051029            PrfSts = 3;
035400051029
035500051029          When  PxPrfSts <> '*ANY'  And  PxPrfSts <> USRI0300.PrfSts;
035600051029            PrfSts = 4;
035700051029
035800051029          Other;
035900051029            For  Idx = 1  To  GenIdx;
036000051029              If  %Scan( ChkGenPrf(Idx): USRI0300.UsrPrf ) = 1;
036100051029
036200051029                PrfSts = 5;
036300051029                Leave;
036400051029              EndIf;
036500051029            EndFor;
036600051029          EndSl;
036700051029
036800051029          If  PrfSts = *Zero;
036900051029
037000051029            ObjLstUsd = GetPrfLstUsd( USRI0300.UsrPrf );
037100051029
037200051029            If  USRI0300.PrvSgoDat = *Blanks;
037300051029              PrvSgnOn = *LoVal;
037400051029            Else;
037500051029              PrvSgnOn = %Date( USRI0300.PrvSgoDat: *CYMD0 );
037600051029            EndIf;
037700051029
037800051029            Select;
037900051029            When  PxInActChk = '*LASTUSED'  And  ObjLstUsd > *LoVal;
038000051029              InactDays = %Diff( %Date(): ObjLstUsd: *Days );
038100051028
038200051029            When  PxInActChk = '*PRVSIGNON'  And  PrvSgnOn > *LoVal;
038300051029              InactDays = %Diff( %Date(): PrvSgnOn: *Days );
038400051029
038500051101            When  ObjRstDat > *LoVal;
038600051101              InactDays = %Diff( %Date(): ObjRstDat: *Days );
038700051101
038800051029            Other;
038900051029              InactDays = %Diff( %Date(): ObjCrtDat: *Days );
039000051029            EndSl;
039100051028
039200051029            If  PxInactDays <= InactDays;
039300051029
039400051029              LstRcd.NewSts = '*SAME';
039500051029
039600051029              If  ObjCrtUsr <> '*IBM';
039700051029
039800051029                If  PxAction = '*DISABLE'  And  USRI0300.PrfSts = '*ENABLED';
039900051029
040000051101                  If  PrcCmd( 'CHGUSRPRF USRPRF('          +
040100051101                               %Trim( USRI0300.UsrPrf )    +
040200051029                              ') STATUS(*DISABLED)'
040300051029                            ) = -1;
040400051101
040500051029                    LstRcd.NewSts = '*NOCHG';
040600051029                  Else;
040700051101                    LstRcd.NewSts = '*DISABLED';
040800051101
040900051101                    SndUsrMsg( PgmSts.UsrPrf
041000051106                             : 'User profile '              +
041100051101                                %Trim( USRI0300.UsrPrf )    +
041200051101                               ' disabled by command ANZPRFUSG.'
041300051101                             );
041400051029                  EndIf;
041500051029                EndIf;
041600051029              EndIf;
041700051029
041800051029              ExSr WrtPrfInf;
041900051029            EndIf;
042000050507          EndIf;
042100050319
042200050319        EndSr;
042300050507
042400050507        BegSr  WrtPrfInf;
042500050507
042600051029          If  InactDays > 99999;
042700051029          LstRcd.InactD = 99999;
042800051029          Else;
042900051029          LstRcd.InactD = InactDays;
043000051029          EndIf;
043100051029
043200050507          LstRcd.UsrPrf = USRI0300.UsrPrf;
043300050507          LstRcd.PrfSts = USRI0300.PrfSts;
043400050507          LstRcd.InvSgo = USRI0300.InvSgo;
043500050507          LstRcd.GrpPrf = USRI0300.GrpPrf;
043600050507          LstRcd.UsrCls = USRI0300.UsrCls;
043700050507
043800050507          If  USRI0300.PwdExpDat = *Blanks;
043900050507            LstRcd.PwdExpD = '*NONE';
044000050507          Else;
044100050507            LstRcd.PwdExpD = %Char( CvtDtsDat( USRI0300.PwdExpDat ): *JOBRUN );
044200050507          EndIf;
044300050507
044400051029          If  ObjLstUsd = *LoVal;
044500051029            LstRcd.LstUsdD = '*NONE';
044600051029          Else;
044700051029            LstRcd.LstUsdD = %Char( ObjLstUsd: *JOBRUN );
044800051029          EndIf;
044900051029
045000050507          If  USRI0300.PwdChgDat = *Blanks;
045100050507            LstRcd.PwdChgD = '*NONE';
045200050507          Else;
045300050507            LstRcd.PwdChgD = %Char( CvtDtsDat( USRI0300.PwdChgDat ): *JOBRUN );
045400050507          EndIf;
045500050507
045600050507          If  USRI0300.PrvSgoDts = *Blanks;
045700050507            LstRcd.PrvSgoD = '*NONE';
045800050507          Else;
045900050507            LstRcd.PrvSgoD = %Char( %Date( USRI0300.PrvSgoDat: *CYMD0 )
046000050507                                  : *JOBRUN
046100050507                                  );
046200050507          EndIf;
046300050507
046400050507          If  USRI0300.PwdExpI = 'Y';
046500050507            LstRcd.PwdExpI = '*YES';
046600050507          Else;
046700050507            LstRcd.PwdExpI = '*NO';
046800050507          EndIf;
046900050507
047000050507          If  USRI0300.NoPwdI = 'Y';
047100050507            LstRcd.PwdI = '*NO';
047200050507          Else;
047300050507            LstRcd.PwdI = '*YES';
047400050507          EndIf;
047500050507
047600050507          WrtDtlLin();
047700050507
047800050507        EndSr;
047900050507
048000041212        BegSr  *InzSr;
048100041212
048200051029          For  Idx = 1  to PxUsrCls.NbrCls;
048300051029
048400051029            Select;
048500051029            When  PxUsrCls.ClsVal(Idx) = '*ALL';
048600051029              ChkUsrCls(1) = '*USER';
048700051029              ChkUsrCls(2) = '*PGMR';
048800051029              ChkUsrCls(3) = '*SYSOPR';
048900051029              ChkUsrCls(4) = '*SECADM';
049000051029              ChkUsrCls(5) = '*SECOFR';
049100051029              ClsIdx = 5;
049200051029
049300051029            When  PxUsrCls.ClsVal(Idx) = '*NONUSER';
049400051029              ChkUsrCls(1) = '*PGMR';
049500051029              ChkUsrCls(2) = '*SYSOPR';
049600051029              ChkUsrCls(3) = '*SECADM';
049700051029              ChkUsrCls(4) = '*SECOFR';
049800051029              ClsIdx = 4;
049900051029
050000051029            Other;
050100051029              ChkUsrCls(Idx) = PxUsrCls.ClsVal(Idx);
050200051029              ClsIdx += 1;
050300051029
050400051029            EndSl;
050500051029          EndFor;
050600051029
050700051029          For  Idx = 1  To  PxExcPrf.NbrPrf;
050800051029
050900051029            GenPrfPos = %Scan( '*': PxExcPrf.PrfVal(Idx): 2 );
051000051029
051100051029            Select;
051200051029            When  PxExcPrf.PrfVal(Idx) = '*NONE';
051300051029
051400051029            When  GenPrfPos > *Zero;
051500051029              GenIdx += 1;
051600051029              ChkGenPrf(GenIdx) = %Subst( PxExcPrf.Prfval(Idx): 1: GenPrfPos-1);
051700051029
051800051029            Other;
051900051029              PrfIdx += 1;
052000051029              ChkUsrPrf(PrfIdx) = PxExcPrf.PrfVal(Idx);
052100051029
052200051029            EndSl;
052300051029          EndFor;
052400051029
052500041212          LstTim = %Int( %Char( %Time(): *ISO0));
052600050319          SysNam = GetSysNam();
052700050507
052800050507          WrtLstHdr();
052900041212
053000041212        EndSr;
053100041212
053200050122      /End-Free
053300050122
053400041212     **-- Printer file definition:  ------------------------------------------**
053500041212     OQSYSPRT   EF           Header         2  2
053600041212     O                       UDATE         Y      8
053700041212     O                       LstTim              18 '  :  :  '
053800050319     O                                           36 'System:'
053900050319     O                       SysNam              45
054000051029     O                                           80 'User profile usage'
054100041212     O                                          107 'Program:'
054200050319     O                       PgmSts.PgmNam      118
054300041212     O                                          126 'Page:'
054400041212     O                       PAGE             +   1
054500050415     **
054600051029     OQSYSPRT   EF           LstHdr         1
054700051029     O                                           27 'Inactivity days . . . . . -
054800051029     O                                              :'
054900051029     O                       PxInactDays   3     32
055000051029     **
055100051029     OQSYSPRT   EF           LstHdr         2
055200051029     O                                           27 'Check attribute . . . . . -
055300051029     O                                              :'
055400051029     O                       PxInactChk          39
055500051029     **
055600041212     OQSYSPRT   EF           LstHdr         1
055700050507     O                                            4 'User'
055800050507     O                                           17 'Class'
055900051029     O                                           28 'Group'
056000051029     O                                           43 'Inv.sign.'
056100051029     O                                           52 'Password'
056200051029     O                                           62 'Pwd.exp.'
056300051029     O                                           71 'Pwd.chg.'
056400051029     O                                           81 'Exp.date'
056500051029     O                                           90 'Sign-on'
056600051029     O                                          101 'Last used'
056700051029     O                                          110 'Inact.'
056800051029     O                                          118 'Status'
056900051029     O                                          131 'New sts.'
057000041216     **
057100041212     OQSYSPRT   EF           DtlLin         1
057200050507     O                       LstRcd.UsrPrf       10
057300050507     O                       LstRcd.UsrCls       22
057400051029     O                       LstRcd.GrpPrf       33
057500051029     O                       LstRcd.InvSgo Z     41
057600051029     O                       LstRcd.PwdI         50
057700051029     O                       LstRcd.PwdExpI      60
057800051029     O                       LstRcd.PwdChgD      71
057900051029     O                       LstRcd.PwdExpD      81
058000051029     O                       LstRcd.PrvSgoD      91
058100051029     O                       LstRcd.LstUsdD     101
058200051029     O                       LstRcd.InactD 3    109
058300051029     O                       LstRcd.PrfSts      122
058400051029     O                       LstRcd.NewSts      132
058500041212     **
058600050123     OQSYSPRT   EF           LstTrl         1
058700050415     O                       TrlTxt              34
058800041216     **-- Write detail line:  ------------------------------------------------**
058900041216     P WrtDtlLin       B
059000041212     D                 Pi
059100041212
059200041212      /Free
059300041212
059400050507        WrtLstHdr( 3 );
059500041212
059600041216        Except  DtlLin;
059700041212
059800041212      /End-Free
059900041212
060000041216     P WrtDtlLin       E
060100050507     **-- Write list header:  ------------------------------------------------**
060200050507     P WrtLstHdr       B
060300050507     D                 Pi
060400050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
060500050507
060600050507      /Free
060700050507
060800050507        If  %Parms = *Zero;
060900050507
061000050507          Except  Header;
061100050507          Except  LstHdr;
061200050507        Else;
061300050507
061400050507          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
061500050507
061600050507            Except  Header;
061700050507            Except  LstHdr;
061800050507          EndIf;
061900050507        EndIf;
062000050507
062100050507      /End-Free
062200050507
062300050507     P WrtLstHdr       E
062400041216     **-- Write list trailer:  -----------------------------------------------**
062500041216     P WrtLstTrl       B
062600041216     D                 Pi
062700050415     D  PxTrlTxt                     32a   Const
062800041216
062900041216      /Free
063000041216
063100050415        TrlTxt = PxTrlTxt;
063200050415
063300041216        Except  LstTrl;
063400041216
063500041216      /End-Free
063600041216
063700041216     P WrtLstTrl       E
063800050318     **-- Convert system DTS to date:  ---------------------------------------**
063900050318     P CvtDtsDat       B
064000050318     D                 Pi              d
064100050318     D  PxSysDts                      8a   Value
064200050318
064300050318     D MI_DTS          s             20a
064400050318
064500050318      /Free
064600050318
064700050318        CvtDtf( '*DTS': PxSysDts: '*YYMD': MI_DTS: *Zero );
064800050318
064900050318        Return  %Date( %Timestamp( MI_DTS: *ISO0 ));
065000050318
065100050318      /End-Free
065200050318
065300050318     P CvtDtsDat       E
065400050319     **-- Get system name:  --------------------------------------------------**
065500050319     P GetSysNam       B
065600050319     D                 Pi             8a   Varying
065700051029
065800050319     **-- Local variables:
065900050319     D Idx             s             10i 0
066000050319     D SysNam          s              8a   Varying
066100050319     **
066200050319     D RtnAtrLen       s             10i 0
066300050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
066400050319     D NetAtr          s             10a   Dim( 1 )
066500050319     **
066600050319     D RtnVar          Ds                  Qualified
066700050319     D  RtnVarNbr                    10i 0
066800050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
066900050319     D  RtnVarDta                  1024a
067000050319
067100050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
067200050319     D  AtrNam                       10a
067300050319     D  DtaTyp                        1a
067400050319     D  InfSts                        1a
067500050319     D  AtrLen                       10i 0
067600050319     D  Atr                        1008a
067700050319
067800050319      /Free
067900050319
068000050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
068100050319
068200050319        NetAtr(1) = 'SYSNAME';
068300050319
068400050319        RtvNetAtr( RtnVar
068500050319                 : RtnAtrLen
068600050319                 : NetAtrNbr
068700050319                 : NetAtr
068800050319                 : ERRC0100
068900050319                 );
069000050319
069100050319        If  ERRC0100.BytAvl > *Zero;
069200050319          SysNam = '';
069300050319
069400050319        Else;
069500050319          For  Idx = 1  to RtnVar.RtnVarNbr;
069600050319
069700050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
069800050319
069900050319            If  RtnAtr.AtrNam = 'SYSNAME';
070000050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
070100050319            EndIf;
070200050319
070300050319          EndFor;
070400050319        EndIf;
070500050319
070600050319        Return  SysNam;
070700050319
070800050319      /End-Free
070900050319
071000050319     P GetSysNam       E
071100051029     **-- Get creating user profile:  ----------------------------------------**
071200051029     P GetCrtUsr       B
071300050506     D                 Pi            10a
071400050506     D  PxUsrPrf                     10a   Value
071500050506     **
071600050506     D OBJD0300        Ds                  Qualified
071700050506     D  BytRtn                       10i 0
071800050506     D  BytAvl                       10i 0
071900050506     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )
072000050506
072100050506      /Free
072200050506
072300050506        RtvObjD( OBJD0300
072400050506               : %Size( OBJD0300 )
072500050506               : 'OBJD0300'
072600050506               : PxUsrPrf + 'QSYS'
072700050506               : '*USRPRF'
072800050506               : ERRC0100
072900050506               );
073000050506
073100050506        If  ERRC0100.BytAvl > *Zero;
073200050506          Return  *Blanks;
073300050506
073400050506        Else;
073500050506          Return  OBJD0300.ObjCrt;
073600050506        EndIf;
073700050506
073800050506      /End-Free
073900050506
074000051029     P GetCrtUsr       E
074100051029     **-- Get profile creation date:  ----------------------------------------**
074200051029     P GetCrtDat       B
074300051029     D                 Pi              d
074400051029     D  PxUsrPrf                     10a   Value
074500051029     **
074600051029     D OBJD0100        Ds                  Qualified
074700051029     D  BytRtn                       10i 0
074800051029     D  BytAvl                       10i 0
074900051029     D  CrtDts                       13a   Overlay( OBJD0100: 65 )
075000051029     D   CrtDat                       7a   Overlay( CrtDts: 1 )
075100051029     D   CrtTim                       6a   Overlay( CrtDts: 8 )
075200051029
075300051029      /Free
075400051029
075500051029        RtvObjD( OBJD0100
075600051029               : %Size( OBJD0100 )
075700051029               : 'OBJD0100'
075800051029               : PxUsrPrf + 'QSYS'
075900051029               : '*USRPRF'
076000051029               : ERRC0100
076100051029               );
076200051029
076300051029        If  ERRC0100.BytAvl > *Zero;
076400051029          Return  *LoVal;
076500051029
076600051029        Else;
076700051029          Return  %Date( OBJD0100.CrtDat: *CYMD0 );
076800051029        EndIf;
076900051029
077000051029      /End-Free
077100051029
077200051029     P GetCrtDat       E
077300051101     **-- Get profile restore date:  -----------------------------------------**
077400051101     P GetRstDat       B
077500051101     D                 Pi              d
077600051101     D  PxUsrPrf                     10a   Value
077700051101     **
077800051101     D OBJD0300        Ds                  Qualified
077900051101     D  BytRtn                       10i 0
078000051101     D  BytAvl                       10i 0
078100051101     D  RstDts                       13a   Overlay( OBJD0300: 207 )
078200051101     D   RstDat                       7a   Overlay( RstDts: 1 )
078300051101     D   RstTim                       6a   Overlay( RstDts: 8 )
078400051101
078500051101      /Free
078600051101
078700051101        RtvObjD( OBJD0300
078800051101               : %Size( OBJD0300 )
078900051101               : 'OBJD0300'
079000051101               : PxUsrPrf + 'QSYS'
079100051101               : '*USRPRF'
079200051101               : ERRC0100
079300051101               );
079400051101
079500051101        Select;
079600051101        When  ERRC0100.BytAvl > *Zero;
079700051101          Return  *LoVal;
079800051101
079900051101        When  OBJD0300.RstDat = *Blanks;
080000051101          Return  *LoVal;
080100051101
080200051101        Other;
080300051101          Return  %Date( OBJD0300.RstDat: *CYMD0 );
080400051101        EndSl;
080500051101
080600051101      /End-Free
080700051101
080800051101     P GetRstDat       E
080900051023     **-- Get user profile last used date:  ----------------------------------**
081000051023     P GetPrfLstUsd    B
081100051023     D                 Pi              d
081200051023     D  PxUsrPrf                     10a   Value
081300051023     **
081400051023     D OBJD0400        Ds                  Qualified
081500051023     D  BytRtn                       10i 0
081600051023     D  BytAvl                       10i 0
081700051023     D  ObjLstUsd                     7a   Overlay( OBJD0400: 461 )
081800051023
081900051023      /Free
082000051023
082100051023        RtvObjD( OBJD0400
082200051023               : %Size( OBJD0400 )
082300051023               : 'OBJD0400'
082400051023               : PxUsrPrf + 'QSYS'
082500051023               : '*USRPRF'
082600051023               : ERRC0100
082700051023               );
082800051023
082900051023        Select;
083000051023        When  ERRC0100.BytAvl > *Zero;
083100051023          Return  *LoVal;
083200051023
083300051023        When  OBJD0400.ObjLstUsd = *Blanks;
083400051023          Return  *LoVal;
083500051023
083600051023        Other;
083700051023          Return  %Date( OBJD0400.ObjLstUsd: *CYMD0 );
083800051023        EndSl;
083900051023
084000051023      /End-Free
084100051023
084200051023     P GetPrfLstUsd    E
084300051028     **-- Process command:  --------------------------------------------------**
084400051028     P PrcCmd          B                   Export
084500051028     D                 Pi            10i 0
084600051028     D  PxCmdStr                   1024a   Const  Varying
084700051028
084800051028     **-- Local variables:
084900051028     D CPOP0100        Ds                  Qualified
085000051028     D  TypPrc                       10i 0 Inz( 2 )
085100051028     D  DBCS                          1a   Inz( '0' )
085200051028     D  PmtAct                        1a   Inz( '2' )
085300051028     D  CmdStx                        1a   Inz( '0' )
085400051028     D  MsgRtvKey                     4a   Inz( *Allx'00' )
085500051028     D  Rsv                           9a   Inz( *Allx'00' )
085600051028     **
085700051028     D ChgCmd          s          32767a
085800051028     D ChgCmdAvl       s             10i 0
085900051028
086000051028      /Free
086100051028
086200051028        PrcCmds( PxCmdStr
086300051028               : %Len( PxCmdStr )
086400051028               : CPOP0100
086500051028               : %Size( CPOP0100 )
086600051028               : 'CPOP0100'
086700051028               : ChgCmd
086800051028               : %Size( ChgCmd )
086900051028               : ChgCmdAvl
087000051028               : ERRC0100
087100051028               );
087200051028
087300051029        If  ERRC0100.BytAvl > *Zero;
087400051028          Return  -1;
087500051028
087600051028        Else;
087700051028          Return  0;
087800051028        EndIf;
087900051028
088000051028      /End-Free
088100051028
088200051029     P PrcCmd          E
088300051101     **-- Send user message:  ------------------------------------------------**
088400051101     P SndUsrMsg       B                   Export
088500051101     D                 Pi            10i 0
088600051101     D  PxUsrPrf                     10a   Const
088700051101     D  PxMsgDta                    512a   Const  Varying
088800051101     **
088900051101     D MsgKey          s              4a
089000051101
089100051101      /Free
089200051101
089300051101        SndMsg( 'CPF9897'
089400051101              : 'QCPFMSG   *LIBL'
089500051101              : PxMsgDta
089600051101              : %Len( PxMsgDta )
089700051101              : '*INFO'
089800051101              : PxUsrPrf + '*LIBL'
089900051101              : 1
090000051101              : *Blanks
090100051101              : MsgKey
090200051101              : ERRC0100
090300051101              );
090400051101
090500051101        If  ERRC0100.BytAvl > *Zero;
090600051101          Return -1;
090700051101
090800051101        Else;
090900051101          Return  0;
091000051101        EndIf;
091100051101
091200051101      /End-Free
091300051101
091400051101     **
091500051101     P SndUsrMsg       E
091600050507     **-- Send completion message:  ------------------------------------------**
091700050507     P SndCmpMsg       B
091800050507     D                 Pi            10i 0
091900050507     D  PxMsgDta                    512a   Const  Varying
092000050507     **
092100050507     D MsgKey          s              4a
092200050507
092300050507      /Free
092400050507
092500050507        SndPgmMsg( 'CPF9897'
092600050507                 : 'QCPFMSG   *LIBL'
092700050507                 : PxMsgDta
092800050507                 : %Len( PxMsgDta )
092900050507                 : '*COMP'
093000050507                 : '*PGMBDY'
093100050507                 : 1
093200050507                 : MsgKey
093300050507                 : ERRC0100
093400050507                 );
093500050507
093600050507        If  ERRC0100.BytAvl > *Zero;
093700050507          Return  -1;
093800050507
093900050507        Else;
094000050507          Return  0;
094100050507
094200050507        EndIf;
094300050507
094400050507      /End-Free
094500050507
094600050507     P SndCmpMsg       E
