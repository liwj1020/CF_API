000100041212     **
000200070710     **  Program . . : CBX9562
000300070710     **  Description : List user's objects
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **
000800050304     **  Compile instructions:
000900070710     **    CrtRpgMod   Module( CBX9562 )
001000050304     **                DbgView( *LIST )
001100041212     **
001200070710     **    CrtPgm      Pgm( CBX9562 )
001300070710     **                Module( CBX9562 )
001400041212     **                ActGrp( *NEW )
001500041212     **
001600041212     **
001700041212     **-- Control specification:  --------------------------------------------**
001800070710     H Option( *SrcStmt )
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
003800051113     **-- Entry format OBJA0100:
003900051113     D OBJA0100        Ds                  Qualified  Based( pLstEnt )
004000050801     D  ObjNam                       10a
004100050801     D  ObjLib                       10a
004200050801     D  ObjTyp                       10a
004300050801     D  AutHlr                        1a
004400050801     D  ObjOwn                        1a
004500050801     D  AspDevLib                    10a
004600050801     D  AspDevObj                    10a
004700051113     **-- Entry format OBJA0110:
004800051113     D OBJA0110        Ds          5120    Qualified  Based( pLstEnt )
004900051113     D  OfsPthNam                    10i 0
005000051113     D  LenPthNam                    10i 0
005100051113     D  ObjTyp                       10a
005200051113     D  AutHlr                        1a
005300051113     D  ObjOwn                        1a
005400051113     D  AspDevNam                    10a
005500051113     **
005600051113     D Path            Ds                  Qualified  Based( pPath )
005700051113     D  PthCcsId                     10i 0
005800051113     D  CtrRegId                      2a
005900051113     D  LngId                         3a
006000051113     D                                3a
006100051113     D  FlgByt                       10i 0
006200051113     D  PthNamLen                    10i 0
006300051113     D  PthDlm                        2a
006400051113     D                               10a
006500051113     D  PthNam                     5000a
006600051113     **
006700051113     D PthNam          s           5000a   Varying
006800050801     **-- API input parameter information:
006900050801     D InpPrm          Ds                  Qualified  Based( pInpPrm )
007000050801     D  UsrSpc                       10a
007100050801     D  UsrSpcLib                    10a
007200050801     D  FmtNam                        8a
007300050801     D  UsrPrf                       10a
007400050801     D  ObjTyp                       10a
007500050801     D  RtnObj                       10a
007600050801     D  CntHdl                       20a
007700050801     D  OfsRqsLst                    10i 0
007800050801     D  NbrLstEnt                    10i 0
007900050801     D  RqsLst                       30a
008000050801     **-- API header information:
008100050801     D HdrInf          Ds                  Qualified  Based( pHdrInf )
008200050801     D  UsrPrf                       10a
008300050801     D  CntHdl                       20a
008400050801     D  RsnCod                       10i 0
008500050303     **-- User space generic header:
008600050303     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
008700051113     D  HdrSiz                       10i 0 Overlay( UsrSpc:  65 )
008800051113     D  RelLvl                        4a   Overlay( UsrSpc:  69 )
008900051113     D  FmtNam                        8a   Overlay( UsrSpc:  73 )
009000051113     D  ApiNam                       10a   Overlay( UsrSpc:  81 )
009100051113     D  CrtDtm                       13a   Overlay( UsrSpc:  91 )
009200051113     D  InfSts                        1a   Overlay( UsrSpc: 104 )
009300051113     D  UsrSpcSiz                    10i 0 Overlay( UsrSpc: 105 )
009400050801     D  OfsInp                       10i 0 Overlay( UsrSpc: 109 )
009500051113     D  SizInp                       10i 0 Overlay( UsrSpc: 113 )
009600050303     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
009700051113     D  SizHdr                       10i 0 Overlay( UsrSpc: 121 )
009800050303     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
009900051113     D  SizLst                       10i 0 Overlay( UsrSpc: 129 )
010000050303     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
010100050303     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
010200051113     D  LstCcsId                     10i 0 Overlay( UsrSpc: 141 )
010300051113     D  CtrRegId                      2a   Overlay( UsrSpc: 145 )
010400051113     D  LngId                         3a   Overlay( UsrSpc: 147 )
010500051113     D  SubSetInd                     1a   Overlay( UsrSpc: 149 )
010600050303     **-- Space pointers:
010700050303     D pUsrSpc         s               *   Inz( *Null )
010800050801     D pInpPrm         s               *   Inz( *Null )
010900050801     D pHdrInf         s               *   Inz( *Null )
011000050303     D pLstEnt         s               *   Inz( *Null )
011100050801
011200070710     **-- List user objects:
011300050801     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
011400070710     D  SpcNamQ                      20a   Const
011500070710     D  FmtNam                        8a   Const
011600070710     D  UsrPrf                       10a   Const
011700070710     D  ObjTyp                       10a   Const
011800070710     D  RtnObj                       10a   Const
011900070710     D  CntHdl                       20a   Const
012000070710     D  Error                     32767a          Options( *VarSize )
012100070710     D  RqsLst                       30a          Options( *VarSize: *NoPass )
012200050303     **-- Create user space:
012300050303     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
012400070710     D  SpcNamQ                      20a   Const
012500070710     D  ExtAtr                       10a   Const
012600070710     D  InzSiz                       10i 0 Const
012700070710     D  InzVal                        1a   Const
012800070710     D  PubAut                       10a   Const
012900070710     D  Text                         50a   Const
013000070710     D  Replace                      10a   Const  Options( *NoPass )
013100070710     D  Error                     32767a          Options( *NoPass: *VarSize )
013200070710     D  Domain                       10a   Const  Options( *NoPass )
013300070710     D  TfrSizRqs                    10i 0 Const  Options( *NoPass )
013400070710     D  OptSpcAlg                     1a   Const  Options( *NoPass )
013500050303     **-- Retrieve pointer to user space:
013600050303     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
013700070710     D  SpcNamQ                      20a   Const
013800070710     D  Pointer                        *
013900070710     D  Error                     32767a          Options( *NoPass: *VarSize )
014000050303     **-- Delete user space:
014100050303     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
014200070710     D  SpcNamQ                      20a   Const
014300070710     D  Error                     32767a          Options( *VarSize )
014400050306     **-- Send program message:
014500050306     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
014600070710     D  MsgId                         7a   Const
014700070710     D  MsgFq                        20a   Const
014800070710     D  MsgDta                      128a   Const
014900070710     D  MsgDtaLen                    10i 0 Const
015000070710     D  MsgTyp                       10a   Const
015100070710     D  CalStkE                      10a   Const  Options( *VarSize )
015200070710     D  CalStkCtr                    10i 0 Const
015300070710     D  MsgKey                        4a
015400070710     D  Error                      1024a          Options( *VarSize )
015500041212
015600050306     **-- Send escape message:
015700050306     D SndEscMsg       Pr            10i 0
015800050306     D  PxMsgId                       7a   Const
015900050306     D  PxMsgF                       10a   Const
016000050306     D  PxMsgDta                    512a   Const  Varying
016100050306     **-- Send completion message:
016200050306     D SndCmpMsg       Pr            10i 0
016300050306     D  PxMsgDta                    512a   Const  Varying
016400050303
016500070710     D CBX9562         Pr
016600050407     D  PxUsrPrf                     10a
016700041212     **
016800070710     D CBX9562         Pi
016900050407     D  PxUsrPrf                     10a
017000041211
017100041211      /Free
017200050306
017300050801        CrtUsrSpc( USR_SPC_Q
017400050801                 : *Blanks
017500050801                 : 65535
017600050801                 : x'00'
017700050801                 : '*CHANGE'
017800050801                 : *Blanks
017900050801                 : '*YES'
018000050801                 : ERRC0100
018100050801                 );
018200050801
018300050801        RtvPtrSpc( USR_SPC_Q: pUsrSpc );
018400050801
018500050801        DoU  CntHdl = *Blanks;
018600050801
018700050801          LstUsrObj( USR_SPC_Q
018800051113                   : 'OBJA0100'
018900050801                   : PxUsrPrf
019000051113                   : '*ALL'
019100051113                   : '*OBJOWN'
019200050801                   : CntHdl
019300050801                   : ERRC0100
019400050801                   );
019500050801
019600050801          If  ERRC0100.BytAvl > *Zero;
019700050801
019800050801            Leave;
019900050801          Else;
020000050801
020100050801            ExSr  GetUsrObj;
020200050801          EndIf;
020300050801        EndDo;
020400050801
020500051113        DoU  CntHdl = *Blanks;
020600051113
020700051113          LstUsrObj( USR_SPC_Q
020800051113                   : 'OBJA0110'
020900051113                   : PxUsrPrf
021000051113                   : '*ALL'
021100051113                   : '*OBJOWN'
021200051113                   : CntHdl
021300051113                   : ERRC0100
021400051113                   );
021500051113
021600051113          If  ERRC0100.BytAvl > *Zero;
021700051113
021800051113            Leave;
021900051113          Else;
022000051113
022100051113            ExSr  GetUsrFil;
022200051113          EndIf;
022300051113        EndDo;
022400051113
022500050801        DltUsrSpc( USR_SPC_Q: ERRC0100 );
022600050122
022700050801        If  ERRC0100.BytAvl > *Zero;
022800050801
022900050801          If  ERRC0100.BytAvl < OFS_MSGDTA;
023000050801            ERRC0100.BytAvl = OFS_MSGDTA;
023100050801          EndIf;
023200050801
023300050801          SndEscMsg( ERRC0100.MsgId
023400050801                   : 'QCPFMSG'
023500050801                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
023600050801                   );
023700050801        Else;
023800050801
023900050801          SndCmpMsg( 'Command completed normally.' );
024000050801        EndIf;
024100050306
024200041211        *InLr = *On;
024300041211        Return;
024400041211
024500050303
024600050801        BegSr  GetUsrObj;
024700050303
024800050801          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
024900050303          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
025000050303          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
025100050303
025200050304          For  Idx = 1  To  UsrSpc.NumLstEnt;
025300050303
025400050303
025500050303            If  Idx < UsrSpc.NumLstEnt;
025600051113              pLstEnt += UsrSpc.SizLstEnt;
025700050303            EndIf;
025800050303          EndFor;
025900050801
026000051113          CntHdl = HdrInf.CntHdl;
026100050303
026200050303        EndSr;
026300050304
026400051113        BegSr  GetUsrFil;
026500051113
026600051113          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
026700051113          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
026800051113          pLstEnt = pUsrSpc + UsrSpc.OfsLst;
026900051113
027000051113          For  Idx = 1  To  UsrSpc.NumLstEnt;
027100051113
027200051113            pPath = pUsrSpc + OBJA0110.OfsPthNam;
027300051113            PthNam = %Subst( Path.PthNam: 1: Path.PthNamLen );
027400051113
027500051113            If  Idx < UsrSpc.NumLstEnt;
027600051113              pLstEnt += UsrSpc.SizLstEnt + OBJA0110.LenPthNam;
027700051113            EndIf;
027800051113          EndFor;
027900051113
028000051113          CntHdl = HdrInf.CntHdl;
028100051113
028200051113        EndSr;
028300051113
028400050303      /End-Free
028500050303
028600070710     **-- Send escape message:
028700050306     P SndEscMsg       B
028800050306     D                 Pi            10i 0
028900050306     D  PxMsgId                       7a   Const
029000050306     D  PxMsgF                       10a   Const
029100050306     D  PxMsgDta                    512a   Const  Varying
029200050306     **
029300050306     D MsgKey          s              4a
029400050306
029500050306      /Free
029600050306
029700050306        SndPgmMsg( PxMsgId
029800050306                 : PxMsgF + '*LIBL'
029900050306                 : PxMsgDta
030000050306                 : %Len( PxMsgDta )
030100050306                 : '*ESCAPE'
030200050306                 : '*PGMBDY'
030300050306                 : 1
030400050306                 : MsgKey
030500050306                 : ERRC0100
030600050306                 );
030700050306
030800050306        If  ERRC0100.BytAvl > *Zero;
030900050306          Return  -1;
031000050306
031100050306        Else;
031200050306          Return   0;
031300050306        EndIf;
031400050306
031500050306      /End-Free
031600050306
031700050306     P SndEscMsg       E
031800070710     **-- Send completion message:
031900050306     P SndCmpMsg       B
032000050306     D                 Pi            10i 0
032100050306     D  PxMsgDta                    512a   Const  Varying
032200050306     **
032300050306     D MsgKey          s              4a
032400050306
032500050306      /Free
032600050306
032700050306        SndPgmMsg( 'CPF9897'
032800050306                 : 'QCPFMSG   *LIBL'
032900050306                 : PxMsgDta
033000050306                 : %Len( PxMsgDta )
033100050306                 : '*COMP'
033200050306                 : '*PGMBDY'
033300050306                 : 1
033400050306                 : MsgKey
033500050306                 : ERRC0100
033600050306                 );
033700050306
033800050306        If  ERRC0100.BytAvl > *Zero;
033900050306          Return  -1;
034000050306
034100050306        Else;
034200050306          Return  0;
034300050306
034400050306        EndIf;
034500050306
034600050306      /End-Free
034700050306
034800050306     P SndCmpMsg       E
