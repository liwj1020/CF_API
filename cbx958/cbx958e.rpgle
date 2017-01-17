000100041110     **
000200060729     **  Program . . : CBX958E
000300060729     **  Description : Work with Netserver User - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500060729     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000060729     **    CrtRpgMod  Module( CBX958E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300060729     **    CrtPgm     Pgm( CBX958E )
001400060729     **               Module( CBX958E )
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
003700041120     **-- Global constants:
003800060327     D NULL            c                   ''
003900060327     D NO_ENT          c                   x'00000000'
004000060423     **-- UIM variables:
004100060423     D UIM             Ds                  Qualified
004200060423     D  EntHdl                        4a
004300060502     **-- UIM constants:
004400060504     D RES_OK          c                   0
004500060504     D RES_ERR         c                   1
004600060311
004700060729     **-- UIM List entry:
004800060729     D LstEnt          Ds                  Qualified
004900060729     D  Option                        5i 0
005000060729     D  NetUsr                       10a
005100060729     D  UsrSts                       10a
005200060729     D  UsrTxt                       50a
005300060311     **-- UIM exit program interfaces:
005400060327     **-- Parm interface:
005500060327     D UimExit         Ds            70    Qualified
005600060327     D  StcLvl                       10i 0
005700060327     D                                8a
005800060327     D  TypCall                      10i 0
005900060327     D  AppHdl                        8a
006000060421     **-- Action list option/Pull-down field choice:
006100060421     D Type5           Ds                  Qualified
006200060421     D  StcLvl                       10i 0
006300060421     D                                8a
006400060421     D  TypCall                      10i 0
006500060421     D  AppHdl                        8a
006600060421     D  PnlNam                       10a
006700060421     D  LstNam                       10a
006800060421     D  LstEntHdl                     4a
006900060421     D  OptNbr                       10i 0
007000060421     D  FncQlf                       10i 0
007100060421     D  ActRes                       10i 0
007200060421     D  PdwFldNam                    10a
007300060311
007400060729     **-- Get list entry:
007500060729     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
007600060729     D  AppHdl                        8a   Const
007700060729     D  VarBuf                    32767a   Const  Options( *VarSize )
007800060729     D  VarBufLen                    10i 0 Const
007900060729     D  VarRcdNam                    10a   Const
008000060729     D  LstNam                       10a   Const
008100060729     D  PosOpt                        4a   Const
008200060729     D  CpyOpt                        1a   Const
008300060729     D  SltCri                       20a   Const
008400060729     D  SltHdl                        4a   Const
008500060729     D  ExtOpt                        1a   Const
008600060729     D  LstEntHdl                     4a
008700060729     D  Error                     32767a          Options( *VarSize )
008800060729     **-- Update list entry:
008900060729     D UpdLstEnt       Pr                  ExtPgm( 'QUIUPDLE' )
009000060729     D  AppHdl                        8a   Const
009100060729     D  VarBuf                    32767a   Const  Options( *VarSize )
009200060729     D  VarBufLen                    10i 0 Const
009300060729     D  VarRcdNam                    10a   Const
009400060729     D  LstNam                       10a   Const
009500060729     D  Option                        4a   Const
009600060729     D  LstEntHdl                     4a
009700060729     D  Error                     32767a          Options( *VarSize )
009800060421     **-- Remove list entry:
009900060421     D RmvLstEnt       Pr                  ExtPgm( 'QUIRMVLE' )
010000060421     D  AppHdl                        8a   Const
010100060421     D  LstNam                       10a   Const
010200060421     D  ExtOpt                        1a   Const
010300060421     D  LstEntHdl                     4a
010400060421     D  Error                     32767a          Options( *VarSize )
010500051129
010600040722     **-- Entry parameters:
010700060729     D CBX958E         Pr
010800060327     D  PxUimExit                          LikeDs( UimExit )
010900051129     **
011000060729     D CBX958E         Pi
011100060327     D  PxUimExit                          LikeDs( UimExit )
011200040721
011300040724      /Free
011400041224
011500060729        If  PxUimExit.TypCall = 5;
011600060729          Type5 = PxUimExit;
011700060729
011800060729          If  Type5.ActRes = RES_OK;
011900060729
012000060729            If  Type5.OptNbr = 1;
012100060729              ExSr  ChgLstEnt;
012200060729            EndIf;
012300060729          EndIf;
012400060729        EndIf;
012500040728
012600040605        Return;
012700060506
012800060729
012900060729        BegSr  ChgLstEnt;
013000060729
013100060729          GetLstEnt( Type5.AppHdl
013200060729                   : LstEnt
013300060729                   : %Size( LstEnt )
013400060729                   : 'DTLRCD'
013500060729                   : 'DTLLST'
013600060729                   : 'HNDL'
013700060729                   : 'Y'
013800060729                   : *Blanks
013900060729                   : Type5.LstEntHdl
014000060729                   : 'N'
014100060729                   : UIM.EntHdl
014200060729                   : ERRC0100
014300060729                   );
014400060729
014500060729          LstEnt.UsrSts = '*ENABLED';
014600060729
014700060729          UpdLstEnt( Type5.AppHdl
014800060729                   : LstEnt
014900060729                   : %Size( LstEnt )
015000060729                   : 'DTLRCD'
015100060729                   : 'DTLLST'
015200060729                   : 'SAME'
015300060729                   : UIM.EntHdl
015400060729                   : ERRC0100
015500060729                   );
015600060729
015700060729        EndSr;
015800060729
015900060423        BegSr  DltLstEnt;
016000060423
016100060423          RmvLstEnt( Type5.AppHdl
016200060423                   : 'DTLLST'
016300060423                   : 'Y'
016400060423                   : Type5.LstEntHdl
016500060423                   : ERRC0100
016600060423                   );
016700060423
016800060423        EndSr;
016900060422
017000051126      /End-Free
