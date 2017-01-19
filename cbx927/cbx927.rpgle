000100041106     **
000200041203     **  Program . . : CBX927
000300041201     **  Description : Display Attributes - CPP
000400041106     **  Author  . . : Carsten Flensburg
000500041127     **
000600041127     **
000700041127     **  Program description:
000800041201     **    This program will print all available attributes of an IFS
000900041201     **    (Integrated File System) object.  The resulting printer file
001000041203     **    will either be displayed, and subsequently deleted, or released
001100041201     **    for printing.
001200041201     **
001300041201     **
001400041201     **  Programmer's notes:
001500041201     **    The following Qp0lGetAttr attribute-IDs are supported as of V5R2 only:
001600041201     **
001700041201     **       29  QP0L_ATTR_SYS_SIGNED     Signed by a trusted source
001800041201     **       30  QP0L_ATTR_MULT_SIGS      More than one OS/400 digital signature
001900041201     **       31  QP0L_ATTR_DISK_STG_OPT   How to allocate auxiliary storage
002000041201     **       32  QP0L_ATTR_MAIN_STG_OPT   How to allocate main storage
002100041201     **       33  QP0L_ATTR_DIR_FORMAT     Directory format; *TYPE1, *TYPE2
002200041201     **       34  QP0L_ATTR_AUDIT          Object auditing value
002300041201     **      301  QP0L_ATTR_SUID           Set effective user ID
002400041201     **      302  QP0L_ATTR_SGID           Set effective group ID
002500041201     **
002600041106     **
002700041106     **  Compile options:
002800041106     **
002900041127     **    CrtRpgMod Module( CBX927 )  DbgView( *LIST )
003000041106     **
003100041127     **    CrtPgm    Pgm( CBX927 )
003200041127     **              Module( CBX927 )
003300041107     **              ActGrp( *NEW )
003400041106     **
003500041106     **
003600041106     **-- Control specification:  --------------------------------------------**
003700041130     H Option( *SrcStmt )  BndDir( 'QC2LE' )  DecEdit( *JOBRUN )
003800041106     **-- Printer file:
003900041106     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
004000041106     F                                      UsrOpn
004100041106     **-- Printer file information:
004200041106     D PrtLinInf       Ds
004300041106     D  PlOvfLin                      5i 0  Overlay( PrtLinInf: 188 )
004400041106     D  PlCurLin                      5i 0  Overlay( PrtLinInf: 367 )
004500041106     D  PlCurPag                      5i 0  Overlay( PrtLinInf: 369 )
004600041106     **-- System information:
004700041106     D                SDs
004800041106     D  PsPgmNam         *Proc
004900041106     **-- API error information:
005000041106     D ERRC0100        Ds                  Qualified
005100041106     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
005200041106     D  BytAvl                       10i 0
005300041106     D  MsgId                         7a
005400041106     D                                1a
005500041106     D  MsgDta                      256a
005600041031     **-- Global variables:
005700041107     D LstTim          s              6s 0
005800041130     D IfsObj          s            109a
005900041129     D LinTxt          s             40a
006000041129     D LinVal          s             50a
006100041127     D MI_Time         s              8a
006200041127     D MI_DTS          s             20a
006300041106     **
006400041113     D BufSizAvl       s             10u 0 Inz( 0 )
006500041113     D NbrBytRtn       s             10u 0 Inz( 0 )
006600041128     D ApiRcvSiz       s             10u 0
006700041031     D rc              s             10i 0
006800041031     D Idx             s             10i 0
006900041031     D pBuffer         s               *
007000041031     D ErrTxt          s            256a
007100041127     D MsgKey          s              4a
007200041112     **-- API path constants:
007300041112     D CUR_CCSID       c                   0
007400041112     D CUR_CTRID       c                   x'0000'
007500041112     D CUR_LNGID       c                   x'000000'
007600041112     D CHR_DLM_1       c                   0
007700041031     **
007800041031     D CVTTIME_TO_OFFSET...
007900041031     D                 c                   0
008000041031     D CVTTIME_TO_TIMESTAMP...
008100041031     D                 c                   1
008200041031     D CVTTIME_FACTOR_EPOCH_ONLY...
008300041031     D                 c                   2
008400041031     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
008500041031     D                 c                   3
008600041031     **
008700041031     **-- File attributes:
008800041031     D ALL_AVL_ATR     c                   0
008900041112     **
009000041112     D QP0L_ATTR_OBJTYPE...
009100041112     D                 c                   0
009200041112     D QP0L_ATTR_DATA_SIZE...
009300041112     D                 c                   1
009400041112     D QP0L_ATTR_ALLOC_SIZE...
009500041112     D                 c                   2
009600041112     D QP0L_ATTR_EXTENDED_ATTR_SIZE...
009700041112     D                 c                   3
009800041112     D QP0L_ATTR_CREATE_TIME...
009900041112     D                 c                   4
010000041112     D QP0L_ATTR_ACCESS_TIME...
010100041112     D                 c                   5
010200041112     D QP0L_ATTR_CHANGE_TIME...
010300041112     D                 c                   6
010400041112     D QP0L_ATTR_MODIFY_TIME...
010500041112     D                 c                   7
010600041112     D QP0L_ATTR_STG_FREE...
010700041112     D                 c                   8
010800041112     D QP0L_ATTR_CHECKED_OUT...
010900041112     D                 c                   9
011000041112     D QP0L_ATTR_LOCAL_REMOTE...
011100041112     D                 c                   10
011200041113     D QP0L_ATTR_AUTH  c                   11
011300041112     D QP0L_ATTR_FILE_ID...
011400041112     D                 c                   12
011500041112     D QP0L_ATTR_ASP   c                   13
011600041112     D QP0L_ATTR_DATA_SIZE_64...
011700041112     D                 c                   14
011800041112     D QP0L_ATTR_ALLOC_SIZE_64...
011900041112     D                 c                   15
012000041112     D QP0L_ATTR_USAGE_INFORMATION...
012100041112     D                 c                   16
012200041112     D QP0L_ATTR_PC_READ_ONLY...
012300041112     D                 c                   17
012400041112     D QP0L_ATTR_PC_HIDDEN...
012500041112     D                 c                   18
012600041112     D QP0L_ATTR_PC_SYSTEM...
012700041112     D                 c                   19
012800041112     D QP0L_ATTR_PC_ARCHIVE...
012900041112     D                 c                   20
013000041112     D QP0L_ATTR_SYSTEM_ARCHIVE...
013100041112     D                 c                   21
013200041112     D QP0L_ATTR_CODEPAGE...
013300041112     D                 c                   22
013400041112     D QP0L_ATTR_FILE_FORMAT...
013500041112     D                 c                   23
013600041112     D QP0L_ATTR_UDFS_DEFAULT_FORMAT...
013700041112     D                 c                   24
013800041112     D QP0L_ATTR_JOURNAL_INFORMATION...
013900041112     D                 c                   25
014000041112     D QP0L_ATTR_ALWCKPWRT...
014100041112     D                 c                   26
014200041112     D QP0L_ATTR_CCSID...
014300041112     D                 c                   27
014400041112     D QP0L_ATTR_SIGNED...
014500041112     D                 c                   28
014600041112     D QP0L_ATTR_SYS_SIGNED...
014700041112     D                 c                   29
014800041112     D QP0L_ATTR_MULT_SIGS...
014900041112     D                 c                   30
015000041112     D QP0L_ATTR_DISK_STG_OPT...
015100041112     D                 c                   31
015200041112     D QP0L_ATTR_MAIN_STG_OPT...
015300041112     D                 c                   32
015400041112     D QP0L_ATTR_DIR_FORMAT...
015500041112     D                 c                   33
015600041112     D QP0L_ATTR_AUDIT...
015700041112     D                 c                   34
015800041112     D QP0L_ATTR_SUID  c                   300
015900041112     D QP0L_ATTR_SGID  c                   301
016000041112     **-- File attribute constants:
016100041112     D QP0L_SYS_NOT_STG_FREE...
016200041112     D                 c                   x'00'
016300041112     D QP0L_SYS_STG_FREE...
016400041112     D                 c                   x'01'
016500041112     D QP0L_NOT_CHECKED_OUT...
016600041112     D                 c                   x'00'
016700041112     D QP0L_CHECKED_OUT...
016800041112     D                 c                   x'01'
016900041127     D QP0L_LOCAL_OBJ  c                   x'01'
017000041127     D QP0L_REMOTE_OBJ...
017100041127     D                 c                   x'02'
017200041112     D QP0L_PC_NOT_READONLY...
017300041112     D                 c                   x'00'
017400041112     D QP0L_PC_READONLY...
017500041112     D                 c                   x'01'
017600041112     D QP0L_PC_NOT_HIDDEN...
017700041112     D                 c                   x'00'
017800041112     D QP0L_PC_HIDDEN...
017900041112     D                 c                   x'01'
018000041112     D QP0L_PC_NOT_SYSTEM...
018100041112     D                 c                   x'00'
018200041112     D QP0L_PC_SYSTEM...
018300041112     D                 c                   x'01'
018400041112     D QP0L_PC_NOT_CHANGED...
018500041112     D                 c                   x'00'
018600041112     D QP0L_PC_CHANGED...
018700041112     D                 c                   x'01'
018800041112     D QP0L_SYSTEM_NOT_CHANGED...
018900041112     D                 c                   x'00'
019000041112     D QP0L_SYSTEM_CHANGED...
019100041112     D                 c                   x'01'
019200041112     D QP0L_FILE_FORMAT_TYPE1...
019300041112     D                 c                   x'00'
019400041112     D QP0L_FILE_FORMAT_TYPE2...
019500041112     D                 c                   x'01'
019600041112     D QP0L_UDFS_DEFAULT_TYPE1...
019700041112     D                 c                   x'00'
019800041112     D QP0L_UDFS_DEFAULT_TYPE2...
019900041112     D                 c                   x'01'
020000041112     D QP0L_NOT_JOURNALED...
020100041112     D                 c                   x'00'
020200041112     D QP0L_JOURNALED  c                   x'01'
020300041112     D QP0L_JOURNAL_SUBTREE...
020400041112     D                 c                   x'80'
020500041112     D QP0L_JOURNAL_OPTIONAL_ENTRIES...
020600041112     D                 c                   x'08'
020700041112     D QP0L_JOURNAL_AFTER_IMAGES...
020800041112     D                 c                   x'20'
020900041112     D QP0L_JOURNAL_BEFORE_IMAGES...
021000041112     D                 c                   x'40'
021100041112     D QP0L_NOT_ALWCKPWRT...
021200041112     D                 c                   x'00'
021300041112     D QP0L_ALWCKPWRT...
021400041112     D                 c                   x'01'
021500041112     D QP0L_NOT_SIGNED...
021600041112     D                 c                   x'00'
021700041112     D QP0L_SIGNED     c                   x'01'
021800041112     D QP0L_SYSTEM_SIGNED_NO...
021900041112     D                 c                   x'00'
022000041112     D QP0L_SYSTEM_SIGNED_YES...
022100041112     D                 c                   x'01'
022200041112     D QP0L_MULT_SIGS_NO...
022300041112     D                 c                   x'00'
022400041112     D QP0L_MULT_SIGS_YES...
022500041112     D                 c                   x'01'
022600041112     D QP0L_STG_NORMAL...
022700041112     D                 c                   x'00'
022800041112     D QP0L_STG_MINIMIZE...
022900041112     D                 c                   x'01'
023000041112     D QP0L_STG_DYNAMIC...
023100041112     D                 c                   x'02'
023200041112     D QP0L_DIR_FORMAT_TYPE1...
023300041112     D                 c                   x'00'
023400041112     D QP0L_DIR_FORMAT_TYPE2...
023500041112     D                 c                   x'01'
023600041112     D QP0L_SUID_OFF   c                   x'00'
023700041112     D QP0L_SUID_ON    c                   x'01'
023800041112     D QP0L_SGID_OFF   c                   x'00'
023900041112     D QP0L_SGID_ON    c                   x'01'
024000041127     **-- Object attributes:
024100041127     D ObjTyp          s             10a
024200041127     D DtaSiz          s             10u 0
024300041127     D AlcSiz          s             10u 0
024400041127     D ExtAtrSiz       s             10u 0
024500041127     D ObjCrtDts       s             19a
024600041127     D ObjChgDts       s             19a
024700041127     D ObjAccDts       s             19a
024800041130     D DtaModDts       s             19a
024900041127     D StgFree         s             10a
025000041127     D ChkOutUsr       s             10a
025100041127     D ChkOutDts       s             19a
025200041127     D ObjLocRmt       s             10a
025300041127     D FileId          s             32a
025400041127     D ObjAsp          s              5i 0
025500041127     D DtaSiz_64       s             20u 0
025600041127     D AlcSiz_64       s             20u 0
025700041130     D DtsReset        s             10a
025800041130     D DtsLstUsd       s             10a
025900041127     D DaysUsdCnt      s             10i 0
026000041127     D ReadOnly        s             10a
026100041127     D ObjHid          s             10a
026200041127     D ObjSys          s             10a
026300041127     D ObjArcPc        s             10a
026400041127     D ObjArcSys       s             10a
026500041128     D DtaCcsId        s             10i 0
026600041127     D FilFmt          s             10a
026700041127     D UdfsDftFmt      s             10a
026800041127     **
026900041127     D JrnSts          s             10a   Inz( '*NO' )
027000041127     D JrnInhJrnA      s             10a
027100041127     D JrnOptEnt       s             10a
027200041127     D JrnImgBef       s             10a
027300041127     D JrnImgAft       s             10a
027400041130     D JrnId           s             20a   Inz( *All'0' )
027500041127     D JrnNam          s             10a
027600041127     D JrnLib          s             10a
027700041127     D JrnStrDts       s             19a
027800041127     **
027900041127     D AlwCkpWrt       s             10a
028000041127     D ObjSig          s             10a
028100041127     D ObjSigSys       s             10a
028200041127     D MltSig          s             10a
028300041127     D DiskStgOpt      s             10a
028400041127     D MainStgOpt      s             10a
028500041127     D DirFmt          s             10a
028600041127     D ObjAudVal       s             10a
028700041127     D SetEuid         s             10a
028800041127     D SetEgid         s             10a
028900041127     **
029000041127     D ObjOwn          s             10a
029100041127     D ObjPgp          s             10a
029200041127     D AutLstNam       s             10a
029300041127     D UsrNam          s             10a
029400041127     D UsrDtaAut       s             10a
029500041127     **
029600041127     D AutObjMgm       s              1a
029700041127     D AutObjExs       s              1a
029800041127     D AutObjAlt       s              1a
029900041127     D AutObjRef       s              1a
030000041127     D AutObjOpr       s              1a
030100041127     D AutDtaRead      s              1a
030200041127     D AutDtaAdd       s              1a
030300041127     D AutDtaUpd       s              1a
030400041127     D AutDtaDlt       s              1a
030500041127     D AutDtaExe       s              1a
030600041127     D AutDtaExcl      s              1a
030700041127     **-- Checkout format:
030800041127     D ChkOut          Ds                  Qualified  Align  Based( pChkOut )
030900041031     D  Ind                           1a
031000041031     D  User                         10a
031100041031     D                                1a
031200041031     D  Time                         10u 0
031300041031     **-- General authority format:
031400041111     D GenAut          Ds                  Qualified  Align  Based( pGenAut )
031500041031     D  ObjOwn                       10a
031600041031     D  PriGrp                       10a
031700041031     D  AutL                         10a
031800041031     D                               10a
031900041031     D  OfsUsrE                      10i 0
032000041031     D  NbrUsrE                      10i 0
032100041031     D  SizUsrE                      10i 0
032200041031     D                               12a
032300041031     **
032400041111     D UsrAut          Ds                  Qualified  Align  Based( pUsrAut )
032500041031     D  UsrNam                       10a
032600041031     D  UsrDtaAut                    10a
032700041031     D  ObjMgm                        1a
032800041031     D  ObjExs                        1a
032900041031     D  ObjAlt                        1a
033000041031     D  ObjRef                        1a
033100041031     D                               10a
033200041031     D  ObjOpr                        1a
033300041031     D  DtaRead                       1a
033400041031     D  DtaAdd                        1a
033500041031     D  DtaUpd                        1a
033600041031     D  DtaDlt                        1a
033700041031     D  DtaExe                        1a
033800041031     D  DtaExclude                    1a
033900041031     D                                7a
034000041031     **-- Object usage format:
034100041111     D ObjUsg          Ds                  Qualified  Align  Based( pObjUsg )
034200041127     D  DtsReset                     10u 0
034300041127     D  DtsLstUsd                    10u 0
034400041127     D  DaysUsdCnt                    5u 0
034500041031     D                                4a
034600041031     **-- Journal info format:
034700041111     D JrnInf          Ds                  Qualified  Align  Based( pJrnInf )
034800041031     D  JrnSts                        1a
034900041031     D  Options                       1a
035000041031     D  JrnId                        10a
035100041031     D  JrnNam                       10a
035200041031     D  JrnLib                       10a
035300041031     D  JrnStrDts                    10u 0
035400041031     **-- API path:
035500041112     D Path            Ds                  Qualified  Align
035600041112     D  CcsId                        10i 0 Inz( CUR_CCSID )
035700041112     D  CtrId                         2a   Inz( CUR_CTRID )
035800041112     D  LngId                         3a   Inz( CUR_LNGID )
035900041112     D                                3a   Inz( *Allx'00' )
036000041112     D  PthTypI                      10i 0 Inz( CHR_DLM_1 )
036100041112     D  PthNamLen                    10i 0
036200041112     D  PthNamDlm                     2a   Inz( '/ ' )
036300041112     D                               10a   Inz( *Allx'00' )
036400041112     D  PthNam                     5000a
036500030618     **
036600041031     D AtrIds          Ds                  Qualified  Align
036700041031     D  NbrAtr                       10i 0
036800041031     D  AtrId                        10i 0 Dim( 32 )
036900030620     **
037000041031     D Buffer          Ds                  Qualified  Align  Based( pBufferE )
037100041031     D  OfsNxtAtr                    10i 0
037200041031     D  AtrId                        10i 0
037300041031     D  SizAtr                       10i 0
037400041031     D                                4a
037500041031     D  AtrDta                     1024a
037600041127     D   AtrInt2                      5i 0 Overlay( AtrDta: 1 )
037700041127     D   AtrInt                      10i 0 Overlay( AtrDta: 1 )
037800041127     D   AtrUint                     10u 0 Overlay( AtrDta: 1 )
037900041127     D   AtrUint8                    20u 0 Overlay( AtrDta: 1 )
038000041031     **-- timeval structure:
038100041031     D timeval         Ds                  Qualified
038200041031     D  sec                          10i 0
038300041031     D  usec                         10i 0
038400041107     **-- Spooled file information:
038500041113     D SPRL0100        Ds                  Qualified
038600041107     D  BytRtn                       10i 0
038700041107     D  BytAvl                       10i 0
038800041107     D  SplfNam                      10a
038900041107     D  JobNam                       10a
039000041107     D  UsrNam                       10a
039100041107     D  JobNbr                        6a
039200041107     D  SplfNbr                      10i 0
039300041107     D  JobSysNam                     8a
039400041107     D  SplfCrtDat                    7a
039500041107     D                                1a
039600041107     D  SplfCrtTim                    6a
039700041031
039800041031     **-- Get attributes:
039900030618     D GetAtr          Pr            10i 0 ExtProc( 'Qp0lGetAttr' )
040000030618     D  GaFilNam                       *   Value
040100030618     D  GaAtrLst                       *   Value
040200030618     D  GaBuffer                       *   Value
040300030618     D  GaBufSizPrv                  10u 0 Value
040400041112     D  GaBufSizAvl                  10u 0
040500041112     D  GaBufSizRtn                  10u 0
040600030618     D  GaFlwSymLnk                  10u 0 Value
040700030618     D  GaDots                       10i 0 Options( *NoPass )
040800041031     **-- Initialize memory:
040900041031     D memset          Pr            10i 0 ExtProc( 'memset' )
041000041031     D  pStg                           *   Value
041100041031     D  InzVal                        1a   Value
041200041031     D  InzByt                       10i 0 Value
041300041031     **-- Copy memory:
041400041031     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
041500041031     D  MemOut                         *   Value
041600041031     D  MemInp                         *   Value
041700041031     D  MemSiz                       10u 0 Value
041800041031     **-- Convert timeval to MItime:
041900041031     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
042000041031     D                                 *   Value
042100041031     D                                 *   Value
042200041031     D                               10i 0 Value
042300041031     **-- Convert date & time:
042400041031     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
042500041031     D  CdInpFmt                     10a   Const
042600041031     D  CdInpVar                     17a   Const  Options( *VarSize )
042700041031     D  CdOutFmt                     10a   Const
042800041031     D  CdOutVar                     17a          Options( *VarSize )
042900041031     D  CdError                      10i 0 Const
043000041106     **-- Retrieve job information:
043100041106     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
043200041106     D  RiRcvVar                  32767a         Options( *VarSize )
043300041106     D  RiRcvVarLen                  10i 0 Const
043400041106     D  RiFmtNam                      8a   Const
043500041106     D  RiJobNamQ                    26a   Const
043600041106     D  RiJobIntId                   16a   Const
043700041106     D  RiError                   32767a         Options( *NoPass: *VarSize )
043800041106     **-- Send program message:
043900041106     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
044000041106     D  SpMsgId                       7a   Const
044100041106     D  SpMsgFq                      20a   Const
044200041106     D  SpMsgDta                    128a   Const
044300041106     D  SpMsgDtaLen                  10i 0 Const
044400041106     D  SpMsgTyp                     10a   Const
044500041106     D  SpCalStkE                    10a   Const  Options( *VarSize )
044600041106     D  SpCalStkCtr                  10i 0 Const
044700041106     D  SpMsgKey                      4a
044800041106     D  SpError                   32767a          Options( *VarSize )
044900041106     **-- Retrieve last spooled file identity:
045000041106     D RtvLstSplfId    Pr                  ExtPgm( 'QSPRILSP' )
045100041106     D  RsRcvVar                  32767a          Options( *VarSize )
045200041106     D  RsRcvVarLen                  10i 0 Const
045300041106     D  RsFmtNam                      8a   Const
045400041106     D  RsError                   32767a          Options( *VarSize )
045500041127     **-- Convert hex to character nibbles:
045600041127     D cvthc           Pr                  ExtProc( 'cvthc' )
045700041127     D  rcv                          32a   Options( *VarSize )
045800041127     D  src                          16a   Options( *VarSize )
045900041127     D  srcsiz                       10i 0 Value
046000041106     **-- Run system command:
046100041106     D system          Pr            10i 0 ExtProc( 'system' )
046200041106     D  command                        *   Value  Options( *String )
046300041106
046400041106     **-- Get job type:
046500041106     D GetJobTyp       Pr             1a
046600041127     **-- Convert Epoch to timestamp:
046700041127     D CvtEpochDts     Pr              z
046800041127     D  PxEpoch_p                      *   Value
046900041130     **-- Write attribute line:
047000041130     D WrtAtrLin       Pr
047100041130     D  PxLinTxt                     40a   Const
047200041130     D  PxLinVal                     50a   Const
047300041130     **-- Write blank line:
047400041130     D WrtBlkLin       Pr
047500041130     **-- Write list header:
047600041130     D WrtLstHdr       Pr
047700041130     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
047800041106     **-- Send escape message:
047900041106     D SndEscMsg       Pr            10i 0
048000041106     D  PxMsgDta                    512a   Const  Varying
048100041106     **-- Send completion message:
048200041106     D SndCmpMsg       Pr            10i 0
048300041106     D  PxMsgDta                    512a   Const  Varying
048400041106     **-- Error identification:
048500030620     D errno           Pr            10i 0
048600030620     **
048700041113     D strerror        Pr           128a   Varying
048800041113
048900041113     D CBX927          Pr
049000041113     D  PxIfsObj                   5002a   Varying
049100041127     D  PxOutOpt                      3a
049200041113     **
049300041113     D CBX927          Pi
049400041113     D  PxIfsObj                   5002a   Varying
049500041113     D  PxOutOpt                      3a
049600041031
049700041031      /Free
049800041031
049900041113        Path.PthNam    = PxIfsObj;
050000041113        Path.PthNamLen = %Len( PxIfsObj );
050100041128
050200041128        AtrIds.NbrAtr = ALL_AVL_ATR;
050300041031
050400041128        If  GetAtr( %Addr( Path )
050500041128                  : %Addr( AtrIds )
050600041128                  : *Null
050700041128                  : *Zero
050800041128                  : BufSizAvl
050900041128                  : NbrBytRtn
051000041128                  : 0
051100041128                  ) = 0;
051200041128
051300041128          ApiRcvSiz = BufSizAvl;
051400041128          pBuffer   = %Alloc( ApiRcvSiz );
051500041031
051600041128          memset( pBuffer: x'00': ApiRcvSiz );
051700041128
051800041128          If  GetAtr( %Addr( Path )
051900041128                    : %Addr( AtrIds )
052000041128                    : pBuffer
052100041128                    : ApiRcvSiz
052200041128                    : BufSizAvl
052300041128                    : NbrBytRtn
052400041128                    : 0
052500041128                    ) = 0;
052600041128
052700041128            pBufferE = pBuffer;
052800041031
052900041128            DoW  pBufferE <> *Null;
053000041031
053100041128              ExSr  RtvAtrVal;
053200041031
053300041128              If  Buffer.OfsNxtAtr = *Zero;
053400041128                pBufferE = *Null;
053500041128              Else;
053600041128                pBufferE = pBuffer + Buffer.OfsNxtAtr;
053700041128              EndIf;
053800041128            EndDo;
053900041128
054000041128          EndIf;
054100041128        Else;
054200041107
054300041111          SndEscMsg( %Char( Errno ) + ': ' + Strerror );
054400041107        EndIf;
054500041107
054600041107        ExSr  CrtLst;
054700041107
054800041113        DeAlloc  pBuffer;
054900041107
055000041107        *InLr = *On;
055100041107        Return;
055200041031
055300041031
055400041107        BegSr  RtvAtrVal;
055500041031
055600041107          Select;
055700041127          When  Buffer.AtrId = QP0L_ATTR_OBJTYPE;
055800041127            ObjTyp = Buffer.AtrDta;
055900041127
056000041127          When  Buffer.AtrId = QP0L_ATTR_DATA_SIZE;
056100041127            DtaSiz = Buffer.AtrUint;
056200041127
056300041127          When  Buffer.AtrId = QP0L_ATTR_ALLOC_SIZE;
056400041127            AlcSiz = Buffer.AtrUint;
056500041127
056600041127          When  Buffer.AtrId = QP0L_ATTR_EXTENDED_ATTR_SIZE;
056700041127            ExtAtrSiz = Buffer.AtrUint;
056800041127
056900041113          When  Buffer.AtrId = QP0L_ATTR_CREATE_TIME;
057000041127            ObjCrtDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));
057100041113
057200041127          When  Buffer.AtrId = QP0L_ATTR_ACCESS_TIME;
057300041127            ObjAccDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));
057400041127
057500041127          When  Buffer.AtrId = QP0L_ATTR_CHANGE_TIME;
057600041127            ObjChgDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));
057700041127
057800041127          When  Buffer.AtrId = QP0L_ATTR_MODIFY_TIME;
057900041127            DtaModDts = %Char( CvtEpochDts( %Addr( Buffer.AtrDta )));
058000041127
058100041127          When  Buffer.AtrId = QP0L_ATTR_STG_FREE;
058200041127
058300041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SYS_STG_FREE;
058400041127              StgFree = '*OFFLINE';
058500041127            Else;
058600041127              StgFree = '*ONLINE';
058700041127            EndIf;
058800041127
058900041127          When  Buffer.AtrId = QP0L_ATTR_CHECKED_OUT;
059000041127
059100041127            If  Buffer.SizAtr > *Zero;
059200041127              pChkOut = %Addr( Buffer.AtrDta );
059300041127
059400041127              If  ChkOut.Ind = QP0L_CHECKED_OUT;
059500041127                ChkOutUsr = ChkOut.User;
059600041127                ChkOutDts = %Char( CvtEpochDts( %Addr( ChkOut.Time )));
059700041127              EndIf;
059800041127            EndIf;
059900041127
060000041127          When  Buffer.AtrId = QP0L_ATTR_LOCAL_REMOTE;
060100041127
060200041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_LOCAL_OBJ;
060300041127              ObjLocRmt = '*LOCAL';
060400041127            Else;
060500041127              ObjLocRmt = '*REMOTE';
060600041127            EndIf;
060700041128
060800041128          When  Buffer.AtrId = QP0L_ATTR_AUTH;
060900041128            pGenAut = %Addr( Buffer.AtrDta );
061000041128
061100041128            ObjOwn = GenAut.ObjOwn;
061200041128            ObjPgp = GenAut.PriGrp;
061300041128            AutLstNam = GenAut.AutL;
061400041128
061500041128            pUsrAut = pBuffer + GenAut.OfsUsrE;
061600041128
061700041128            For  Idx = 1  to GenAut.NbrUsrE;
061800041128
061900041128              // Authorization entry available here
062000041128
062100041128              If  Idx < GenAut.NbrUsrE;
062200041128                pUsrAut += GenAut.SizUsrE;
062300041128              EndIf;
062400041128            EndFor;
062500041127
062600041127          When  Buffer.AtrId = QP0L_ATTR_FILE_ID;
062700041127            cvthc( FileId: Buffer.AtrDta: Buffer.SizAtr * 2 );
062800041127
062900041127          When  Buffer.AtrId = QP0L_ATTR_ASP;
063000041127            ObjAsp = Buffer.AtrInt2;
063100041127
063200041127          When  Buffer.AtrId = QP0L_ATTR_DATA_SIZE_64;
063300041127            DtaSiz_64 = Buffer.AtrUint8;
063400041127
063500041127          When  Buffer.AtrId = QP0L_ATTR_ALLOC_SIZE_64;
063600041127            AlcSiz_64 = Buffer.AtrUint8;
063700041127
063800041113          When  Buffer.AtrId = QP0L_ATTR_USAGE_INFORMATION;
063900041127
064000041127            If  Buffer.SizAtr >= %Size( ObjUsg );
064100041127              pObjUsg = %Addr( Buffer.AtrDta );
064200041127
064300041127              If  ObjUsg.DtsReset > *Zero;
064400041127                DtsReset = %Char( CvtEpochDts( %Addr( ObjUsg.DtsReset )));
064500041127              EndIf;
064600041127
064700041127              If  ObjUsg.DtsLstUsd > *Zero;
064800041127                DtsLstUsd = %Char( CvtEpochDts( %Addr( ObjUsg.DtsLstUsd )));
064900041127              EndIf;
065000041127
065100041127              DaysUsdCnt = ObjUsg.DaysUsdCnt;
065200041127            EndIf;
065300041127
065400041127          When  Buffer.AtrId = QP0L_ATTR_PC_READ_ONLY;
065500041127
065600041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_READONLY;
065700041128              ReadOnly = '*YES';
065800041127            Else;
065900041128              ReadOnly = '*NO';
066000041127            EndIf;
066100041127
066200041127          When  Buffer.AtrId = QP0L_ATTR_PC_HIDDEN;
066300041127
066400041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_HIDDEN;
066500041128              ObjHid = '*YES';
066600041127            Else;
066700041128              ObjHid = '*NO';
066800041127            EndIf;
066900041127
067000041127          When  Buffer.AtrId = QP0L_ATTR_PC_SYSTEM;
067100041127
067200041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_SYSTEM;
067300041128              ObjSys = '*YES';
067400041127            Else;
067500041128              ObjSys = '*NO';
067600041127            EndIf;
067700041127
067800041127          When  Buffer.AtrId = QP0L_ATTR_PC_ARCHIVE;
067900041127
068000041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_PC_CHANGED;
068100041128              ObjArcPc = '*YES';
068200041127            Else;
068300041128              ObjArcPc = '*NO';
068400041127            EndIf;
068500041127
068600041127          When  Buffer.AtrId = QP0L_ATTR_SYSTEM_ARCHIVE;
068700041127
068800041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SYSTEM_CHANGED;
068900041128              ObjArcSys = '*YES';
069000041127            Else;
069100041128              ObjArcSys = '*NO';
069200041127            EndIf;
069300041128
069400041128          When  Buffer.AtrId = QP0L_ATTR_FILE_FORMAT;
069500041128
069600041128            Select;
069700041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
069800041128                             = QP0L_FILE_FORMAT_TYPE1;
069900041128              FilFmt = '*TYPE1';
070000041128
070100041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
070200041128                             = QP0L_FILE_FORMAT_TYPE2;
070300041128              FilFmt = '*TYPE2';
070400041128            EndSl;
070500041128
070600041128          When  Buffer.AtrId = QP0L_ATTR_UDFS_DEFAULT_FORMAT;
070700041128
070800041128            Select;
070900041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
071000041128                             = QP0L_UDFS_DEFAULT_TYPE1;
071100041128              UdfsDftFmt = '*TYPE1';
071200041128
071300041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
071400041128                             = QP0L_UDFS_DEFAULT_TYPE2;
071500041128              UdfsDftFmt = '*TYPE2';
071600041128            EndSl;
071700041031
071800041113          When  Buffer.AtrId = QP0L_ATTR_JOURNAL_INFORMATION;
071900041031
072000041127            If  Buffer.SizAtr > *Zero;
072100041107              pJrnInf = %Addr( Buffer.AtrDta );
072200041127
072300041127              If  JrnInf.JrnSts = QP0L_JOURNALED  Or
072400041127                  Buffer.SizAtr >= %Size( JrnInf );
072500041127
072600041127                If  JrnInf.JrnSts = QP0L_JOURNALED;
072700041127                  JrnSts = '*YES';
072800041127                EndIf;
072900041127
073000041127                cvthc( JrnId: JrnInf.JrnId: %Size( JrnInf.JrnId ) * 2 );
073100041127
073200041127                If  %BitAnd( JrnInf.Options
073300041127                           : QP0L_JOURNAL_BEFORE_IMAGES
073400041127                           ) <> x'00';
073500041127
073600041127                  JrnImgBef = '*YES';
073700041127                Else;
073800041127                  JrnImgBef = '*NO';
073900041127                EndIf;
074000041127
074100041127                If  %BitAnd( JrnInf.Options
074200041127                           : QP0L_JOURNAL_AFTER_IMAGES
074300041127                           ) <> x'00';
074400041127
074500041127                  JrnImgAft = '*YES';
074600041127                Else;
074700041127                  JrnImgAft = '*NO';
074800041127                EndIf;
074900041127
075000041127                If  %BitAnd( JrnInf.Options
075100041127                           : QP0L_JOURNAL_SUBTREE
075200041127                           ) <> x'00';
075300041127
075400041127                  JrnInhJrnA = '*YES';
075500041127                Else;
075600041127                  JrnInhJrnA = '*NO';
075700041127                EndIf;
075800041127
075900041127                If  %BitAnd( JrnInf.Options
076000041127                           : QP0L_JOURNAL_OPTIONAL_ENTRIES
076100041127                           ) <> x'00';
076200041127
076300041127                  JrnOptEnt = '*NONE';
076400041127                Else;
076500041127                  JrnOptEnt = '*OPNCLOSYN';
076600041127                EndIf;
076700041127
076800041127                JrnNam = JrnInf.JrnNam;
076900041127                JrnLib = JrnInf.JrnLib;
077000041127                JrnStrDts = %Char( CvtEpochDts( %Addr( JrnInf.JrnStrDts )));
077100041127              EndIf;
077200041107            EndIf;
077300041127
077400041127          When  Buffer.AtrId = QP0L_ATTR_ALWCKPWRT;
077500041127
077600041130            Select;
077700041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
077800041130                             = QP0L_ALWCKPWRT;
077900041128              AlwCkpWrt = '*YES';
078000041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
078100041130                             = QP0L_NOT_ALWCKPWRT;
078200041128              AlwCkpWrt = '*NO';
078300041130            EndSl;
078400041127
078500041127          When  Buffer.AtrId = QP0L_ATTR_CCSID;
078600041127
078700041128            DtaCcsId = Buffer.AtrInt;
078800041128
078900041128          When  Buffer.AtrId = QP0L_ATTR_SIGNED;
079000041127
079100041130            Select;
079200041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SIGNED;
079300041128              ObjSig = '*YES';
079400041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_NOT_SIGNED;
079500041128              ObjSig = '*NO';
079600041130            EndSl;
079700041128
079800041128          When  Buffer.AtrId = QP0L_ATTR_SYS_SIGNED;
079900041128
080000041130            Select;
080100041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
080200041128                             = QP0L_SYSTEM_SIGNED_YES;
080300041128              ObjSigSys = '*YES';
080400041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
080500041130                             = QP0L_SYSTEM_SIGNED_NO;
080600041128              ObjSigSys = '*NO';
080700041130            EndSl;
080800041128
080900041128          When  Buffer.AtrId = QP0L_ATTR_MULT_SIGS;
081000041128
081100041130            Select;
081200041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
081300041130                             = QP0L_MULT_SIGS_YES;
081400041128              MltSig = '*YES';
081500041130            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
081600041130                             = QP0L_MULT_SIGS_NO;
081700041128              MltSig = '*NO';
081800041130            EndSl;
081900041128
082000041127          When  Buffer.AtrId = QP0L_ATTR_DISK_STG_OPT;
082100041127
082200041127            Select;
082300041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_NORMAL;
082400041128              DiskStgOpt = '*NORMAL';
082500041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_MINIMIZE;
082600041128              DiskStgOpt = '*MINIMIZE';
082700041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_DYNAMIC;
082800041128              DiskStgOpt = '*DYNAMIC';
082900041127            EndSl;
083000041127
083100041127          When  Buffer.AtrId = QP0L_ATTR_MAIN_STG_OPT;
083200041127
083300041127            Select;
083400041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_NORMAL;
083500041128              MainStgOpt = '*NORMAL';
083600041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_MINIMIZE;
083700041128              MainStgOpt = '*MINIMIZE';
083800041127            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_STG_DYNAMIC;
083900041128              DiskStgOpt = '*DYNAMIC';
084000041127            EndSl;
084100041127
084200041128          When  Buffer.AtrId = QP0L_ATTR_DIR_FORMAT;
084300041128
084400041128            Select;
084500041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
084600041128                             = QP0L_DIR_FORMAT_TYPE1;
084700041128              DirFmt = '*TYPE1';
084800041128
084900041128            When  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr )
085000041128                             = QP0L_DIR_FORMAT_TYPE2;
085100041128              DirFmt = '*TYPE2';
085200041128            EndSl;
085300041128
085400041128          When  Buffer.AtrId = QP0L_ATTR_AUDIT;
085500041128
085600041128              ObjAudVal = %Subst( Buffer.AtrDta: 1: Buffer.SizAtr );
085700041128
085800041127          When  Buffer.AtrId = QP0L_ATTR_SUID;
085900041127
086000041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SUID_ON;
086100041128              SetEuid = '*YES';
086200041127            Else;
086300041128              SetEuid = '*NO';
086400041127            EndIf;
086500041127
086600041127          When  Buffer.AtrId = QP0L_ATTR_SGID;
086700041127
086800041127            If  %Subst( Buffer.AtrDta: 1: Buffer.SizAtr ) = QP0L_SGID_ON;
086900041128              SetEgid = '*YES';
087000041128            Else;
087100041128              SetEgid = '*NO';
087200041128            EndIf;
087300041127
087400041127          EndSl;
087500041031
087600041107        EndSr;
087700041031
087800041107        BegSr  CrtLst;
087900041107
088000041201          system( 'OVRPRTF FILE(QSYSPRT) HOLD(*YES) '       +
088100041201                  'PAGESIZE(70,000 *N *ROWCOL) OVRFLW(70) ' +
088200041130                  'SECURE(*YES) OVRSCOPE(*JOB)'
088300041130                );
088400041107
088500041130          Open  QSYSPRT;
088600041107
088700041130          ExSr  WrtAtrLst;
088800041107
088900041130          system( 'DLTOVR  FILE(QSYSPRT) LVL(*JOB)' );
089000041107
089100041130          Close  QSYSPRT;
089200041107
089300041130          If  PxOutOpt = 'DSP'  And GetJobTyp() = 'I';
089400041130            ExSr  DspLst;
089500041107
089600041130          Else;
089700041130            ExSr  WrtLst;
089800041130          EndIf;
089900041113
090000041130        EndSr;
090100041107
090200041130        BegSr  WrtAtrLst;
090300041130
090400041130          WrtLstHdr();
090500041130
090600041130          WrtAtrLin( 'Type . . . . . . . . . . . . . . . . . :': ObjTyp );
090700041130          WrtAtrLin( 'Owner  . . . . . . . . . . . . . . . . :': ObjOwn );
090800041130          WrtAtrLin( 'System object is on  . . . . . . . . . :': ObjLocRmt );
090900041130          WrtAtrLin( 'Auxiliary storage pool . . . . . . . . :'
091000041130                   : %Char( ObjAsp )
091100041130                   );
091200041130
091300041130          WrtBlkLin();
091400041130
091500041130          WrtAtrLin( 'Coded character set ID . . . . . . . . :'
091600041130                   : %EditC( %Dec( DtaCcsId: 5: 0 ): 'X' )
091700041130                   );
091800041130
091900041130          WrtAtrLin( 'Hidden file  . . . . . . . . . . . . . :': ObjHid );
092000041130          WrtAtrLin( 'PC system file . . . . . . . . . . . . :': ObjSys );
092100041130          WrtAtrLin( 'Read only  . . . . . . . . . . . . . . :': ReadOnly );
092200041130          WrtBlkLin();
092300041130
092400041130          If  ChkOutUsr > *Blanks;
092500041130            WrtAtrLin( 'Checked out by . . . . . . . . . . . . :': ChkOutUsr );
092600041130            WrtAtrLin( 'Checked out date/time  . . . . . . . . :': ChkOutDts );
092700041130          EndIf;
092800041130
092900041130          WrtAtrLin( 'Need to archive (PC) . . . . . . . . . :': ObjArcPc );
093000041130          WrtAtrLin( 'Need to archive (AS/400) . . . . . . . :': ObjArcSys );
093100041130
093200041130          If  AlwCkpWrt > *Blanks;
093300041130            WrtAtrLin( 'Allow write during save  . . . . . . . :': AlwCkpWrt );
093400041130          EndIf;
093500041130
093600041130          WrtBlkLin();
093700041130
093800041130          WrtAtrLin( 'Create date/time . . . . . . . . . . . :': ObjCrtDts );
093900041130          WrtAtrLin( 'Last access date/time  . . . . . . . . :': ObjAccDts );
094000041130          WrtAtrLin( 'Data change date/time  . . . . . . . . :': DtaModDts );
094100041130          WrtAtrLin( 'Attribute change date/time . . . . . . :': ObjChgDts );
094200041130          WrtBlkLin();
094300041130
094400041130          If  DtsLstUsd > *Blanks;
094500041130            WrtAtrLin( 'Last used date . . . . . . . . . . . . :': DtsLstUsd );
094600041130            WrtAtrLin( 'Days used count  . . . . . . . . . . . :'
094700041130                     : %Char( DaysUsdCnt )
094800041130                     );
094900041130
095000041130            WrtAtrLin( '  Reset date . . . . . . . . . . . . . :': DtsReset );
095100041130            WrtBlkLin();
095200041130          EndIf;
095300041130
095400041130          WrtAtrLin( 'File ID  . . . . . . . . . . . . . . . :'
095500041130                   : 'x''' + FileId + ''''
095600041130                   );
095700041130
095800041130          If  FilFmt > *Blanks;
095900041130            WrtAtrLin( 'File format  . . . . . . . . . . . . . :': FilFmt );
096000041130          EndIf;
096100041130
096200041130          If  DirFmt > *Blanks;
096300041130            WrtAtrLin( 'Directory format . . . . . . . . . . . :': DirFmt );
096400041130          EndIf;
096500041130
096600041130          If  UdfsDftFmt > *Blanks;
096700041130            WrtAtrLin( 'UDFS default format  . . . . . . . . . :': UdfsDftFmt );
096800041130          EndIf;
096900041130
097000041130          WrtBlkLin();
097100041130
097200041130          WrtAtrLin( 'Size of object data in bytes . . . . . :'
097300041130                   : %Trim( %EditC( DtaSiz_64: 'J' ))
097400041130                   );
097500041130
097600041130          WrtAtrLin( 'Allocated size of object . . . . . . . :'
097700041130                   : %Trim( %EditC( AlcSiz_64: 'J' ))
097800041130                   );
097900041130
098000041130          WrtAtrLin( 'Size of extended attributes  . . . . . :'
098100041130                   : %Trim( %EditC( ExtAtrSiz: 'J' ))
098200041130                   );
098300041130
098400041130          WrtAtrLin( 'Storage freed  . . . . . . . . . . . . :': StgFree );
098500041130
098600041130          If  DiskStgOpt > *Blanks;
098700041130            WrtAtrLin( 'Disk storage option  . . . . . . . . . :': DiskStgOpt );
098800041130            WrtAtrLin( 'Main storage option  . . . . . . . . . :': MainStgOpt );
098900041130          EndIf;
099000041130
099100041130          WrtBlkLin();
099200041130
099300041130          WrtAtrLin( 'Authorization list . . . . . . . . . . :': AutLstNam );
099400041130          WrtAtrLin( 'Object primary group . . . . . . . . . :': ObjPgp );
099500041130          WrtAtrLin( 'Set effective user ID  . . . . . . . . :': SetEuid );
099600041130          WrtAtrLin( 'Set effective group ID . . . . . . . . :': SetEgid );
099700041130          WrtBlkLin();
099800041130
099900041130          WrtAtrLin( 'Auditing value . . . . . . . . . . . . :': ObjAudVal );
100000041130
100100041130          If  ObjSig > *Blanks;
100200041130            WrtAtrLin( 'Digitally signed . . . . . . . . . . . :': ObjSig );
100300041130            WrtAtrLin( 'Multiple signatures  . . . . . . . . . :': MltSig );
100400041130            WrtAtrLin( 'Certificate Authority trusted  . . . . :': ObjSigSys );
100500041130          EndIf;
100600041130
100700041130          WrtBlkLin();
100800041130
100900041130          WrtAtrLin( 'Object is currently journaled  . . . . :': JrnSts );
101000041130
101100041130          If  JrnNam > *Blanks;
101200041130            WrtAtrLin( 'Current or last journal  . . . . . . . :': JrnNam );
101300041130            WrtAtrLin( '  Library  . . . . . . . . . . . . . . :': JrnLib );
101400041130            WrtAtrLin( 'Last journal start date/time . . . . . :': JrnStrDts );
101500041130            WrtAtrLin( 'Journal ID . . . . . . . . . . . . . . :'
101600041130                     : 'x''' + JrnId + ''''
101700041130                     );
101800041130
101900041130            WrtBlkLin();
102000041130
102100041130            WrtAtrLin( 'Journal image before . . . . . . . . . :': JrnImgBef );
102200041130            WrtAtrLin( 'Journal image after  . . . . . . . . . :': JrnImgAft );
102300041130            WrtAtrLin( 'Journal subtree  . . . . . . . . . . . :': JrnInhJrnA );
102400041130            WrtAtrLin( 'Journal entries to be omitted  . . . . :': JrnOptEnt );
102500041130          EndIf;
102600041130
102700041130        EndSr;
102800041130
102900041107        BegSr  DspLst;
103000041107
103100041107          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );
103200041107
103300041107          system( 'DSPSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
103400041107                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
103500041107                                    %Trim( SPRL0100.UsrNam )  + '/' +
103600041107                                    %Trim( SPRL0100.JobNam )  + ')' +
103700041107                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
103800041107                );
103900041107
104000041107          system( 'DLTSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
104100041107                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
104200041107                                    %Trim( SPRL0100.UsrNam )  + '/' +
104300041107                                    %Trim( SPRL0100.JobNam )  + ')' +
104400041107                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
104500041107                );
104600041107
104700041107        EndSr;
104800041107
104900041107        BegSr  WrtLst;
105000041107
105100041201          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );
105200041201
105300041201          system( 'RLSSPLF FILE(' + %Trim( SPRL0100.SplfNam ) + ')' +
105400041201                          ' JOB(' + %Trim( SPRL0100.JobNbr )  + '/' +
105500041201                                    %Trim( SPRL0100.UsrNam )  + '/' +
105600041201                                    %Trim( SPRL0100.JobNam )  + ')' +
105700041201                       ' SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
105800041201                );
105900041201
106000041113          SndCmpMsg( 'List has been printed.' );
106100041107
106200041107        EndSr;
106300041130
106400041130        BegSr  *InzSr;
106500041130
106600041130          LstTim = %Int( %Char( %Time(): *ISO0));
106700041130
106800041130          If  %Len( PxIfsObj ) > %Size( IfsObj );
106900041130
107000041130            EvalR  IfsObj = PxIfsObj;
107100041130            %Subst( IfsObj: 1: 3 ) = '...';
107200041130          Else;
107300041130
107400041130            IfsObj = PxIfsObj;
107500041130          EndIf;
107600041130
107700041130        EndSr;
107800041107
107900041107      /End-Free
108000041107
108100041106     **-- Printer file definition:  ------------------------------------------**
108200041106     OQSYSPRT   EF           Header         2  2
108300041106     O                       UDATE         Y      8
108400041107     O                       LstTim              18 '  :  :  '
108500041130     O                                           70 'Display Attributes'
108600041106     O                                          107 'Program:'
108700041106     O                       PsPgmNam           118
108800041106     O                                          126 'Page:'
108900041106     O                       PAGE             +   1
109000041106     OQSYSPRT   EF           LstHdr         1
109100041130     O                                           20 'Object . . . . . . :'
109200041106     O                       IfsObj             132
109300041129     OQSYSPRT   EF           DtlLin         1
109400041129     O                       LinTxt              40
109500041129     O                       LinVal              93
109600041129     OQSYSPRT   EF           DtlBlk         1
109700041106     **
109800041129     OQSYSPRT   EF           LstTrl      1
109900041129     O                                           26 '*  E N D  O F  L I S T  *'
110000030620     **-- Get runtime error number:  -----------------------------------------**
110100041031     P errno           B
110200030620     D                 Pi            10i 0
110300030620     D sys_errno       Pr              *    ExtProc( '__errno' )
110400030620     **
110500041031     D Error           s             10i 0  Based( pError )  NoOpt
110600041031
110700041031      /Free
110800041031
110900041031        pError = sys_errno;
111000041031
111100041031        Return  Error;
111200041031
111300041031      /End-Free
111400041031
111500030620     P Errno           E
111600030620     **-- Get runtime error text:  -------------------------------------------**
111700041031     P strerror        B
111800030620     D                 Pi           128a    Varying
111900030620     D sys_strerror    Pr              *    ExtProc( 'strerror' )
112000030620     D                               10i 0  Value
112100041031
112200041031      /Free
112300041031
112400041031        Return  %Str( sys_strerror( Errno ));
112500041031
112600041031      /End-Free
112700041031
112800041031     P strerror        E
112900041106     **-- Get job type:  -----------------------------------------------------**
113000041106     P GetJobTyp       B
113100041106     D                 Pi             1a
113200041106     **
113300041106     D JOBI0400        Ds                  Qualified
113400041106     D  BytRtn                       10i 0
113500041106     D  BytAvl                       10i 0
113600041106     D  JobNam                       10a
113700041106     D  UsrNam                       10a
113800041106     D  JobNbr                        6a
113900041106     D  JobIntId                     16a
114000041106     D  JobSts                       10a
114100041106     D  JobTyp                        1a
114200041106     D  JobSubTyp                     1a
114300041106
114400041106      /Free
114500041106
114600041106        RtvJobInf( JOBI0400
114700041106                 : %Size( JOBI0400 )
114800041106                 : 'JOBI0400'
114900041106                 : '*'
115000041106                 : *Blank
115100041106                 : ERRC0100
115200041106                 );
115300041106
115400041106        If  ERRC0100.BytAvl > *Zero;
115500041106          Return  *Blank;
115600041106
115700041106        Else;
115800041106          Return  JOBI0400.JobTyp;
115900041106
116000041106        EndIf;
116100041106
116200041106      /End-Free
116300041106
116400041106     P GetJobTyp       E
116500041127     **-- Convert Epoch to timestamp:  ---------------------------------------**
116600041127     P CvtEpochDts     B
116700041127     D                 Pi              z
116800041127     D  PxEpoch_p                      *   Value
116900041127
117000041127      /Free
117100041127
117200041127        MemCpy( %Addr( timeval.sec )
117300041127              : PxEpoch_p
117400041127              : %Size( timeval.sec )
117500041127              );
117600041127
117700041127        timeval.usec = *zero;
117800041127
117900041127        rc = CvtTvToMi( %Addr( MI_Time )
118000041127                      : %Addr( timeval )
118100041127                      : CVTTIME_TO_TIMESTAMP
118200041127                      );
118300041127
118400041127        CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );
118500041127
118600041127        Return  %Timestamp( MI_DTS: *ISO0 );
118700041127
118800041127      /End-Free
118900041127
119000041127     P CvtEpochDts     E
119100041130     **-- Write attribute line:  ---------------------------------------------**
119200041130     P WrtAtrLin       B
119300041130     D                 Pi
119400041130     D  PxLinTxt                     40a   Const
119500041130     D  PxLinVal                     50a   Const
119600041130
119700041130      /Free
119800041130
119900041130          WrtLstHdr( 3 );
120000041130
120100041130          LinTxt = PxLinTxt;
120200041130          LinVal = PxLinVal;
120300041130
120400041130          Except  DtlLin;
120500041130
120600041130      /End-Free
120700041130
120800041130     P WrtAtrLin       E
120900041130     **-- Write blank line:  -------------------------------------------------**
121000041130     P WrtBlkLin       B
121100041130     D                 Pi
121200041130
121300041130      /Free
121400041130
121500041130          WrtLstHdr( 2 );
121600041130
121700041130          Except  DtlBlk;
121800041130
121900041130      /End-Free
122000041130
122100041130     P WrtBlkLin       E
122200041130     **-- Write list header:  ------------------------------------------------**
122300041130     P WrtLstHdr       B
122400041130     D                 Pi
122500041130     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
122600041130
122700041130      /Free
122800041130
122900041130        If  %Parms = *Zero;
123000041130
123100041130          Except  Header;
123200041130          Except  LstHdr;
123300041130        Else;
123400041130
123500041130          If  PlCurLin > PlOvfLin - PxOvrFlwRel;
123600041130
123700041130            Except  Header;
123800041130            Except  LstHdr;
123900041130          EndIf;
124000041130        EndIf;
124100041130
124200041130      /End-Free
124300041130
124400041130     P WrtLstHdr       E
124500041106     **-- Send escape message:  ----------------------------------------------**
124600041106     P SndEscMsg       B
124700041106     D                 Pi            10i 0
124800041106     D  PxMsgDta                    512a   Const  Varying
124900041106
125000041106      /Free
125100041106
125200041203        SndPgmMsg( 'CPF9897'
125300041106                 : 'QCPFMSG   *LIBL'
125400041106                 : PxMsgDta
125500041106                 : %Len( PxMsgDta )
125600041106                 : '*ESCAPE'
125700041106                 : '*PGMBDY'
125800041106                 : 1
125900041106                 : MsgKey
126000041106                 : ERRC0100
126100041106                 );
126200041106
126300041106        If  ERRC0100.BytAvl > *Zero;
126400041106          Return  -1;
126500041106
126600041106        Else;
126700041106          Return  0;
126800041106
126900041106        EndIf;
127000041106
127100041106      /End-Free
127200041106
127300041106     P SndEscMsg       E
127400041106     **-- Send completion message:  ------------------------------------------**
127500041106     P SndCmpMsg       B
127600041106     D                 Pi            10i 0
127700041106     D  PxMsgDta                    512a   Const  Varying
127800041106
127900041106      /Free
128000041106
128100041106        SndPgmMsg( 'CPF9897'
128200041106                 : 'QCPFMSG   *LIBL'
128300041106                 : PxMsgDta
128400041106                 : %Len( PxMsgDta )
128500041106                 : '*COMP'
128600041106                 : '*PGMBDY'
128700041106                 : 1
128800041106                 : MsgKey
128900041106                 : ERRC0100
129000041106                 );
129100041106
129200041106        If  ERRC0100.BytAvl > *Zero;
129300041106          Return  -1;
129400041106
129500041106        Else;
129600041106          Return  0;
129700041106
129800041106        EndIf;
129900041106
130000041106      /End-Free
130100041106
130200041106     **
130300041106     P SndCmpMsg       E
