     **
     **  Program . . : CBX9522
     **  Description : Print job run attributes - main CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX9522 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX9522 )
     **                Module( CBX9322 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )

     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )

     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D NBR_KEY         c                   1
     D KEY_OFS         c                   80
     D SIZ_NLS_INF     c                   290
     D JOB_RUN         c                   0
     D TYP_BIN         c                   0
     D TYP_UBIN        c                   9
     D ASCEND          c                   1
     D DESCEND         c                   2
     **
     D SRT_PUT         c                   1
     D SRT_END         c                   2
     D SRT_GET         c                   3
     D SRT_CNL         c                   4
     **-- Global variables:
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     D Idx             s             10i 0
     D SrtAct          s               n
     D KeyDtaVal       s             32a
     **
     D PrtOrd          Ds                  Based( pNULL )  Qualified
     D  NbrElm                        5i 0
     D  SrtFld                       10a
     D  SrtSeq                       10a
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  PrcUnTm                      20u 0
     D  TmpStMb                      10i 0
     D  MxPrcUt                      10a
     D  MxTmpSt                      10a
     D  PrcUtDb                      19a
     D  DftWait                       7a
     D  ElgPrg                        5a
     D  TimSlc                        7a
     D  RunPty                        3i 0
     D  JobNam                       10a
     D  UsrPrf                       10a
     D  JobNbr                        6a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0 Inz( 1 )
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 10 )
     **-- Job information:
     D OLJB0200        Ds           512    Qualified
     D  JobNam                       10a
     D  UsrPrf                       10a
     D  JobNbr                        6a
     D  JobIdInt                     16a
     D  Status                       10a
     D  JobTyp                        1a
     D  JobSubTyp                     1a
     D                                2a
     **-- Key information:
     D KeyInf          Ds                  Qualified
     D  FldNbrRtn                    10i 0
     D  KeyStr                       20a   Dim( %Elem( LstApi.KeyFld ))
     D   FldInfLen                   10i 0 Overlay( KeyStr:  1 )
     D   KeyFld                      10i 0 Overlay( KeyStr:  5 )
     D   DtaTyp                       1a   Overlay( KeyStr:  9 )
     D                                3a   Overlay( KeyStr: 10 )
     D   DtaLen                      10i 0 Overlay( KeyStr: 13 )
     D   DtaOfs                      10i 0 Overlay( KeyStr: 17 )
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
     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 0 )
     D  SrtInf                       12a   Dim( 10 )
     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
     D   Rsv                          1a   Overlay( SrtInf: *Next )
     **-- Authority control:
     D AutCtl          Ds                  Qualified
     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
     D  CalLvl                       10i 0 Inz( 0 )
     D  DplObjAut                    10i 0 Inz( 0 )
     D  NbrObjAut                    10i 0 Inz( 0 )
     D  DplLibAut                    10i 0 Inz( 0 )
     D  NbrLibAut                    10i 0 Inz( 0 )
     D                               10i 0 Inz( 0 )
     D  ObjAut                       10a   Dim( 10 )
     D  LibAut                       10a   Dim( 10 )
     **-- Selection control:
     D SltCtl          Ds
     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
     D  SltOmt                       10i 0 Inz( 0 )
     D  DplSts                       10i 0 Inz( 20 )
     D  NbrSts                       10i 0 Inz( 1 )
     D                               10i 0 Inz( 0 )
     D  Status                        1a   Inz( '*' )
     **-- Selection information:
     D OLJS0100        Ds                  Qualified
     D  JobNam                       10a   Inz( '*ALL' )
     D  UsrNam                       10a   Inz( '*ALL' )
     D  JobNbr                        6a   Inz( '*ALL' )
     D  JobTyp                        1a   Inz( '*' )
     D                                1a
     D  OfsPriSts                    10i 0 Inz( 60 )
     D  NbrPriSts                    10i 0 Inz( 1 )
     D  OfsActSts                    10i 0 Inz( 70 )
     D  NbrActSts                    10i 0 Inz( 0 )
     D  OfsJbqSts                    10i 0 Inz( 78 )
     D  NbrJbqSts                    10i 0 Inz( 0 )
     D  OfsJbqNam                    10i 0 Inz( 88 )
     D  NbrJbqNam                    10i 0 Inz( 0 )
     **
     D  PriSts                       10a   Dim( 1 )
     D  ActSts                        4a   Dim( 2 )
     D  JbqSts                       10a   Dim( 1 )
     D  JbqNam                       20a   Dim( 1 )
     **-- Job information key fields:
     D KeyDta          Ds                  Qualified
     D  PrcUniTim                    20u 0
     D  TmpStgUsdMb                  10i 0
     D  MaxPrcUniTm                  10i 0
     D  MaxTmpStgMb                  10i 0
     D  PrcUniTimDb                  20u 0
     D  NbrAuxIoRqs                  20u 0
     D  DftWait                      10i 0
     D  ElgPrg                       10a
     D  TimSlc                       10i 0
     D  RunPty                       10i 0

     **-- Sort API parameters:
     D SrtApi          Ds                  Qualified  Inz
     D  DtaBufLen                    10i 0
     D  DtaRtnLen                    10i 0
     D  Omit                         16a
     **
     D RqsCtlBlk       Ds                  Qualified  Inz
     D  BlkLen                       10i 0
     D  RqsTyp                       10i 0 Inz( 8 )
     D                               10i 0
     D  Options                      10i 0
     D  RcdLen                       10i 0 Inz( %Size( LstRcd ))
     D  RcdCnt                       10i 0
     D  KeyOfs                       10i 0 Inz( KEY_OFS )
     D  KeyNbr                       10i 0
     D  NlsOfs                       10i 0
     D  InpFlsOfs                    10i 0
     D  InpFlsNbr                    10i 0
     D  OutFlsOfs                    10i 0
     D  OutFlsNbr                    10i 0
     D  KeyEntLen                    10i 0 Inz( %Size( SrtKeyInfDs ))
     D  NlsSsqLen                    10i 0 Inz( SIZ_NLS_INF )
     D  InpFenLen                    10i 0
     D  OutFenLen                    10i 0
     D  NlbMapOfs                    10i 0
     D  VlrAciOfs                    10i 0
     D                               10i 0
     **
     D SrtKeyInf                     20a   Dim( NBR_KEY )
     **
     D SrtTblQ                       20a   Inz( '*LANGIDSHR' )
     D SrtSeqCcsId                   10i 0 Inz( JOB_RUN )
     D SrtSeqLngId                   10a   Inz( '*JOBRUN' )
     D SrtSeqTbl                    256a
     **
     D SrtKeyInfDs     Ds                  Qualified  Inz
     D  KeyStrPos                    10i 0
     D  KeySize                      10i 0
     D  KeyDtaTyp                    10i 0
     D  KeyOrder                     10i 0
     D  KeyOrdPos                    10i 0
     **
     D RqsCtlBlkIo     Ds                  Qualified
     D  RqsTyp                       10i 0 Inz
     D                               10i 0 Inz
     D  RcdLen                       10i 0 Inz
     D  RcdCnt                       10i 0 Inz
     **
     D DtaBufInf       Ds                  Qualified
     D  RcdPrc                       10i 0
     D  RcdAvl                       10i 0
     D                                8a

     **-- Open list of jobs:
     D LstJobs         Pr                  ExtPgm( 'QGYOLJOB' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  RcvVarDfn                 65535a          Options( *VarSize )
     D  RcvDfnLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  JobSltInf                  1024a   Const  Options( *VarSize )
     D  JobSltLen                    10i 0 Const
     D  NbrFldRtn                    10i 0 Const
     D  KeyFldRtn                    10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  Error                      1024a          Options( *VarSize )
     D  JobSltFmt                     8a   Const  Options( *NoPass )
     D  ResStc                        1a   Const  Options( *NoPass )
     D  GenRtnDta                    32a          Options( *NoPass: *VarSize )
     D  GenRtnDtaLn                  10i 0 Const  Options( *NoPass )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
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
     **-- Copy memory:
     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
     D  MemOut                         *   Value
     D  MemInp                         *   Value
     D  MemSiz                       10u 0 Value
     **-- Initialize sort:
     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
     D  RqsCtlBlk                    80a   Const  Options( *VarSize )
     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
     D  OutDtaBuf                 65535a          Options( *VarSize )
     D  OutDtaLen                    10i 0 Const
     D  RtnDtaLen                    10i 0
     D  Error                     32767a          Options( *VarSize )
     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
     **-- Sort input/output:
     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
     D  RqsCtlBlk                    16a   Const
     D  InpDtaBuf                 65535a   Const  Options( *VarSize )
     D  OutDtaBuf                 65535a          Options( *VarSize )
     D  OutDtaLen                    10i 0 Const
     D  OutDtaInf                    16a
     D  Error                     32767a          Options( *VarSize )
     D  RtnRcdFb                    144a          Options( *VarSize: *NoPass )
     D  RtnRcdFbLen                  10i 0 Const  Options( *NoPass )
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
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  NbrNetAtr                    10i 0 Const
     D  NetAtr                       10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  Error                     32767a          Options( *VarSize )

     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     32a   Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX9522         Pr
     D  PxJobTyp                      1a
     D  PxCpuTimLmt                  10i 0
     D  PxTmpStgLmt                  10i 0
     D  PxPrtOrd                           LikeDs( PrtOrd )
     **
     D CBX9522         Pi
     D  PxJobTyp                      1a
     D  PxCpuTimLmt                  10i 0
     D  PxTmpStgLmt                  10i 0
     D  PxPrtOrd                           LikeDs( PrtOrd )

      /Free

        OLJS0100.PriSts(1) = '*ACTIVE';
        OLJS0100.JobTyp    = PxJobTyp;

        LstApi.KeyFld(1) = 0312;
        LstApi.KeyFld(2) = 0313;
        LstApi.KeyFld(3) = 0409;
        LstApi.KeyFld(4) = 1302;
        LstApi.KeyFld(5) = 1305;
        LstApi.KeyFld(6) = 1406;
        LstApi.KeyFld(7) = 1604;
        LstApi.KeyFld(8) = 1802;
        LstApi.KeyFld(9) = 2002;
        LstApi.KeyFld(10) = 2009;

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        LstJobs( OLJB0200
               : %Size( OLJB0200 )
               : 'OLJB0200'
               : KeyInf
               : %Size( KeyInf )
               : LstInf
               : 1
               : SrtInf
               : OLJS0100
               : %Size( OLJS0100 )
               : LstApi.NbrKeyRtn
               : LstApi.KeyFld
               : ERRC0100
               : 'OLJS0100'
               );

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
                   );
        Else;

          DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

            ExSr  GetKeyDta;
            ExSr  ChkKeyDta;

            LstApi.RtnRcdNbr += 1;

            GetLstEnt( OLJB0200
                     : %Size( OLJB0200 )
                     : LstInf.Handle
                     : LstInf
                     : 1
                     : LstApi.RtnRcdNbr
                     : ERRC0100
                     );

          EndDo;

          ExSr  WrtSrtLst;

          If  LstInf.LstSts = '5';
            WrtLstTrl( '***  P A R T I A L  L I S T  ***' );
          EndIf;

          WrtLstTrl( '***  E N D  O F  L I S T  ***' );

          CloseLst( LstInf.Handle: ERRC0100 );
        EndIf;

        *InLr = *On;
        Return;


        BegSr  GetKeyDta;

          Clear  KeyDta;

          For Idx = 1  To KeyInf.FldNbrRtn;

            KeyDtaVal = %SubSt( OLJB0200
                              : KeyInf.DtaOfs(Idx) + 1
                              : KeyInf.DtaLen(Idx)
                              );


            Select;
            When  KeyInf.KeyFld(Idx) = 0312;
              memcpy( %Addr( KeyDta.PrcUniTim )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.PrcUniTim )
                    );

            When  KeyInf.KeyFld(Idx) = 0313;
              memcpy( %Addr( KeyDta.PrcUniTimDb )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.PrcUniTimDb )
                    );

            When  KeyInf.KeyFld(Idx) = 0409;
              memcpy( %Addr( KeyDta.DftWait )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.DftWait )
                    );

            When  KeyInf.KeyFld(Idx) = 1302;
              memcpy( %Addr( KeyDta.MaxPrcUniTm )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.MaxPrcUniTm )
                    );

            When  KeyInf.KeyFld(Idx) = 1305;
              memcpy( %Addr( KeyDta.MaxTmpStgMb )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.MaxTmpStgMb )
                    );

            When  KeyInf.KeyFld(Idx) = 1406;
              memcpy( %Addr( KeyDta.NbrAuxIoRqs )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.NbrAuxIoRqs )
                    );

            When  KeyInf.KeyFld(Idx) = 1604;
              KeyDta.ElgPrg = KeyDtaVal;

            When  KeyInf.KeyFld(Idx) = 1802;
              memcpy( %Addr( KeyDta.RunPty )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.RunPty )
                    );

            When  KeyInf.KeyFld(Idx) = 2002;
              memcpy( %Addr( KeyDta.TimSlc )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.TimSlc )
                    );

            When  KeyInf.KeyFld(Idx) = 2009;
              memcpy( %Addr( KeyDta.TmpStgUsdMb )
                    : %Addr( KeyDtaVal )
                    : %Size( KeyDta.TmpStgUsdMb )
                    );

            EndSl;
          EndFor;

        EndSr;

        BegSr  ChkKeyDta;

          Select;
          When  PxTmpStgLmt = -1  And PxCpuTimLmt = -1;
            ExSr  AddSrtLst;

          When  PxTmpStgLmt < KeyDta.TmpStgUsdMb  And  PxCpuTimLmt = -1;
            ExSr  AddSrtLst;

          When  PxCpuTimLmt < KeyDta.PrcUniTim  And  PxTmpStgLmt = -1;
            ExSr  AddSrtLst;

          When  PxTmpStgLmt < KeyDta.TmpStgUsdMb  And
                PxCpuTimLmt < KeyDta.PrcUniTim;
            ExSr  AddSrtLst;
          EndSl;

        EndSr;

        BegSr  InzSrtLst;

          If  PxPrtOrd.SrtFld = '*TMPSTG';
            SrtKeyInfDs.KeyDtaTyp = TYP_BIN;
            SrtKeyInfDs.KeyStrPos = 9;
            SrtKeyInfDs.KeySize   = %Size( LstRcd.TmpStMb );

          ElseIf  PxPrtOrd.SrtFld = '*CPUTIM';
            SrtKeyInfDs.KeyDtaTyp = TYP_UBIN;
            SrtKeyInfDs.KeyStrPos = 1;
            SrtKeyInfDs.KeySize   = %Size( LstRcd.PrcUnTm );
          EndIf;

          If  PxPrtOrd.SrtSeq = '*ASCEND';
            SrtKeyInfDs.KeyOrder  = ASCEND;

          ElseIf  PxPrtOrd.SrtSeq = '*DESCEND';
            SrtKeyInfDs.KeyOrder  = DESCEND;
          EndIf;

          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;

          RqsCtlBlk.NlsOfs = KEY_OFS +
                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY );

          RqsCtlBlk.BlkLen = KEY_OFS +
                             ( %Size( RqsCtlBlk.SrtKeyInf ) * NBR_KEY ) +
                             SIZ_NLS_INF;

          RqsCtlBlk.KeyNbr = NBR_KEY;

          InzSort( RqsCtlBlk
                 : SrtApi.Omit
                 : SrtApi.Omit
                 : SrtApi.DtaBufLen
                 : SrtApi.DtaRtnLen
                 : ERRC0100
                 );

          If  ERRC0100.BytAvl = *Zero;
            SrtAct = *On;
          EndIf;

        EndSr;

        BegSr  AddSrtLst;

          If  SrtAct = *Off;
            ExSr  InzSrtLst;
          EndIf;

          RqsCtlBlkIo.RcdLen = RqsCtlBlk.RcdLen;
          RqsCtlBlkIo.RcdCnt = 1;
          RqsCtlBlkIo.RqsTyp = SRT_PUT;

          LstRcd.PrcUnTm = KeyDta.PrcUniTim;
          LstRcd.TmpStMb = KeyDta.TmpStgUsdMb;

          If  KeyDta.MaxPrcUniTm = -1;
            LstRcd.MxPrcUt = '*NOMAX';
          Else;
            EvalR  LstRcd.MxPrcUt = %Char( KeyDta.MaxPrcUniTm );
          EndIf;

          If  KeyDta.MaxTmpStgMb = -1;
            LstRcd.MxTmpSt = '*NOMAX';
          Else;
            EvalR  LstRcd.MxTmpSt = %Char( KeyDta.MaxTmpStgMb );
          EndIf;

          EvalR  LstRcd.PrcUtDb = %Char( KeyDta.PrcUniTimDb );
          EvalR  LstRcd.DftWait = %Char( KeyDta.DftWait );
          EvalR  LstRcd.TimSlc  = %Char( KeyDta.TimSlc );

          LstRcd.ElgPrg  = KeyDta.ElgPrg;
          LstRcd.RunPty  = KeyDta.RunPty;
          LstRcd.JobNam  = OLJB0200.JobNam;
          LstRcd.UsrPrf  = OLJB0200.UsrPrf;
          LstRcd.JobNbr  = OLJB0200.JobNbr;

          SortIo( RqsCtlBlkIo
                : LstRcd
                : SrtApi.Omit
                : SrtApi.DtaBufLen
                : DtaBufInf
                : ERRC0100
                );

        EndSr;

        BegSr  WrtSrtLst;

          ExSr  EndSrtLst;

          If  DtaBufInf.RcdAvl > *Zero;

            RqsCtlBlkIo.RqsTyp = SRT_GET;

            SrtApi.DtaBufLen = RqsCtlBlkIo.RcdLen;

            SortIo( RqsCtlBlkIo
                  : SrtApi.Omit
                  : LstRcd
                  : SrtApi.DtaBufLen
                  : DtaBufInf
                  : ERRC0100
                  );

            DoW  DtaBufInf.RcdPrc > *Zero  And  ERRC0100.BytAvl = *Zero;

              WrtDtlLin();

              SortIo( RqsCtlBlkIo
                    : SrtApi.Omit
                    : LstRcd
                    : SrtApi.DtaBufLen
                    : DtaBufInf
                    : ERRC0100
                    );
            EndDo;
          EndIf;

        EndSr;

        BegSr  EndSrtLst;

          RqsCtlBlkIo.RqsTyp = SRT_END;

          SortIo( RqsCtlBlkIo
                : SrtApi.Omit
                : SrtApi.Omit
                : SrtApi.DtaBufLen
                : DtaBufInf
                : ERRC0100
                );

          If  ERRC0100.BytAvl = *Zero;
            SrtAct = *Off;
          EndIf;

        EndSr;

        BegSr  *InzSr;

          LstTim = %Int( %Char( %Time(): *ISO0));
          SysNam = GetSysNam();

          WrtLstHdr( *Omit );

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           36 'System:'
     O                       SysNam              45
     O                                           85 'Print Job Run Attributes'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           34 'Run'
     O                                           41 'Time'
     O                                           58 'Default'
     O                                           68 'Max. CPU'
     O                                          102 'Max. temp.'
     O                                          114 'Temp. stg.'
     OQSYSPRT   EF           LstHdr         1
     O                                            3 'Job'
     O                                           15 'User'
     O                                           28 'Number'
     O                                           35 'pty.'
     O                                           42 'slice'
     O                                           49 'Purge'
     O                                           58 'wait'
     O                                           67 'time ms'
     O                                           90 'CPU time used ms'
     O                                          102 'storage Mb'
     O                                          113 'used Mb'
     O                                          132 'DB CPU time used'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.JobNam       10
     O                       LstRcd.UsrPrf       21
     O                       LstRcd.JobNbr       28
     O                       LstRcd.RunPty 3     34
     O                       LstRcd.TimSlc       42
     O                       LstRcd.ElgPrg       49
     O                       LstRcd.DftWait      58
     O                       LstRcd.MxPrcUt      70
     O                       LstRcd.PrcUnTm3     90
     O                       LstRcd.MxTmpSt     102
     O                       LstRcd.TmpStMb3    112
     O                       LstRcd.PrcUtDb     132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34

     **-- Write detail line:
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtLstHdr( 3 );

        Except  DtlLin;

      /End-Free

     P WrtDtlLin       E
     **-- Write list header:
     P WrtLstHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )

      /Free

        If  %Addr( PxOvrFlwRel) = *Null;

          Except  Header;
          Except  LstHdr;
        Else;

          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;

            Except  Header;
            Except  LstHdr;
          EndIf;
        EndIf;

      /End-Free

     P WrtLstHdr       E
     **-- Write list trailer:
     P WrtLstTrl       B
     D                 Pi
     D  PxTrlTxt                     32a   Const

      /Free

        TrlTxt = PxTrlTxt;

        Except  LstTrl;

      /End-Free

     P WrtLstTrl       E
     **-- Get system name:
     P GetSysNam       B
     D                 Pi             8a   Varying

     **-- Local variables:
     D Idx             s             10i 0
     D SysNam          s              8a   Varying
     **
     D RtnAtrLen       s             10i 0
     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
     D NetAtr          s             10a   Dim( 1 )
     **
     D RtnVar          Ds                  Qualified
     D  RtnVarNbr                    10i 0
     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
     D  RtnVarDta                  1024a

     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
     D  AtrNam                       10a
     D  DtaTyp                        1a
     D  InfSts                        1a
     D  AtrLen                       10i 0
     D  Atr                        1008a

      /Free

        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;

        NetAtr(1) = 'SYSNAME';

        RtvNetAtr( RtnVar
                 : RtnAtrLen
                 : NetAtrNbr
                 : NetAtr
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          SysNam = '';

        Else;
          For  Idx = 1  to RtnVar.RtnVarNbr;

            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);

            If  RtnAtr.AtrNam = 'SYSNAME';
              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
            EndIf;

          EndFor;
        EndIf;

        Return  SysNam;

      /End-Free

     P GetSysNam       E
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
