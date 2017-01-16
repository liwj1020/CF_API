000100041110     **
000200070123     **  Program . . : CBX968E
000300061114     **  Description : Display Job Queue Jobs - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500070211     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070123     **    CrtRpgMod  Module( CBX968E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070123     **    CrtPgm     Pgm( CBX968E )
001400070123     **               Module( CBX968E )
001500060518     **               ActGrp( *CALLER )
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
004000060423     **-- UIM variables:
004100060423     D UIM             Ds                  Qualified
004200060423     D  EntHdl                        4a
004300060502     **-- UIM constants:
004400060502     D APP_PRTF        c                   'QPRINT    *LIBL'
004500060502     D ODP_SHR         c                   'N'
004600060502     D SPLF_NAM        c                   'PJOBQJOB'
004700061114     D SPLF_USRDTA     c                   'DSPJOBQJOB'
004800060502     D EJECT_NO        c                   'N'
004900060502     D CLO_NRM         c                   'M'
005000060504     D RES_OK          c                   0
005100060504     D RES_ERR         c                   1
005200060421
005300131107     **-- UIM List entry:
005400131107     D LstEnt          Ds                  Qualified
005500131107     D  Option                        5i 0
005600131107     D  JobId                        26a
005700131107     D  JobNam_q                     26a
005800131107     D   JobNam                      10a   Overlay( JobNam_q:  1 )
005900131107     D   JobUsr                      10a   Overlay( JobNam_q: 11 )
006000131107     D   JobNbr                       6s 0 Overlay( JobNam_q: 21 )
006100131107     D  JobTyp                        1a
006200131107     D  JobSts1                       7a
006300131107     D  JobSts2                       7a
006400131107     D  JobPty                        2a
006500131107     D  EntDat                        7a
006600131107     D  EntTim                        6a
006700131107     D  CurUsr                       10a
006800131107     D  SbmJob                       10a
006900131107     D  SbmUsr                       10a
007000131107     D  SbmNbr                        6s 0
007100131107     D  MsgRpy                        1a
007200131107     D  MsgQue_q                     20a
007300131107     D   MsgQueNam                   10a   Overlay( MsgQue_q:  1 )
007400131107     D   MsgQueLib                   10a   Overlay( MsgQue_q: 11 )
007500131107     D  MsgKey                        4a
007600131107
007700060311     **-- UIM exit program interfaces:
007800060327     **-- Parm interface:
007900060327     D UimExit         Ds            70    Qualified
008000060327     D  StcLvl                       10i 0
008100060327     D                                8a
008200060327     D  TypCall                      10i 0
008300060327     D  AppHdl                        8a
008400060311     **-- Function key - call:
008500060311     D Type1           Ds                  Qualified
008600060311     D  StcLvl                       10i 0
008700060311     D                                8a
008800060311     D  TypCall                      10i 0
008900060311     D  AppHdl                        8a
009000060311     D  PnlNam                       10a
009100060311     D  FncKey                       10i 0
009200131107     **-- Action list option/Pull-down field choice - call (type 3/9):
009300131107     D Type3           Ds                  Qualified
009400131107     D  StcLvl                       10i 0
009500131107     D                                8a
009600131107     D  TypCall                      10i 0
009700131107     D  AppHdl                        8a
009800131107     D  PnlNam                       10a
009900131107     D  LstNam                       10a
010000131107     D  LstEntHdl                     4a
010100131107     D  OptNbr                       10i 0
010200131107     D  FncQlf                       10i 0
010300131107     D  PdwFldNam                    10a
010400060311
010500131107     **-- Get list entry:
010600131107     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
010700131107     D  AppHdl                        8a   Const
010800131107     D  VarBuf                    32767a   Const  Options( *VarSize )
010900131107     D  VarBufLen                    10i 0 Const
011000131107     D  VarRcdNam                    10a   Const
011100131107     D  LstNam                       10a   Const
011200131107     D  PosOpt                        4a   Const
011300131107     D  CpyOpt                        1a   Const
011400131107     D  SltCri                       20a   Const
011500131107     D  SltHdl                        4a   Const
011600131107     D  ExtOpt                        1a   Const
011700131107     D  LstEntHdl                     4a
011800131107     D  Error                     32767a          Options( *VarSize )
011900060502     **-- Print panel:
012000060502     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
012100060502     D  AppHdl                        8a   Const
012200060502     D  PrtPnlNam                    10a   Const
012300060502     D  EjtOpt                        1a   Const
012400060502     D  Error                     32767a          Options( *VarSize )
012500060502     **-- Add print application:
012600060502     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
012700060502     D  AppHdl                        8a   Const
012800060502     D  PrtDevF_q                    20a   Const
012900060502     D  AltFilNam                    10a   Const
013000060502     D  ShrOpnDtaPth                  1a   Const
013100060502     D  UsrDta                       10a   Const
013200060502     D  Error                     32767a          Options( *VarSize )
013300060502     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
013400060502     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
013500060502     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
013600060502     **-- Remove print application:
013700060502     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
013800060502     D  AppHdl                        8a   Const
013900060502     D  CloOpt                        1a   Const
014000060502     D  Error                     32767a          Options( *VarSize )
014100060501
014200060327     **-- Send program message:
014300060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
014400060327     D  MsgId                         7a   Const
014500060327     D  MsgFq                        20a   Const
014600060327     D  MsgDta                      128a   Const
014700060327     D  MsgDtaLen                    10i 0 Const
014800060327     D  MsgTyp                       10a   Const
014900060327     D  CalStkE                      10a   Const  Options( *VarSize )
015000060327     D  CalStkCtr                    10i 0 Const
015100060327     D  MsgKey                        4a
015200060327     D  Error                     32767a          Options( *VarSize )
015300131107
015400131107     **-- Additional message information:
015500131107     D CBX209          Pr                  ExtPgm( 'CBX209' )
015600131107     D  MsqNam_q                     20a
015700131107     D  MsqKey                        4a
015800060327
015900131107     **-- Send escape message:
016000131107     D SndEscMsg       Pr            10i 0
016100131107     D  PxMsgId                       7a   Const
016200131107     D  PxMsgF                       10a   Const
016300131107     D  PxMsgDta                    512a   Const  Varying
016400060502     **-- Send completion message:
016500060502     D SndCmpMsg       Pr            10i 0
016600060502     D  PxMsgDta                    512a   Const  Varying
016700051129
016800040722     **-- Entry parameters:
016900070123     D CBX968E         Pr
017000060327     D  PxUimExit                          LikeDs( UimExit )
017100051129     **
017200070123     D CBX968E         Pi
017300060327     D  PxUimExit                          LikeDs( UimExit )
017400040721
017500040724      /Free
017600041224
017700131107          Select;
017800131107          When  PxUimExit.TypCall = 1;
017900060501            Type1 = PxUimExit;
018000060501
018100061114            If  Type1.FncKey = 21;
018200060502              ExSr  PrtJobPnl;
018300061114            EndIf;
018400131107
018500131107          When  PxUimExit.TypCall = 3;
018600131107            Type3 = PxUimExit;
018700131107
018800131107            If  Type3.OptNbr = 7;
018900131107              ExSr  DspMsgInf;
019000131107            EndIf;
019100131107          EndSl;
019200040728
019300040605        Return;
019400060501
019500060502
019600060502        BegSr  PrtJobPnl;
019700060502
019800060502          AddPrtApp( Type1.AppHdl
019900060502                   : APP_PRTF
020000060502                   : SPLF_NAM
020100060502                   : ODP_SHR
020200060502                   : SPLF_USRDTA
020300060502                   : ERRC0100
020400060502                   );
020500060502
020600060502          PrtPnl( Type1.AppHdl
020700060502                : 'PRTHDR'
020800060502                : EJECT_NO
020900060502                : ERRC0100
021000060502                );
021100060502
021200060502          PrtPnl( Type1.AppHdl
021300060502                : 'PRTLST'
021400060502                : EJECT_NO
021500060502                : ERRC0100
021600060502                );
021700060502
021800060502          RmvPrtApp( Type1.AppHdl
021900060502                   : CLO_NRM
022000060502                   : ERRC0100
022100060502                   );
022200060502
022300060502          SndCmpMsg( 'List has been printed.' );
022400060502
022500060508        EndSr;
022600060422
022700131107        BegSr  DspMsgInf;
022800131107
022900131107          GetLstEnt( Type3.AppHdl
023000131107                   : LstEnt
023100131107                   : %Size( LstEnt )
023200131107                   : 'DTLRCD'
023300131107                   : 'DTLLST'
023400131107                   : 'HNDL'
023500131107                   : 'Y'
023600131107                   : *Blanks
023700131107                   : Type3.LstEntHdl
023800131107                   : 'N'
023900131107                   : UIM.EntHdl
024000131107                   : ERRC0100
024100131107                   );
024200131107
024300131107          Select;
024400131107          When  LstEnt.MsgRpy = '2';
024500131107            SndEscMsg( 'CPI1150': 'QCPFMSG': LstEnt.JobNam_q + LstEnt.MsgQue_q);
024600131107
024700131107          When  LstEnt.MsgKey = *Blanks;
024800131107            SndEscMsg( 'CPD1201': 'QCPFMSG': LstEnt.JobNam_q );
024900131107
025000131107          When  LstEnt.MsgKey = *Allx'00';
025100131107            SndEscMsg( 'CPD1201': 'QCPFMSG': LstEnt.JobNam_q );
025200131107
025300131107          Other;
025400131107            CBX209( LstEnt.MsgQue_q: LstEnt.MsgKey );
025500131107          EndSl;
025600131107
025700131107        EndSr;
025800131107
025900051126      /End-Free
026000060327
026100131107     **-- Send escape message:
026200131107     P SndEscMsg       B
026300131107     D                 Pi            10i 0
026400131107     D  PxMsgId                       7a   Const
026500131107     D  PxMsgF                       10a   Const
026600131107     D  PxMsgDta                    512a   Const  Varying
026700131107     **
026800131107     D MsgKey          s              4a
026900131107
027000131107      /Free
027100131107
027200131107        SndPgmMsg( PxMsgId
027300131107                 : PxMsgF + '*LIBL'
027400131107                 : PxMsgDta
027500131107                 : %Len( PxMsgDta )
027600131107                 : '*ESCAPE'
027700131107                 : '*PGMBDY'
027800131107                 : 1
027900131107                 : MsgKey
028000131107                 : ERRC0100
028100131107                 );
028200131107
028300131107        If  ERRC0100.BytAvl > *Zero;
028400131107          Return  -1;
028500131107
028600131107        Else;
028700131107          Return   0;
028800131107        EndIf;
028900131107
029000131107      /End-Free
029100131107
029200131107     P SndEscMsg       E
029300060502     **-- Send completion message:
029400060502     P SndCmpMsg       B
029500060502     D                 Pi            10i 0
029600060502     D  PxMsgDta                    512a   Const  Varying
029700060502     **
029800060502     D MsgKey          s              4a
029900060502
030000060502      /Free
030100060502
030200060502        SndPgmMsg( 'CPF9897'
030300060502                 : 'QCPFMSG   *LIBL'
030400060502                 : PxMsgDta
030500060502                 : %Len( PxMsgDta )
030600060502                 : '*COMP'
030700060502                 : '*PGMBDY'
030800060502                 : 1
030900060502                 : MsgKey
031000060502                 : ERRC0100
031100060502                 );
031200060502
031300060502        If  ERRC0100.BytAvl > *Zero;
031400060502          Return  -1;
031500060502
031600060502        Else;
031700060502          Return  0;
031800060502
031900060502        EndIf;
032000060502
032100060502      /End-Free
032200060502
032300060502     **
032400060502     P SndCmpMsg       E
