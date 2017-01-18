000100050216     **
000200050625     **  Program . . : CBX939
000300050626     **  Description : Retrieve System Data
000400050216     **  Author  . . : Carsten Flensburg
000500030829     **
000600050216     **
000700040716     **
000800050625     **  Compile options:
000900050625     **
001000050625     **    CrtRpgMod  Module( CBX939 )
001100050216     **               DbgView( *LIST )
001200031119     **
001300050625     **    CrtPgm     Pgm( CBX939 )
001400050625     **               Module( CBX939 )
001500050625     **               ActGrp( *NEW )
001600031119     **
001700040716     **
001800951011     **-- Header Specifications:  --------------------------------------------**
001900050625     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002000040711     **-- API Error Data Structure:
002100050205     D ERRC0100        Ds                  Qualified  Inz
002200050205     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002300050205     D  BytAvl                       10i 0
002400050205     D  MsgId                         7a
002500000320     D                                1a
002600050205     D  MsgDta                      256a
002700050216
002800050205     **-- Global constants:
002900050205     D NULL            c                   ''
003000050216
003100040711     **-- Product information:
003200040711     D PRDR0100        Ds                  Qualified
003300040711     D  BytPrv                       10i 0
003400040711     D  BytRtn                       10i 0
003500040711     D                               10i 0
003600040711     D  PrdId                         7a
003700040711     D  Release                       6a
003800040711     D  PrdOpt                        4a
003900040711     D  LodId                         4a
004000040711     D  LodTyp                       10a
004100040711     D  SymLodStt                    10a
004200040711     D  LodErrInd                    10a
004300040711     D  LodStt                        2a
004400040711     D  SupFlg                        1a
004500040711     D  RegTyp                        2a
004600040711     D  RegVal                       14a
004700040711     D                                2a
004800040711     D  OfsAddInf                    10i 0
004900040711     D  PriLodId                      4a
005000040711     D  MinTrgRel                     6a
005100040711     D  MinVrmBas                     6a
005200040711     D  RqmBasOpt                     1a
005300040711     D  Level                         3a
005400050205     **-- System status information:
005500050205     D SSTS0200        Ds                  Qualified
005600050205     D  BytAvl                       10i 0
005700050626     D  BytRtn                       10i 0 Inz( *Zero )
005800050205     D  RstStt                        1a   Overlay( SSTS0200: 31 )
005900050626     D  PrcUnitUsd                    9b 1 Overlay( SSTS0200: 33 )
006000050626     D  SysAspSiz                    10i 0 Overlay( SSTS0200: 49 )
006100050626     D  SysAspUsd                     9b 4 Overlay( SSTS0200: 53 )
006200050626     D  TotAuxStg                    10i 0 Overlay( SSTS0200: 57 )
006300050626     D  DbCapPct                      9b 1 Overlay( SSTS0200: 69 )
006400050626     D  MainStgSiz                   10i 0 Overlay( SSTS0200: 73 )
006500050625     **-- TCP/IP attributes:
006600050625     D TCPA0100        Ds                  Qualified
006700050625     D  BytRtn                       10u 0
006800050625     D  BytAvl                       10u 0
006900050625     D  StkSts                       10u 0
007000050625     D  ActTim                       10u 0
007100050625     D  LstStrD                       8a
007200050625     D  LstStrT                       6a
007300050625     D  LstEndD                       8a
007400050625     D  LstEndT                       6a
007500050625     D  StrJob                       10a
007600050625     D  StrUsr                       10a
007700050625     D  StrNbr                        6a
007800050625     D  StrJobInt                    16a
007900050625     D  EndJob                       10a
008000050625     D  EndUsr                       10a
008100050625     D  EndNbr                        6a
008200050625     D  EndJobInt                    16a
008300050625     D  OfsAddInf                    10u 0
008400050625     D  LenAddInf                    10u 0
008500050625     D  LmtMod                       10u 0
008600050625     **-- Resource management data:
008700050626     D RscMgtDta       Ds                  Qualified
008800050626     D  BytPrv                       10i 0 Inz( %Size( RscMgtDta ))
008900050625     D  BytAvl                       10i 0
009000050625     D  TimDay                        8a
009100050625     ** Data
009200050625     D   PrcTimIpl                   20u 0
009300050625     D   PrcTimScWlPr                20u 0
009400050625     D   PrcTimDb                    20u 0
009500050625     D   PrcTimDbThr                  4b 1
009600050625     D   PrcTimDbLmt                  4b 1
009700050625     D   Rsv1                        10u 0 Inz( x'00' )
009800050625     D   PrcTimInt                   20u 0
009900050625     D   PrcTimIntThr                 4b 1
010000050625     D   PrcTimIntLmt                 4b 1
010100050625     D   Rsv2                        10u 0 Inz( x'00' )
010200050625     ** Control data for MATRMD:
010300050625     D MatCtlDta       Ds                  Qualified
010400050625     D  SltOpt                        1a   Inz( x'01' )
010500050625     D  Rsv                           7a   Inz( *Allx'00' )
010600050205
010700050205     **-- Retrieve system status:
010800050205     D RtvSysSts       Pr                  ExtPgm( 'QWCRSSTS' )
010900050205     D  RsRcvVar                  32767a          Options( *VarSize )
011000050205     D  RsRcvVarLen                  10i 0 Const
011100050205     D  RsFmtNam                     10a   Const
011200050205     D  RsRstStc                     10a   Const
011300050205     D  RsError                   32767a          Options( *VarSize )
011400050205     **
011500050205     D  RsPoolSltInf                 24a   Const  Options( *VarSize: *NoPass )
011600050205     D  RsPoolSltSiz                 10i 0 Const  Options( *NoPass )
011700050625     **-- Retrieve TCP/IP attributes:
011800050625     D RtvTcpA         Pr                  ExtProc( 'QtocRtvTCPA' )
011900050625     D  RtRcvVar                  32767a          Options( *VarSize )
012000050625     D  RtRcvVarLen                  10i 0 Const
012100050625     D  RtFmtNam                      8a   Const
012200050625     D  RtError                   32767a          Options( *VarSize )
012300040711     **-- Retrieve product information:
012400040711     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
012500040711     D  PiDta                              Like( PRDR0100 )
012600040711     D  PiDtaLen                     10i 0 Const
012700040711     D  PiFmtNam                      8a   Const
012800040711     D  PiPrdInf                     27a   Const
012900040711     D  PiError                    1024a         Options( *VarSize )
013000050205     **-- Retrieve job information:
013100050205     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
013200050205     D  RiRcvVar                  32767a          Options( *VarSize )
013300050205     D  RiRcvVarLen                  10i 0 Const
013400050205     D  RiFmtNam                      8a   Const
013500050205     D  RiJobNamQ                    26a   Const
013600050205     D  RiJobIntId                   16a   Const
013700050205     D  RiError                   32767a          Options( *NoPass: *VarSize )
013800050205     D  RiRstStc                      1a          Options( *NoPass )
013900040711     **-- Convert date & time:
014000040711     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
014100040711     D  CdInpFmt                     10a   Const
014200040711     D  CdInpVar                     17a   Const  Options( *VarSize )
014300040711     D  CdOutFmt                     10a   Const  Options( *VarSize )
014400040711     D  CdOutVar                     17a   Const  Options( *VarSize )
014500040711     D  CdError                   32767a          Options( *VarSize )
014600050205     **-- Create user space:
014700050205     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
014800050205     D  CsSpcNamQ                    20a   Const
014900050205     D  CsExtAtr                     10a   Const
015000050205     D  CsInzSiz                     10i 0 Const
015100050205     D  CsInzVal                      1a   Const
015200050205     D  CsPubAut                     10a   Const
015300050205     D  CsText                       50a   Const
015400050205     D  CsReplace                    10a   Const Options( *NoPass )
015500050205     D  CsError                   32767a         Options( *NoPass: *VarSize )
015600050205     D  CsDomain                     10a   Const Options( *NoPass )
015700050205     **-- Delete user space:
015800050205     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
015900050205     D  DsSpcNamQ                    20a   Const
016000050205     D  DsError                   32767a         Options( *VarSize )
016100050205     **-- Retrieve pointer to user space:
016200050205     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
016300050205     D  RpSpcNamQ                    20a   Const
016400050205     D  RpPointer                      *
016500050205     D  RpError                   32767a         Options( *NoPass: *VarSize )
016600050205     **-- Materialize machine attributes:
016700050205     D MatMatr         Pr                  ExtProc('_MATMATR1')
016800050205     D  Atr                       32767a          Options( *VarSize )
016900050205     D  Opt                           2a   Const
017000050625     **-- Materialize resource management data:
017100050625     D MatRmd          Pr                  ExtProc( '_MATRMD' )
017200050625     D  Rcv                       32767a          Options( *VarSize )
017300050625     D  Ctl                           8a   Const
017400050205     **-- Test bit in string:
017500050205     D tstbts          Pr            10i 0 ExtProc( 'tstbts' )
017600050205     D  string                         *   Value
017700050205     D  bitofs                       10u 0 Value
017800050205
017900050205     **-- Get system state:
018000050625     D GetSysStt       Pr             1a
018100050626     **-- Get main storage size:
018200050626     D GetMainStg      Pr            10i 0
018300050626     **-- Get system ASP size:
018400050626     D GetSysAsp       Pr            10i 0
018500050626     **-- Get system ASP used:
018600050626     D GetSysAspUsd    Pr             9p 4
018700050626     D  PxRstStc                     10a
018800050626     **-- Get total auxilliary storage:
018900050626     D GetTotAux       Pr            10i 0
019000050626     **-- Get system ASP threshold:
019100050626     D GetSysAspThr    Pr             4p 1
019200050626     **-- Get processing unit used:
019300050626     D GetCpuPct       Pr             9p 1
019400050626     D  PxRstStc                     10a
019500050626     **-- Get database capability used:
019600050626     D GetDbCap        Pr             9p 1
019700050626     D  PxRstStc                     10a
019800050625     **-- Get TCP status:
019900050625     D GetTcpSts       Pr             1a
020000040711     **-- Get system release level:
020100040711     D GetRlsLvl       Pr             6a
020200050205     **-- Get IPL timestamp:
020300050625     D GetIplDts       Pr            17a
020400050216     **-- Get processor group:
020500050205     D GetPrcGrp       Pr             4a
020600050205     **-- Get processor type:
020700050205     D GetPrcTyp       Pr             4a
020800050205     **-- Get key position:
020900050205     D GetKeyPos       Pr             6a
021000050205     **-- Get IPL type:
021100050205     D GetIplTyp       Pr             1a
021200050625     **-- Get interactive threshold:
021300050625     D GetIntThr       Pr             4p 1
021400050625     **-- Get interactive limit:
021500050625     D GetIntLmt       Pr             4p 1
021600050625     **-- Get database threshold:
021700050625     D GetDbThr        Pr             4p 1
021800050625     **-- Get database limit:
021900050625     D GetDbLmt        Pr             4p 1
022000050205
022100050625     D CBX939          Pr
022200050626     D  PxRstStc                     10a
022300050625     D  PxPrcTyp                      4a
022400050625     D  PxPrcGrp                      4a
022500050626     D  PxMainStgSiz                 10p 0
022600050625     D  PxTotAuxSiz                  10p 0
022700050625     D  PxSysAspSiz                  10p 0
022800050626     D  PxSysAspUsd                   7p 4
022900050625     D  PxSysAspThr                   4p 1
023000050625     D  PxCpuPctUsd                   4p 1
023100050625     D  PxDbCapUsd                    4p 1
023200050625     D  PxPrcIntThr                   4p 1
023300050625     D  PxPrcIntLmt                   4p 1
023400050625     D  PxDbCapThr                    4p 1
023500050625     D  PxDbCapLmt                    4p 1
023600050625     D  PxOsRel                       6a
023700050625     D  PxSysStt                      1a
023800050625     D  PxTcpSts                      1a
023900050625     D  PxIplDts                     17a
024000050625     D  PxCurIpltyp                   1a
024100050625     D  PxPnlKeyPos                   6a
024200050625     **
024300050625     D CBX939          Pi
024400050626     D  PxRstStc                     10a
024500050625     D  PxPrcTyp                      4a
024600050625     D  PxPrcGrp                      4a
024700050626     D  PxMainStgSiz                 10p 0
024800050625     D  PxTotAuxSiz                  10p 0
024900050625     D  PxSysAspSiz                  10p 0
025000050626     D  PxSysAspUsd                   7p 4
025100050625     D  PxSysAspThr                   4p 1
025200050625     D  PxCpuPctUsd                   4p 1
025300050625     D  PxDbCapUsd                    4p 1
025400050625     D  PxPrcIntThr                   4p 1
025500050625     D  PxPrcIntLmt                   4p 1
025600050625     D  PxDbCapThr                    4p 1
025700050625     D  PxDbCapLmt                    4p 1
025800050625     D  PxOsRel                       6a
025900050625     D  PxSysStt                      1a
026000050625     D  PxTcpSts                      1a
026100050625     D  PxIplDts                     17a
026200050625     D  PxCurIpltyp                   1a
026300050625     D  PxPnlKeyPos                   6a
026400050625
026500050625      /Free
026600050625
026700050625        If  %Addr( PxPrcTyp ) <> *Null;
026800050625          PxPrcTyp = GetPrcTyp();
026900050625        EndIf;
027000050625
027100050625        If  %Addr( PxPrcGrp ) <> *Null;
027200050625          PxPrcGrp = GetPrcGrp();
027300050625        EndIf;
027400050625
027500050625        If  %Addr( PxMainStgSiz ) <> *Null;
027600050626          PxMainStgSiz = GetMainStg();
027700050625        EndIf;
027800050625
027900050625        If  %Addr( PxSysAspSiz ) <> *Null;
028000050626          PxSysAspSiz = GetSysAsp();
028100050625        EndIf;
028200050625
028300050625        If  %Addr( PxSysAspUsd ) <> *Null;
028400050626          PxSysAspUsd = GetSysAspUsd( PxRstStc );
028500050625        EndIf;
028600050625
028700050626        If  %Addr( PxTotAuxSiz ) <> *Null;
028800050626          PxTotAuxSiz = GetTotAux();
028900050626        EndIf;
029000050626
029100050625        If  %Addr( PxSysAspThr ) <> *Null;
029200050626          PxSysAspThr = GetSysAspThr();
029300050625        EndIf;
029400050625
029500050625        If  %Addr( PxCpuPctUsd ) <> *Null;
029600050626          PxCpuPctUsd = GetCpuPct( PxRstStc );
029700050625        EndIf;
029800050625
029900050625        If  %Addr( PxDbCapUsd ) <> *Null;
030000050626          PxDbCapUsd = GetDbCap( PxRstStc );
030100050625        EndIf;
030200050625
030300050625        If  %Addr( PxPrcIntThr ) <> *Null;
030400050625          PxPrcIntThr = GetIntThr();
030500050625        EndIf;
030600050625
030700050625        If  %Addr( PxPrcIntLmt ) <> *Null;
030800050625          PxPrcIntLmt = GetIntLmt();
030900050625        EndIf;
031000050625
031100050625        If  %Addr( PxDbCapThr ) <> *Null;
031200050625          PxDbCapThr = GetDbThr();
031300050625        EndIf;
031400050625
031500050625        If  %Addr( PxDbCapLmt ) <> *Null;
031600050625          PxDbCapLmt = GetDbLmt();
031700050625        EndIf;
031800050625
031900050625        If  %Addr( PxOsRel ) <> *Null;
032000050625          PxOsRel = GetRlsLvl();
032100050625        EndIf;
032200050625
032300050625        If  %Addr( PxSysStt ) <> *Null;
032400050625          PxSysStt = GetSysStt();
032500050625        EndIf;
032600050625
032700050625        If  %Addr( PxTcpSts ) <> *Null;
032800050625          PxTcpSts = GetTcpSts();
032900050625        EndIf;
033000050625
033100050625        If  %Addr( PxIplDts ) <> *Null;
033200050625          PxIplDtS = GetIplDts();
033300050625        EndIf;
033400050625
033500050625        If  %Addr( PxCurIplTyp ) <> *Null;
033600050625          PxCurIplTyp = GetIplTyp();
033700050625        EndIf;
033800050625
033900050625        If  %Addr( PxPnlKeyPos ) <> *Null;
034000050625          PxPnlKeyPos = GetKeyPos();
034100050625        EndIf;
034200050625
034300050625        *InLr = *On;
034400050625        Return;
034500050625
034600050625      /End-Free
034700050625
034800050205     **-- Get system state:
034900050205     P GetSysStt       B                   Export
035000050625     D                 Pi             1a
035100050205
035200050205      /Free
035300050205
035400050205        RtvSysSts( SSTS0200
035500050205                 : %Size( SSTS0200 )
035600050205                 : 'SSTS0200'
035700050626                 : '*NO'
035800050205                 : ERRC0100
035900050205                 );
036000050205
036100050205        If  ERRC0100.BytAvl > *Zero;
036200050625          Return  *Blank;
036300050205        Else;
036400050205          Return  SSTS0200.RstStt;
036500050205        EndIf;
036600050205
036700050205      /End-Free
036800050205
036900050205     P GetSysStt       E
037000050626     **-- Get main storage size:
037100050626     P GetMainStg      B                   Export
037200050626     D                 Pi            10i 0
037300050626
037400050626      /Free
037500050626
037600050626        RtvSysSts( SSTS0200
037700050626                 : %Size( SSTS0200 )
037800050626                 : 'SSTS0200'
037900050626                 : '*NO'
038000050626                 : ERRC0100
038100050626                 );
038200050626
038300050626        If  ERRC0100.BytAvl > *Zero;
038400050626          Return  -1;
038500050626        Else;
038600050626          Return  SSTS0200.MainStgSiz;
038700050626        EndIf;
038800050626
038900050626      /End-Free
039000050626
039100050626     P GetMainStg      E
039200050626     **-- Get system ASP size:
039300050626     P GetSysAsp       B                   Export
039400050626     D                 Pi            10i 0
039500050626
039600050626      /Free
039700050626
039800050626        RtvSysSts( SSTS0200
039900050626                 : %Size( SSTS0200 )
040000050626                 : 'SSTS0200'
040100050626                 : '*NO'
040200050626                 : ERRC0100
040300050626                 );
040400050626
040500050626        If  ERRC0100.BytAvl > *Zero;
040600050626          Return  -1;
040700050626        Else;
040800050626          Return  SSTS0200.SysAspSiz;
040900050626        EndIf;
041000050626
041100050626      /End-Free
041200050626
041300050626     P GetSysAsp       E
041400050626     **-- Get system ASP used:
041500050626     P GetSysAspUsd    B                   Export
041600050626     D                 Pi             9p 4
041700050626     D  PxRstStc                     10a
041800050626
041900050626      /Free
042000050626
042100050626        RtvSysSts( SSTS0200
042200050626                 : %Size( SSTS0200 )
042300050626                 : 'SSTS0200'
042400050626                 : PxRstStc
042500050626                 : ERRC0100
042600050626                 );
042700050626
042800050626        If  ERRC0100.BytAvl > *Zero;
042900050626          Return  -1;
043000050626        Else;
043100050626          Return  SSTS0200.SysAspUsd;
043200050626        EndIf;
043300050626
043400050626      /End-Free
043500050626
043600050626     P GetSysAspUsd    E
043700050626     **-- Get total auxilliary storage:
043800050626     P GetTotAux       B                   Export
043900050626     D                 Pi            10i 0
044000050626
044100050626      /Free
044200050626
044300050626        RtvSysSts( SSTS0200
044400050626                 : %Size( SSTS0200 )
044500050626                 : 'SSTS0200'
044600050626                 : PxRstStc
044700050626                 : ERRC0100
044800050626                 );
044900050626
045000050626        If  ERRC0100.BytAvl > *Zero;
045100050626          Return  -1;
045200050626        Else;
045300050626          Return  SSTS0200.TotAuxStg;
045400050626        EndIf;
045500050626
045600050626      /End-Free
045700050626
045800050626     P GetTotAux       E
045900050626     **-- Get processing unit used:
046000050626     P GetCpuPct       B                   Export
046100050626     D                 Pi             9p 1
046200050626     D  PxRstStc                     10a
046300050626
046400050626      /Free
046500050626
046600050626        RtvSysSts( SSTS0200
046700050626                 : %Size( SSTS0200 )
046800050626                 : 'SSTS0200'
046900050626                 : PxRstStc
047000050626                 : ERRC0100
047100050626                 );
047200050626
047300050626        If  ERRC0100.BytAvl > *Zero;
047400050626          Return  -1;
047500050626        Else;
047600050626          Return  SSTS0200.PrcUnitUsd;
047700050626        EndIf;
047800050626
047900050626      /End-Free
048000050626
048100050626     P GetCpuPct       E
048200050626     **-- Get database capability used:
048300050626     P GetDbCap        B                   Export
048400050626     D                 Pi             9p 1
048500050626     D  PxRstStc                     10a
048600050626
048700050626      /Free
048800050626
048900050626        RtvSysSts( SSTS0200
049000050626                 : %Size( SSTS0200 )
049100050626                 : 'SSTS0200'
049200050626                 : PxRstStc
049300050626                 : ERRC0100
049400050626                 );
049500050626
049600050626        If  ERRC0100.BytAvl > *Zero;
049700050626          Return  -1;
049800050626        Else;
049900050626          Return  SSTS0200.DbCapPct;
050000050626        EndIf;
050100050626
050200050626      /End-Free
050300050626
050400050626     P GetDbCap        E
050500050625     **-- Get TCP status:
050600050625     P GetTcpSts       B                   Export
050700050625     D                 Pi             1a
050800050625
050900050625      /Free
051000050625
051100050625        RtvTcpA( TCPA0100: %Size( TCPA0100 ): 'TCPA0100': ERRC0100 );
051200050625
051300050625        Select;
051400050625        When  ERRC0100.BytAvl  > *Zero;
051500050625          Return  'E';
051600050625
051700050625        When  TCPA0100.StkSts = 1;
051800050625          Return  'O';
051900050625
052000050625        Other;
052100050625          Return  'N';
052200050625        EndSl;
052300050625
052400050625      /End-Free
052500050625
052600050625     P GetTcpSts       E
052700040711     **-- Get system release level:  -----------------------------------------**
052800040711     P GetRlsLvl       B                   Export
052900040711     D                 Pi             6a
053000040711
053100040711      /Free
053200040711
053300040714        RtvPrdInf( PRDR0100
053400040714                 : %Size( PRDR0100 )
053500040714                 : 'PRDR0100'
053600040714                 : '*OPSYS *CUR  0000*CODE    '
053700050205                 : ERRC0100
053800040714                 );
053900040711
054000050205        If  ERRC0100.BytAvl > *Zero;
054100040714          PRDR0100.Release = *Blanks;
054200040714        EndIf;
054300040711
054400040714        Return  PRDR0100.Release;
054500040711
054600040711      /End-Free
054700040711
054800040711     P GetRlsLvl       E
054900050205     **-- Get IPL timestamp:  ------------------------------------------------**
055000050205     P GetIplDts       B                   Export
055100050625     D                 Pi            17a
055200050625
055300050205     D IplDts          Ds            17    Qualified
055400050205     D  Date                          8a
055500050205     D  Time                          6a
055600050625     **-- Inz status record:
055700050625     D MMTR_0108_T     Ds                  Qualified
055800050625     D  BytPrv                       10i 0 Inz( %Size( MMTR_0108_T ))
055900050625     D  BytAvl                       10i 0
056000050625     D  StrIpl                        8a   Overlay( MMTR_0108_T: 441 )
056100050625     **
056200050625     D MMTR_MISR       c                   x'0108'
056300050205
056400050205      /Free
056500050205
056600050625        MatMatr( MMTR_0108_T: MMTR_MISR );
056700050205
056800050625        CvtDtf( '*DTS': MMTR_0108_T.StrIpl: '*YYMD': IplDts: ERRC0100 );
056900050205
057000050625        Return  IplDts;
057100050205
057200050205      /End-Free
057300050205
057400050205     P GetIplDts       E
057500050216     **-- Get processor group:  ----------------------------------------------**
057600050205     P GetPrcGrp       B                   Export
057700050205     D                 Pi             4a
057800050625
057900050205     D MMTR_012C_T     Ds          2616    Qualified
058000050205     D  BytPrv                       10i 0 Inz( %Size( MMTR_012C_T ))
058100050205     D  BytAvl                       10i 0
058200050205     D  reserved                      8a
058300050205     D  Mem_Offset                   10i 0
058400050205     D  Proc_Offset                  10i 0
058500050205     D  Col_Offset                   10i 0
058600050205     D  CEC_Offset                   10i 0
058700050205     D  Panel_Offset                 10i 0
058800050205     **
058900050205     D CEC_VPD_T       Ds                  Qualified  Based( pCEC_VPD_T )
059000050205     D  CEC_read                      4a
059100050205     D  Manufacturing                 4a
059200050205     D  reserved1                     4a
059300050205     D  Type                          4a
059400050205     D  Model                         4a
059500050205     D  Pseudo_Model                  4a
059600050205     D  Group_Id                      4a
059700050205     D  reserved2                     4a
059800050205     D  Sys_Type_Ext                  1a
059900050205     D  Feature_Code                  4a
060000050205     D  Serial_No                    10a
060100050205     D  reserved3                     1a
060200050205     **
060300050205     D MMTR_VPD        c                   x'012c'
060400050205
060500050205      /Free
060600050205
060700050625        MatMatr( MMTR_012C_T: MMTR_VPD );
060800050205
060900050205        pCEC_VPD_T = %Addr( MMTR_012C_T ) + MMTR_012C_T.CEC_Offset;
061000050205
061100050205        Return  %Trim( CEC_VPD_T.Group_Id );
061200050205
061300050205      /End-Free
061400050205
061500050205     P GetPrcGrp       E
061600050205     **-- Get processor type:  -----------------------------------------------**
061700050205     P GetPrcTyp       B                   Export
061800050205     D                 Pi             4a
061900050625
062000050205     D MMTR_012C_T     Ds          2616    Qualified
062100050205     D  BytPrv                       10i 0 Inz( %Size( MMTR_012C_T ))
062200050205     D  BytAvl                       10i 0
062300050205     D  reserved                      8a
062400050205     D  Mem_Offset                   10i 0
062500050205     D  Proc_Offset                  10i 0
062600050205     D  Col_Offset                   10i 0
062700050205     D  CEC_Offset                   10i 0
062800050205     D  Panel_Offset                 10i 0
062900050205     **
063000050205     D CEC_VPD_T       Ds                  Qualified  Based( pCEC_VPD_T )
063100050205     D  CEC_read                      4a
063200050205     D  Manufacturing                 4a
063300050205     D  reserved1                     4a
063400050205     D  Type                          4a
063500050205     D  Model                         4a
063600050205     D  Pseudo_Model                  4a
063700050205     D  Group_Id                      4a
063800050205     D  reserved2                     4a
063900050205     D  Sys_Type_Ext                  1a
064000050205     D  Feature_Code                  4a
064100050205     D  Serial_No                    10a
064200050205     D  reserved3                     1a
064300050205     **
064400050205     D MMTR_VPD        c                   x'012c'
064500050205
064600050205      /Free
064700050205
064800050625        MatMatr( MMTR_012C_T: MMTR_VPD );
064900050205
065000050205        pCEC_VPD_T = %Addr( MMTR_012C_T ) + MMTR_012C_T.CEC_Offset;
065100050205
065200050205        Return  CEC_VPD_T.Type;
065300050205
065400050205      /End-Free
065500050205
065600050205     P GetPrcTyp       E
065700050205     **-- Get key position:  -------------------------------------------------**
065800050205     P GetKeyPos       B                   Export
065900050205     D                 Pi             6a
066000050625
066100050206     D MMTR_0168_T     Ds                  Qualified
066200050206     D  BytPrv                       10i 0 Inz( %Size( MMTR_0168_T ))
066300050205     D  BytAvl                       10i 0
066400050205     D  CurIplTyp                     1a
066500050205     D  BitMap                        1a
066600050205     D                                6a
066700050205     D  PrvIplTyp                     1a
066800050205     **
066900050206     D MMTR_PANEL_STATUS...
067000050206     D                 c                   x'0168'
067100050205
067200050205      /Free
067300050205
067400050206        MatMatr( MMTR_0168_T: MMTR_PANEL_STATUS );
067500050205
067600050205        Select;
067700050206        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 4 ) = 1;
067800050205          Return  'Auto';
067900050205
068000050206        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 5 ) = 1;
068100050205          Return  'Normal';
068200050205
068300050206        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 6 ) = 1;
068400050205          Return  'Manual';
068500050205
068600050206        When  tstbts( %Addr( MMTR_0168_T.BitMap ): 7 ) = 1;
068700050205          Return  'Secure';
068800050205
068900050205        Other;
069000050205          Return  *Blanks;
069100050205        EndSl;
069200050205
069300050205      /End-Free
069400050205
069500050205     P GetKeyPos       E
069600050205     **-- Get IPL type:  -----------------------------------------------------**
069700050205     P GetIplTyp       B                   Export
069800050205     D                 Pi             1a
069900050625
070000050206     D MMTR_0168_T     Ds                  Qualified
070100050206     D  BytPrv                       10i 0 Inz( %Size( MMTR_0168_T ))
070200050205     D  BytAvl                       10i 0
070300050205     D  CurIplTyp                     1a
070400050205     D  BitMap                        1a
070500050205     D                                6a
070600050205     D  PrvIplTyp                     1a
070700050205     **
070800050206     D MMTR_PANEL_STATUS...
070900050206     D                 c                   x'0168'
071000050205
071100050205      /Free
071200050205
071300050206        MatMatr( MMTR_0168_T: MMTR_PANEL_STATUS );
071400050205
071500050206        Return  MMTR_0168_T.CurIplTyp;
071600050205
071700050205      /End-Free
071800050205
071900050205     P GetIplTyp       E
072000050625     **-- Get interactive threshold:  ----------------------------------------**
072100050625     P GetIntThr       B                   Export
072200050625     D                 Pi             4p 1
072300050625
072400050625      /Free
072500050625
072600050626        MatRmd( RscMgtDta: MatCtlDta );
072700050625
072800050626        Return  RscMgtDta.PrcTimIntThr;
072900050625
073000050625      /End-Free
073100050625
073200050625     P GetIntThr       E
073300050625     **-- Get interactive limit:  --------------------------------------------**
073400050625     P GetIntLmt       B                   Export
073500050625     D                 Pi             4p 1
073600050625
073700050625      /Free
073800050625
073900050626        MatRmd( RscMgtDta: MatCtlDta );
074000050625
074100050626        Return  RscMgtDta.PrcTimIntLmt;
074200050625
074300050625      /End-Free
074400050625
074500050625     P GetIntLmt       E
074600050625     **-- Get database threshold:  -------------------------------------------**
074700050625     P GetDbThr        B                   Export
074800050625     D                 Pi             4p 1
074900050625
075000050625      /Free
075100050625
075200050626        MatRmd( RscMgtDta: MatCtlDta );
075300050625
075400050626        Return  RscMgtDta.PrcTimDbThr;
075500050625
075600050625      /End-Free
075700050625
075800050625     P GetDbThr        E
075900050625     **-- Get database limit:  -----------------------------------------------**
076000050625     P GetDbLmt        B                   Export
076100050625     D                 Pi             4p 1
076200050625
076300050625      /Free
076400050625
076500050626        MatRmd( RscMgtDta: MatCtlDta );
076600050625
076700050626        Return  RscMgtDta.PrcTimDbLmt;
076800050625
076900050625      /End-Free
077000050625
077100050625     P GetDbLmt        E
077200050626     **-- Get system ASP threshold:  -----------------------------------------**
077300050626     P GetSysAspThr    B                   Export
077400050626     D                 Pi             4p 1
077500050626
077600050626     **-- Global constants:
077700050626     D AUX_STORAGE     c                   x'12'
077800050626     **-- API control data:
077900050626     D MatCtlDta       Ds                  Qualified
078000050626     D  SltOpt                        1a   Inz( AUX_STORAGE )
078100050626     D  Rsv                           7a   Inz( *Allx'00' )
078200050626     **-- Resource management data:
078300050626     D RscMgtDta       Ds                  Qualified
078400050626     D  BytPrv                       10i 0 Inz( %Size( RscMgtDta ))
078500050626     D  BytAvl                       10i 0
078600050626     D  TimDay                        8a
078700050626     D  RscDtaStr
078800050626     D   CtlInf                      64a   Overlay( RscDtaStr: 1 )
078900050626     D    NbrAsp                      5i 0 Overlay( CtlInf:  1 )
079000050626     D    NbrAlcAux                   5i 0 Overlay( CtlInf: *Next )
079100050626     D    NbrUlcAux                   5i 0 Overlay( CtlInf: *Next )
079200050626     D    Rsv1                        2a   Overlay( CtlInf: *Next )
079300050626     D    MaxAuxTmp                  20i 0 Overlay( CtlInf: *Next )
079400050626     D    Rsv2                       12a   Overlay( CtlInf: *Next )
079500050626     D    OfsUnitInf                 10i 0 Overlay( CtlInf: *Next )
079600050626     D    NbrUnitMir                  5i 0 Overlay( CtlInf: *Next )
079700050626     D    MirMainStg                 10i 0 Overlay( CtlInf: *Next )
079800050626     D    Rsv3                        2a   Overlay( CtlInf: *Next )
079900050626     D    CurAuxTmp                  20i 0 Overlay( CtlInf: *Next )
080000050626     D    NbrBytPag                  10i 0 Overlay( CtlInf: *Next )
080100050626     D    NbrIndAsp                   5u 0 Overlay( CtlInf: *Next )
080200050626     D    NbrDskAsp                   5u 0 Overlay( CtlInf: *Next )
080300050626     D    NbrBasAsp                   5u 0 Overlay( CtlInf: *Next )
080400050626     D    NbrDsuBas                   5u 0 Overlay( CtlInf: *Next )
080500050626     D    NbrDsuSas                   5u 0 Overlay( CtlInf: *Next )
080600050626     D    Rsv4                        2a   Overlay( CtlInf: *Next )
080700050626     D   RscDta                   65455a   Overlay( RscDtaStr: *Next )
080800050626     **-- ASP information:
080900050626     D RmdAspInf       Ds                  Based( pAspInf )  Qualified
081000050626     D  AspInf                      160a   Dim( 256 )
081100050626     D   AspNbr                       5i 0 Overlay( AspInf:  1 )
081200050626     D   AspCtlFlg                    1a   Overlay( AspInf: *Next )
081300050626     D   AspOvfRcy                    1a   Overlay( AspInf: *Next )
081400050626     D   NbrAlcAux                    5u 0 Overlay( AspInf: *Next )
081500050626     D   Rsv1                         2a   Overlay( AspInf: *Next )
081600050626     D   AspMedCap                   20i 0 Overlay( AspInf: *Next )
081700050626     D   Rsv2                         8a   Overlay( AspInf: *Next )
081800050626     D   AspSpcAvl                   20i 0 Overlay( AspInf: *Next )
081900050626     D   AspEvtThr                   20i 0 Overlay( AspInf: *Next )
082000050626     D   AspEvtThp                    5i 0 Overlay( AspInf: *Next )
082100050626     D   AspAddFlg                    2a   Overlay( AspInf: *Next )
082200050626     D   AspCmpRcy                    1a   Overlay( AspInf: *Next )
082300050626     D   Rsv3                         3a   Overlay( AspInf: *Next )
082400050626     D   AspSysStg                   20i 0 Overlay( AspInf: *Next )
082500050626     D   AspOvfStg                   20i 0 Overlay( AspInf: *Next )
082600050626     D   SpcAlcErr                   10i 0 Overlay( AspInf: *Next )
082700050626     D   SpcAlcMch                   10i 0 Overlay( AspInf: *Next )
082800050626     D   SpcAlcTrc                   10i 0 Overlay( AspInf: *Next )
082900050626     D   SpcAlcMsd                   10i 0 Overlay( AspInf: *Next )
083000050626     D   SpcAlcMic                   10i 0 Overlay( AspInf: *Next )
083100050626     D   Rsv4                         4a   Overlay( AspInf: *Next )
083200050626     D   AvlStgLlm                   20i 0 Overlay( AspInf: *Next )
083300050626     D   PrtSpcCap                   20i 0 Overlay( AspInf: *Next )
083400050626     D   UnpspcCap                   20i 0 Overlay( AspInf: *Next )
083500050626     D   PrtSpcAvl                   20i 0 Overlay( AspInf: *Next )
083600050626     D   UnpSpcAvl                   20i 0 Overlay( AspInf: *Next )
083700050626     D   Rsv5                        32a   Overlay( AspInf: *Next )
083800050626
083900050626      /Free
084000050626
084100050626        MatRmd( RscMgtDta: MatCtlDta );
084200050626
084300050626        pAspInf = %Addr( RscMgtDta.RscDta );
084400050626
084500050626        Return  RmdAspInf.AspEvtThp(1);
084600050626
084700050626      /End-Free
084800050626
084900050626     P GetSysAspThr    E
