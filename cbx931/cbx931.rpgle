000100041212     **
000200050305     **  Program . . : CBX931
000300050303     **  Description : Change object authority - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Program description:
000800050304     **    This program will replace the specified user's authority to the
000900050304     **    selected objects with the specified new authority.
001000041212     **
001100041212     **
001200050304     **  Compile instructions:
001300050305     **    CrtRpgMod   Module( CBX931 )
001400050304     **                DbgView( *LIST )
001500041212     **
001600050305     **    CrtPgm      Pgm( CBX931 )
001700050305     **                Module( CBX931 )
001800041212     **                ActGrp( *NEW )
001900041212     **
002000041212     **
002100041212     **-- Control specification:  --------------------------------------------**
002200041212     H Option( *SrcStmt: *NoDebugIo )
002300050303     **-- System information:
002400050303     D PgmSts         sDs                  Qualified
002500050303     D  JobUsr                       10a   Overlay( PgmSts: 254 )
002600050303     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002700041211     **-- API error data structure:
002800041211     D ERRC0100        Ds                  Qualified
002900041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003000041211     D  BytAvl                       10i 0
003100041211     D  MsgId                         7a
003200990921     D                                1a
003300041211     D  MsgDta                      128a
003400050212     **-- Global constants:
003500050303     D USR_SPC_Q       c                   'AUTLST    QTEMP'
003600050306     D OFS_MSGDTA      c                   16
003700050303     D NBR_KEY         c                   2
003800041212     **-- Global variables:
003900041211     D Idx             s             10i 0
004000050306     D ObjCntSlt       s             10i 0 Inz( *Zero )
004100050306     D ObjCntIgn       s             10i 0 Inz( *Zero )
004200050304     D NewAutL         s            110a   Varying
004300050303     **
004400050304     D CmpAut          Ds                  LikeDs( USRA0100 )
004500050304     **
004600050303     D CurAut          Ds                  Qualified
004700050303     D  NbrAut                        5i 0
004800050303     D  AutVal                       10a   Dim( 10 )
004900050303     **
005000050303     D NewAut          Ds                  Qualified
005100050303     D  NbrAut                        5i 0
005200050303     D  AutVal                       10a   Dim( 10 )
005300050303     **-- Entry format USRA0100:
005400050303     D USRA0100        Ds                  Qualified  Based( pLstEnt )
005500050303     D  UsrPrf                       10a
005600050303     D  AutVal                       10a
005700050303     D  AutLstMgt                     1a
005800050303     D  ObjOpr                        1a
005900050303     D  ObjMgt                        1a
006000050303     D  ObjExs                        1a
006100050303     D  DtaRead                       1a
006200050303     D  DtaAdd                        1a
006300050303     D  DtaUpd                        1a
006400050303     D  DtaDlt                        1a
006500050303     D  DtaExe                        1a
006600050303     D                               10a
006700050303     D  ObjAlt                        1a
006800050303     D  ObjRef                        1a
006900050303     **-- USRA0100 - header information:
007000050303     D HdrInf          Ds                  Qualified  Based( pHdrInf )
007100050303     D  ObjNam                       10a
007200050303     D  LibNam                       10a
007300050303     D  ObjTyp                       10a
007400050303     D  OwnNam                       10a
007500050303     D  AutL                         10a
007600050303     D  PriGrp                       10a
007700050303     D  FldAut                        1a
007800050303     D  AspDevLib                    10a
007900050303     D  AspDevObj                    10a
008000050303     **-- User space generic header:
008100050303     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
008200050303     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
008300050303     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
008400050303     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
008500050303     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
008600050303     **-- Space pointers:
008700050303     D pUsrSpc         s               *   Inz( *Null )
008800050303     D pHdrInf         s               *   Inz( *Null )
008900050303     D pLstEnt         s               *   Inz( *Null )
009000050212     **-- List API parameters:
009100050212     D LstApi          Ds                  Qualified  Inz
009200050212     D  RtnRcdNbr                    10i 0
009300050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
009400050303     D  KeyFld                       10i 0 Dim( NBR_KEY )
009500050212     D  ObjTyp                       10a
009600040426     **-- Object information:
009700041211     D ObjInf          Ds          4096    Qualified
009800041212     D  ObjNam                       10a
009900041212     D  ObjLib                       10a
010000041212     D  ObjTyp                       10a
010100041211     D  InfSts                        1a
010200040426     D                                1a
010300041211     D  FldNbrRtn                    10i 0
010400041211     D  Data                               Like( KeyInf )
010500040426     **-- Key information:
010600041211     D KeyInf          Ds                  Qualified  Based( pKeyInf )
010700041211     D  FldInfLen                    10i 0
010800041211     D  KeyFld                       10i 0
010900041211     D  DtaTyp                        1a
011000041211     D                                3a
011100041211     D  DtaLen                       10i 0
011200041211     D  Data                        256a
011300040426     **-- List information:
011400041211     D LstInf          Ds                  Qualified
011500041211     D  RcdNbrTot                    10i 0
011600041211     D  RcdNbrRtn                    10i 0
011700041211     D  Handle                        4a
011800041211     D  RcdLen                       10i 0
011900041211     D  InfSts                        1a
012000041211     D  Dts                          13a
012100041211     D  LstSts                        1a
012200040426     D                                1a
012300041211     D  InfLen                       10i 0
012400041211     D  Rcd1                         10i 0
012500040426     D                               40a
012600040426     **-- Sort information:
012700041211     D SrtInf          Ds                  Qualified
012800041211     D  NbrKeys                      10i 0 Inz( 0 )
012900041211     D  SrtInf                       12a   Dim( 10 )
013000041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
013100041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
013200041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
013300041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
013400041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
013500040426     **-- Authority control:
013600041211     D AutCtl          Ds                  Qualified
013700041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
013800041211     D  CalLvl                       10i 0 Inz( 0 )
013900041211     D  DplObjAut                    10i 0 Inz( 0 )
014000041211     D  NbrObjAut                    10i 0 Inz( 0 )
014100041211     D  DplLibAut                    10i 0 Inz( 0 )
014200041211     D  NbrLibAut                    10i 0 Inz( 0 )
014300040426     D                               10i 0 Inz( 0 )
014400041211     D  ObjAut                       10a   Dim( 10 )
014500041211     D  LibAut                       10a   Dim( 10 )
014600040426     **-- Selection control:
014700041211     D SltCtl          Ds
014800041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
014900041211     D  SltOmt                       10i 0 Inz( 0 )
015000041211     D  DplSts                       10i 0 Inz( 20 )
015100041211     D  NbrSts                       10i 0 Inz( 1 )
015200040426     D                               10i 0 Inz( 0 )
015300041211     D  Status                        1a   Inz( '*' )
015400040426     **-- Object information key fields:
015500041211     D KEY0200         Ds                  Qualified
015600041211     D  InfSts                        1a
015700041211     D  ExtObjAtr                    10a
015800041211     D  TxtDsc                       50a
015900041211     D  UsrDfnAtr                    10a
016000041211     D  OrdLibL                      10i 0
016100040426     D                                5a
016200041211     **
016300041211     D ObjOwn          s             10a
016400041211     **-- Open list of objects:
016500040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
016600040426     D  LoRcvVar                  65535a          Options( *VarSize )
016700040426     D  LoRcvVarLen                  10i 0 Const
016800040426     D  LoLstInf                     80a
016900040426     D  LoNbrRcdRtn                  10i 0 Const
017000040426     D  LoSrtInf                   1024a   Const  Options( *VarSize )
017100040426     D  LoObjNam_q                   20a   Const
017200040426     D  LoObjTyp                     10a   Const
017300040426     D  LoAutCtl                   1024a   Const  Options( *VarSize )
017400040426     D  LoSltCtl                   1024a   Const  Options( *VarSize )
017500041211     D  LoNbrKeyRtn                  10i 0 Const
017600041211     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
017700040426     D  LoError                    1024a          Options( *VarSize )
017800020531     **
017900040426     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
018000040426     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
018100040426     **
018200040426     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
018300041212     **-- Get list entry:
018400020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
018500020531     D  GlRcvVar                  65535a          Options( *VarSize )
018600020531     D  GlRcvVarLen                  10i 0 Const
018700020531     D  GlHandle                      4a   Const
018800020531     D  GlLstInf                     80a
018900020531     D  GlNbrRcdRtn                  10i 0 Const
019000020531     D  GlRtnRcdNbr                  10i 0 Const
019100020531     D  GlError                    1024a          Options( *VarSize )
019200041212     **-- Close list:
019300020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
019400020531     D  ClHandle                      4a   Const
019500020531     D  ClError                    1024a          Options( *VarSize )
019600050303     **-- List authorized users:
019700050303     D LstAutUsr       Pr                  ExtPgm( 'QSYLUSRA' )
019800050303     D  LaSpcNamQ                    20a   Const
019900050303     D  LaFmtNam                      8a   Const
020000050303     D  LaObjNamQ                    20a   Const
020100050303     D  LaObjTyp                     10a   Const
020200050303     D  LaError                   32767a          Options( *VarSize )
020300050303     D  LaAspDev                     10a          Options( *NoPass )
020400050303     **-- Create user space:
020500050303     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
020600050303     D  CsSpcNamQ                    20a   Const
020700050303     D  CsExtAtr                     10a   Const
020800050303     D  CsInzSiz                     10i 0 Const
020900050303     D  CsInzVal                      1a   Const
021000050303     D  CsPubAut                     10a   Const
021100050303     D  CsText                       50a   Const
021200050303     D  CsReplace                    10a   Const  Options( *NoPass )
021300050303     D  CsError                   32767a          Options( *NoPass: *VarSize )
021400050303     D  CsDomain                     10a   Const  Options( *NoPass )
021500050303     D  CsTfrSizRqs                  10i 0 Const  Options( *NoPass )
021600050303     D  CsOptSpcAlg                   1a   Const  Options( *NoPass )
021700050303     **-- Retrieve pointer to user space:
021800050303     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
021900050303     D  RpSpcNamQ                    20a   Const
022000050303     D  RpPointer                      *
022100050303     D  RpError                   32767a          Options( *NoPass: *VarSize )
022200050303     **-- Delete user space:
022300050303     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
022400050303     D  DsSpcNamQ                    20a   Const
022500050303     D  DsError                   32767a          Options( *VarSize )
022600050303     **-- Process commands:
022700050303     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
022800050303     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
022900050303     D  PcSrcCmdLen                  10i 0 Const
023000050303     D  PcOptCtlBlk                  20a   Const
023100050303     D  PcOptCtlBlkLn                10i 0 Const
023200050303     D  PcOptCtlBlkFm                 8a   Const
023300050303     D  PcChgCmd                  32767a          Options( *VarSize )
023400050303     D  PcChgCmdLen                  10i 0 Const
023500050303     D  PcChgCmdLenAv                10i 0
023600050303     D  PcError                   32767a          Options( *VarSize )
023700050306     **-- Send program message:
023800050306     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
023900050306     D  SpMsgId                       7a   Const
024000050306     D  SpMsgFq                      20a   Const
024100050306     D  SpMsgDta                    128a   Const
024200050306     D  SpMsgDtaLen                  10i 0 Const
024300050306     D  SpMsgTyp                     10a   Const
024400050306     D  SpCalStkE                    10a   Const  Options( *VarSize )
024500050306     D  SpCalStkCtr                  10i 0 Const
024600050306     D  SpMsgKey                      4a
024700050306     D  SpError                    1024a          Options( *VarSize )
024800041212
024900050306     **-- Compare authority values:
025000050306     D CmpAutVal       Pr              n
025100050306     D  PxAutVal1                          LikeDs( USRA0100 )
025200050306     D  PxAutVal2                          LikeDs( USRA0100 )
025300050303     **-- Process command:
025400050303     D PrcCmd          Pr             7a
025500050303     D  CmdStr                     1024a   Const  Varying
025600050306     **-- Send escape message:
025700050306     D SndEscMsg       Pr            10i 0
025800050306     D  PxMsgId                       7a   Const
025900050306     D  PxMsgF                       10a   Const
026000050306     D  PxMsgDta                    512a   Const  Varying
026100050306     **-- Send completion message:
026200050306     D SndCmpMsg       Pr            10i 0
026300050306     D  PxMsgDta                    512a   Const  Varying
026400050303
026500050305     D CBX931          Pr
026600050303     D  PxObjNam_q                   20a
026700050407     D  PxObjTyp                      7a
026800050407     D  PxUsrPrf                     10a
026900050303     D  PxCurAut                           LikeDs( CurAut )
027000050303     D  PxNewAut                           LikeDs( NewAut )
027100041212     **
027200050305     D CBX931          Pi
027300050303     D  PxObjNam_q                   20a
027400050407     D  PxObjTyp                      7a
027500050407     D  PxUsrPrf                     10a
027600050303     D  PxCurAut                           LikeDs( CurAut )
027700050303     D  PxNewAut                           LikeDs( NewAut )
027800041211
027900041211      /Free
028000050303
028100050303        If  PxUsrPrf = '*CURRENT';
028200050303          PxUsrPrf = PgmSts.CurUsr;
028300050303        EndIf;
028400041211
028500050212        LstApi.KeyFld(1) = 200;
028600050212        LstApi.KeyFld(2) = 302;
028700041211
028800041211        SrtInf.NbrKeys      = 0;
028900041211        SrtInf.KeyFldOfs(1) = 0;
029000041211        SrtInf.KeyFldLen(1) = 0;
029100041211        SrtInf.KeyFldTyp(1) = 0;
029200041211        SrtInf.SrtOrd(1)    = '1';
029300041211        SrtInf.Rsv(1)       = x'00';
029400041211
029500050303        LstApi.RtnRcdNbr = 1;
029600050303
029700050303        LstObjs( ObjInf
029800050303               : %Size( ObjInf )
029900050303               : LstInf
030000050303               : 1
030100050303               : SrtInf
030200050303               : PxObjNam_q
030300050303               : PxObjTyp
030400050303               : AutCtl
030500050303               : SltCtl
030600050303               : LstApi.NbrKeyRtn
030700050303               : LstApi.KeyFld
030800050303               : ERRC0100
030900050303               );
031000050303
031100050306        If  ERRC0100.BytAvl > *Zero;
031200050306
031300050306          If  ERRC0100.BytAvl < OFS_MSGDTA;
031400050306            ERRC0100.BytAvl = OFS_MSGDTA;
031500050306          EndIf;
031600050306
031700050306          SndEscMsg( ERRC0100.MsgId
031800050306                   : 'QCPFMSG'
031900050306                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
032000050306                   );
032100050306        Else;
032200050306
032300050306          CrtUsrSpc( USR_SPC_Q
032400050306                   : *Blanks
032500050306                   : 65535
032600050306                   : x'00'
032700050306                   : '*CHANGE'
032800050306                   : *Blanks
032900050306                   : '*YES'
033000050306                   : ERRC0100
033100050306                   );
033200050303
033300050303          DoW  LstInf.LstSts <> '2'  Or
033400050303               LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
033500050303
033600050303            ExSr  GetKeyDta;
033700050303            ExSr  ChkObjAut;
033800050303
033900050303            LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
034000050303
034100050303            GetLstEnt( ObjInf
034200050303                     : %Size( ObjInf )
034300050303                     : LstInf.Handle
034400050303                     : LstInf
034500050303                     : 1
034600050303                     : LstApi.RtnRcdNbr
034700050303                     : ERRC0100
034800050303                     );
034900050303
035000050303            If  ERRC0100.BytAvl > *Zero;
035100050303              Leave;
035200050303            EndIf;
035300050303
035400050303          EndDo;
035500050306
035600050306          DltUsrSpc( USR_SPC_Q: ERRC0100 );
035700050303        EndIf;
035800050303
035900050303        CloseLst( LstInf.Handle: ERRC0100 );
036000050122
036100050306        SndCmpMsg( 'Command completed normally. ' + %Char( ObjCntSlt ) +
036200050306                   ' objects changed. '           + %Char( ObjCntIgn ) +
036300050306                   ' objects not changed.'
036400050306                 );
036500050306
036600041211        *InLr = *On;
036700041211        Return;
036800041211
036900050303
037000041211        BegSr  GetKeyDta;
037100041211
037200041211          pKeyInf = %Addr( ObjInf.Data );
037300041211
037400050304          For  Idx = 1  To  ObjInf.FldNbrRtn;
037500041211
037600041211            Select;
037700041211            When  KeyInf.KeyFld = 200;
037800041211              KEY0200 = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
037900041211
038000041211            When  KeyInf.KeyFld = 302;
038100041211              ObjOwn = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
038200041211            EndSl;
038300041211
038400041211            If  Idx < ObjInf.FldNbrRtn;
038500041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
038600041211            EndIf;
038700041211          EndFor;
038800041211
038900041211        EndSr;
039000041211
039100050303        BegSr  ChkObjAut;
039200050303
039300050303          LstAutUsr( USR_SPC_Q
039400050303                   : 'USRA0100'
039500050303                   : ObjInf.ObjNam + ObjInf.ObjLib
039600050303                   : ObjInf.ObjTyp
039700050303                   : ERRC0100
039800050303                   );
039900050303
040000050304          If  ERRC0100.BytAvl = *Zero;
040100050303
040200050303            RtvPtrSpc( USR_SPC_Q: pUsrSpc );
040300050303
040400050303            ExSr  ChkUsrAut;
040500050303          EndIf;
040600050303
040700050303        EndSr;
040800050303
040900050303        BegSr  ChkUsrAut;
041000050303
041100050303          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
041200050303          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
041300050303
041400050304          For  Idx = 1  To  UsrSpc.NumLstEnt;
041500050303
041600050303            If  USRA0100.UsrPrf = PxUsrPrf;
041700050304
041800050304              If  CmpAutVal( USRA0100: CmpAut ) = *On;
041900050303
042000050303                PrcCmd( 'GRTOBJAUT OBJ(' + %Trim( ObjInf.ObjLib ) + '/'  +
042100050303                                           %Trim( ObjInf.ObjNam ) + ') ' +
042200050303                              'OBJTYPE(' + %Trim( ObjInf.ObjTyp ) + ') ' +
042300050303                              'USER('    + %Trim( PxUsrPrf )      + ') ' +
042400050304                              'AUT('     + %Trim( NewAutL )       + ') ' +
042500050303                              'REPLACE(*YES)'
042600050303                      );
042700050306
042800050306                ObjCntSlt += 1;
042900050306              Else;
043000050306                ObjCntIgn += 1;
043100050304              EndIf;
043200050303
043300050303              Leave;
043400050303            EndIf;
043500050303
043600050303            If  Idx < UsrSpc.NumLstEnt;
043700050303              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
043800050303            EndIf;
043900050303          EndFor;
044000050303
044100050303        EndSr;
044200050303
044300050303        BegSr  ChkAutVal;
044400050303
044500050304        EndSr;
044600050122
044700050304        BegSr  *InzSr;
044800050304
044900050304          NewAutL = PxNewAut.AutVal(1);
045000050304
045100050304          For  Idx = 2  To  PxNewAut.NbrAut;
045200050304            NewAutL += ' ' + PxNewAut.AutVal(Idx);
045300050304          EndFor;
045400050304
045500050304          CmpAut.ObjOpr  = 'N';
045600050304          CmpAut.ObjMgt  = 'N';
045700050304          CmpAut.ObjExs  = 'N';
045800050304          CmpAut.ObjAlt  = 'N';
045900050304          CmpAut.ObjRef  = 'N';
046000050304          CmpAut.DtaRead = 'N';
046100050304          CmpAut.DtaAdd  = 'N';
046200050304          CmpAut.DtaUpd  = 'N';
046300050304          CmpAut.DtaDlt  = 'N';
046400050304          CmpAut.DtaExe  = 'N';
046500050304
046600050304          For  Idx = 1  To  PxCurAut.NbrAut;
046700050304
046800050304            Select;
046900050304            When  PxCurAut.AutVal(Idx) = '*ALL';
047000050304              CmpAut.ObjOpr  = 'Y';
047100050304              CmpAut.ObjMgt  = 'Y';
047200050304              CmpAut.ObjExs  = 'Y';
047300050304              CmpAut.ObjAlt  = 'Y';
047400050304              CmpAut.ObjRef  = 'Y';
047500050304              CmpAut.DtaRead = 'Y';
047600050304              CmpAut.DtaAdd  = 'Y';
047700050304              CmpAut.DtaUpd  = 'Y';
047800050304              CmpAut.DtaDlt  = 'Y';
047900050304              CmpAut.DtaExe  = 'Y';
048000050304
048100050304            When  PxCurAut.AutVal(Idx) = '*CHANGE';
048200050304              CmpAut.ObjOpr  = 'Y';
048300050304              CmpAut.DtaRead = 'Y';
048400050304              CmpAut.DtaAdd  = 'Y';
048500050304              CmpAut.DtaUpd  = 'Y';
048600050304              CmpAut.DtaDlt  = 'Y';
048700050304              CmpAut.DtaExe  = 'Y';
048800050304
048900050304            When  PxCurAut.AutVal(Idx) = '*USE';
049000050304              CmpAut.ObjOpr  = 'Y';
049100050304              CmpAut.DtaRead = 'Y';
049200050304              CmpAut.DtaExe  = 'Y';
049300050304
049400050304            When  PxCurAut.AutVal(Idx) = '*EXCLUDE';
049500050304
049600050304            When  PxCurAut.AutVal(Idx) = '*OBJOPR';
049700050304              CmpAut.ObjOpr  = 'Y';
049800050304
049900050304            When  PxCurAut.AutVal(Idx) = '*OBJMGT';
050000050304              CmpAut.ObjMgt  = 'Y';
050100050304
050200050304            When  PxCurAut.AutVal(Idx) = '*OBJEXIST';
050300050304              CmpAut.ObjExs  = 'Y';
050400050304
050500050304            When  PxCurAut.AutVal(Idx) = '*OBJALTER';
050600050304              CmpAut.ObjAlt  = 'Y';
050700050304
050800050304            When  PxCurAut.AutVal(Idx) = '*OBJREF';
050900050304              CmpAut.ObjRef  = 'Y';
051000050304
051100050304            When  PxCurAut.AutVal(Idx) = '*READ';
051200050304              CmpAut.DtaRead = 'Y';
051300050304
051400050304            When  PxCurAut.AutVal(Idx) = '*ADD';
051500050304              CmpAut.DtaAdd  = 'Y';
051600050304
051700050304            When  PxCurAut.AutVal(Idx) = '*UPD';
051800050304              CmpAut.DtaUpd  = 'Y';
051900050304
052000050304            When  PxCurAut.AutVal(Idx) = '*DLT';
052100050304              CmpAut.DtaDlt  = 'Y';
052200050304
052300050304            When  PxCurAut.AutVal(Idx) = '*EXECUTE';
052400050304              CmpAut.DtaExe  = 'Y';
052500050304            EndSl;
052600050304          EndFor;
052700050304
052800050304        EndSr;
052900050304
053000050303      /End-Free
053100050303
053200050306     **-- Compare authority values:  -----------------------------------------**
053300050306     P CmpAutVal       B
053400050306     D                 Pi              n
053500050306     D  PxAutVal1                          LikeDs( USRA0100 )
053600050306     D  PxAutVal2                          LikeDs( USRA0100 )
053700050306
053800050306      /Free
053900050306
054000050306        If  %Subst( PxAutVal1: 22 ) = %Subst( PxAutVal2: 22 );
054100050306          Return  *On;
054200050306        Else;
054300050306          Return  *Off;
054400050306        EndIf;
054500050306
054600050306      /End-Free
054700050306
054800050306     P CmpAutVal       E
054900050303     **-- Process command:  --------------------------------------------------**
055000050304     P PrcCmd          B
055100050303     D                 Pi             7a
055200050303     D  PxCmdStr                   1024a   Const  Varying
055300050303     **-- Local variables:
055400050303     D CpOptCtlBlk     Ds
055500050303     D  CpTypPrc                     10i 0 Inz( 2 )
055600050303     D  CpDBCS                        1a   Inz( '0' )
055700050303     D  CpPmtAct                      1a   Inz( '2' )
055800050303     D  CpCmdStx                      1a   Inz( '0' )
055900050303     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
056000050303     D  CpRsv                         9a   Inz( *Allx'00' )
056100050303     **
056200050303     D CpChgCmd        s          32767a
056300050303     D CpChgCmdAvl     s             10i 0
056400050303
056500050303      /Free
056600050303
056700050303        PrcCmds( PxCmdStr
056800050303               : %Len( PxCmdStr )
056900050303               : CpOptCtlBlk
057000050303               : %Size( CpOptCtlBlk )
057100050303               : 'CPOP0100'
057200050303               : CpChgCmd
057300050303               : %Size( CpChgCmd )
057400050303               : CpChgCmdAvl
057500050303               : ERRC0100
057600050303               );
057700050303
057800050303        If  ERRC0100.BytAvl > *Zero;
057900050303          Return  ERRC0100.MsgId;
058000050303        Else;
058100050303          Return  *Blanks;
058200050303        EndIf;
058300050303
058400050303      /End-Free
058500050303
058600050303     P PrcCmd          E
058700050306     **-- Send escape message:  ----------------------------------------------**
058800050306     P SndEscMsg       B
058900050306     D                 Pi            10i 0
059000050306     D  PxMsgId                       7a   Const
059100050306     D  PxMsgF                       10a   Const
059200050306     D  PxMsgDta                    512a   Const  Varying
059300050306     **
059400050306     D MsgKey          s              4a
059500050306
059600050306      /Free
059700050306
059800050306        SndPgmMsg( PxMsgId
059900050306                 : PxMsgF + '*LIBL'
060000050306                 : PxMsgDta
060100050306                 : %Len( PxMsgDta )
060200050306                 : '*ESCAPE'
060300050306                 : '*PGMBDY'
060400050306                 : 1
060500050306                 : MsgKey
060600050306                 : ERRC0100
060700050306                 );
060800050306
060900050306        If  ERRC0100.BytAvl > *Zero;
061000050306          Return  -1;
061100050306
061200050306        Else;
061300050306          Return   0;
061400050306        EndIf;
061500050306
061600050306      /End-Free
061700050306
061800050306     P SndEscMsg       E
061900050306     **-- Send completion message:  ------------------------------------------**
062000050306     P SndCmpMsg       B
062100050306     D                 Pi            10i 0
062200050306     D  PxMsgDta                    512a   Const  Varying
062300050306     **
062400050306     D MsgKey          s              4a
062500050306
062600050306      /Free
062700050306
062800050306        SndPgmMsg( 'CPF9897'
062900050306                 : 'QCPFMSG   *LIBL'
063000050306                 : PxMsgDta
063100050306                 : %Len( PxMsgDta )
063200050306                 : '*COMP'
063300050306                 : '*PGMBDY'
063400050306                 : 1
063500050306                 : MsgKey
063600050306                 : ERRC0100
063700050306                 );
063800050306
063900050306        If  ERRC0100.BytAvl > *Zero;
064000050306          Return  -1;
064100050306
064200050306        Else;
064300050306          Return  0;
064400050306
064500050306        EndIf;
064600050306
064700050306      /End-Free
064800050306
064900050306     **
065000050306     P SndCmpMsg       E
