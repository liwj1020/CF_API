     **
     **  Program . . : CBX971
     **  Description : Work with Output Queue Authorities - UIM Exit Program
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX971E )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX971E )
     **               Module( CBX971E )
     **               ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a

     **-- Global constants:
     D NULL            c                   ''
     D NO_ENT          c                   x'00000000'
     D RES_OK          c                   0
     **-- Global variables:
     D MsgKey          s              4a
     D MsgStr          s            512a   Varying
     D Idx             s             10i 0
     D BLANKS          s             50a

     **-- Qualified object name:
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a
     **-- Supplemental groups:
     D SupGrpPrf       Ds                  Qualified
     D  SupGrpLst                    10a   Dim( 15 )
     **-- Supplemental groups list:
     D SupGrpLst       Ds                  Qualified
     D  SupGrpLst                    11a   Dim( 15 )

     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  OutQue_q                     20a
     D  WrkUsr                       10a
     D  PosUsr                       10a
     D  DspDta                       10a
     D  OprCtl                       10a
     D  AutChk                       10a
     D  QueOwn                       10a
     D  PubAut                       10a
     D  QueAutL                      10a
     **-- User information:
     D USRI0300        Ds         10240    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PrvSgoDts                    13a   Overlay( USRI0300:  19 )
     D   PrvSgoDat                    7a   Overlay( USRI0300:  19 )
     D   PrvSgoTim                    6a   Overlay( USRI0300:  26 )
     D  InvSgo                       10i 0 Overlay( USRI0300:  33 )
     D  PrfSts                       10a   Overlay( USRI0300:  37 )
     D  PwdChgDat                     8a   Overlay( USRI0300:  47 )
     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
     D  PwdExpItv                    10i 0 Overlay( USRI0300:  57 )
     D  PwdExpDat                     8a   Overlay( USRI0300:  61 )
     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
     D  UsrCls                       10a   Overlay( USRI0300:  74 )
     D  SpcAut                       15a   Overlay( USRI0300:  84 )
     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
     D  Owner                        10a   Overlay( USRI0300: 109 )
     D  GrpAut                       10a   Overlay( USRI0300: 119 )
     D  LmtCap                       10a   Overlay( USRI0300: 189 )
     D  TxtDsc                       50a   Overlay( USRI0300: 199 )
     D  ObjAudVal                    10a   Overlay( USRI0300: 501 )
     D  UsrAudVal                    64a   Overlay( USRI0300: 511 )
     D  GrpAutTyp                    10a   Overlay( USRI0300: 575 )
     D  OfsSupGrp                    10i 0 Overlay( USRI0300: 585 )
     D  NbrSupGrp                    10i 0 Overlay( USRI0300: 589 )
     D  GrpMbrI                       1a   Overlay( USRI0300: 633 )
     D  DigCerI                       1a   Overlay( USRI0300: 634 )
     D  LocPwdMgt                     1a   Overlay( USRI0300: 661 )
     **-- Output queue information:
     D OUTQ0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OutQue_q                     20a
     D   OutQueNam                   10a   Overlay( OutQue_q: 1 )
     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
     D  FilOrd                       10a
     D  DspAnyF                      10a
     D  JobSep                       10i 0
     D  OprCtl                       10a
     D  DtaQueNam                    10a
     D  DtaQueLib                    10a
     D  AutChk                       10a
     D  NbrFil                       10i 0
     D  OutQueSts                    10a
     D  WtrJobNam                    10a
     D  WtrJobUsr                    10a
     D  WtrJobNbr                     6a
     D  WtrJobSts                    10a
     D  PrtDevNam                    10a
     D  OutQueTxt                    50a
     D                                2a
     D  NbrSpfPag                    10i 0
     D  NbrWtrStr                    10i 0
     D  WtrAutStr                    10i 0

     **-- UIM constants:
     D RDS_OPT_INZ     c                   'N'
     D POS_TOP         c                   'TOP'
     D CPY_VAR         c                   'Y'
     D INC_EXP         c                   'Y'
     D RMV_LST_ADD     c                   'L'
     D LIST_COMP       c                   'ALL'
     D LIST_SAME       c                   'SAME'
     D EXIT_SAME       c                   '*SAME'
     D TRIM_SAME       c                   'S'
     D KEY_ENTER       c                   26
     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  EntHdl                        4a
     D  LstPos                        4a
     D  FncRqs                       10i 0
     D  LstHdl                        4a
     D  EntLocOpt2                    4a

     **-- UIM API return structures:
     **-- Cursor record:
     D CsrRcd          Ds                  Qualified
     D  CsrEid                        4a
     D  CsrVar                       10a
     D  CsrNam                       10a
     D  CsrLst                       10a
     D  CsrPos                        5i 0
     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  UsrPrf                       10a
     D  UsrCls                       10a
     D  GrpPrf                       10a
     D  NbrSupGrp                     5i 0
     D  SplCtl                        1a
     D  JobCtl                        1a
     D  AutSrc                        2a
     D  QueAut                       10a
     D  QueRead                       1a
     D  QueRAD                        1a
     D  QueMgt                        1a
     D  StrWtr                        1a
     D  AddSpl                        1a
     D  WrkWth                        1a
     D  QueOpr                        1a
     D  QueOpm                        1a
     D  SplCon                        1a
     D  SplOpr                        1a

     **-- UIM exit program interfaces:
     **-- Parm interface:
     D UimExit         Ds            70    Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     **-- Function key - call:
     D Type1           Ds                  Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     D  PnlNam                       10a
     D  FncKey                       10i 0

     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve output queue information:
     D RtvOutQueInf    Pr                  ExtPgm( 'QSPROUTQ' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  OutQue_q                     20a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Get dialog variable:
     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a          Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  PosOpt                        4a   Const
     D  CpyOpt                        1a   Const
     D  SltCri                       20a   Const
     D  SltHdl                        4a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )

     **-- Display long text:
     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
     D  LngTxt                    32767a   Const  Options( *VarSize )
     D  LngTxtLen                    10i 0 Const
     D  MsgId                         7a   Const
     D  MsgF                         20a   Const
     D  Error                     32767a   Const  Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX971E         Pr
     D  PxUimExit                          LikeDs( UimExit )
     **
     D CBX971E         Pi
     D  PxUimExit                          LikeDs( UimExit )

      /Free

        If  PxUimExit.TypCall = 1;
          Type1 = PxUimExit;

          Select;
          When  Type1.FncKey = 8;
            ExSr  DspQueAtr;

          When  Type1.FncKey = 22;

            GetDlgVar( Type1.AppHdl
                     : CsrRcd
                     : %Size( CsrRcd )
                     : 'CSRRCD'
                     : ERRC0100
                     );

            If  CsrRcd.CsrEid = NO_ENT  Or  CsrRcd.CsrVar <> 'SUPGRP';
              SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );

            Else;
              ExSr  RunCsrAct;
            EndIf;
          EndSl;
        EndIf;

        Return;


        BegSr  RunCsrAct;

          GetLstEnt( Type1.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'HNDL'
                   : 'Y'
                   : *Blanks
                   : CsrRcd.CsrEid
                   : 'N'
                   : UIM.EntHdl
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            RtvUsrInf( USRI0300
                     : %Size( USRI0300 )
                     : 'USRI0300'
                     : LstEnt.UsrPrf
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;

              If  USRI0300.NbrSupGrp = *Zero;
                SupGrpLst.SupGrpLst(1) = '*NONE';

              Else;
                SupGrpPrf = %Subst( USRI0300
                                  : USRI0300.OfsSupGrp + 1
                                  : USRI0300.NbrSupGrp * 10
                                  );

                SupGrpLst.SupGrpLst = SupGrpPrf.SupGrpLst;
              EndIf;

              DspLngTxt( %TrimR( SupGrpLst )
                       : %Len( %TrimR( SupGrpLst ))
                       : 'CBX0001'
                       : 'CBX971M   *LIBL'
                       : ERRC0100
                       );

            EndIf;
          EndIf;

        EndSr;

        BegSr  DspQueAtr;

          GetDlgVar( Type1.AppHdl
                   : HdrRcd
                   : %Size( HdrRcd )
                   : 'HDRRCD'
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            RtvOutQueInf( OUTQ0100
                        : %Size( OUTQ0100 )
                        : 'OUTQ0100'
                        : HdrRcd.OutQue_q
                        : ERRC0100
                        );

            If  ERRC0100.BytAvl = *Zero;

              MsgStr = 'DSPDTA(' + %Trim( OUTQ0100.DspAnyF ) + ')' + BLANKS +
                       'OPRCTL(' + %Trim( OUTQ0100.OprCtl )  + ')' + BLANKS +
                       'AUTCHK(' + %Trim( OUTQ0100.AutChk )  + ')';

              DspLngTxt( MsgStr
                       : %Len( MsgStr )
                       : 'CBX0002'
                       : 'CBX971M   *LIBL'
                       : ERRC0100
                       );

            EndIf;
          EndIf;

        EndSr;

      /End-Free

     **-- Send escape message:
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
