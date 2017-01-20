     **
     **  Program . . : CBX963
     **  Description : Display Server Share - CPP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **  Programmer's notes:
     **    Activation group *NEW to avoid risk of recursive calls and
     **    ensure resource scoping and clean-up.
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX963 )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX963 )
     **               Module( CBX963 )
     **               ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     **-- Global variables:
     D Idx             s             10i 0
     D SysDts          s               z
     D Path            s           1024a   Varying

     **-- File extension table:
     D FilExtTbl       Ds                  Qualified
     D  TblEnt                             Dim( 128 )
     D   ExtLen                      10i 0 Overlay( TblEnt: 1 )
     D   FilExt                      46a   Overlay( TblEnt: 5 )
     **-- List information:
     D ZLSL0101        Ds         32767    Qualified
     D  EntLen                       10i 0
     D  Share                        12a
     D  DevTyp                       10i 0
     D  Permis                       10i 0
     D  MaxUsr                       10i 0
     D  CurUsr                       10i 0
     D  SpfTyp                       10i 0
     D  OfsPthNam                    10i 0
     D  LenPthNam                    10i 0
     D  OutQue_q                     20a
     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
     D  PrtDrv                       50a
     D  TxtDsc                       50a
     D  PrtFil_q                     20a
     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
     D  TxtCcsId                     10i 0
     D  OfsExtTbl                    10i 0
     D  NbrTblEnt                    10i 0
     D  EnbTxtCnv                     1a
     D  Publish                       1a
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  RcdLen                       10i 0
     D  InfLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D                               34a

     **-- UIM constants:
     D PNLGRP_Q        c                   'CBX963P   *LIBL     '
     D PNLGRP          c                   'CBX963P   '
     D SCP_AUT_RCL     c                   -1
     D RDS_OPT_INZ     c                   'N'
     D PRM_IFC_0       c                   0
     D CLO_NORM        c                   'M'
     D FNC_EXIT        c                   -4
     D FNC_CNL         c                   -8
     D KEY_F05         c                   5
     D RTN_ENTER       c                   500
     D INC_EXP         c                   'Y'
     D CPY_VAR         c                   'Y'
     D CPY_VAR_NO      c                   'N'
     D HLP_WDW         c                   'N'
     D POS_TOP         c                   'TOP'
     D POS_BOT         c                   'BOT'
     D LIST_COMP       c                   'ALL'
     D LIST_SAME       c                   'SAME'
     D EXIT_SAME       c                   '*SAME'
     D DSPA_SAME       c                   'SAME'
     D TRIM_SAME       c                   'S'
     **
     D APP_PRTF        c                   'QPRINT    *LIBL'
     D ODP_SHR         c                   'N'
     D SPLF_NAM        c                   'PDSPSVRSHR'
     D SPLF_USRDTA     c                   'DSPSVRSHR'
     D EJECT_NO        c                   'N'

     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  AppHdl                        8a
     D  FncRqs                       10i 0 Inz
     **-- UIM Panel exit program record:
     D ExpRcd          Ds                  Qualified
     D  ExitPg                       20a   Inz( 'CBX963E   *LIBL' )
     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified  Inz
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  Share                        12a
     D  DevTyp                        1s 0
     D  TxtDsc                       50a
     **-- UIM Detail record:
     D DtlRcd          Ds                  Qualified
     D  Permis                        1s 0
     D  MaxUsr                       10i 0
     D  CurUsr                       10i 0
     D  SpfTyp                        1s 0
     D  Path                       1000a
     D  Path_s                      256a
     D  OutQue_q                     20a
     D  PrtDrv                       50a
     D  PrtFil_q                     20a
     D  EnbTxtCnv                     1a
     D  PubPrtShr                     1a
     D  NbrFilExt                     3s 0
     D  FilExt                     1000a

     **-- Open list of server information:
     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       64a
     D  Format                        8a   Const
     D  InfQual                      15a   Const
     D  Error                     32767a          Options( *VarSize )
     D  SsnUsr                       10a   Const  Options( *NoPass )
     D  SsnId                        20u 0 Const  Options( *NoPass )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNamQ                      26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a         Options( *NoPass: *VarSize )
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
     **-- Close application:
     D CloApp          Pr                  ExtPgm( 'QUICLOA' )
     D  AppHdl                        8a   Const
     D  CloOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Get job type:
     D GetJobTyp       Pr             1a
     **-- Format file extension:
     D FmtFilExt       Pr          1000a   Varying
     D  PxFilExtTbl                        LikeDs( FilExtTbl )
     D                                     Const
     D  PxNbrFilEnt                  10i 0 Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Program entry:
     D CBX963          Pr
     D  PxShare                      12a
     D  PxOutOpt                      3a
     **
     D CBX963          Pi
     D  PxShare                      12a
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

        ExSr  BldShrDsp;
        ExSr  BldHdrRcd;

        If  PxOutOpt = 'DSP'  And  GetJobTyp() = 'I';
          ExSr  DspLst;
        Else;
          ExSr  WrtLst;
        EndIf;

        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );

        *InLr = *On;
        Return;


        BegSr  BldShrDsp;

          LstSvrInf( ZLSL0101
                   : %Len( ZLSL0101 )
                   : LstInf
                   : 'ZLSL0101'
                   : PxShare
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrRtn = 1;
            ExSr  PutDtlRcd;
          EndIf;

        EndSr;

        BegSr  PutDtlRcd;

          Path = %Subst( ZLSL0101
                       : ZLSL0101.OfsPthNam + 1
                       : ZLSL0101.LenPthNam
                       );

          FilExtTbl = %Subst( ZLSL0101
                            : ZLSL0101.OfsExtTbl + 1
                            : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
                            );

          DtlRcd.Permis      = ZLSL0101.Permis;
          DtlRcd.MaxUsr      = ZLSL0101.MaxUsr;
          DtlRcd.CurUsr      = ZLSL0101.CurUsr;
          DtlRcd.SpfTyp      = ZLSL0101.SpfTyp;
          DtlRcd.Path        = Path;
          DtlRcd.Path_s      = Path;
          DtlRcd.OutQue_q    = ZLSL0101.OutQue_q;
          DtlRcd.PrtDrv      = ZLSL0101.PrtDrv;
          DtlRcd.PrtFil_q    = ZLSL0101.PrtFil_q;
          DtlRcd.NbrFilExt   = ZLSL0101.NbrTblEnt;
          DtlRcd.EnbTxtCnv   = ZLSL0101.EnbTxtCnv;
          DtlRcd.PubPrtShr   = ZLSL0101.Publish;
          DtlRcd.FilExt      = FmtFilExt( FilExtTbl: ZLSL0101.NbrTblEnt );

          PutDlgVar( UIM.AppHdl: DtlRcd: %Size( DtlRcd ): 'DTLRCD': ERRC0100 );

        EndSr;

        BegSr  DspLst;

          DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;

            DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );

            Select;
            When  ERRC0100.BytAvl > *Zero;
              ExSr  EscApiErr;

            When  UIM.FncRqs = RTN_ENTER;
              Leave;

            When  UIM.FncRqs = KEY_F05;
              ExSr  BldShrDsp;
            EndSl;

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
                : 'PRTDTL'
                : EJECT_NO
                : ERRC0100
                );

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  BldHdrRcd;

          SysDts = %Timestamp();

          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
          HdrRcd.TimZon = '*SYS';

          HdrRcd.Share  = ZLSL0101.Share;
          HdrRcd.DevTyp = ZLSL0101.DevTyp;
          HdrRcd.TxtDsc = ZLSL0101.TxtDsc;

          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

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
     **-- Format file extension:  --------------------------------------------**
     P FmtFilExt       B
     D                 Pi          1000a   Varying
     D  PxFilExtTbl                        LikeDs( FilExtTbl )
     D                                     Const
     D  PxNbrFilEnt                  10i 0 Const

     D Idx             s             10i 0
     D FilExt          s             46a   Varying
     D RtnStr          s           1000a   Varying

      /Free

          For  Idx = 1  to  PxNbrFilEnt;
            FilExt = %Subst( PxFilExtTbl.FilExt(Idx)
                           : 1
                           : PxFilExtTbl.ExtLen(Idx)
                           );

            Select;
            When  FilExt = '*';
              RtnStr += '*ALL';

            When  FilExt = '.';
              RtnStr += '*NOEXT';

            Other;
              RtnStr += '''' + FilExt + ''' ';
            EndSl;
          EndFor;

          Return  %TrimR( RtnStr );

      /End-Free

     P FmtFilExt       E
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

     **
     P SndCmpMsg       E
