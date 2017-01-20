     **
     **  Program . . : CBX947
     **  Description : Check PTF status - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX947 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX947 )
     **                Module( CBX947 )
     **                BndSrvPgm( QPZLSTFX )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )

     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- system function error ID:
     D SysError        s              7a   Import( '_EXCP_MSGID' )

     **-- Global constants:
     D USRSPC_Q        c                   'LSTPTFS   QTEMP'
     D LST_RCDS        c                   1024
     D PRD_BASE        c                   '0000'
     **-- Global variables:
     D IdxPrd          s             10u 0
     D IdxPtf          s             10u 0
     D PtfStsTxt       s             32a   Varying
     D ChkSavF         s             10a   Inz
     D ChkOnOrd        s             10a   Inz
     D ChkCvrOnl       s             10a   Inz
     D ChkNotApy       s             10a   Inz
     D ChkActRqd       s             10a   Inz
     **
     D PtfSts          Ds                  Qualified
     D  NbrSts                        5i 0
     D  StsVal                       10a   Dim( 5 )

     **-- API header information:
     D HdrInf          Ds                  Qualified  Based( pHdrInf )
     D  UsrSpcNamSp                  10a
     D  UsrSpcLibSp                  10a
     D  CurIplSrc                     1a
     D  CurSvrIplSrc                  1a
     D  HpvSts                        1a
     **-- User space generic header:
     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
     **-- User space pointers:
     D pUsrSpc         s               *   Inz( *Null )
     D pHdrInf         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )

     **-- Product information:
     D PRDS0200        Ds                  Qualified  Based( pPRDS0200 )
     D  PrdId                         7a
     D  PrdOpt                        5a
     D  RlsLvl                        6a
     D                                2a
     D  DscMsgId                      7a
     D  DscObjNam                    10a
     D  DscObjLib                    10a
     D  InsFlg                        1a
     D  SptFlg                        1a
     D  RegTyp                        2a
     D  RegVal                       14a
     D  DscTxt                      132a
     **-- Input information:
     D InpInf          Ds                  Qualified
     D  NbrRcdRtn                    10i 0 Inz( LST_RCDS )
     D  NbrPrdSlt                    10a   Inz( '*ALL' )
     D  InzPnlView                    1a   Inz( '2' )
     D  AlwExit                       1a   Inz( '1' )
     D  PrdOptDsp                    10a   Inz( '*BASE' )
     D  PrdOpt                       10a   Inz( '*INSTLD' )
     D  LstRcd                       10i 0 Inz( 0 )
     **-- Input list:
     D InpLst          Ds                  Qualified
     D  PrdId                         7a
     D  PrdOpt                        5a
     D  RlsLvl                        6a
     **-- Output information:
     D OutInf          Ds                  Qualified
     D  RcdSiz                       10i 0
     D  RcdAvl                       10i 0
     D  Action                       10i 0

     **-- PTF product information
     D PtfPrdInf       Ds                  Qualified
     D  PrdId                         7a
     D  Release                       6a
     D  PrdOpt                        4a
     D  LodId                        10a
     D  IncSpsPtf                     1a   Inz( '1' )
     D                               22a   Inz( *Allx'00' )
     **-- PTF list entry:
     D PTFL0100        Ds                  Qualified  Based( pLstEnt )
     D  PtfId                         7a
     D  RelLvlPtf                     6a
     D  PrdOptPtf                     4a
     D  PrdLodPtf                     4a
     D  LodSts                        1a
     D  SvfSts                        1a
     D  CvrSts                        1a
     D  OrdSts                        1a
     D  IplAct                        1a
     D  ActPnd                        1a
     D  ActReq                        1a
     D  IplReq                        1a
     D  PtfRls                        1a
     D  MinLvl                        2a
     D  MaxLvl                        2a
     D  StsDts                       13a
     D   StsDat                       7a   Overlay( StsDts: 1 )
     D   StsTim                       6a   Overlay( StsDts: 8 )
     D  SpsPtfId                      7a
     D  SvrIplReq                     1a
     D  CrtDts                       13a
     D   CrtDat                       7a   Overlay( CrtDts: 1 )
     D   CrtTim                       6a   Overlay( CrtDts: 8 )

     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  SpcNamQ                      20a   Const
     D  ExtAtr                       10a   Const
     D  InzSiz                       10i 0 Const
     D  InzVal                        1a   Const
     D  PubAut                       10a   Const
     D  Text                         50a   Const
     **
     D  Replace                      10a   Const Options( *NoPass )
     D  Error                     32767a         Options( *NoPass: *VarSize )
     **
     D  Domain                       10a   Const Options( *NoPass )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  SpcNamQ                      20a   Const
     D  Error                     32767a         Options( *VarSize )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  SpcNamQ                      20a   Const
     D  Pointer                        *
     D  Error                     32767a         Options( *NoPass: *VarSize )
     **-- Select products:
     D SltPrds         Pr                  ExtPgm( 'QSZSLTPR' )
     D  OutLst                    32767a          Options( *VarSize )
     D  InpInf                       40a   Const
     D  FmtNam                        8a   Const
     D  InpLst                       18a   Const  Dim( 1024 )
     D                                            Options( *VarSize )
     D  OutInf                    32767a          Options( *VarSize )
     D  Error                     32767a          Options( *VarSize )
     **-- List PTFs:
     D LstPtfs         Pr                  ExtProc( 'QpzListPTF' )
     D  SpcNamQ                      20a   Const
     D  PrdId                        50a   Const
     D  FmtNam                        8a   Const
     D  Error                     32767a         Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                      1024a         Options( *VarSize )
     D  CalStkElen                   10i 0 Const Options( *NoPass )
     D  CalStkEq                     20a   Const Options( *NoPass )
     D  DspWait                      10i 0 Const Options( *NoPass )
     D  CalStkEtyp                   20a   Const Options( *NoPass )
     D  CcsId                        10i 0 Const Options( *NoPass )
     **-- Run system command:
     D system          Pr            10i 0 ExtProc( 'system' )
     D  command                        *   Value  Options( *String )

     **-- Get PTF status:
     D GetPtfSts       Pr            32a   Varying
     D  PxLodSts                      1a   Const
     D  PxSvfSts                      1a   Const
     D  PxCvrSts                      1a   Const
     D  PxOrdSts                      1a   Const
     D  PxIplAct                      1a   Const
     **-- Send information message:
     D SndInfMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX947          Pr
     D  PxPtfSts                           LikeDs( PtfSts )
     D  PxPtfOpt                      4a
     D  PxSltPrd                      4a
     **
     D CBX947          Pi
     D  PxPtfSts                           LikeDs( PtfSts )
     D  PxPtfOpt                      4a
     D  PxSltPrd                      4a

      /Free

        CrtUsrSpc( USRSPC_Q
                 : *Blanks
                 : 65535
                 : x'00'
                 : '*CHANGE'
                 : *Blanks
                 : '*YES'
                 : ERRC0100
                 );

        pPRDS0200 = %Alloc( LST_RCDS * %Size( PRDS0200 ));

        InpInf.NbrPrdSlt = PxSltPrd;

        SltPrds( PRDS0200
               : InpInf
               : 'PRDS0200'
               : InpLst
               : OutInf
               : ERRC0100
               );

        If  ERRC0100.BytAvl = *Zero;

          For  IdxPrd = 1  to  OutInf.RcdAvl;

            PtfPrdInf.PrdId   = PRDS0200.PrdId;
            PtfPrdInf.Release = '*ALL';
            PtfPrdInf.PrdOpt  = '*ALL';
            PtfPrdInf.LodId   = '*ALL';

            LstPtfs( USRSPC_Q: PtfPrdInf: 'PTFL0100': ERRC0100 );

            If  ERRC0100.BytAvl = *Zero;
              ExSr  ChkPtfSts;
            EndIf;

            If  IdxPrd < OutInf.RcdAvl;
              Eval pPRDS0200 += OutInf.RcdSiz;
            EndIf;
          EndFor;
        EndIf;

        DltUsrSpc( USRSPC_Q: ERRC0100 );

        If  OutInf.Action < 0;
          SndCmpMsg( 'PTF check cancelled.' );
        Else;
          SndCmpMsg( 'PTF check completed.' );
        EndIf;

        *InLr = *On;
        Return;

        BegSr  ChkPtfSts;

          RtvPtrSpc( USRSPC_Q: pUsrSpc );

          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          For  IdxPtf = 1  to UsrSpc.NumLstEnt;

            Select;
            When  ChkSavF   = '*PTFSAVF'   And
                  PTFL0100.LodSts = '0'    And
                  PTFL0100.SvfSts = '1'    Or

                  ChkCvrOnl = '*COVERONLY' And
                  PTFL0100.LodSts = '0'    And
                  PTFL0100.SvfSts = '0'    And
                  PTFL0100.CvrSts = '1'    Or

                  ChkOnOrd  = '*ONORDER'   And
                  PTFL0100.LodSts = '0'    And
                  PTFL0100.SvfSts = '0'    And
                  PTFL0100.CvrSts = '0'    And
                  PTFL0100.OrdSts = '1'    Or

                  ChkNotApy = '*NOTAPY'    And
                  PTFL0100.LodSts = '1'    Or

                  ChkActRqd = '*ACTRQD'    And
                  PTFL0100.ActReq > '0'    And
                  PTFL0100.ActPnd > '0';

              ExSr  RunPtfOpt;

            EndSl;

            If  IdxPtf < UsrSpc.NumLstEnt;
              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
            EndIf;
          EndFor;

        EndSr;

        BegSr  RunPtfOpt;

          Select;
          When  PxPtfOpt = '*MSG';
            ExSr  SndPtfSts;

          When  PxPtfOpt = '*DSP';
            ExSr  RunDspPtf;
          EndSl;

        EndSr;

        BegSr  SndPtfSts;

          PtfStsTxt = GetPtfSts( PTFL0100.LodSts
                               : PTFL0100.SvfSts
                               : PTFL0100.CvrSts
                               : PTFL0100.OrdSts
                               : PTFL0100.IplAct
                               );

          SndInfMsg( 'PTF '                                 +
                     PtfPrdInf.PrdId                        +
                     '-'                                    +
                     PTFL0100.PtfId                         +
                     ' currently has status '''             +
                     PtfStsTxt                              +
                     '''.'
                   );

        EndSr;

        BegSr  RunDspPtf;

          system( 'DSPPTF LICPGM('                          +
                   %TrimR( PtfPrdInf.PrdId )                +
                  ') SELECT('                               +
                   %TrimR( PTFL0100.PtfId )                 +
                  ') COVERONLY(*NO)'
                );

        EndSr;

        BegSr  *InzSr;

          If  PxPtfSts.NbrSts = 1  And  PxPtfSts.StsVal(1) = '*NONAPY';
            ChkSavF   = '*PTFSAVF';
            ChkOnOrd  = '*ONORDER';
            ChkCvrOnl = '*COVERONLY';
            ChkNotApy = '*NOTAPY';
            ChkActRqd = '*ACTRQD';

          Else;
            For  IdxPtf = 1  To  PxPtfSts.NbrSts;

              Select;
              When  PxPtfSts.StsVal(IdxPtf) = '*PTFSAVF';
                ChkSavF   = '*PTFSAVF';

              When  PxPtfSts.StsVal(IdxPtf) = '*ONORDER';
                ChkOnOrd  = '*ONORDER';

              When  PxPtfSts.StsVal(IdxPtf) = '*COVERONLY';
                ChkCvrOnl = '*COVERONLY';

              When  PxPtfSts.StsVal(IdxPtf) = '*NOTAPY';
                ChkNotApy = '*NOTAPY';

              When  PxPtfSts.StsVal(IdxPtf) = '*ACTRQD';
                ChkActRqd = '*ACTRQD';
              EndSl;
            EndFor;
          EndIf;

        EndSr;

      /End-Free

     **-- Get PTF status:  ---------------------------------------------------**
     P GetPtfSts       B
     D                 Pi            32a   Varying
     D  PxLodSts                      1a   Const
     D  PxSvfSts                      1a   Const
     D  PxCvrSts                      1a   Const
     D  PxOrdSts                      1a   Const
     D  PxIplAct                      1a   Const

      /Free

        Select;
        When  PxLodSts = '0'  And  PxSvfSts = '1';
          Return  'Save file only';

        When  PxLodSts = '0'  And  PxCvrSts = '1';
          Return  'Cover letter only';

        When  PxLodSts = '0'  And  PxOrdSts = '1';
          Return  'On order only';

        When  PxLodSts = '1'  And  PxIplAct > '0';
          Return  'Not applied - IPL action';

        When  PxLodSts = '1';
          Return  'Not applied';

        Other;
          Return  'Undefined';
        EndSl;

      /End-Free

     P GetPtfSts       E
     **-- Send information message:  -----------------------------------------**
     P SndInfMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*INFO'
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

     P SndInfMsg       E
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
