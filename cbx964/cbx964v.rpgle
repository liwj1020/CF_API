000100041110     **
000200061106     **  Program . . : CBX964V
000300061106     **  Description : Work with Server Shares - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500061106     **  Published . : System iNetwork Systems Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900061106     **    Validity checking program for server share existence in case of
001000061106     **    specific share name.
001100050804     **
001200050804     **
001300031115     **  Compile options:
001400061106     **    CrtRpgMod Module( CBX964V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700061106     **    CrtPgm    Pgm( CBX964V )
001800061106     **              Module( CBX964V )
001900061203     **              ActGrp( *CALLER )
002000031115     **
002100031115     **
002200040605     **-- Control specification:  --------------------------------------------**
002300050804     H Option( *SrcStmt )
002400040722
002500040728     **-- API error data structure:
002600040728     D ERRC0100        Ds                  Qualified
002700040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002800040728     D  BytAvl                       10i 0
002900061203     D  MsgId                         7a
003000040728     D                                1a
003100061203     D  MsgDta                      512a
003200060407
003300060407     **-- Global constants:
003400060407     D ADP_PRV_INVLVL  c                   1
003500060407     **-- Global variables:
003600060407     D AutFlg          s              1a
003700060407     D SpcAut          s             10a   Dim( 8 )
003800050731
003900061106     **-- Open list of server information:
004000061106     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
004100061106     D  RcvVar                    32767a          Options( *VarSize )
004200061106     D  RcvVarLen                    10i 0 Const
004300061106     D  LstInf                       64a
004400061106     D  Format                        8a   Const
004500061106     D  InfQual                      15a   Const
004600061106     D  Error                     32767a          Options( *VarSize )
004700061106     D  SsnUsr                       10a   Const  Options( *NoPass )
004800061106     D  SsnId                        20u 0 Const  Options( *NoPass )
004900040728     **-- Send program message:
005000040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
005100050802     D  MsgId                         7a   Const
005200050802     D  MsgFq                        20a   Const
005300050802     D  MsgDta                      128a   Const
005400050802     D  MsgDtaLen                    10i 0 Const
005500050802     D  MsgTyp                       10a   Const
005600050802     D  CalStkE                      10a   Const  Options( *VarSize )
005700050802     D  CalStkCtr                    10i 0 Const
005800050802     D  MsgKey                        4a
005900050802     D  Error                      1024a          Options( *VarSize )
006000040722
006100061106     **-- Check share existence:
006200061106     D ChkShr          Pr              n
006300061106     D  PxShare                      12a   Const
006400060401
006500040728     **-- Send diagnostic message:
006600040728     D SndDiagMsg      Pr            10i 0
006700040722     D  PxMsgId                       7a   Const
006800040722     D  PxMsgDta                    512a   Const  Varying
006900040728     **-- Send escape message:
007000040728     D SndEscMsg       Pr            10i 0
007100040728     D  PxMsgId                       7a   Const
007200040728     D  PxMsgDta                    512a   Const  Varying
007300040722
007400040722     **-- Entry parameters:
007500061106     D CBX964V         Pr
007600061106     D  PxShare                      12a
007700061108     D  PxType                       10i 0
007800060729     D  PxOutOpt                      3a
007900050731     **
008000061106     D CBX964V         Pi
008100061106     D  PxShare                      12a
008200061108     D  PxType                       10i 0
008300060729     D  PxOutOpt                      3a
008400040721
008500040724      /Free
008600060407
008700061106        If  %Scan( '*': PxShare ) = *Zero;
008800060421
008900061106          If  ChkShr( PxShare ) = *Off;
009000061106
009100061106            SndDiagMsg( 'CPD0006'
009200061106                      : '0000Share '        +
009300061106                         %Trim( PxShare )   +
009400061106                        ' not found.'
009500061106                      );
009600061106
009700060421            SndEscMsg( 'CPF0002': '' );
009800060421          EndIf;
009900060421        EndIf;
010000050408
010100040605        *InLr = *On;
010200040605        Return;
010300040605
010400040721      /End-Free
010500040721
010600061106     **-- Check share existence:  --------------------------------------------**
010700061106     P ChkShr          B                   Export
010800061106     D                 Pi              n
010900061106     D  PxShare                      12a   Const
011000061106
011100061106     **-- Share information:
011200061106     D ZLSL0101        Ds         32767    Qualified
011300061106     D  EntLen                       10i 0
011400061106     D  Share                        12a
011500061106     D  DevTyp                       10i 0
011600061106     D  Permis                       10i 0
011700061106     D  MaxUsr                       10i 0
011800061106     D  CurUsr                       10i 0
011900061106     D  SpfTyp                       10i 0
012000061106     D  OfsPthNam                    10i 0
012100061106     D  LenPthNam                    10i 0
012200061106     D  OutQue_q                     20a
012300061106     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
012400061106     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
012500061106     D  PrtDrv                       50a
012600061106     D  TxtDsc                       50a
012700061106     D  PrtFil_q                     20a
012800061106     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
012900061106     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
013000061106     D  TxtCcsId                     10i 0
013100061106     D  OfsExtTbl                    10i 0
013200061106     D  NbrTblEnt                    10i 0
013300061106     D  EnbTxtCnv                     1a
013400061106     D  Publish                       1a
013500061106     **-- List information:
013600061106     D LstInf          Ds                  Qualified
013700061106     D  RcdNbrTot                    10i 0
013800061106     D  RcdNbrRtn                    10i 0
013900061106     D  RcdLen                       10i 0
014000061106     D  InfLen                       10i 0
014100061106     D  InfSts                        1a
014200061106     D  Dts                          13a
014300061106     D                               34a
014400061106
014500061106      /Free
014600061106
014700061106        LstSvrInf( ZLSL0101
014800061106                 : %Len( ZLSL0101 )
014900061106                 : LstInf
015000061106                 : 'ZLSL0101'
015100061106                 : PxShare
015200061106                 : ERRC0100
015300061106                 );
015400061106
015500061106        Select;
015600061106        When  ERRC0100.BytAvl > *Zero;
015700061106          Return  *Off;
015800061106
015900061106        When  LstInf.RcdNbrTot <> 1;
016000061106          Return  *Off;
016100061106
016200061106        Other;
016300061106          Return  *On;
016400061106        EndSl;
016500061106
016600061106      /End-Free
016700061106
016800061106     P ChkShr          E
016900060316     **-- Send diagnostic message:
017000040728     P SndDiagMsg      B
017100040722     D                 Pi            10i 0
017200040722     D  PxMsgId                       7a   Const
017300040722     D  PxMsgDta                    512a   Const  Varying
017400040722     **
017500040722     D MsgKey          s              4a
017600040722
017700040722      /Free
017800040722
017900040722        SndPgmMsg( PxMsgId
018000040722                 : 'QCPFMSG   *LIBL'
018100040722                 : PxMsgDta
018200040722                 : %Len( PxMsgDta )
018300040728                 : '*DIAG'
018400040722                 : '*PGMBDY'
018500040722                 : 1
018600040722                 : MsgKey
018700040722                 : ERRC0100
018800040722                 );
018900040722
019000040722        If  ERRC0100.BytAvl > *Zero;
019100040722          Return  -1;
019200040722
019300040722        Else;
019400040722          Return   0;
019500040722        EndIf;
019600040722
019700040722      /End-Free
019800040722
019900040728     P SndDiagMsg      E
020000060316     **-- Send escape message:
020100040728     P SndEscMsg       B
020200040728     D                 Pi            10i 0
020300040728     D  PxMsgId                       7a   Const
020400040728     D  PxMsgDta                    512a   Const  Varying
020500040728     **
020600040728     D MsgKey          s              4a
020700040728
020800040728      /Free
020900040728
021000040728        SndPgmMsg( PxMsgId
021100040728                 : 'QCPFMSG   *LIBL'
021200040728                 : PxMsgDta
021300040728                 : %Len( PxMsgDta )
021400040728                 : '*ESCAPE'
021500040728                 : '*PGMBDY'
021600040728                 : 1
021700040728                 : MsgKey
021800040728                 : ERRC0100
021900040728                 );
022000040728
022100040728        If  ERRC0100.BytAvl > *Zero;
022200040728          Return  -1;
022300040728
022400040728        Else;
022500040728          Return   0;
022600040728        EndIf;
022700040728
022800040728      /End-Free
022900040728
023000040728     P SndEscMsg       E
