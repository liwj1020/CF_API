000100041110     **
000200140101     **  Program . . : CBX971
000300140101     **  Description : Work with Output Queue Authorities - UIM Exit Program
000400140101     **  Author  . . : Carsten Flensburg
000500140101     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700071006     **
000800060514     **
000900060328     **  Compile options:
001000140101     **    CrtRpgMod  Module( CBX971E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300140101     **    CrtPgm     Pgm( CBX971E )
001400140101     **               Module( CBX971E )
001500120212     **               ActGrp( *NEW )
001600031115     **
001700031115     **
001800040605     **-- Control specification:  --------------------------------------------**
001900060311     H Option( *SrcStmt )
002000040722
002100041120     **-- System information:
002200041120     D PgmSts         SDs                  Qualified
002300041120     D  PgmNam           *Proc
002400041120     D  CurJob                       10a   Overlay( PgmSts: 244 )
002500041120     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002600041120     D  JobNbr                        6a   Overlay( PgmSts: 264 )
002700041120     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002800060311
002900040728     **-- API error data structure:
003000040728     D ERRC0100        Ds                  Qualified
003100040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003200040728     D  BytAvl                       10i 0
003300041119     D  MsgId                         7a
003400040728     D                                1a
003500041119     D  MsgDta                      512a
003600060311
003700041120     **-- Global constants:
003800060327     D NULL            c                   ''
003900060327     D NO_ENT          c                   x'00000000'
004000060703     D RES_OK          c                   0
004100060703     **-- Global variables:
004200060703     D MsgKey          s              4a
004300140420     D MsgStr          s            512a   Varying
004400111203     D Idx             s             10i 0
004500140420     D BLANKS          s             50a
004600120212
004700120212     **-- Qualified object name:
004800120212     D ObjNam_q        Ds
004900120212     D  ObjNam                       10a
005000120212     D  ObjLib                       10a
005100120208     **-- Supplemental groups:
005200120208     D SupGrpPrf       Ds                  Qualified
005300120208     D  SupGrpLst                    10a   Dim( 15 )
005400120208     **-- Supplemental groups list:
005500120208     D SupGrpLst       Ds                  Qualified
005600120208     D  SupGrpLst                    11a   Dim( 15 )
005700120208
005800140420     **-- UIM Panel header record:
005900140420     D HdrRcd          Ds                  Qualified
006000140420     D  SysDat                        7a
006100140420     D  SysTim                        6a
006200140420     D  TimZon                       10a
006300140420     D  OutQue_q                     20a
006400140420     D  WrkUsr                       10a
006500140420     D  PosUsr                       10a
006600140420     D  DspDta                       10a
006700140420     D  OprCtl                       10a
006800140420     D  AutChk                       10a
006900140420     D  QueOwn                       10a
007000140420     D  PubAut                       10a
007100140420     D  QueAutL                      10a
007200120208     **-- User information:
007300120208     D USRI0300        Ds         10240    Qualified
007400120208     D  BytRtn                       10i 0
007500120208     D  BytAvl                       10i 0
007600120208     D  UsrPrf                       10a
007700120208     D  PrvSgoDts                    13a   Overlay( USRI0300:  19 )
007800120208     D   PrvSgoDat                    7a   Overlay( USRI0300:  19 )
007900120208     D   PrvSgoTim                    6a   Overlay( USRI0300:  26 )
008000120208     D  InvSgo                       10i 0 Overlay( USRI0300:  33 )
008100120208     D  PrfSts                       10a   Overlay( USRI0300:  37 )
008200120208     D  PwdChgDat                     8a   Overlay( USRI0300:  47 )
008300120208     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
008400120208     D  PwdExpItv                    10i 0 Overlay( USRI0300:  57 )
008500120208     D  PwdExpDat                     8a   Overlay( USRI0300:  61 )
008600120208     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
008700120208     D  UsrCls                       10a   Overlay( USRI0300:  74 )
008800120208     D  SpcAut                       15a   Overlay( USRI0300:  84 )
008900120208     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
009000120208     D  Owner                        10a   Overlay( USRI0300: 109 )
009100120208     D  GrpAut                       10a   Overlay( USRI0300: 119 )
009200120208     D  LmtCap                       10a   Overlay( USRI0300: 189 )
009300120208     D  TxtDsc                       50a   Overlay( USRI0300: 199 )
009400120208     D  ObjAudVal                    10a   Overlay( USRI0300: 501 )
009500120208     D  UsrAudVal                    64a   Overlay( USRI0300: 511 )
009600120208     D  GrpAutTyp                    10a   Overlay( USRI0300: 575 )
009700120208     D  OfsSupGrp                    10i 0 Overlay( USRI0300: 585 )
009800120208     D  NbrSupGrp                    10i 0 Overlay( USRI0300: 589 )
009900120208     D  GrpMbrI                       1a   Overlay( USRI0300: 633 )
010000120208     D  DigCerI                       1a   Overlay( USRI0300: 634 )
010100120208     D  LocPwdMgt                     1a   Overlay( USRI0300: 661 )
010200140420     **-- Output queue information:
010300140420     D OUTQ0100        Ds                  Qualified
010400140420     D  BytRtn                       10i 0
010500140420     D  BytAvl                       10i 0
010600140420     D  OutQue_q                     20a
010700140420     D   OutQueNam                   10a   Overlay( OutQue_q: 1 )
010800140420     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
010900140420     D  FilOrd                       10a
011000140420     D  DspAnyF                      10a
011100140420     D  JobSep                       10i 0
011200140420     D  OprCtl                       10a
011300140420     D  DtaQueNam                    10a
011400140420     D  DtaQueLib                    10a
011500140420     D  AutChk                       10a
011600140420     D  NbrFil                       10i 0
011700140420     D  OutQueSts                    10a
011800140420     D  WtrJobNam                    10a
011900140420     D  WtrJobUsr                    10a
012000140420     D  WtrJobNbr                     6a
012100140420     D  WtrJobSts                    10a
012200140420     D  PrtDevNam                    10a
012300140420     D  OutQueTxt                    50a
012400140420     D                                2a
012500140420     D  NbrSpfPag                    10i 0
012600140420     D  NbrWtrStr                    10i 0
012700140420     D  WtrAutStr                    10i 0
012800120208
012900070804     **-- UIM constants:
013000070804     D RDS_OPT_INZ     c                   'N'
013100111203     D POS_TOP         c                   'TOP'
013200070804     D CPY_VAR         c                   'Y'
013300070804     D INC_EXP         c                   'Y'
013400070804     D RMV_LST_ADD     c                   'L'
013500070804     D LIST_COMP       c                   'ALL'
013600070805     D LIST_SAME       c                   'SAME'
013700070804     D EXIT_SAME       c                   '*SAME'
013800070804     D TRIM_SAME       c                   'S'
013900070804     D KEY_ENTER       c                   26
014000060423     **-- UIM variables:
014100060423     D UIM             Ds                  Qualified
014200060423     D  EntHdl                        4a
014300070804     D  LstPos                        4a
014400070804     D  FncRqs                       10i 0
014500111203     D  LstHdl                        4a
014600111203     D  EntLocOpt2                    4a
014700111203
014800060311     **-- UIM API return structures:
014900120208     **-- Cursor record:
015000120208     D CsrRcd          Ds                  Qualified
015100120208     D  CsrEid                        4a
015200120208     D  CsrVar                       10a
015300120212     D  CsrNam                       10a
015400120212     D  CsrLst                       10a
015500120212     D  CsrPos                        5i 0
015600111203     **-- UIM List entry:
015700111203     D LstEnt          Ds                  Qualified
015800140101     D  Option                        5i 0
015900140101     D  UsrPrf                       10a
016000140101     D  UsrCls                       10a
016100140101     D  GrpPrf                       10a
016200140101     D  NbrSupGrp                     5i 0
016300140101     D  SplCtl                        1a
016400140101     D  JobCtl                        1a
016500140101     D  AutSrc                        2a
016600140101     D  QueAut                       10a
016700140101     D  QueRead                       1a
016800140101     D  QueRAD                        1a
016900140101     D  QueMgt                        1a
017000140101     D  StrWtr                        1a
017100140101     D  AddSpl                        1a
017200140101     D  WrkWth                        1a
017300140101     D  QueOpr                        1a
017400140101     D  QueOpm                        1a
017500140101     D  SplCon                        1a
017600140101     D  SplOpr                        1a
017700060311
017800060311     **-- UIM exit program interfaces:
017900060327     **-- Parm interface:
018000060327     D UimExit         Ds            70    Qualified
018100060327     D  StcLvl                       10i 0
018200060327     D                                8a
018300060327     D  TypCall                      10i 0
018400060327     D  AppHdl                        8a
018500120208     **-- Function key - call:
018600120208     D Type1           Ds                  Qualified
018700120208     D  StcLvl                       10i 0
018800120208     D                                8a
018900120208     D  TypCall                      10i 0
019000120208     D  AppHdl                        8a
019100120208     D  PnlNam                       10a
019200120208     D  FncKey                       10i 0
019300060311
019400120208     **-- Retrieve user information:
019500120208     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
019600120208     D  RcvVar                    32767a          Options( *VarSize )
019700120208     D  RcvVarLen                    10i 0 Const
019800120208     D  FmtNam                       10a   Const
019900120208     D  UsrPrf                       10a   Const
020000120208     D  Error                     32767a          Options( *VarSize )
020100140420     **-- Retrieve output queue information:
020200140420     D RtvOutQueInf    Pr                  ExtPgm( 'QSPROUTQ' )
020300140420     D  RcvVar                    32767a          Options( *VarSize )
020400140420     D  RcvVarLen                    10i 0 Const
020500140420     D  FmtNam                        8a   Const
020600140420     D  OutQue_q                     20a   Const
020700140420     D  Error                     32767a          Options( *VarSize )
020800120208     **-- Get dialog variable:
020900120208     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
021000120208     D  AppHdl                        8a   Const
021100120208     D  VarBuf                    32767a          Options( *VarSize )
021200120208     D  VarBufLen                    10i 0 Const
021300120208     D  VarRcdNam                    10a   Const
021400120208     D  Error                     32767a          Options( *VarSize )
021500111203     **-- Get list entry:
021600111203     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
021700111203     D  AppHdl                        8a   Const
021800111203     D  VarBuf                    32767a   Const  Options( *VarSize )
021900111203     D  VarBufLen                    10i 0 Const
022000111203     D  VarRcdNam                    10a   Const
022100111203     D  LstNam                       10a   Const
022200111203     D  PosOpt                        4a   Const
022300111203     D  CpyOpt                        1a   Const
022400111203     D  SltCri                       20a   Const
022500111203     D  SltHdl                        4a   Const
022600111203     D  ExtOpt                        1a   Const
022700111203     D  LstEntHdl                     4a
022800111203     D  Error                     32767a          Options( *VarSize )
022900070804
023000120208     **-- Display long text:
023100120208     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
023200120208     D  LngTxt                    32767a   Const  Options( *VarSize )
023300120208     D  LngTxtLen                    10i 0 Const
023400120208     D  MsgId                         7a   Const
023500120208     D  MsgF                         20a   Const
023600120208     D  Error                     32767a   Const  Options( *VarSize )
023700060327     **-- Send program message:
023800060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
023900060327     D  MsgId                         7a   Const
024000060327     D  MsgFq                        20a   Const
024100060327     D  MsgDta                      128a   Const
024200060327     D  MsgDtaLen                    10i 0 Const
024300060327     D  MsgTyp                       10a   Const
024400060327     D  CalStkE                      10a   Const  Options( *VarSize )
024500060327     D  CalStkCtr                    10i 0 Const
024600060327     D  MsgKey                        4a
024700060327     D  Error                     32767a          Options( *VarSize )
024800060327     **-- Send escape message:
024900060327     D SndEscMsg       Pr            10i 0
025000060327     D  PxMsgId                       7a   Const
025100060327     D  PxMsgF                       10a   Const
025200060327     D  PxMsgDta                    512a   Const  Varying
025300051129
025400040722     **-- Entry parameters:
025500140101     D CBX971E         Pr
025600060327     D  PxUimExit                          LikeDs( UimExit )
025700051129     **
025800140101     D CBX971E         Pi
025900060327     D  PxUimExit                          LikeDs( UimExit )
026000040721
026100040724      /Free
026200041224
026300140101        If  PxUimExit.TypCall = 1;
026400120208          Type1 = PxUimExit;
026500120208
026600140420          Select;
026700140420          When  Type1.FncKey = 8;
026800140420            ExSr  DspQueAtr;
026900140420
027000140420          When  Type1.FncKey = 22;
027100120208
027200120208            GetDlgVar( Type1.AppHdl
027300120208                     : CsrRcd
027400120208                     : %Size( CsrRcd )
027500120208                     : 'CSRRCD'
027600120208                     : ERRC0100
027700120208                     );
027800120208
027900140101            If  CsrRcd.CsrEid = NO_ENT  Or  CsrRcd.CsrVar <> 'SUPGRP';
028000140101              SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );
028100140101
028200140101            Else;
028300140101              ExSr  RunCsrAct;
028400140101            EndIf;
028500140420          EndSl;
028600140101        EndIf;
028700040728
028800040605        Return;
028900111203
029000140101
029100120208        BegSr  RunCsrAct;
029200120208
029300120208          GetLstEnt( Type1.AppHdl
029400120208                   : LstEnt
029500120208                   : %Size( LstEnt )
029600120208                   : 'DTLRCD'
029700120208                   : 'DTLLST'
029800120208                   : 'HNDL'
029900120208                   : 'Y'
030000120208                   : *Blanks
030100120208                   : CsrRcd.CsrEid
030200120208                   : 'N'
030300120208                   : UIM.EntHdl
030400120208                   : ERRC0100
030500120208                   );
030600120208
030700120208          If  ERRC0100.BytAvl = *Zero;
030800120208
030900120208            RtvUsrInf( USRI0300
031000120208                     : %Size( USRI0300 )
031100120208                     : 'USRI0300'
031200120208                     : LstEnt.UsrPrf
031300120208                     : ERRC0100
031400120208                     );
031500120208
031600120208            If  ERRC0100.BytAvl = *Zero;
031700120212
031800120212              If  USRI0300.NbrSupGrp = *Zero;
031900120212                SupGrpLst.SupGrpLst(1) = '*NONE';
032000120212
032100120212              Else;
032200120212                SupGrpPrf = %Subst( USRI0300
032300120212                                  : USRI0300.OfsSupGrp + 1
032400120212                                  : USRI0300.NbrSupGrp * 10
032500120212                                  );
032600120212
032700120212                SupGrpLst.SupGrpLst = SupGrpPrf.SupGrpLst;
032800120212              EndIf;
032900120208
033000120208              DspLngTxt( %TrimR( SupGrpLst )
033100120208                       : %Len( %TrimR( SupGrpLst ))
033200120208                       : 'CBX0001'
033300140101                       : 'CBX971M   *LIBL'
033400120208                       : ERRC0100
033500120208                       );
033600120208
033700120208            EndIf;
033800120208          EndIf;
033900120208
034000120208        EndSr;
034100140420
034200140420        BegSr  DspQueAtr;
034300140420
034400140420          GetDlgVar( Type1.AppHdl
034500140420                   : HdrRcd
034600140420                   : %Size( HdrRcd )
034700140420                   : 'HDRRCD'
034800140420                   : ERRC0100
034900140420                   );
035000140420
035100140420          If  ERRC0100.BytAvl = *Zero;
035200140420
035300140420            RtvOutQueInf( OUTQ0100
035400140420                        : %Size( OUTQ0100 )
035500140420                        : 'OUTQ0100'
035600140420                        : HdrRcd.OutQue_q
035700140420                        : ERRC0100
035800140420                        );
035900140420
036000140420            If  ERRC0100.BytAvl = *Zero;
036100140420
036200140420              MsgStr = 'DSPDTA(' + %Trim( OUTQ0100.DspAnyF ) + ')' + BLANKS +
036300140420                       'OPRCTL(' + %Trim( OUTQ0100.OprCtl )  + ')' + BLANKS +
036400140420                       'AUTCHK(' + %Trim( OUTQ0100.AutChk )  + ')';
036500140420
036600140420              DspLngTxt( MsgStr
036700140420                       : %Len( MsgStr )
036800140420                       : 'CBX0002'
036900140420                       : 'CBX971M   *LIBL'
037000140420                       : ERRC0100
037100140420                       );
037200140420
037300140420            EndIf;
037400140420          EndIf;
037500140420
037600140420        EndSr;
037700120212
037800051126      /End-Free
037900060327
038000060327     **-- Send escape message:
038100060327     P SndEscMsg       B
038200060327     D                 Pi            10i 0
038300060327     D  PxMsgId                       7a   Const
038400060327     D  PxMsgF                       10a   Const
038500060327     D  PxMsgDta                    512a   Const  Varying
038600060327     **
038700060327     D MsgKey          s              4a
038800060327
038900060327      /Free
039000060327
039100060327        SndPgmMsg( PxMsgId
039200060327                 : PxMsgF + '*LIBL'
039300060327                 : PxMsgDta
039400060327                 : %Len( PxMsgDta )
039500060327                 : '*ESCAPE'
039600060327                 : '*PGMBDY'
039700060327                 : 1
039800060327                 : MsgKey
039900060327                 : ERRC0100
040000060327                 );
040100060327
040200060327        If  ERRC0100.BytAvl > *Zero;
040300060327          Return  -1;
040400060327
040500060327        Else;
040600060327          Return   0;
040700060327        EndIf;
040800060327
040900060327      /End-Free
041000060327
041100060327     P SndEscMsg       E
