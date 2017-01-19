000100041201     **
000200050210     **  Program . . : CBX929
000300050209     **  Description : Retrieve user special authority - CPP
000400041201     **  Author  . . : Carsten Flensburg
000500041201     **
000600041201     **
000700050211     **  Compile instructions:
000800050210     **    CrtRpgMod   Module( CBX929 )
000900041201     **                DbgView( *NONE )
001000041201     **                Aut( *USE )
001100041201     **
001200050210     **    CrtPgm      Pgm( CBX929 )
001300050210     **                Module( CBX929 )
001400041201     **                ActGrp( *NEW )
001500041201     **                UsrPrf( *OWNER )
001600041201     **                Aut( *USE )
001700041201     **
001800041201     **
001900040723     **-- Control specification:  --------------------------------------------**
002000041201     H Option( *SrcStmt )
002100040723
002200050209     **-- Global constants:
002300050209     D OFS_MSGDTA      c                   16
002400050212     D MAX_SUPGRP      c                   15
002500050212     D MAX_SPCAUT      c                   15
002600050212     **-- Global variables:
002700050212     D AccSpcAut       s              1a   Dim( MAX_SPCAUT )
002800050212     D Idx             s             10i 0
002900041201
003000040723     **-- API error data structure:
003100040723     D ERRC0100        Ds                  Qualified
003200040723     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003300040723     D  BytAvl                       10i 0
003400041201     D  MsgId                         7a
003500040723     D                                1a
003600041201     D  MsgDta                      512a
003700050209     **-- User information structure:
003800050209     D USRI0200        Ds           512    Qualified
003900050209     D  BytRtn                       10i 0
004000050209     D  BytAvl                       10i 0
004100050209     D  UsrPrf                       10a
004200050212     D  SpcAut                        1a   Overlay( USRI0200: 29 )
004300050212     D                                     Dim( MAX_SPCAUT )
004400050209     D  GrpPrf                       10a   Overlay( USRI0200: 44 )
004500050209     D  SupGrpOfs                    10i 0 Overlay( USRI0200: 97 )
004600050209     D  SupGrpNbr                    10i 0 Overlay( USRI0200: 101 )
004700050209     **
004800050212     D SupGrpPrf       s             10a   Based( pSupGrpPrf )
004900050212     D                                     Dim( MAX_SUPGRP )
005000040723
005100050209     **-- Retrieve user information:
005200050209     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
005300050209     D  RuRcvVar                  32767a          Options( *VarSize )
005400050209     D  RuRcvVarLen                  10i 0 Const
005500050209     D  RuFmtNam                     10a   Const
005600050209     D  RuUsrPrf                     10a   Const
005700050209     D  RuError                   32767a          Options( *VarSize )
005800041201     **-- Send program message:
005900041201     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
006000041201     D  SpMsgId                       7a   Const
006100041201     D  SpMsgFq                      20a   Const
006200041201     D  SpMsgDta                    128a   Const
006300041201     D  SpMsgDtaLen                  10i 0 Const
006400041201     D  SpMsgTyp                     10a   Const
006500041201     D  SpCalStkE                    10a   Const  Options( *VarSize )
006600041201     D  SpCalStkCtr                  10i 0 Const
006700041201     D  SpMsgKey                      4a
006800041201     D  SpError                    1024a          Options( *VarSize )
006900041201
007000050210     **-- Add special authority:
007100050212     D AddSpcAut       Pr             1a   Dim( MAX_SPCAUT )
007200050212     D  PxSpcAut1                     1a   Dim( MAX_SPCAUT )  Value
007300050212     D  PxSpcAut2                     1a   Dim( MAX_SPCAUT )  Value
007400050210     **-- Get special authority:
007500050212     D GetSpcAut       Pr             1a   Dim( MAX_SPCAUT )
007600050210     D  PxUsrPrf                     10a   Value
007700050210     **-- Format special authority:
007800050212     D FmtSpcAut       Pr            10a   Dim( MAX_SPCAUT )
007900050212     D  PxSpcAut                      1a   Dim( MAX_SPCAUT )  Value
008000050210     **-- Send escape message:
008100050210     D SndEscMsg       Pr            10i 0
008200050210     D  PxMsgId                       7a   Const
008300050210     D  PxMsgF                       10a   Const
008400050210     D  PxMsgDta                    512a   Const  Varying
008500040727
008600050210     D CBX929          Pr
008700041201     D  PxUsrPrf                     10a
008800050209     D  PxOption                     10a
008900050212     D  PxSpcAut                     10a   Dim( MAX_SPCAUT )
009000041201     **
009100050210     D CBX929          Pi
009200041201     D  PxUsrPrf                     10a
009300050209     D  PxOption                     10a
009400050212     D  PxSpcAut                     10a   Dim( MAX_SPCAUT )
009500040723
009600040723      /Free
009700040723
009800050209        RtvUsrInf( USRI0200
009900050209                 : %Size( USRI0200 )
010000050209                 : 'USRI0200'
010100050209                 : PxUsrPrf
010200050209                 : ERRC0100
010300050209                 );
010400040723
010500041201        If  ERRC0100.BytAvl > *Zero;
010600050107
010700050209          If  ERRC0100.BytAvl < OFS_MSGDTA;
010800050209            ERRC0100.BytAvl = OFS_MSGDTA;
010900050209          EndIf;
011000050209
011100050209          SndEscMsg( ERRC0100.MsgId
011200050209                   : 'QCPFMSG'
011300050209                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
011400050209                   );
011500050107
011600041201        Else;
011700050210          pSupGrpPrf = %Addr( USRI0200 ) + USRI0200.SupGrpOfs;
011800040723        EndIf;
011900040723
012000050210        If  PxOption = '*USRPRF'  Or PxOption = '*ALL';
012100050211
012200050210          AccSpcAut = AddSpcAut( AccSpcAut: USRI0200.SpcAut );
012300050210        EndIf;
012400050210
012500050210        If  PxOption = '*GRPPRF'  Or PxOption = '*ALL';
012600050210
012700050210          If  USRI0200.GrpPrf <> '*NONE';
012800050210
012900050210            AccSpcAut = AddSpcAut( AccSpcAut: GetSpcAut( USRI0200.GrpPrf ));
013000050210          EndIf;
013100050210        EndIf;
013200050210
013300050210        If  PxOption = '*SUPGRP'  Or PxOption = '*ALL';
013400050210
013500050210          For  Idx = 1 to  USRI0200.SupGrpNbr;
013600050210
013700050210            AccSpcAut = AddSpcAut( AccSpcAut: GetSpcAut( SupGrpPrf(Idx) ));
013800050210          EndFor;
013900050210        EndIf;
014000050210
014100050210        PxSpcAut = FmtSpcAut( AccSpcAut );
014200050210
014300041201        *InLr = *On;
014400040723        Return;
014500040723
014600040723      /End-Free
014700040723
014800050210     **-- Send escape message:  ----------------------------------------------**
014900050210     P SndEscMsg       B
015000050210     D                 Pi            10i 0
015100050210     D  PxMsgId                       7a   Const
015200050210     D  PxMsgF                       10a   Const
015300050210     D  PxMsgDta                    512a   Const  Varying
015400050210     **
015500050210     D MsgKey          s              4a
015600050210
015700050210      /Free
015800050210
015900050210        SndPgmMsg( PxMsgId
016000050210                 : PxMsgF + '*LIBL'
016100050210                 : PxMsgDta
016200050210                 : %Len( PxMsgDta )
016300050210                 : '*ESCAPE'
016400050210                 : '*PGMBDY'
016500050210                 : 1
016600050210                 : MsgKey
016700050210                 : ERRC0100
016800050210                 );
016900050210
017000050210        If  ERRC0100.BytAvl > *Zero;
017100050210          Return  -1;
017200050210
017300050210        Else;
017400050210          Return   0;
017500050210        EndIf;
017600050210
017700050210      /End-Free
017800050210
017900050210     P SndEscMsg       E
018000050210     **-- Get special authority:  --------------------------------------------**
018100050210     P GetSpcAut       B
018200050212     D                 Pi             1a   Dim( MAX_SPCAUT )
018300050210     D  PxUsrPrf                     10a   Value
018400050210     **
018500050210     D USRI0200        Ds                  Qualified
018600050210     D  BytRtn                       10i 0
018700050210     D  BytAvl                       10i 0
018800050210     D  UsrPrf                       10a
018900050212     D  SpcAut                        1a   Overlay( USRI0200: 29 )
019000050212     D                                     Dim( MAX_SPCAUT )
019100050210
019200050210      /Free
019300050210
019400050210        RtvUsrInf( USRI0200
019500050210                 : %Size( USRI0200 )
019600050210                 : 'USRI0200'
019700050210                 : PxUsrPrf
019800050210                 : ERRC0100
019900050210                 );
020000050210
020100050210        If  ERRC0100.BytAvl > *Zero;
020200050210          Return  *Blanks;
020300050210
020400050210        Else;
020500050210          Return  USRI0200.SpcAut;
020600050210        EndIf;
020700050210
020800050210      /End-Free
020900050210
021000050210     P GetSpcAut       E
021100050210     **-- Add special authority:  --------------------------------------------**
021200050210     P AddSpcAut       B
021300050212     D                 Pi             1a   Dim( MAX_SPCAUT )
021400050212     D  PxSpcAut1                     1a   Dim( MAX_SPCAUT )  Value
021500050212     D  PxSpcAut2                     1a   Dim( MAX_SPCAUT )  Value
021600050210     **
021700050210     D Idx             s             10i 0
021800050210     **
021900050210
022000050210      /Free
022100050210
022200050210        For Idx = 1  To %Elem( PxSpcAut1 );
022300050210
022400050210          If  PxSpcAut2( Idx ) = 'Y';
022500050210
022600050210            PxSpcAut1(Idx) = PxSpcAut2(Idx);
022700050210          EndIf;
022800050210        EndFor;
022900050210
023000050210        Return  PxSpcAut1;
023100050210
023200050210      /End-Free
023300050210
023400050210     P AddSpcAut       E
023500050210     **-- Format special authority:  -----------------------------------------**
023600050210     P FmtSpcAut       B                   Export
023700050212     D                 Pi            10a   Dim( MAX_SPCAUT )
023800050212     D  PxSpcAut                      1a   Dim( MAX_SPCAUT )  Value
023900050210     **
024000050210     D Idx             s             10i 0
024100050212     D SpcAut          s             10a   Dim( MAX_SPCAUT )
024200050210
024300050210      /Free
024400050210
024500050210        If  PxSpcAut(1) = 'Y';
024600050210          Idx += 1;
024700050210          SpcAut(Idx) = '*ALLOBJ';
024800050210        EndIf;
024900050210
025000050210        If  PxSpcAut(2) = 'Y';
025100050210          Idx += 1;
025200050210          SpcAut(Idx) = '*SECADM';
025300050210        EndIf;
025400050210
025500050210        If  PxSpcAut(3) = 'Y';
025600050210          Idx += 1;
025700050210          SpcAut(Idx) = '*JOBCTL';
025800050210        EndIf;
025900050210
026000050210        If  PxSpcAut(4) = 'Y';
026100050210          Idx += 1;
026200050210          SpcAut(Idx) = '*SPLCTL';
026300050210        EndIf;
026400050210
026500050210        If  PxSpcAut(5) = 'Y';
026600050210          Idx += 1;
026700050210          SpcAut(Idx) = '*SAVSYS';
026800050210        EndIf;
026900050210
027000050210        If  PxSpcAut(6) = 'Y';
027100050210          Idx += 1;
027200050210          SpcAut(Idx) = '*SERVICE';
027300050210        EndIf;
027400050210
027500050210        If  PxSpcAut(7) = 'Y';
027600050210          Idx += 1;
027700050210          SpcAut(Idx) = '*AUDIT';
027800050210        EndIf;
027900050210
028000050210        If  PxSpcAut(8) = 'Y';
028100050210          Idx += 1;
028200050210          SpcAut(Idx) = '*IOSYSCFG';
028300050210        EndIf;
028400050210
028500050210        If  SpcAut(1) = *Blanks;
028600050210          SpcAut(1) = '*NONE';
028700050210        EndIf;
028800050210
028900050210        Return  SpcAut;
029000050210
029100050210      /End-Free
029200050210
029300050210     P FmtSpcAut       E
