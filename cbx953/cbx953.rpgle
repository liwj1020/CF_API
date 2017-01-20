     **
     **  Program . . : CBX953
     **  Description : Add Group Profile - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : Club Tech iSeries System Management Tips Newsletter
     **
     **
     **  Program description:
     **    This program adds a specified group profile to all user profiles
     **    that meet the specified selection criteria.
     **
     **    The group profile is added as the primary group if the user
     **    profile does not already have one. Otherwise the group profile is
     **    added as a supplemental group, provided that not all supplemental
     **    group have already been specified.
     **
     **    A completion status report is written to a spooled file and
     **    placed in the current job's default output queue.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX953 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX953 )
     **              Module( CBX953 )
     **              ActGrp( CBX953 )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )

     **-- File specifications:
     FUSRFILE   IF   F   10        Disk    InfDs( FilInf )  UsrOpn
     F                                     ExtFile( FilNam )
     FQSYSPRT   O    F  132        Printer InfDs( PrtLinInf )  OflInd( *InOf )

     **-- Data file information:
     D FilInf          Ds                  Qualified
     D  FilNam                       10a   Overlay( FilInf:  83 )
     D  RcdLen                        5i 0 Overlay( FilInf: 125 )
     D  MbrNam                       10a   Overlay( FilInf: 129 )
     D  NbrRcd                       10i 0 Overlay( FilInf: 156 )
     D  Rrn                          10i 0 Overlay( FilInf: 397 )
     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
     **-- System information:
     D PgmSts         Sds                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Input record:
     D InpRcd          Ds                  Qualified
     D  UsrPrf                       10a
     **-- Global constants:
     D NULL            c                   ''
     D PRF_USR         c                   '0'
     D PRF_GRP         c                   '1'
     **-- Global variables:
     D FilNam          s             21a
     D PrfSts          s             10i 0
     D GrpSts          s             10i 0
     D CmdSts          s             10i 0
     D PrfPrc          s             10i 0
     D PrfChg1         s             10i 0
     D PrfChg2         s             10i 0
     D Idx             s             10i 0 Inz
     D ClsIdx          s             10i 0 Inz
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             64a
     D CrtOwn          s             10a
     D SupGrps         s            165a   Varying
     D ChkUsrCls       s             10a   Dim( 5 )
     **
     D UsrCls          Ds                  Qualified
     D  NbrCls                        5i 0
     D  ClsVal                       10a   Dim( 5 )
     **
     D File_q          Ds                  Qualified
     D  File                         10a
     D  LibNam                       10a
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  UsrPrf                       10a
     D  UsrCls                       10a
     D  GrpPrf                       10a
     D  PrfSts                       10a
     D  NbrSpGp                       2s 0
     D  ChgSts                       75a

     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  GrpPrf                       10a
     D  SltCri                       10a
     D  UsrPrf                       10a
     **-- Retrieve API parameters:
     D RtvApi          Ds                  Qualified  Inz
     D  UsrPrf                       10a
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
     **-- User information:
     D AUTU0100        Ds                  Qualified
     D  UsrPrf                       10a
     D  UsrGrpI                       1a
     D  GrpMbrI                       1a
     **-- User information:
     D USRI0300        Ds          4096    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PrfSts                       10a   Overlay( USRI0300:  37 )
     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
     D  UsrCls                       10a   Overlay( USRI0300:  74 )
     D  SpcAut                       15a   Overlay( USRI0300:  84 )
     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
     D  LmtCap                       10a   Overlay( USRI0300: 189 )
     D  OfsSupGrp                    10i 0 Overlay( USRI0300: 585 )
     D  NbrSupGrp                    10i 0 Overlay( USRI0300: 589 )
     D  GID                          10i 0 Overlay( USRI0300: 597 )
     **
     D SupGrp          s             10a   Dim( 15 )  Based( pSupGrp )

     **-- Open list of authorized users:
     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  FmtNam                        8a   Const
     D  SltCri                       10a   Const
     D  GrpPrf                       10a   Const
     D  Error                      1024a          Options( *VarSize )
     D  UsrPrf                       10a   Const  Options( *NoPass )
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
     **-- Process commands:
     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
     D  SrcCmd                    32702a   Const  Options( *VarSize )
     D  SrcCmdLen                    10i 0 Const
     D  OptCtlBlk                    20a   Const
     D  OptCtlBlkLn                  10i 0 Const
     D  OptCtlBlkFm                   8a   Const
     D  ChgCmd                    32767a          Options( *VarSize )
     D  ChgCmdLen                    10i 0 Const
     D  ChgCmdLenAvl                 10i 0
     D  Error                     32767a          Options( *VarSize )
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
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a         Options( *VarSize )

     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get creating user profile:
     D GetCrtUsr       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Process command:
     D PrcCmd          Pr            10i 0
     D  PxCmdStr                   1024a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     64a   Const

     **-- Entry parameters:
     D CBX953          Pr
     D  PxUsrPrf                     10a
     D  PxNewGrpPrf                  10a
     D  PxGrpOwn                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxGrpPrf                     10a
     D  PxRplPriGrp                   4a
     D  PxPrfOpt                      7a
     D  PxFile_q                           LikeDs( File_q )
     **
     D CBX953          Pi
     D  PxUsrPrf                     10a
     D  PxNewGrpPrf                  10a
     D  PxGrpOwn                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxGrpPrf                     10a
     D  PxRplPriGrp                   4a
     D  PxPrfOpt                      7a
     D  PxFile_q                           LikeDs( File_q )

      /Free

        If  PxUsrPrf = '*FILE';
          ExSr  GetFile;
        Else;
          ExSr  LstUser;
        EndIf;

        *InLr = *On;
        Return;

        BegSr  GetFile;

          FilNam = %TrimR( PxFile_q.LibNam ) + '/' + PxFile_q.File;

          Open  USRFILE;
          SetLl  *Start  USRFILE;

          Read  USRFILE  InpRcd;
          DoW  Not %EoF;

            ExSr  GetPrfInf;

            Read  USRFILE  InpRcd;
          EndDo;

          Close USRFILE;

        EndSr;

        BegSr  LstUser;

          LstApi.RtnRcdNbr = 1;
          LstApi.SltCri = '*ALL';
          LstApi.GrpPrf = '*NONE';
          LstApi.UsrPrf = PxUsrPrf;

          LstAutUsr( AUTU0100
                   : %Size( AUTU0100 )
                   : LstInf
                   : 1
                   : 'AUTU0100'
                   : LstApi.SltCri
                   : LstApi.GrpPrf
                   : ERRC0100
                   : LstApi.UsrPrf
                   );

          If  ERRC0100.BytAvl = *Zero;

            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

              ExSr  GetPrfInf;

              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

              GetLstEnt( AUTU0100
                       : %Size( AUTU0100 )
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

          If  PrfPrc = *Zero;
            WrtLstTrl( '(No user profiles met selection criteria)' );
          EndIf;

          WrtLstTrl( *Blanks );
          WrtLstTrl( 'Profiles processed . . . . . . :  ' + %Char( PrfPrc ));
          WrtLstTrl( 'Primary groups added . . . . . :  ' + %Char( PrfChg1 ));
          WrtLstTrl( 'Supplemental groups added  . . :  ' + %Char( PrfChg2 ));
          WrtLstTrl( *Blanks );
          WrtLstTrl( '***  E N D  O F  L I S T  ***' );

          SndCmpMsg( 'Completion status report has been printed.' );

        EndSr;

        BegSr  GetPrfInf;

          If  PxUsrPrf = '*FILE';
            RtvApi.UsrPrf = InpRcd.UsrPrf;
          Else;
            RtvApi.UsrPrf = AUTU0100.UsrPrf;
          EndIf;

          RtvUsrInf( USRI0300
                   : %Size( USRI0300 )
                   : 'USRI0300'
                   : RtvApi.UsrPrf
                   : ERRC0100
                   );

          Select;
          When  ERRC0100.BytAvl > *Zero;
            Clear  USRI0300;
            USRI0300.UsrPrf = RtvApi.UsrPrf;

            ExSr  ChkPrfInf;

          When  %Lookup( USRI0300.UsrCls: ChkUsrCls: 1: ClsIdx ) > *Zero;

            If  PxGrpPrf = '*ANY'  Or  PxGrpPrf = USRI0300.GrpPrf;
              ExSr  ChkPrfInf;
            EndIf;
          EndSl;

        EndSr;

        BegSr  ChkPrfInf;

          PrfPrc += 1;
          pSupGrp = %Addr( USRI0300 ) + USRI0300.OfsSupGrp;

          Select;
          When  ERRC0100.BytAvl > *Zero;
            PrfSts = -1;

          When  USRI0300.GID > *Zero;
            PrfSts = -2;

          When  GetCrtUsr( USRI0300.UsrPrf ) = '*IBM';
            PrfSts = -3;

          When  %Subst( USRI0300.UsrPrf: 1: 1 ) = 'Q';
            PrfSts = -3;

          When  USRI0300.GrpPrf <> '*NONE'  And  USRI0300.NbrSupGrp >= 15;
            PrfSts = -4;

          When  USRI0300.GrpPrf = PxNewGrpPrf;
            PrfSts = -5;

          When  %Lookup( PxNewGrpPrf: SupGrp: 1: USRI0300.NbrSupGrp ) > 1;
            PrfSts = -6;

          Other;
            PrfSts = *Zero;
          EndSl;

          If  PrfSts = *Zero;
            ExSr  AddGrpPrf;
          EndIf;

          ExSr WrtPrfInf;

        EndSr;

        BegSr  AddGrpPrf;

          Select;
          When  USRI0300.GrpPrf = '*NONE'  Or  PxRplPriGrp = '*YES';
            GrpSts = 1;
            PrfChg1 += 1;

            ExSr  UpdPriGrp;

          When  PxRplPriGrp = '*SUPGRP';
            GrpSts = 3;
            PrfChg3 += 1;

            ExSr  UpdPriGrp;
            ExSr  UpdSupGrp;

          Other;
            GrpSts = 2;
            PrfChg2 += 1;

            ExSr  UpdSupGrp;
          EndSl;

          Select;
          When  CmdSts < *Zero;
            PrfSts = -11;

          When  GrpSts = 1  And  PxPrfOpt = '*UPDATE';
            SndCmpMsg( 'Group profile '               +
                       %Trim( PxNewGrpPrf )           +
                       ' added to user profile '      +
                       %Trim( USRI0300.UsrPrf )       +
                       '.'
                     );

          When  GrpSts = 2  And  PxPrfOpt = '*UPDATE';
            SndCmpMsg( 'Supplemental group profile '  +
                       %Trim( PxNewGrpPrf )           +
                       ' added to user profile '      +
                       %Trim( USRI0300.UsrPrf )       +
                       '.'
                     );

          When  GrpSts = 3  And  PxPrfOpt = '*UPDATE';
            SndCmpMsg( 'Supplemental group profile '  +
                       %Trim( PxNewGrpPrf )           +
                       ' added to user profile '      +
                       %Trim( USRI0300.UsrPrf )       +
                       '.'
                     );
          EndSl;

        EndSr;

        BegSr  UpdPriGrp;

          If  PxPrfOpt = '*UPDATE';
            CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
                              %Trim( USRI0300.UsrPrf )    +
                              ') GRPPRF('                 +
                              %Trim( PxNewGrpPrf )        +
                              ') OWNER('                  +
                              %Trim( CrtOwn )             +
                              ')'
                            );
          EndIf;

        EndSr;

        BegSr  UpdSupGrp;

          If  PxPrfOpt = '*UPDATE';
            SupGrps = NULL;

            For  Idx = 1  to  USRI0300.NbrSupGrp;
              SupGrps += %TrimR( SupGrp(Idx)) + ' ';
            EndFor;

            SupGrps += PxNewGrpPrf;

            CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
                              %Trim( USRI0300.UsrPrf )    +
                              ') SUPGRPPRF('              +
                              SupGrps                     +
                              ') OWNER('                  +
                              %Trim( CrtOwn )             +
                              ')'
                            );
          EndIf;

        EndSr;

        BegSr  WrtPrfInf;

          LstRcd.UsrPrf  = USRI0300.UsrPrf;
          LstRcd.UsrCls  = USRI0300.UsrCls;
          LstRcd.GrpPrf  = USRI0300.GrpPrf;
          LstRcd.NbrSpGp = USRI0300.NbrSupGrp;
          LstRcd.PrfSts  = USRI0300.PrfSts;

          Select;
          When  PrfSts = -1;
            LstRcd.ChgSts = 'Error occurred when retrieving user profile data.';

          When  PrfSts = -2;
            LstRcd.ChgSts = 'User profile is a group profile.';

          When  PrfSts = -3;
            LstRcd.ChgSts = 'System user profile cannot be changed.';

          When  PrfSts = -4;
            LstRcd.ChgSts = 'Group profile overflow.  Group profile not added.';

          When  PrfSts = -5;
            LstRcd.ChgSts = 'Group profile already assigned.';

          When  PrfSts = -6;
            LstRcd.ChgSts = 'Supplemental group profile already assigned.';

          When  PrfSts = -11;
            LstRcd.ChgSts = 'Change user profile command failed.';

          When  GrpSts = 1;
            LstRcd.ChgSts = 'Group profile added as primary group.';

          When  GrpSts = 2;
            LstRcd.ChgSts = 'Group profile added as supplemental group.';
          EndSl;

          WrtDtlLin();

        EndSr;

        BegSr  *InzSr;

          For  Idx = 1  to PxUsrCls.NbrCls;

            Select;
            When  PxUsrCls.ClsVal(Idx) = '*ALL';
              ChkUsrCls(1) = '*USER';
              ChkUsrCls(2) = '*PGMR';
              ChkUsrCls(3) = '*SYSOPR';
              ChkUsrCls(4) = '*SECADM';
              ChkUsrCls(5) = '*SECOFR';
              ClsIdx = 5;

            When  PxUsrCls.ClsVal(Idx) = '*NONUSER';
              ChkUsrCls(1) = '*PGMR';
              ChkUsrCls(2) = '*SYSOPR';
              ChkUsrCls(3) = '*SECADM';
              ChkUsrCls(4) = '*SECOFR';
              ClsIdx = 4;

            Other;
              ChkUsrCls(Idx) = PxUsrCls.ClsVal(Idx);
              ClsIdx += 1;
            EndSl;
          EndFor;

          Select;
          When  PxGrpOwn = '*SAME';
            CrtOwn = '*SAME';

          When  PxGrpOwn = '*YES';
            CrtOwn = '*GRPPRF';

          When  PxGrpOwn = '*NO';
            CrtOwn = '*USRPRF';
          EndSl;

          LstTim = %Int( %Char( %Time(): *ISO0));
          SysNam = GetSysNam();

          WrtLstHdr();

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           36 'System:'
     O                       SysNam              45
     O                                           88 'Add group profile comple-
     O                                              tion report'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           27 'User profile  . . . . . . -
     O                                              :'
     O                       PxUsrPrf            39
     O                       PxFile_q.File       50
     O                                           80 'User classes to select  . -
     O                                              :'
     O                       ChkUsrCls          132
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           27 'Group profile to add  . . -
     O                                              :'
     O                       PxNewGrpPrf         39
     O                                           80 'Group profile to select . -
     O                                              :'
     O                       PxGrpPrf            92
     OQSYSPRT   EF           LstHdr         2
     O                                           27 'Replace group profile . . -
     O                                              :'
     O                       PxRplPriGrp         33
     O                                           80 'User profile option . . . -
     O                                              :'
     O                       PxPrfOpt            89
     O                                          120 'Group ownership . . . . . -
     O                                              :'
     O                       PxGrpOwn           132
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            4 'User'
     O                                           17 'Class'
     O                                           28 'Group'
     O                                           43 'Sup.grp.'
     O                                           51 'Status'
     O                                           70 'Change status'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.UsrPrf       10
     O                       LstRcd.UsrCls       22
     O                       LstRcd.GrpPrf       33
     O                       LstRcd.NbrSpGp3     41
     O                       LstRcd.PrfSts       55
     O                       LstRcd.ChgSts      132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              66
     **-- Write detail line:  ------------------------------------------------**
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
     **-- Write list trailer:
     P WrtLstTrl       B
     D                 Pi
     D  PxTrlTxt                     64a   Const

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
     **-- Get creating user profile:
     P GetCrtUsr       B
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxUsrPrf + 'QSYS'
               : '*USRPRF'
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  OBJD0300.ObjCrt;
        EndIf;

      /End-Free

     P GetCrtUsr       E
     **-- Process command:
     P PrcCmd          B                   Export
     D                 Pi            10i 0
     D  PxCmdStr                   1024a   Const  Varying

     **-- Local variables:
     D CPOP0100        Ds                  Qualified
     D  TypPrc                       10i 0 Inz( 2 )
     D  DBCS                          1a   Inz( '0' )
     D  PmtAct                        1a   Inz( '2' )
     D  CmdStx                        1a   Inz( '0' )
     D  MsgRtvKey                     4a   Inz( *Allx'00' )
     D  Rsv                           9a   Inz( *Allx'00' )
     **
     D ChgCmd          s          32767a
     D ChgCmdAvl       s             10i 0

      /Free

        PrcCmds( PxCmdStr
               : %Len( PxCmdStr )
               : CPOP0100
               : %Size( CPOP0100 )
               : 'CPOP0100'
               : ChgCmd
               : %Size( ChgCmd )
               : ChgCmdAvl
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;
        EndIf;

      /End-Free

     P PrcCmd          E
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

     P SndCmpMsg       E
