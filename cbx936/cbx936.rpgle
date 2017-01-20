     **
     **  Program . . : CBX936
     **  Description : Analyze user profiles - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX936 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX936 )
     **                Module( CBX936 )
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
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global variables:
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  UsrPrf                       10a
     D  PrfSts                       10a
     D  PwdExpI                       4a
     D  PwdExpD                       8a
     D  InvSgo                        3i 0
     D  GrpPrf                       10a
     D  PwdI                          4a
     D  LmtCap                        4a
     D  SpcAut                        4a
     D  UsrCls                       10a
     D  PrvSgoD                       8a
     D  PwdChgD                       8a
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
     D  LuRcvVar                  65535a          Options( *VarSize )
     D  LuRcvVarLen                  10i 0 Const
     D  LuLstInf                     80a
     D  LuNbrRcdRtn                  10i 0 Const
     D  LuFmtNam                      8a   Const
     D  LuSltCri                     10a   Const
     D  LuGrpNam                     10a   Const
     D  LuError                    1024a          Options( *VarSize )
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
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RoRcvVar                  32767a         Options( *VarSize )
     D  RoRcvVarLen                  10i 0 Const
     D  RoFmtNam                      8a   Const
     D  RoObjNamQ                    20a   Const
     D  RoObjTyp                     10a   Const
     D  RoError                   32767a         Options( *VarSize )

     **-- Convert system DTS to date:
     D CvtDtsDat       Pr              d
     D  PxSysDts                      8a   Value
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get user creator:
     D GetUsrCrt       Pr            10a
     D  PxUsrPrf                     10a   Value
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
     D CBX936          Pr
     D  PxOption                     10a
     D  PxSysPrf                      4a
     **
     D CBX936          Pi
     D  PxOption                     10a
     D  PxSysPrf                      4a

      /Free

        LstApi.RtnRcdNbr = 1;

        If  PxOption = '*NOGROUP';
          LstApi.SltCri = '*MEMBER';
          LstApi.GrpNam = '*NOGROUP';
        Else;
          LstApi.SltCri = '*ALL';
          LstApi.GrpNam = '*NONE';
        EndIf;

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

          If  PxSysPrf = '*YES'  Or  GetUsrCrt( USRI0300.UsrPrf ) <> '*IBM';

            Select;
            When  PxOption = '*DISABLED'  And  USRI0300.PrfSts = '*DISABLED';
              ExSr WrtPrfInf;

            When  PxOption = '*EXPIRED'  And  USRI0300.PwdExpI = 'Y';
              ExSr WrtPrfInf;

            When  PxOption = '*EXPIRED'  And  USRI0300.PwdExpDat = *Blanks;
              // No expiration date - skip user profile.

            When  PxOption = '*EXPIRED'  And
                  CvtDtsDat( USRI0300.PwdExpDat ) <= %Date();
              ExSr WrtPrfInf;

            When  PxOption = '*INVSIGNON'  And  USRI0300.InvSgo > *Zero;
              ExSr WrtPrfInf;

            When  PxOption = '*NOGROUP'  And  USRI0300.GrpPrf = '*NONE';
              ExSr WrtPrfInf;

            When  PxOption = '*NOPWD'  And  USRI0300.NoPwdI = 'Y';
              ExSr WrtPrfInf;

            When  PxOption = '*NOTLMTCAP'  And  USRI0300.LmtCap <> '*YES';
              ExSr WrtPrfInf;
            EndSl;
          EndIf;

        EndSr;

        BegSr  WrtPrfInf;

          LstRcd.UsrPrf = USRI0300.UsrPrf;
          LstRcd.PrfSts = USRI0300.PrfSts;
          LstRcd.InvSgo = USRI0300.InvSgo;
          LstRcd.GrpPrf = USRI0300.GrpPrf;
          LstRcd.LmtCap = USRI0300.LmtCap;
          LstRcd.UsrCls = USRI0300.UsrCls;

          If  USRI0300.PwdExpDat = *Blanks;
            LstRcd.PwdExpD = '*NONE';
          Else;
            LstRcd.PwdExpD = %Char( CvtDtsDat( USRI0300.PwdExpDat ): *JOBRUN );
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

          If  USRI0300.SpcAut = 'NNNNNNNN';
            LstRcd.SpcAut = '*NO';
          Else;
            LstRcd.SpcAut = '*YES';
          EndIf;

          WrtDtlLin();

        EndSr;

        BegSr  *InzSr;

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
     O                                           82 'User profile exceptions'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                            4 'User'
     O                                           17 'Class'
     O                                           29 'Group'
     O                                           42 'Status'
     O                                           53 'Limit'
     O                                           65 'Spc.aut.'
     O                                           75 'Inv.sign.'
     O                                           84 'Password'
     O                                           94 'Pwd.exp.'
     O                                          104 'Exp.date'
     O                                          114 'Sign-on'
     O                                          129 'Pwd. changed'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.UsrPrf       10
     O                       LstRcd.UsrCls       22
     O                       LstRcd.GrpPrf       34
     O                       LstRcd.PrfSts       46
     O                       LstRcd.LmtCap       52
     O                       LstRcd.SpcAut       62
     O                       LstRcd.InvSgo Z     70
     O                       LstRcd.PwdI         81
     O                       LstRcd.PwdExpI      92
     O                       LstRcd.PwdExpD     104
     O                       LstRcd.PrvSgoD     115
     O                       LstRcd.PwdChgD     126
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
     **-- Get user creator:  -------------------------------------------------**
     P GetUsrCrt       B                   Export
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

     P GetUsrCrt       E
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

     **
     P SndCmpMsg       E
