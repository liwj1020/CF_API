     **
     **  Program . . : CBX967
     **  Description : Display Subsystem Job Queues - CPP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( CBX967 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX967 )
     **                Module( CBX967 )
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
     **-- UIM constants:
     D PNLGRP_Q        c                   'CBX967P   *LIBL     '
     D PNLGRP          c                   'CBX967P   '
     D SCP_AUT_RCL     c                   -1
     D RDS_OPT_INZ     c                   'N'
     D PRM_IFC_0       c                   0
     D CLO_NORM        c                   'M'
     D FNC_EXIT        c                   -4
     D FNC_CNL         c                   -8
     D KEY_F05         c                   5
     D KEY_F24         c                   24
     D RTN_ENTER       c                   500
     D HLP_WDW         c                   'N'
     D POS_TOP         c                   'TOP'
     D POS_BOT         c                   'BOT'
     D LIST_COMP       c                   'ALL'
     D LIST_SAME       c                   'SAME'
     D EXIT_SAME       c                   '*SAME'
     D TRIM_SAME       c                   'S'

     **-- Global variables:
     D SysDts          s               z
     **
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a

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

     **-- UIM Panel exit program record:
     D ExpRcd          Ds                  Qualified
     D  ExitPg                       20a   Inz( 'CBX967E   *LIBL' )
     **-- UIM Panel header record:
     D HdrRcd          Ds                  Qualified
     D  SysDat                        7a
     D  SysTim                        6a
     D  TimZon                       10a
     D  SbsNam                       10a
     D  SbsLib                       10a
     D  SbsSts                       10a
     D  MaxActJob                     7s 0
     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  SeqNbr                        4s 0
     D  JobQue_q                     20a
     D   JobQue                      10a   Overlay( JobQue_q: 1 )
     D   JobQueLib                   10a   Overlay( JobQue_q: *Next )
     D  JobQueSts                     1a
     D  MaxAct                        7s 0
     D  CurAct                        7s 0
     D  NbrJobOnQue                   7s 0
     D  QueDsc                       50a
     D  MaxPty1                       2s 0
     D  MaxPty2                       2s 0
     D  MaxPty3                       2s 0
     D  MaxPty4                       2s 0
     D  MaxPty5                       2s 0
     D  MaxPty6                       2s 0
     D  MaxPty7                       2s 0
     D  MaxPty8                       2s 0
     D  MaxPty9                       2s 0
     **
     D LstEntPos       Ds                  LikeDs( LstEnt )

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0 Inz( 1 )
     D  NbrFldRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 10 )

     **-- Subsystem information:
     D SBSI0100        Ds                  Qualified  Inz
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  SbsNam_q                     20a
     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
     D  SbsSts                       10a
     D  SgnDevName                   10a
     D  SgnDevLib                    10a
     D  SecLngLib                    10a
     D  MaxActJob                    10i 0
     D  CurActJob                    10i 0
     D  NbrPools                     10i 0
     D  PoolInf                            Dim( 10 )
     D   PoolId                      10i 0 Overlay( PoolInf: 1 )
     D   PoolNam                     10a   Overlay( PoolInf: *Next )
     D                                6a   Overlay( PoolInf: *Next )
     D   PoolSiz                     10i 0 Overlay( PoolInf: *Next )
     D   PoolActLvl                  10i 0 Overlay( PoolInf: *Next )
     **-- Job queue information:
     D OJBQ0100        Ds                  Qualified
     D  JobQue_q                     20a
     D   JobQueNam                   10a   Overlay( JobQue_q:  1 )
     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
     D  JobQueSts                     1a
     D  SbsNam_Q                     20a
     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
     D                                3a
     D  NbrJobOnQue                  10i 0
     D  SeqNbr                       10i 0
     D  MaxAct                       10i 0
     D  CurAct                       10i 0
     D  QueDsc                       50a
     **-- Job queue information (partial):
     D JOBQ0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  JobQue_q                     20a
     D   JobQueNam                   10a   Overlay( JobQue_q:  1 )
     D   JobQueLib                   10a   Overlay( JobQue_q: 11 )
     D  OprCtl                       10a
     D  AutChk                       10a
     D  NbrJobOnQue                  10i 0
     D  JobQueSts                    10a
     D  SbsNam_Q                     20a
     D   SbsNam                      10a   Overlay( SbsNam_q:  1 )
     D   SbsLib                      10a   Overlay( SbsNam_q: 11 )
     D  QueDsc                       50a
     D  SeqNbr                       10i 0
     D  MaxAct                       10i 0
     D  CurAct                       10i 0
     D  MaxPty1                      10i 0
     D  MaxPty2                      10i 0
     D  MaxPty3                      10i 0
     D  MaxPty4                      10i 0
     D  MaxPty5                      10i 0
     D  MaxPty6                      10i 0
     D  MaxPty7                      10i 0
     D  MaxPty8                      10i 0
     D  MaxPty9                      10i 0
     **-- Filter information:
     D FltInf          Ds                  Qualified
     D  FltInfLen                    10i 0 Inz( %Size( FltInf ))
     D  JobQue                       20a
     D   JobQueNam                   10a   Overlay( JobQue:  1 )
     D   JobQueLib                   10a   Overlay( JobQue: 11 )
     D  ActSbsNam                    10a
     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 4 )
     D  SrtStr                       12a   Dim( 4 )
     D   KeyFldOfs                   10i 0 Overlay( SrtStr:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtStr:  5 )
     D   KeyFldTyp                    5i 0 Overlay( SrtStr:  9 )
     D   SrtOrd                       1a   Overlay( SrtStr: 11 )
     D   Rsv                          1a   Overlay( SrtStr: 12 )
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a

     **-- Open list of job queues:
     D LstJobQues      Pr                  ExtPgm( 'QSPOLJBQ' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  LstInf                       80a
     D  FltInf                       32a   Const  Options( *VarSize )
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  NbrRcdRtn                    10i 0 Const
     D  Error                      1024a          Options( *VarSize )
     **-- Get open list entry:
     D GetOplEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  Handle                        4a   Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  RtnRcdNbr                    10i 0 Const
     D  Error                      1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  Handle                        4a   Const
     D  Error                      1024a          Options( *VarSize )
     **-- Retrieve subsystem information:
     D RtvSbsInf       Pr                  ExtPgm( 'QWDRSBSD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  SbsNam_q                     20a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve job queue information:
     D RtvJobQueInf    Pr                  ExtPgm( 'QSPRJOBQ' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobQue_q                     20a   Const
     D  Error                      1024a          Options( *VarSize )
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
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
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

     **-- Get object library:
     D GetObjLib       Pr            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     D CBX967          Pr
     D  PxSbsNam_q                         LikeDs( ObjNam_q )
     **
     D CBX967          Pi
     D  PxSbsNam_q                         LikeDs( ObjNam_q )

      /Free

        OpnDspApp( UIM.AppHdl
                 : PNLGRP_Q
                 : SCP_AUT_RCL
                 : PRM_IFC_0
                 : HLP_WDW
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          ExSr  EscApiErr;
        EndIf;

        PutDlgVar( UIM.AppHdl: ExpRcd: %Size( ExpRcd ): 'EXPRCD': ERRC0100 );

        ExSr  BldHdrRcd;
        ExSr  BldJobQueLst;

        DoU  UIM.FncRqs = FNC_EXIT  Or  UIM.FncRqs = FNC_CNL;

          DspPnl( UIM.AppHdl: UIM.FncRqs: PNLGRP: RDS_OPT_INZ: ERRC0100 );

          Select;
          When  ERRC0100.BytAvl > *Zero;
            ExSr  EscApiErr;

          When  UIM.FncRqs = RTN_ENTER;
            Leave;
          EndSl;

          GetDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

          If  UIM.FncRqs = KEY_F05  And  UIM.EntLocOpt = 'NEXT';
            ExSr  GetLstPos;
            ExSr  DltUsrLst;
          EndIf;

          If  UIM.FncRqs = KEY_F05;
            ExSr  BldJobQueLst;
            ExSr  SetLstPos;
          EndIf;

          ExSr  BldHdrRcd;
        EndDo;

        CloApp( UIM.AppHdl: CLO_NORM: ERRC0100 );

        *InLr = *On;
        Return;


        BegSr  BldJobQueLst;

          ExSr  InzApiPrm;

          UIM.EntLocOpt = 'FRST';
          LstApi.RtnRcdNbr = 1;

          LstJobQues( OJBQ0100
                    : %Size( OJBQ0100 )
                    : 'OJBQ0100'
                    : LstInf
                    : FltInf
                    : SrtInf
                    : -1
                    : ERRC0100
                    );

          If  ERRC0100.BytAvl = *Zero  And  LstInf.RcdNbrRtn > *Zero;
            ExSr  PrcLstEnt;

            DoW  LstInf.RcdNbrTot > LstApi.RtnRcdNbr;
              LstApi.RtnRcdNbr += 1;

              GetOplEnt( OJBQ0100
                       : %Size( OJBQ0100 )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;

              ExSr  PrcLstEnt;
            EndDo;
          EndIf;

          CloseLst( LstInf.Handle: ERRC0100 );

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

          LstEnt.Option = *Zero;

          LstEnt.SeqNbr      = OJBQ0100.SeqNbr;
          LstEnt.JobQue_q    = OJBQ0100.JobQue_q;
          LstEnt.JobQueSts   = OJBQ0100.JobQueSts;
          LstEnt.MaxAct      = OJBQ0100.MaxAct;
          LstEnt.CurAct      = OJBQ0100.CurAct;
          LstEnt.NbrJobOnQue = OJBQ0100.NbrJobOnQue;
          LstEnt.QueDsc      = OJBQ0100.QueDsc;

          ExSr  GetJobQueInf;

          LstEnt.MaxPty1     = JOBQ0200.MaxPty1;
          LstEnt.MaxPty2     = JOBQ0200.MaxPty2;
          LstEnt.MaxPty3     = JOBQ0200.MaxPty3;
          LstEnt.MaxPty4     = JOBQ0200.MaxPty4;
          LstEnt.MaxPty5     = JOBQ0200.MaxPty5;
          LstEnt.MaxPty6     = JOBQ0200.MaxPty6;
          LstEnt.MaxPty7     = JOBQ0200.MaxPty7;
          LstEnt.MaxPty8     = JOBQ0200.MaxPty8;
          LstEnt.MaxPty9     = JOBQ0200.MaxPty9;

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

        EndSr;

        BegSr  GetJobQueInf;

          RtvJobQueInf( JOBQ0200
                      : %Size( JOBQ0200 )
                      : 'JOBQ0200'
                      : OJBQ0100.JobQue_q
                      : ERRC0100
                      );

          If  ERRC0100.BytAvl > *Zero;
            Clear  JOBQ0200;
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
                     : 'EQ        SEQNBR'
                     : LstAtr.DspPos
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

        BegSr  BldHdrRcd;

          SysDts = %Timestamp();

          HdrRcd.SysDat = %Char( %Date( SysDts ): *CYMD0 );
          HdrRcd.SysTim = %Char( %Time( SysDts ): *HMS0 );
          HdrRcd.TimZon = '*SYS';

          ExSr  GetSbsInf;

          HdrRcd.SbsNam    = SBSI0100.SbsNam;
          HdrRcd.SbsLib    = SBSI0100.SbsLib;
          HdrRcd.SbsSts    = SBSI0100.SbsSts;
          HdrRcd.MaxActJob = SBSI0100.MaxActJob;

          PutDlgVar( UIM.AppHdl: HdrRcd: %Size( HdrRcd ): 'HDRRCD': ERRC0100 );

        EndSr;

        BegSr  DltUsrLst;

          DltLst( UIM.AppHdl: 'DTLLST': ERRC0100 );

        EndSr;

        BegSr  GetSbsInf;

          RtvSbsInf( SBSI0100
                   : %Size( SBSI0100 )
                   : 'SBSI0100'
                   : PxSbsNam_q
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl > *Zero;
            Reset  SBSI0100;
          EndIf;

        EndSr;

        BegSr  InzApiPrm;

          FltInf.JobQue    = '*ALLOCATED';
          FltInf.ActSbsNam = SBSI0100.SbsNam_q;

          SrtInf.NbrKeys   = 1;

          SrtInf.KeyFldOfs(1) = 49;
          SrtInf.KeyFldLen(1) = %Size( OJBQ0100.SeqNbr );
          SrtInf.KeyFldTyp(1) = BIN_SGN;
          SrtInf.SrtOrd(1)    = SORT_ASC;
          SrtInf.Rsv(1)       = x'00';

        EndSr;

        BegSr  *InzSr;

          If  PxSbsNam_q.ObjLib = '*LIBL';
            PxSbsNam_q.ObjLib = GetObjLib( PxSbsNam_q: '*SBSD' );
          EndIf;

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

     **-- Get object library:
     P GetObjLib       B
     D                 Pi            10a
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  ObjLibRtn                    10a
     D  ObjASP                       10i 0
     D  ObjOwn                       10a
     D  ObjDmn                        2a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : PxObjNam_q
                : PxObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;

         Else;
           Return  OBJD0100.ObjLibRtn;
         EndIf;

      /End-Free

     P GetObjLib       E
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
