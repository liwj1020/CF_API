000100041110     **
000200070423     **  Program . . : CBX969E
000300060517     **  Description : Work with Jobs - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500070423     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070423     **    CrtRpgMod  Module( CBX969E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070423     **    CrtPgm     Pgm( CBX969E )
001400070423     **               Module( CBX969E )
001500070423     **               ActGrp( *CALLER )
001600031115     **
001700031115     **
001800040605     **-- Control specification:  --------------------------------------------**
001900060311     H Option( *SrcStmt )
002000040722
002100041120     **-- System information:
002200041120     D PgmSts         SDs                  Qualified
002300041120     D  PgmNam           *Proc
002400041120     D  CurJob                       10a   Overlay( PgmSts: 244 )
002500041120     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002600041120     D  JobNbr                        6a   Overlay( PgmSts: 264 )
002700041120     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002800060311
002900040728     **-- API error data structure:
003000040728     D ERRC0100        Ds                  Qualified
003100040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003200040728     D  BytAvl                       10i 0
003300041119     D  MsgId                         7a
003400040728     D                                1a
003500041119     D  MsgDta                      512a
003600060311
003700041120     **-- Global constants:
003800060327     D NULL            c                   ''
003900060327     D NO_ENT          c                   x'00000000'
004000060522
004100060522     **-- UIM constants:
004200060522     D POS_BOT         c                   'BOT'
004300060522     D LIST_COMP       c                   'ALL'
004400060522     D EXIT_SAME       c                   '*SAME'
004500060522     D TRIM_SAME       c                   'S'
004600060522     D INC_EXP         c                   'Y'
004700060522     D CPY_VAR         c                   'Y'
004800060522     D CPY_VAR_NO      c                   'N'
004900060423     **-- UIM variables:
005000060423     D UIM             Ds                  Qualified
005100060423     D  EntHdl                        4a
005200060502     **-- UIM constants:
005300060502     D APP_PRTF        c                   'QPRINT    *LIBL'
005400060502     D ODP_SHR         c                   'N'
005500060512     D SPLF_NAM        c                   'PLSTJOBS'
005600060511     D SPLF_USRDTA     c                   'WRKJOBS'
005700060502     D EJECT_NO        c                   'N'
005800060502     D CLO_NRM         c                   'M'
005900060504     D RES_OK          c                   0
006000060504     D RES_ERR         c                   1
006100051129
006200060311     **-- UIM API return structures:
006300060508     **-- Cursor record:
006400060508     D CsrRcd          Ds                  Qualified
006500060508     D  CsrEid                        4a
006600060508     D  CsrVar                       10a
006700060508     D  CsrNam                       10a
006800060508     D  CsrLst                       10a
006900060508     D  CsrPos                        5i 0
007000060421     **-- UIM List entry:
007100060501     D LstEnt          Ds                  Qualified
007200060511     D  Option                        5i 0
007300060511     D  EntId                        19a
007400060511     D  JobNam                       10a
007500060511     D  JobUsr                       10a
007600060511     D  JobNbr                        6s 0
007700060511     D  JobTyp                        1a
007800060511     D  JobSts1                       7a
007900060511     D  JobSts2                       4a
008000060511     D  JobDat                        7a
008100060511     D  EntDat                        7a
008200060511     D  EntTim                        6a
008300060511     D  ActDat                        7a
008400060511     D  ActTim                        6a
008500060511     D  CurUsr                       10a
008600060511     D  FncCmp                       14a
008700060511     D  MsgRpy                        1a
008800060511     D  SbmJob                       10a
008900060511     D  SbmUsr                       10a
009000060511     D  SbmNbr                        6a
009100060311
009200060311     **-- UIM exit program interfaces:
009300060327     **-- Parm interface:
009400060327     D UimExit         Ds            70    Qualified
009500060327     D  StcLvl                       10i 0
009600060327     D                                8a
009700060327     D  TypCall                      10i 0
009800060327     D  AppHdl                        8a
009900060311     **-- Function key - call:
010000060311     D Type1           Ds                  Qualified
010100060311     D  StcLvl                       10i 0
010200060311     D                                8a
010300060311     D  TypCall                      10i 0
010400060311     D  AppHdl                        8a
010500060311     D  PnlNam                       10a
010600060311     D  FncKey                       10i 0
010700060421     **-- Action list option/Pull-down field choice:
010800060421     D Type5           Ds                  Qualified
010900060421     D  StcLvl                       10i 0
011000060421     D                                8a
011100060421     D  TypCall                      10i 0
011200060421     D  AppHdl                        8a
011300060421     D  PnlNam                       10a
011400060421     D  LstNam                       10a
011500060421     D  LstEntHdl                     4a
011600060421     D  OptNbr                       10i 0
011700060421     D  FncQlf                       10i 0
011800060421     D  ActRes                       10i 0
011900060421     D  PdwFldNam                    10a
012000060311
012100060311     **-- Get list entry:
012200060311     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
012300060311     D  AppHdl                        8a   Const
012400060311     D  VarBuf                    32767a   Const  Options( *VarSize )
012500060311     D  VarBufLen                    10i 0 Const
012600060311     D  VarRcdNam                    10a   Const
012700060311     D  LstNam                       10a   Const
012800060311     D  PosOpt                        4a   Const
012900060311     D  CpyOpt                        1a   Const
013000060311     D  SltCri                       20a   Const
013100060311     D  SltHdl                        4a   Const
013200060311     D  ExtOpt                        1a   Const
013300060311     D  LstEntHdl                     4a
013400060311     D  Error                     32767a          Options( *VarSize )
013500060421     **-- Update list entry:
013600060421     D UpdLstEnt       Pr                  ExtPgm( 'QUIUPDLE' )
013700060421     D  AppHdl                        8a   Const
013800060421     D  VarBuf                    32767a   Const  Options( *VarSize )
013900060421     D  VarBufLen                    10i 0 Const
014000060421     D  VarRcdNam                    10a   Const
014100060421     D  LstNam                       10a   Const
014200060421     D  Option                        4a   Const
014300060421     D  LstEntHdl                     4a
014400060421     D  Error                     32767a          Options( *VarSize )
014500060311
014600060311     **-- Get dialog variable:
014700060311     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
014800060311     D  AppHdl                        8a   Const
014900060311     D  VarBuf                    32767a          Options( *VarSize )
015000060311     D  VarBufLen                    10i 0 Const
015100060311     D  VarRcdNam                    10a   Const
015200060311     D  Error                     32767a          Options( *VarSize )
015300060501     **-- Put dialog variable:
015400060501     D PutDlgVar       Pr                  ExtPgm( 'QUIPUTV' )
015500060501     D  AppHdl                        8a   Const
015600060501     D  VarBuf                    32767a   Const  Options( *VarSize )
015700060501     D  VarBufLen                    10i 0 Const
015800060501     D  VarRcdNam                    10a   Const
015900060501     D  Error                     32767a          Options( *VarSize )
016000060502     **-- Print panel:
016100060502     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
016200060502     D  AppHdl                        8a   Const
016300060502     D  PrtPnlNam                    10a   Const
016400060502     D  EjtOpt                        1a   Const
016500060502     D  Error                     32767a          Options( *VarSize )
016600060502     **-- Add print application:
016700060502     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
016800060502     D  AppHdl                        8a   Const
016900060502     D  PrtDevF_q                    20a   Const
017000060502     D  AltFilNam                    10a   Const
017100060502     D  ShrOpnDtaPth                  1a   Const
017200060502     D  UsrDta                       10a   Const
017300060502     D  Error                     32767a          Options( *VarSize )
017400060502     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
017500060502     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
017600060502     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
017700060502     **-- Remove print application:
017800060502     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
017900060502     D  AppHdl                        8a   Const
018000060502     D  CloOpt                        1a   Const
018100060502     D  Error                     32767a          Options( *VarSize )
018200060522     **-- Set list attributes:
018300060522     D SetLstAtr       Pr                  ExtPgm( 'QUISETLA' )
018400060522     D  AppHdl                        8a   Const
018500060522     D  LstNam                       10a   Const
018600060522     D  LstCon                        4a   Const
018700060522     D  ExtPgmVar                    10a   Const
018800060522     D  DspPos                        4a   Const
018900060522     D  AlwTrim                       1a   Const
019000060522     D  Error                     32767a          Options( *VarSize )
019100060501
019200060501     **-- Process commands:
019300060501     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
019400060501     D  SrcCmd                    32702a   Const  Options( *VarSize )
019500060501     D  SrcCmdLen                    10i 0 Const
019600060501     D  OptCtlBlk                    20a   Const
019700060501     D  OptCtlBlkLn                  10i 0 Const
019800060501     D  OptCtlBlkFm                   8a   Const
019900060501     D  ChgCmd                    32767a          Options( *VarSize )
020000060501     D  ChgCmdLen                    10i 0 Const
020100060501     D  ChgCmdLenAv                  10i 0
020200060501     D  Error                     32767a          Options( *VarSize )
020300060327     **-- Send program message:
020400060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
020500060327     D  MsgId                         7a   Const
020600060327     D  MsgFq                        20a   Const
020700060327     D  MsgDta                      128a   Const
020800060327     D  MsgDtaLen                    10i 0 Const
020900060327     D  MsgTyp                       10a   Const
021000060327     D  CalStkE                      10a   Const  Options( *VarSize )
021100060327     D  CalStkCtr                    10i 0 Const
021200060327     D  MsgKey                        4a
021300060327     D  Error                     32767a          Options( *VarSize )
021400060327
021500060501     **-- Process command:
021600060501     D PrcCmd          Pr             7a
021700060501     D  CmdStr                     1024a   Const  Varying
021800060502     **-- Send completion message:
021900060502     D SndCmpMsg       Pr            10i 0
022000060502     D  PxMsgDta                    512a   Const  Varying
022100060327     **-- Send escape message:
022200060327     D SndEscMsg       Pr            10i 0
022300060327     D  PxMsgId                       7a   Const
022400060327     D  PxMsgF                       10a   Const
022500060327     D  PxMsgDta                    512a   Const  Varying
022600051129
022700040722     **-- Entry parameters:
022800070423     D CBX969E         Pr
022900060327     D  PxUimExit                          LikeDs( UimExit )
023000051129     **
023100070423     D CBX969E         Pi
023200060327     D  PxUimExit                          LikeDs( UimExit )
023300040721
023400040724      /Free
023500041224
023600060501          Select;
023700060501          When  PxUimExit.TypCall = 1;
023800060501            Type1 = PxUimExit;
023900060501
024000060502            Select;
024100060502            When  Type1.FncKey = 21;
024200060502              ExSr  PrtJobPnl;
024300060508
024400060508            When  Type1.FncKey = 22;
024500060508              ExSr  RunCsrAct;
024600060502            EndSl;
024700060501
024800060501          When  PxUimExit.TypCall = 5;
024900060421            Type5 = PxUimExit;
025000060327
025100060504            If  Type5.ActRes = RES_OK;
025200060504
025300060504              Select;
025400060504              When  Type5.OptNbr = 2;
025500060504                ExSr  ChgLstEnt;
025600060504
025700060504              When  Type5.OptNbr = 3;
025800060504                ExSr  HldLstEnt;
025900060504
026000060504              When  Type5.OptNbr = 4;
026100060517                ExSr  EndLstEnt;
026200060504
026300060504              When  Type5.OptNbr = 6;
026400060504                ExSr  RlsLstEnt;
026500060504              EndSl;
026600060504            EndIf;
026700060501          EndSl;
026800040728
026900040605        Return;
027000040721
027100060502
027200060502        BegSr  PrtJobPnl;
027300060502
027400060502          AddPrtApp( Type1.AppHdl
027500060502                   : APP_PRTF
027600060502                   : SPLF_NAM
027700060502                   : ODP_SHR
027800060502                   : SPLF_USRDTA
027900060502                   : ERRC0100
028000060502                   );
028100060502
028200060502          PrtPnl( Type1.AppHdl
028300060502                : 'PRTHDR'
028400060502                : EJECT_NO
028500060502                : ERRC0100
028600060502                );
028700060502
028800060502          PrtPnl( Type1.AppHdl
028900060502                : 'PRTLST'
029000060502                : EJECT_NO
029100060502                : ERRC0100
029200060502                );
029300060502
029400060502          RmvPrtApp( Type1.AppHdl
029500060502                   : CLO_NRM
029600060502                   : ERRC0100
029700060502                   );
029800060502
029900060502          SndCmpMsg( 'List has been printed.' );
030000060502
030100060508        EndSr;
030200060508
030300060508        BegSr  RunCsrAct;
030400060508
030500060508          GetDlgVar( Type1.AppHdl
030600060508                   : CsrRcd
030700060508                   : %Size( CsrRcd )
030800060511                   : 'CSRRCD'
030900060508                   : ERRC0100
031000060508                   );
031100060508
031200060508          If  CsrRcd.CsrEid = NO_ENT  Or  CsrRcd.CsrVar <> 'JOBNAM';
031300060508            SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );
031400060508
031500060508          Else;
031600060508            GetLstEnt( Type1.AppHdl
031700060508                     : LstEnt
031800060508                     : %Size( LstEnt )
031900060508                     : 'DTLRCD'
032000060508                     : 'DTLLST'
032100060508                     : 'HNDL'
032200060508                     : 'Y'
032300060508                     : *Blanks
032400060508                     : CsrRcd.CsrEid
032500060508                     : 'N'
032600060508                     : UIM.EntHdl
032700060508                     : ERRC0100
032800060508                     );
032900060508
033000060508            If  LstEnt.JobSts1 <> '*ACTIVE';
033100060508              SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );
033200060512
033300060512            Else;
033400060512              PrcCmd( 'WRKACTJOB JOB(' + %TrimR( LstEnt.JobNam ) + ')' );
033500060508            EndIf;
033600060508          EndIf;
033700060508
033800060502        EndSr;
033900060501
034000060422        BegSr  ChgLstEnt;
034100060422
034200060422          GetLstEnt( Type5.AppHdl
034300060422                   : LstEnt
034400060422                   : %Size( LstEnt )
034500060422                   : 'DTLRCD'
034600060422                   : 'DTLLST'
034700060422                   : 'HNDL'
034800060422                   : 'Y'
034900060422                   : *Blanks
035000060422                   : Type5.LstEntHdl
035100060422                   : 'N'
035200060423                   : UIM.EntHdl
035300060422                   : ERRC0100
035400060422                   );
035500060422
035600060501          LstEnt.JobSts2 = 'Chg';
035700060422
035800060422          UpdLstEnt( Type5.AppHdl
035900060422                   : LstEnt
036000060422                   : %Size( LstEnt )
036100060422                   : 'DTLRCD'
036200060422                   : 'DTLLST'
036300060422                   : 'SAME'
036400060423                   : UIM.EntHdl
036500060422                   : ERRC0100
036600060422                   );
036700060422
036800060422        EndSr;
036900060423
037000060501        BegSr  HldLstEnt;
037100060501
037200060501          GetLstEnt( Type5.AppHdl
037300060501                   : LstEnt
037400060501                   : %Size( LstEnt )
037500060501                   : 'DTLRCD'
037600060501                   : 'DTLLST'
037700060501                   : 'HNDL'
037800060501                   : 'Y'
037900060501                   : *Blanks
038000060501                   : Type5.LstEntHdl
038100060501                   : 'N'
038200060501                   : UIM.EntHdl
038300060501                   : ERRC0100
038400060501                   );
038500060501
038600060501          LstEnt.JobSts2 = 'Hld';
038700060501
038800060501          UpdLstEnt( Type5.AppHdl
038900060501                   : LstEnt
039000060501                   : %Size( LstEnt )
039100060501                   : 'DTLRCD'
039200060501                   : 'DTLLST'
039300060501                   : 'SAME'
039400060501                   : UIM.EntHdl
039500060501                   : ERRC0100
039600060501                   );
039700060501
039800060501        EndSr;
039900060501
040000060517        BegSr  EndLstEnt;
040100060517
040200060517          GetLstEnt( Type5.AppHdl
040300060517                   : LstEnt
040400060517                   : %Size( LstEnt )
040500060517                   : 'DTLRCD'
040600060517                   : 'DTLLST'
040700060517                   : 'HNDL'
040800060517                   : 'Y'
040900060517                   : *Blanks
041000060517                   : Type5.LstEntHdl
041100060517                   : 'N'
041200060517                   : UIM.EntHdl
041300060517                   : ERRC0100
041400060517                   );
041500060517
041600060517          LstEnt.JobSts2 = 'End';
041700060517
041800060517          UpdLstEnt( Type5.AppHdl
041900060517                   : LstEnt
042000060517                   : %Size( LstEnt )
042100060517                   : 'DTLRCD'
042200060517                   : 'DTLLST'
042300060517                   : 'SAME'
042400060517                   : UIM.EntHdl
042500060517                   : ERRC0100
042600060517                   );
042700060517
042800060517        EndSr;
042900060501
043000060501        BegSr  RlsLstEnt;
043100060501
043200060501          GetLstEnt( Type5.AppHdl
043300060501                   : LstEnt
043400060501                   : %Size( LstEnt )
043500060501                   : 'DTLRCD'
043600060501                   : 'DTLLST'
043700060501                   : 'HNDL'
043800060501                   : 'Y'
043900060501                   : *Blanks
044000060501                   : Type5.LstEntHdl
044100060501                   : 'N'
044200060501                   : UIM.EntHdl
044300060501                   : ERRC0100
044400060501                   );
044500060501
044600060501          LstEnt.JobSts2 = 'Rls';
044700060501
044800060501          UpdLstEnt( Type5.AppHdl
044900060501                   : LstEnt
045000060501                   : %Size( LstEnt )
045100060501                   : 'DTLRCD'
045200060501                   : 'DTLLST'
045300060501                   : 'SAME'
045400060501                   : UIM.EntHdl
045500060501                   : ERRC0100
045600060501                   );
045700060501
045800060501        EndSr;
045900060511
046000051126      /End-Free
046100060327
046200060501     **-- Process command:  --------------------------------------------------**
046300060501     P PrcCmd          B                   Export
046400060501     D                 Pi             7a
046500060501     D  PxCmdStr                   1024a   Const  Varying
046600060501
046700060501     **-- Local variables:
046800060501     D CpOptCtlBlk     Ds
046900060501     D  CpTypPrc                     10i 0 Inz( 2 )
047000060501     D  CpDBCS                        1a   Inz( '0' )
047100060501     D  CpPmtAct                      1a   Inz( '2' )
047200060501     D  CpCmdStx                      1a   Inz( '0' )
047300060501     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
047400060501     D  CpRsv                         9a   Inz( *Allx'00' )
047500060501     **
047600060501     D CpChgCmd        s          32767a
047700060501     D CpChgCmdAvl     s             10i 0
047800060501
047900060501      /Free
048000060501
048100060501        PrcCmds( PxCmdStr
048200060501               : %Len( PxCmdStr )
048300060501               : CpOptCtlBlk
048400060501               : %Size( CpOptCtlBlk )
048500060501               : 'CPOP0100'
048600060501               : CpChgCmd
048700060501               : %Size( CpChgCmd )
048800060501               : CpChgCmdAvl
048900060501               : ERRC0100
049000060501               );
049100060501
049200060501        If  ERRC0100.BytAvl > *Zero;
049300060501          Return  ERRC0100.MsgId;
049400060501        Else;
049500060501          Return  *Blanks;
049600060501        EndIf;
049700060501
049800060501      /End-Free
049900060501
050000060501     P PrcCmd          E
050100060502     **-- Send completion message:
050200060502     P SndCmpMsg       B
050300060502     D                 Pi            10i 0
050400060502     D  PxMsgDta                    512a   Const  Varying
050500060502     **
050600060502     D MsgKey          s              4a
050700060502
050800060502      /Free
050900060502
051000060502        SndPgmMsg( 'CPF9897'
051100060502                 : 'QCPFMSG   *LIBL'
051200060502                 : PxMsgDta
051300060502                 : %Len( PxMsgDta )
051400060502                 : '*COMP'
051500060502                 : '*PGMBDY'
051600060502                 : 1
051700060502                 : MsgKey
051800060502                 : ERRC0100
051900060502                 );
052000060502
052100060502        If  ERRC0100.BytAvl > *Zero;
052200060502          Return  -1;
052300060502
052400060502        Else;
052500060502          Return  0;
052600060502
052700060502        EndIf;
052800060502
052900060502      /End-Free
053000060502
053100060502     **
053200060502     P SndCmpMsg       E
053300060327     **-- Send escape message:
053400060327     P SndEscMsg       B
053500060327     D                 Pi            10i 0
053600060327     D  PxMsgId                       7a   Const
053700060327     D  PxMsgF                       10a   Const
053800060327     D  PxMsgDta                    512a   Const  Varying
053900060327     **
054000060327     D MsgKey          s              4a
054100060327
054200060327      /Free
054300060327
054400060327        SndPgmMsg( PxMsgId
054500060327                 : PxMsgF + '*LIBL'
054600060327                 : PxMsgDta
054700060327                 : %Len( PxMsgDta )
054800060327                 : '*ESCAPE'
054900060327                 : '*PGMBDY'
055000060327                 : 1
055100060327                 : MsgKey
055200060327                 : ERRC0100
055300060327                 );
055400060327
055500060327        If  ERRC0100.BytAvl > *Zero;
055600060327          Return  -1;
055700060327
055800060327        Else;
055900060327          Return   0;
056000060327        EndIf;
056100060327
056200060327      /End-Free
056300060327
056400060327     P SndEscMsg       E
