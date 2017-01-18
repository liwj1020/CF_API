000100041212     **
000200051112     **  Program . . : CBX949
000300051112     **  Description : Print registered exit programs - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Compile and setup instructions:
000800051112     **    CrtRpgMod   Module( CBX949 )
000900050318     **                DbgView( *LIST )
001000041212     **
001100051112     **    CrtPgm      Pgm( CBX949 )
001200051112     **                Module( CBX949 )
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
003100051121     D  NbrLin                        5i 0 Overlay( PrtLinInf: 152 )
003200050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
003300050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
003400050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
003500051023
003600041211     **-- API error data structure:
003700041211     D ERRC0100        Ds                  Qualified
003800041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003900041211     D  BytAvl                       10i 0
004000041211     D  MsgId                         7a
004100990921     D                                1a
004200041211     D  MsgDta                      128a
004300051111
004400051111     **-- Global constants:
004500051119     D NULL            c                   ''
004600051111     D ALL_EXIT_FMT    c                   '*ALL'
004700051111     D ALL_EXIT_PGM    c                   -1
004800041212     **-- Global variables:
004900051029     D Idx             s             10i 0 Inz
005000051111     D PgmIdx          s             10i 0 Inz
005100110922     D PgmTyp          s             10a   Varying
005200110922     D SltAll          s               n   Inz( *Off )
005300110922     D ExcIbm          s               n   Inz( *Off )
005400110922     D ExcCmd          s               n   Inz( *Off )
005500110922     D ExcPgm          s               n   Inz( *Off )
005600110922     D ExcFnc          s               n   Inz( *Off )
005700110922     D ExcCer          s               n   Inz( *Off )
005800110922     D ExcDom          s               n   Inz( *Off )
005900041212     D LstTim          s              6s 0
006000050319     D SysNam          s              8a
006100050415     D TrlTxt          s             32a
006200050122     **-- List record:
006300050122     D LstRcd          Ds                  Qualified
006400051112     D  ExtPnt                       20a
006500051112     D  FmtNam                        8a
006600051120     D  MaxNbEp                      10a
006700051120     D  CurNbEp                      10a
006800051112     D  AlwDeRg                       4a
006900051112     D  AlwChEp                       4a
007000051112     D  RegExPg                       4a
007100051112     D  ExtPtDs                      50a
007200051112     **-- Program record:
007300051112     D PgmRcd          Ds                  Qualified
007400051112     D  ExtPgNb                      10i 0
007500051112     D  ExtPgNm                      10a
007600051112     D  ExtPgLb                      10a
007700051112     D  ExtPgDt                      20a
007800051112     D  PgmOwn                       10a
007900051112     D  PgmCrt                       10a
008000051112     D  PgmSys                       10a
008100051119     D  PgmCrDt                       8a
008200051119     D  PgmChDt                       8a
008300051119     D  PgmRsDt                       8a
008400051112
008500051111     **-- Exit program selection:
008600051111     D ExtPgmSlt       Ds                  Qualified
008700051111     D  NbrSltCri                    10i 0
008800051112     D  ExtPgmSltEnt                       Dim( 1 )
008900051111     D   SizCriEnt                   10i 0 Overlay( ExtPgmSltEnt: 1 )
009000051111     D   CmpOpr                      10i 0 Overlay( ExtPgmSltEnt: *Next )
009100051111     D   StrPosDta                   10i 0 Overlay( ExtPgmSltEnt: *Next )
009200051111     D   LenCmpDta                   10i 0 Overlay( ExtPgmSltEnt: *Next )
009300051111     D   CmpDta                     256a   Overlay( ExtPgmSltEnt: *Next )
009400051111     **-- Exit point information:
009500051111     D EXTI0100        Ds         65535    Qualified
009600050507     D  BytRtn                       10i 0
009700050507     D  BytAvl                       10i 0
009800051111     D  CntHdl                       16a   Inz
009900051111     D  OfsLstEnt                    10i 0
010000051111     D  NbrLstEnt                    10i 0
010100051111     D  LenLstEnt                    10i 0
010200051023
010300051111     D ExtPntEnt       Ds                  Qualified  Based( pExtPntEnt )
010400051111     D  ExtPntNam                    20a
010500051111     D  ExtPntFmtNam                  8a
010600051111     D  MaxNbrExtPgm                 10i 0
010700051111     D  CurNbrExtPgm                 10i 0
010800051111     D  AlwDeReg                      1a
010900051111     D  AlwChgEpCtl                   1a
011000051111     D  RegExtPnt                     1a
011100051111     D  PpEpNamAdd                   10a
011200051111     D  PpEpLibAdd                   10a
011300051111     D  PpEpFmtAdd                    8a
011400051111     D  PpEpNamRmv                   10a
011500051111     D  PpEpLibRmv                   10a
011600051111     D  PpEpFmtRmv                    8a
011700051111     D  PpEpNamRtv                   10a
011800051111     D  PpEpLibRtv                   10a
011900051111     D  PpEpFmtRtv                    8a
012000051111     D  ExtPntDscInd                  1a
012100051111     D  ExtPntDscMsgF                10a
012200051111     D  ExtPntDscLib                 10a
012300051111     D  ExtPntDscMsId                 7a
012400051111     D  ExtPntTxtDsc                 50a
012500051111
012600051111     **-- Exit program information:
012700051111     D EXTI0300        Ds         65535    Qualified
012800051111     D  BytRtn                       10i 0
012900051111     D  BytAvl                       10i 0
013000051111     D  CntHdl                       16a   Inz
013100051111     D  OfsLstEnt                    10i 0
013200051111     D  NbrLstEnt                    10i 0
013300051111     D  LenLstEnt                    10i 0
013400051111
013500051111     D ExtPgmEnt       Ds          1024    Qualified  Based( pExtPgmEnt )
013600051111     D  OfsNxtEnt                    10i 0
013700051111     D  ExtPntNam                    20a
013800051111     D  ExtPntFmtNam                  8a
013900051111     D  RegExtPnt                     1a
014000051111     D  CmpEnt                        1a
014100051111     D                                2a
014200051111     D  ExtPgmNbr                    10i 0
014300051111     D  ExtPgmNam                    10a
014400051111     D  ExtPgmLib                    10a
014500051111     D  ExtPgmDscInd                  1a
014600051111     D  EpDscMsgF                    10a
014700051111     D  EpDscLib                     10a
014800051111     D  EpDscMsgId                    7a
014900051111     D  EpDscTxt                     50a
015000051111     D                                2a
015100051111     D  EpDtaCcsId                   10i 0
015200051111     D  OfsExtPgmDta                 10i 0
015300051111     D  LenExtPgmDta                 10i 0
015400051111     D  ThdSafe                       1a
015500051111     D  MltThdJobAcn                  1a
015600051111     D                                1a
015700051111     **
015800051119     D ExtPgmDta       s            256a   Varying
015900051111
016000051111     **-- Retrieve exit information:
016100051111     D RtvExitInf      Pr                  ExtProc( 'QusRetrieveExit-
016200051111     D                                     Information')
016300051111     D  CntHdl                       16a
016400051023     D  RcvVar                    65535a          Options( *VarSize )
016500051023     D  RcvVarLen                    10i 0 Const
016600051023     D  FmtNam                        8a   Const
016700051111     D  ExtPntNam                    20a   Const
016800051111     D  ExtPntFmtNam                  8a   Const
016900051111     D  ExtPgmNbr                    10i 0 Const
017000051111     D  ExtPgmSltCri               1024a          Options( *VarSize )
017100051023     D  Error                      1024a          Options( *VarSize )
017200050319     **-- Send program message:
017300050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
017400051023     D  MsgId                         7a   Const
017500051023     D  MsgFq                        20a   Const
017600051023     D  MsgDta                      128a   Const
017700051023     D  MsgDtaLen                    10i 0 Const
017800051023     D  MsgTyp                       10a   Const
017900051023     D  CalStkE                      10a   Const  Options( *VarSize )
018000051023     D  CalStkCtr                    10i 0 Const
018100051023     D  MsgKey                        4a
018200051023     D  Error                     32767a          Options( *VarSize )
018300051101     **-- Send message:
018400051101     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
018500051101     D  MsgId                         7a   Const
018600051101     D  MsgFq                        20a   Const
018700051101     D  MsgDta                      512a   Const  Options( *VarSize )
018800051101     D  MsgDtaLen                    10i 0 Const
018900051101     D  MsgTyp                       10a   Const
019000051101     D  MsgQq                      1000a   Const  Options( *VarSize )
019100051101     D  MsgQnbr                      10i 0 Const
019200051101     D  MsgQrpy                      20a   Const
019300051101     D  MsgKey                        4a
019400051101     D  Error                     32767a          Options( *VarSize )
019500051101     D  CcsId                        10i 0 Const  Options( *NoPass )
019600050319     **-- Retrieve net attribute:
019700050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
019800051023     D  RcvVar                    32767a          Options( *VarSize )
019900051023     D  RcvVarLen                    10i 0 Const
020000051023     D  NbrNetAtr                    10i 0 Const
020100051023     D  NetAtr                       10a   Const  Dim( 256 )
020200050319     D                                            Options( *VarSize )
020300051023     D  Error                     32767a          Options( *VarSize )
020400050506     **-- Retrieve object description:
020500050506     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
020600051023     D  RcvVar                    32767a         Options( *VarSize )
020700051023     D  RcvVarLen                    10i 0 Const
020800051023     D  FmtNam                        8a   Const
020900051023     D  ObjNamQ                      20a   Const
021000051023     D  ObjTyp                       10a   Const
021100051023     D  Error                     32767a         Options( *VarSize )
021200051112     **-- Retrieve message:
021300051112     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
021400051112     D  RcvVar                    32767a          Options( *VarSize )
021500051112     D  RcvVarLen                    10i 0 Const
021600051112     D  FmtNam                       10a   Const
021700051112     D  MsgId                         7a   Const
021800051112     D  MsgFq                        20a   Const
021900051112     D  MsgDta                      512a   Const  Options( *VarSize )
022000051112     D  MsgDtaLen                    10i 0 Const
022100051112     D  RplSubVal                    10a   Const
022200051112     D  RtnFmtChr                    10a   Const
022300051112     D  Error                     32767a          Options( *VarSize )
022400051112     **
022500051112     D  RtvOpt                       10a   Const  Options( *NoPass )
022600051112     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
022700051112     D  RplCcsId                     10i 0 Const  Options( *NoPass )
022800041212
022900050319     **-- Get system name:
023000050319     D GetSysNam       Pr             8a   Varying
023100110922     **-- Get program type:
023200110922     D GetPgmTyp       Pr            10a
023300110922     D  PxObjNam                     10a   Value
023400110922     D  PxObjLib                     10a   Value
023500051119     **-- Get object owner:
023600051119     D GetObjOwn       Pr            10a
023700051119     D  PxObjNam                     10a   Value
023800051119     D  PxObjLib                     10a   Value
023900051119     D  PxObjTyp                     10a   Value
024000051119     **-- Get object creator:
024100051119     D GetObjCrt       Pr            10a
024200051119     D  PxObjNam                     10a   Value
024300051119     D  PxObjLib                     10a   Value
024400051119     D  PxObjTyp                     10a   Value
024500051119     **-- Get object system:
024600051119     D GetObjSys       Pr            10a
024700051119     D  PxObjNam                     10a   Value
024800051119     D  PxObjLib                     10a   Value
024900051119     D  PxObjTyp                     10a   Value
025000051119     **-- Get object creation date:
025100051119     D GetObjCrtDat    Pr             8a
025200051119     D  PxObjNam                     10a   Value
025300051119     D  PxObjLib                     10a   Value
025400051119     D  PxObjTyp                     10a   Value
025500051119     **-- Get object change date:
025600051119     D GetObjChgDat    Pr             8a
025700051119     D  PxObjNam                     10a   Value
025800051119     D  PxObjLib                     10a   Value
025900051119     D  PxObjTyp                     10a   Value
026000051119     **-- Get object restore date:
026100051119     D GetObjRstDat    Pr             8a
026200051119     D  PxObjNam                     10a   Value
026300051119     D  PxObjLib                     10a   Value
026400051119     D  PxObjTyp                     10a   Value
026500051112     **-- Retrieve message text:
026600051112     D RtvMsgTxt       Pr          1024a   Varying
026700051112     D  MsgId                         7a   Value
026800051112     D  MsgF                         10a   Value
026900051112     D  MsgFlib                      10a   Value
027000051112     D  MsgDta                     1024a   Const  Options( *NoPass )
027100051101     **-- Send user message:
027200051101     D SndUsrMsg       Pr            10i 0
027300051101     D  PxUsrPrf                     10a   Const
027400051101     D  PxMsgDta                    512a   Const  Varying
027500050507     **-- Send completion message:
027600050507     D SndCmpMsg       Pr            10i 0
027700050507     D  PxMsgDta                    512a   Const  Varying
027800051028
027900041216     **-- Write detail line:
028000041216     D WrtDtlLin       Pr
028100051112     **-- Write program line:
028200051112     D WrtPgmLin       Pr
028300050507     **-- Write list header:
028400050507     D WrtLstHdr       Pr
028500050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
028600051120     **-- Write program header:
028700051120     D WrtPgmHdr       Pr
028800051120     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
028900041216     **-- Write list trailer:
029000041216     D WrtLstTrl       Pr
029100050415     D  PxTrlTxt                     32a   Const
029200041212
029300050319     **-- Entry parameters:
029400110922     D ExcXpg          Ds                  Qualified
029500110922     D  NbrVal                        5i 0
029600110922     D  ExcVal                       10a   Dim( 5 )
029700110922     **
029800051111     D CBX949          Pr
029900051111     D  PxExtPnt                     20a
030000110922     D  PxExcXpg                           LikeDs( ExcXpg )
030100041212     **
030200051111     D CBX949          Pi
030300051111     D  PxExtPnt                     20a
030400110922     D  PxExcXpg                           LikeDs( ExcXpg )
030500041211
030600041211      /Free
030700041211
030800051111        ExtPgmSlt.NbrSltCri = *Zero;
030900050506
031000051111        DoU  EXTI0100.CntHdl = *Blanks;
031100051111
031200051111          RtvExitInf( EXTI0100.CntHdl
031300051111                    : EXTI0100
031400051111                    : %Size( EXTI0100 )
031500051111                    : 'EXTI0100'
031600051111                    : PxExtPnt
031700051111                    : ALL_EXIT_FMT
031800051111                    : ALL_EXIT_PGM
031900051111                    : ExtPgmSlt
032000051111                    : ERRC0100
032100051111                    );
032200051111
032300051111          If  ERRC0100.BytAvl = *Zero;
032400051111
032500051111            pExtPntEnt = %Addr( EXTI0100 ) + EXTI0100.OfsLstEnt;
032600051111
032700051111            For  Idx = 1  To  EXTI0100.NbrLstEnt;
032800051111
032900051112              If  ExtPntEnt.CurNbrExtPgm > *Zero;
033000051112
033100051112                ExSr  WrtExtPnt;
033200051112                ExSr  GetExtPgm;
033300051112              EndIf;
033400051111
033500051111              If  Idx < EXTI0100.NbrLstEnt;
033600051111                pExtPntEnt += EXTI0100.LenLstEnt;
033700051111              EndIf;
033800051111            EndFor;
033900051111          EndIf;
034000051111        EndDo;
034100050506
034200050506        WrtLstTrl( '***  E N D  O F  L I S T  ***' );
034300050415
034400050507        SndCmpMsg( 'List has been printed.' );
034500050507
034600050506        *InLr = *On;
034700050506        Return;
034800050506
034900050415
035000051111        BegSr  GetExtPgm;
035100050507
035200051120          WrtPgmHdr();
035300051120
035400051111          DoU  EXTI0300.CntHdl = *Blanks;
035500051111
035600051111            RtvExitInf( EXTI0300.CntHdl
035700051111                      : EXTI0300
035800051111                      : %Size( EXTI0300 )
035900051111                      : 'EXTI0300'
036000051111                      : ExtPntEnt.ExtPntNam
036100051111                      : ExtPntEnt.ExtPntFmtNam
036200051111                      : ALL_EXIT_PGM
036300051111                      : ExtPgmSlt
036400051111                      : ERRC0100
036500051111                      );
036600051111
036700051111            If  ERRC0100.BytAvl = *Zero;
036800051111
036900051111              pExtPgmEnt = %Addr( EXTI0300 ) + EXTI0300.OfsLstEnt;
037000051111
037100051111              For  PgmIdx = 1  To  EXTI0300.NbrLstEnt;
037200051111
037300051111                ExSr  GetPgmDta;
037400051119                ExSr  WrtPgmInf;
037500051111
037600051111                If  PgmIdx < EXTI0300.NbrLstEnt;
037700051111                  pExtPgmEnt = %Addr( EXTI0300 ) + ExtPgmEnt.OfsNxtEnt;
037800051111                EndIf;
037900051111              EndFor;
038000051111            EndIf;
038100051111          EndDo;
038200041211
038300041211        EndSr;
038400041211
038500051111        BegSr  GetPgmDta;
038600050319
038700051111          If  ExtPgmEnt.OfsExtPgmDta > *Zero;
038800051111
038900051111            ExtPgmDta = %Subst( EXTI0300
039000051111                              : ExtPgmEnt.OfsExtPgmDta + 1
039100051111                              : ExtPgmEnt.LenExtPgmDta
039200051111                              );
039300051119            Else;
039400051119            ExtPgmDta = NULL;
039500051111          EndIf;
039600050319
039700050319        EndSr;
039800051112
039900051112        BegSr  WrtExtPnt;
040000051112
040100051112          LstRcd.ExtPnt  = ExtPntEnt.ExtPntNam;
040200051112          LstRcd.FmtNam  = ExtPntEnt.ExtPntFmtNam;
040300051120          LstRcd.CurNbEp = %EditC( ExtPntEnt.CurNbrExtPgm: '3' );
040400051120
040500051120          If   ExtPntEnt.MaxNbrExtPgm = -1;
040600051120            EvalR LstRcd.MaxNbEp = '*NOMAX';
040700051120          Else;
040800051120            LstRcd.MaxNbEp = %EditC( ExtPntEnt.MaxNbrExtPgm: '3' );
040900051120          EndIf;
041000051112
041100051112          If  ExtPntEnt.AlwDeReg = '0';
041200051112            LstRcd.AlwDeRg = '*NO';
041300051112          Else;
041400051112            LstRcd.AlwDeRg = '*YES';
041500051112          EndIf;
041600051112
041700051112          If  ExtPntEnt.AlwChgEpCtl = '0';
041800051112            LstRcd.AlwChEp = '*NO';
041900051112          Else;
042000051112            LstRcd.AlwChEp = '*YES';
042100051112          EndIf;
042200051112
042300051112          If  ExtPntEnt.RegExtPnt = '0';
042400051112            LstRcd.RegExPg = '*NO';
042500051112          Else;
042600051112            LstRcd.RegExPg = '*YES';
042700051112          EndIf;
042800051112
042900051112          If  ExtPntEnt.ExtPntDscInd = '1';
043000051112            LstRcd.ExtPtDs = ExtPntEnt.ExtPntTxtDsc;
043100051112          Else;
043200051112            LstRcd.ExtPtDs = RtvMsgTxt( ExtPntEnt.ExtPntDscMsId
043300051112                                      : ExtPntEnt.ExtPntDscMsgF
043400051112                                      : ExtPntEnt.ExtPntDscLib
043500051112                                      );
043600051112          EndIf;
043700051112
043800051112          WrtDtlLin();
043900051112
044000051112        EndSr;
044100050507
044200051111        BegSr  WrtPgmInf;
044300051119
044400051119          PgmRcd.ExtPgNb = ExtPgmEnt.ExtPgmNbr;
044500051119          PgmRcd.ExtPgNm = ExtPgmEnt.ExtPgmNam;
044600051119          PgmRcd.ExtPgLb = ExtPgmEnt.ExtPgmLib;
044700051119
044800051119          If  %Len( ExtPgmDta ) > %Size( PgmRcd.ExtPgDt );
044900051119            PgmRcd.ExtPgDt = %Subst( ExtPgmDta
045000051119                                   : 1
045100051119                                   : %Size( PgmRcd.ExtPgDt ) - 2
045200051119                                   ) + ' >';
045300051119          Else;
045400051119            PgmRcd.ExtPgDt = ExtPgmDta;
045500051119          EndIf;
045600051119
045700110922          PgmTyp = GetPgmTyp( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb );
045800110922
045900110922          PgmRcd.PgmOwn  = GetObjOwn( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );
046000110922          PgmRcd.PgmCrt  = GetObjCrt( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );
046100110922          PgmRcd.PgmSys  = GetObjSys( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );
046200051119
046300051119          PgmRcd.PgmCrDt = GetObjCrtDat( PgmRcd.ExtPgNm
046400051119                                       : PgmRcd.ExtPgLb
046500110922                                       : PgmTyp
046600051119                                       );
046700050507
046800051119          PgmRcd.PgmChDt = GetObjChgDat( PgmRcd.ExtPgNm
046900051119                                       : PgmRcd.ExtPgLb
047000110922                                       : PgmTyp
047100051119                                       );
047200051119
047300051119          PgmRcd.PgmRsDt = GetObjRstDat( PgmRcd.ExtPgNm
047400051119                                       : PgmRcd.ExtPgLb
047500110922                                       : PgmTyp
047600051119                                       );
047700051119
047800110922          Select;
047900110922          When  SltAll = *On;
048000110922            WrtPgmLin();
048100110922
048200110922          When  ExcCmd = *On                             And
048300110922                LstRcd.ExtPnt <> 'QIBM_QCA_RTV_COMMAND'  And
048400110922                LstRcd.ExtPnt <> 'QIBM_QCA_CHG_COMMAND';
048500110922            WrtPgmLin();
048600110922
048700110922          When  ExcPgm = *On             And
048800110922                PgmRcd.PgmCrt <> '*IBM'  And
048900110922                PgmRcd.PgmCrt <> *Blanks;
049000110922            WrtPgmLin();
049100110922
049200110922          When  ExcFnc = *On                              And
049300110922              ((LstRcd.ExtPnt  <> 'QIBM_QSY_HOSTFUNC'     And
049400110922                LstRcd.ExtPnt  <> 'QIBM_QSY_OPNAVCLIENT'  And
049500110922                LstRcd.ExtPnt  <> 'QIBM_QSY_OTHERCLIENT') Or
049600110922               (PgmRcd.ExtPgNm <> 'FUNCTION'              And
049700110922                PgmRcd.ExtPgLb <> 'REGISTER'));
049800110922            WrtPgmLin();
049900110922
050000110922          When  ExcDom = *On                         And
050100110922                LstRcd.ExtPnt <> 'QIBM_QCST_ADMDMN'  And
050200110922                PgmRcd.PgmCrt <> '*IBM'  And
050300110922                PgmRcd.PgmCrt <> *Blanks;
050400110922            WrtPgmLin();
050500110922
050600110922          When  ExcIbm = *On                              And
050700110922                LstRcd.ExtPnt  <> 'QIBM_QCA_RTV_COMMAND'  And
050800110922                LstRcd.ExtPnt  <> 'QIBM_QCA_CHG_COMMAND'  And
050900110922
051000110922                PgmRcd.PgmCrt  <> '*IBM'                  And
051100110922                PgmRcd.PgmCrt  <> *Blanks                 And
051200110922
051300110922              ((LstRcd.ExtPnt  <> 'QIBM_QSY_HOSTFUNC'     And
051400110922                LstRcd.ExtPnt  <> 'QIBM_QSY_OPNAVCLIENT'  And
051500110922                LstRcd.ExtPnt  <> 'QIBM_QSY_OTHERCLIENT') Or
051600110922               (PgmRcd.ExtPgNm <> 'FUNCTION'              And
051700110922                PgmRcd.ExtPgLb <> 'REGISTER'))            And
051800110922
051900110922                LstRcd.ExtPnt  <> 'QIBM_QCST_ADMDMN'  And
052000110922                PgmRcd.PgmCrt  <> '*IBM'  And
052100110922                PgmRcd.PgmCrt  <> *Blanks;
052200110922
052300110922            WrtPgmLin();
052400110922          EndSl;
052500110922
052600050507        EndSr;
052700050507
052800041212        BegSr  *InzSr;
052900051029
053000041212          LstTim = %Int( %Char( %Time(): *ISO0));
053100050319          SysNam = GetSysNam();
053200050507
053300050507          WrtLstHdr();
053400110922
053500110922          Select;
053600110922          When  PxExcXpg.ExcVal(1) = '*NONE';
053700110922            SltAll = *On;
053800110922
053900110922          When  PxExcXpg.ExcVal(1) = '*IBM';
054000110922            ExcIbm = *On;
054100110922
054200110922          When  %LookUp( '*IBMCMD': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
054300110922            ExcCmd = *On;
054400110922
054500110922          When  %LookUp( '*IBMPGM': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
054600110922            ExcPgm = *On;
054700110922
054800110922          When  %LookUp( '*IBMDOM': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
054900110922            ExcDom = *On;
055000110922
055100110922          When  %LookUp( '*IBMFNC': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
055200110922            ExcFnc = *On;
055300110922          EndSl;
055400110922
055500041212        EndSr;
055600041212
055700050122      /End-Free
055800050122
055900041212     **-- Printer file definition:  ------------------------------------------**
056000041212     OQSYSPRT   EF           Header         2  2
056100041212     O                       UDATE         Y      8
056200041212     O                       LstTim              18 '  :  :  '
056300050319     O                                           36 'System:'
056400050319     O                       SysNam              45
056500051112     O                                           82 'Registered exit programs'
056600041212     O                                          107 'Program:'
056700050319     O                       PgmSts.PgmNam      118
056800041212     O                                          126 'Page:'
056900041212     O                       PAGE             +   1
057000050415     **
057100051120     OQSYSPRT   EF           Header         1
057200051111     O                                           27 'Exit point name . . . . . -
057300051029     O                                              :'
057400051111     O                       PxExtPnt            42
057500051029     **
057600051111     OQSYSPRT   EF           LstHdr      1  1
057700051119     O                                           10 'Exit point'
057800051119     O                                           28 'Format'
057900051119     O                                           42 'Nbr.exitpgm'
058000051119     O                                           54 'Max.exitpgm'
058100051119     O                                           64 'Alw.dereg'
058200051119     O                                           73 'Alw.chg.'
058300051119     O                                           81 'Regist.'
058400051119     O                                           86 'Text'
058500041216     **
058600051112     OQSYSPRT   EF           PgmHdr      1  1
058700051120     O                                           14 'Exit nbr.'
058800051120     O                                           23 'Program'
058900110922     O                                           35 'Library'
059000051120     O                                           57 'Exit program data'
059100051120     O                                           67 'Owner'
059200051120     O                                           81 'Creator'
059300051120     O                                           92 'System'
059400051120     O                                          106 'Create date'
059500051120     O                                          118 'Change date'
059600051120     O                                          131 'Restore date'
059700051112     **
059800041212     OQSYSPRT   EF           DtlLin         1
059900051112     O                       LstRcd.ExtPnt       20
060000051112     O                       LstRcd.FmtNam       30
060100051120     O                       LstRcd.CurNbEp      41
060200051120     O                       LstRcd.MaxNbEp      53
060300051119     O                       LstRcd.AlwDeRg      63
060400051119     O                       LstRcd.AlwChEp      71
060500051119     O                       LstRcd.RegExPg      79
060600051119     O                       LstRcd.ExtPtDs     132
060700051112     **
060800051112     OQSYSPRT   EF           PgmLin         1
060900051120     O                       PgmRcd.ExtPgNb3     12
061000051120     O                       PgmRcd.ExtPgNm      26
061100051120     O                       PgmRcd.ExtPgLb      38
061200051120     O                       PgmRcd.ExtPgDt      60
061300051120     O                       PgmRcd.PgmOwn       72
061400051120     O                       PgmRcd.PgmCrt       84
061500051120     O                       PgmRcd.PgmSys       96
061600051120     O                       PgmRcd.PgmCrDt     106
061700051120     O                       PgmRcd.PgmChDt     118
061800051120     O                       PgmRcd.PgmRsDt     130
061900041212     **
062000050123     OQSYSPRT   EF           LstTrl         1
062100050415     O                       TrlTxt              34
062200051112     **-- Write detail line:  ------------------------------------------------**
062300041216     P WrtDtlLin       B
062400041212     D                 Pi
062500041212
062600041212      /Free
062700041212
062800051121        WrtLstHdr( 6 );
062900041212
063000041216        Except  DtlLin;
063100041212
063200041212      /End-Free
063300041212
063400041216     P WrtDtlLin       E
063500051112     **-- Write program line:
063600051112     P WrtPgmLin       B
063700051112     D                 Pi
063800051112
063900051112      /Free
064000051112
064100051121        WrtPgmHdr( 1 );
064200051112
064300051112        Except  PgmLin;
064400051112
064500051112      /End-Free
064600051112
064700051112     P WrtPgmLin       E
064800051112     **-- Write list header:
064900050507     P WrtLstHdr       B
065000050507     D                 Pi
065100050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
065200050507
065300050507      /Free
065400050507
065500051120        Select;
065600051120        When  %Parms = *Zero;
065700050507          Except  Header;
065800050507
065900051120        When  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
066000051120          Except  Header;
066100051120          Except  LstHdr;
066200051120
066300051120        Other;
066400051120          Except  LstHdr;
066500051120        EndSl;
066600050507
066700050507      /End-Free
066800050507
066900050507     P WrtLstHdr       E
067000051120     **-- Write program header:
067100051120     P WrtPgmHdr       B
067200051120     D                 Pi
067300051120     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
067400051120
067500051120      /Free
067600051120
067700051120        If  %Parms = *Zero;
067800051120
067900051120          Except  PgmHdr;
068000051120        Else;
068100051120
068200051120          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
068300051120
068400051120            Except  Header;
068500051120            Except  PgmHdr;
068600051120          EndIf;
068700051120        EndIf;
068800051120
068900051120      /End-Free
069000051120
069100051120     P WrtPgmHdr       E
069200051112     **-- Write list trailer:
069300041216     P WrtLstTrl       B
069400041216     D                 Pi
069500050415     D  PxTrlTxt                     32a   Const
069600041216
069700041216      /Free
069800041216
069900050415        TrlTxt = PxTrlTxt;
070000050415
070100041216        Except  LstTrl;
070200041216
070300041216      /End-Free
070400041216
070500041216     P WrtLstTrl       E
070600051112     **-- Get system name:
070700050319     P GetSysNam       B
070800050319     D                 Pi             8a   Varying
070900051029
071000050319     **-- Local variables:
071100050319     D Idx             s             10i 0
071200050319     D SysNam          s              8a   Varying
071300050319     **
071400050319     D RtnAtrLen       s             10i 0
071500050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
071600050319     D NetAtr          s             10a   Dim( 1 )
071700050319     **
071800050319     D RtnVar          Ds                  Qualified
071900050319     D  RtnVarNbr                    10i 0
072000050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
072100050319     D  RtnVarDta                  1024a
072200050319
072300050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
072400050319     D  AtrNam                       10a
072500050319     D  DtaTyp                        1a
072600050319     D  InfSts                        1a
072700050319     D  AtrLen                       10i 0
072800050319     D  Atr                        1008a
072900050319
073000050319      /Free
073100050319
073200050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
073300050319
073400050319        NetAtr(1) = 'SYSNAME';
073500050319
073600050319        RtvNetAtr( RtnVar
073700050319                 : RtnAtrLen
073800050319                 : NetAtrNbr
073900050319                 : NetAtr
074000050319                 : ERRC0100
074100050319                 );
074200050319
074300050319        If  ERRC0100.BytAvl > *Zero;
074400050319          SysNam = '';
074500050319
074600050319        Else;
074700050319          For  Idx = 1  to RtnVar.RtnVarNbr;
074800050319
074900050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
075000050319
075100050319            If  RtnAtr.AtrNam = 'SYSNAME';
075200050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
075300050319            EndIf;
075400050319
075500050319          EndFor;
075600050319        EndIf;
075700050319
075800050319        Return  SysNam;
075900050319
076000050319      /End-Free
076100050319
076200050319     P GetSysNam       E
076300110922     **-- Get program type:
076400110922     P GetPgmTyp       B
076500050506     D                 Pi            10a
076600051119     D  PxObjNam                     10a   Value
076700051119     D  PxObjLib                     10a   Value
076800050506     **
076900051119     D OBJD0100        Ds                  Qualified
077000050506     D  BytRtn                       10i 0
077100050506     D  BytAvl                       10i 0
077200051119     D  ObjOwn                       10a   Overlay( OBJD0100: 53 )
077300050506
077400050506      /Free
077500050506
077600051119        RtvObjD( OBJD0100
077700051119               : %Size( OBJD0100 )
077800051119               : 'OBJD0100'
077900051119               : PxObjNam + PxObjLib
078000110922               : '*PGM'
078100050506               : ERRC0100
078200050506               );
078300050506
078400110922        If  ERRC0100.BytAvl = *Zero;
078500110922
078600110922          Return  '*PGM';
078700110922        EndIf;
078800050506
078900110922        RtvObjD( OBJD0100
079000110922               : %Size( OBJD0100 )
079100110922               : 'OBJD0100'
079200110922               : PxObjNam + PxObjLib
079300110922               : '*SRVPGM'
079400110922               : ERRC0100
079500110922               );
079600110922
079700110922        If  ERRC0100.BytAvl = *Zero;
079800110922
079900110922          Return  '*SRVPGM';
080000110922        EndIf;
080100110922
080200110922        Return  *Blanks;
080300050506
080400050506      /End-Free
080500050506
080600110922     P GetPgmTyp       E
080700110922     **-- Get object owner:
080800110922     P GetObjOwn       B
080900110922     D                 Pi            10a
081000110922     D  PxObjNam                     10a   Value
081100110922     D  PxObjLib                     10a   Value
081200110922     D  PxObjTyp                     10a   Value
081300110922     **
081400110922     D OBJD0100        Ds                  Qualified
081500110922     D  BytRtn                       10i 0
081600110922     D  BytAvl                       10i 0
081700110922     D  ObjOwn                       10a   Overlay( OBJD0100: 53 )
081800110922
081900110922      /Free
082000110922
082100110922        RtvObjD( OBJD0100
082200110922               : %Size( OBJD0100 )
082300110922               : 'OBJD0100'
082400110922               : PxObjNam + PxObjLib
082500110922               : PxObjTyp
082600110922               : ERRC0100
082700110922               );
082800110922
082900110922        If  ERRC0100.BytAvl > *Zero;
083000110922          Return  *Blanks;
083100110922
083200110922        Else;
083300110922          Return  OBJD0100.ObjOwn;
083400110922        EndIf;
083500110922
083600110922      /End-Free
083700110922
083800110922     P GetObjOwn       E
083900051119     **-- Get object creator:
084000051119     P GetObjCrt       B
084100051119     D                 Pi            10a
084200051119     D  PxObjNam                     10a   Value
084300051119     D  PxObjLib                     10a   Value
084400051119     D  PxObjTyp                     10a   Value
084500051119     **
084600051119     D OBJD0300        Ds                  Qualified
084700051119     D  BytRtn                       10i 0
084800051119     D  BytAvl                       10i 0
084900051119     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )
085000051119
085100051119      /Free
085200051119
085300051119        RtvObjD( OBJD0300
085400051119               : %Size( OBJD0300 )
085500051119               : 'OBJD0300'
085600051119               : PxObjNam + PxObjLib
085700051119               : PxObjTyp
085800051119               : ERRC0100
085900051119               );
086000051119
086100051119        If  ERRC0100.BytAvl > *Zero;
086200051119          Return  *Blanks;
086300051119
086400051119        Else;
086500051119          Return  OBJD0300.ObjCrt;
086600051119        EndIf;
086700051119
086800051119      /End-Free
086900051119
087000051119     P GetObjCrt       E
087100051119     **-- Get object system:
087200051119     P GetObjSys       B
087300051119     D                 Pi            10a
087400051119     D  PxObjNam                     10a   Value
087500051119     D  PxObjLib                     10a   Value
087600051119     D  PxObjTyp                     10a   Value
087700051119     **
087800051119     D OBJD0300        Ds                  Qualified
087900051119     D  BytRtn                       10i 0
088000051119     D  BytAvl                       10i 0
088100051119     D  ObjSys                       10a   Overlay( OBJD0300: 230 )
088200051119
088300051119      /Free
088400051119
088500051119        RtvObjD( OBJD0300
088600051119               : %Size( OBJD0300 )
088700051119               : 'OBJD0300'
088800051119               : PxObjNam + PxObjLib
088900051119               : PxObjTyp
089000051119               : ERRC0100
089100051119               );
089200051119
089300051119        If  ERRC0100.BytAvl > *Zero;
089400051119          Return  *Blanks;
089500051119
089600051119        Else;
089700051119          Return  OBJD0300.ObjSys;
089800051119        EndIf;
089900051119
090000051119      /End-Free
090100051119
090200051119     P GetObjSys       E
090300051119     **-- Get object creation date:
090400051119     P GetObjCrtDat    B
090500051119     D                 Pi             8a
090600051119     D  PxObjNam                     10a   Value
090700051119     D  PxObjLib                     10a   Value
090800051119     D  PxObjTyp                     10a   Value
090900051119     **
091000051119     D OBJD0100        Ds                  Qualified
091100051119     D  BytRtn                       10i 0
091200051119     D  BytAvl                       10i 0
091300051119     D  ObjCrtDts                    13a   Overlay( OBJD0100: 65 )
091400051119     D   ObjCrtDat                    7a   Overlay( ObjCrtDts: 1 )
091500051119     D   ObjCrtTim                    6a   Overlay( ObjCrtDts: 8 )
091600051119
091700051119      /Free
091800051119
091900051119        RtvObjD( OBJD0100
092000051119               : %Size( OBJD0100 )
092100051119               : 'OBJD0100'
092200051119               : PxObjNam + PxObjLib
092300051119               : PxObjTyp
092400051119               : ERRC0100
092500051119               );
092600051119
092700051119        If  ERRC0100.BytAvl > *Zero;
092800051119          Return  *Blanks;
092900051119
093000051119        Else;
093100051119          Return  %Char( %Date( OBJD0100.ObjCrtDat: *CYMD0 ): *JOBRUN );
093200051119        EndIf;
093300051119
093400051119      /End-Free
093500051119
093600051119     P GetObjCrtDat    E
093700051119     **-- Get object change date:
093800051119     P GetObjChgDat    B
093900051119     D                 Pi             8a
094000051119     D  PxObjNam                     10a   Value
094100051119     D  PxObjLib                     10a   Value
094200051119     D  PxObjTyp                     10a   Value
094300051119     **
094400051119     D OBJD0100        Ds                  Qualified
094500051119     D  BytRtn                       10i 0
094600051119     D  BytAvl                       10i 0
094700051119     D  ObjChgDts                    13a   Overlay( OBJD0100: 78 )
094800051119     D   ObjChgDat                    7a   Overlay( ObjChgDts: 1 )
094900051119     D   ObjChgTim                    6a   Overlay( ObjChgDts: 8 )
095000051119
095100051119      /Free
095200051119
095300051119        RtvObjD( OBJD0100
095400051119               : %Size( OBJD0100 )
095500051119               : 'OBJD0100'
095600051119               : PxObjNam + PxObjLib
095700051119               : PxObjTyp
095800051119               : ERRC0100
095900051119               );
096000051119
096100051119        Select;
096200051119        When  ERRC0100.BytAvl > *Zero;
096300051119          Return  *Blanks;
096400051119
096500051119        When  OBJD0100.ObjChgDat = *Blanks;
096600051119          Return  *Blanks;
096700051119
096800051119        Other;
096900051119          Return  %Char( %Date( OBJD0100.ObjChgDat: *CYMD0 ): *JOBRUN );
097000051119        EndSl;
097100051119
097200051119      /End-Free
097300051119
097400051119     P GetObjChgDat    E
097500051119     **-- Get object restore date:
097600051119     P GetObjRstDat    B
097700051119     D                 Pi             8a
097800051119     D  PxObjNam                     10a   Value
097900051119     D  PxObjLib                     10a   Value
098000051119     D  PxObjTyp                     10a   Value
098100051119     **
098200051119     D OBJD0300        Ds                  Qualified
098300051119     D  BytRtn                       10i 0
098400051119     D  BytAvl                       10i 0
098500051119     D  ObjRstDts                    13a   Overlay( OBJD0300: 207 )
098600051119     D   ObjRstDat                    7a   Overlay( ObjRstDts: 1 )
098700051119     D   ObjRstTim                    6a   Overlay( ObjRstDts: 8 )
098800051119
098900051119      /Free
099000051119
099100051119        RtvObjD( OBJD0300
099200051119               : %Size( OBJD0300 )
099300051119               : 'OBJD0300'
099400051119               : PxObjNam + PxObjLib
099500051119               : PxObjTyp
099600051119               : ERRC0100
099700051119               );
099800051119
099900051119        Select;
100000051119        When  ERRC0100.BytAvl > *Zero;
100100051119          Return  *Blanks;
100200051119
100300051119        When  OBJD0300.ObjRstDat = *Blanks;
100400051119          Return  *Blanks;
100500051119
100600051119        Other;
100700051119          Return  %Char( %Date( OBJD0300.ObjRstDat: *CYMD0 ): *JOBRUN );
100800051119        EndSl;
100900051119
101000051119      /End-Free
101100051119
101200051119     P GetObjRstDat    E
101300051112     **-- Retrieve message text:
101400051112     P RtvMsgTxt       B                   Export
101500051112     D                 Pi          1024a   Varying
101600051112     D  PxMsgId                       7a   Value
101700051112     D  PxMsgF                       10a   Value
101800051112     D  PxMsgFlib                    10a   Value
101900051112     D  PxMsgDta                   1024a   Const  Options( *NoPass )
102000051112
102100051112     **-- Local variables:
102200051112     D MsgDta          s           1024a   Varying
102300051112     **-- Return structure:
102400051112     D RTVM0100        Ds                  Qualified
102500051112     D  BytRtn                       10i 0
102600051112     D  BytAvl                       10i 0
102700051112     D  RtnMsgLen                    10i 0
102800051112     D  RtnMsgAvl                    10i 0
102900051112     D  RtnHlpLen                    10i 0
103000051112     D  RtnHlpAvl                    10i 0
103100051112     D  Msg                        1024a
103200051112     **
103300051112     D NULL            c                   ''
103400051112
103500051112      /Free
103600051112
103700051112        If  %Parms >= 4;
103800051112          MsgDta = %TrimL( PxMsgDta );
103900051112        EndIf;
104000051112
104100051112        RtvMsg( RTVM0100
104200051112              : %Size( RTVM0100 )
104300051112              :'RTVM0100'
104400051112              : PxMsgId
104500051112              : PxMsgF + PxMsgFlib
104600051112              : MsgDta
104700051112              : %Len( MsgDta )
104800051112              : '*YES'
104900051112              : '*NO'
105000051112              : ERRC0100
105100051112              );
105200051112
105300051112        If  ERRC0100.BytAvl = *Zero;
105400051112          Return  %SubSt( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
105500051112
105600051112        Else;
105700051112          Return  NULL;
105800051112        EndIf;
105900051112
106000051112      /End-Free
106100051112
106200051112     P RtvMsgTxt       E
106300051112     **-- Send user message:
106400051101     P SndUsrMsg       B                   Export
106500051101     D                 Pi            10i 0
106600051101     D  PxUsrPrf                     10a   Const
106700051101     D  PxMsgDta                    512a   Const  Varying
106800051101     **
106900051101     D MsgKey          s              4a
107000051101
107100051101      /Free
107200051101
107300051101        SndMsg( 'CPF9897'
107400051101              : 'QCPFMSG   *LIBL'
107500051101              : PxMsgDta
107600051101              : %Len( PxMsgDta )
107700051101              : '*INFO'
107800051101              : PxUsrPrf + '*LIBL'
107900051101              : 1
108000051101              : *Blanks
108100051101              : MsgKey
108200051101              : ERRC0100
108300051101              );
108400051101
108500051101        If  ERRC0100.BytAvl > *Zero;
108600051101          Return -1;
108700051101
108800051101        Else;
108900051101          Return  0;
109000051101        EndIf;
109100051101
109200051101      /End-Free
109300051101
109400051101     **
109500051101     P SndUsrMsg       E
109600051112     **-- Send completion message:
109700050507     P SndCmpMsg       B
109800050507     D                 Pi            10i 0
109900050507     D  PxMsgDta                    512a   Const  Varying
110000050507     **
110100050507     D MsgKey          s              4a
110200050507
110300050507      /Free
110400050507
110500050507        SndPgmMsg( 'CPF9897'
110600050507                 : 'QCPFMSG   *LIBL'
110700050507                 : PxMsgDta
110800050507                 : %Len( PxMsgDta )
110900050507                 : '*COMP'
111000050507                 : '*PGMBDY'
111100050507                 : 1
111200050507                 : MsgKey
111300050507                 : ERRC0100
111400050507                 );
111500050507
111600050507        If  ERRC0100.BytAvl > *Zero;
111700050507          Return  -1;
111800050507
111900050507        Else;
112000050507          Return  0;
112100050507
112200050507        EndIf;
112300050507
112400050507      /End-Free
112500050507
112600050507     P SndCmpMsg       E
