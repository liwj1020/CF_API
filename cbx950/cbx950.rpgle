     **
     **  Program . . : CBX950
     **  Description : Display job IFS object lock
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **
     **  Programmer's notes:
     **    The QP0LRRO API (Retrieve object references) was introduced with
     **    release V5R3 and this program will therefore not be able to run
     **    succesfully on earlier releases.
     **
     **    QP0LRRO documentation and comprehensive usage notes can be found here:
     **    http://publib.boulder.ibm.com/infocenter/iseries/v5r3/topic/apis/qp0lrro.htm
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX950 )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX950 )
     **               Module( CBX950 )
     **               ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  BndDir( 'QC2LE' )
     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
     F                                      UsrOpn

     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )

     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  JobNam_q                     26a   Overlay( PgmSts: 244 )
     D  JobNam                       10a   Overlay( PgmSts: 244 )
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- system function error ID:
     D SysError        s              7a   Import( '_EXCP_MSGID' )

     **-- Global variables:
     D LstTim          s              6s 0
     D TrlTxt          s             32a
     D BytAlc          s             10i 0
     D NbrRcds         s             10u 0
     D Idx             s             10i 0
     D PthRtnLen       s             10i 0
     D DlmRtnLen       s             10i 0
     D NotSup          s             10i 0
     D FB              s             10i 0 Dim( 3 )
     D IfsObj          s           5000a
     D IfsObjV         s           5000a   Varying
     D PthDlm          s              2a
     D MsgKey          s              4a
     **
     D JobNam_q        Ds                  Qualified
     D  JobNam                       10a
     D  UsrPrf                       10a
     D  JobNbr                        6a
     **
     D OutHdr          Ds                  Qualified  Inz
     D  JobNam                       10a
     D  UsrPrf                       10a
     D  JobNbr                        6a
     **
     D OutDtl          Ds                  Qualified  Inz
     D  IfsObj                       42a
     D  SavLck                       10u 0
     D  AtrLck                       10u 0
     D  ShrNoRW                      10u 0
     D  ShrRdWr                      10u 0
     D  ShrWtOn                      10u 0
     D  ShrRdOn                      10u 0
     D  Execute                      10u 0
     D  ReadWrt                      10u 0
     D  WrtOnly                      10u 0
     D  RdOnly                       10u 0
     D  ChkUsr                       10a
     D  IfsObjF                     130a
     **-- Global constants:
     D NULL            c                    ''
     D OFS_MSGDTA      c                   16
     **
     D QP0L_ROOT_FS    c                    0
     D QP0L_OPENSYS...
     D _FS             c                    1
     D QP0L_UDFS_FS    c                    2
     D QP0L_UDFS_MANAGEMENT_FS...
     D                 c                    3
     D QP0L_QSYS_FS    c                    4
     D QP0L_IASPQSYS_FS...
     D                 c                    5
     D QP0L_QDLS_FS    c                    6
     D QP0L_NFS_FS     c                    7
     D QP0L_QNETWARE_FS...
     D                 c                    8
     D QP0L_QOPT_FS    c                    9
     D QP0L_QFILSVR400_FS...
     D                 c                   10
     D QP0L_QNTC_FS    c                   11
     **
     D QP0L_NO_ERROR   c                   0
     D QP0L_ERROR      c                   1
     D QP0L_SPACE_ERROR...
     D                 c                   2

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
     **-- Job identification:
     D JIDF0100        Ds                   Qualified  Inz
     D  JobNam_q                     26a
     D  JobNam                       10a    Overlay( JobNam_q: 1 )
     D  UsrNam                       10a    Overlay( JobNam_q: *Next )
     D  JobNbr                        6a    Overlay( JobNam_q: *Next )
     D  IntJobId                     16a
     D                                2a    Inz( *Allx'00' )
     D  ThrInd                       10i 0  Inz( 1 )
     D  ThrId                         8a    Inz( *Allx'00' )
     **-- Object reference information:
     D RROO0100        Ds                  Qualified  Based( pRROO0100 )
     D  BytRtn                       10u 0
     D  BytAvl                       10u 0
     D  ObjRtnCnt                    10u 0
     D  ObjAvlCnt                    10u 0
     D  OfsObjLst                    10u 0
     D  RtvRefSts                    10u 0
     **
     D Qp0l_Obj_List   Ds                  Qualified  Based( pQp0l_Obj_List )
     D  DplNxtObj                    10u 0
     D  DplExtRefTyp                 10u 0
     D  LenExtRefTyp                 10u 0
     D  RefCnt                       10u 0
     D  DplPthNam                    10u 0
     D  LenPthNam                    10u 0
     D  FilId                        16a
     D  FilSysId                     20u 0
     D  FilSysTyp                    10u 0
     D  FilIdNbr                     10u 0
     D  GenId                        10u 0
     **-- Extended object reference types structure:
     D Qp0l_Ext_Ref_T  Ds                   Qualified  Based( pQp0l_Ext_Ref_T )
     D  RdOnShrRdOn                  10u 0
     D  RdOnShrWtOn                  10u 0
     D  RdOnShrRdWt                  10u 0
     D  RdOnShrNoRW                  10u 0
     D  WtOnShrRdOn                  10u 0
     D  WtOnShrWtOn                  10u 0
     D  WtOnShrRdWt                  10u 0
     D  WtOnShrNoRW                  10u 0
     D  RWonShrRdOn                  10u 0
     D  RWonShrWtOn                  10u 0
     D  RWonShrRdWt                  10u 0
     D  RWonShrNoRW                  10u 0
     D  ExOnShrRdOn                  10u 0
     D  ExOnShrWtOn                  10u 0
     D  ExOnShrRdWt                  10u 0
     D  ExOnShrNoRW                  10u 0
     D  XRonShrRdOn                  10u 0
     D  XRonShrWtOn                  10u 0
     D  XRonShrRdWt                  10u 0
     D  XRonShrNoRW                  10u 0
     D  AtrLck                       10u 0
     D  SavLck                       10u 0
     D  SavLckInt                    10u 0
     D  LnkChgLck                    10u 0
     D  CurDir                       10u 0
     D  RootDir                      10u 0
     D  FilSvrRef                    10u 0
     D  FilSvrWrkDir                 10u 0
     D  ChkOut                       10u 0
     D  ChkOutUsrNm                  10a
     D                                2a
     **-- API path:
     D Qlg_Path_Name   Ds                  Qualified  Based( pQlg_Path_Name )
     D  CcsId                        10i 0
     D  CtrId                         2a
     D  LngId                         3a
     D                                3a
     D  PthTypI                      10i 0
     D  PthNamLen                    10i 0
     D  PthNamDlm                     2a
     D                               10a
     D  PthNam                     5000a

     **-- Retrieve job references:
     D RtvJobRef       Pr                  ExtPgm( 'QP0LRRO' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10u 0 Const
     D  RcvFmt                        8a   Const
     D  JobId                        56a   Const
     D  JobIdFmt                      8a   Const
     D  Error                     32767a          Options( *VarSize: *NoPass)
     **-- Convert string:
     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
     D  InpCcsId                     10i 0 Const
     D  InpStrTyp                    10i 0 Const
     D  InpStr                    32767a   Const  Options( *VarSize )
     D  InpStrSiz                    10i 0 Const
     D  OutCcsId                     10i 0 Const
     D  OutStrTyp                    10i 0 Const
     D  OutCvtAlt                    10i 0 Const
     D  OutStrSiz                    10i 0 Const
     D  OutStr                    32767a          Options( *VarSize )
     D  OutStrLenRt                  10i 0
     D  NotSup                       10i 0       Const
     D  FB                           10i 0 Dim( 3 )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNamQ                      26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a          Options( *NoPass: *VarSize )
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
     **-- Retrieve last spooled file identity:
     D RtvLstSplfId    Pr                  ExtPgm( 'QSPRILSP' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Register termination exit:
     D CeeRtx          Pr                  ExtProc( 'CEERTX' )
     D  procedure                      *   Const  ProcPtr
     D  token                          *          Options( *Omit )
     D  fb                           12a          Options( *Omit )
     **-- Unregister termination exit:
     D CeeUtx          Pr                  ExtProc( 'CEEUTX' )
     D  procedure                      *   Const  ProcPtr
     D  fb                           12a          Options( *Omit )
     **-- Normal end:
     D Exit            Pr                  ExtProc( 'CEETREC' )
     D  cel_rc_mod                   10i 0 Const  Options( *NoPass )
     D  user_rc                      10i 0 Const  Options( *NoPass )
     **-- Run system command:
     D system          Pr            10i 0 ExtProc( 'system' )
     D  command                        *   Value  Options( *String )

     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write detail line 2:
     D WrtDtlLin2      Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     32a   Const
     **-- Terminate program:
     D TrmPgm          Pr
     D  pPtr                           *
     **-- Get job type:
     D GetJobTyp       Pr             1a
     **-- Get job ccsid:
     D JobCcsId        Pr            10i 0
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX950          Pr
     D  PxJobNam_q                         LikeDs( JobNam_q )
     D  PxDspOpt                      3a
     D  PxLngPth                      1a
     **
     D CBX950          Pi
     D  PxJobNam_q                         LikeDs( JobNam_q )
     D  PxDspOpt                      3a
     D  PxLngPth                      1a

      /Free

        system( 'OVRPRTF FILE(QSYSPRT) HOLD(*YES) SECURE(*YES) ' +
                'OVRSCOPE(*JOB)'
              );

        Open  QSYSPRT;

        If PxJobNam_q = '*';
          PxJobNam_q = PgmSts.JobNam_q;
        EndIf;

        JIDF0100.JobNam_q = PxJobNam_q;

        BytAlc = 65535;
        pRROO0100 = %Alloc( BytAlc );
        RROO0100.BytAvl = *Zero;


        DoU  RROO0100.BytAvl <= BytAlc;

          If  RROO0100.BytAvl > BytAlc;
            BytAlc = RROO0100.BytAvl;
            pRROO0100 = %ReAlloc( pRROO0100: BytAlc );
          EndIf;

          CeeRtx( %Paddr( TrmPgm ): pRROO0100: *Omit );

          Monitor;
            RtvJobRef( RROO0100
                     : BytAlc
                     : 'RROO0100'
                     : JIDF0100
                     : 'JIDF0100'
                     : ERRC0100
                     );

          On-Error;
            SndEscMsg( 'CPF9897': 'QCPFMSG': 'Release must be V5R2 or higher.');
          EndMon;

          If  ERRC0100.BytAvl > *Zero;
            Leave;
          EndIf;
        EndDo;

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );
        Else;
          ExSr  PrcJobRef;
        EndIf;

        system( 'DLTOVR  FILE(QSYSPRT) LVL(*JOB)' );

        Close  QSYSPRT;

        If  PxDspOpt = 'DSP'  And  GetJobTyp() = 'I';
          ExSr  DspLst;

        Else;
          ExSr  WrtLst;
        EndIf;


        *InLr = *On;

        Exit();
        Return;


        BegSr  DspLst;

          RtvLstSplfId( SPRL0100: %Size( SPRL0100 ): 'SPRL0100': ERRC0100 );

          system( 'DSPSPLF '                     +
                  'FILE(' + %Trim( SPRL0100.SplfNam )   + ') ' +
                  'JOB('  + %Trim( SPRL0100.JobNbr )    + '/'  +
                            %Trim( SPRL0100.UsrNam )    + '/'  +
                            %Trim( SPRL0100.JobNam )    + ') ' +
                  'SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
                );

          system( 'DLTSPLF '                     +
                  'FILE(' + %Trim( SPRL0100.SplfNam )   + ') ' +
                  'JOB('  + %Trim( SPRL0100.JobNbr )    + '/'  +
                            %Trim( SPRL0100.UsrNam )    + '/'  +
                            %Trim( SPRL0100.JobNam )    + ') ' +
                  'SPLNBR(' + %Char( SPRL0100.SplfNbr ) + ')'
                );

        EndSr;

        BegSr  WrtLst;

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  PrcJobRef;

          LstTim = %Int( %Char( %Time(): *ISO0));

          OutHdr.JobNam = PxJobNam_q.JobNam;
          OutHdr.UsrPrf = PxJobNam_q.UsrPrf;
          OutHdr.JobNbr = PxJobNam_q.JobNbr;

          WrtLstHdr();

          pQp0l_Obj_List = %Addr( RROO0100 ) + RROO0100.OfsObjLst;

          For  Idx = 1  To  RROO0100.ObjRtnCnt;

            ExSr  GetRefDtl;

            If Idx <  RROO0100.ObjRtnCnt;
              pQp0l_Obj_List += Qp0l_Obj_List.DplNxtObj;
            EndIf;
          EndFor;

          If  NbrRcds = *Zero;
            WrtLstTrl( '  (No IFS locks found)');
          Else;
            WrtLstTrl( '***  E N D  O F  L I S T  ***' );
          EndIf;

        EndSr;

        BegSr  GetRefDtl;

          pQp0l_Ext_Ref_T = pQp0l_Obj_List + Qp0l_Obj_List.DplExtRefTyp;
          pQlg_Path_Name  = pQp0l_Obj_List + Qp0l_Obj_List.DplPthNam;

          CvtString( Qlg_Path_Name.CcsId
                   : 0
                   : Qlg_Path_Name.PthNam
                   : Qlg_Path_Name.PthNamLen
                   : JobCcsId()
                   : 0
                   : 0
                   : %Size( IfsObj )
                   : IfsObj
                   : PthRtnLen
                   : NotSup
                   : FB
                   );

          If  FB(1) > *Zero;
            SndEscMsg( 'CPF9897': 'QCPFMSG': 'Data conversion ended in error.');

          Else;
            CvtString( Qlg_Path_Name.CcsId
                     : 0
                     : Qlg_Path_Name.PthNamDlm
                     : %Size( Qlg_Path_Name.PthNamDlm )
                     : JobCcsId()
                     : 0
                     : 0
                     : %Size( PthDlm )
                     : PthDlm
                     : DlmRtnLen
                     : NotSup
                     : FB
                     );
          EndIf;

          ExSr  WrtLckDtl;

        EndSr;

        BegSr  WrtLckDtl;

          NbrRcds += 1;

          IfsObjV = %TrimR( IfsObj );

          If  %Len( IfsObjV ) > %Size( OutDtl.IfsObj );
            EvalR  OutDtl.IfsObj = IfsObjV;
            %Subst( OutDtl.IfsObj: 1: 2 ) = '< ';

          Else;
            OutDtl.IfsObj = IfsObjV;
          EndIf;

          If  Qp0l_Ext_Ref_T.ChkOut > *Zero;
            OutDtl.ChkUsr = Qp0l_Ext_Ref_T.ChkOutUsrNm;
          Else;
            OutDtl.ChkUsr = '*NONE';
          EndIf;

          OutDtl.SavLck = Qp0l_Ext_Ref_T.SavLck;
          OutDtl.AtrLck = Qp0l_Ext_Ref_T.AtrLck;

          OutDtl.ShrNoRW = Qp0l_Ext_Ref_T.XRonShrNoRW +
                           Qp0l_Ext_Ref_T.RWonShrNoRW +
                           Qp0l_Ext_Ref_T.WtOnShrNoRW +
                           Qp0l_Ext_Ref_T.RdOnShrNoRW;

          OutDtl.ShrRdWr = Qp0l_Ext_Ref_T.XRonShrRdWt +
                           Qp0l_Ext_Ref_T.RWonShrRdWt +
                           Qp0l_Ext_Ref_T.WtOnShrRdWt +
                           Qp0l_Ext_Ref_T.RdOnShrRdWt;

          OutDtl.ShrWtOn = Qp0l_Ext_Ref_T.XRonShrWtOn +
                           Qp0l_Ext_Ref_T.RWonShrWtOn +
                           Qp0l_Ext_Ref_T.WtOnShrWtOn +
                           Qp0l_Ext_Ref_T.RdOnShrWtOn;

          OutDtl.ShrRdOn = Qp0l_Ext_Ref_T.XRonShrRdOn +
                           Qp0l_Ext_Ref_T.RWonShrRdOn +
                           Qp0l_Ext_Ref_T.WtOnShrRdOn +
                           Qp0l_Ext_Ref_T.RdOnShrRdOn;

          OutDtl.Execute = Qp0l_Ext_Ref_T.XRonShrRdOn +
                           Qp0l_Ext_Ref_T.XRonShrWtOn +
                           Qp0l_Ext_Ref_T.XRonShrRdWt +
                           Qp0l_Ext_Ref_T.XRonShrNoRW;

          OutDtl.ReadWrt = Qp0l_Ext_Ref_T.RWonShrRdOn +
                           Qp0l_Ext_Ref_T.RWonShrWtOn +
                           Qp0l_Ext_Ref_T.RWonShrRdWt +
                           Qp0l_Ext_Ref_T.RWonShrNoRW;

          OutDtl.WrtOnly = Qp0l_Ext_Ref_T.WtOnShrRdOn +
                           Qp0l_Ext_Ref_T.WtOnShrWtOn +
                           Qp0l_Ext_Ref_T.WtOnShrRdWt +
                           Qp0l_Ext_Ref_T.WtOnShrNoRW;

          OutDtl.RdOnly  = Qp0l_Ext_Ref_T.RdOnShrRdOn +
                           Qp0l_Ext_Ref_T.RdOnShrWtOn +
                           Qp0l_Ext_Ref_T.RdOnShrRdWt +
                           Qp0l_Ext_Ref_T.RdOnShrNoRW;

          WrtDtlLin();

          If  PxLngPth = 'F'  And  %Len( IfsObjV ) > %Size( OutDtl.IfsObj );

            DoU  %Len( IfsObjV ) = *Zero;
              OutDtl.IfsObjF = IfsObjV;

              WrtDtlLin2();

              If  %Len( IfsObjV ) > %Size( OutDtl.IfsObjF );
                IfsObjV = %Subst( IfsObjV: %Size( OutDtl.IfsObjF ) + 1 );
              Else;
                IfsObjV = NULL;
              EndIf;
            EndDo;
          EndIf;

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           70 'Display job IFS object -
     O                                              locks'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     OQSYSPRT   EF           LstHdr         1
     O                                           18 'Job name . . . . :'
     O                       OutHdr.JobNam       30
     OQSYSPRT   EF           LstHdr         1
     O                                           18 '  User . . . . . :'
     O                       OutHdr.UsrPrf       30
     OQSYSPRT   EF           LstHdr         1
     O                                           18 '  Number . . . . :'
     O                       OutHdr.JobNbr       26
     OQSYSPRT   EF           DtlHdr         1
     O                                          107 '------------- Shared ------
     O                                              --------'
     O                                          120 '-- Locks --'
     OQSYSPRT   EF           DtlHdr         1
     O                                           10 'IFS object'
     O                                           49 'Rd only'
     O                                           58 'Wr only'
     O                                           65 'Rd/wr'
     O                                           71 'Exec'
     O                                           80 'Rd only'
     O                                           89 'Wr only'
     O                                           97 'Rd/wr'
     O                                          107 'No rd/wr'
     O                                          113 'Attr'
     O                                          120 'Save'
     O                                          131 'Check out'
     **-- Write right->left (prevent overlay):
     OQSYSPRT   EF           LckDtl         1
     O                       OutDtl.ChkUsr      132
     O                       OutDtl.SavLck 3    119
     O                       OutDtl.AtrLck 3    112
     O                       OutDtl.ShrNoRW3    104
     O                       OutDtl.ShrRdWr3     95
     O                       OutDtl.ShrWtOn3     87
     O                       OutDtl.ShrRdOn3     78
     O                       OutDtl.Execute3     70
     O                       OutDtl.ReadWrt3     63
     O                       OutDtl.WrtOnly3     56
     O                       OutDtl.RdOnly 3     47
     O                       OutDtl.IfsObj       42
     OQSYSPRT   EF           LckDtl2        1
     O                       OutDtl.IfsObjF     132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34
     **-- Write detail line:  ------------------------------------------------**
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtLstHdr( 3 );

        Except  LckDtl;

      /End-Free

     P WrtDtlLin       E
     **-- Write detail line 2:  ----------------------------------------------**
     P WrtDtlLin2      B
     D                 Pi

      /Free

        WrtLstHdr( 2 );

        Except  LckDtl2;

      /End-Free

     P WrtDtlLin2      E
     **-- Write list header:  ------------------------------------------------**
     P WrtLstHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        If  %Parms = *Zero;
          Except  Header;
          Except  LstHdr;
          Except  DtlHdr;

        Else;
          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;

            Except  Header;
            Except  DtlHdr;
          EndIf;
        EndIf;

      /End-Free

     P WrtLstHdr       E
     **-- Write list trailer:  -----------------------------------------------**
     P WrtLstTrl       B
     D                 Pi
     D  PxTrlTxt                     32a   Const

      /Free

        TrlTxt = PxTrlTxt;

        Except  LstTrl;

      /End-Free

     P WrtLstTrl       E
     **-- Get job type:  -----------------------------------------------------**
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
     **-- Get job ccsid:  ----------------------------------------------------**
     P JobCcsId        B
     D                 Pi            10i 0
     **-- Job info format JOBI0400:
     D JOBI0400        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  JobNam                       10a
     D  UsrNam                       10a
     D  JobNbr                        6a
     D  CcsId                        10i 0 Overlay( JOBI0400: 301 )
     D  CcsIdDft                     10i 0 Overlay( JOBI0400: 373 )

      /Free

        RtvJobInf( JOBI0400
                 : %Size( JOBI0400 )
                 : 'JOBI0400'
                 : '*'
                 : *Blank
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  -1;

        When  JOBI0400.CcsId = 65535;
          Return  JOBI0400.CcsIdDft;

        Other;
          Return  JOBI0400.CcsId;
        EndSl;

      /End-Free

     P JobCcsId        E
     **-- Send escape message:  ----------------------------------------------**
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
     **-- Send completion message:  ------------------------------------------**
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

     P SndCmpMsg       E
     **-- Terminate program:  ------------------------------------------------**
     P TrmPgm          B
     D                 Pi
     D  pPtr                           *

      /Free

        DeAlloc  pPtr;

        *InLr = *On;

        Return;

      /End-Free

     P TrmPgm          E
