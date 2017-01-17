000100041212     **
000200050801     **  Program . . : CBX951
000300050801     **  Description : List user's authorization list entries
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **
000800050304     **  Compile instructions:
000900050801     **    CrtRpgMod   Module( CBX951 )
001000050304     **                DbgView( *LIST )
001100041212     **
001200050801     **    CrtPgm      Pgm( CBX951 )
001300050801     **                Module( CBX951 )
001400041212     **                ActGrp( *NEW )
001500041212     **
001600041212     **
001700041212     **-- Control specification:  --------------------------------------------**
001800041212     H Option( *SrcStmt: *NoDebugIo )
001900050801
002000050303     **-- System information:
002100050303     D PgmSts         sDs                  Qualified
002200050303     D  JobUsr                       10a   Overlay( PgmSts: 254 )
002300050303     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002400041211     **-- API error data structure:
002500041211     D ERRC0100        Ds                  Qualified
002600041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002700041211     D  BytAvl                       10i 0
002800041211     D  MsgId                         7a
002900990921     D                                1a
003000041211     D  MsgDta                      128a
003100050212     **-- Global constants:
003200050801     D USR_SPC_Q       c                   'AUTOBJLST QTEMP'
003300050306     D OFS_MSGDTA      c                   16
003400041212     **-- Global variables:
003500041211     D Idx             s             10i 0
003600050801     D CntHdl          s             20a   Inz
003700050801
003800050801     **-- Entry format OBJA0200:
003900050801     D OBJA0200        Ds                  Qualified  Based( pLstEnt )
004000050801     D  ObjNam                       10a
004100050801     D  ObjLib                       10a
004200050801     D  ObjTyp                       10a
004300050801     D  AutHlr                        1a
004400050801     D  ObjOwn                        1a
004500050801     D  AutVal                       10a
004600050801     D  AutlMgt                       1a
004700050801     D  ObjOpr                        1a
004800050801     D  ObjMgt                        1a
004900050303     D  ObjExs                        1a
005000050303     D  DtaRead                       1a
005100050303     D  DtaAdd                        1a
005200050303     D  DtaUpd                        1a
005300050303     D  DtaDlt                        1a
005400050303     D  DtaExe                        1a
005500050303     D                               10a
005600050303     D  ObjAlt                        1a
005700050303     D  ObjRef                        1a
005800050801     D  AspDevLib                    10a
005900050801     D  AspDevObj                    10a
006000051113     **-- Entry format OBJA0210:
006100051113     D OBJA0210        Ds          5120    Qualified  Based( pLstEnt )
006200051113     D  OfsPthNam                    10i 0
006300051113     D  LenPthNam                    10i 0
006400051113     D  ObjTyp                       10a
006500051113     D  AutHlr                        1a
006600051113     D  ObjOwn                        1a
006700051113     D  AutVal                       10a
006800051113     D  AutlMgt                       1a
006900051113     D  ObjOpr                        1a
007000051113     D  ObjMgt                        1a
007100051113     D  ObjExs                        1a
007200051113     D  ObjAlt                        1a
007300051113     D  ObjRef                        1a
007400051113     D                               10a
007500051113     D  DtaRead                       1a
007600051113     D  DtaAdd                        1a
007700051113     D  DtaUpd                        1a
007800051113     D  DtaDlt                        1a
007900051113     D  DtaExe                        1a
008000051113     D  AspDevNam                    10a
008100051113     **
008200051113     D Path            Ds                  Qualified  Based( pPath )
008300051113     D  PthCcsId                     10i 0
008400051113     D  CtrRegId                      2a
008500051113     D  LngId                         3a
008600051113     D                                3a
008700051113     D  FlgByt                       10i 0
008800051113     D  PthNamLen                    10i 0
008900051113     D  PthDlm                        2a
009000051113     D                               10a
009100051113     D  PthNam                     5000a
009200051113     **
009300051113     D PthNam          s           5000a   Varying
009400050801     **-- API input parameter information:
009500050801     D InpPrm          Ds                  Qualified  Based( pInpPrm )
009600050801     D  UsrSpc                       10a
009700050801     D  UsrSpcLib                    10a
009800050801     D  FmtNam                        8a
009900050801     D  UsrPrf                       10a
010000050801     D  ObjTyp                       10a
010100050801     D  RtnObj                       10a
010200050801     D  CntHdl                       20a
010300050801     D  OfsRqsLst                    10i 0
010400050801     D  NbrLstEnt                    10i 0
010500050801     D  RqsLst                       30a
010600050801     **-- API header information:
010700050801     D HdrInf          Ds                  Qualified  Based( pHdrInf )
010800050801     D  UsrPrf                       10a
010900050801     D  CntHdl                       20a
011000050801     D  RsnCod                       10i 0
011100050303     **-- User space generic header:
011200050303     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
011300051113     D  HdrSiz                       10i 0 Overlay( UsrSpc:  65 )
011400051113     D  RelLvl                        4a   Overlay( UsrSpc:  69 )
011500051113     D  FmtNam                        8a   Overlay( UsrSpc:  73 )
011600051113     D  ApiNam                       10a   Overlay( UsrSpc:  81 )
011700051113     D  CrtDtm                       13a   Overlay( UsrSpc:  91 )
011800051113     D  InfSts                        1a   Overlay( UsrSpc: 104 )
011900051113     D  UsrSpcSiz                    10i 0 Overlay( UsrSpc: 105 )
012000050801     D  OfsInp                       10i 0 Overlay( UsrSpc: 109 )
012100051113     D  SizInp                       10i 0 Overlay( UsrSpc: 113 )
012200050303     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
012300051113     D  SizHdr                       10i 0 Overlay( UsrSpc: 121 )
012400050303     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
012500051113     D  SizLst                       10i 0 Overlay( UsrSpc: 129 )
012600050303     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
012700050303     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
012800051113     D  LstCcsId                     10i 0 Overlay( UsrSpc: 141 )
012900051113     D  CtrRegId                      2a   Overlay( UsrSpc: 145 )
013000051113     D  LngId                         3a   Overlay( UsrSpc: 147 )
013100051113     D  SubSetInd                     1a   Overlay( UsrSpc: 149 )
013200050303     **-- Space pointers:
013300050303     D pUsrSpc         s               *   Inz( *Null )
013400050801     D pInpPrm         s               *   Inz( *Null )
013500050801     D pHdrInf         s               *   Inz( *Null )
013600050303     D pLstEnt         s               *   Inz( *Null )
013700050801
013800050303     **-- List authorized users:
013900050801     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
014000050801     D  LuSpcNamQ                    20a   Const
014100050801     D  LuFmtNam                      8a   Const
014200050801     D  LuUsrPrf                     10a   Const
014300050801     D  LuObjTyp                     10a   Const
014400050801     D  LuRtnObj                     10a   Const
014500050801     D  LuCntHdl                     20a   Const
014600050801     D  LuError                   32767a          Options( *VarSize )
014700050801     D  LuRqsLst                     30a          Options( *VarSize: *NoPass )
014800050303     **-- Create user space:
014900050303     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
015000050303     D  CsSpcNamQ                    20a   Const
015100050303     D  CsExtAtr                     10a   Const
015200050303     D  CsInzSiz                     10i 0 Const
015300050303     D  CsInzVal                      1a   Const
015400050303     D  CsPubAut                     10a   Const
015500050303     D  CsText                       50a   Const
015600050303     D  CsReplace                    10a   Const  Options( *NoPass )
015700050303     D  CsError                   32767a          Options( *NoPass: *VarSize )
015800050303     D  CsDomain                     10a   Const  Options( *NoPass )
015900050303     D  CsTfrSizRqs                  10i 0 Const  Options( *NoPass )
016000050303     D  CsOptSpcAlg                   1a   Const  Options( *NoPass )
016100050303     **-- Retrieve pointer to user space:
016200050303     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
016300050303     D  RpSpcNamQ                    20a   Const
016400050303     D  RpPointer                      *
016500050303     D  RpError                   32767a          Options( *NoPass: *VarSize )
016600050303     **-- Delete user space:
016700050303     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
016800050303     D  DsSpcNamQ                    20a   Const
016900050303     D  DsError                   32767a          Options( *VarSize )
017000050306     **-- Send program message:
017100050306     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
017200050306     D  SpMsgId                       7a   Const
017300050306     D  SpMsgFq                      20a   Const
017400050306     D  SpMsgDta                    128a   Const
017500050306     D  SpMsgDtaLen                  10i 0 Const
017600050306     D  SpMsgTyp                     10a   Const
017700050306     D  SpCalStkE                    10a   Const  Options( *VarSize )
017800050306     D  SpCalStkCtr                  10i 0 Const
017900050306     D  SpMsgKey                      4a
018000050306     D  SpError                    1024a          Options( *VarSize )
018100041212
018200050306     **-- Send escape message:
018300050306     D SndEscMsg       Pr            10i 0
018400050306     D  PxMsgId                       7a   Const
018500050306     D  PxMsgF                       10a   Const
018600050306     D  PxMsgDta                    512a   Const  Varying
018700050306     **-- Send completion message:
018800050306     D SndCmpMsg       Pr            10i 0
018900050306     D  PxMsgDta                    512a   Const  Varying
019000050303
019100051113     D CBX9512         Pr
019200050407     D  PxUsrPrf                     10a
019300041212     **
019400051113     D CBX9512         Pi
019500050407     D  PxUsrPrf                     10a
019600041211
019700041211      /Free
019800050306
019900050801        CrtUsrSpc( USR_SPC_Q
020000050801                 : *Blanks
020100050801                 : 65535
020200050801                 : x'00'
020300050801                 : '*CHANGE'
020400050801                 : *Blanks
020500050801                 : '*YES'
020600050801                 : ERRC0100
020700050801                 );
020800050801
020900050801        RtvPtrSpc( USR_SPC_Q: pUsrSpc );
021000050801
021100050801        DoU  CntHdl = *Blanks;
021200050801
021300050801          LstUsrObj( USR_SPC_Q
021400051113                   : 'OBJA0210'
021500050801                   : PxUsrPrf
021600051113                   : '*ALL'
021700051113                   : '*OBJOWN'
021800050801                   : CntHdl
021900050801                   : ERRC0100
022000050801                   );
022100050801
022200050801          If  ERRC0100.BytAvl > *Zero;
022300050801
022400050801            Leave;
022500050801          Else;
022600050801
022700050801            ExSr  GetUsrObj;
022800050801          EndIf;
022900050801        EndDo;
023000050801
023100050801        DltUsrSpc( USR_SPC_Q: ERRC0100 );
023200050122
023300050801        If  ERRC0100.BytAvl > *Zero;
023400050801
023500050801          If  ERRC0100.BytAvl < OFS_MSGDTA;
023600050801            ERRC0100.BytAvl = OFS_MSGDTA;
023700050801          EndIf;
023800050801
023900050801          SndEscMsg( ERRC0100.MsgId
024000050801                   : 'QCPFMSG'
024100050801                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
024200050801                   );
024300050801        Else;
024400050801
024500050801          SndCmpMsg( 'Command completed normally.' );
024600050801        EndIf;
024700050306
024800041211        *InLr = *On;
024900041211        Return;
025000041211
025100050303
025200050801        BegSr  GetUsrObj;
025300050303
025400050801          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
025500050303          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
025600050303          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
025700050303
025800050304          For  Idx = 1  To  UsrSpc.NumLstEnt;
025900050303
026000051113            pPath = pUsrSpc + OBJA0210.OfsPthNam;
026100051113            PthNam = %Subst( Path.PthNam: 1: Path.PthNamLen );
026200050303
026300050303            If  Idx < UsrSpc.NumLstEnt;
026400051113              pLstEnt += UsrSpc.SizLstEnt + OBJA0210.LenPthNam;
026500050303            EndIf;
026600050303          EndFor;
026700050801
026800050801          CntHdl = InpPrm.CntHdl;
026900050303
027000050303        EndSr;
027100050304
027200050303      /End-Free
027300050303
027400050306     **-- Send escape message:  ----------------------------------------------**
027500050306     P SndEscMsg       B
027600050306     D                 Pi            10i 0
027700050306     D  PxMsgId                       7a   Const
027800050306     D  PxMsgF                       10a   Const
027900050306     D  PxMsgDta                    512a   Const  Varying
028000050306     **
028100050306     D MsgKey          s              4a
028200050306
028300050306      /Free
028400050306
028500050306        SndPgmMsg( PxMsgId
028600050306                 : PxMsgF + '*LIBL'
028700050306                 : PxMsgDta
028800050306                 : %Len( PxMsgDta )
028900050306                 : '*ESCAPE'
029000050306                 : '*PGMBDY'
029100050306                 : 1
029200050306                 : MsgKey
029300050306                 : ERRC0100
029400050306                 );
029500050306
029600050306        If  ERRC0100.BytAvl > *Zero;
029700050306          Return  -1;
029800050306
029900050306        Else;
030000050306          Return   0;
030100050306        EndIf;
030200050306
030300050306      /End-Free
030400050306
030500050306     P SndEscMsg       E
030600050306     **-- Send completion message:  ------------------------------------------**
030700050306     P SndCmpMsg       B
030800050306     D                 Pi            10i 0
030900050306     D  PxMsgDta                    512a   Const  Varying
031000050306     **
031100050306     D MsgKey          s              4a
031200050306
031300050306      /Free
031400050306
031500050306        SndPgmMsg( 'CPF9897'
031600050306                 : 'QCPFMSG   *LIBL'
031700050306                 : PxMsgDta
031800050306                 : %Len( PxMsgDta )
031900050306                 : '*COMP'
032000050306                 : '*PGMBDY'
032100050306                 : 1
032200050306                 : MsgKey
032300050306                 : ERRC0100
032400050306                 );
032500050306
032600050306        If  ERRC0100.BytAvl > *Zero;
032700050306          Return  -1;
032800050306
032900050306        Else;
033000050306          Return  0;
033100050306
033200050306        EndIf;
033300050306
033400050306      /End-Free
033500050306
033600050306     **
033700050306     P SndCmpMsg       E
