     **
     **  Program . . : CBX949
     **  Description : Print registered exit programs - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX949 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX949 )
     **                Module( CBX949 )
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
     D  NbrLin                        5i 0 Overlay( PrtLinInf: 152 )
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

     **-- Global constants:
     D NULL            c                   ''
     D ALL_EXIT_FMT    c                   '*ALL'
     D ALL_EXIT_PGM    c                   -1
     **-- Global variables:
     D Idx             s             10i 0 Inz
     D PgmIdx          s             10i 0 Inz
     D PgmTyp          s             10a   Varying
     D SltAll          s               n   Inz( *Off )
     D ExcIbm          s               n   Inz( *Off )
     D ExcCmd          s               n   Inz( *Off )
     D ExcPgm          s               n   Inz( *Off )
     D ExcFnc          s               n   Inz( *Off )
     D ExcCer          s               n   Inz( *Off )
     D ExcDom          s               n   Inz( *Off )
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  ExtPnt                       20a
     D  FmtNam                        8a
     D  MaxNbEp                      10a
     D  CurNbEp                      10a
     D  AlwDeRg                       4a
     D  AlwChEp                       4a
     D  RegExPg                       4a
     D  ExtPtDs                      50a
     **-- Program record:
     D PgmRcd          Ds                  Qualified
     D  ExtPgNb                      10i 0
     D  ExtPgNm                      10a
     D  ExtPgLb                      10a
     D  ExtPgDt                      20a
     D  PgmOwn                       10a
     D  PgmCrt                       10a
     D  PgmSys                       10a
     D  PgmCrDt                       8a
     D  PgmChDt                       8a
     D  PgmRsDt                       8a

     **-- Exit program selection:
     D ExtPgmSlt       Ds                  Qualified
     D  NbrSltCri                    10i 0
     D  ExtPgmSltEnt                       Dim( 1 )
     D   SizCriEnt                   10i 0 Overlay( ExtPgmSltEnt: 1 )
     D   CmpOpr                      10i 0 Overlay( ExtPgmSltEnt: *Next )
     D   StrPosDta                   10i 0 Overlay( ExtPgmSltEnt: *Next )
     D   LenCmpDta                   10i 0 Overlay( ExtPgmSltEnt: *Next )
     D   CmpDta                     256a   Overlay( ExtPgmSltEnt: *Next )
     **-- Exit point information:
     D EXTI0100        Ds         65535    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  CntHdl                       16a   Inz
     D  OfsLstEnt                    10i 0
     D  NbrLstEnt                    10i 0
     D  LenLstEnt                    10i 0

     D ExtPntEnt       Ds                  Qualified  Based( pExtPntEnt )
     D  ExtPntNam                    20a
     D  ExtPntFmtNam                  8a
     D  MaxNbrExtPgm                 10i 0
     D  CurNbrExtPgm                 10i 0
     D  AlwDeReg                      1a
     D  AlwChgEpCtl                   1a
     D  RegExtPnt                     1a
     D  PpEpNamAdd                   10a
     D  PpEpLibAdd                   10a
     D  PpEpFmtAdd                    8a
     D  PpEpNamRmv                   10a
     D  PpEpLibRmv                   10a
     D  PpEpFmtRmv                    8a
     D  PpEpNamRtv                   10a
     D  PpEpLibRtv                   10a
     D  PpEpFmtRtv                    8a
     D  ExtPntDscInd                  1a
     D  ExtPntDscMsgF                10a
     D  ExtPntDscLib                 10a
     D  ExtPntDscMsId                 7a
     D  ExtPntTxtDsc                 50a

     **-- Exit program information:
     D EXTI0300        Ds         65535    Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  CntHdl                       16a   Inz
     D  OfsLstEnt                    10i 0
     D  NbrLstEnt                    10i 0
     D  LenLstEnt                    10i 0

     D ExtPgmEnt       Ds          1024    Qualified  Based( pExtPgmEnt )
     D  OfsNxtEnt                    10i 0
     D  ExtPntNam                    20a
     D  ExtPntFmtNam                  8a
     D  RegExtPnt                     1a
     D  CmpEnt                        1a
     D                                2a
     D  ExtPgmNbr                    10i 0
     D  ExtPgmNam                    10a
     D  ExtPgmLib                    10a
     D  ExtPgmDscInd                  1a
     D  EpDscMsgF                    10a
     D  EpDscLib                     10a
     D  EpDscMsgId                    7a
     D  EpDscTxt                     50a
     D                                2a
     D  EpDtaCcsId                   10i 0
     D  OfsExtPgmDta                 10i 0
     D  LenExtPgmDta                 10i 0
     D  ThdSafe                       1a
     D  MltThdJobAcn                  1a
     D                                1a
     **
     D ExtPgmDta       s            256a   Varying

     **-- Retrieve exit information:
     D RtvExitInf      Pr                  ExtProc( 'QusRetrieveExit-
     D                                     Information')
     D  CntHdl                       16a
     D  RcvVar                    65535a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ExtPntNam                    20a   Const
     D  ExtPntFmtNam                  8a   Const
     D  ExtPgmNbr                    10i 0 Const
     D  ExtPgmSltCri               1024a          Options( *VarSize )
     D  Error                      1024a          Options( *VarSize )
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
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  NbrNetAtr                    10i 0 Const
     D  NetAtr                       10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a         Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a         Options( *VarSize )
     **-- Retrieve message:
     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  RplSubVal                    10a   Const
     D  RtnFmtChr                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **
     D  RtvOpt                       10a   Const  Options( *NoPass )
     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
     D  RplCcsId                     10i 0 Const  Options( *NoPass )

     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get program type:
     D GetPgmTyp       Pr            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     **-- Get object owner:
     D GetObjOwn       Pr            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Get object creator:
     D GetObjCrt       Pr            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Get object system:
     D GetObjSys       Pr            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Get object creation date:
     D GetObjCrtDat    Pr             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Get object change date:
     D GetObjChgDat    Pr             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Get object restore date:
     D GetObjRstDat    Pr             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **-- Retrieve message text:
     D RtvMsgTxt       Pr          1024a   Varying
     D  MsgId                         7a   Value
     D  MsgF                         10a   Value
     D  MsgFlib                      10a   Value
     D  MsgDta                     1024a   Const  Options( *NoPass )
     **-- Send user message:
     D SndUsrMsg       Pr            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write program line:
     D WrtPgmLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write program header:
     D WrtPgmHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     32a   Const

     **-- Entry parameters:
     D ExcXpg          Ds                  Qualified
     D  NbrVal                        5i 0
     D  ExcVal                       10a   Dim( 5 )
     **
     D CBX949          Pr
     D  PxExtPnt                     20a
     D  PxExcXpg                           LikeDs( ExcXpg )
     **
     D CBX949          Pi
     D  PxExtPnt                     20a
     D  PxExcXpg                           LikeDs( ExcXpg )

      /Free

        ExtPgmSlt.NbrSltCri = *Zero;

        DoU  EXTI0100.CntHdl = *Blanks;

          RtvExitInf( EXTI0100.CntHdl
                    : EXTI0100
                    : %Size( EXTI0100 )
                    : 'EXTI0100'
                    : PxExtPnt
                    : ALL_EXIT_FMT
                    : ALL_EXIT_PGM
                    : ExtPgmSlt
                    : ERRC0100
                    );

          If  ERRC0100.BytAvl = *Zero;

            pExtPntEnt = %Addr( EXTI0100 ) + EXTI0100.OfsLstEnt;

            For  Idx = 1  To  EXTI0100.NbrLstEnt;

              If  ExtPntEnt.CurNbrExtPgm > *Zero;

                ExSr  WrtExtPnt;
                ExSr  GetExtPgm;
              EndIf;

              If  Idx < EXTI0100.NbrLstEnt;
                pExtPntEnt += EXTI0100.LenLstEnt;
              EndIf;
            EndFor;
          EndIf;
        EndDo;

        WrtLstTrl( '***  E N D  O F  L I S T  ***' );

        SndCmpMsg( 'List has been printed.' );

        *InLr = *On;
        Return;


        BegSr  GetExtPgm;

          WrtPgmHdr();

          DoU  EXTI0300.CntHdl = *Blanks;

            RtvExitInf( EXTI0300.CntHdl
                      : EXTI0300
                      : %Size( EXTI0300 )
                      : 'EXTI0300'
                      : ExtPntEnt.ExtPntNam
                      : ExtPntEnt.ExtPntFmtNam
                      : ALL_EXIT_PGM
                      : ExtPgmSlt
                      : ERRC0100
                      );

            If  ERRC0100.BytAvl = *Zero;

              pExtPgmEnt = %Addr( EXTI0300 ) + EXTI0300.OfsLstEnt;

              For  PgmIdx = 1  To  EXTI0300.NbrLstEnt;

                ExSr  GetPgmDta;
                ExSr  WrtPgmInf;

                If  PgmIdx < EXTI0300.NbrLstEnt;
                  pExtPgmEnt = %Addr( EXTI0300 ) + ExtPgmEnt.OfsNxtEnt;
                EndIf;
              EndFor;
            EndIf;
          EndDo;

        EndSr;

        BegSr  GetPgmDta;

          If  ExtPgmEnt.OfsExtPgmDta > *Zero;

            ExtPgmDta = %Subst( EXTI0300
                              : ExtPgmEnt.OfsExtPgmDta + 1
                              : ExtPgmEnt.LenExtPgmDta
                              );
            Else;
            ExtPgmDta = NULL;
          EndIf;

        EndSr;

        BegSr  WrtExtPnt;

          LstRcd.ExtPnt  = ExtPntEnt.ExtPntNam;
          LstRcd.FmtNam  = ExtPntEnt.ExtPntFmtNam;
          LstRcd.CurNbEp = %EditC( ExtPntEnt.CurNbrExtPgm: '3' );

          If   ExtPntEnt.MaxNbrExtPgm = -1;
            EvalR LstRcd.MaxNbEp = '*NOMAX';
          Else;
            LstRcd.MaxNbEp = %EditC( ExtPntEnt.MaxNbrExtPgm: '3' );
          EndIf;

          If  ExtPntEnt.AlwDeReg = '0';
            LstRcd.AlwDeRg = '*NO';
          Else;
            LstRcd.AlwDeRg = '*YES';
          EndIf;

          If  ExtPntEnt.AlwChgEpCtl = '0';
            LstRcd.AlwChEp = '*NO';
          Else;
            LstRcd.AlwChEp = '*YES';
          EndIf;

          If  ExtPntEnt.RegExtPnt = '0';
            LstRcd.RegExPg = '*NO';
          Else;
            LstRcd.RegExPg = '*YES';
          EndIf;

          If  ExtPntEnt.ExtPntDscInd = '1';
            LstRcd.ExtPtDs = ExtPntEnt.ExtPntTxtDsc;
          Else;
            LstRcd.ExtPtDs = RtvMsgTxt( ExtPntEnt.ExtPntDscMsId
                                      : ExtPntEnt.ExtPntDscMsgF
                                      : ExtPntEnt.ExtPntDscLib
                                      );
          EndIf;

          WrtDtlLin();

        EndSr;

        BegSr  WrtPgmInf;

          PgmRcd.ExtPgNb = ExtPgmEnt.ExtPgmNbr;
          PgmRcd.ExtPgNm = ExtPgmEnt.ExtPgmNam;
          PgmRcd.ExtPgLb = ExtPgmEnt.ExtPgmLib;

          If  %Len( ExtPgmDta ) > %Size( PgmRcd.ExtPgDt );
            PgmRcd.ExtPgDt = %Subst( ExtPgmDta
                                   : 1
                                   : %Size( PgmRcd.ExtPgDt ) - 2
                                   ) + ' >';
          Else;
            PgmRcd.ExtPgDt = ExtPgmDta;
          EndIf;

          PgmTyp = GetPgmTyp( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb );

          PgmRcd.PgmOwn  = GetObjOwn( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );
          PgmRcd.PgmCrt  = GetObjCrt( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );
          PgmRcd.PgmSys  = GetObjSys( PgmRcd.ExtPgNm: PgmRcd.ExtPgLb: PgmTyp );

          PgmRcd.PgmCrDt = GetObjCrtDat( PgmRcd.ExtPgNm
                                       : PgmRcd.ExtPgLb
                                       : PgmTyp
                                       );

          PgmRcd.PgmChDt = GetObjChgDat( PgmRcd.ExtPgNm
                                       : PgmRcd.ExtPgLb
                                       : PgmTyp
                                       );

          PgmRcd.PgmRsDt = GetObjRstDat( PgmRcd.ExtPgNm
                                       : PgmRcd.ExtPgLb
                                       : PgmTyp
                                       );

          Select;
          When  SltAll = *On;
            WrtPgmLin();

          When  ExcCmd = *On                             And
                LstRcd.ExtPnt <> 'QIBM_QCA_RTV_COMMAND'  And
                LstRcd.ExtPnt <> 'QIBM_QCA_CHG_COMMAND';
            WrtPgmLin();

          When  ExcPgm = *On             And
                PgmRcd.PgmCrt <> '*IBM'  And
                PgmRcd.PgmCrt <> *Blanks;
            WrtPgmLin();

          When  ExcFnc = *On                              And
              ((LstRcd.ExtPnt  <> 'QIBM_QSY_HOSTFUNC'     And
                LstRcd.ExtPnt  <> 'QIBM_QSY_OPNAVCLIENT'  And
                LstRcd.ExtPnt  <> 'QIBM_QSY_OTHERCLIENT') Or
               (PgmRcd.ExtPgNm <> 'FUNCTION'              And
                PgmRcd.ExtPgLb <> 'REGISTER'));
            WrtPgmLin();

          When  ExcDom = *On                         And
                LstRcd.ExtPnt <> 'QIBM_QCST_ADMDMN'  And
                PgmRcd.PgmCrt <> '*IBM'  And
                PgmRcd.PgmCrt <> *Blanks;
            WrtPgmLin();

          When  ExcIbm = *On                              And
                LstRcd.ExtPnt  <> 'QIBM_QCA_RTV_COMMAND'  And
                LstRcd.ExtPnt  <> 'QIBM_QCA_CHG_COMMAND'  And

                PgmRcd.PgmCrt  <> '*IBM'                  And
                PgmRcd.PgmCrt  <> *Blanks                 And

              ((LstRcd.ExtPnt  <> 'QIBM_QSY_HOSTFUNC'     And
                LstRcd.ExtPnt  <> 'QIBM_QSY_OPNAVCLIENT'  And
                LstRcd.ExtPnt  <> 'QIBM_QSY_OTHERCLIENT') Or
               (PgmRcd.ExtPgNm <> 'FUNCTION'              And
                PgmRcd.ExtPgLb <> 'REGISTER'))            And

                LstRcd.ExtPnt  <> 'QIBM_QCST_ADMDMN'  And
                PgmRcd.PgmCrt  <> '*IBM'  And
                PgmRcd.PgmCrt  <> *Blanks;

            WrtPgmLin();
          EndSl;

        EndSr;

        BegSr  *InzSr;

          LstTim = %Int( %Char( %Time(): *ISO0));
          SysNam = GetSysNam();

          WrtLstHdr();

          Select;
          When  PxExcXpg.ExcVal(1) = '*NONE';
            SltAll = *On;

          When  PxExcXpg.ExcVal(1) = '*IBM';
            ExcIbm = *On;

          When  %LookUp( '*IBMCMD': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
            ExcCmd = *On;

          When  %LookUp( '*IBMPGM': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
            ExcPgm = *On;

          When  %LookUp( '*IBMDOM': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
            ExcDom = *On;

          When  %LookUp( '*IBMFNC': PxExcXpg.ExcVal: PxExcXpg.NbrVal ) > *Zero;
            ExcFnc = *On;
          EndSl;

        EndSr;

      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           36 'System:'
     O                       SysNam              45
     O                                           82 'Registered exit programs'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           Header         1
     O                                           27 'Exit point name . . . . . -
     O                                              :'
     O                       PxExtPnt            42
     **
     OQSYSPRT   EF           LstHdr      1  1
     O                                           10 'Exit point'
     O                                           28 'Format'
     O                                           42 'Nbr.exitpgm'
     O                                           54 'Max.exitpgm'
     O                                           64 'Alw.dereg'
     O                                           73 'Alw.chg.'
     O                                           81 'Regist.'
     O                                           86 'Text'
     **
     OQSYSPRT   EF           PgmHdr      1  1
     O                                           14 'Exit nbr.'
     O                                           23 'Program'
     O                                           35 'Library'
     O                                           57 'Exit program data'
     O                                           67 'Owner'
     O                                           81 'Creator'
     O                                           92 'System'
     O                                          106 'Create date'
     O                                          118 'Change date'
     O                                          131 'Restore date'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.ExtPnt       20
     O                       LstRcd.FmtNam       30
     O                       LstRcd.CurNbEp      41
     O                       LstRcd.MaxNbEp      53
     O                       LstRcd.AlwDeRg      63
     O                       LstRcd.AlwChEp      71
     O                       LstRcd.RegExPg      79
     O                       LstRcd.ExtPtDs     132
     **
     OQSYSPRT   EF           PgmLin         1
     O                       PgmRcd.ExtPgNb3     12
     O                       PgmRcd.ExtPgNm      26
     O                       PgmRcd.ExtPgLb      38
     O                       PgmRcd.ExtPgDt      60
     O                       PgmRcd.PgmOwn       72
     O                       PgmRcd.PgmCrt       84
     O                       PgmRcd.PgmSys       96
     O                       PgmRcd.PgmCrDt     106
     O                       PgmRcd.PgmChDt     118
     O                       PgmRcd.PgmRsDt     130
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34
     **-- Write detail line:  ------------------------------------------------**
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtLstHdr( 6 );

        Except  DtlLin;

      /End-Free

     P WrtDtlLin       E
     **-- Write program line:
     P WrtPgmLin       B
     D                 Pi

      /Free

        WrtPgmHdr( 1 );

        Except  PgmLin;

      /End-Free

     P WrtPgmLin       E
     **-- Write list header:
     P WrtLstHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        Select;
        When  %Parms = *Zero;
          Except  Header;

        When  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
          Except  Header;
          Except  LstHdr;

        Other;
          Except  LstHdr;
        EndSl;

      /End-Free

     P WrtLstHdr       E
     **-- Write program header:
     P WrtPgmHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        If  %Parms = *Zero;

          Except  PgmHdr;
        Else;

          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;

            Except  Header;
            Except  PgmHdr;
          EndIf;
        EndIf;

      /End-Free

     P WrtPgmHdr       E
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
     **-- Get program type:
     P GetPgmTyp       B
     D                 Pi            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjOwn                       10a   Overlay( OBJD0100: 53 )

      /Free

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxObjNam + PxObjLib
               : '*PGM'
               : ERRC0100
               );

        If  ERRC0100.BytAvl = *Zero;

          Return  '*PGM';
        EndIf;

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxObjNam + PxObjLib
               : '*SRVPGM'
               : ERRC0100
               );

        If  ERRC0100.BytAvl = *Zero;

          Return  '*SRVPGM';
        EndIf;

        Return  *Blanks;

      /End-Free

     P GetPgmTyp       E
     **-- Get object owner:
     P GetObjOwn       B
     D                 Pi            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjOwn                       10a   Overlay( OBJD0100: 53 )

      /Free

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  OBJD0100.ObjOwn;
        EndIf;

      /End-Free

     P GetObjOwn       E
     **-- Get object creator:
     P GetObjCrt       B
     D                 Pi            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  OBJD0300.ObjCrt;
        EndIf;

      /End-Free

     P GetObjCrt       E
     **-- Get object system:
     P GetObjSys       B
     D                 Pi            10a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjSys                       10a   Overlay( OBJD0300: 230 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  OBJD0300.ObjSys;
        EndIf;

      /End-Free

     P GetObjSys       E
     **-- Get object creation date:
     P GetObjCrtDat    B
     D                 Pi             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjCrtDts                    13a   Overlay( OBJD0100: 65 )
     D   ObjCrtDat                    7a   Overlay( ObjCrtDts: 1 )
     D   ObjCrtTim                    6a   Overlay( ObjCrtDts: 8 )

      /Free

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        Else;
          Return  %Char( %Date( OBJD0100.ObjCrtDat: *CYMD0 ): *JOBRUN );
        EndIf;

      /End-Free

     P GetObjCrtDat    E
     **-- Get object change date:
     P GetObjChgDat    B
     D                 Pi             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjChgDts                    13a   Overlay( OBJD0100: 78 )
     D   ObjChgDat                    7a   Overlay( ObjChgDts: 1 )
     D   ObjChgTim                    6a   Overlay( ObjChgDts: 8 )

      /Free

        RtvObjD( OBJD0100
               : %Size( OBJD0100 )
               : 'OBJD0100'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        When  OBJD0100.ObjChgDat = *Blanks;
          Return  *Blanks;

        Other;
          Return  %Char( %Date( OBJD0100.ObjChgDat: *CYMD0 ): *JOBRUN );
        EndSl;

      /End-Free

     P GetObjChgDat    E
     **-- Get object restore date:
     P GetObjRstDat    B
     D                 Pi             8a
     D  PxObjNam                     10a   Value
     D  PxObjLib                     10a   Value
     D  PxObjTyp                     10a   Value
     **
     D OBJD0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjRstDts                    13a   Overlay( OBJD0300: 207 )
     D   ObjRstDat                    7a   Overlay( ObjRstDts: 1 )
     D   ObjRstTim                    6a   Overlay( ObjRstDts: 8 )

      /Free

        RtvObjD( OBJD0300
               : %Size( OBJD0300 )
               : 'OBJD0300'
               : PxObjNam + PxObjLib
               : PxObjTyp
               : ERRC0100
               );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Blanks;

        When  OBJD0300.ObjRstDat = *Blanks;
          Return  *Blanks;

        Other;
          Return  %Char( %Date( OBJD0300.ObjRstDat: *CYMD0 ): *JOBRUN );
        EndSl;

      /End-Free

     P GetObjRstDat    E
     **-- Retrieve message text:
     P RtvMsgTxt       B                   Export
     D                 Pi          1024a   Varying
     D  PxMsgId                       7a   Value
     D  PxMsgF                       10a   Value
     D  PxMsgFlib                    10a   Value
     D  PxMsgDta                   1024a   Const  Options( *NoPass )

     **-- Local variables:
     D MsgDta          s           1024a   Varying
     **-- Return structure:
     D RTVM0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RtnMsgLen                    10i 0
     D  RtnMsgAvl                    10i 0
     D  RtnHlpLen                    10i 0
     D  RtnHlpAvl                    10i 0
     D  Msg                        1024a
     **
     D NULL            c                   ''

      /Free

        If  %Parms >= 4;
          MsgDta = %TrimL( PxMsgDta );
        EndIf;

        RtvMsg( RTVM0100
              : %Size( RTVM0100 )
              :'RTVM0100'
              : PxMsgId
              : PxMsgF + PxMsgFlib
              : MsgDta
              : %Len( MsgDta )
              : '*YES'
              : '*NO'
              : ERRC0100
              );

        If  ERRC0100.BytAvl = *Zero;
          Return  %SubSt( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );

        Else;
          Return  NULL;
        EndIf;

      /End-Free

     P RtvMsgTxt       E
     **-- Send user message:
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
