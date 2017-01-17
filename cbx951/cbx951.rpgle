000100050630     **
000200060117     **  Program . . : CBX951
000300050701     **  Description : Add PRN seed - CPP
000400050630     **  Author  . . : Carsten Flensburg
000500050630     **
000600050630     **
000700050630     **  Programmer's notes:
000800050630     **    Earliest release program will run: V5R1
000900050630     **
001000050630     **
001100050630     **  Compile options:
001200050630     **
001300060117     **    CrtRpgMod Module( CBX951 )
001400050630     **              DbgView( *LIST )
001500050630     **
001600060117     **    CrtPgm    Pgm( CBX951 )
001700060117     **              Module( CBX951 )
001800050630     **              ActGrp( *NEW )
001900050630     **
002000050630     **
002100050630     **-- Header specifications:  --------------------------------------------**
002200050629     H Option( *SrcStmt )  BndDir( 'QC2LE' )
002300050630
002400050630     **-- System information:
002500050630     D PgmSts         SDs                  Qualified
002600050630     D  PgmNam           *Proc
002700050630     D  CurJob                       10a   Overlay( PgmSts: 244 )
002800050630     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002900050630     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003000050630     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003100050629     **-- API error information:
003200050629     D ERRC0100        Ds                  Qualified
003300050629     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
003400050629     D  BytAvl                       10i 0
003500050629     D  MsgId                         7a
003600050629     D                                1a
003700050629     D  MsgDta                      256a
003800060128
003900050629     **-- Global variables:
004000050630     D AutFlg          s              1a
004100050629     D Seed            s             20a
004200050629     D SeedHex         s             40a   Varying
004300050630     D MsgKey          s              4a
004400050630     **-- Global constants:
004500050630     D OFS_MSGDTA      c                   16
004600050630     D ADP_PRV_INVLVL  c                   1
004700060128
004800050629     **-- Convert hex to character:
004900050629     D cvthc           Pr                  ExtProc( 'cvthc' )
005000050629     D  RcvHex                         *   Value
005100050629     D  SrcChr                         *   Value
005200050629     D  RcvLen                       10i 0 Value
005300050629     **-- Convert character to hex:
005400050629     D cvtch           Pr                  ExtProc( 'cvtch' )
005500050629     D  RcvChr                         *   Value
005600050629     D  SrcHex                         *   Value
005700050629     D  RcvLen                       10i 0 Value
005800050629     **-- String to unsigned long:
005900050629     D strtoul         pr            10i 0 ExtProc( 'strtoul' )
006000050629     D  nptr                           *   Value  Options( *String )
006100050629     D  endptr                         *   Value
006200050629     D  base                         10i 0 Value
006300050629     **-- Add seed for pseudorandom number generator:
006400050629     D AddSeedPng      pr            10i 0 ExtProc( 'Qc3AddPRNGSeed' )
006500050629     D  Seed                         20a   Const  Options( *VarSize )
006600050630     D  SeedLen                      10i 0 Const
006700050629     D  Error                     32767a          Options( *VarSize )
006800050630     **-- Check special authority
006900050630     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
007000050630     D  CsAutInf                      1a
007100050630     D  CsUsrPrf                     10a   Const
007200050630     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
007300050630     D  CsNbrAut                     10i 0 Const
007400050630     D  CsCalLvl                     10i 0 Const
007500050630     D  CsError                   32767a          Options( *VarSize )
007600050630     **-- Send program message:
007700050630     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
007800050630     D  SpMsgId                       7a   Const
007900050630     D  SpMsgFq                      20a   Const
008000050630     D  SpMsgDta                    128a   Const
008100050630     D  SpMsgDtaLen                  10i 0 Const
008200050630     D  SpMsgTyp                     10a   Const
008300050630     D  SpCalStkE                    10a   Const  Options( *VarSize )
008400050630     D  SpCalStkCtr                  10i 0 Const
008500050630     D  SpMsgKey                      4a
008600050630     D  SpError                   32767a          Options( *VarSize )
008700050629
008800050629     **-- Add seed in hexadecimal form:
008900050629     D AddSeedHex      Pr             8a
009000050629     D  PxSeed                       32a   Const
009100050630     **-- Send diagnostic message:
009200050630     D SndDiagMsg      Pr            10i 0
009300050630     D  PxMsgId                       7a   Const
009400050630     D  PxMsgDta                    512a   Const  Varying
009500050630     **-- Send escape message:
009600050630     D SndEscMsg       Pr            10i 0
009700050630     D  PxMsgDta                    512a   Const  Varying
009800050630     **-- Send completion message:
009900050630     D SndCmpMsg       Pr            10i 0
010000050630     D  PxMsgDta                    512a   Const  Varying
010100050629
010200060117     D CBX951          Pr
010300050629     D  PxSeed1                      32a
010400050629     D  PxSeed2                      32a
010500050629     D  PxSeed3                      32a
010600050629     D  PxSeed4                      32a
010700050629     D  PxSeed5                      32a
010800050629     **
010900060117     D CBX951          Pi
011000050629     D  PxSeed1                      32a
011100050629     D  PxSeed2                      32a
011200050629     D  PxSeed3                      32a
011300050629     D  PxSeed4                      32a
011400050629     D  PxSeed5                      32a
011500050629
011600050629      /Free
011700050630
011800050630        ChkSpcAut( AutFlg
011900050630                 : PgmSts.UsrPrf
012000050630                 : '*ALLOBJ'
012100050630                 : 1
012200050630                 : ADP_PRV_INVLVL
012300050630                 : ERRC0100
012400050630                 );
012500050630
012600050630        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
012700050630
012800050630          SndEscMsg( 'Special authority *ALLOBJ required.' );
012900050630        Else;
013000050630
013100050630          If  %Check( '01': PxSeed1 ) > *Zero  Or
013200050630              %Check( '01': PxSeed2 ) > *Zero  Or
013300050630              %Check( '01': PxSeed3 ) > *Zero  Or
013400050630              %Check( '01': PxSeed4 ) > *Zero  Or
013500050630              %Check( '01': PxSeed5 ) > *Zero;
013600050630
013700050630            SndDiagMsg( 'CPF9898'
013800050630                      : 'Only binary values are allowed, please specify ' +
013900150417                        '''0'' and ''1'''
014000050630                      );
014100050630
014200050630            SndEscMsg( 'ADDPRNSEED command ended in error' );
014300050630
014400050630          Else;
014500050630            SeedHex  = AddSeedHex( PxSeed1 );
014600050630            SeedHex += AddSeedHex( PxSeed2 );
014700050630            SeedHex += AddSeedHex( PxSeed3 );
014800050630            SeedHex += AddSeedHex( PxSeed4 );
014900050630            SeedHex += AddSeedHex( PxSeed5 );
015000050630
015100050630            cvtch( %Addr( Seed ): %Addr( SeedHex ) + 2: %Len( SeedHex ));
015200050630
015300050630            AddSeedPng( Seed: %Size( Seed ): ERRC0100 );
015400050630
015500050630            If  ERRC0100.BytAvl > *Zero;
015600050630              If  ERRC0100.BytAvl < OFS_MSGDTA;
015700050630                ERRC0100.BytAvl = OFS_MSGDTA;
015800050630              EndIf;
015900050630
016000050630              SndDiagMsg( ERRC0100.MsgId
016100050630                        : %Subst( ERRC0100.MsgDta
016200060117                                : 1
016300060117                                : ERRC0100.BytAvl - OFS_MSGDTA
016400060117                                ));
016500050630
016600050630              SndEscMsg( 'ADDPRNSEED command ended in error' );
016700050630            Else;
016800050630              SndCmpMsg( 'PRN seed added succesfully.' );
016900050630            EndIf;
017000050630          EndIf;
017100050630        EndIf;
017200050629
017300050629        *InLr = *On;
017400050629        Return;
017500050629
017600050629      /End-Free
017700050629
017800050629     **-- Add seed in hexadecimal form:  -------------------------------------**
017900050629     P AddSeedHex      B
018000050629     D                 Pi             8a
018100050629     D  PxSeed                       32a   Const
018200050629
018300050629     **-- Local variables:
018400050629     D Ptr             s               *
018500050629     D Uint            s             10u 0
018600050629     D SeedHex         s              8a
018700050629
018800050629      /Free
018900050629
019000050629        Uint = strtoul( PxSeed: %Addr( Ptr ): 2 );
019100050629
019200050629        cvthc( %Addr( SeedHex ): %Addr( Uint ): %Size( SeedHex ));
019300050629
019400050629        Return  SeedHex;
019500050629
019600050629      /End-Free
019700050629
019800050629     P AddSeedHex      E
019900050630     **-- Send diagnostic message:  ------------------------------------------**
020000050630     P SndDiagMsg      B
020100050630     D                 Pi            10i 0
020200050630     D  PxMsgId                       7a   Const
020300050630     D  PxMsgDta                    512a   Const  Varying
020400050630     **
020500050630     D MsgKey          s              4a
020600050630
020700050630      /Free
020800050630
020900050630        SndPgmMsg( PxMsgId
021000050630                 : 'QCPFMSG   *LIBL'
021100050630                 : PxMsgDta
021200050630                 : %Len( PxMsgDta )
021300050630                 : '*DIAG'
021400050630                 : '*PGMBDY'
021500050630                 : 1
021600050630                 : MsgKey
021700050630                 : ERRC0100
021800050630                 );
021900050630
022000050630        If  ERRC0100.BytAvl > *Zero;
022100050630          Return  -1;
022200050630
022300050630        Else;
022400050630          Return   0;
022500050630        EndIf;
022600050630
022700050630      /End-Free
022800050630
022900050630     P SndDiagMsg      E
023000050630     **-- Send escape message:  ----------------------------------------------**
023100050630     P SndEscMsg       B
023200050630     D                 Pi            10i 0
023300050630     D  PxMsgDta                    512a   Const  Varying
023400050630
023500050630      /Free
023600050630
023700050630        SndPgmMsg( 'CPF9898'
023800050630                 : 'QCPFMSG   *LIBL'
023900050630                 : PxMsgDta
024000050630                 : %Len( PxMsgDta )
024100050630                 : '*ESCAPE'
024200050630                 : '*PGMBDY'
024300050630                 : 1
024400050630                 : MsgKey
024500050630                 : ERRC0100
024600050630                 );
024700050630
024800050630        If  ERRC0100.BytAvl > *Zero;
024900050630          Return  -1;
025000050630
025100050630        Else;
025200050630          Return  0;
025300050630
025400050630        EndIf;
025500050630
025600050630      /End-Free
025700050630
025800050630     P SndEscMsg       E
025900050630     **-- Send completion message:  ------------------------------------------**
026000050630     P SndCmpMsg       B
026100050630     D                 Pi            10i 0
026200050630     D  PxMsgDta                    512a   Const  Varying
026300050630
026400050630      /Free
026500050630
026600050630        SndPgmMsg( 'CPF9897'
026700050630                 : 'QCPFMSG   *LIBL'
026800050630                 : PxMsgDta
026900050630                 : %Len( PxMsgDta )
027000050630                 : '*COMP'
027100050630                 : '*PGMBDY'
027200050630                 : 1
027300050630                 : MsgKey
027400050630                 : ERRC0100
027500050630                 );
027600050630
027700050630        If  ERRC0100.BytAvl > *Zero;
027800050630          Return  -1;
027900050630
028000050630        Else;
028100050630          Return  0;
028200050630
028300050630        EndIf;
028400050630
028500050630      /End-Free
028600050630
028700050630     P SndCmpMsg       E
