000100040314     **
000200051218     **  Program . . : CBX950
000300051218     **  Description : Display job IFS object lock
000400040314     **  Author  . . : Carsten Flensburg
000500040314     **
000600041105     **
000700040318     **
000800041105     **
000900040314     **  Programmer's notes:
001000051124     **    The QP0LRRO API (Retrieve object references) was introduced with
001100051124     **    release V5R3 and this program will therefore not be able to run
001200041030     **    succesfully on earlier releases.
001300040314     **
001400051124     **    QP0LRRO documentation and comprehensive usage notes can be found here:
001500051124     **    http://publib.boulder.ibm.com/infocenter/iseries/v5r3/topic/apis/qp0lrro.htm
001600040318     **
001700040314     **  Compile options:
001800051218     **    CrtRpgMod  Module( CBX950 )
001900051218     **               DbgView( *LIST )
002000040314     **
002100051218     **    CrtPgm     Pgm( CBX950 )
002200051218     **               Module( CBX950 )
002300051218     **               ActGrp( *NEW )
002400040314     **
002500040314     **
002600040314     **-- Control specification:  --------------------------------------------**
002700051222     H Option( *SrcStmt: *NoDebugIo )  BndDir( 'QC2LE' )
002800051218     **-- Printer file:
002900051218     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
003000051218     F                                      UsrOpn
003100051218
003200051218     **-- Printer file information:
003300051218     D PrtLinInf       Ds                  Qualified
003400051218     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
003500051218     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
003600051218     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
003700051123
003800051218     **-- System information:
003900051218     D PgmSts         SDs                  Qualified
004000051218     D  PgmNam           *Proc
004100051218     D  JobNam_q                     26a   Overlay( PgmSts: 244 )
004200051218     D  JobNam                       10a   Overlay( PgmSts: 244 )
004300051218     D  CurJob                       10a   Overlay( PgmSts: 244 )
004400051218     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
004500051218     D  JobNbr                        6a   Overlay( PgmSts: 264 )
004600051218     D  CurUsr                       10a   Overlay( PgmSts: 358 )
004700051123     **-- Api error data structure:
004800041018     D ERRC0100        Ds                  Qualified
004900041018     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
005000041018     D  BytAvl                       10i 0 Inz
005100041018     D  MsgId                         7a
005200010329     D                                1a
005300041018     D  MsgDta                      128a
005400051218     **-- system function error ID:
005500051218     D SysError        s              7a   Import( '_EXCP_MSGID' )
005600051123
005700051123     **-- Global variables:
005800051221     D LstTim          s              6s 0
005900051221     D TrlTxt          s             32a
006000051123     D BytAlc          s             10i 0
006100051218     D NbrRcds         s             10u 0
006200051123     D Idx             s             10i 0
006300051221     D PthRtnLen       s             10i 0
006400051221     D DlmRtnLen       s             10i 0
006500051123     D NotSup          s             10i 0
006600051123     D FB              s             10i 0 Dim( 3 )
006700051221     D IfsObj          s           5000a
006800051222     D IfsObjV         s           5000a   Varying
006900051123     D PthDlm          s              2a
007000051221     D MsgKey          s              4a
007100051218     **
007200051218     D JobNam_q        Ds                  Qualified
007300051218     D  JobNam                       10a
007400051218     D  UsrPrf                       10a
007500051218     D  JobNbr                        6a
007600051221     **
007700051221     D OutHdr          Ds                  Qualified  Inz
007800051221     D  JobNam                       10a
007900051221     D  UsrPrf                       10a
008000051221     D  JobNbr                        6a
008100051221     **
008200051221     D OutDtl          Ds                  Qualified  Inz
008300051221     D  IfsObj                       42a
008400051221     D  SavLck                       10u 0
008500051221     D  AtrLck                       10u 0
008600051221     D  ShrNoRW                      10u 0
008700051221     D  ShrRdWr                      10u 0
008800051221     D  ShrWtOn                      10u 0
008900051221     D  ShrRdOn                      10u 0
009000051221     D  Execute                      10u 0
009100051221     D  ReadWrt                      10u 0
009200051221     D  WrtOnly                      10u 0
009300051221     D  RdOnly                       10u 0
009400051221     D  ChkUsr                       10a
009500051222     D  IfsObjF                     130a
009600051123     **-- Global constants:
009700051123     D NULL            c                    ''
009800051221     D OFS_MSGDTA      c                   16
009900051123     **
010000051123     D QP0L_ROOT_FS    c                    0
010100051123     D QP0L_OPENSYS...
010200051123     D _FS             c                    1
010300051123     D QP0L_UDFS_FS    c                    2
010400051128     D QP0L_UDFS_MANAGEMENT_FS...
010500051128     D                 c                    3
010600051123     D QP0L_QSYS_FS    c                    4
010700051128     D QP0L_IASPQSYS_FS...
010800051128     D                 c                    5
010900051123     D QP0L_QDLS_FS    c                    6
011000051123     D QP0L_NFS_FS     c                    7
011100051128     D QP0L_QNETWARE_FS...
011200051128     D                 c                    8
011300051123     D QP0L_QOPT_FS    c                    9
011400051128     D QP0L_QFILSVR400_FS...
011500051128     D                 c                   10
011600051123     D QP0L_QNTC_FS    c                   11
011700051123     **
011800051123     D QP0L_NO_ERROR   c                   0
011900051123     D QP0L_ERROR      c                   1
012000051128     D QP0L_SPACE_ERROR...
012100051128     D                 c                   2
012200051123
012300051218     **-- Spooled file information:
012400051218     D SPRL0100        Ds                  Qualified
012500051218     D  BytRtn                       10i 0
012600051218     D  BytAvl                       10i 0
012700051218     D  SplfNam                      10a
012800051218     D  JobNam                       10a
012900051218     D  UsrNam                       10a
013000051218     D  JobNbr                        6a
013100051218     D  SplfNbr                      10i 0
013200051218     D  JobSysNam                     8a
013300051218     D  SplfCrtDat                    7a
013400051218     D                                1a
013500051218     D  SplfCrtTim                    6a
013600051123     **-- Job identification:
013700051123     D JIDF0100        Ds                   Qualified  Inz
013800051221     D  JobNam_q                     26a
013900051221     D  JobNam                       10a    Overlay( JobNam_q: 1 )
014000051221     D  UsrNam                       10a    Overlay( JobNam_q: *Next )
014100051221     D  JobNbr                        6a    Overlay( JobNam_q: *Next )
014200051123     D  IntJobId                     16a
014300051123     D                                2a    Inz( *Allx'00' )
014400051123     D  ThrInd                       10i 0  Inz( 1 )
014500051123     D  ThrId                         8a    Inz( *Allx'00' )
014600051123     **-- Object reference information:
014700051123     D RROO0100        Ds                  Qualified  Based( pRROO0100 )
014800041018     D  BytRtn                       10u 0
014900041018     D  BytAvl                       10u 0
015000051123     D  ObjRtnCnt                    10u 0
015100051123     D  ObjAvlCnt                    10u 0
015200051123     D  OfsObjLst                    10u 0
015300051123     D  RtvRefSts                    10u 0
015400051123     **
015500051123     D Qp0l_Obj_List   Ds                  Qualified  Based( pQp0l_Obj_List )
015600051123     D  DplNxtObj                    10u 0
015700051123     D  DplExtRefTyp                 10u 0
015800051123     D  LenExtRefTyp                 10u 0
015900051123     D  RefCnt                       10u 0
016000051123     D  DplPthNam                    10u 0
016100051123     D  LenPthNam                    10u 0
016200051123     D  FilId                        16a
016300051123     D  FilSysId                     20u 0
016400051123     D  FilSysTyp                    10u 0
016500051123     D  FilIdNbr                     10u 0
016600051123     D  GenId                        10u 0
016700051123     **-- Extended object reference types structure:
016800051123     D Qp0l_Ext_Ref_T  Ds                   Qualified  Based( pQp0l_Ext_Ref_T )
016900051123     D  RdOnShrRdOn                  10u 0
017000051123     D  RdOnShrWtOn                  10u 0
017100051123     D  RdOnShrRdWt                  10u 0
017200051123     D  RdOnShrNoRW                  10u 0
017300051123     D  WtOnShrRdOn                  10u 0
017400051123     D  WtOnShrWtOn                  10u 0
017500051123     D  WtOnShrRdWt                  10u 0
017600051123     D  WtOnShrNoRW                  10u 0
017700051123     D  RWonShrRdOn                  10u 0
017800051123     D  RWonShrWtOn                  10u 0
017900051123     D  RWonShrRdWt                  10u 0
018000051123     D  RWonShrNoRW                  10u 0
018100051123     D  ExOnShrRdOn                  10u 0
018200051123     D  ExOnShrWtOn                  10u 0
018300051123     D  ExOnShrRdWt                  10u 0
018400051123     D  ExOnShrNoRW                  10u 0
018500051123     D  XRonShrRdOn                  10u 0
018600051123     D  XRonShrWtOn                  10u 0
018700051123     D  XRonShrRdWt                  10u 0
018800051123     D  XRonShrNoRW                  10u 0
018900051123     D  AtrLck                       10u 0
019000051123     D  SavLck                       10u 0
019100051123     D  SavLckInt                    10u 0
019200051123     D  LnkChgLck                    10u 0
019300051123     D  CurDir                       10u 0
019400051123     D  RootDir                      10u 0
019500051123     D  FilSvrRef                    10u 0
019600051221     D  FilSvrWrkDir                 10u 0
019700051123     D  ChkOut                       10u 0
019800051123     D  ChkOutUsrNm                  10a
019900051123     D                                2a
020000051123     **-- API path:
020100051123     D Qlg_Path_Name   Ds                  Qualified  Based( pQlg_Path_Name )
020200051123     D  CcsId                        10i 0
020300051123     D  CtrId                         2a
020400051123     D  LngId                         3a
020500051123     D                                3a
020600051123     D  PthTypI                      10i 0
020700051123     D  PthNamLen                    10i 0
020800051123     D  PthNamDlm                     2a
020900051123     D                               10a
021000051123     D  PthNam                     5000a
021100051123
021200051123     **-- Retrieve job references:
021300051123     D RtvJobRef       Pr                  ExtPgm( 'QP0LRRO' )
021400051123     D  RcvVar                    65535a          Options( *VarSize )
021500051123     D  RcvVarLen                    10u 0 Const
021600051123     D  RcvFmt                        8a   Const
021700051123     D  JobId                        56a   Const
021800051123     D  JobIdFmt                      8a   Const
021900051123     D  Error                     32767a          Options( *VarSize: *NoPass)
022000051123     **-- Convert string:
022100051123     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
022200051123     D  InpCcsId                     10i 0 Const
022300051123     D  InpStrTyp                    10i 0 Const
022400051124     D  InpStr                    32767a   Const  Options( *VarSize )
022500051123     D  InpStrSiz                    10i 0 Const
022600051123     D  OutCcsId                     10i 0 Const
022700051123     D  OutStrTyp                    10i 0 Const
022800051123     D  OutCvtAlt                    10i 0 Const
022900051123     D  OutStrSiz                    10i 0 Const
023000051124     D  OutStr                    32767a          Options( *VarSize )
023100051123     D  OutStrLenRt                  10i 0
023200051123     D  NotSup                       10i 0       Const
023300051123     D  FB                           10i 0 Dim( 3 )
023400051123     **-- Retrieve job information:
023500051123     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
023600051124     D  RcvVar                    32767a          Options( *VarSize )
023700051124     D  RcvVarLen                    10i 0 Const
023800051124     D  FmtNam                        8a   Const
023900051124     D  JobNamQ                      26a   Const
024000051124     D  JobIntId                     16a   Const
024100051124     D  Error                     32767a          Options( *NoPass: *VarSize )
024200051123     **-- Send program message:
024300051123     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
024400051124     D  MsgId                         7a   Const
024500051124     D  MsgFq                        20a   Const
024600051124     D  MsgDta                      128a   Const
024700051124     D  MsgDtaLen                    10i 0 Const
024800051124     D  MsgTyp                       10a   Const
024900051124     D  CalStkE                      10a   Const  Options( *VarSize )
025000051124     D  CalStkCtr                    10i 0 Const
025100051124     D  MsgKey                        4a
025200051124     D  Error                      1024a          Options( *VarSize )
025300051218     **-- Retrieve last spooled file identity:
025400051218     D RtvLstSplfId    Pr                  ExtPgm( 'QSPRILSP' )
025500051218     D  RcvVar                    32767a          Options( *VarSize )
025600051218     D  RcvVarLen                    10i 0 Const
025700051218     D  FmtNam                        8a   Const
025800051218     D  Error                     32767a          Options( *VarSize )
025900051218     **-- Register termination exit:
026000051221     D CeeRtx          Pr                  ExtProc( 'CEERTX' )
026100051221     D  procedure                      *   Const  ProcPtr
026200051221     D  token                          *          Options( *Omit )
026300051221     D  fb                           12a          Options( *Omit )
026400051218     **-- Unregister termination exit:
026500051221     D CeeUtx          Pr                  ExtProc( 'CEEUTX' )
026600051221     D  procedure                      *   Const  ProcPtr
026700051221     D  fb                           12a          Options( *Omit )
026800051221     **-- Normal end:
026900051221     D Exit            Pr                  ExtProc( 'CEETREC' )
027000051221     D  cel_rc_mod                   10i 0 Const  Options( *NoPass )
027100051221     D  user_rc                      10i 0 Const  Options( *NoPass )
027200051218     **-- Run system command:
027300051218     D system          Pr            10i 0 ExtProc( 'system' )
027400051218     D  command                        *   Value  Options( *String )
027500051123
027600051221     **-- Write detail line:
027700051221     D WrtDtlLin       Pr
027800051222     **-- Write detail line 2:
027900051222     D WrtDtlLin2      Pr
028000051221     **-- Write list header:
028100051221     D WrtLstHdr       Pr
028200051221     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
028300051221     **-- Write list trailer:
028400051221     D WrtLstTrl       Pr
028500051221     D  PxTrlTxt                     32a   Const
028600051218     **-- Terminate program:
028700051218     D TrmPgm          Pr
028800051218     D  pPtr                           *
028900051218     **-- Get job type:
029000051218     D GetJobTyp       Pr             1a
029100051123     **-- Get job ccsid:
029200051123     D JobCcsId        Pr            10i 0
029300051221     **-- Send escape message:
029400051221     D SndEscMsg       Pr            10i 0
029500051221     D  PxMsgId                       7a   Const
029600051221     D  PxMsgF                       10a   Const
029700051221     D  PxMsgDta                    512a   Const  Varying
029800051123     **-- Send completion message:
029900051123     D SndCmpMsg       Pr            10i 0
030000051123     D  PxMsgDta                    512a   Const  Varying
030100051123
030200051218     D CBX950          Pr
030300051218     D  PxJobNam_q                         LikeDs( JobNam_q )
030400051218     D  PxDspOpt                      3a
030500051222     D  PxLngPth                      1a
030600051218     **
030700051218     D CBX950          Pi
030800051218     D  PxJobNam_q                         LikeDs( JobNam_q )
030900051218     D  PxDspOpt                      3a
031000051222     D  PxLngPth                      1a
031100041018
031200041018      /Free
031300051218
031400051218        system( 'OVRPRTF FILE(QSYSPRT) HOLD(*YES) SECURE(*YES) ' +
031500051218                'OVRSCOPE(*JOB)'
031600051218              );
031700051218
031800051218        Open  QSYSPRT;
031900051218
032000051218        If PxJobNam_q = '*';
032100051218          PxJobNam_q = PgmSts.JobNam_q;
032200051218        EndIf;
032300051221
032400051221        JIDF0100.JobNam_q = PxJobNam_q;
032500051218
032600051123        BytAlc = 65535;
032700051123        pRROO0100 = %Alloc( BytAlc );
032800051123        RROO0100.BytAvl = *Zero;
032900041018
033000051218
033100051123        DoU  RROO0100.BytAvl <= BytAlc;
033200051123
033300051123          If  RROO0100.BytAvl > BytAlc;
033400051123            BytAlc = RROO0100.BytAvl;
033500051123            pRROO0100 = %ReAlloc( pRROO0100: BytAlc );
033600051123          EndIf;
033700051123
033800051218          CeeRtx( %Paddr( TrmPgm ): pRROO0100: *Omit );
033900051218
034000051218          Monitor;
034100051218            RtvJobRef( RROO0100
034200051218                     : BytAlc
034300051218                     : 'RROO0100'
034400051218                     : JIDF0100
034500051218                     : 'JIDF0100'
034600051218                     : ERRC0100
034700051218                     );
034800051218
034900051218          On-Error;
035000051221            SndEscMsg( 'CPF9897': 'QCPFMSG': 'Release must be V5R2 or higher.');
035100051218          EndMon;
035200041018
035300051123          If  ERRC0100.BytAvl > *Zero;
035400051123            Leave;
035500051123          EndIf;
035600051123        EndDo;
035700041018
035800051221        If  ERRC0100.BytAvl > *Zero;
035900051221
036000051221          If  ERRC0100.BytAvl < OFS_MSGDTA;
036100051221            ERRC0100.BytAvl = OFS_MSGDTA;
036200051221          EndIf;
036300051221
036400051221          SndEscMsg( ERRC0100.MsgId
036500051221                   : 'QCPFMSG'
036600051221                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
036700051221                   );
036800051221        Else;
036900051218          ExSr  PrcJobRef;
037000051123        EndIf;
037100051218
037200051218        system( 'DLTOVR  FILE(QSYSPRT) LVL(*JOB)' );
037300051218
037400051218        Close  QSYSPRT;
037500051218
037600051221        If  PxDspOpt = 'DSP'  And  GetJobTyp() = 'I';
037700051218          ExSr  DspLst;
037800051218
037900051218        Else;
038000051218          ExSr  WrtLst;
038100051218        EndIf;
038200051218
038300051123
038400041018        *InLr = *On;
038500051221
038600051221        Exit();
038700041018        Return;
038800051123
038900051218
039000051218        BegSr  DspLst;
039100051218
039200051218          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );
039300051218
039400051218          system( 'DSPSPLF '                     +
039500051218                  'FILE(' + %Trim( SPRL0100.SplfNam )   + ') ' +
039600051218                  'JOB('  + %Trim( SPRL0100.JobNbr )    + '/'  +
039700051218                            %Trim( SPRL0100.UsrNam )    + '/'  +
039800051218                            %Trim( SPRL0100.JobNam )    + ') ' +
039900051218                  'SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
040000051218                );
040100051218
040200051218          system( 'DLTSPLF '                     +
040300051218                  'FILE(' + %Trim( SPRL0100.SplfNam )   + ') ' +
040400051218                  'JOB('  + %Trim( SPRL0100.JobNbr )    + '/'  +
040500051218                            %Trim( SPRL0100.UsrNam )    + '/'  +
040600051218                            %Trim( SPRL0100.JobNam )    + ') ' +
040700051218                  'SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
040800051218                );
040900051218
041000051218        EndSr;
041100051218
041200051218        BegSr  WrtLst;
041300051218
041400051218          SndCmpMsg( 'List has been printed.' );
041500051218
041600051218        EndSr;
041700051218
041800051218        BegSr  PrcJobRef;
041900051218
042000051221          LstTim = %Int( %Char( %Time(): *ISO0));
042100051221
042200051221          OutHdr.JobNam = PxJobNam_q.JobNam;
042300051221          OutHdr.UsrPrf = PxJobNam_q.UsrPrf;
042400051221          OutHdr.JobNbr = PxJobNam_q.JobNbr;
042500051218
042600051221          WrtLstHdr();
042700051218
042800051218          pQp0l_Obj_List = %Addr( RROO0100 ) + RROO0100.OfsObjLst;
042900051218
043000051218          For  Idx = 1  To  RROO0100.ObjRtnCnt;
043100051218
043200051218            ExSr  GetRefDtl;
043300051218
043400051218            If Idx <  RROO0100.ObjRtnCnt;
043500051218              pQp0l_Obj_List += Qp0l_Obj_List.DplNxtObj;
043600051218            EndIf;
043700051218          EndFor;
043800051218
043900051218          If  NbrRcds = *Zero;
044000051221            WrtLstTrl( '  (No IFS locks found)');
044100051221          Else;
044200051221            WrtLstTrl( '***  E N D  O F  L I S T  ***' );
044300051218          EndIf;
044400051218
044500051218        EndSr;
044600051218
044700051123        BegSr  GetRefDtl;
044800051123
044900051123          pQp0l_Ext_Ref_T = pQp0l_Obj_List + Qp0l_Obj_List.DplExtRefTyp;
045000051123          pQlg_Path_Name  = pQp0l_Obj_List + Qp0l_Obj_List.DplPthNam;
045100051123
045200051123          CvtString( Qlg_Path_Name.CcsId
045300051123                   : 0
045400051123                   : Qlg_Path_Name.PthNam
045500051123                   : Qlg_Path_Name.PthNamLen
045600051123                   : JobCcsId()
045700051123                   : 0
045800051123                   : 0
045900051123                   : %Size( IfsObj )
046000051123                   : IfsObj
046100051221                   : PthRtnLen
046200051123                   : NotSup
046300051123                   : FB
046400051123                   );
046500051123
046600051123          If  FB(1) > *Zero;
046700051221            SndEscMsg( 'CPF9897': 'QCPFMSG': 'Data conversion ended in error.');
046800051123
046900051123          Else;
047000051123            CvtString( Qlg_Path_Name.CcsId
047100051123                     : 0
047200051123                     : Qlg_Path_Name.PthNamDlm
047300051123                     : %Size( Qlg_Path_Name.PthNamDlm )
047400051123                     : JobCcsId()
047500051123                     : 0
047600051123                     : 0
047700051123                     : %Size( PthDlm )
047800051123                     : PthDlm
047900051221                     : DlmRtnLen
048000051123                     : NotSup
048100051123                     : FB
048200051123                     );
048300051123          EndIf;
048400051218
048500051218          ExSr  WrtLckDtl;
048600051123
048700051123        EndSr;
048800051218
048900051218        BegSr  WrtLckDtl;
049000051218
049100051218          NbrRcds += 1;
049200051218
049300051222          IfsObjV = %TrimR( IfsObj );
049400051222
049500051222          If  %Len( IfsObjV ) > %Size( OutDtl.IfsObj );
049600051222            EvalR  OutDtl.IfsObj = IfsObjV;
049700051222            %Subst( OutDtl.IfsObj: 1: 2 ) = '< ';
049800051221
049900051221          Else;
050000051222            OutDtl.IfsObj = IfsObjV;
050100051221          EndIf;
050200051221
050300051221          If  Qp0l_Ext_Ref_T.ChkOut > *Zero;
050400051221            OutDtl.ChkUsr = Qp0l_Ext_Ref_T.ChkOutUsrNm;
050500051221          Else;
050600051221            OutDtl.ChkUsr = '*NONE';
050700051221          EndIf;
050800051221
050900051221          OutDtl.SavLck = Qp0l_Ext_Ref_T.SavLck;
051000051221          OutDtl.AtrLck = Qp0l_Ext_Ref_T.AtrLck;
051100051221
051200051221          OutDtl.ShrNoRW = Qp0l_Ext_Ref_T.XRonShrNoRW +
051300051221                           Qp0l_Ext_Ref_T.RWonShrNoRW +
051400051221                           Qp0l_Ext_Ref_T.WtOnShrNoRW +
051500051221                           Qp0l_Ext_Ref_T.RdOnShrNoRW;
051600051221
051700051221          OutDtl.ShrRdWr = Qp0l_Ext_Ref_T.XRonShrRdWt +
051800051221                           Qp0l_Ext_Ref_T.RWonShrRdWt +
051900051221                           Qp0l_Ext_Ref_T.WtOnShrRdWt +
052000051221                           Qp0l_Ext_Ref_T.RdOnShrRdWt;
052100051221
052200051221          OutDtl.ShrWtOn = Qp0l_Ext_Ref_T.XRonShrWtOn +
052300051221                           Qp0l_Ext_Ref_T.RWonShrWtOn +
052400051221                           Qp0l_Ext_Ref_T.WtOnShrWtOn +
052500051221                           Qp0l_Ext_Ref_T.RdOnShrWtOn;
052600051221
052700051221          OutDtl.ShrRdOn = Qp0l_Ext_Ref_T.XRonShrRdOn +
052800051221                           Qp0l_Ext_Ref_T.RWonShrRdOn +
052900051221                           Qp0l_Ext_Ref_T.WtOnShrRdOn +
053000051221                           Qp0l_Ext_Ref_T.RdOnShrRdOn;
053100051221
053200051221          OutDtl.Execute = Qp0l_Ext_Ref_T.XRonShrRdOn +
053300051221                           Qp0l_Ext_Ref_T.XRonShrWtOn +
053400051221                           Qp0l_Ext_Ref_T.XRonShrRdWt +
053500051221                           Qp0l_Ext_Ref_T.XRonShrNoRW;
053600051221
053700051221          OutDtl.ReadWrt = Qp0l_Ext_Ref_T.RWonShrRdOn +
053800051221                           Qp0l_Ext_Ref_T.RWonShrWtOn +
053900051221                           Qp0l_Ext_Ref_T.RWonShrRdWt +
054000051221                           Qp0l_Ext_Ref_T.RWonShrNoRW;
054100051221
054200051221          OutDtl.WrtOnly = Qp0l_Ext_Ref_T.WtOnShrRdOn +
054300051221                           Qp0l_Ext_Ref_T.WtOnShrWtOn +
054400051221                           Qp0l_Ext_Ref_T.WtOnShrRdWt +
054500051221                           Qp0l_Ext_Ref_T.WtOnShrNoRW;
054600051221
054700051221          OutDtl.RdOnly  = Qp0l_Ext_Ref_T.RdOnShrRdOn +
054800051221                           Qp0l_Ext_Ref_T.RdOnShrWtOn +
054900051221                           Qp0l_Ext_Ref_T.RdOnShrRdWt +
055000051221                           Qp0l_Ext_Ref_T.RdOnShrNoRW;
055100051221
055200051221          WrtDtlLin();
055300051222
055400051222          If  PxLngPth = 'F'  And  %Len( IfsObjV ) > %Size( OutDtl.IfsObj );
055500051222
055600051222            DoU  %Len( IfsObjV ) = *Zero;
055700051222              OutDtl.IfsObjF = IfsObjV;
055800051222
055900051222              WrtDtlLin2();
056000051222
056100051222              If  %Len( IfsObjV ) > %Size( OutDtl.IfsObjF );
056200051222                IfsObjV = %Subst( IfsObjV: %Size( OutDtl.IfsObjF ) + 1 );
056300051222              Else;
056400051222                IfsObjV = NULL;
056500051222              EndIf;
056600051222            EndDo;
056700051222          EndIf;
056800051218
056900051218        EndSr;
057000041018
057100041018      /End-Free
057200051218
057300051218     **-- Printer file definition:  ------------------------------------------**
057400051218     OQSYSPRT   EF           Header         2  2
057500051218     O                       UDATE         Y      8
057600051221     O                       LstTim              18 '  :  :  '
057700051222     O                                           70 'Display job IFS object -
057800051222     O                                              locks'
057900051218     O                                          107 'Program:'
058000051221     O                       PgmSts.PgmNam      118
058100051218     O                                          126 'Page:'
058200051218     O                       PAGE             +   1
058300051218     OQSYSPRT   EF           LstHdr         1
058400051221     O                                           18 'Job name . . . . :'
058500051221     O                       OutHdr.JobNam       30
058600051218     OQSYSPRT   EF           LstHdr         1
058700051221     O                                           18 '  User . . . . . :'
058800051221     O                       OutHdr.UsrPrf       30
058900051218     OQSYSPRT   EF           LstHdr         1
059000051221     O                                           18 '  Number . . . . :'
059100051221     O                       OutHdr.JobNbr       26
059200051218     OQSYSPRT   EF           DtlHdr         1
059300051222     O                                          107 '------------- Shared ------
059400051218     O                                              --------'
059500051222     O                                          120 '-- Locks --'
059600051218     OQSYSPRT   EF           DtlHdr         1
059700051221     O                                           10 'IFS object'
059800051221     O                                           49 'Rd only'
059900051221     O                                           58 'Wr only'
060000051221     O                                           65 'Rd/wr'
060100051221     O                                           71 'Exec'
060200051221     O                                           80 'Rd only'
060300051221     O                                           89 'Wr only'
060400051221     O                                           97 'Rd/wr'
060500051221     O                                          107 'No rd/wr'
060600051221     O                                          113 'Attr'
060700051221     O                                          120 'Save'
060800051221     O                                          131 'Check out'
060900051218     **-- Write right->left (prevent overlay):
061000051218     OQSYSPRT   EF           LckDtl         1
061100051221     O                       OutDtl.ChkUsr      132
061200051221     O                       OutDtl.SavLck 3    119
061300051221     O                       OutDtl.AtrLck 3    112
061400051221     O                       OutDtl.ShrNoRW3    104
061500051221     O                       OutDtl.ShrRdWr3     95
061600051221     O                       OutDtl.ShrWtOn3     87
061700051221     O                       OutDtl.ShrRdOn3     78
061800051221     O                       OutDtl.Execute3     70
061900051221     O                       OutDtl.ReadWrt3     63
062000051221     O                       OutDtl.WrtOnly3     56
062100051221     O                       OutDtl.RdOnly 3     47
062200051221     O                       OutDtl.IfsObj       42
062300051222     OQSYSPRT   EF           LckDtl2        1
062400051222     O                       OutDtl.IfsObjF     132
062500051221     **
062600051221     OQSYSPRT   EF           LstTrl         1
062700051221     O                       TrlTxt              34
062800051221     **-- Write detail line:  ------------------------------------------------**
062900051221     P WrtDtlLin       B
063000051221     D                 Pi
063100051221
063200051221      /Free
063300051221
063400051221        WrtLstHdr( 3 );
063500051221
063600051221        Except  LckDtl;
063700051221
063800051221      /End-Free
063900051221
064000051221     P WrtDtlLin       E
064100051222     **-- Write detail line 2:  ----------------------------------------------**
064200051222     P WrtDtlLin2      B
064300051222     D                 Pi
064400051222
064500051222      /Free
064600051222
064700051222        WrtLstHdr( 2 );
064800051222
064900051222        Except  LckDtl2;
065000051222
065100051222      /End-Free
065200051222
065300051222     P WrtDtlLin2      E
065400051221     **-- Write list header:  ------------------------------------------------**
065500051221     P WrtLstHdr       B
065600051221     D                 Pi
065700051221     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
065800051221
065900051221      /Free
066000051221
066100051221        If  %Parms = *Zero;
066200051221          Except  Header;
066300051221          Except  LstHdr;
066400051221          Except  DtlHdr;
066500051221
066600051221        Else;
066700051221          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
066800051221
066900051221            Except  Header;
067000051221            Except  DtlHdr;
067100051221          EndIf;
067200051221        EndIf;
067300051221
067400051221      /End-Free
067500051221
067600051221     P WrtLstHdr       E
067700051221     **-- Write list trailer:  -----------------------------------------------**
067800051221     P WrtLstTrl       B
067900051221     D                 Pi
068000051221     D  PxTrlTxt                     32a   Const
068100051221
068200051221      /Free
068300051221
068400051221        TrlTxt = PxTrlTxt;
068500051221
068600051221        Except  LstTrl;
068700051221
068800051221      /End-Free
068900051221
069000051221     P WrtLstTrl       E
069100051218     **-- Get job type:  -----------------------------------------------------**
069200051218     P GetJobTyp       B
069300051218     D                 Pi             1a
069400051218
069500051218     D JOBI0400        Ds                  Qualified
069600051218     D  BytRtn                       10i 0
069700051218     D  BytAvl                       10i 0
069800051218     D  JobNam                       10a
069900051218     D  UsrNam                       10a
070000051218     D  JobNbr                        6a
070100051218     D  JobIntId                     16a
070200051218     D  JobSts                       10a
070300051218     D  JobTyp                        1a
070400051218     D  JobSubTyp                     1a
070500051218
070600051218      /Free
070700051218
070800051218        RtvJobInf( JOBI0400
070900051218                 : %Size( JOBI0400 )
071000051218                 : 'JOBI0400'
071100051218                 : '*'
071200051218                 : *Blank
071300051218                 : ERRC0100
071400051218                 );
071500051218
071600051218        If  ERRC0100.BytAvl > *Zero;
071700051218          Return  *Blank;
071800051218
071900051218        Else;
072000051218          Return  JOBI0400.JobTyp;
072100051218        EndIf;
072200051218
072300051218      /End-Free
072400051218
072500051218     P GetJobTyp       E
072600051123     **-- Get job ccsid:  ----------------------------------------------------**
072700051123     P JobCcsId        B
072800051123     D                 Pi            10i 0
072900051123     **-- Job info format JOBI0400:
073000051123     D JOBI0400        Ds                  Qualified
073100051123     D  BytRtn                       10i 0
073200051123     D  BytAvl                       10i 0
073300051123     D  JobNam                       10a
073400051123     D  UsrNam                       10a
073500051123     D  JobNbr                        6a
073600051123     D  CcsId                        10i 0 Overlay( JOBI0400: 301 )
073700051123     D  CcsIdDft                     10i 0 Overlay( JOBI0400: 373 )
073800051123
073900051123      /Free
074000051123
074100051123        RtvJobInf( JOBI0400
074200051123                 : %Size( JOBI0400 )
074300051123                 : 'JOBI0400'
074400051123                 : '*'
074500051123                 : *Blank
074600051123                 : ERRC0100
074700051123                 );
074800051123
074900051123        Select;
075000051123        When  ERRC0100.BytAvl > *Zero;
075100051123          Return  -1;
075200051123
075300051123        When  JOBI0400.CcsId = 65535;
075400051123          Return  JOBI0400.CcsIdDft;
075500051123
075600051123        Other;
075700051123          Return  JOBI0400.CcsId;
075800051123        EndSl;
075900051123
076000051123      /End-Free
076100051123
076200051123     P JobCcsId        E
076300051221     **-- Send escape message:  ----------------------------------------------**
076400051221     P SndEscMsg       B
076500051221     D                 Pi            10i 0
076600051221     D  PxMsgId                       7a   Const
076700051221     D  PxMsgF                       10a   Const
076800051221     D  PxMsgDta                    512a   Const  Varying
076900051221     **
077000051221     D MsgKey          s              4a
077100051221
077200051221      /Free
077300051221
077400051221        SndPgmMsg( PxMsgId
077500051221                 : PxMsgF + '*LIBL'
077600051221                 : PxMsgDta
077700051221                 : %Len( PxMsgDta )
077800051221                 : '*ESCAPE'
077900051221                 : '*PGMBDY'
078000051221                 : 1
078100051221                 : MsgKey
078200051221                 : ERRC0100
078300051221                 );
078400051221
078500051221        If  ERRC0100.BytAvl > *Zero;
078600051221          Return  -1;
078700051221
078800051221        Else;
078900051221          Return   0;
079000051221        EndIf;
079100051221
079200051221      /End-Free
079300051221
079400051221     P SndEscMsg       E
079500051123     **-- Send completion message:  ------------------------------------------**
079600051123     P SndCmpMsg       B
079700051123     D                 Pi            10i 0
079800051123     D  PxMsgDta                    512a   Const  Varying
079900051123     **
080000051123     D MsgKey          s              4a
080100051123
080200051123      /Free
080300051123
080400051123        SndPgmMsg( 'CPF9897'
080500051123                 : 'QCPFMSG   *LIBL'
080600051123                 : PxMsgDta
080700051123                 : %Len( PxMsgDta )
080800051123                 : '*COMP'
080900051123                 : '*PGMBDY'
081000051123                 : 1
081100051123                 : MsgKey
081200051123                 : ERRC0100
081300051123                 );
081400051123
081500051123        If  ERRC0100.BytAvl > *Zero;
081600051123          Return  -1;
081700051123
081800051123        Else;
081900051123          Return  0;
082000051123
082100051123        EndIf;
082200051123
082300051123      /End-Free
082400051123
082500051123     P SndCmpMsg       E
082600051218     **-- Terminate program:  ------------------------------------------------**
082700051218     P TrmPgm          B
082800051218     D                 Pi
082900051218     D  pPtr                           *
083000051218
083100051218      /Free
083200051218
083300051218        DeAlloc  pPtr;
083400051218
083500051218        *InLr = *On;
083600051218
083700051218        Return;
083800051218
083900051218      /End-Free
084000051218
084100051218     P TrmPgm          E
