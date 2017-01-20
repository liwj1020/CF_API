     **
     **  Program . . : CBX956
     **  Description : Print user's authorization lists
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX956 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX956 )
     **                Module( CBX956 )
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
     D PgmSts         sDs                  Qualified
     D  PgmNam           *Proc
     D  JobUsr                       10a   Overlay( PgmSts: 254 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global constants:
     D USR_SPC_Q       c                   'AUTOBJLST QTEMP'
     D OFS_MSGDTA      c                   16
     D MAX_GRPPRF      c                   16
     **
     D NBR_KEY         c                   1
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
     D Idx             s             10i 0
     D GrpIdx          s             10i 0
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     D SrtAct          s               n
     D UsrPrf          s             10a
     D GrpPrf          s             10a
     D GrpPrfLst       s             10a   Dim( MAX_GRPPRF )
     **-- API parameters:
     D LstPrf          s             10a
     D CntHdl          s             20a   Inz
     **
     D RqsLst          Ds                  Qualified
     D  NbrRqs                       10i 0
     D  RqsEnt                       10a   Dim( 3 )
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  AutLst                       10a
     D  ObjOwn                        4a
     D  AutVal                       10a
     D  AutFlg
     D  AutlMgt                       1a   Overlay( AutFlg: 1 )
     D  ObjOpr                        1a   Overlay( AutFlg: *Next )
     D  ObjMgt                        1a   Overlay( AutFlg: *Next )
     D  ObjExs                        1a   Overlay( AutFlg: *Next )
     D  ObjAlt                        1a   Overlay( AutFlg: *Next )
     D  ObjRef                        1a   Overlay( AutFlg: *Next )
     D  DtaRead                       1a   Overlay( AutFlg: *Next )
     D  DtaAdd                        1a   Overlay( AutFlg: *Next )
     D  DtaUpd                        1a   Overlay( AutFlg: *Next )
     D  DtaDlt                        1a   Overlay( AutFlg: *Next )
     D  DtaExe                        1a   Overlay( AutFlg: *Next )
     **-- Entry format OBJA0200:
     D OBJA0200        Ds                  Qualified  Based( pLstEnt )
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  AutHlr                        1a
     D  ObjOwn                        1a
     D  AutVal                       10a
     D  AutlMgt                       1a
     D  ObjOpr                        1a
     D  ObjMgt                        1a
     D  ObjExs                        1a
     D  DtaRead                       1a
     D  DtaAdd                        1a
     D  DtaUpd                        1a
     D  DtaDlt                        1a
     D  DtaExe                        1a
     D                               10a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     D  AspDevLib                    10a
     D  AspDevObj                    10a
     **-- API input parameter information:
     D InpPrm          Ds                  Qualified  Based( pInpPrm )
     D  UsrSpc                       10a
     D  UsrSpcLib                    10a
     D  FmtNam                        8a
     D  UsrPrf                       10a
     D  ObjTyp                       10a
     D  RtnObj                       10a
     D  CntHdl                       20a
     D  OfsRqsLst                    10i 0
     D  NbrLstEnt                    10i 0
     D  RqsLst                       30a
     **-- API header information:
     D HdrInf          Ds                  Qualified  Based( pHdrInf )
     D  UsrPrf                       10a
     D  CntHdl                       20a
     D  RsnCod                       10i 0
     **-- User space generic header:
     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
     D  OfsInp                       10i 0 Overlay( UsrSpc: 109 )
     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
     **-- Space pointers:
     D pUsrSpc         s               *   Inz( *Null )
     D pInpPrm         s               *   Inz( *Null )
     D pHdrInf         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )

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
     D  RcdAvl                       10i 0 Inz( *Zero )
     D                                8a

     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- List authorized users:
     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
     D  SpcNamQ                      20a   Const
     D  FmtNam                        8a   Const
     D  UsrPrf                       10a   Const
     D  ObjTyp                       10a   Const
     D  RtnObj                       10a   Const
     D  CntHdl                       20a   Const
     D  Error                     32767a          Options( *VarSize )
     D  RqsLst                       30a          Options( *VarSize: *NoPass )
     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  SpcNamQ                      20a   Const
     D  ExtAtr                       10a   Const
     D  InzSiz                       10i 0 Const
     D  InzVal                        1a   Const
     D  PubAut                       10a   Const
     D  Text                         50a   Const
     D  Replace                      10a   Const  Options( *NoPass )
     D  Error                     32767a          Options( *NoPass: *VarSize )
     D  Domain                       10a   Const  Options( *NoPass )
     D  TfrSizRqs                    10i 0 Const  Options( *NoPass )
     D  OptSpcAlg                     1a   Const  Options( *NoPass )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  SpcNamQ                      20a   Const
     D  Pointer                        *
     D  Error                     32767a          Options( *NoPass: *VarSize )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  SpcNamQ                      20a   Const
     D  Error                     32767a          Options( *VarSize )
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
     D  Error                      1024a          Options( *VarSize )
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  NbrNetAtr                    10i 0 Const
     D  NetAtr                       10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  Error                     32767a          Options( *VarSize )

     **-- Get group profiles:
     D GetGrpPrf       Pr            10a   Dim( MAX_GRPPRF )
     D  PxUsrPrf                     10a   Const
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
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX956          Pr
     D  PxUsrPrf                     10a
     D  PxIncGrp                      1a
     **
     D CBX956          Pi
     D  PxUsrPrf                     10a
     D  PxIncGrp                      1a

      /Free

        CrtUsrSpc( USR_SPC_Q
                 : *Blanks
                 : 65535
                 : x'00'
                 : '*CHANGE'
                 : *Blanks
                 : '*YES'
                 : ERRC0100
                 );

        RtvPtrSpc( USR_SPC_Q: pUsrSpc );

        RqsLst.NbrRqs = 3;
        RqsLst.RqsEnt(1) = '*OBJAUT';
        RqsLst.RqsEnt(2) = '*OBJOWN';
        RqsLst.RqsEnt(3) = '*OBJPGP';

        UsrPrf = PxUsrPrf;
        LstPrf = UsrPrf;
        GrpPrf = '*NONE';

        ExSr  GetObjLst;

        If  PxIncGrp = 'Y';
          GrpPrfLst = GetGrpPrf( PxUsrPrf );

          For  GrpIdx = 1  to  %Elem( GrpPrfLst );

            If  GrpPrfLst(GrpIdx) = *Blanks;
              Leave;
            EndIf;

            GrpPrf = GrpPrfLst(GrpIdx);
            LstPrf = GrpPrf;

            ExSr  GetObjLst;

          EndFor;
        EndIf;

        WrtLstTrl( '***  E N D  O F  L I S T  ***' );

        SndCmpMsg( 'Authorization lists printed for user profile ' +
                   %TrimR( PxUsrPrf )                             +
                   '.'
                 );

        DltUsrSpc( USR_SPC_Q: ERRC0100 );

        *InLr = *On;
        Return;

        BegSr  GetObjLst;

          WrtLstHdr( *Omit );

          DoU  CntHdl = *Blanks;

            LstUsrObj( USR_SPC_Q
                     : 'OBJA0200'
                     : LstPrf
                     : '*AUTL'
                     : '*REQLIST'
                     : CntHdl
                     : ERRC0100
                     : RqsLst
                     );

            If  ERRC0100.BytAvl > *Zero;
              ExSr  SndErrMsg;

            Else;
              ExSr  GetUsrObj;
            EndIf;
          EndDo;

          ExSr  WrtSrtLst;

        EndSr;

        BegSr  GetUsrObj;

          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          If  UsrSpc.NumLstEnt = *Zero;

          Else;
            For  Idx = 1  To  UsrSpc.NumLstEnt;

              ExSr  AddSrtLst;

              If  Idx < UsrSpc.NumLstEnt;
                pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
              EndIf;
            EndFor;
          EndIf;

          CntHdl = InpPrm.CntHdl;

        EndSr;

        BegSr  InzSrtLst;

          SrtKeyInfDs.KeySize   = %Size( LstRcd.AutLst );
          SrtKeyInfDs.KeyDtaTyp = CHAR_NLS;
          SrtKeyInfDs.KeyOrder  = ASCEND;
          SrtKeyInfDs.KeyStrPos = 1;

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

          LstRcd.AutLst  =  OBJA0200.ObjNam;

          Select;
          When  OBJA0200.ObjOwn = 'Y';
            LstRcd.ObjOwn  =  '*YES';
          When  OBJA0200.ObjOwn = 'G';
            LstRcd.ObjOwn  =  '*PGP';
          When  OBJA0200.ObjOwn = 'N';
            LstRcd.ObjOwn  =  '*NO';
          Other;
            LstRcd.ObjOwn  =  '*';
          EndSl;

          LstRcd.AutVal  =  OBJA0200.AutVal;
          LstRcd.AutlMgt =  OBJA0200.AutlMgt;
          LstRcd.ObjOpr  =  OBJA0200.ObjOpr;
          LstRcd.ObjMgt  =  OBJA0200.ObjMgt;
          LstRcd.ObjExs  =  OBJA0200.ObjExs;
          LstRcd.ObjAlt  =  OBJA0200.ObjAlt;
          LstRcd.ObjRef  =  OBJA0200.ObjRef;
          LstRcd.DtaRead =  OBJA0200.DtaRead;
          LstRcd.DtaAdd  =  OBJA0200.DtaAdd;
          LstRcd.DtaUpd  =  OBJA0200.DtaUpd;
          LstRcd.DtaDlt  =  OBJA0200.DtaDlt;
          LstRcd.DtaExe  =  OBJA0200.DtaExe;

          LstRcd.AutFlg = %Xlate( 'YN': 'X ': LstRcd.AutFlg );

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

          If  DtaBufInf.RcdAvl = *Zero;
            WrtLstTrl( '(No authorization lists found)' );

          Else;
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

        BegSr  SndErrMsg;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
                   );

        EndSr;

        BegSr  *InzSr;

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
     O                                           85 'User Authorization Lists'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           26 'User profile . . . . . . :'
     O                       UsrPrf              38
     OQSYSPRT   EF           LstHdr         1
     O                                           26 '  Group profile  . . . . :'
     O                       GrpPrf              38
     OQSYSPRT   EF           LstHdr      1  1
     O                                           13 'Authorization'
     O                                           44 'List'
     O                                           83 '------------- Object ------
     O                                              ---------'
     O                                          123 '--------------- Data ------
     O                                              ----------'
     OQSYSPRT   EF           LstHdr         1
     O                                            4 'List'
     O                                           20 'Owner'
     O                                           33 'Authority'
     O                                           43 'Mgt'
     O                                           51 'Opr'
     O                                           59 'Mgt'
     O                                           68 'Exist'
     O                                           76 'Alter'
     O                                           83 'Ref'
     O                                           91 'Read'
     O                                           99 'Add'
     O                                          107 'Upd'
     O                                          115 'Dlt'
     O                                          123 'Exe'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.AutLst       10
     O                       LstRcd.ObjOwn       19
     O                       LstRcd.AutVal       34
     O                       LstRcd.AutlMgt      42
     O                       LstRcd.ObjOpr       50
     O                       LstRcd.ObjMgt       58
     O                       LstRcd.ObjExs       66
     O                       LstRcd.ObjAlt       74
     O                       LstRcd.ObjRef       82
     O                       LstRcd.DtaRead      90
     O                       LstRcd.DtaAdd       98
     O                       LstRcd.DtaUpd      106
     O                       LstRcd.DtaDlt      114
     O                       LstRcd.DtaExe      122
     **
     OQSYSPRT   EF           LstTrl      1  1
     O                       TrlTxt              34

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
     **-- Get group profiles:
     P GetGrpPrf       B                   Export
     D                 Pi            10a   Dim( MAX_GRPPRF )
     D  PxUsrPrf                     10a   Const

     **-- Local declarations:
     D MAX_SUPGRP      c                   15
     D MAX_SPCAUT      c                   15
     D GrpPrf          s             10a   Inz  Dim( MAX_GRPPRF )
     D GrpIdx          s             10i 0 Inz
     D Idx             s             10i 0
     **-- User information structure:
     D USRI0200        Ds           512    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  SpcAut                        1a   Overlay( USRI0200: 29 )
     D                                     Dim( MAX_SPCAUT )
     D  GrpPrf                       10a   Overlay( USRI0200: 44 )
     D  SupGrpOfs                    10i 0 Overlay( USRI0200: 97 )
     D  SupGrpNbr                    10i 0 Overlay( USRI0200: 101 )
     **
     D SupGrpPrf       s             10a   Based( pSupGrpPrf )
     D                                     Dim( MAX_SUPGRP )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl = *Zero;
          pSupGrpPrf = %Addr( USRI0200 ) + USRI0200.SupGrpOfs;

          If  USRI0200.GrpPrf <> '*NONE';
            GrpIdx += 1;
            GrpPrf(GrpIdx) = USRI0200.GrpPrf;
          EndIf;

          For  Idx = 1 to  USRI0200.SupGrpNbr;
            GrpIdx += 1;
            GrpPrf(GrpIdx) = SupGrpPrf(Idx);
          EndFor;
        EndIf;

        Return  GrpPrf;

      /End-Free

     P GetGrpPrf       E
