000100041212     **
000200050507     **  Program . . : CBX936
000300050508     **  Description : Analyze user profiles - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Compile and setup instructions:
000800050507     **    CrtRpgMod   Module( CBX936 )
000900050318     **                DbgView( *LIST )
001000041212     **
001100050507     **    CrtPgm      Pgm( CBX936 )
001200050507     **                Module( CBX936 )
001300041212     **                ActGrp( *NEW )
001400041212     **
001500041212     **
001600041212     **-- Control specification:  --------------------------------------------**
001700050319     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
001800041212     **-- Printer file:
001900041212     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
002000041212     **-- Printer file information:
002100050212     D PrtLinInf       Ds                  Qualified
002200050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
002300050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
002400050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
002500041212     **-- System information:
002600050319     D PgmSts         SDs                  Qualified
002700050319     D  PgmNam           *Proc
002800041211     **-- API error data structure:
002900041211     D ERRC0100        Ds                  Qualified
003000041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003100041211     D  BytAvl                       10i 0
003200041211     D  MsgId                         7a
003300990921     D                                1a
003400041211     D  MsgDta                      128a
003500041212     **-- Global variables:
003600041212     D LstTim          s              6s 0
003700050319     D SysNam          s              8a
003800050415     D TrlTxt          s             32a
003900050122     **-- List record:
004000050122     D LstRcd          Ds                  Qualified
004100050507     D  UsrPrf                       10a
004200050507     D  PrfSts                       10a
004300050507     D  PwdExpI                       4a
004400050507     D  PwdExpD                       8a
004500050507     D  InvSgo                        3i 0
004600050507     D  GrpPrf                       10a
004700050507     D  PwdI                          4a
004800050507     D  LmtCap                        4a
004900050507     D  SpcAut                        4a
005000050507     D  UsrCls                       10a
005100050507     D  PrvSgoD                       8a
005200050507     D  PwdChgD                       8a
005300050212     **-- List API parameters:
005400050212     D LstApi          Ds                  Qualified  Inz
005500050212     D  RtnRcdNbr                    10i 0
005600050506     D  GrpNam                       10a
005700050506     D  SltCri                       10a
005800040426     **-- List information:
005900041211     D LstInf          Ds                  Qualified
006000041211     D  RcdNbrTot                    10i 0
006100041211     D  RcdNbrRtn                    10i 0
006200041211     D  Handle                        4a
006300041211     D  RcdLen                       10i 0
006400041211     D  InfSts                        1a
006500041211     D  Dts                          13a
006600041211     D  LstSts                        1a
006700040426     D                                1a
006800041211     D  InfLen                       10i 0
006900041211     D  Rcd1                         10i 0
007000040426     D                               40a
007100050507     **-- User information:
007200050507     D AUTU0100        Ds                  Qualified
007300050506     D  UsrPrf                       10a
007400050506     D  UsrGrpI                       1a
007500050506     D  GrpMbrI                       1a
007600050507     **-- User information:
007700050507     D USRI0300        Ds                  Qualified
007800050507     D  BytRtn                       10i 0
007900050507     D  BytAvl                       10i 0
008000050507     D  UsrPrf                       10a
008100050507     D  PrvSgoDts                    13a   Overlay( USRI0300:  19 )
008200050507     D   PrvSgoDat                    7a   Overlay( USRI0300:  19 )
008300050507     D   PrvSgoTim                    6a   Overlay( USRI0300:  26 )
008400050507     D  InvSgo                       10i 0 Overlay( USRI0300:  33 )
008500050507     D  PrfSts                       10a   Overlay( USRI0300:  37 )
008600050507     D  PwdChgDat                     8a   Overlay( USRI0300:  47 )
008700050507     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
008800050507     D  PwdExpDat                     8a   Overlay( USRI0300:  61 )
008900050507     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
009000050507     D  UsrCls                       10a   Overlay( USRI0300:  74 )
009100050507     D  SpcAut                       15a   Overlay( USRI0300:  84 )
009200050507     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
009300050507     D  LmtCap                       10a   Overlay( USRI0300: 189 )
009400050506     **-- Open list of authorized users:
009500050506     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
009600050506     D  LuRcvVar                  65535a          Options( *VarSize )
009700050506     D  LuRcvVarLen                  10i 0 Const
009800050506     D  LuLstInf                     80a
009900050506     D  LuNbrRcdRtn                  10i 0 Const
010000050506     D  LuFmtNam                      8a   Const
010100050506     D  LuSltCri                     10a   Const
010200050506     D  LuGrpNam                     10a   Const
010300050506     D  LuError                    1024a          Options( *VarSize )
010400041212     **-- Get list entry:
010500020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
010600020531     D  GlRcvVar                  65535a          Options( *VarSize )
010700020531     D  GlRcvVarLen                  10i 0 Const
010800020531     D  GlHandle                      4a   Const
010900020531     D  GlLstInf                     80a
011000020531     D  GlNbrRcdRtn                  10i 0 Const
011100020531     D  GlRtnRcdNbr                  10i 0 Const
011200020531     D  GlError                    1024a          Options( *VarSize )
011300041212     **-- Close list:
011400020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
011500020531     D  ClHandle                      4a   Const
011600020531     D  ClError                    1024a          Options( *VarSize )
011700050319     **-- Send program message:
011800050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
011900050319     D  SpMsgId                       7a   Const
012000050319     D  SpMsgFq                      20a   Const
012100050319     D  SpMsgDta                    128a   Const
012200050319     D  SpMsgDtaLen                  10i 0 Const
012300050319     D  SpMsgTyp                     10a   Const
012400050319     D  SpCalStkE                    10a   Const  Options( *VarSize )
012500050319     D  SpCalStkCtr                  10i 0 Const
012600050319     D  SpMsgKey                      4a
012700050319     D  SpError                   32767a          Options( *VarSize )
012800050318     **-- Convert date & time:
012900050318     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
013000050318     D  CdInpFmt                     10a   Const
013100050318     D  CdInpVar                     17a   Const  Options( *VarSize )
013200050318     D  CdOutFmt                     10a   Const
013300050318     D  CdOutVar                     17a          Options( *VarSize )
013400050318     D  CdError                      10i 0 Const
013500050319     **-- Retrieve net attribute:
013600050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
013700050319     D  RnRcvVar                  32767a          Options( *VarSize )
013800050319     D  RnRcvVarLen                  10i 0 Const
013900050319     D  RnNbrNetAtr                  10i 0 Const
014000050319     D  RnNetAtr                     10a   Const  Dim( 256 )
014100050319     D                                            Options( *VarSize )
014200050319     D  RnError                   32767a          Options( *VarSize )
014300050506     **-- Retrieve user information:
014400050506     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
014500050506     D  RuRcvVar                  32767a          Options( *VarSize )
014600050506     D  RuRcvVarLen                  10i 0 Const
014700050506     D  RuFmtNam                     10a   Const
014800050506     D  RuUsrPrf                     10a   Const
014900050506     D  RuError                   32767a          Options( *VarSize )
015000050506     **-- Retrieve object description:
015100050506     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
015200050506     D  RoRcvVar                  32767a         Options( *VarSize )
015300050506     D  RoRcvVarLen                  10i 0 Const
015400050506     D  RoFmtNam                      8a   Const
015500050506     D  RoObjNamQ                    20a   Const
015600050506     D  RoObjTyp                     10a   Const
015700050506     D  RoError                   32767a         Options( *VarSize )
015800041212
015900050318     **-- Convert system DTS to date:
016000050318     D CvtDtsDat       Pr              d
016100050318     D  PxSysDts                      8a   Value
016200050319     **-- Get system name:
016300050319     D GetSysNam       Pr             8a   Varying
016400050506     **-- Get user creator:
016500050506     D GetUsrCrt       Pr            10a
016600050506     D  PxUsrPrf                     10a   Value
016700050507     **-- Send completion message:
016800050507     D SndCmpMsg       Pr            10i 0
016900050507     D  PxMsgDta                    512a   Const  Varying
017000041216     **-- Write detail line:
017100041216     D WrtDtlLin       Pr
017200050507     **-- Write list header:
017300050507     D WrtLstHdr       Pr
017400050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
017500041216     **-- Write list trailer:
017600041216     D WrtLstTrl       Pr
017700050415     D  PxTrlTxt                     32a   Const
017800041212
017900050319     **-- Entry parameters:
018000050507     D CBX936          Pr
018100050507     D  PxOption                     10a
018200050507     D  PxSysPrf                      4a
018300041212     **
018400050507     D CBX936          Pi
018500050507     D  PxOption                     10a
018600050507     D  PxSysPrf                      4a
018700041211
018800041211      /Free
018900041211
019000050506        LstApi.RtnRcdNbr = 1;
019100050506
019200050507        If  PxOption = '*NOGROUP';
019300050507          LstApi.SltCri = '*MEMBER';
019400050507          LstApi.GrpNam = '*NOGROUP';
019500050507        Else;
019600050507          LstApi.SltCri = '*ALL';
019700050507          LstApi.GrpNam = '*NONE';
019800050507        EndIf;
019900050506
020000050506        LstAutUsr( AUTU0100
020100050506                 : %Size( AUTU0100 )
020200050506                 : LstInf
020300050506                 : 1
020400050506                 : 'AUTU0100'
020500050506                 : LstApi.SltCri
020600050506                 : LstApi.GrpNam
020700050506                 : ERRC0100
020800050506                 );
020900050415
021000050506        If  ERRC0100.BytAvl = *Zero;
021100050506
021200050506          DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
021300050506
021400050507            ExSr  GetPrfInf;
021500050506
021600050506            LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
021700050506
021800050507            GetLstEnt( AUTU0100
021900050507                     : %Size( AUTU0100 )
022000050506                     : LstInf.Handle
022100050506                     : LstInf
022200050506                     : 1
022300050506                     : LstApi.RtnRcdNbr
022400050506                     : ERRC0100
022500050506                     );
022600050506
022700050506            If  ERRC0100.BytAvl > *Zero;
022800050506              Leave;
022900050506            EndIf;
023000050506
023100050506          EndDo;
023200050506
023300050506          CloseLst( LstInf.Handle: ERRC0100 );
023400050506        EndIf;
023500050506
023600050506        WrtLstTrl( '***  E N D  O F  L I S T  ***' );
023700050415
023800050507        SndCmpMsg( 'List has been printed.' );
023900050507
024000050506        *InLr = *On;
024100050506        Return;
024200050506
024300050415
024400050507        BegSr  GetPrfInf;
024500050507
024600050507          RtvUsrInf( USRI0300
024700050507                   : %Size( USRI0300 )
024800050507                   : 'USRI0300'
024900050507                   : AUTU0100.UsrPrf
025000050507                   : ERRC0100
025100050507                   );
025200050507
025300050507          If  ERRC0100.BytAvl = *Zero;
025400050507            ExSr  ChkPrfInf;
025500050507          EndIf;
025600041211
025700041211        EndSr;
025800041211
025900050507        BegSr  ChkPrfInf;
026000050319
026100050507          If  PxSysPrf = '*YES'  Or  GetUsrCrt( USRI0300.UsrPrf ) <> '*IBM';
026200050507
026300050507            Select;
026400050507            When  PxOption = '*DISABLED'  And  USRI0300.PrfSts = '*DISABLED';
026500050507              ExSr WrtPrfInf;
026600050507
026700050507            When  PxOption = '*EXPIRED'  And  USRI0300.PwdExpI = 'Y';
026800050507              ExSr WrtPrfInf;
026900050507
027000050507            When  PxOption = '*EXPIRED'  And  USRI0300.PwdExpDat = *Blanks;
027100050508              // No expiration date - skip user profile.
027200050507
027300050507            When  PxOption = '*EXPIRED'  And
027400050507                  CvtDtsDat( USRI0300.PwdExpDat ) <= %Date();
027500050507              ExSr WrtPrfInf;
027600050507
027700050507            When  PxOption = '*INVSIGNON'  And  USRI0300.InvSgo > *Zero;
027800050507              ExSr WrtPrfInf;
027900050507
028000050507            When  PxOption = '*NOGROUP'  And  USRI0300.GrpPrf = '*NONE';
028100050507              ExSr WrtPrfInf;
028200050507
028300050507            When  PxOption = '*NOPWD'  And  USRI0300.NoPwdI = 'Y';
028400050507              ExSr WrtPrfInf;
028500050507
028600050507            When  PxOption = '*NOTLMTCAP'  And  USRI0300.LmtCap <> '*YES';
028700050507              ExSr WrtPrfInf;
028800050507            EndSl;
028900050507          EndIf;
029000050319
029100050319        EndSr;
029200050507
029300050507        BegSr  WrtPrfInf;
029400050507
029500050507          LstRcd.UsrPrf = USRI0300.UsrPrf;
029600050507          LstRcd.PrfSts = USRI0300.PrfSts;
029700050507          LstRcd.InvSgo = USRI0300.InvSgo;
029800050507          LstRcd.GrpPrf = USRI0300.GrpPrf;
029900050507          LstRcd.LmtCap = USRI0300.LmtCap;
030000050507          LstRcd.UsrCls = USRI0300.UsrCls;
030100050507
030200050507          If  USRI0300.PwdExpDat = *Blanks;
030300050507            LstRcd.PwdExpD = '*NONE';
030400050507          Else;
030500050507            LstRcd.PwdExpD = %Char( CvtDtsDat( USRI0300.PwdExpDat ): *JOBRUN );
030600050507          EndIf;
030700050507
030800050507          If  USRI0300.PwdChgDat = *Blanks;
030900050507            LstRcd.PwdChgD = '*NONE';
031000050507          Else;
031100050507            LstRcd.PwdChgD = %Char( CvtDtsDat( USRI0300.PwdChgDat ): *JOBRUN );
031200050507          EndIf;
031300050507
031400050507          If  USRI0300.PrvSgoDts = *Blanks;
031500050507            LstRcd.PrvSgoD = '*NONE';
031600050507          Else;
031700050507            LstRcd.PrvSgoD = %Char( %Date( USRI0300.PrvSgoDat: *CYMD0 )
031800050507                                  : *JOBRUN
031900050507                                  );
032000050507          EndIf;
032100050507
032200050507          If  USRI0300.PwdExpI = 'Y';
032300050507            LstRcd.PwdExpI = '*YES';
032400050507          Else;
032500050507            LstRcd.PwdExpI = '*NO';
032600050507          EndIf;
032700050507
032800050507          If  USRI0300.NoPwdI = 'Y';
032900050507            LstRcd.PwdI = '*NO';
033000050507          Else;
033100050507            LstRcd.PwdI = '*YES';
033200050507          EndIf;
033300050507
033400050507          If  USRI0300.SpcAut = 'NNNNNNNN';
033500050507            LstRcd.SpcAut = '*NO';
033600050507          Else;
033700050507            LstRcd.SpcAut = '*YES';
033800050507          EndIf;
033900050507
034000050507          WrtDtlLin();
034100050507
034200050507        EndSr;
034300050507
034400041212        BegSr  *InzSr;
034500041212
034600041212          LstTim = %Int( %Char( %Time(): *ISO0));
034700050319          SysNam = GetSysNam();
034800050507
034900050507          WrtLstHdr();
035000041212
035100041212        EndSr;
035200041212
035300050122      /End-Free
035400050122
035500041212     **-- Printer file definition:  ------------------------------------------**
035600041212     OQSYSPRT   EF           Header         2  2
035700041212     O                       UDATE         Y      8
035800041212     O                       LstTim              18 '  :  :  '
035900050319     O                                           36 'System:'
036000050319     O                       SysNam              45
036100050507     O                                           82 'User profile exceptions'
036200041212     O                                          107 'Program:'
036300050319     O                       PgmSts.PgmNam      118
036400041212     O                                          126 'Page:'
036500041212     O                       PAGE             +   1
036600050415     **
036700041212     OQSYSPRT   EF           LstHdr         1
036800050507     O                                            4 'User'
036900050507     O                                           17 'Class'
037000050507     O                                           29 'Group'
037100050507     O                                           42 'Status'
037200050507     O                                           53 'Limit'
037300050507     O                                           65 'Spc.aut.'
037400050507     O                                           75 'Inv.sign.'
037500050507     O                                           84 'Password'
037600050507     O                                           94 'Pwd.exp.'
037700050507     O                                          104 'Exp.date'
037800050507     O                                          114 'Sign-on'
037900050507     O                                          129 'Pwd. changed'
038000041216     **
038100041212     OQSYSPRT   EF           DtlLin         1
038200050507     O                       LstRcd.UsrPrf       10
038300050507     O                       LstRcd.UsrCls       22
038400050507     O                       LstRcd.GrpPrf       34
038500050507     O                       LstRcd.PrfSts       46
038600050507     O                       LstRcd.LmtCap       52
038700050507     O                       LstRcd.SpcAut       62
038800050507     O                       LstRcd.InvSgo Z     70
038900050507     O                       LstRcd.PwdI         81
039000050507     O                       LstRcd.PwdExpI      92
039100050507     O                       LstRcd.PwdExpD     104
039200050507     O                       LstRcd.PrvSgoD     115
039300050507     O                       LstRcd.PwdChgD     126
039400041212     **
039500050123     OQSYSPRT   EF           LstTrl         1
039600050415     O                       TrlTxt              34
039700041216     **-- Write detail line:  ------------------------------------------------**
039800041216     P WrtDtlLin       B
039900041212     D                 Pi
040000041212
040100041212      /Free
040200041212
040300050507        WrtLstHdr( 3 );
040400041212
040500041216        Except  DtlLin;
040600041212
040700041212      /End-Free
040800041212
040900041216     P WrtDtlLin       E
041000050507     **-- Write list header:  ------------------------------------------------**
041100050507     P WrtLstHdr       B
041200050507     D                 Pi
041300050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
041400050507
041500050507      /Free
041600050507
041700050507        If  %Parms = *Zero;
041800050507
041900050507          Except  Header;
042000050507          Except  LstHdr;
042100050507        Else;
042200050507
042300050507          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
042400050507
042500050507            Except  Header;
042600050507            Except  LstHdr;
042700050507          EndIf;
042800050507        EndIf;
042900050507
043000050507      /End-Free
043100050507
043200050507     P WrtLstHdr       E
043300041216     **-- Write list trailer:  -----------------------------------------------**
043400041216     P WrtLstTrl       B
043500041216     D                 Pi
043600050415     D  PxTrlTxt                     32a   Const
043700041216
043800041216      /Free
043900041216
044000050415        TrlTxt = PxTrlTxt;
044100050415
044200041216        Except  LstTrl;
044300041216
044400041216      /End-Free
044500041216
044600041216     P WrtLstTrl       E
044700050318     **-- Convert system DTS to date:  ---------------------------------------**
044800050318     P CvtDtsDat       B
044900050318     D                 Pi              d
045000050318     D  PxSysDts                      8a   Value
045100050318
045200050318     D MI_DTS          s             20a
045300050318
045400050318      /Free
045500050318
045600050318        CvtDtf( '*DTS': PxSysDts: '*YYMD': MI_DTS: *Zero );
045700050318
045800050318        Return  %Date( %Timestamp( MI_DTS: *ISO0 ));
045900050318
046000050318      /End-Free
046100050318
046200050318     P CvtDtsDat       E
046300050319     **-- Get system name:  --------------------------------------------------**
046400050319     P GetSysNam       B
046500050319     D                 Pi             8a   Varying
046600050319     **
046700050319     **-- Local variables:
046800050319     D Idx             s             10i 0
046900050319     D SysNam          s              8a   Varying
047000050319     **
047100050319     D RtnAtrLen       s             10i 0
047200050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
047300050319     D NetAtr          s             10a   Dim( 1 )
047400050319     **
047500050319     D RtnVar          Ds                  Qualified
047600050319     D  RtnVarNbr                    10i 0
047700050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
047800050319     D  RtnVarDta                  1024a
047900050319
048000050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
048100050319     D  AtrNam                       10a
048200050319     D  DtaTyp                        1a
048300050319     D  InfSts                        1a
048400050319     D  AtrLen                       10i 0
048500050319     D  Atr                        1008a
048600050319
048700050319      /Free
048800050319
048900050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
049000050319
049100050319        NetAtr(1) = 'SYSNAME';
049200050319
049300050319        RtvNetAtr( RtnVar
049400050319                 : RtnAtrLen
049500050319                 : NetAtrNbr
049600050319                 : NetAtr
049700050319                 : ERRC0100
049800050319                 );
049900050319
050000050319        If  ERRC0100.BytAvl > *Zero;
050100050319          SysNam = '';
050200050319
050300050319        Else;
050400050319          For  Idx = 1  to RtnVar.RtnVarNbr;
050500050319
050600050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
050700050319
050800050319            If  RtnAtr.AtrNam = 'SYSNAME';
050900050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
051000050319            EndIf;
051100050319
051200050319          EndFor;
051300050319        EndIf;
051400050319
051500050319        Return  SysNam;
051600050319
051700050319      /End-Free
051800050319
051900050319     P GetSysNam       E
052000050506     **-- Get user creator:  -------------------------------------------------**
052100050506     P GetUsrCrt       B                   Export
052200050506     D                 Pi            10a
052300050506     D  PxUsrPrf                     10a   Value
052400050506     **
052500050506     D OBJD0300        Ds                  Qualified
052600050506     D  BytRtn                       10i 0
052700050506     D  BytAvl                       10i 0
052800050506     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )
052900050506
053000050506      /Free
053100050506
053200050506        RtvObjD( OBJD0300
053300050506               : %Size( OBJD0300 )
053400050506               : 'OBJD0300'
053500050506               : PxUsrPrf + 'QSYS'
053600050506               : '*USRPRF'
053700050506               : ERRC0100
053800050506               );
053900050506
054000050506        If  ERRC0100.BytAvl > *Zero;
054100050506          Return  *Blanks;
054200050506
054300050506        Else;
054400050506          Return  OBJD0300.ObjCrt;
054500050506        EndIf;
054600050506
054700050506      /End-Free
054800050506
054900050506     P GetUsrCrt       E
055000050507     **-- Send completion message:  ------------------------------------------**
055100050507     P SndCmpMsg       B
055200050507     D                 Pi            10i 0
055300050507     D  PxMsgDta                    512a   Const  Varying
055400050507     **
055500050507     D MsgKey          s              4a
055600050507
055700050507      /Free
055800050507
055900050507        SndPgmMsg( 'CPF9897'
056000050507                 : 'QCPFMSG   *LIBL'
056100050507                 : PxMsgDta
056200050507                 : %Len( PxMsgDta )
056300050507                 : '*COMP'
056400050507                 : '*PGMBDY'
056500050507                 : 1
056600050507                 : MsgKey
056700050507                 : ERRC0100
056800050507                 );
056900050507
057000050507        If  ERRC0100.BytAvl > *Zero;
057100050507          Return  -1;
057200050507
057300050507        Else;
057400050507          Return  0;
057500050507
057600050507        EndIf;
057700050507
057800050507      /End-Free
057900050507
058000050507     **
058100050507     P SndCmpMsg       E
