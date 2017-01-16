000100041110     **
000200070128     **  Program . . : CBX967E
000300070128     **  Description : Display Subsystem Job Queues - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500070128     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070128     **    CrtRpgMod  Module( CBX967E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070128     **    CrtPgm     Pgm( CBX967E )
001400070128     **               Module( CBX967E )
001500070128     **               ActGrp( *CALLER )
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
004600060505     D SPLF_NAM        c                   'PSBSJOBQ'
004700061114     D SPLF_USRDTA     c                   'DSPSBSJOBQ'
004800060502     D EJECT_NO        c                   'N'
004900060502     D CLO_NRM         c                   'M'
005000060504     D RES_OK          c                   0
005100060504     D RES_ERR         c                   1
005200060311
005300060311     **-- UIM exit program interfaces:
005400060327     **-- Parm interface:
005500060327     D UimExit         Ds            70    Qualified
005600060327     D  StcLvl                       10i 0
005700060327     D                                8a
005800060327     D  TypCall                      10i 0
005900060327     D  AppHdl                        8a
006000060311     **-- Function key - call:
006100060311     D Type1           Ds                  Qualified
006200060311     D  StcLvl                       10i 0
006300060311     D                                8a
006400060311     D  TypCall                      10i 0
006500060311     D  AppHdl                        8a
006600060311     D  PnlNam                       10a
006700060311     D  FncKey                       10i 0
006800060311
006900060502     **-- Print panel:
007000060502     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
007100060502     D  AppHdl                        8a   Const
007200060502     D  PrtPnlNam                    10a   Const
007300060502     D  EjtOpt                        1a   Const
007400060502     D  Error                     32767a          Options( *VarSize )
007500060502     **-- Add print application:
007600060502     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
007700060502     D  AppHdl                        8a   Const
007800060502     D  PrtDevF_q                    20a   Const
007900060502     D  AltFilNam                    10a   Const
008000060502     D  ShrOpnDtaPth                  1a   Const
008100060502     D  UsrDta                       10a   Const
008200060502     D  Error                     32767a          Options( *VarSize )
008300060502     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
008400060502     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
008500060502     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
008600060502     **-- Remove print application:
008700060502     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
008800060502     D  AppHdl                        8a   Const
008900060502     D  CloOpt                        1a   Const
009000060502     D  Error                     32767a          Options( *VarSize )
009100060501
009200060327     **-- Send program message:
009300060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
009400060327     D  MsgId                         7a   Const
009500060327     D  MsgFq                        20a   Const
009600060327     D  MsgDta                      128a   Const
009700060327     D  MsgDtaLen                    10i 0 Const
009800060327     D  MsgTyp                       10a   Const
009900060327     D  CalStkE                      10a   Const  Options( *VarSize )
010000060327     D  CalStkCtr                    10i 0 Const
010100060327     D  MsgKey                        4a
010200060327     D  Error                     32767a          Options( *VarSize )
010300060327
010400060502     **-- Send completion message:
010500060502     D SndCmpMsg       Pr            10i 0
010600060502     D  PxMsgDta                    512a   Const  Varying
010700051129
010800040722     **-- Entry parameters:
010900070128     D CBX967E         Pr
011000060327     D  PxUimExit                          LikeDs( UimExit )
011100051129     **
011200070128     D CBX967E         Pi
011300060327     D  PxUimExit                          LikeDs( UimExit )
011400040721
011500040724      /Free
011600041224
011700061114        If  PxUimExit.TypCall = 1;
011800061114          Type1 = PxUimExit;
011900061114
012000061114          If  Type1.FncKey = 21;
012100061114            ExSr  PrtJobPnl;
012200061114          EndIf;
012300061114        EndIf;
012400040728
012500040605        Return;
012600040721
012700060422
012800060502        BegSr  PrtJobPnl;
012900060502
013000060502          AddPrtApp( Type1.AppHdl
013100060502                   : APP_PRTF
013200060502                   : SPLF_NAM
013300060502                   : ODP_SHR
013400060502                   : SPLF_USRDTA
013500060502                   : ERRC0100
013600060502                   );
013700060502
013800060502          PrtPnl( Type1.AppHdl
013900060502                : 'PRTHDR'
014000060502                : EJECT_NO
014100060502                : ERRC0100
014200060502                );
014300060502
014400060502          PrtPnl( Type1.AppHdl
014500060502                : 'PRTLST'
014600060502                : EJECT_NO
014700060502                : ERRC0100
014800060502                );
014900060502
015000060502          RmvPrtApp( Type1.AppHdl
015100060502                   : CLO_NRM
015200060502                   : ERRC0100
015300060502                   );
015400060502
015500060502          SndCmpMsg( 'List has been printed.' );
015600060502
015700060502        EndSr;
015800060422
015900051126      /End-Free
016000060327
016100060502     **-- Send completion message:
016200060502     P SndCmpMsg       B
016300060502     D                 Pi            10i 0
016400060502     D  PxMsgDta                    512a   Const  Varying
016500060502     **
016600060502     D MsgKey          s              4a
016700060502
016800060502      /Free
016900060502
017000060502        SndPgmMsg( 'CPF9897'
017100060502                 : 'QCPFMSG   *LIBL'
017200060502                 : PxMsgDta
017300060502                 : %Len( PxMsgDta )
017400060502                 : '*COMP'
017500060502                 : '*PGMBDY'
017600060502                 : 1
017700060502                 : MsgKey
017800060502                 : ERRC0100
017900060502                 );
018000060502
018100060502        If  ERRC0100.BytAvl > *Zero;
018200060502          Return  -1;
018300060502
018400060502        Else;
018500060502          Return  0;
018600060502
018700060502        EndIf;
018800060502
018900060502      /End-Free
019000060502
019100060502     **
019200060502     P SndCmpMsg       E
