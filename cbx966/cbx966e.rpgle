000100041110     **
000200070125     **  Program . . : CBX966E
000300061122     **  Description : Display Subsystem Activity - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500070102     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070102     **    CrtRpgMod  Module( CBX966E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070102     **    CrtPgm     Pgm( CBX966E )
001400070102     **               Module( CBX966E )
001500060514     **               ActGrp( *CALLER )
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
003700060502     **-- UIM constants:
003800060502     D APP_PRTF        c                   'QPRINT    *LIBL'
003900060502     D ODP_SHR         c                   'N'
004000060506     D SPLF_NAM        c                   'PSBSACT'
004100061122     D SPLF_USRDTA     c                   'DSPSBSACT'
004200060502     D EJECT_NO        c                   'N'
004300060502     D CLO_NRM         c                   'M'
004400060311
004500060311     **-- UIM exit program interfaces:
004600060327     **-- Parm interface:
004700060327     D UimExit         Ds            70    Qualified
004800060327     D  StcLvl                       10i 0
004900060327     D                                8a
005000060327     D  TypCall                      10i 0
005100060327     D  AppHdl                        8a
005200060311     **-- Function key - call:
005300060311     D Type1           Ds                  Qualified
005400060311     D  StcLvl                       10i 0
005500060311     D                                8a
005600060311     D  TypCall                      10i 0
005700060311     D  AppHdl                        8a
005800060311     D  PnlNam                       10a
005900060311     D  FncKey                       10i 0
006000060311
006100060502     **-- Print panel:
006200060502     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
006300060502     D  AppHdl                        8a   Const
006400060502     D  PrtPnlNam                    10a   Const
006500060502     D  EjtOpt                        1a   Const
006600060502     D  Error                     32767a          Options( *VarSize )
006700060502     **-- Add print application:
006800060502     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
006900060502     D  AppHdl                        8a   Const
007000060502     D  PrtDevF_q                    20a   Const
007100060502     D  AltFilNam                    10a   Const
007200060502     D  ShrOpnDtaPth                  1a   Const
007300060502     D  UsrDta                       10a   Const
007400060502     D  Error                     32767a          Options( *VarSize )
007500060502     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
007600060502     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
007700060502     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
007800060502     **-- Remove print application:
007900060502     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
008000060502     D  AppHdl                        8a   Const
008100060502     D  CloOpt                        1a   Const
008200060502     D  Error                     32767a          Options( *VarSize )
008300060501
008400060501     **-- Process commands:
008500060501     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
008600060501     D  SrcCmd                    32702a   Const  Options( *VarSize )
008700060501     D  SrcCmdLen                    10i 0 Const
008800060501     D  OptCtlBlk                    20a   Const
008900060501     D  OptCtlBlkLn                  10i 0 Const
009000060501     D  OptCtlBlkFm                   8a   Const
009100060501     D  ChgCmd                    32767a          Options( *VarSize )
009200060501     D  ChgCmdLen                    10i 0 Const
009300060501     D  ChgCmdLenAv                  10i 0
009400060501     D  Error                     32767a          Options( *VarSize )
009500060327     **-- Send program message:
009600060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
009700060327     D  MsgId                         7a   Const
009800060327     D  MsgFq                        20a   Const
009900060327     D  MsgDta                      128a   Const
010000060327     D  MsgDtaLen                    10i 0 Const
010100060327     D  MsgTyp                       10a   Const
010200060327     D  CalStkE                      10a   Const  Options( *VarSize )
010300060327     D  CalStkCtr                    10i 0 Const
010400060327     D  MsgKey                        4a
010500060327     D  Error                     32767a          Options( *VarSize )
010600060327
010700060501     **-- Process command:
010800060501     D PrcCmd          Pr             7a
010900060501     D  CmdStr                     1024a   Const  Varying
011000060502     **-- Send completion message:
011100060502     D SndCmpMsg       Pr            10i 0
011200060502     D  PxMsgDta                    512a   Const  Varying
011300060327     **-- Send escape message:
011400060327     D SndEscMsg       Pr            10i 0
011500060327     D  PxMsgId                       7a   Const
011600060327     D  PxMsgF                       10a   Const
011700060327     D  PxMsgDta                    512a   Const  Varying
011800051129
011900040722     **-- Entry parameters:
012000070102     D CBX966E         Pr
012100060327     D  PxUimExit                          LikeDs( UimExit )
012200051129     **
012300070102     D CBX966E         Pi
012400060327     D  PxUimExit                          LikeDs( UimExit )
012500040721
012600040724      /Free
012700041224
012800061122          If  PxUimExit.TypCall = 1;
012900060501            Type1 = PxUimExit;
013000060501
013100060505            If  Type1.FncKey = 21;
013200060502              ExSr  PrtJobPnl;
013300060505            EndIf;
013400061122          EndIf;
013500040728
013600040605        Return;
013700040721
013800060422
013900060502        BegSr  PrtJobPnl;
014000060502
014100060502          AddPrtApp( Type1.AppHdl
014200060502                   : APP_PRTF
014300060502                   : SPLF_NAM
014400060502                   : ODP_SHR
014500060502                   : SPLF_USRDTA
014600060502                   : ERRC0100
014700060502                   );
014800060502
014900060502          PrtPnl( Type1.AppHdl
015000060502                : 'PRTHDR'
015100060502                : EJECT_NO
015200060502                : ERRC0100
015300060502                );
015400060502
015500060502          PrtPnl( Type1.AppHdl
015600060502                : 'PRTLST'
015700060502                : EJECT_NO
015800060502                : ERRC0100
015900060502                );
016000060502
016100060502          RmvPrtApp( Type1.AppHdl
016200060502                   : CLO_NRM
016300060502                   : ERRC0100
016400060502                   );
016500060502
016600060502          SndCmpMsg( 'List has been printed.' );
016700060502
016800060502        EndSr;
016900060422
017000051126      /End-Free
017100060327
017200060502     **-- Send completion message:
017300060502     P SndCmpMsg       B
017400060502     D                 Pi            10i 0
017500060502     D  PxMsgDta                    512a   Const  Varying
017600060502     **
017700060502     D MsgKey          s              4a
017800060502
017900060502      /Free
018000060502
018100060502        SndPgmMsg( 'CPF9897'
018200060502                 : 'QCPFMSG   *LIBL'
018300060502                 : PxMsgDta
018400060502                 : %Len( PxMsgDta )
018500060502                 : '*COMP'
018600060502                 : '*PGMBDY'
018700060502                 : 1
018800060502                 : MsgKey
018900060502                 : ERRC0100
019000060502                 );
019100060502
019200060502        If  ERRC0100.BytAvl > *Zero;
019300060502          Return  -1;
019400060502
019500060502        Else;
019600060502          Return  0;
019700060502
019800060502        EndIf;
019900060502
020000060502      /End-Free
020100060502
020200060502     **
020300060502     P SndCmpMsg       E
