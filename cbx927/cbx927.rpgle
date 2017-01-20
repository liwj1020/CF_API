     **
     **  Program . . : CBX927
     **  Description : Display Attributes - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will print all available attributes of an IFS
     **    (Integrated File System) object.  The resulting printer file
     **    will either be displayed, and subsequently deleted, or released
     **    for printing.
     **
     **
     **  Programmer's notes:
     **    The following Qp0lGetAttr attribute-IDs are supported as of V5R2 only:
     **
     **       29  QP0L_ATTR_SYS_SIGNED     Signed by a trusted source
     **       30  QP0L_ATTR_MULT_SIGS      More than one OS/400 digital signature
     **       31  QP0L_ATTR_DISK_STG_OPT   How to allocate auxiliary storage
     **       32  QP0L_ATTR_MAIN_STG_OPT   How to allocate main storage
     **       33  QP0L_ATTR_DIR_FORMAT     Directory format; *TYPE1, *TYPE2
     **       34  QP0L_ATTR_AUDIT          Object auditing value
     **      301  QP0L_ATTR_SUID           Set effective user ID
     **      302  QP0L_ATTR_SGID           Set effective group ID
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX927 )  DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX927 )
     **              Module( CBX927 )
     **              ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )  DecEdit( *JOBRUN )
     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
     F                                      UsrOpn
     **-- Printer file information:
     D PrtLinInf       Ds
     D  PlOvfLin                      5i 0  Overlay( PrtLinInf: 188 )
     D  PlCurLin                      5i 0  Overlay( PrtLinInf: 367 )
     D  PlCurPag                      5i 0  Overlay( PrtLinInf: 369 )
     **-- System information:
     D                SDs
     D  PsPgmNam         *Proc
     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Global variables:
     D LstTim          s              6s 0
     D IfsObj          s            109a
     D LinTxt          s             40a
     D LinVal          s             50a
     D MI_Time         s              8a
     D MI_DTS          s             20a
     **
     D BufSizAvl       s             10u 0 Inz( 0 )
     D NbrBytRtn       s             10u 0 Inz( 0 )
     D ApiRcvSiz       s             10u 0
     D rc              s             10i 0
     D Idx             s             10i 0
     D pBuffer         s               *
     D ErrTxt          s            256a
     D MsgKey          s              4a
     **-- API path constants:
     D CUR_CCSID       c                   0
     D CUR_CTRID       c                   x'0000'
     D CUR_LNGID       c                   x'000000'
     D CHR_DLM_1       c                   0
     **
     D CVTTIME_TO_OFFSET...
     D                 c                   0
     D CVTTIME_TO_TIMESTAMP...
     D                 c                   1
     D CVTTIME_FACTOR_EPOCH_ONLY...
     D                 c                   2
     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
     D                 c                   3
     **
     **-- File attributes:
     D ALL_AVL_ATR     c                   0
     **
     D QP0L_ATTR_OBJTYPE...
     D                 c                   0
     D QP0L_ATTR_DATA_SIZE...
     D                 c                   1
     D QP0L_ATTR_ALLOC_SIZE...
     D                 c                   2
     D QP0L_ATTR_EXTENDED_ATTR_SIZE...
     D                 c                   3
     D QP0L_ATTR_CREATE_TIME...
     D                 c                   4
     D QP0L_ATTR_ACCESS_TIME...
     D                 c                   5
     D QP0L_ATTR_CHANGE_TIME...
     D                 c                   6
     D QP0L_ATTR_MODIFY_TIME...
     D                 c                   7
     D QP0L_ATTR_STG_FREE...
     D                 c                   8
     D QP0L_ATTR_CHECKED_OUT...
     D                 c                   9
     D QP0L_ATTR_LOCAL_REMOTE...
     D                 c                   10
     D QP0L_ATTR_AUTH  c                   11
     D QP0L_ATTR_FILE_ID...
     D                 c                   12
     D QP0L_ATTR_ASP   c                   13
     D QP0L_ATTR_DATA_SIZE_64...
     D                 c                   14
     D QP0L_ATTR_ALLOC_SIZE_64...
     D                 c                   15
     D QP0L_ATTR_USAGE_INFORMATION...
     D                 c                   16
     D QP0L_ATTR_PC_READ_ONLY...
     D                 c                   17
     D QP0L_ATTR_PC_HIDDEN...
     D                 c                   18
     D QP0L_ATTR_PC_SYSTEM...
     D                 c                   19
     D QP0L_ATTR_PC_ARCHIVE...
     D                 c                   20
     D QP0L_ATTR_SYSTEM_ARCHIVE...
     D                 c                   21
     D QP0L_ATTR_CODEPAGE...
     D                 c                   22
     D QP0L_ATTR_FILE_FORMAT...
     D                 c                   23
     D QP0L_ATTR_UDFS_DEFAULT_FORMAT...
     D                 c                   24
     D QP0L_ATTR_JOURNAL_INFORMATION...
     D                 c                   25
     D QP0L_ATTR_ALWCKPWRT...
     D                 c                   26
     D QP0L_ATTR_CCSID...
     D                 c                   27
     D QP0L_ATTR_SIGNED...
     D                 c                   28
     D QP0L_ATTR_SYS_SIGNED...
     D                 c                   29
     D QP0L_ATTR_MULT_SIGS...
     D                 c                   30
     D QP0L_ATTR_DISK_STG_OPT...
     D                 c                   31
     D QP0L_ATTR_MAIN_STG_OPT...
     D                 c                   32
     D QP0L_ATTR_DIR_FORMAT...
     D                 c                   33
     D QP0L_ATTR_AUDIT...
     D                 c                   34
     D QP0L_ATTR_SUID  c                   300
     D QP0L_ATTR_SGID  c                   301
     **-- File attribute constants:
     D QP0L_SYS_NOT_STG_FREE...
     D                 c                   x'00'
     D QP0L_SYS_STG_FREE...
     D                 c                   x'01'
     D QP0L_NOT_CHECKED_OUT...
     D                 c                   x'00'
     D QP0L_CHECKED_OUT...
     D                 c                   x'01'
     D QP0L_LOCAL_OBJ  c                   x'01'
     D QP0L_REMOTE_OBJ...
     D                 c                   x'02'
     D QP0L_PC_NOT_READONLY...
     D                 c                   x'00'
     D QP0L_PC_READONLY...
     D                 c                   x'01'
     D QP0L_PC_NOT_HIDDEN...
     D                 c                   x'00'
     D QP0L_PC_HIDDEN...
     D                 c                   x'01'
     D QP0L_PC_NOT_SYSTEM...
     D                 c                   x'00'
     D QP0L_PC_SYSTEM...
     D                 c                   x'01'
     D QP0L_PC_NOT_CHANGED...
     D                 c                   x'00'
     D QP0L_PC_CHANGED...
     D                 c                   x'01'
     D QP0L_SYSTEM_NOT_CHANGED...
     D                 c                   x'00'
     D QP0L_SYSTEM_CHANGED...
     D                 c                   x'01'
     D QP0L_FILE_FORMAT_TYPE1...
     D                 c                   x'00'
     D QP0L_FILE_FORMAT_TYPE2...
     D                 c                   x'01'
     D QP0L_UDFS_DEFAULT_TYPE1...
     D                 c                   x'00'
     D QP0L_UDFS_DEFAULT_TYPE2...
     D                 c                   x'01'
     D QP0L_NOT_JOURNALED...
     D                 c                   x'00'
     D QP0L_JOURNALED  c                   x'01'
     D QP0L_JOURNAL_SUBTREE...
     D                 c                   x'80'
     D QP0L_JOURNAL_OPTIONAL_ENTRIES...
     D                 c                   x'08'
     D QP0L_JOURNAL_AFTER_IMAGES...
     D                 c                   x'20'
     D QP0L_JOURNAL_BEFORE_IMAGES...
     D                 c                   x'40'
     D QP0L_NOT_ALWCKPWRT...
     D                 c                   x'00'
     D QP0L_ALWCKPWRT...
     D                 c                   x'01'
     D QP0L_NOT_SIGNED...
     D                 c                   x'00'
     D QP0L_SIGNED     c                   x'01'
     D QP0L_SYSTEM_SIGNED_NO...
     D                 c                   x'00'
     D QP0L_SYSTEM_SIGNED_YES...
     D                 c                   x'01'
     D QP0L_MULT_SIGS_NO...
     D                 c                   x'00'
     D QP0L_MULT_SIGS_YES...
     D                 c                   x'01'
     D QP0L_STG_NORMAL...
     D                 c                   x'00'
     D QP0L_STG_MINIMIZE...
     D                 c                   x'01'
     D QP0L_STG_DYNAMIC...
     D                 c                   x'02'
     D QP0L_DIR_FORMAT_TYPE1...
     D                 c                   x'00'
     D QP0L_DIR_FORMAT_TYPE2...
     D                 c                   x'01'
     D QP0L_SUID_OFF   c                   x'00'
     D QP0L_SUID_ON    c                   x'01'
     D QP0L_SGID_OFF   c                   x'00'
     D QP0L_SGID_ON    c                   x'01'
     **-- Object attributes:
     D ObjTyp          s             10a
     D DtaSiz          s             10u 0
     D AlcSiz          s             10u 0
     D ExtAtrSiz       s             10u 0
     D ObjCrtDts       s             19a
     D ObjChgDts       s             19a
     D ObjAccDts       s             19a
     D DtaModDts       s             19a
     D StgFree         s             10a
     D ChkOutUsr       s             10a
     D ChkOutDts       s             19a
     D ObjLocRmt       s             10a
     D FileId          s             32a
     D ObjAsp          s              5i 0
     D DtaSiz_64       s             20u 0
     D AlcSiz_64       s             20u 0
     D DtsReset        s             10a
     D DtsLstUsd       s             10a
     D DaysUsdCnt      s             10i 0
     D ReadOnly        s             10a
     D ObjHid          s             10a
     D ObjSys          s             10a
     D ObjArcPc        s             10a
     D ObjArcSys       s             10a
     D DtaCcsId        s             10i 0
     D FilFmt          s             10a
     D UdfsDftFmt      s             10a
     **
     D JrnSts          s             10a   Inz( '*NO' )
     D JrnInhJrnA      s             10a
     D JrnOptEnt       s             10a
     D JrnImgBef       s             10a
     D JrnImgAft       s             10a
     D JrnId           s             20a   Inz( *All'0' )
     D JrnNam          s             10a
     D JrnLib          s             10a
     D JrnStrDts       s             19a
     **
     D AlwCkpWrt       s             10a
     D ObjSig          s             10a
     D ObjSigSys       s             10a
     D MltSig          s             10a
     D DiskStgOpt      s             10a
     D MainStgOpt      s             10a
     D DirFmt          s             10a
     D ObjAudVal       s             10a
     D SetEuid         s             10a
     D SetEgid         s             10a
     **
     D ObjOwn          s             10a
     D ObjPgp          s             10a
     D AutLstNam       s             10a
     D UsrNam          s             10a
     D UsrDtaAut       s             10a
     **
     D AutObjMgm       s              1a
     D AutObjExs       s              1a
     D AutObjAlt       s              1a
     D AutObjRef       s              1a
     D AutObjOpr       s              1a
     D AutDtaRead      s              1a
     D AutDtaAdd       s              1a
     D AutDtaUpd       s              1a
     D AutDtaDlt       s              1a
     D AutDtaExe       s              1a
     D AutDtaExcl      s              1a
     **-- Checkout format:
     D ChkOut          Ds                  Qualified  Align  Based( pChkOut )
     D  Ind                           1a
     D  User                         10a
     D                                1a
     D  Time                         10u 0
     **-- General authority format:
     D GenAut          Ds                  Qualified  Align  Based( pGenAut )
     D  ObjOwn                       10a
     D  PriGrp                       10a
     D  AutL                         10a
     D                               10a
     D  OfsUsrE                      10i 0
     D  NbrUsrE                      10i 0
     D  SizUsrE                      10i 0
     D                               12a
     **
     D UsrAut          Ds                  Qualified  Align  Based( pUsrAut )
     D  UsrNam                       10a
     D  UsrDtaAut                    10a
     D  ObjMgm                        1a
     D  ObjExs                        1a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     D                               10a
     D  ObjOpr                        1a
     D  DtaRead                       1a
     D  DtaAdd                        1a
     D  DtaUpd                        1a
     D  DtaDlt                        1a
     D  DtaExe                        1a
     D  DtaExclude                    1a
     D                                7a
     **-- Object usage format:
     D ObjUsg          Ds                  Qualified  Align  Based( pObjUsg )
     D  DtsReset                     10u 0
     D  DtsLstUsd                    10u 0
     D  DaysUsdCnt                    5u 0
     D                                4a
     **-- Journal info format:
     D JrnInf          Ds                  Qualified  Align  Based( pJrnInf )
     D  JrnSts                        1a
     D  Options                       1a
     D  JrnId                        10a
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  JrnStrDts                    10u 0
     **-- API path:
     D Path            Ds                  Qualified  Align
     D  CcsId                        10i 0 Inz( CUR_CCSID )
     D  CtrId                         2a   Inz( CUR_CTRID )
     D  LngId                         3a   Inz( CUR_LNGID )
     D                                3a   Inz( *Allx'00' )
     D  PthTypI                      10i 0 Inz( CHR_DLM_1 )
     D  PthNamLen                    10i 0
     D  PthNamDlm                     2a   Inz( '/ ' )
     D                               10a   Inz( *Allx'00' )
     D  PthNam                     5000a
     **
     D AtrIds          Ds                  Qualified  Align
     D  NbrAtr                       10i 0
     D  AtrId                        10i 0 Dim( 32 )
     **
     D Buffer          Ds                  Qualified  Align  Based( pBufferE )
     D  OfsNxtAtr                    10i 0
     D  AtrId                        10i 0
     D  SizAtr                       10i 0
     D                                4a
     D  AtrDta                     1024a
     D   AtrInt2                      5i 0 Overlay( AtrDta: 1 )
     D   AtrInt                      10i 0 Overlay( AtrDta: 1 )
     D   AtrUint                     10u 0 Overlay( AtrDta: 1 )
     D   AtrUint8                    20u 0 Overlay( AtrDta: 1 )
     **-- timeval structure:
     D timeval         Ds                  Qualified
     D  sec                          10i 0
     D  usec                         10i 0
     **-- Spooled file information:
     D SPRL0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  SplfNam                      10a
     D  JobNam                       10a
     D  UsrNam                       10a
     D  JobNbr                        6a
     D  SplfNbr                      10i 0
     D  JobSysNam                     8a
     D  SplfCrtDat                    7a
     D                                1a
     D  SplfCrtTim                    6a

     **-- Get attributes:
     D GetAtr          Pr            10i 0 ExtProc( 'Qp0lGetAttr' )
     D  GaFilNam                       *   Value
     D  GaAtrLst                       *   Value
     D  GaBuffer                       *   Value
     D  GaBufSizPrv                  10u 0 Value
     D  GaBufSizAvl                  10u 0
     D  GaBufSizRtn                  10u 0
     D  GaFlwSymLnk                  10u 0 Value
     D  GaDots                       10i 0 Options( *NoPass )
     **-- Initialize memory:
     D memset          Pr            10i 0 ExtProc( 'memset' )
     D  pStg                           *   Value
     D  InzVal                        1a   Value
     D  InzByt                       10i 0 Value
     **-- Copy memory:
     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
     D  MemOut                         *   Value
     D  MemInp                         *   Value
     D  MemSiz                       10u 0 Value
     **-- Convert timeval to MItime:
     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
     D                                 *   Value
     D                                 *   Value
     D                               10i 0 Value
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const
     D  CdOutVar                     17a          Options( *VarSize )
     D  CdError                      10i 0 Const
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RiRcvVar                  32767a         Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiFmtNam                      8a   Const
     D  RiJobNamQ                    26a   Const
     D  RiJobIntId                   16a   Const
     D  RiError                   32767a         Options( *NoPass: *VarSize )
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
     **-- Retrieve last spooled file identity:
     D RtvLstSplfId    Pr                  ExtPgm( 'QSPRILSP' )
     D  RsRcvVar                  32767a          Options( *VarSize )
     D  RsRcvVarLen                  10i 0 Const
     D  RsFmtNam                      8a   Const
     D  RsError                   32767a          Options( *VarSize )
     **-- Convert hex to character nibbles:
     D cvthc           Pr                  ExtProc( 'cvthc' )
     D  rcv                          32a   Options( *VarSize )
     D  src                          16a   Options( *VarSize )
     D  srcsiz                       10i 0 Value
     **-- Run system command:
     D system          Pr            10i 0 ExtProc( 'system' )
     D  command                        *   Value  Options( *String )

     **-- Get job type:
     D GetJobTyp       Pr             1a
     **-- Convert Epoch to timestamp:
     D CvtEpochDts     Pr              z
     D  PxEpoch_p                      *   Value
     **-- Write attribute line:
     D WrtAtrLin       Pr
     D  PxLinTxt                     40a   Const
     D  PxLinVal                     50a   Const
     **-- Write blank line:
     D WrtBlkLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Error identification:
     D errno           Pr            10i 0
     **
     D strerror        Pr           128a   Varying

     D CBX927          Pr
     D  PxIfsObj                   5002a   Varying
     D  PxOutOpt                      3a
     **
     D CBX927          Pi
     D  PxIfsObj                   5002a   Varying
     D  PxOutOpt                      3a

      /Free

        Path.PthNam    = PxIfsObj;
        Path.PthNamLen = %Len( PxIfsObj );

        AtrIds.NbrAtr = ALL_AVL_ATR;

        If  GetAtr( %Addr( Path )
                  : %Addr( AtrIds )
                  : *Null
                  : *Zero
                  : BufSizAvl
                  : NbrBytRtn
                  : 0
                  ) = 0;

          ApiRcvSiz = BufSizAvl;
          pBuffer   = %Alloc( ApiRcvSiz );

          memset( pBuffer: x'00': ApiRcvSiz );

          If  GetAtr( %Addr( Path )
                    : %Addr( AtrIds )
                    : pBuffer
                    : ApiRcvSiz
                    : BufSizAvl
                    : NbrBytRtn
                    : 0
                    ) = 0;

            pBufferE = pBuffer;

            DoW  pBufferE <> *Null;

              ExSr  RtvAtrVal;

              If  Buffer.OfsNxtAtr = *Zero;
                pBufferE = *Null;
              Else;
                pBufferE = pBuffer + Buffer.OfsNxtAtr;
              EndIf;
            EndDo;

          EndIf;
        Else;

          SndEscMsg( %Char( Errno ) + ': ' + Strerror );
        EndIf;

        ExSr  CrtLst;

        DeAlloc  pBuffer;

        *InLr = *On;
        Return;


        BegSr  RtvAtrVal;

          Select;
          When  Buffer.AtrId = QP0L_ATTR_OBJTYPE;
            ObjTyp = Buffer.AtrDta;

          When  Buffer.AtrId = QP0L_ATTR_DATA_SIZE;
            DtaSiz = Buffer.AtrUint;

          When  Buffer.AtrId = QP0L_ATTR_ALLOC_SIZE;
            AlcSiz = Buffer.AtrUint;

          When  Buffer.AtrId = QP0L_ATTR_EXTENDED_ATTR_SIZE;
            ExtAtrSiz = Buffer.AtrUint;

          When  Buffer.AtrId = QP0L_ATTR_CREATE_TIME;
            ObjCrtDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));

          When  Buffer.AtrId = QP0L_ATTR_ACCESS_TIME;
            ObjAccDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));

          When  Buffer.AtrId = QP0L_ATTR_CHANGE_TIME;
            ObjChgDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));

          When  Buffer.AtrId = QP0L_ATTR_MODIFY_TIME;
            DtaModDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));

          When  Buffer.AtrId = QP0L_ATTR_STG_FREE;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SYS_STG_FREE;
              StgFree = '*OFFLINE';
            Else;
              StgFree = '*ONLINE';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_CHECKED_OUT;

            If  Buffer.SizAtr > *Zero;
              pChkOut = %Addr( Buffer.AtrDta );

              If  ChkOut.Ind = QP0L_CHECKED_OUT;
                ChkOutUsr = ChkOut.User;
                ChkOutDts = %Char( CvtEpochDts( %Addr( ChkOut.Time )));
              EndIf;
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_LOCAL_REMOTE;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_LOCAL_OBJ;
              ObjLocRmt = '*LOCAL';
            Else;
              ObjLocRmt = '*REMOTE';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_AUTH;
            pGenAut = %Addr( Buffer.AtrDta );

            ObjOwn = GenAut.ObjOwn;
            ObjPgp = GenAut.PriGrp;
            AutLstNam = GenAut.AutL;

            pUsrAut = pBuffer + GenAut.OfsUsrE;

            For  Idx = 1  to GenAut.NbrUsrE;

              // Authorization entry available here

              If  Idx < GenAut.NbrUsrE;
                pUsrAut += GenAut.SizUsrE;
              EndIf;
            EndFor;

          When  Buffer.AtrId = QP0L_ATTR_FILE_ID;
            cvthc( FileId: Buffer.AtrDta: Buffer.SizAtr * 2 );

          When  Buffer.AtrId = QP0L_ATTR_ASP;
            ObjAsp = Buffer.AtrInt2;

          When  Buffer.AtrId = QP0L_ATTR_DATA_SIZE_64;
            DtaSiz_64 = Buffer.AtrUint8;

          When  Buffer.AtrId = QP0L_ATTR_ALLOC_SIZE_64;
            AlcSiz_64 = Buffer.AtrUint8;

          When  Buffer.AtrId = QP0L_ATTR_USAGE_INFORMATION;

            If  Buffer.SizAtr >= %Size( ObjUsg );
              pObjUsg = %Addr( Buffer.AtrDta );

              If  ObjUsg.DtsReset > *Zero;
                DtsReset = %Char( CvtEpochDts( %Addr( ObjUsg.DtsReset )));
              EndIf;

              If  ObjUsg.DtsLstUsd > *Zero;
                DtsLstUsd = %Char( CvtEpochDts( %Addr( ObjUsg.DtsLstUsd )));
              EndIf;

              DaysUsdCnt = ObjUsg.DaysUsdCnt;
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_PC_READ_ONLY;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_READONLY;
              ReadOnly = '*YES';
            Else;
              ReadOnly = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_PC_HIDDEN;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_HIDDEN;
              ObjHid = '*YES';
            Else;
              ObjHid = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_PC_SYSTEM;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_SYSTEM;
              ObjSys = '*YES';
            Else;
              ObjSys = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_PC_ARCHIVE;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_CHANGED;
              ObjArcPc = '*YES';
            Else;
              ObjArcPc = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_SYSTEM_ARCHIVE;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SYSTEM_CHANGED;
              ObjArcSys = '*YES';
            Else;
              ObjArcSys = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_FILE_FORMAT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_FILE_FORMAT_TYPE1;
              FilFmt = '*TYPE1';

            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_FILE_FORMAT_TYPE2;
              FilFmt = '*TYPE2';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_UDFS_DEFAULT_FORMAT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_UDFS_DEFAULT_TYPE1;
              UdfsDftFmt = '*TYPE1';

            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_UDFS_DEFAULT_TYPE2;
              UdfsDftFmt = '*TYPE2';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_JOURNAL_INFORMATION;

            If  Buffer.SizAtr > *Zero;
              pJrnInf = %Addr( Buffer.AtrDta );

              If  JrnInf.JrnSts = QP0L_JOURNALED  Or
                  Buffer.SizAtr >= %Size( JrnInf );

                If  JrnInf.JrnSts = QP0L_JOURNALED;
                  JrnSts = '*YES';
                EndIf;

                cvthc( JrnId: JrnInf.JrnId: %Size( JrnInf.JrnId ) * 2 );

                If  %BitAnd( JrnInf.Options
                           : QP0L_JOURNAL_BEFORE_IMAGES
                           ) <> x'00';

                  JrnImgBef = '*YES';
                Else;
                  JrnImgBef = '*NO';
                EndIf;

                If  %BitAnd( JrnInf.Options
                           : QP0L_JOURNAL_AFTER_IMAGES
                           ) <> x'00';

                  JrnImgAft = '*YES';
                Else;
                  JrnImgAft = '*NO';
                EndIf;

                If  %BitAnd( JrnInf.Options
                           : QP0L_JOURNAL_SUBTREE
                           ) <> x'00';

                  JrnInhJrnA = '*YES';
                Else;
                  JrnInhJrnA = '*NO';
                EndIf;

                If  %BitAnd( JrnInf.Options
                           : QP0L_JOURNAL_OPTIONAL_ENTRIES
                           ) <> x'00';

                  JrnOptEnt = '*NONE';
                Else;
                  JrnOptEnt = '*OPNCLOSYN';
                EndIf;

                JrnNam = JrnInf.JrnNam;
                JrnLib = JrnInf.JrnLib;
                JrnStrDts = %Char( CvtEpochDts( %Addr( JrnInf.JrnStrDts )));
              EndIf;
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_ALWCKPWRT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_ALWCKPWRT;
              AlwCkpWrt = '*YES';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_NOT_ALWCKPWRT;
              AlwCkpWrt = '*NO';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_CCSID;

            DtaCcsId = Buffer.AtrInt;

          When  Buffer.AtrId = QP0L_ATTR_SIGNED;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SIGNED;
              ObjSig = '*YES';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_NOT_SIGNED;
              ObjSig = '*NO';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_SYS_SIGNED;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_SYSTEM_SIGNED_YES;
              ObjSigSys = '*YES';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_SYSTEM_SIGNED_NO;
              ObjSigSys = '*NO';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_MULT_SIGS;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_MULT_SIGS_YES;
              MltSig = '*YES';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_MULT_SIGS_NO;
              MltSig = '*NO';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_DISK_STG_OPT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_NORMAL;
              DiskStgOpt = '*NORMAL';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_MINIMIZE;
              DiskStgOpt = '*MINIMIZE';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_DYNAMIC;
              DiskStgOpt = '*DYNAMIC';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_MAIN_STG_OPT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_NORMAL;
              MainStgOpt = '*NORMAL';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_MINIMIZE;
              MainStgOpt = '*MINIMIZE';
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_DYNAMIC;
              DiskStgOpt = '*DYNAMIC';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_DIR_FORMAT;

            Select;
            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_DIR_FORMAT_TYPE1;
              DirFmt = '*TYPE1';

            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
                             = QP0L_DIR_FORMAT_TYPE2;
              DirFmt = '*TYPE2';
            EndSl;

          When  Buffer.AtrId = QP0L_ATTR_AUDIT;

              ObjAudVal = %Subst( Buffer.AtrDta: 1: Buffer.SizAtr );

          When  Buffer.AtrId = QP0L_ATTR_SUID;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SUID_ON;
              SetEuid = '*YES';
            Else;
              SetEuid = '*NO';
            EndIf;

          When  Buffer.AtrId = QP0L_ATTR_SGID;

            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SGID_ON;
              SetEgid = '*YES';
            Else;
              SetEgid = '*NO';
            EndIf;

          EndSl;

        EndSr;

        BegSr  CrtLst;

          system( 'OVRPRTF FILE(QSYSPRT) HOLD(*YES) '       +
                  'PAGESIZE(70,000 *N *ROWCOL) OVRFLW(70) ' +
                  'SECURE(*YES) OVRSCOPE(*JOB)'
                );

          Open  QSYSPRT;

          ExSr  WrtAtrLst;

          system( 'DLTOVR  FILE(QSYSPRT) LVL(*JOB)' );

          Close  QSYSPRT;

          If  PxOutOpt = 'DSP'  And GetJobTyp() = 'I';
            ExSr  DspLst;

          Else;
            ExSr  WrtLst;
          EndIf;

        EndSr;

        BegSr  WrtAtrLst;

          WrtLstHdr();

          WrtAtrLin( 'Type . . . . . . . . . . . . . . . . . :': ObjTyp );
          WrtAtrLin( 'Owner  . . . . . . . . . . . . . . . . :': ObjOwn );
          WrtAtrLin( 'System object is on  . . . . . . . . . :': ObjLocRmt );
          WrtAtrLin( 'Auxiliary storage pool . . . . . . . . :'
                   : %Char( ObjAsp )
                   );

          WrtBlkLin();

          WrtAtrLin( 'Coded character set ID . . . . . . . . :'
                   : %EditC( %Dec( DtaCcsId: 5: 0 ): 'X' )
                   );

          WrtAtrLin( 'Hidden file  . . . . . . . . . . . . . :': ObjHid );
          WrtAtrLin( 'PC system file . . . . . . . . . . . . :': ObjSys );
          WrtAtrLin( 'Read only  . . . . . . . . . . . . . . :': ReadOnly );
          WrtBlkLin();

          If  ChkOutUsr > *Blanks;
            WrtAtrLin( 'Checked out by . . . . . . . . . . . . :': ChkOutUsr );
            WrtAtrLin( 'Checked out date/time  . . . . . . . . :': ChkOutDts );
          EndIf;

          WrtAtrLin( 'Need to archive (PC) . . . . . . . . . :': ObjArcPc );
          WrtAtrLin( 'Need to archive (AS/400) . . . . . . . :': ObjArcSys );

          If  AlwCkpWrt > *Blanks;
            WrtAtrLin( 'Allow write during save  . . . . . . . :': AlwCkpWrt );
          EndIf;

          WrtBlkLin();

          WrtAtrLin( 'Create date/time . . . . . . . . . . . :': ObjCrtDts );
          WrtAtrLin( 'Last access date/time  . . . . . . . . :': ObjAccDts );
          WrtAtrLin( 'Data change date/time  . . . . . . . . :': DtaModDts );
          WrtAtrLin( 'Attribute change date/time . . . . . . :': ObjChgDts );
          WrtBlkLin();

          If  DtsLstUsd > *Blanks;
            WrtAtrLin( 'Last used date . . . . . . . . . . . . :': DtsLstUsd );
            WrtAtrLin( 'Days used count  . . . . . . . . . . . :'
                     : %Char( DaysUsdCnt )
                     );

            WrtAtrLin( '  Reset date . . . . . . . . . . . . . :': DtsReset );
            WrtBlkLin();
          EndIf;

          WrtAtrLin( 'File ID  . . . . . . . . . . . . . . . :'
                   : 'x''' + FileId + ''''
                   );

          If  FilFmt > *Blanks;
            WrtAtrLin( 'File format  . . . . . . . . . . . . . :': FilFmt );
          EndIf;

          If  DirFmt > *Blanks;
            WrtAtrLin( 'Directory format . . . . . . . . . . . :': DirFmt );
          EndIf;

          If  UdfsDftFmt > *Blanks;
            WrtAtrLin( 'UDFS default format  . . . . . . . . . :': UdfsDftFmt );
          EndIf;

          WrtBlkLin();

          WrtAtrLin( 'Size of object data in bytes . . . . . :'
                   : %Trim( %EditC( DtaSiz_64: 'J' ))
                   );

          WrtAtrLin( 'Allocated size of object . . . . . . . :'
                   : %Trim( %EditC( AlcSiz_64: 'J' ))
                   );

          WrtAtrLin( 'Size of extended attributes  . . . . . :'
                   : %Trim( %EditC( ExtAtrSiz: 'J' ))
                   );

          WrtAtrLin( 'Storage freed  . . . . . . . . . . . . :': StgFree );

          If  DiskStgOpt > *Blanks;
            WrtAtrLin( 'Disk storage option  . . . . . . . . . :': DiskStgOpt );
            WrtAtrLin( 'Main storage option  . . . . . . . . . :': MainStgOpt );
          EndIf;

          WrtBlkLin();

          WrtAtrLin( 'Authorization list . . . . . . . . . . :': AutLstNam );
          WrtAtrLin( 'Object primary group . . . . . . . . . :': ObjPgp );
          WrtAtrLin( 'Set effective user ID  . . . . . . . . :': SetEuid );
          WrtAtrLin( 'Set effective group ID . . . . . . . . :': SetEgid );
          WrtBlkLin();

          WrtAtrLin( 'Auditing value . . . . . . . . . . . . :': ObjAudVal );

          If  ObjSig > *Blanks;
            WrtAtrLin( 'Digitally signed . . . . . . . . . . . :': ObjSig );
            WrtAtrLin( 'Multiple signatures  . . . . . . . . . :': MltSig );
            WrtAtrLin( 'Certificate Authority trusted  . . . . :': ObjSigSys );
          EndIf;

          WrtBlkLin();

          WrtAtrLin( 'Object is currently journaled  . . . . :': JrnSts );

          If  JrnNam > *Blanks;
            WrtAtrLin( 'Current or last journal  . . . . . . . :': JrnNam );
            WrtAtrLin( '  Library  . . . . . . . . . . . . . . :': JrnLib );
            WrtAtrLin( 'Last journal start date/time . . . . . :': JrnStrDts );
            WrtAtrLin( 'Journal ID . . . . . . . . . . . . . . :'
                     : 'x''' + JrnId + ''''
                     );

            WrtBlkLin();

            WrtAtrLin( 'Journal image before . . . . . . . . . :': JrnImgBef );
            WrtAtrLin( 'Journal image after  . . . . . . . . . :': JrnImgAft );
            WrtAtrLin( 'Journal subtree  . . . . . . . . . . . :': JrnInhJrnA );
            WrtAtrLin( 'Journal entries to be omitted  . . . . :': JrnOptEnt );
          EndIf;

        EndSr;

        BegSr  DspLst;

          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );

          system( 'DSPSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
                                    %Trim( SPRL0100.UsrNam )  + '/' +
                                    %Trim( SPRL0100.JobNam )  + ')' +
                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
                );

          system( 'DLTSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
                                    %Trim( SPRL0100.UsrNam )  + '/' +
                                    %Trim( SPRL0100.JobNam )  + ')' +
                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
                );

        EndSr;

        BegSr  WrtLst;

          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );

          system( 'RLSSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
                                    %Trim( SPRL0100.UsrNam )  + '/' +
                                    %Trim( SPRL0100.JobNam )  + ')' +
                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
                );

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  *InzSr;

          LstTim = %Int( %Char( %Time(): *ISO0));

          If  %Len( PxIfsObj ) > %Size( IfsObj );

            EvalR  IfsObj = PxIfsObj;
            %Subst( IfsObj: 1: 3 ) = '...';
          Else;

            IfsObj = PxIfsObj;
          EndIf;

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           70 'Display Attributes'
     O                                          107 'Program:'
     O                       PsPgmNam           118
     O                                          126 'Page:'
     O                       PAGE             +   1
     OQSYSPRT   EF           LstHdr         1
     O                                           20 'Object . . . . . . :'
     O                       IfsObj             132
     OQSYSPRT   EF           DtlLin         1
     O                       LinTxt              40
     O                       LinVal              93
     OQSYSPRT   EF           DtlBlk         1
     **
     OQSYSPRT   EF           LstTrl      1
     O                                           26 '*  E N D  O F  L I S T  *'
     **-- Get runtime error number:  -----------------------------------------**
     P errno           B
     D                 Pi            10i 0
     D sys_errno       Pr              *    ExtProc( '__errno' )
     **
     D Error           s             10i 0  Based( pError )  NoOpt

      /Free

        pError = sys_errno;

        Return  Error;

      /End-Free

     P Errno           E
     **-- Get runtime error text:  -------------------------------------------**
     P strerror        B
     D                 Pi           128a    Varying
     D sys_strerror    Pr              *    ExtProc( 'strerror' )
     D                               10i 0  Value

      /Free

        Return  %Str( sys_strerror( Errno ));

      /End-Free

     P strerror        E
     **-- Get job type:  -----------------------------------------------------**
     P GetJobTyp       B
     D                 Pi             1a
     **
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
     **-- Convert Epoch to timestamp:  ---------------------------------------**
     P CvtEpochDts     B
     D                 Pi              z
     D  PxEpoch_p                      *   Value

      /Free

        MemCpy( %Addr( timeval.sec )
              : PxEpoch_p
              : %Size( timeval.sec )
              );

        timeval.usec = *zero;

        rc = CvtTvToMi( %Addr( MI_Time )
                      : %Addr( timeval )
                      : CVTTIME_TO_TIMESTAMP
                      );

        CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );

        Return  %Timestamp( MI_DTS: *ISO0 );

      /End-Free

     P CvtEpochDts     E
     **-- Write attribute line:  ---------------------------------------------**
     P WrtAtrLin       B
     D                 Pi
     D  PxLinTxt                     40a   Const
     D  PxLinVal                     50a   Const

      /Free

          WrtLstHdr( 3 );

          LinTxt = PxLinTxt;
          LinVal = PxLinVal;

          Except  DtlLin;

      /End-Free

     P WrtAtrLin       E
     **-- Write blank line:  -------------------------------------------------**
     P WrtBlkLin       B
     D                 Pi

      /Free

          WrtLstHdr( 2 );

          Except  DtlBlk;

      /End-Free

     P WrtBlkLin       E
     **-- Write list header:  ------------------------------------------------**
     P WrtLstHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        If  %Parms = *Zero;

          Except  Header;
          Except  LstHdr;
        Else;

          If  PlCurLin > PlOvfLin - PxOvrFlwRel;

            Except  Header;
            Except  LstHdr;
          EndIf;
        EndIf;

      /End-Free

     P WrtLstHdr       E
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
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
          Return  0;

        EndIf;

      /End-Free

     P SndEscMsg       E
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying

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
