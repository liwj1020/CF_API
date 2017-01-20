     **
     **  Program . . : CBX937
     **  Description : Display PTF CUM level - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX937 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX937 )
     **                Module( CBX937 )
     **                ActGrp( *NEW )
     **                BndSrvPgm( QPZLSTFX )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Global constants:
     D USRSPC_Q        c                   'LSTPTFS   QTEMP'
     **-- Global variables:
     D Idx             s             10u 0
     D CumLvl          s              5s 0 Inz
     D MsgDta          s            128a   Varying
     D MsgKey          s              4a
     **
     D IplDts          Ds            17    Qualified
     D  Date                          8a
     D  Time                          6a
     **-- API header information:
     D HdrInf          Ds                  Qualified  Based( pHdrInf )
     D  UsrSpcNamSp                  10a
     D  UsrSpcLibSp                  10a
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
     **-- Inz status record:
     D MatInzSts       Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( MatInzSts ))
     D  BytAvl                       10i 0
     D  StrIpl                        8a   Overlay( MatInzSts: 441 )
     **-- Product information - QSZRTVPR:
     D PRDR0100        Ds                  Qualified
     D  BytPrv                       10i 0
     D  BytRtn                       10i 0
     D                               10i 0
     D  PrdId                         7a
     D  Release                       6a
     D  PrdOpt                        4a
     D  LodId                         4a
     D  LodTyp                       10a
     D  SymLodStt                    10a
     D  LodErrInd                    10a
     D  LodStt                        2a
     D  SupFlg                        1a
     D  RegTyp                        2a
     D  RegVal                       14a
     D                                2a
     D  OfsAddInf                    10i 0
     D  PriLodId                      4a
     D  MinTrgRel                     6a
     D  MinVrmBas                     6a
     D  RqmBasOpt                     1a
     D  Level                         3a
     **-- PTF product information
     D PtfPrdInf       Ds                  Qualified
     D  PrdId                         7a
     D  Release                       6a
     D  PrdOpt                        4a
     D  LodId                        10a
     D  IncSpsPtf                     1a   Inz( '0' )
     D                               22a   Inz( *Allx'00' )
     **-- PTF list entry:
     D PTFL0100        Ds                  Qualified  Based( pLstEnt )
     D  PtfId                         7a
     D   PtfPfx                       2a   Overlay( PtfId: 1 )
     D   PtfCum                       1a   Overlay( PtfId: 2 )
     D   PtfNbr                       5s 0 Overlay( PtfId: 3 )
     D  RelLvlPtf                     6a
     D   RelV                         1a   Overlay( RelLvlPtf: 2 )
     D   RelR                         1a   Overlay( RelLvlPtf: 4 )
     D   RelM                         1a   Overlay( RelLvlPtf: 6 )
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
     **-- Retrieve product information:
     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
     D  Dta                                Like( PRDR0100 )
     D  DtaLen                       10i 0 Const
     D  FmtNam                        8a   Const
     D  PrdInf                       27a   Const
     D  Error                      1024a         Options( *VarSize )
     **-- List PTFs:
     D LstPtfs         Pr                  ExtProc( 'QpzListPTF' )
     D  SpcNamQ                      20a   Const
     D  PrdId                        50a   Const
     D  FmtNam                        8a   Const
     D  Error                     32767a         Options( *VarSize )
     **-- Materialize machine attributes:
     D MatMatr         PR                  ExtProc( '_MATMATR1' )
     D  Atr                                Like( MatInzSts )
     D  Opt                           2a   Const
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  InpFmt                       10a   Const
     D  InpVar                       17a   Const  Options( *VarSize )
     D  OutFmt                       10a   Const
     D  OutVar                       17a          Options( *VarSize )
     D  Error                        10i 0 Const
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
     **
     D  CalStkElen                   10i 0 Const Options( *NoPass )
     D  CalStkEq                     20a   Const Options( *NoPass )
     D  DspWait                      10i 0 Const Options( *NoPass )
     **
     D  CalStkEtyp                   20a   Const Options( *NoPass )
     D  CcsId                        10i 0 Const Options( *NoPass )

      /Free

        RtvPrdInf( PRDR0100
                 : %Size( PRDR0100 )
                 : 'PRDR0100'
                 : '*OPSYS *CUR  0000*CODE    '
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl = *Zero;

          CrtUsrSpc( USRSPC_Q
                   : *Blanks
                   : 65535
                   : x'00'
                   : '*CHANGE'
                   : *Blanks
                   : '*YES'
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            PtfPrdInf.PrdId   = PRDR0100.PrdId;
            PtfPrdInf.Release = PRDR0100.Release;
            PtfPrdInf.PrdOpt  = PRDR0100.PrdOpt;
            PtfPrdInf.LodId   = PRDR0100.LodId;

            LstPtfs( USRSPC_Q: PtfPrdInf: 'PTFL0100': ERRC0100 );

            If  ERRC0100.BytAvl = *Zero;
              ExSr  GetPtfLvl;

              MatMatr( MatInzSts: x'0108' );

              CvtDtf( '*DTS': MatInzSts.StrIpl: '*YYMD': IplDts: 0 );

              MsgDta = 'Cum level '                                       +
                       PTFL0100.PtfCum + %Char( CumLvl )                  +
                       PTFL0100.RelV + PTFL0100.RelR + PTFL0100.RelM      +
                       ' of '                                             +
                       %Char( %Date( PTFL0100.StsDat: *CYMD0 ): *JOBRUN ) +
                       ' at '                                             +
                       %Char( %Time( PTFL0100.StsTim: *HMS0 ): *JOBRUN )  +
                       ' last IPL on '                                    +
                       %Char( %Date( IplDts.Date: *ISO0 ): *JOBRUN )      +
                       ' at '                                             +
                       %Char( %Time( IplDts.Time: *HMS0 ): *JOBRUN )      +
                       '.';

              SndPgmMsg( 'CPF9897'
                       : 'QCPFMSG   *LIBL'
                       : MsgDta
                       : %Len( MsgDta )
                       : '*INFO'
                       : '*PGMBDY'
                       : 1
                       : MsgKey
                       : ERRC0100
                       );

            EndIf;

            DltUsrSpc( USRSPC_Q: ERRC0100 );

          EndIf;
        EndIf;

        *InLr = *On;
        Return;

        BegSr  GetPtfLvl;

          RtvPtrSpc( USRSPC_Q: pUsrSpc );

          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          For  Idx = 1  to UsrSpc.NumLstEnt;

            If  PTFL0100.PtfPfx = 'TC';

              If  PTFL0100.PtfNbr > CumLvl;

                CumLvl = PTFL0100.PtfNbr;
              EndIf;
            EndIf;

            If  Idx < UsrSpc.NumLstEnt;
              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
            EndIf;
          EndFor;

        EndSr;

      /End-Free
