000100041110     **
000200070101     **  Program . . : CBX965E
000300061116     **  Description : Display User Jobs - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500070101     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070101     **    CrtRpgMod  Module( CBX965E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070101     **    CrtPgm     Pgm( CBX965E )
001400070101     **               Module( CBX965E )
001500070101     **               ActGrp( *CALLER )
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
005600061116     D SPLF_USRDTA     c                   'DSPUSRJOB'
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
010700060311
010800060502     **-- Print panel:
010900060502     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
011000060502     D  AppHdl                        8a   Const
011100060502     D  PrtPnlNam                    10a   Const
011200060502     D  EjtOpt                        1a   Const
011300060502     D  Error                     32767a          Options( *VarSize )
011400060502     **-- Add print application:
011500060502     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
011600060502     D  AppHdl                        8a   Const
011700060502     D  PrtDevF_q                    20a   Const
011800060502     D  AltFilNam                    10a   Const
011900060502     D  ShrOpnDtaPth                  1a   Const
012000060502     D  UsrDta                       10a   Const
012100060502     D  Error                     32767a          Options( *VarSize )
012200060502     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
012300060502     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
012400060502     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
012500060502     **-- Remove print application:
012600060502     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
012700060502     D  AppHdl                        8a   Const
012800060502     D  CloOpt                        1a   Const
012900060502     D  Error                     32767a          Options( *VarSize )
013000060501
013100060327     **-- Send program message:
013200060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
013300060327     D  MsgId                         7a   Const
013400060327     D  MsgFq                        20a   Const
013500060327     D  MsgDta                      128a   Const
013600060327     D  MsgDtaLen                    10i 0 Const
013700060327     D  MsgTyp                       10a   Const
013800060327     D  CalStkE                      10a   Const  Options( *VarSize )
013900060327     D  CalStkCtr                    10i 0 Const
014000060327     D  MsgKey                        4a
014100060327     D  Error                     32767a          Options( *VarSize )
014200060327
014300060502     **-- Send completion message:
014400060502     D SndCmpMsg       Pr            10i 0
014500060502     D  PxMsgDta                    512a   Const  Varying
014600051129
014700040722     **-- Entry parameters:
014800070101     D CBX965E         Pr
014900060327     D  PxUimExit                          LikeDs( UimExit )
015000051129     **
015100070101     D CBX965E         Pi
015200060327     D  PxUimExit                          LikeDs( UimExit )
015300040721
015400040724      /Free
015500041224
015600061116          If  PxUimExit.TypCall = 1;
015700060501            Type1 = PxUimExit;
015800060501
015900061116            If  Type1.FncKey = 21;
016000060502              ExSr  PrtJobPnl;
016100061116            EndIf;
016200061116          EndIf;
016300040728
016400040605        Return;
016500040721
016600060502
016700060502        BegSr  PrtJobPnl;
016800060502
016900060502          AddPrtApp( Type1.AppHdl
017000060502                   : APP_PRTF
017100060502                   : SPLF_NAM
017200060502                   : ODP_SHR
017300060502                   : SPLF_USRDTA
017400060502                   : ERRC0100
017500060502                   );
017600060502
017700060502          PrtPnl( Type1.AppHdl
017800060502                : 'PRTHDR'
017900060502                : EJECT_NO
018000060502                : ERRC0100
018100060502                );
018200060502
018300060502          PrtPnl( Type1.AppHdl
018400060502                : 'PRTLST'
018500060502                : EJECT_NO
018600060502                : ERRC0100
018700060502                );
018800060502
018900060502          RmvPrtApp( Type1.AppHdl
019000060502                   : CLO_NRM
019100060502                   : ERRC0100
019200060502                   );
019300060502
019400060502          SndCmpMsg( 'List has been printed.' );
019500060502
019600060508        EndSr;
019700060511
019800051126      /End-Free
019900060327
020000060502     **-- Send completion message:
020100060502     P SndCmpMsg       B
020200060502     D                 Pi            10i 0
020300060502     D  PxMsgDta                    512a   Const  Varying
020400060502     **
020500060502     D MsgKey          s              4a
020600060502
020700060502      /Free
020800060502
020900060502        SndPgmMsg( 'CPF9897'
021000060502                 : 'QCPFMSG   *LIBL'
021100060502                 : PxMsgDta
021200060502                 : %Len( PxMsgDta )
021300060502                 : '*COMP'
021400060502                 : '*PGMBDY'
021500060502                 : 1
021600060502                 : MsgKey
021700060502                 : ERRC0100
021800060502                 );
021900060502
022000060502        If  ERRC0100.BytAvl > *Zero;
022100060502          Return  -1;
022200060502
022300060502        Else;
022400060502          Return  0;
022500060502
022600060502        EndIf;
022700060502
022800060502      /End-Free
022900060502
023000060502     **
023100060502     P SndCmpMsg       E
