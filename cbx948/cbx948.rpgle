     **
     **  Program . . : CBX948
     **  Description : Analyze user profile usage - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX948 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX948 )
     **                Module( CBX948 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )

     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )

     **-- System information:
     D PgmSts         Sds                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global variables:
     D Idx             s             10i 0 Inz
     D ClsIdx          s             10i 0 Inz
     D PrfIdx          s             10i 0 Inz
     D GenIdx          s             10i 0 Inz
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     D PrfSts          s             10i 0
     D GenPrfPos       s             10i 0
     D InactDays       s             10i 0
     D ObjCrtUsr       s             10a
     D ObjCrtDat       s               d
     D ObjRstDat       s               d
     D ObjLstUsd       s               d
     D PrvSgnOn        s               d
     **
     D UsrCls          Ds                  Qualified
     D  NbrCls                        5i 0
     D  ClsVal                       10a   Dim( 5 )
     **
     D ExcPrf          Ds                  Qualified
     D  NbrPrf                        5i 0
     D  PrfVal                       10a   Dim( 30 )
     **
     D ChkUsrCls       s             10a   Dim( 5 )
     D ChkUsrPrf       s             10a   Dim( 30 )
     D ChkGenPrf       s             10a   Dim( 30 )  Varying
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  UsrPrf                       10a
     D  PrfSts                       10a
     D  PwdExpI                       4a
     D  PwdExpD                       8a
     D  InvSgo                        6s 0
     D  GrpPrf                       10a
     D  PwdI                          4a
     D  UsrCls                       10a
     D  PrvSgoD                       8a
     D  LstUsdD                       8a
     D  PwdChgD                       8a
     D  InactD                        5s 0
     D  NewSts                        9a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  GrpNam                       10a
     D  SltCri                       10a
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
     D USRI0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PrvSgoDts                    13a   Overlay( USRI0300:  19 )
     D   PrvSgoDat                    7a   Overlay( USRI0300:  19 )
     D   PrvSgoTim                    6a   Overlay( USRI0300:  26 )
     D  InvSgo                       10i 0 Overlay( USRI0300:  33 )
     D  PrfSts                       10a   Overlay( USRI0300:  37 )
     D  PwdChgDat                     8a   Overlay( USRI0300:  47 )
     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
     D  PwdExpDat                     8a   Overlay( USRI0300:  61 )
     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
     D  UsrCls                       10a   Overlay( USRI0300:  74 )
     D  SpcAut                       15a   Overlay( USRI0300:  84 )
     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
     D  LmtCap                       10a   Overlay( USRI0300: 189 )

     **-- Open list of authorized users:
     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       80a
     D  NbrRcdRtn                    10i 0 Const
     D  FmtNam                        8a   Const
     D  SltCri                       10a   Const
     D  GrpNam                       10a   Const
     D  Error                      1024a          Options( *VarSize )
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
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  MsgQq                      1000a   Const  Options( *VarSize )
     D  MsgQnbr                      10i 0 Const
     D  MsgQrpy                      20a   Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )
     D  CcsId                        10i 0 Const  Options( *NoPass )
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  InpFmt                       10a   Const
     D  InpVar                       17a   Const  Options( *VarSize )
     D  OutFmt                       10a   Const
     D  OutVar                       17a          Options( *VarSize )
     D  Error                        10i 0 Const
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

     **-- Convert system DTS to date:
     D CvtDtsDat       Pr              d
     D  PxSysDts                      8a   Value
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get creating user profile:
     D GetCrtUsr       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get profile creation date:
     D GetCrtDat       Pr              d
     D  PxUsrPrf                     10a   Value
     **-- Get profile restore date:
     D GetRstDat       Pr              d
     D  PxUsrPrf                     10a   Value
     **-- Get user profile last used date:
     D GetPrfLstUsd    Pr              d
     D  PxUsrPrf                     10a   Value
     **-- Process command:
     D PrcCmd          Pr            10i 0
     D  PxCmdStr                   1024a   Const  Varying
     **-- Send user message:
     D SndUsrMsg       Pr            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying
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
     D  PxTrlTxt                     32a   Const

     **-- Entry parameters:
     D CBX948          Pr
     D  PxInactDays                   3p 0
     D  PxInactChk                   10a
     D  PxAction                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxExcPrf                           LikeDs( ExcPrf )
     D  PxPrfSts                     10a
     D  PxSysPrf                      4a
     **
     D CBX948          Pi
     D  PxInactDays                   3p 0
     D  PxInactChk                   10a
     D  PxAction                     10a
     D  PxUsrCls                           LikeDs( UsrCls )
     D  PxExcPrf                           LikeDs( ExcPrf )
     D  PxPrfSts                     10a
     D  PxSysPrf                      4a

      /Free

        LstApi.RtnRcdNbr = 1;
        LstApi.SltCri = '*ALL';
        LstApi.GrpNam = '*NONE';

        LstAutUsr( AUTU0100
                 : %Size( AUTU0100 )
                 : LstInf
                 : 1
                 : 'AUTU0100'
                 : LstApi.SltCri
                 : LstApi.GrpNam
                 : ERRC0100
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

        WrtLstTrl( '***  E N D  O F  L I S T  ***' );

        SndCmpMsg( 'List has been printed.' );

        *InLr = *On;
        Return;


        BegSr  GetPrfInf;

          RtvUsrInf( USRI0300
                   : %Size( USRI0300 )
                   : 'USRI0300'
                   : AUTU0100.UsrPrf
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;
            ExSr  ChkPrfInf;
          EndIf;

        EndSr;

        BegSr  ChkPrfInf;

          ObjCrtUsr = GetCrtUsr( USRI0300.UsrPrf );
          ObjCrtDat = GetCrtDat( USRI0300.UsrPrf );
          ObjRstDat = GetRstDat( USRI0300.UsrPrf );

          PrfSts = *Zero;

          Select;
          When  PxSysPrf = '*NO'  And  ObjCrtUsr = '*IBM';
            PrfSts = 1;

          When  %Lookup( USRI0300.UsrCls: ChkUsrCls: 1: ClsIdx ) = *Zero;
            PrfSts = 2;

          When  %Lookup( USRI0300.UsrPrf: ChkUsrPrf: 1: PrfIdx ) > *Zero;
            PrfSts = 3;

          When  PxPrfSts <> '*ANY'  And  PxPrfSts <> USRI0300.PrfSts;
            PrfSts = 4;

          Other;
            For  Idx = 1  To  GenIdx;
              If  %Scan( ChkGenPrf(Idx): USRI0300.UsrPrf ) = 1;

                PrfSts = 5;
                Leave;
              EndIf;
            EndFor;
          EndSl;

          If  PrfSts = *Zero;

            ObjLstUsd = GetPrfLstUsd( USRI0300.UsrPrf );

            If  USRI0300.PrvSgoDat = *Blanks;
              PrvSgnOn = *LoVal;
            Else;
              PrvSgnOn = %Date( USRI0300.PrvSgoDat: *CYMD0 );
            EndIf;

            Select;
            When  PxInActChk = '*LASTUSED'  And  ObjLstUsd > *LoVal;
              InactDays = %Diff( %Date(): ObjLstUsd: *Days );

            When  PxInActChk = '*PRVSIGNON'  And  PrvSgnOn > *LoVal;
              InactDays = %Diff( %Date(): PrvSgnOn: *Days );

            When  ObjRstDat > *LoVal;
              InactDays = %Diff( %Date(): ObjRstDat: *Days );

            Other;
              InactDays = %Diff( %Date(): ObjCrtDat: *Days );
            EndSl;

            If  PxInactDays <= InactDays;

              LstRcd.NewSts = '*SAME';

              If  ObjCrtUsr <> '*IBM';

                If  PxAction = '*DISABLE'  And  USRI0300.PrfSts = '*ENABLED';

                  If  PrcCmd( 'CHGUSRPRF USRPRF('          +
                               %Trim( USRI0300.UsrPrf )    +
                              ') STATUS(*DISABLED)'
                            ) = -1;

                    LstRcd.NewSts = '*NOCHG';
                  Else;
                    LstRcd.NewSts = '*DISABLED';

                    SndUsrMsg( PgmSts.UsrPrf
                             : 'User profile '              +
                                %Trim( USRI0300.UsrPrf )    +
                               ' disabled by command ANZPRFUSG.'
                             );
                  EndIf;
                EndIf;
              EndIf;

              ExSr WrtPrfInf;
            EndIf;
          EndIf;

        EndSr;

        BegSr  WrtPrfInf;

          If  InactDays > 99999;
          LstRcd.InactD = 99999;
          Else;
          LstRcd.InactD = InactDays;
          EndIf;

          LstRcd.UsrPrf = USRI0300.UsrPrf;
          LstRcd.PrfSts = USRI0300.PrfSts;
          LstRcd.InvSgo = USRI0300.InvSgo;
          LstRcd.GrpPrf = USRI0300.GrpPrf;
          LstRcd.UsrCls = USRI0300.UsrCls;

          If  USRI0300.PwdExpDat = *Blanks;
            LstRcd.PwdExpD = '*NONE';
          Else;
            LstRcd.PwdExpD = %Char( CvtDtsDat( USRI0300.PwdExpDat ): *JOBRUN );
          EndIf;

          If  ObjLstUsd = *LoVal;
            LstRcd.LstUsdD = '*NONE';
          Else;
            LstRcd.LstUsdD = %Char( ObjLstUsd: *JOBRUN );
          EndIf;

          If  USRI0300.PwdChgDat = *Blanks;
            LstRcd.PwdChgD = '*NONE';
          Else;
            LstRcd.PwdChgD = %Char( CvtDtsDat( USRI0300.PwdChgDat ): *JOBRUN );
          EndIf;

          If  USRI0300.PrvSgoDts = *Blanks;
            LstRcd.PrvSgoD = '*NONE';
          Else;
            LstRcd.PrvSgoD = %Char( %Date( USRI0300.PrvSgoDat: *CYMD0 )
                                  : *JOBRUN
                                  );
          EndIf;

          If  USRI0300.PwdExpI = 'Y';
            LstRcd.PwdExpI = '*YES';
          Else;
            LstRcd.PwdExpI = '*NO';
          EndIf;

          If  USRI0300.NoPwdI = 'Y';
            LstRcd.PwdI = '*NO';
          Else;
            LstRcd.PwdI = '*YES';
          EndIf;

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

          For  Idx = 1  To  PxExcPrf.NbrPrf;

            GenPrfPos = %Scan( '*': PxExcPrf.PrfVal(Idx): 2 );

            Select;
            When  PxExcPrf.PrfVal(Idx) = '*NONE';

            When  GenPrfPos > *Zero;
              GenIdx += 1;
              ChkGenPrf(GenIdx) = %Subst( PxExcPrf.Prfval(Idx): 1: GenPrfPos-1);

            Other;
              PrfIdx += 1;
              ChkUsrPrf(PrfIdx) = PxExcPrf.PrfVal(Idx);

            EndSl;
          EndFor;

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
     O                                           80 'User profile usage'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           27 'Inactivity days . . . . . -
     O                                              :'
     O                       PxInactDays   3     32
     **
     OQSYSPRT   EF           LstHdr         2
     O                                           27 'Check attribute . . . . . -
     O                                              :'
     O                       PxInactChk          39
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            4 'User'
     O                                           17 'Class'
     O                                           28 'Group'
     O                                           43 'Inv.sign.'
     O                                           52 'Password'
     O                                           62 'Pwd.exp.'
     O                                           71 'Pwd.chg.'
     O                                           81 'Exp.date'
     O                                           90 'Sign-on'
     O                                          101 'Last used'
     O                                          110 'Inact.'
     O                                          118 'Status'
     O                                          131 'New sts.'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.UsrPrf       10
     O                       LstRcd.UsrCls       22
     O                       LstRcd.GrpPrf       33
     O                       LstRcd.InvSgo Z     41
     O                       LstRcd.PwdI         50
     O                       LstRcd.PwdExpI      60
     O                       LstRcd.PwdChgD      71
     O                       LstRcd.PwdExpD      81
     O                       LstRcd.PrvSgoD      91
     O                       LstRcd.LstUsdD     101
     O                       LstRcd.InactD 3    109
     O                       LstRcd.PrfSts      122
     O                       LstRcd.NewSts      132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34
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
     **-- Get creating user profile:  ----------------------------------------**
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
     **-- Get profile creation date:  ----------------------------------------**
     P GetCrtDat       B
     D                 Pi              d
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  CrtDts                       13a   Overlay( OBJD0100: 65 )
     D   CrtDat                       7a   Overlay( CrtDts: 1 )
     D   CrtTim                       6a   Overlay( CrtDts: 8 )

      /Free

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxUsrPrf + 'QSYS'
               : '*USRPRF'
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *LoVal;

        Else;
          Return  %Date( OBJD0100.CrtDat: *CYMD0 );
        EndIf;

      /End-Free

     P GetCrtDat       E
     **-- Get profile restore date:  -----------------------------------------**
     P GetRstDat       B
     D                 Pi              d
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RstDts                       13a   Overlay( OBJD0300: 207 )
     D   RstDat                       7a   Overlay( RstDts: 1 )
     D   RstTim                       6a   Overlay( RstDts: 8 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxUsrPrf + 'QSYS'
               : '*USRPRF'
               : ERRC0100
               );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *LoVal;

        When  OBJD0300.RstDat = *Blanks;
          Return  *LoVal;

        Other;
          Return  %Date( OBJD0300.RstDat: *CYMD0 );
        EndSl;

      /End-Free

     P GetRstDat       E
     **-- Get user profile last used date:  ----------------------------------**
     P GetPrfLstUsd    B
     D                 Pi              d
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0400        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjLstUsd                     7a   Overlay( OBJD0400: 461 )

      /Free

        RtvObjD( OBJD0400
               : %Size( OBJD0400 )
               : 'OBJD0400'
               : PxUsrPrf + 'QSYS'
               : '*USRPRF'
               : ERRC0100
               );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *LoVal;

        When  OBJD0400.ObjLstUsd = *Blanks;
          Return  *LoVal;

        Other;
          Return  %Date( OBJD0400.ObjLstUsd: *CYMD0 );
        EndSl;

      /End-Free

     P GetPrfLstUsd    E
     **-- Process command:  --------------------------------------------------**
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
     **-- Send user message:  ------------------------------------------------**
     P SndUsrMsg       B                   Export
     D                 Pi            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndMsg( 'CPF9897'
              : 'QCPFMSG   *LIBL'
              : PxMsgDta
              : %Len( PxMsgDta )
              : '*INFO'
              : PxUsrPrf + '*LIBL'
              : 1
              : *Blanks
              : MsgKey
              : ERRC0100
              );

        If  ERRC0100.BytAvl > *Zero;
          Return -1;

        Else;
          Return  0;
        EndIf;

      /End-Free

     **
     P SndUsrMsg       E
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
