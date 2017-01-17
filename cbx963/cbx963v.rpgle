000100041110     **
000200061104     **  Program . . : CBX963V
000300061104     **  Description : Display Server Share - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500061104     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900061106     **    Validity checking program for server share existence.
001000050804     **
001100050804     **
001200031115     **  Compile options:
001300061104     **    CrtRpgMod Module( CBX963V )
001400040722     **              DbgView( *LIST )
001500031115     **
001600061104     **    CrtPgm    Pgm( CBX963V )
001700061104     **              Module( CBX963V )
001800060729     **              ActGrp( QILE )
001900031115     **
002000031115     **
002100040605     **-- Control specification:  --------------------------------------------**
002200050804     H Option( *SrcStmt )
002300040722
002400060421     **-- System information:
002500060421     D PgmSts         SDs                  Qualified
002600060421     D  PgmNam           *Proc
002700060421     D  CurJob                       10a   Overlay( PgmSts: 244 )
002800060421     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
002900060421     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003000060421     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003100040728     **-- API error data structure:
003200040728     D ERRC0100        Ds                  Qualified
003300040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003400040728     D  BytAvl                       10i 0
003500060812     D  MsgId                         7a
003600040728     D                                1a
003700060812     D  MsgDta                      512a
003800060812
003900061104     D                               34a
004000061106
004100061104     **-- Open list of server information:
004200061104     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
004300061104     D  RcvVar                    32767a          Options( *VarSize )
004400061104     D  RcvVarLen                    10i 0 Const
004500061104     D  LstInf                       64a
004600061104     D  Format                        8a   Const
004700061104     D  InfQual                      15a   Const
004800061104     D  Error                     32767a          Options( *VarSize )
004900061104     D  SsnUsr                       10a   Const  Options( *NoPass )
005000061104     D  SsnId                        20u 0 Const  Options( *NoPass )
005100040728     **-- Send program message:
005200040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
005300050802     D  MsgId                         7a   Const
005400050802     D  MsgFq                        20a   Const
005500050802     D  MsgDta                      128a   Const
005600050802     D  MsgDtaLen                    10i 0 Const
005700050802     D  MsgTyp                       10a   Const
005800050802     D  CalStkE                      10a   Const  Options( *VarSize )
005900050802     D  CalStkCtr                    10i 0 Const
006000050802     D  MsgKey                        4a
006100050802     D  Error                      1024a          Options( *VarSize )
006200040722
006300061104     **-- Check share existence:
006400061104     D ChkShr          Pr              n
006500061104     D  PxShare                      12a   Const
006600060401
006700040728     **-- Send diagnostic message:
006800040728     D SndDiagMsg      Pr            10i 0
006900040722     D  PxMsgId                       7a   Const
007000040722     D  PxMsgDta                    512a   Const  Varying
007100040728     **-- Send escape message:
007200040728     D SndEscMsg       Pr            10i 0
007300040728     D  PxMsgId                       7a   Const
007400040728     D  PxMsgDta                    512a   Const  Varying
007500040722
007600040722     **-- Entry parameters:
007700061104     D CBX963V         Pr
007800061104     D  PxShare                      12a
007900050731     **
008000061104     D CBX963V         Pi
008100061104     D  PxShare                      12a
008200040721
008300040724      /Free
008400060421
008500061104        If  ChkShr( PxShare ) = *Off;
008600061028
008700060812          SndDiagMsg( 'CPD0006'
008800061104                    : '0000Share '        +
008900061104                       %Trim( PxShare )   +
009000061028                      ' not found.'
009100060812                    );
009200060812
009300060812          SndEscMsg( 'CPF0002': '' );
009400060812        EndIf;
009500050408
009600040605        *InLr = *On;
009700040605        Return;
009800040605
009900040721      /End-Free
010000040721
010100061104     **-- Check share existence:  --------------------------------------------**
010200061104     P ChkShr          B                   Export
010300060623     D                 Pi              n
010400061104     D  PxShare                      12a   Const
010500061104
010600061104     **-- Share information:
010700061104     D ZLSL0101        Ds         32767    Qualified
010800061104     D  EntLen                       10i 0
010900061104     D  Share                        12a
011000061104     D  DevTyp                       10i 0
011100061104     D  Permis                       10i 0
011200061104     D  MaxUsr                       10i 0
011300061104     D  CurUsr                       10i 0
011400061104     D  SpfTyp                       10i 0
011500061104     D  OfsPthNam                    10i 0
011600061104     D  LenPthNam                    10i 0
011700061104     D  OutQue_q                     20a
011800061104     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
011900061104     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
012000061104     D  PrtDrv                       50a
012100061104     D  TxtDsc                       50a
012200061104     D  PrtFil_q                     20a
012300061104     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
012400061104     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
012500061104     D  TxtCcsId                     10i 0
012600061104     D  OfsExtTbl                    10i 0
012700061104     D  NbrTblEnt                    10i 0
012800061104     D  EnbTxtCnv                     1a
012900061104     D  Publish                       1a
013000061104     **-- List information:
013100061104     D LstInf          Ds                  Qualified
013200061104     D  RcdNbrTot                    10i 0
013300061104     D  RcdNbrRtn                    10i 0
013400061104     D  RcdLen                       10i 0
013500061104     D  InfLen                       10i 0
013600061104     D  InfSts                        1a
013700061104     D  Dts                          13a
013800061104     D                               34a
013900060623
014000060623      /Free
014100060623
014200061104        LstSvrInf( ZLSL0101
014300061104                 : %Len( ZLSL0101 )
014400061104                 : LstInf
014500061104                 : 'ZLSL0101'
014600061104                 : PxShare
014700061104                 : ERRC0100
014800061104                 );
014900060623
015000061104        Select;
015100061104        When  ERRC0100.BytAvl > *Zero;
015200061104          Return  *Off;
015300060623
015400061104        When  LstInf.RcdNbrTot <> 1;
015500061104          Return  *Off;
015600061104
015700061104        Other;
015800061104          Return  *On;
015900061104        EndSl;
016000060623
016100060623      /End-Free
016200060623
016300061104     P ChkShr          E
016400060316     **-- Send diagnostic message:
016500040728     P SndDiagMsg      B
016600040722     D                 Pi            10i 0
016700040722     D  PxMsgId                       7a   Const
016800040722     D  PxMsgDta                    512a   Const  Varying
016900040722     **
017000040722     D MsgKey          s              4a
017100040722
017200040722      /Free
017300040722
017400040722        SndPgmMsg( PxMsgId
017500040722                 : 'QCPFMSG   *LIBL'
017600040722                 : PxMsgDta
017700040722                 : %Len( PxMsgDta )
017800040728                 : '*DIAG'
017900040722                 : '*PGMBDY'
018000040722                 : 1
018100040722                 : MsgKey
018200040722                 : ERRC0100
018300040722                 );
018400040722
018500040722        If  ERRC0100.BytAvl > *Zero;
018600040722          Return  -1;
018700040722
018800040722        Else;
018900040722          Return   0;
019000040722        EndIf;
019100040722
019200040722      /End-Free
019300040722
019400040728     P SndDiagMsg      E
019500060316     **-- Send escape message:
019600040728     P SndEscMsg       B
019700040728     D                 Pi            10i 0
019800040728     D  PxMsgId                       7a   Const
019900040728     D  PxMsgDta                    512a   Const  Varying
020000040728     **
020100040728     D MsgKey          s              4a
020200040728
020300040728      /Free
020400040728
020500040728        SndPgmMsg( PxMsgId
020600040728                 : 'QCPFMSG   *LIBL'
020700040728                 : PxMsgDta
020800040728                 : %Len( PxMsgDta )
020900040728                 : '*ESCAPE'
021000040728                 : '*PGMBDY'
021100040728                 : 1
021200040728                 : MsgKey
021300040728                 : ERRC0100
021400040728                 );
021500040728
021600040728        If  ERRC0100.BytAvl > *Zero;
021700040728          Return  -1;
021800040728
021900040728        Else;
022000040728          Return   0;
022100040728        EndIf;
022200040728
022300040728      /End-Free
022400040728
022500040728     P SndEscMsg       E
