     **
     **  Program . . : CBX958
     **  Description : Work with Subsystem Activity - CPP
     **  Author  . . : Carsten Flensburg
     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( CBX958 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX958 )
     **                Module( CBX958 )
     **                ActGrp( *NEW )
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     **
     D BIN_SGN         c                   0
     D NUM_ZON         c                   2
     D CHAR_NLS        c                   4
     D SORT_ASC        c                   '1'
     D NULL            c                   ''
     **-- UIM constants:
     D PNLGRP_Q        c                   'CBX958P   *LIBL     '
     D PNLGRP          c                   'CBX958P   '
     D SCP_AUT_RCL     c                   -1
     D RDS_OPT_INZ     c                   'N'
     D PRM_IFC_0       c                   0
     D CLO_NORM        c                   'M'
     D FNC_EXIT        c                   -4
     D FNC_CNL         c                   -8
     D KEY_F05         c                   5
     D RTN_ENTER       c                   500
     D HLP_WDW         c                   'N'
     D POS_TOP         c                   'TOP'
     D POS_BOT         c                   'BOT'
     D LIST_COMP       c                   'ALL'
     D LIST_SAME       c                   'SAME'
     D EXIT_SAME       c                   '*SAME'
     D TRIM_SAME       c                   'S'
     **
     D APP_PRTF        c                   'QPRINT    *LIBL'
     D ODP_SHR         c                   'N'
     D SPLF_NAM        c                   'PNETUSR'
     D SPLF_USRDTA     c                   'WRKNETUSR'
     D EJECT_NO        c                   'N'

     **-- Global variables:
     D Idx             s             10i 0
     D SysDts          s               z
     D WrkUsr          s             10a

     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  AppHdl                        8a
     D  LstHdl                        4a
     D  EntHdl                        4a
     D  FncRqs                       10i 0
     D  EntLocOpt                     4a
     D  LstPos                        4a
     **-- List attributes structure:
     D LstAtr          Ds                  Qualified
     D  LstCon                        4a
     D  ExtPgmVar                    10a
     D  DspPos                        4a
     D  AlwTrim                       1a

     **-- UIM Panel exit prgram record:
     D ExpRcd          Ds                  Qualified
     D  ExitPg                       20a   Inz( 'CBX958E   *LIBL' )
     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  WrkUsr                       10a
     D  WrkSts                       10a
     D  PosUsr                       10a
     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  NetUsr                       10a
     D  UsrSts                       10a
     D  UsrTxt                       50a
     **
     D LstEntPos       Ds                  LikeDs( LstEnt )

     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  RcdLen                       10i 0
     D  InfLenRtn                    10i 0
     D  InfCmp                        1a
     D  Dts                          13a
     D                               34a
     **-- API parameters:
     D ZLSL0900        Ds                  Qualified
     D  DsaNetUsr                    10a   Dim( 5120 )

     **-- Open list of server information:
     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       64a
     D  FmtNam                       10a   Const
     D  InfQual                      15a   Const
     D  Error                     32767a          Options( *VarSize )
     D  SsnUsr                       10a   Const  Options( *NoPass )
     D  SsnId                        20i 0 Const  Options( *NoPass )
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
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNamQ                      26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a         Options( *NoPass: *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Open display application:
     D OpnDspApp       Pr                  ExtPgm( 'QUIOPNDA' )
     D  AppHdl                        8a
     D  PnlGrp_q                     20a   Const
     D  AppScp                       10i 0 Const
     D  ExtPrmIfc                    10i 0 Const
     D  FulScrHlp                     1a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Add print application:
     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
     D  AppHdl                        8a   Const
     D  PrtDevF_q                    20a   Const
     D  AltFilNam                    10a   Const
     D  ShrOpnDtaPth                  1a   Const
     D  UsrDta                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Open print application:
     D OpnPrtApp       Pr                  ExtPgm( 'QUIOPNPA' )
     D  AppHdl                        8a
     D  PnlGrp_q                     20a   Const
     D  AppScp                       10i 0 Const
     D  ExtPrmIfc                    10i 0 Const
     D  PrtDevF_q                    20a   Const
     D  AltFilNam                    10a   Const
     D  ShrOpnDtaPth                  1a   Const
     D  UsrDta                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Display panel:
     D DspPnl          Pr                  ExtPgm( 'QUIDSPP' )
     D  AppHdl                        8a   Const
     D  FncRqs                       10i 0
     D  PnlNam                       10a   Const
     D  ReDspOpt                      1a   Const
     D  Error                     32767a          Options( *VarSize )
     D  UsrTsk                        1a   Const  Options( *NoPass )
     D  CalStkCnt                    10i 0 Const  Options( *NoPass )
     D  CalMsgQue                   256a   Const  Options( *NoPass: *VarSize )
     D  MsgKey                        4a   Const  Options( *NoPass )
     D  CsrPosOpt                     1a   Const  Options( *NoPass )
     D  FinLstEnt                     4a   Const  Options( *NoPass )
     D  ErrLstEnt                     4a   Const  Options( *NoPass )
     D  WaitTim                      10i 0 Const  Options( *NoPass )
     D  CalMsgQueLen                 10i 0 Const  Options( *NoPass )
     D  CalQlf                       20a   Const  Options( *NoPass )
     **-- Print panel:
     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
     D  AppHdl                        8a   Const
     D  PrtPnlNam                    10a   Const
     D  EjtOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Put dialog variable:
     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Get dialog variable:
     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a          Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Add list entry:
     D AddLstEnt       Pr                  ExtPgm( 'QUIADDLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  EntLocOpt                     4a   Const
     D  LstEntHdl                     4a
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
     **-- Retrieve list attributes:
     D RtvLstAtr       Pr                  ExtPgm( 'QUIRTVLA' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  AtrRcv                    32767a          Options( *VarSize )
     D  AtrRcvLen                    10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **-- Set list attributes:
     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  LstCon                        4a   Const
     D  ExtPgmVar                    10a   Const
     D  DspPos                        4a   Const
     D  AlwTrim                       1a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Delete list:
     D DltLst          Pr                  ExtPgm( 'QUIDLTL' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Close application:
     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
     D  AppHdl                        8a   Const
     D  CloOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Get job type:
     D GetJobTyp       Pr             1a
     **-- Get user text:
     D GetUsrTxt       Pr            50a   Varying
     D  PxUsrPrf                     10a   Value
     **-- Check generic string:
     D ChkGenStr       Pr              n
     D  PxCmpStr                    256a   Const  Varying
     D  PxChkStr                    256a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     D CBX958          Pr
     D  PxNetUsr                     10a
     D  PxStatus                     10a
     D  PxOutOpt                      3a
     **
     D CBX958          Pi
     D  PxNetUsr                     10a
     D  PxStatus                     10a
     D  PxOutOpt                      3a

      /Free

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';

          OpnDspApp( UIM.AppHdl
                   : PNLGRP_Q
                   : SCP_AUT_RCL
                   : PRM_IFC_0
                   : HLP_WDW
                   : ERRC0100
                   );
        Else;
          OpnPrtApp( UIM.AppHdl
                   : PNLGRP_Q
                   : SCP_AUT_RCL
                   : PRM_IFC_0
                   : APP_PRTF
                   : SPLF_NAM
                   : ODP_SHR
                   : SPLF_USRDTA
                   : ERRC0100
                   );
        EndIf;

        If  ERRC0100.BytAvl > *Zero;
          ExSr  EscApiErr;
        EndIf;

        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );

        ExSr  BldHdrRcd;
        ExSr  BldUsrLst;

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
          ExSr  DspLst;
        Else;
          ExSr  WrtLst;
        EndIf;

        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );

        *InLr = *On;
        Return;


        BegSr  DspLst;

          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;

            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );

            If  ERRC0100.BytAvl > *Zero;
              ExSr  EscApiErr;
            EndIf;

            GetDlgVar( UIM.AppHdl
                     : HdrRcd
                     : %Size( HdrRcd )
                     : 'HDRRCD'
                     : ERRC0100
                     );

            Select;
            When  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
              ExSr  GetLstPos;
              ExSr  DltUsrLst;

            When  WrkUsr <> HdrRcd.WrkUsr;
              ExSr  DltUsrLst;
            EndSl;

            Select;
            When  UIM.FncRqs = KEY_F05;
              ExSr  RstHdrRcd;
              ExSr  BldUsrLst;
              ExSr  SetLstPos;

            When  WrkUsr <> HdrRcd.WrkUsr;
              WrkUsr = HdrRcd.WrkUsr;

              ExSr  BldUsrLst;
            EndSl;

            If  UIM.FncRqs = RTN_ENTER  And
                UIM.EntLocOpt = 'NEXT'  And
                HdrRcd.PosUsr > *Blanks;

              ExSr  FndLstPos;
            EndIf;

            ExSr  BldHdrRcd;
          EndDo;

        EndSr;

        BegSr  WrtLst;

          PrtPnl( UIM.AppHdl
                : 'PRTHDR'
                : EJECT_NO
                : ERRC0100
                );

          PrtPnl( UIM.AppHdl
                : 'PRTLST'
                : EJECT_NO
                : ERRC0100
                );

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  BldUsrLst;

          UIM.EntLocOpt = 'FRST';

          LstSvrInf( ZLSL0900
                   : %Size( ZLSL0900 )
                   : LstInf
                   : 'ZLSL0900'
                   : *Blank
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            For Idx = 1  to LstInf.RcdNbrTot;
              ExSr  PrcLstEnt;
            EndFor;
          EndIf;

          SetLstAtr( UIM.AppHdl
                   : 'DTLLST'
                   : LIST_COMP
                   : EXIT_SAME
                   : POS_TOP
                   : TRIM_SAME
                   : ERRC0100
                   );

        EndSr;

        BegSr  PrcLstEnt;

          LstEnt.NetUsr = ZLSL0900.DsaNetUsr(Idx);

          If  HdrRcd.WrkUsr = '*ALL'  Or
              HdrRcd.WrkUsr = LstEnt.NetUsr  Or
              ChkGenStr( HdrRcd.WrkUsr: LstEnt.NetUsr ) = *On;

            LstEnt.Option = *Zero;
            LstEnt.UsrSts = '*DISABLED';
            LstEnt.UsrTxt = GetUsrTxt( LstEnt.NetUsr );

            AddLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : 'DTLRCD'
                     : 'DTLLST'
                     : UIM.EntLocOpt
                     : UIM.LstHdl
                     : ERRC0100
                     );

            UIM.EntLocOpt = 'NEXT';
          EndIf;

        EndSr;

        BegSr  GetLstPos;

          RtvLstAtr( UIM.AppHdl: 'DTLLST': LstAtr: %Size( LstAtr ): ERRC0100 );

          If  LstAtr.DspPos <> 'TOP';

            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : 'DTLRCD'
                     : 'DTLLST'
                     : 'HNDL'
                     : 'Y'
                     : *Blanks
                     : LstAtr.DspPos
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            LstEntPos = LstEnt;
          EndIf;

        EndSr;

        BegSr  SetLstPos;

          If  LstAtr.DspPos <> 'TOP';

            LstEnt = LstEntPos;

            PutDlgVar( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : 'DTLRCD'
                     : ERRC0100
                     );

            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'FSLT'
                     : 'N'
                     : 'EQ        NETUSR'
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;

              SetLstAtr( UIM.AppHdl
                       : 'DTLLST'
                       : LIST_SAME
                       : EXIT_SAME
                       : UIM.EntHdl
                       : TRIM_SAME
                       : ERRC0100
                       );

            EndIf;
          EndIf;

        EndSr;

        BegSr  FndLstPos;

          LstEnt.NetUsr = HdrRcd.PosUsr;

          PutDlgVar( UIM.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : ERRC0100
                   );

          GetLstEnt( UIM.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'FSLT'
                   : 'Y'
                   : 'GE        NETUSR'
                   : *Blanks
                   : 'N'
                   : UIM.EntHdl
                   : ERRC0100
                   );

          Select;
          When  ERRC0100.BytAvl > *Zero;
            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'LAST'
                     : 'N'
                     : *Blanks
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

          When  %Scan( %Trim( HdrRcd.PosUsr ): LstEnt.NetUsr ) <> 1;
            GetLstEnt( UIM.AppHdl
                     : LstEnt
                     : %Size( LstEnt )
                     : '*NONE'
                     : 'DTLLST'
                     : 'PREV'
                     : 'N'
                     : *Blanks
                     : *Blanks
                     : 'N'
                     : UIM.EntHdl
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl > *Zero;
              GetLstEnt( UIM.AppHdl
                       : LstEnt
                       : %Size( LstEnt )
                       : '*NONE'
                       : 'DTLLST'
                       : 'FRST'
                       : 'N'
                       : *Blanks
                       : *Blanks
                       : 'N'
                       : UIM.EntHdl
                       : ERRC0100
                       );
            EndIf;
          EndSl;

          If  ERRC0100.BytAvl = *Zero;

            SetLstAtr( UIM.AppHdl
                     : 'DTLLST'
                     : LIST_SAME
                     : EXIT_SAME
                     : UIM.EntHdl
                     : TRIM_SAME
                     : ERRC0100
                     );

          EndIf;

          HdrRcd.PosUsr = *Blanks;

        EndSr;

        BegSr  BldHdrRcd;

          SysDts = %Timestamp();

          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
          HdrRcd.TimZon = '*SYS';

          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

        EndSr;

        BegSr  RstHdrRcd;

          HdrRcd.WrkUsr = WrkUsr;
          HdrRcd.PosUsr = *Blanks;

        EndSr;

        BegSr  *InzSr;

          HdrRcd.WrkUsr = PxNetUsr;
          HdrRcd.WrkSts = PxStatus;
          HdrRcd.PosUsr = *Blanks;

          WrkUsr = HdrRcd.WrkUsr;

        EndSr;

        BegSr  DltUsrLst;

          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );

        EndSr;

        BegSr  EscApiErr;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );

        EndSr;

      /End-Free

     **-- Get job type:
     P GetJobTyp       B
     D                 Pi             1a

     D JOBI0400        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  JobNam                       10a
     D  UsrNam                       10a
     D  JobNbr                        6a
     D  JobIntId                     16a
     D  JobSts                       10a
     D  JobTyp                        1a
     D  JobSubTyp                     1a

      /Free

        RtvJobInf( JOBI0400
                 : %Size( JOBI0400 )
                 : 'JOBI0400'
                 : '*'
                 : *Blank
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blank;

        Else;
          Return  JOBI0400.JobTyp;
        EndIf;

      /End-Free

     P GetJobTyp       E
     **-- Get user text:
     P GetUsrTxt       B
     D                 Pi            50a   Varying
     D  PxUsrPrf                     10a   Value
     **
     D USRI0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  UsrTxt                       50a   Overlay( USRI0300: 199 )

      /Free

        RtvUsrInf( USRI0300
                 : %Size( USRI0300 )
                 : 'USRI0300'
                 : PxUsrPrf
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  NULL;

        Else;
          Return  %Trim( USRI0300.UsrTxt );
        EndIf;

      /End-Free

     P GetUsrTxt       E
     **-- Check generic string:
     P ChkGenStr       B
     D                 Pi              n
     D  PxCmpStr                    256a   Const  Varying
     D  PxChkStr                    256a   Const  Varying

     D  ChkLen         s             10i 0

      /Free

        ChkLen =  %Scan( '*': PxCmpStr ) - 1;

        If  ChkLen > *Zero;
          Return  %Scan( %Subst( PxCmpStr: 1: ChkLen ): PxChkStr ) = 1;

        Else;
          Return  *Off;
        EndIf;

      /End-Free

     P ChkGenStr       E
     **-- Send completion message:
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     P SndCmpMsg       E
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
