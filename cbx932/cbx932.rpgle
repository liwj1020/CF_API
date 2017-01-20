     **
     **  Program . . : CBX932
     **  Description : Print save information - main CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX932 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX932 )
     **                Module( CBX932 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )  BndDir( 'QC2LE' )
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
     D ADP_PRV_INVLVL  c                   1
     D NBR_KEY         c                   2
     D KEY_OFS         c                   80
     D SIZ_NLS_INF     c                   290
     D JOB_RUN         c                   0
     D CHAR_NLS        c                   4
     D DATE_MDY        c                   13
     D DATE_DMY        c                   14
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
     D ObjLib          s             10a
     D TrlTxt          s             32a
     D Idx             s             10i 0
     D SrtAct          s               n
     D SavDat          s               d
     **
     D IncDat          Ds                  Based( pNULL )  Qualified
     D  NbrElm                        5i 0
     D  SavDat                        7a
     D  DatRel                       10a
     **
     D PrtOrd          Ds                  Based( pNULL )  Qualified
     D  NbrElm                        5i 0
     D  SrtFld                       10a
     D  SrtSeq                       10a
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  ObjLib                       10a
     D  ObjNam                       10a
     D  ObjTxt                       50a
     D  SavDat                        8a
     D  RstDat                        8a
     D  SavCmd                       10a
     D  SavDev                        5a
     D  SavVol                       10a
     D  SavSeq                        6s 0
     D  SavLbl                       17a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 8 )
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     **-- Object information:
     D ObjInf          Ds          4096    Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  InfSts                        1a
     D                                1a
     D  FldNbrRtn                    10i 0
     D  Data                               Like( KeyInf )
     **-- Key information:
     D KeyInf          Ds                  Qualified  Based( pKeyInf )
     D  FldInfLen                    10i 0
     D  KeyFld                       10i 0
     D  DtaTyp                        1a
     D                                3a
     D  DtaLen                       10i 0
     D  Data                        256a
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
     **-- Object information key fields:
     D KeyFld          Ds                  Qualified
     D  ObjTxt                       50a
     D  SavDts                        8a
     D  RstDts                        8a
     D  SavSeq                       10i 0
     D  SavCmd                       10a
     D  SavVol                       71a
     D  SavDev                       10a
     D  SavLbl                       17a
     D  SavDat                         d
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
     **-- Open list of objects:
     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
     D  LoRcvVar                  65535a          Options( *VarSize )
     D  LoRcvVarLen                  10i 0 Const
     D  LoLstInf                     80a
     D  LoNbrRcdRtn                  10i 0 Const
     D  LoSrtInf                   1024a   Const  Options( *VarSize )
     D  LoObjNam_q                   20a   Const
     D  LoObjTyp                     10a   Const
     D  LoAutCtl                   1024a   Const  Options( *VarSize )
     D  LoSltCtl                   1024a   Const  Options( *VarSize )
     D  LoNbrKeyRtn                  10i 0 Const
     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  LoError                    1024a          Options( *VarSize )
     **
     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
     **
     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  GlRcvVar                  65535a          Options( *VarSize )
     D  GlRcvVarLen                  10i 0 Const
     D  GlHandle                      4a   Const
     D  GlLstInf                     80a
     D  GlNbrRcdRtn                  10i 0 Const
     D  GlRtnRcdNbr                  10i 0 Const
     D  GlError                    1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  ClHandle                      4a   Const
     D  ClError                    1024a          Options( *VarSize )
     **-- Copy memory:
     D memcpy          Pr              *   ExtProc( 'memmove' )
     D  MemOut                         *   Value
     D  MemInp                         *   Value
     D  MemSiz                       10u 0 Value
     **-- Initialize sort:
     D InzSort         Pr                  ExtPgm( 'QLGSORT' )
     D  IsRqsCtlBlk                  80a   Const  Options( *VarSize )
     D  IsInpDtaBuf               65535a   Const  Options( *VarSize )
     D  IsOutDtaBuf               65535a          Options( *VarSize )
     D  IsOutDtaLen                  10i 0 Const
     D  IsRtnDtaLen                  10i 0
     D  IsError                   32767a          Options( *VarSize )
     D  IsRtnRcdFb                  144a          Options( *VarSize: *NoPass )
     D  IsRtnRcdFbLen                10i 0 Const  Options( *NoPass )
     **-- Sort input/output:
     D SortIo          Pr                  ExtPgm( 'QLGSRTIO' )
     D  IoRqsCtlBlk                  16a   Const
     D  IoInpDtaBuf               65535a   Const  Options( *VarSize )
     D  IoOutDtaBuf               65535a          Options( *VarSize )
     D  IoOutDtaLen                  10i 0 Const
     D  IoOutDtaInf                  16a
     D  IoError                   32767a          Options( *VarSize )
     D  IoRtnRcdFb                  144a          Options( *VarSize: *NoPass )
     D  IoRtnRcdFbLen                10i 0 Const  Options( *NoPass )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                   32767a          Options( *VarSize )
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const
     D  CdOutVar                     17a          Options( *VarSize )
     D  CdError                      10i 0 Const
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RnRcvVar                  32767a          Options( *VarSize )
     D  RnRcvVarLen                  10i 0 Const
     D  RnNbrNetAtr                  10i 0 Const
     D  RnNetAtr                     10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  RnError                   32767a          Options( *VarSize )

     **-- Convert system DTS to date:
     D CvtDtsDat       Pr              d
     D  PxSysDts                      8a   Value
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxObjLib                     10a   Const  Options( *Omit )
     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )
     **-- Write library header:
     D WrtLibHdr       Pr
     D  PxObjLib                     10a   Const
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     32a   Const

     **-- Entry parameters:
     D CBX9322X        Pr
     D  PxLibNam                     10a   Varying
     D  PxObjLvl                     10a
     D  PxIncDat                           LikeDs( IncDat )
     D  PxPrtOrd                           LikeDs( PrtOrd )
     **
     D CBX9322X        Pi
     D  PxLibNam                     10a   Varying
     D  PxObjLvl                     10a
     D  PxIncDat                           LikeDs( IncDat )
     D  PxPrtOrd                           LikeDs( PrtOrd )

      /Free

        ExSr  InzApiPrm;

        ExSr  PrtSavCmd;

        ExSr  PrtLibInf;

        *InLr = *On;
        Return;


        BegSr  InzApiPrm;

          LstApi.KeyFld(1) = 203;
          LstApi.KeyFld(2) = 501;
          LstApi.KeyFld(3) = 502;
          LstApi.KeyFld(4) = 505;
          LstApi.KeyFld(5) = 506;
          LstApi.KeyFld(6) = 507;
          LstApi.KeyFld(7) = 508;
          LstApi.KeyFld(8) = 511;

          SrtInf.NbrKeys      = 0;
          SrtInf.KeyFldOfs(1) = 0;
          SrtInf.KeyFldLen(1) = 0;
          SrtInf.KeyFldTyp(1) = 0;
          SrtInf.SrtOrd(1)    = '1';
          SrtInf.Rsv(1)       = x'00';

        EndSr;

        BegSr  PrtLibInf;

          Select;
          When  PxObjLvl = '*LIB';
            LstApi.ObjNam = PxLibNam;
            LstApi.ObjLib = '*LIBL';
            LstApi.ObjTyp = '*LIB';

          When  PxObjLvl = '*OBJ';
            LstApi.ObjNam = '*ALL';
            LstApi.ObjLib = PxLibNam;
            LstApi.ObjTyp = '*ALL';
          EndSl;

          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : 1
                 : SrtInf
                 : LstApi.ObjNam + LstApi.ObjLib
                 : LstApi.ObjTyp
                 : AutCtl
                 : SltCtl
                 : LstApi.NbrKeyRtn
                 : LstApi.KeyFld
                 : ERRC0100
                 );

          If  ERRC0100.BytAvl = *Zero;

            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

              ExSr  GetKeyDta;
              ExSr  ChkKeyDta;

              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

              GetLstEnt( ObjInf
                       : %Size( ObjInf )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;

              If  LstInf.LstSts = '5'  And  LstInf.RcdNbrTot = LstApi.RtnRcdNbr;
                Leave;
              EndIf;
            EndDo;

            CloseLst( LstInf.Handle: ERRC0100 );
          EndIf;

          ObjLib = *Blanks;

          ExSr  WrtSrtLst;

          If  LstInf.LstSts = '5';
            WrtLstTrl( '***  P A R T I A L  L I S T  ***' );
          EndIf;

          WrtLstTrl( '***  E N D  O F  L I S T  2  ***' );

        EndSr;

        BegSr  PrtSavCmd;

          LstApi.ObjNam = 'QSAV*';
          LstApi.ObjLib = 'QSYS';
          LstApi.ObjTyp = '*DTAARA';

          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : 1
                 : SrtInf
                 : LstApi.ObjNam + LstApi.ObjLib
                 : LstApi.ObjTyp
                 : AutCtl
                 : SltCtl
                 : LstApi.NbrKeyRtn
                 : LstApi.KeyFld
                 : ERRC0100
                 );

          If  ERRC0100.BytAvl = *Zero;

            DoW  LstInf.LstSts <> '2'  Or
                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

              ExSr  GetKeyDta;
              ExSr  ChkKeyDta;

              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

              GetLstEnt( ObjInf
                       : %Size( ObjInf )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;
            EndDo;

            CloseLst( LstInf.Handle: ERRC0100 );
          EndIf;

          ObjLib = '*NONE';

          ExSr  WrtSrtLst;

          WrtLstTrl( '***  E N D  O F  L I S T  1  ***' );

        EndSr;

        BegSr  GetKeyDta;

          pKeyInf = %Addr( ObjInf.Data );

          For  Idx = 1  To ObjInf.FldNbrRtn;

            Select;
            When  KeyInf.KeyFld = 203;
              KeyFld.ObjTxt = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 501;
              KeyFld.SavDts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
              KeyFld.SavDat = CvtDtsDat( KeyFld.SavDts );

            When  KeyInf.KeyFld = 502;
              KeyFld.RstDts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 505;
              MemCpy( %Addr( KeyFld.SavSeq )
                    : %Addr( KeyInf.Data )
                    : %Size( KeyFld.SavSeq )
                    );

            When  KeyInf.KeyFld = 506;
              KeyFld.SavCmd = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 507;
              KeyFld.SavVol = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 508;
              KeyFld.SavDev = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 511;
              KeyFld.SavLbl = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
            EndSl;

            If  Idx < ObjInf.FldNbrRtn;
              pKeyInf = pKeyInf + KeyInf.FldInfLen;
            EndIf;
          EndFor;

        EndSr;

        BegSr  ChkKeyDta;

          Select;
          When  PxIncDat.NbrElm = 1;
            ExSr  AddSrtLst;

          When  PxIncDat.DatRel = '*BEFORE'  And
                KeyFld.SavDat < SavDat;
            ExSr  AddSrtLst;

          When  PxIncDat.DatRel = '*AFTER'  And
                KeyFld.SavDat >= SavDat;
            ExSr  AddSrtLst;
          EndSl;

        EndSr;

        BegSr  InzSrtLst;

          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
          SrtKeyInfDs.KeyStrPos = 1;
          SrtKeyInfDs.KeySize   = %Size( LstRcd.ObjLib );
          SrtKeyInfDs.KeyOrder  = ASCEND;

          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;

          If  PxPrtOrd.SrtFld = '*LIBOBJ';
            SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
            SrtKeyInfDs.KeyStrPos = 11;
            SrtKeyInfDs.KeySize   = %Size( LstRcd.ObjNam );

          ElseIf  PxPrtOrd.SrtFld = '*LIBSAV';
            SrtKeyInfDs.KeyDtaTyp = DATE_DMY;
            SrtKeyInfDs.KeyStrPos = 71;
            SrtKeyInfDs.KeySize   = %Size( LstRcd.SavDat );
          EndIf;

          If  PxPrtOrd.SrtSeq = '*ASCEND';
            SrtKeyInfDs.KeyOrder  = ASCEND;

          ElseIf  PxPrtOrd.SrtSeq = '*DESCEND';
            SrtKeyInfDs.KeyOrder  = DESCEND;
          EndIf;

          RqsCtlBlk.SrtKeyInf(2) = SrtKeyInfDs;

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

          LstRcd.ObjLib = ObjInf.ObjLib;
          LstRcd.ObjNam = ObjInf.ObjNam;
          LstRcd.ObjTxt = KeyFld.ObjTxt;
          LstRcd.SavCmd = KeyFld.SavCmd;
          LstRcd.SavDev = KeyFld.SavDev;
          LstRcd.SavVol = KeyFld.SavVol;
          LstRcd.SavSeq = KeyFld.SavSeq;
          LstRcd.SavLbl = KeyFld.SavLbl;

          If  KeyFld.SavDts = *Allx'00';
            LstRcd.SavDat = *Blanks;
          Else;
            LstRcd.SavDat = %Char( CvtDtsDat( KeyFld.SavDts ): *DMY/);
          EndIf;

          If  KeyFld.RstDts = *Allx'00';
            LstRcd.RstDat = *Blanks;
          Else;
            LstRcd.RstDat = %Char( CvtDtsDat( KeyFld.RstDts ): *DMY/);
          EndIf;

          SortIo( RqsCtlBlkIo
                : LstRcd
                : SrtApi.Omit
                : SrtApi.DtaBufLen
                : DtaBufInf
                : ERRC0100
                );

        EndSr;

        BegSr  WrtSrtLst;

          If  PxObjLvl = '*LIB'  Or  ObjLib = '*NONE';
            WrtLstHdr( *Omit: *Omit );
          EndIf;

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

            DoW  DtaBufInf.RcdAvl > *Zero  And  ERRC0100.BytAvl = *Zero;

              If  PxObjLvl = '*OBJ'  And  ObjLib <> '*NONE';

                If  LstRcd.ObjLib <> ObjLib;

                  WrtLstHdr( LstRcd.ObjLib: *Omit );
                  ObjLib = LstRcd.ObjLib;
                EndIf;
              EndIf;

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

          If  PxIncDat.NbrElm = 2;

            If  PxIncDat.SavDat = '0010000';
              SavDat = %Date();
            Else;
              SavDat = %Date( PxIncDat.SavDat: *CYMD0 );
            EndIf;
          EndIf;

          LstTim = %Int( %Char( %Time(): *ISO0));
          SysNam = GetSysNam();

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           36 'System:'
     O                       SysNam              45
     O                                           80 'Save information'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LibHdr         2
     O                                           26 'Object library . . . . . -
     O                                              :'
     O                       ObjLib              38
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            6 'Object'
     O                                           22 'Description'
     O                                           66 'Saved'
     O                                           79 'Restored'
     O                                           90 'Save cmd.'
     O                                           96 'Dev.'
     O                                          107 'Volume ID'
     O                                          114 'Seq.'
     O                                          120 'Label'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.ObjNam       10
     O                       LstRcd.ObjTxt       61
     O                       LstRcd.SavDat       69
     O                       LstRcd.RstDat       79
     O                       LstRcd.SavCmd       91
     O                       LstRcd.SavDev       97
     O                       LstRcd.SavVol      108
     O                       LstRcd.SavSeq Z    114
     O                       LstRcd.SavLbl      132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34
     **-- Write detail line:  ------------------------------------------------**
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtLstHdr( *Omit: 3 );

        Except  DtlLin;

      /End-Free

     P WrtDtlLin       E
     **-- Write list header:  ------------------------------------------------**
     P WrtLstHdr       B
     D                 Pi
     D  PxObjLib                     10a   Const  Options( *Omit )
     D  PxOvrFlwRel                  10i 0 Const  Options( *Omit )

      /Free

        If  %Addr( PxOvrFlwRel) = *Null;

          Except  Header;

          If  %Addr( PxObjLib ) <> *Null;
            WrtLibHdr( PxObjLib );
          EndIf;

          Except  LstHdr;
        Else;

          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;

            Except  Header;

            If  %Addr( PxObjLib ) <> *Null;
              WrtLibHdr( PxObjLib );
            EndIf;

            Except  LstHdr;
          EndIf;
        EndIf;

      /End-Free

     P WrtLstHdr       E
     **-- Write library header:  ---------------------------------------------**
     P WrtLibHdr       B
     D                 Pi
     D  PxObjLib                     10a   Const

      /Free

        ObjLib = PxObjLib;

        Except  LibHdr;

      /End-Free

     P WrtLibHdr       E
     **-- Write list trailer:  -----------------------------------------------**
     P WrtLstTrl       B
     D                 Pi
     D  PxTrlTxt                     32a   Const

      /Free

        TrlTxt = PxTrlTxt;

        Except  LstTrl;

      /End-Free

     P WrtLstTrl       E
     **-- Convert system DTS to date:  ---------------------------------------**
     P CvtDtsDat       B
     D                 Pi              d
     D  PxSysDts                      8a   Value

     D MI_DTS          s             20a

      /Free

        CvtDtf( '*DTS': PxSysDts: '*YYMD': MI_DTS: *Zero );

        Return  %Date( %Timestamp( MI_DTS: *ISO0 ));

      /End-Free

     P CvtDtsDat       E
     **-- Get system name:  --------------------------------------------------**
     P GetSysNam       B
     D                 Pi             8a   Varying
     **
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
