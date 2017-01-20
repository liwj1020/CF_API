     **
     **  Program . . : CBX939
     **  Description : Retrieve System Data
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod  Module( CBX939 )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX939 )
     **               Module( CBX939 )
     **               ActGrp( *NEW )
     **
     **
     **-- Header Specifications:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )
     **-- API Error Data Structure:
     D ERRC0100        Ds                  Qualified  Inz
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a

     **-- Global constants:
     D NULL            c                   ''

     **-- Product information:
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
     **-- System status information:
     D SSTS0200        Ds                  Qualified
     D  BytAvl                       10i 0
     D  BytRtn                       10i 0 Inz( *Zero )
     D  RstStt                        1a   Overlay( SSTS0200: 31 )
     D  PrcUnitUsd                    9b 1 Overlay( SSTS0200: 33 )
     D  SysAspSiz                    10i 0 Overlay( SSTS0200: 49 )
     D  SysAspUsd                     9b 4 Overlay( SSTS0200: 53 )
     D  TotAuxStg                    10i 0 Overlay( SSTS0200: 57 )
     D  DbCapPct                      9b 1 Overlay( SSTS0200: 69 )
     D  MainStgSiz                   10i 0 Overlay( SSTS0200: 73 )
     **-- TCP/IP attributes:
     D TCPA0100        Ds                  Qualified
     D  BytRtn                       10u 0
     D  BytAvl                       10u 0
     D  StkSts                       10u 0
     D  ActTim                       10u 0
     D  LstStrD                       8a
     D  LstStrT                       6a
     D  LstEndD                       8a
     D  LstEndT                       6a
     D  StrJob                       10a
     D  StrUsr                       10a
     D  StrNbr                        6a
     D  StrJobInt                    16a
     D  EndJob                       10a
     D  EndUsr                       10a
     D  EndNbr                        6a
     D  EndJobInt                    16a
     D  OfsAddInf                    10u 0
     D  LenAddInf                    10u 0
     D  LmtMod                       10u 0
     **-- Resource management data:
     D RscMgtDta       Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( RscMgtDta ))
     D  BytAvl                       10i 0
     D  TimDay                        8a
     ** Data
     D   PrcTimIpl                   20u 0
     D   PrcTimScWlPr                20u 0
     D   PrcTimDb                    20u 0
     D   PrcTimDbThr                  4b 1
     D   PrcTimDbLmt                  4b 1
     D   Rsv1                        10u 0 Inz( x'00' )
     D   PrcTimInt                   20u 0
     D   PrcTimIntThr                 4b 1
     D   PrcTimIntLmt                 4b 1
     D   Rsv2                        10u 0 Inz( x'00' )
     ** Control data for MATRMD:
     D MatCtlDta       Ds                  Qualified
     D  SltOpt                        1a   Inz( x'01' )
     D  Rsv                           7a   Inz( *Allx'00' )

     **-- Retrieve system status:
     D RtvSysSts       Pr                  ExtPgm( 'QWCRSSTS' )
     D  RsRcvVar                  32767a          Options( *VarSize )
     D  RsRcvVarLen                  10i 0 Const
     D  RsFmtNam                     10a   Const
     D  RsRstStc                     10a   Const
     D  RsError                   32767a          Options( *VarSize )
     **
     D  RsPoolSltInf                 24a   Const  Options( *VarSize: *NoPass )
     D  RsPoolSltSiz                 10i 0 Const  Options( *NoPass )
     **-- Retrieve TCP/IP attributes:
     D RtvTcpA         Pr                  ExtProc( 'QtocRtvTCPA' )
     D  RtRcvVar                  32767a          Options( *VarSize )
     D  RtRcvVarLen                  10i 0 Const
     D  RtFmtNam                      8a   Const
     D  RtError                   32767a          Options( *VarSize )
     **-- Retrieve product information:
     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
     D  PiDta                              Like( PRDR0100 )
     D  PiDtaLen                     10i 0 Const
     D  PiFmtNam                      8a   Const
     D  PiPrdInf                     27a   Const
     D  PiError                    1024a         Options( *VarSize )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RiRcvVar                  32767a          Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiFmtNam                      8a   Const
     D  RiJobNamQ                    26a   Const
     D  RiJobIntId                   16a   Const
     D  RiError                   32767a          Options( *NoPass: *VarSize )
     D  RiRstStc                      1a          Options( *NoPass )
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const  Options( *VarSize )
     D  CdOutVar                     17a   Const  Options( *VarSize )
     D  CdError                   32767a          Options( *VarSize )
     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  CsSpcNamQ                    20a   Const
     D  CsExtAtr                     10a   Const
     D  CsInzSiz                     10i 0 Const
     D  CsInzVal                      1a   Const
     D  CsPubAut                     10a   Const
     D  CsText                       50a   Const
     D  CsReplace                    10a   Const Options( *NoPass )
     D  CsError                   32767a         Options( *NoPass: *VarSize )
     D  CsDomain                     10a   Const Options( *NoPass )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  DsSpcNamQ                    20a   Const
     D  DsError                   32767a         Options( *VarSize )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a         Options( *NoPass: *VarSize )
     **-- Materialize machine attributes:
     D MatMatr         Pr                  ExtProc('_MATMATR1')
     D  Atr                       32767a          Options( *VarSize )
     D  Opt                           2a   Const
     **-- Materialize resource management data:
     D MatRmd          Pr                  ExtProc( '_MATRMD' )
     D  Rcv                       32767a          Options( *VarSize )
     D  Ctl                           8a   Const
     **-- Test bit in string:
     D tstbts          Pr            10i 0 ExtProc( 'tstbts' )
     D  string                         *   Value
     D  bitofs                       10u 0 Value

     **-- Get system state:
     D GetSysStt       Pr             1a
     **-- Get main storage size:
     D GetMainStg      Pr            10i 0
     **-- Get system ASP size:
     D GetSysAsp       Pr            10i 0
     **-- Get system ASP used:
     D GetSysAspUsd    Pr             9p 4
     D  PxRstStc                     10a
     **-- Get total auxilliary storage:
     D GetTotAux       Pr            10i 0
     **-- Get system ASP threshold:
     D GetSysAspThr    Pr             4p 1
     **-- Get processing unit used:
     D GetCpuPct       Pr             9p 1
     D  PxRstStc                     10a
     **-- Get database capability used:
     D GetDbCap        Pr             9p 1
     D  PxRstStc                     10a
     **-- Get TCP status:
     D GetTcpSts       Pr             1a
     **-- Get system release level:
     D GetRlsLvl       Pr             6a
     **-- Get IPL timestamp:
     D GetIplDts       Pr            17a
     **-- Get processor group:
     D GetPrcGrp       Pr             4a
     **-- Get processor type:
     D GetPrcTyp       Pr             4a
     **-- Get key position:
     D GetKeyPos       Pr             6a
     **-- Get IPL type:
     D GetIplTyp       Pr             1a
     **-- Get interactive threshold:
     D GetIntThr       Pr             4p 1
     **-- Get interactive limit:
     D GetIntLmt       Pr             4p 1
     **-- Get database threshold:
     D GetDbThr        Pr             4p 1
     **-- Get database limit:
     D GetDbLmt        Pr             4p 1

     D CBX939          Pr
     D  PxRstStc                     10a
     D  PxPrcTyp                      4a
     D  PxPrcGrp                      4a
     D  PxMainStgSiz                 10p 0
     D  PxTotAuxSiz                  10p 0
     D  PxSysAspSiz                  10p 0
     D  PxSysAspUsd                   7p 4
     D  PxSysAspThr                   4p 1
     D  PxCpuPctUsd                   4p 1
     D  PxDbCapUsd                    4p 1
     D  PxPrcIntThr                   4p 1
     D  PxPrcIntLmt                   4p 1
     D  PxDbCapThr                    4p 1
     D  PxDbCapLmt                    4p 1
     D  PxOsRel                       6a
     D  PxSysStt                      1a
     D  PxTcpSts                      1a
     D  PxIplDts                     17a
     D  PxCurIpltyp                   1a
     D  PxPnlKeyPos                   6a
     **
     D CBX939          Pi
     D  PxRstStc                     10a
     D  PxPrcTyp                      4a
     D  PxPrcGrp                      4a
     D  PxMainStgSiz                 10p 0
     D  PxTotAuxSiz                  10p 0
     D  PxSysAspSiz                  10p 0
     D  PxSysAspUsd                   7p 4
     D  PxSysAspThr                   4p 1
     D  PxCpuPctUsd                   4p 1
     D  PxDbCapUsd                    4p 1
     D  PxPrcIntThr                   4p 1
     D  PxPrcIntLmt                   4p 1
     D  PxDbCapThr                    4p 1
     D  PxDbCapLmt                    4p 1
     D  PxOsRel                       6a
     D  PxSysStt                      1a
     D  PxTcpSts                      1a
     D  PxIplDts                     17a
     D  PxCurIpltyp                   1a
     D  PxPnlKeyPos                   6a

      /Free

        If  %Addr( PxPrcTyp ) <> *Null;
          PxPrcTyp = GetPrcTyp();
        EndIf;

        If  %Addr( PxPrcGrp ) <> *Null;
          PxPrcGrp = GetPrcGrp();
        EndIf;

        If  %Addr( PxMainStgSiz ) <> *Null;
          PxMainStgSiz = GetMainStg();
        EndIf;

        If  %Addr( PxSysAspSiz ) <> *Null;
          PxSysAspSiz = GetSysAsp();
        EndIf;

        If  %Addr( PxSysAspUsd ) <> *Null;
          PxSysAspUsd = GetSysAspUsd( PxRstStc );
        EndIf;

        If  %Addr( PxTotAuxSiz ) <> *Null;
          PxTotAuxSiz = GetTotAux();
        EndIf;

        If  %Addr( PxSysAspThr ) <> *Null;
          PxSysAspThr = GetSysAspThr();
        EndIf;

        If  %Addr( PxCpuPctUsd ) <> *Null;
          PxCpuPctUsd = GetCpuPct( PxRstStc );
        EndIf;

        If  %Addr( PxDbCapUsd ) <> *Null;
          PxDbCapUsd = GetDbCap( PxRstStc );
        EndIf;

        If  %Addr( PxPrcIntThr ) <> *Null;
          PxPrcIntThr = GetIntThr();
        EndIf;

        If  %Addr( PxPrcIntLmt ) <> *Null;
          PxPrcIntLmt = GetIntLmt();
        EndIf;

        If  %Addr( PxDbCapThr ) <> *Null;
          PxDbCapThr = GetDbThr();
        EndIf;

        If  %Addr( PxDbCapLmt ) <> *Null;
          PxDbCapLmt = GetDbLmt();
        EndIf;

        If  %Addr( PxOsRel ) <> *Null;
          PxOsRel = GetRlsLvl();
        EndIf;

        If  %Addr( PxSysStt ) <> *Null;
          PxSysStt = GetSysStt();
        EndIf;

        If  %Addr( PxTcpSts ) <> *Null;
          PxTcpSts = GetTcpSts();
        EndIf;

        If  %Addr( PxIplDts ) <> *Null;
          PxIplDtS = GetIplDts();
        EndIf;

        If  %Addr( PxCurIplTyp ) <> *Null;
          PxCurIplTyp = GetIplTyp();
        EndIf;

        If  %Addr( PxPnlKeyPos ) <> *Null;
          PxPnlKeyPos = GetKeyPos();
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Get system state:
     P GetSysStt       B                   Export
     D                 Pi             1a

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : '*NO'
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  *Blank;
        Else;
          Return  SSTS0200.RstStt;
        EndIf;

      /End-Free

     P GetSysStt       E
     **-- Get main storage size:
     P GetMainStg      B                   Export
     D                 Pi            10i 0

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : '*NO'
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.MainStgSiz;
        EndIf;

      /End-Free

     P GetMainStg      E
     **-- Get system ASP size:
     P GetSysAsp       B                   Export
     D                 Pi            10i 0

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : '*NO'
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.SysAspSiz;
        EndIf;

      /End-Free

     P GetSysAsp       E
     **-- Get system ASP used:
     P GetSysAspUsd    B                   Export
     D                 Pi             9p 4
     D  PxRstStc                     10a

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : PxRstStc
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.SysAspUsd;
        EndIf;

      /End-Free

     P GetSysAspUsd    E
     **-- Get total auxilliary storage:
     P GetTotAux       B                   Export
     D                 Pi            10i 0

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : PxRstStc
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.TotAuxStg;
        EndIf;

      /End-Free

     P GetTotAux       E
     **-- Get processing unit used:
     P GetCpuPct       B                   Export
     D                 Pi             9p 1
     D  PxRstStc                     10a

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : PxRstStc
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.PrcUnitUsd;
        EndIf;

      /End-Free

     P GetCpuPct       E
     **-- Get database capability used:
     P GetDbCap        B                   Export
     D                 Pi             9p 1
     D  PxRstStc                     10a

      /Free

        RtvSysSts( SSTS0200
                 : %Size( SSTS0200 )
                 : 'SSTS0200'
                 : PxRstStc
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;
        Else;
          Return  SSTS0200.DbCapPct;
        EndIf;

      /End-Free

     P GetDbCap        E
     **-- Get TCP status:
     P GetTcpSts       B                   Export
     D                 Pi             1a

      /Free

        RtvTcpA( TCPA0100: %Size( TCPA0100 ): 'TCPA0100': ERRC0100 );

        Select;
        When  ERRC0100.BytAvl  > *Zero;
          Return  'E';

        When  TCPA0100.StkSts = 1;
          Return  'O';

        Other;
          Return  'N';
        EndSl;

      /End-Free

     P GetTcpSts       E
     **-- Get system release level:  -----------------------------------------**
     P GetRlsLvl       B                   Export
     D                 Pi             6a

      /Free

        RtvPrdInf( PRDR0100
                 : %Size( PRDR0100 )
                 : 'PRDR0100'
                 : '*OPSYS *CUR  0000*CODE    '
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          PRDR0100.Release = *Blanks;
        EndIf;

        Return  PRDR0100.Release;

      /End-Free

     P GetRlsLvl       E
     **-- Get IPL timestamp:  ------------------------------------------------**
     P GetIplDts       B                   Export
     D                 Pi            17a

     D IplDts          Ds            17    Qualified
     D  Date                          8a
     D  Time                          6a
     **-- Inz status record:
     D MMTR_0108_T     Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_0108_T ))
     D  BytAvl                       10i 0
     D  StrIpl                        8a   Overlay( MMTR_0108_T: 441 )
     **
     D MMTR_MISR       c                   x'0108'

      /Free

        MatMatr( MMTR_0108_T: MMTR_MISR );

        CvtDtf( '*DTS': MMTR_0108_T.StrIpl: '*YYMD': IplDts: ERRC0100 );

        Return  IplDts;

      /End-Free

     P GetIplDts       E
     **-- Get processor group:  ----------------------------------------------**
     P GetPrcGrp       B                   Export
     D                 Pi             4a

     D MMTR_012C_T     Ds          2616    Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_012C_T ))
     D  BytAvl                       10i 0
     D  reserved                      8a
     D  Mem_Offset                   10i 0
     D  Proc_Offset                  10i 0
     D  Col_Offset                   10i 0
     D  CEC_Offset                   10i 0
     D  Panel_Offset                 10i 0
     **
     D CEC_VPD_T       Ds                  Qualified  Based( pCEC_VPD_T )
     D  CEC_read                      4a
     D  Manufacturing                 4a
     D  reserved1                     4a
     D  Type                          4a
     D  Model                         4a
     D  Pseudo_Model                  4a
     D  Group_Id                      4a
     D  reserved2                     4a
     D  Sys_Type_Ext                  1a
     D  Feature_Code                  4a
     D  Serial_No                    10a
     D  reserved3                     1a
     **
     D MMTR_VPD        c                   x'012c'

      /Free

        MatMatr( MMTR_012C_T: MMTR_VPD );

        pCEC_VPD_T = %Addr( MMTR_012C_T ) + MMTR_012C_T.CEC_Offset;

        Return  %Trim( CEC_VPD_T.Group_Id );

      /End-Free

     P GetPrcGrp       E
     **-- Get processor type:  -----------------------------------------------**
     P GetPrcTyp       B                   Export
     D                 Pi             4a

     D MMTR_012C_T     Ds          2616    Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_012C_T ))
     D  BytAvl                       10i 0
     D  reserved                      8a
     D  Mem_Offset                   10i 0
     D  Proc_Offset                  10i 0
     D  Col_Offset                   10i 0
     D  CEC_Offset                   10i 0
     D  Panel_Offset                 10i 0
     **
     D CEC_VPD_T       Ds                  Qualified  Based( pCEC_VPD_T )
     D  CEC_read                      4a
     D  Manufacturing                 4a
     D  reserved1                     4a
     D  Type                          4a
     D  Model                         4a
     D  Pseudo_Model                  4a
     D  Group_Id                      4a
     D  reserved2                     4a
     D  Sys_Type_Ext                  1a
     D  Feature_Code                  4a
     D  Serial_No                    10a
     D  reserved3                     1a
     **
     D MMTR_VPD        c                   x'012c'

      /Free

        MatMatr( MMTR_012C_T: MMTR_VPD );

        pCEC_VPD_T = %Addr( MMTR_012C_T ) + MMTR_012C_T.CEC_Offset;

        Return  CEC_VPD_T.Type;

      /End-Free

     P GetPrcTyp       E
     **-- Get key position:  -------------------------------------------------**
     P GetKeyPos       B                   Export
     D                 Pi             6a

     D MMTR_0168_T     Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_0168_T ))
     D  BytAvl                       10i 0
     D  CurIplTyp                     1a
     D  BitMap                        1a
     D                                6a
     D  PrvIplTyp                     1a
     **
     D MMTR_PANEL_STATUS...
     D                 c                   x'0168'

      /Free

        MatMatr( MMTR_0168_T: MMTR_PANEL_STATUS );

        Select;
        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 4 ) = 1;
          Return  'Auto';

        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 5 ) = 1;
          Return  'Normal';

        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 6 ) = 1;
          Return  'Manual';

        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 7 ) = 1;
          Return  'Secure';

        Other;
          Return  *Blanks;
        EndSl;

      /End-Free

     P GetKeyPos       E
     **-- Get IPL type:  -----------------------------------------------------**
     P GetIplTyp       B                   Export
     D                 Pi             1a

     D MMTR_0168_T     Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( MMTR_0168_T ))
     D  BytAvl                       10i 0
     D  CurIplTyp                     1a
     D  BitMap                        1a
     D                                6a
     D  PrvIplTyp                     1a
     **
     D MMTR_PANEL_STATUS...
     D                 c                   x'0168'

      /Free

        MatMatr( MMTR_0168_T: MMTR_PANEL_STATUS );

        Return  MMTR_0168_T.CurIplTyp;

      /End-Free

     P GetIplTyp       E
     **-- Get interactive threshold:  ----------------------------------------**
     P GetIntThr       B                   Export
     D                 Pi             4p 1

      /Free

        MatRmd( RscMgtDta: MatCtlDta );

        Return  RscMgtDta.PrcTimIntThr;

      /End-Free

     P GetIntThr       E
     **-- Get interactive limit:  --------------------------------------------**
     P GetIntLmt       B                   Export
     D                 Pi             4p 1

      /Free

        MatRmd( RscMgtDta: MatCtlDta );

        Return  RscMgtDta.PrcTimIntLmt;

      /End-Free

     P GetIntLmt       E
     **-- Get database threshold:  -------------------------------------------**
     P GetDbThr        B                   Export
     D                 Pi             4p 1

      /Free

        MatRmd( RscMgtDta: MatCtlDta );

        Return  RscMgtDta.PrcTimDbThr;

      /End-Free

     P GetDbThr        E
     **-- Get database limit:  -----------------------------------------------**
     P GetDbLmt        B                   Export
     D                 Pi             4p 1

      /Free

        MatRmd( RscMgtDta: MatCtlDta );

        Return  RscMgtDta.PrcTimDbLmt;

      /End-Free

     P GetDbLmt        E
     **-- Get system ASP threshold:  -----------------------------------------**
     P GetSysAspThr    B                   Export
     D                 Pi             4p 1

     **-- Global constants:
     D AUX_STORAGE     c                   x'12'
     **-- API control data:
     D MatCtlDta       Ds                  Qualified
     D  SltOpt                        1a   Inz( AUX_STORAGE )
     D  Rsv                           7a   Inz( *Allx'00' )
     **-- Resource management data:
     D RscMgtDta       Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( RscMgtDta ))
     D  BytAvl                       10i 0
     D  TimDay                        8a
     D  RscDtaStr
     D   CtlInf                      64a   Overlay( RscDtaStr: 1 )
     D    NbrAsp                      5i 0 Overlay( CtlInf:  1 )
     D    NbrAlcAux                   5i 0 Overlay( CtlInf: *Next )
     D    NbrUlcAux                   5i 0 Overlay( CtlInf: *Next )
     D    Rsv1                        2a   Overlay( CtlInf: *Next )
     D    MaxAuxTmp                  20i 0 Overlay( CtlInf: *Next )
     D    Rsv2                       12a   Overlay( CtlInf: *Next )
     D    OfsUnitInf                 10i 0 Overlay( CtlInf: *Next )
     D    NbrUnitMir                  5i 0 Overlay( CtlInf: *Next )
     D    MirMainStg                 10i 0 Overlay( CtlInf: *Next )
     D    Rsv3                        2a   Overlay( CtlInf: *Next )
     D    CurAuxTmp                  20i 0 Overlay( CtlInf: *Next )
     D    NbrBytPag                  10i 0 Overlay( CtlInf: *Next )
     D    NbrIndAsp                   5u 0 Overlay( CtlInf: *Next )
     D    NbrDskAsp                   5u 0 Overlay( CtlInf: *Next )
     D    NbrBasAsp                   5u 0 Overlay( CtlInf: *Next )
     D    NbrDsuBas                   5u 0 Overlay( CtlInf: *Next )
     D    NbrDsuSas                   5u 0 Overlay( CtlInf: *Next )
     D    Rsv4                        2a   Overlay( CtlInf: *Next )
     D   RscDta                   65455a   Overlay( RscDtaStr: *Next )
     **-- ASP information:
     D RmdAspInf       Ds                  Based( pAspInf )  Qualified
     D  AspInf                      160a   Dim( 256 )
     D   AspNbr                       5i 0 Overlay( AspInf:  1 )
     D   AspCtlFlg                    1a   Overlay( AspInf: *Next )
     D   AspOvfRcy                    1a   Overlay( AspInf: *Next )
     D   NbrAlcAux                    5u 0 Overlay( AspInf: *Next )
     D   Rsv1                         2a   Overlay( AspInf: *Next )
     D   AspMedCap                   20i 0 Overlay( AspInf: *Next )
     D   Rsv2                         8a   Overlay( AspInf: *Next )
     D   AspSpcAvl                   20i 0 Overlay( AspInf: *Next )
     D   AspEvtThr                   20i 0 Overlay( AspInf: *Next )
     D   AspEvtThp                    5i 0 Overlay( AspInf: *Next )
     D   AspAddFlg                    2a   Overlay( AspInf: *Next )
     D   AspCmpRcy                    1a   Overlay( AspInf: *Next )
     D   Rsv3                         3a   Overlay( AspInf: *Next )
     D   AspSysStg                   20i 0 Overlay( AspInf: *Next )
     D   AspOvfStg                   20i 0 Overlay( AspInf: *Next )
     D   SpcAlcErr                   10i 0 Overlay( AspInf: *Next )
     D   SpcAlcMch                   10i 0 Overlay( AspInf: *Next )
     D   SpcAlcTrc                   10i 0 Overlay( AspInf: *Next )
     D   SpcAlcMsd                   10i 0 Overlay( AspInf: *Next )
     D   SpcAlcMic                   10i 0 Overlay( AspInf: *Next )
     D   Rsv4                         4a   Overlay( AspInf: *Next )
     D   AvlStgLlm                   20i 0 Overlay( AspInf: *Next )
     D   PrtSpcCap                   20i 0 Overlay( AspInf: *Next )
     D   UnpspcCap                   20i 0 Overlay( AspInf: *Next )
     D   PrtSpcAvl                   20i 0 Overlay( AspInf: *Next )
     D   UnpSpcAvl                   20i 0 Overlay( AspInf: *Next )
     D   Rsv5                        32a   Overlay( AspInf: *Next )

      /Free

        MatRmd( RscMgtDta: MatCtlDta );

        pAspInf = %Addr( RscMgtDta.RscDta );

        Return  RmdAspInf.AspEvtThp(1);

      /End-Free

     P GetSysAspThr    E
