000100041110     **
000200070429     **  Program . . : CBX970E
000300070502     **  Description : Work with Journal 2 - UIM Exit Program
000400060826     **  Author  . . : Carsten Flensburg
000500070429     **  Published . : System iNetwork Systems Management Tips Newsletter
000600060826     **
000700051202     **
000800051202     **
000900060328     **  Compile options:
001000070429     **    CrtRpgMod  Module( CBX970E )
001100060328     **               DbgView( *LIST )
001200060328     **
001300070429     **    CrtPgm     Pgm( CBX970E )
001400070429     **               Module( CBX970E )
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
004600060421
004700060311     **-- UIM API return structures:
004800060421     **-- UIM List entry:
004900060826     D  Option                        5i 0
005000070429     D  JrnPos                       20a
005100070429     D  JrnNam                       10a
005200070429     D  JrnLib                       10a
005300060826     D  UsrPrf                       10a
005400060826     D  PrtDev                       10a
005500060826     D  InlLibLst                     4a
005600060826     D  JobQueNam                    10a
005700060826     D  JobQueLib                    10a
005800060826     D  OutQueNam                    10a
005900060826     D  OutQueLib                    10a
006000060826     D  RqsDta                       32a
006100060826     D  RtgDta                       32a
006200060826     D  JobDscTxt                    50a
006300060311
006400060311     **-- UIM exit program interfaces:
006500060327     **-- Parm interface:
006600060327     D UimExit         Ds            70    Qualified
006700060327     D  StcLvl                       10i 0
006800060327     D                                8a
006900060327     D  TypCall                      10i 0
007000060327     D  AppHdl                        8a
007100060311     **-- Function key - call:
007200060311     D Type1           Ds                  Qualified
007300060311     D  StcLvl                       10i 0
007400060311     D                                8a
007500060311     D  TypCall                      10i 0
007600060311     D  AppHdl                        8a
007700060311     D  PnlNam                       10a
007800060311     D  FncKey                       10i 0
007900060421     **-- Action list option/Pull-down field choice:
008000060421     D Type5           Ds                  Qualified
008100060421     D  StcLvl                       10i 0
008200060421     D                                8a
008300060421     D  TypCall                      10i 0
008400060421     D  AppHdl                        8a
008500060421     D  PnlNam                       10a
008600060421     D  LstNam                       10a
008700060421     D  LstEntHdl                     4a
008800060421     D  OptNbr                       10i 0
008900060421     D  FncQlf                       10i 0
009000060421     D  ActRes                       10i 0
009100060421     D  PdwFldNam                    10a
009200060311
009300060421     **-- Remove list entry:
009400060421     D RmvLstEnt       Pr                  ExtPgm( 'QUIRMVLE' )
009500060421     D  AppHdl                        8a   Const
009600060421     D  LstNam                       10a   Const
009700060421     D  ExtOpt                        1a   Const
009800060421     D  LstEntHdl                     4a
009900060421     D  Error                     32767a          Options( *VarSize )
010000051129
010100040722     **-- Entry parameters:
010200070429     D CBX970E         Pr
010300060327     D  PxUimExit                          LikeDs( UimExit )
010400051129     **
010500070429     D CBX970E         Pi
010600060327     D  PxUimExit                          LikeDs( UimExit )
010700040721
010800040724      /Free
010900041224
011000060826          If  PxUimExit.TypCall = 5;
011100060421            Type5 = PxUimExit;
011200060327
011300060504            If  Type5.ActRes = RES_OK;
011400060504
011500060826              If  Type5.OptNbr = 4;
011600060504                ExSr  DltLstEnt;
011700060826              EndIf;
011800060504            EndIf;
011900060826          EndIf;
012000040728
012100040605        Return;
012200040721
012300060506
012400060423        BegSr  DltLstEnt;
012500060423
012600060423          RmvLstEnt( Type5.AppHdl
012700060423                   : 'DTLLST'
012800060423                   : 'Y'
012900060423                   : Type5.LstEntHdl
013000060423                   : ERRC0100
013100060423                   );
013200060423
013300060423        EndSr;
013400060422
013500051126      /End-Free
