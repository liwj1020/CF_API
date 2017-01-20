     **
     **  Program . . : CBX9302
     **  Description : Print programs adopting special authorities - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will produce a list of all objects adopting the
     **    special authorities specified.
     **
     **
     **  Programmer's notes:
     **    Although Structured Query Language (SQL) packages also are
     **    capable of adopting special and private authorities, currently
     **    no programmatical method exists to identify object of type
     **    *SQLPKG that adopts authority:
     **
     **    http://www-912.ibm.com/s_dir/slkbase.nsf/1ac66549a21402188625680b0002037e/
     **      9fe5eef9a3d096c7862565c2007cef34?OpenDocument
     **
     **
     **  Authority and security restrictions:
     **    To successfully run this program *ALLOBJ special authority is
     **    necessary.  The required authority can be obtained by means of
     **    adopted authority:
     **
     **    -  Change the program object's USRPRF attribute to *OWNER using
     **       the CHGPGM command.
     **
     **    -  Change the program object owner to QSECOFR using the CHGOBJOWN
     **       command.
     **
     **    If you successfully follow the compile and setup instructions below,
     **    the program will be capable of performing the necessary operations.
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX9302 )
     **                DbgView( *NONE )
     **                Aut( *USE )
     **
     **    CrtPgm      Pgm( CBX9302 )
     **                Module( CBX9302 )
     **                ActGrp( *NEW )
     **                UsrPrf( *OWNER )
     **                Aut( *USE )
     **
     **    ChgObjOwn   Obj( CBX9302 )
     **                ObjType( *PGM )
     **                NewOwn( QSECOFR )
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
     D                SDs
     D  PsPgmNam         *Proc
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
     D ASCEND          c                   1
     D DESCEND         c                   2
     **
     D SRT_PUT         c                   1
     D SRT_END         c                   2
     D SRT_GET         c                   3
     D SRT_CNL         c                   4
     **-- Global variables:
     D LstTim          s              6s 0
     D SpcAutL         s             88a   Varying
     D ObjItr          s             10i 0
     D Idx             s             10i 0
     D AutFlg          s              1a
     D SrtAct          s               n
     **
     D SpcAut          Ds                  Qualified
     D  NbrAut                        5i 0
     D  AutVal                       10a   Dim( 8 )
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  ObjNam                       10a
     D  LibNam                       10a
     D  PgmTyp                       10a
     D  ObjAtr                       10a
     D  ObjTxt                       50a
     D  AdpPrf                       10a
     D  CrtPrf                       10a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 3 )
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
     D KEY0200         Ds                  Qualified
     D  InfSts                        1a
     D  ExtObjAtr                    10a
     D  TxtDsc                       50a
     D  UsrDfnAtr                    10a
     D  OrdLibL                      10i 0
     D                                5a
     **
     D ObjOwn          s             10a
     D CrtPrf          s             10a
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
     **-- Retrieve program information:
     D RtvPgmInf       Pr                  ExtPgm( 'QCLRPGMI' )
     D  PiRcvVar                  32767a          Options( *VarSize )
     D  PiRcvVarLen                  10i 0 Const
     D  PiFmtNam                      8a   Const
     D  PiPgmNamQ                    20a   Const
     D  PiError                   32767a          Options( *VarSize )
     **-- Retrieve service program information:
     D RtvSrvPgmI      Pr                  ExtPgm( 'QBNRSPGM' )
     D  SiRcvVar                  32767a          Options( *VarSize )
     D  SiRcvVarLen                  10i 0 Const
     D  SiFmtNam                      8a   Const
     D  SiPgmNamQ                    20a   Const
     D  SiError                   32767a          Options( *VarSize )
     **-- Check user special authority
     D ChkUsrSpcAut    Pr                  ExtPgm( 'QSYCUSRS' )
     D  CsAutInf                      1a
     D  CsUsrPrf                     10a   Const
     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
     D  CsNbrAut                     10i 0 Const
     D  CsCalLvl                     10i 0 Const
     D  CsError                   32767a          Options( *VarSize )
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

     **-- Retrieve program user profile attribute - by type:
     D RtvPgmUpaTyp    Pr            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     D  PxPgmTyp                     10a   Const
     **-- Retrieve program user profile attribute:
     D RtvPgmUpa       Pr            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     **-- Retrieve service program user profile attribute:
     D RtvSrvPgmUpa    Pr            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr

     D CBX9302         Pr
     D  PxPgmLib                     10a
     D  PxSpcAut                           LikeDs( SpcAut )
     D  PxSrtOrd                     10a
     D  PxSysObj                      4a
     **
     D CBX9302         Pi
     D  PxPgmLib                     10a
     D  PxSpcAut                           LikeDs( SpcAut )
     D  PxSrtOrd                     10a
     D  PxSysObj                      4a

      /Free

        LstApi.KeyFld(1) = 200;
        LstApi.KeyFld(2) = 302;
        LstApi.KeyFld(3) = 405;

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        For  ObjItr = 1  To 2;

          Select;
          When  ObjItr = 1;
            LstApi.ObjTyp = '*PGM';

          When  ObjItr = 2;
            LstApi.ObjTyp = '*SRVPGM';
          EndSl;

          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : 1
                 : SrtInf
                 : '*ALL      ' + PxPgmLib
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

              If    PxSysObj = '*YES'  Or  CrtPrf <> '*IBM';
                ExSr  ChkPgmAdp;
              EndIf;

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
        EndFor;

        ExSr  WrtSrtLst;

        *InLr = *On;

        Return;

        BegSr  GetKeyDta;

          pKeyInf = %Addr( ObjInf.Data );

          For  Idx = 1  To ObjInf.FldNbrRtn;

            Select;
            When  KeyInf.KeyFld = 200;

              KEY0200 = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 302;

              ObjOwn = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 405;

              CrtPrf = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
            EndSl;

            If  Idx < ObjInf.FldNbrRtn;
              pKeyInf = pKeyInf + KeyInf.FldInfLen;
            EndIf;
          EndFor;

        EndSr;

        BegSr  ChkPgmAdp;

          If  RtvPgmUpaTyp( ObjInf.ObjNam
                          : ObjInf.ObjLib
                          : ObjInf.ObjTyp
                          ) = '*OWNER';

            ChkUsrSpcAut( AutFlg
                        : ObjOwn
                        : PxSpcAut.AutVal
                        : PxSpcAut.NbrAut
                        : ADP_PRV_INVLVL
                        : ERRC0100
                        );

            If  ERRC0100.BytAvl = *Zero;

              If  AutFlg = 'Y';

                ExSr AddSrtLst;
              EndIf;
            EndIf;
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

          When  PxSrtOrd = '*ADPPRF';
            SrtKeyInfDs.KeyStrPos = 91;

          When  PxSrtOrd = '*CRTPRF';
            SrtKeyInfDs.KeyStrPos = 101;

          When  PxSrtOrd = '*TYPOBJ';
            SrtKeyInfDs.KeyStrPos = 21;
          EndSl;

          RqsCtlBlk.SrtKeyInf(1) = SrtKeyInfDs;

          Select;
          When  PxSrtOrd = '*LIBOBJ';
            SrtKeyInfDs.KeyStrPos = 1;

          When  PxSrtOrd = '*OBJ   ';
            SrtKeyInfDs.KeyStrPos = 11;

          When  PxSrtOrd = '*ADPPRF';
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
          LstRcd.PgmTyp = ObjInf.ObjTyp;
          LstRcd.ObjAtr = KEY0200.ExtObjAtr;
          LstRcd.ObjTxt = KEY0200.TxtDsc;
          LstRcd.AdpPrf = ObjOwn;
          LstRcd.CrtPrf = CrtPrf;

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

          SpcAutL = PxSpcAut.AutVal(1);
          For  Idx = 2  To PxSpcAut.NbrAut;

            SpcAutL = SpcAutL + ' ' + PxSpcAut.AutVal(Idx);
          EndFor;

          WrtLstHdr();

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           75 'Programs adopting special -
     O                                              authorities'
     O                                          107 'Program:'
     O                       PsPgmNam           118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           27 'Program library . . . . . -
     O                                              :'
     O                       PxPgmLib            39
     **
     OQSYSPRT   EF           LstHdr         2
     O                                           27 'Special authorities . . . -
     O                                              :'
     O                       SpcAutL            117
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            6 'Object'
     O                                           19 'Library'
     O                                           28 'Type'
     O                                           45 'Attribute'
     O                                           52 'Text'
     O                                          114 'User profile'
     O                                          125 'Creator'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.ObjNam       10
     O                       LstRcd.LibNam       22
     O                       LstRcd.PgmTyp       34
     O                       LstRcd.ObjAtr       46
     O                       LstRcd.ObjTxt       98
     O                       LstRcd.AdpPrf      112
     O                       LstRcd.CrtPrf      128
     **
     OQSYSPRT   EF           LstTrl         1
     O                                           30 '***  E N D  O F  L I S T  -
     O                                              ***'
     **-- Retrieve program user profile attribute - by type:  ----------------**
     P RtvPgmUpaTyp    B                   Export
     D                 Pi            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     D  PxPgmTyp                     10a   Const
     **

      /Free

        Select;
        When  PxPgmTyp = '*PGM';

          Return  RtvPgmUpa( PxPgmNam: PxPgmLib );

        When  PxPgmTyp = '*SRVPGM';

          Return  RtvSrvPgmUpa( PxPgmNam: PxPgmLib );

        Other;
          Return  *Blanks;
        EndSl;

      /End-Free

     P RtvPgmUpaTyp    E
     **-- Retrieve program user profile attribute:  --------------------------**
     P RtvPgmUpa       B                   Export
     D                 Pi            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     **
     D PGMI0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  PgmNam                       10a
     D  PgmLib                       10a
     D  PgmOwn                       10a
     D  PgmAtr                       10a
     D  UsrPrf                        1a   Overlay( PGMI0100: 106 )
     D  UseAdpAut                     1a   Overlay( PGMI0100: 107 )
     D  LogCmd                        1a   Overlay( PGMI0100: 108 )
     D  AlwRtvSrc                     1a   Overlay( PGMI0100: 109 )

      /Free

        RtvPgmInf( PGMI0100
                 : %Size( PGMI0100 )
                 : 'PGMI0100'
                 : PxPgmNam + PxPgmLib
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        When  PGMI0100.UsrPrf = 'U';
          Return  '*USER';

        When  PGMI0100.UsrPrf = 'O';
          Return  '*OWNER';

        Other;
          Return  *Blanks;
        EndSl;

      /End-Free

     P RtvPgmUpa       E
     **-- Retrieve service program user profile attribute:  ------------------**
     P RtvSrvPgmUpa    B                   Export
     D                 Pi            10a
     D  PxPgmNam                     10a   Const
     D  PxPgmLib                     10a   Const
     **
     D SPGI0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  PgmNam                       10a
     D  PgmLib                       10a
     D  PgmOwn                       10a
     D  PgmAtr                       10a
     D  UsrPrf                        1a   Overlay( SPGI0100: 138 )
     D  TxtDsc                       50a   Overlay( SPGI0100: 157 )
     D  UseAdpAut                     1a   Overlay( SPGI0100: 213 )
     D  PgmStt                        1a   Overlay( SPGI0100: 307 )
     D  PgmDmn                        1a   Overlay( SPGI0100: 308 )

      /Free

        RtvSrvPgmI( SPGI0100
                  : %Size( SPGI0100 )
                  : 'SPGI0100'
                  : PxPgmNam + PxPgmLib
                  : ERRC0100
                  );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        When  SPGI0100.UsrPrf = 'U';
          Return  '*USER';

        When  SPGI0100.UsrPrf = 'O';
          Return  '*OWNER';

        Other;
          Return  *Blanks;
        EndSl;

      /End-Free

     P RtvSrvPgmUpa    E
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
