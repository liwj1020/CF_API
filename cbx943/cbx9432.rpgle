     **
     **  Program . . : CBX9432
     **  Description : Print journal report - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will produce a list of all objects currently either
     **    being journaled or not being journaled.
     **
     **
     **  Authority and security restrictions:
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX9432 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX9432 )
     **                Module( CBX9432 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )

     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )

     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
     **-- System information:
     D PgmSts         sDs                  Qualified
     D  PgmNam           *Proc

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global constants:
     D OBJ_JRN         c                   '1'
     D OBJ_NOT_JRN     c                   '0'
     D NBR_KEY         c                   2
     D KEY_OFS         c                   80
     D SIZ_NLS_INF     c                   290
     D JOB_RUN         c                   0
     D CHAR_NLS        c                   4
     D ASCEND          c                   1
     D DESCEND         c                   2
     **
     D SRT_PUT         c                   1
     D SRT_END         c                   2
     D SRT_GET         c                   3
     D SRT_CNL         c                   4
     **-- Global variables:
     D LstTim          s              6s 0
     D Idx             s             10i 0
     D SrtAct          s               n
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  ObjNam                       10a
     D  LibNam                       10a
     D  ObjTyp                       10a
     D  ObjTxt                       50a
     D  CrtPrf                       10a
     D  JrnSts                        8a
     D  JrnNam                       10a
     D  JrnLib                       10a

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 6 )
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
     D  TxtDsc                       50a
     D  ExtObjAtr                    10a
     D  ObjOwn                       10a
     D  CrtPrf                       10a
     D  JrnSts                        1a
     D  JrnNam                       10a
     D  JrnLib                       10a
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
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  SrtInf                     1024a   Const  Options( *VarSize )
     D  ObjNam_q                     20a   Const
     D  ObjTyp                       10a   Const
     D  AutCtl                     1024a   Const  Options( *VarSize )
     D  SltCtl                     1024a   Const  Options( *VarSize )
     D  NbrKeyRtn                    10i 0 Const
     D  KeyFld                       10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  Error                      1024a          Options( *VarSize )
     **
     D  JobIdInf                    256a          Options( *NoPass: *VarSize )
     D  JobIdFmt                      8a   Const  Options( *NoPass )
     **
     D  AspCtl                      256a          Options( *NoPass: *VarSize )
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

     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr

     D CBX9432         Pr
     D  PxObjLib                     10a
     D  PxObjTyp                     10a
     D  PxRptTyp                     10a
     D  PxSrtOrd                     10a
     **
     D CBX9432         Pi
     D  PxObjLib                     10a
     D  PxObjTyp                     10a
     D  PxRptTyp                     10a
     D  PxSrtOrd                     10a

      /Free

        LstApi.KeyFld(1) = 202;
        LstApi.KeyFld(2) = 203;
        LstApi.KeyFld(3) = 405;
        LstApi.KeyFld(4) = 513;
        LstApi.KeyFld(5) = 514;
        LstApi.KeyFld(6) = 515;

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        If  PxObjTyp = '*FILE'  Or  PxObjTyp = '*ALL';
          LstApi.ObjTyp = '*FILE';

          ExSr  GetObjLst;
        EndIf;

        If  PxObjTyp = '*DTAARA'  Or  PxObjTyp = '*ALL';
          LstApi.ObjTyp = '*DTAARA';

          ExSr  GetObjLst;
        EndIf;

        If  PxObjTyp = '*DTAQ'  Or  PxObjTyp = '*ALL';
          LstApi.ObjTyp = '*DTAQ';

          ExSr  GetObjLst;
        EndIf;

        ExSr  WrtSrtLst;

        *InLr = *On;

        Return;

        BegSr  GetObjLst;

          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : 1
                 : SrtInf
                 : '*ALL      ' + PxObjLib
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

              ExSr  ChkJrnSts;

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

        EndSr;

        BegSr  GetKeyDta;

          pKeyInf = %Addr( ObjInf.Data );

          For  Idx = 1  To ObjInf.FldNbrRtn;

            Select;
            When  KeyInf.KeyFld = 202;
              KeyFld.ExtObjAtr = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 203;
              KeyFld.TxtDsc = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 405;
              KeyFld.CrtPrf = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 513;
              KeyFld.JrnSts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 514;
              KeyFld.JrnNam = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 515;
              KeyFld.JrnLib = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
            EndSl;

            If  Idx < ObjInf.FldNbrRtn;
              pKeyInf = pKeyInf + KeyInf.FldInfLen;
            EndIf;
          EndFor;

        EndSr;

        BegSr  ChkJrnSts;

          If  ObjInf.ObjTyp = '*FILE'   And  KeyFld.ExtObjAtr  = 'PF'        Or
              ObjInf.ObjTyp = '*DTAQ'   And  KeyFld.ExtObjAtr <> 'DDMDTAQUE' Or
              ObjInf.ObjTyp = '*DTAARA' And  KeyFld.ExtObjAtr <> 'DDMDTAARA';

            Select;
            When  PxRptTyp = '*JRN'  And  KeyFld.JrnSts = OBJ_JRN;
              ExSr AddSrtLst;

            When  PxRptTyp = '*NOTJRN'  And  KeyFld.JrnSts = OBJ_NOT_JRN;
              ExSr AddSrtLst;
            EndSl;
          EndIf;

        EndSr;

        BegSr  InzSrtLst;

          SrtKeyInfDs.KeySize   = 10;
          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
          SrtKeyInfDs.KeyOrder  = ASCEND;

          Select;
          When  PxSrtOrd = '*LIBOBJ';
            SrtKeyInfDs.KeyStrPos = 11;

          When  PxSrtOrd = '*OBJ   ';
            SrtKeyInfDs.KeyStrPos = 1;

          When  PxSrtOrd = '*JRNLIB';
            SrtKeyInfDs.KeyStrPos = 99;

          When  PxSrtOrd = '*CRTPRF';
            SrtKeyInfDs.KeyStrPos = 81;

          When  PxSrtOrd = '*TYPOBJ';
            SrtKeyInfDs.KeyStrPos = 21;
          EndSl;

          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;

          Select;
          When  PxSrtOrd = '*LIBOBJ';
            SrtKeyInfDs.KeyStrPos = 1;

          When  PxSrtOrd = '*OBJ   ';
            SrtKeyInfDs.KeyStrPos = 11;

          When  PxSrtOrd = '*JRNLIB';
            SrtKeyInfDs.KeyStrPos = 1;

          When  PxSrtOrd = '*CRTPRF';
            SrtKeyInfDs.KeyStrPos = 1;

          When  PxSrtOrd = '*TYPOBJ';
            SrtKeyInfDs.KeyStrPos = 1;
          EndSl;

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

          LstRcd.ObjNam = ObjInf.ObjNam;
          LstRcd.LibNam = ObjInf.ObjLib;
          LstRcd.ObjTyp = ObjInf.ObjTyp;
          LstRcd.ObjTxt = KeyFld.TxtDsc;
          LstRcd.CrtPrf = KeyFld.CrtPrf;
          LstRcd.JrnNam = KeyFld.JrnNam;
          LstRcd.JrnLib = KeyFld.JrnLib;

          If  KeyFld.JrnSts = OBJ_JRN;
            LstRcd.JrnSts = '*JRN';
          Else;
            LstRcd.JrnSts = '*NOTJRN';
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

          WrtLstTrl();

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

        EndSr;

        BegSr  *InzSr;

          LstTim = %Int( %Char( %Time(): *ISO0));

          WrtLstHdr();

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           65 'Journal report'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           27 'Object library  . . . . . -
     O                                              :'
     O                       PxObjLib            39
     **
     OQSYSPRT   EF           LstHdr         2
     O                                           27 'List type . . . . . . . . -
     O                                              :'
     O                       PxRptTyp            39
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            6 'Object'
     O                                           19 'Library'
     O                                           28 'Type'
     O                                           40 'Text'
     O                                           95 'Creator'
     O                                          106 'Status'
     O                                          117 'Journal'
     O                                          129 'Library'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.ObjNam       10
     O                       LstRcd.LibNam       22
     O                       LstRcd.ObjTyp       34
     O                       LstRcd.ObjTxt       86
     O                       LstRcd.CrtPrf       98
     O                       LstRcd.JrnSts      108
     O                       LstRcd.JrnNam      120
     O                       LstRcd.JrnLib      132
     **
     OQSYSPRT   EF           LstTrl         1
     O                                           30 '***  E N D  O F  L I S T  -
     O                                              ***'
     **-- Write detail line:  ------------------------------------------------**
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtLstHdr( 3 );

        Except  DtlLin;

      /End-Free

     P WrtDtlLin       E
     **-- Write list header:  ------------------------------------------------**
     P WrtLstHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        If  %Parms = *Zero;

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
     **-- Write list trailer:  -----------------------------------------------**
     P WrtLstTrl       B
     D                 Pi

      /Free

        Except  LstTrl;

      /End-Free

     P WrtLstTrl       E
