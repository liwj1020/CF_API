000100041110     **
000200061203     **  Program . . : CBX964E
000300061203     **  Description : Work with Server Shares - UIM Exit Program
000400060328     **  Author  . . : Carsten Flensburg
000500060729     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
000600051202     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000061203     **    CrtRpgMod  Module( CBX964E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300061203     **    CrtPgm     Pgm( CBX964E )
001400061203     **               Module( CBX964E )
001500060514     **               ActGrp( *CALLER )
001600031115     **
001700031115     **
001800040605     **-- Control specification:  --------------------------------------------**
001900060311     H Option( *SrcStmt )
002000040722
002100040728     **-- API error data structure:
002200040728     D ERRC0100        Ds                  Qualified
002300040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002400040728     D  BytAvl                       10i 0
002500041119     D  MsgId                         7a
002600040728     D                                1a
002700041119     D  MsgDta                      512a
002800060311
002900060502     **-- UIM constants:
003000060504     D RES_OK          c                   0
003100060504     D RES_ERR         c                   1
003200060311
003300060311     **-- UIM exit program interfaces:
003400060327     **-- Parm interface:
003500060327     D UimExit         Ds            70    Qualified
003600060327     D  StcLvl                       10i 0
003700060327     D                                8a
003800060327     D  TypCall                      10i 0
003900060327     D  AppHdl                        8a
004000060421     **-- Action list option/Pull-down field choice:
004100060421     D Type5           Ds                  Qualified
004200060421     D  StcLvl                       10i 0
004300060421     D                                8a
004400060421     D  TypCall                      10i 0
004500060421     D  AppHdl                        8a
004600060421     D  PnlNam                       10a
004700060421     D  LstNam                       10a
004800060421     D  LstEntHdl                     4a
004900060421     D  OptNbr                       10i 0
005000060421     D  FncQlf                       10i 0
005100060421     D  ActRes                       10i 0
005200060421     D  PdwFldNam                    10a
005300060311
005400060421     **-- Remove list entry:
005500060421     D RmvLstEnt       Pr                  ExtPgm( 'QUIRMVLE' )
005600060421     D  AppHdl                        8a   Const
005700060421     D  LstNam                       10a   Const
005800060421     D  ExtOpt                        1a   Const
005900060421     D  LstEntHdl                     4a
006000060421     D  Error                     32767a          Options( *VarSize )
006100051129
006200040722     **-- Entry parameters:
006300061106     D CBX964E         Pr
006400060327     D  PxUimExit                          LikeDs( UimExit )
006500051129     **
006600061106     D CBX964E         Pi
006700060327     D  PxUimExit                          LikeDs( UimExit )
006800040721
006900040724      /Free
007000041224
007100060729        If  PxUimExit.TypCall = 5;
007200060729          Type5 = PxUimExit;
007300060729
007400060729          If  Type5.ActRes = RES_OK;
007500060729
007600061109            If  Type5.OptNbr = 4;
007700061109              ExSr  DltLstEnt;
007800060729            EndIf;
007900060729          EndIf;
008000060729        EndIf;
008100040728
008200040605        Return;
008300060506
008400060729
008500060423        BegSr  DltLstEnt;
008600060423
008700060423          RmvLstEnt( Type5.AppHdl
008800060423                   : 'DTLLST'
008900060423                   : 'Y'
009000060423                   : Type5.LstEntHdl
009100060423                   : ERRC0100
009200060423                   );
009300060423
009400060423        EndSr;
009500060422
009600051126      /End-Free
