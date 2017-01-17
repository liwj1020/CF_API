000100031030     **
000200060624     **  Program . . : CBX957
000300060624     **  Description : Change NetServer User - CPP
000400031030     **  Author  . . : Carsten Flensburg
000500031030     **
000600031030     **
000700031030     **
000800031030     **  Programmer's notes:
000900031030     **    To enable a NetServer user *SECADM special authority is required
001000031030     **    as well as *OBJMGT and *USE authority to the system user profile
001100031030     **    (the corresponding iSeries user profile).
001200031101     **
001300031101     **    To use the QZLSCHSI API, you must have *IOSYSCFG special authority.
001400031030     **
001500031101     **
001600031030     **  Compile options:
001700060624     **    CrtRpgMod Module( CBX957 )
001800060624     **              DbgView( *LIST )
001900060624     **
002000060624     **    CrtPgm    Pgm( CBX957 )
002100060624     **              Module( CBX957 )
002200060624     **              ActGrp( *NEW )
002300031030     **
002400031030     **
002500030911     **-- Header specifications:  --------------------------------------------**
002600000926     H Option( *SrcStmt )
002700060624
002800050216     **-- API error data structure:
002900050216     D ERRC0100        Ds                  Qualified
003000050216     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003100050216     D  BytAvl                       10i 0
003200050216     D  MsgId                         7a
003300990921     D                                1a
003400050216     D  MsgDta                      256a
003500050216
003600050216     **-- Global constants:
003700050216     D OFS_MSGDTA      c                   16
003800060624     D STS_ENABLE      c                   'E'
003900050216
004000020702     **-- Request variable:
004100050216     D ZLSS0200        Ds                  Qualified
004200050216     D  NbrSvrUsr                    10i 0
004300050216     D  NetSvrUsr                    10a   Dim( 1024 )
004400050216
004500050216     **-- Change server information:
004600020702     D ChgSvrInf       Pr                  ExtPgm( 'QZLSCHSI' )
004700060624     D  RqsVar                    32767a   Const  Options( *VarSize )
004800060624     D  RqsVarLen                    10i 0 Const
004900060624     D  FmtNam                       10a   Const
005000060624     D  Error                     32767a          Options( *VarSize )
005100050216     **-- Send program message:
005200050216     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
005300060624     D  MsgId                         7a   Const
005400060624     D  MsgF_q                       20a   Const
005500060624     D  MsgDta                      512a   Const  Options( *VarSize )
005600060624     D  MsgDtaLen                    10i 0 Const
005700060624     D  MsgTyp                       10a   Const
005800060624     D  CalStkEnt                    10a   Const  Options( *VarSize )
005900060624     D  CalStkCtr                    10i 0 Const
006000060624     D  MsgKey                        4a
006100060624     D  Error                       512a          Options( *VarSize )
006200050216     **
006300060624     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
006400060624     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
006500060624     D  DspWait                      10i 0 Const  Options( *NoPass )
006600050216     **
006700060624     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
006800060624     D  CcsId                        10i 0 Const  Options( *NoPass )
006900050216
007000050216     **-- Send completion message:
007100050216     D SndCmpMsg       Pr            10i 0
007200050216     D  PxMsgDta                    512a   Const  Varying
007300050216     **-- Send escape message:
007400050216     D SndEscMsg       Pr            10i 0
007500050216     D  PxMsgId                       7a   Const
007600050216     D  PxMsgF                       10a   Const
007700050216     D  PxMsgDta                    512a   Const  Varying
007800050216
007900060624     **-- Entry parameters:
008000060624     D CBX957          Pr
008100060624     D  PxUsrPrf                     10a   Varying
008200060624     D  PxStatus                      1a
008300060624     **
008400060624     D CBX957          Pi
008500060624     D  PxUsrPrf                     10a   Varying
008600060624     D  PxStatus                      1a
008700060624
008800050216      /Free
008900050216
009000060624        If  PxStatus = STS_ENABLE;
009100060624
009200060624          ZLSS0200.NbrSvrUsr  = 1;
009300060624          ZLSS0200.NetSvrUsr(1) = PxUsrPrf;
009400060624
009500060624          ChgSvrInf( ZLSS0200: %Size( ZLSS0200 ): 'ZLSS0200': ERRC0100 );
009600060624
009700060624          If  ERRC0100.BytAvl > *Zero;
009800060624
009900060624            If  ERRC0100.BytAvl < OFS_MSGDTA;
010000060624              ERRC0100.BytAvl = OFS_MSGDTA;
010100060624            EndIf;
010200060624
010300060624            SndEscMsg( ERRC0100.MsgId
010400060624                     : 'QCPFMSG'
010500060624                     : %Subst( ERRC0100.MsgDta
010600060624                             : 1
010700060624                             : ERRC0100.BytAvl - OFS_MSGDTA
010800060624                             )
010900060624                     );
011000060624          Else;
011100060624            SndCmpMsg( 'NetServer user ' + PxUsrPrf + ' enabled.' );
011200060624          EndIf;
011300060624
011400060624        Else;
011500060624            SndCmpMsg( 'NetServer user ' + PxUsrPrf + ' not changed.' );
011600060624        EndIf;
011700050216
011800060624        *InLr = *On;
011900060624        Return;
012000050216
012100050216      /End-Free
012200050216
012300050216     **-- Send completion message:  ------------------------------------------**
012400050216     P SndCmpMsg       B
012500050216     D                 Pi            10i 0
012600050216     D  PxMsgDta                    512a   Const  Varying
012700050216     **
012800050216     D MsgKey          s              4a
012900050216
013000050216      /Free
013100050216
013200050216        SndPgmMsg( 'CPF9897'
013300050216                 : 'QCPFMSG   *LIBL'
013400050216                 : PxMsgDta
013500050216                 : %Len( PxMsgDta )
013600050216                 : '*COMP'
013700050216                 : '*PGMBDY'
013800050216                 : 1
013900050216                 : MsgKey
014000050216                 : ERRC0100
014100050216                 );
014200050216
014300050216        If  ERRC0100.BytAvl > *Zero;
014400050216          Return  -1;
014500050216
014600050216        Else;
014700050216          Return  0;
014800050216
014900050216        EndIf;
015000050216
015100050216      /End-Free
015200050216
015300050216     P SndCmpMsg       E
015400050216     **-- Send escape message:  ----------------------------------------------**
015500050216     P SndEscMsg       B
015600050216     D                 Pi            10i 0
015700050216     D  PxMsgId                       7a   Const
015800050216     D  PxMsgF                       10a   Const
015900050216     D  PxMsgDta                    512a   Const  Varying
016000050216     **
016100050216     D MsgKey          s              4a
016200050216
016300050216      /Free
016400050216
016500050216        SndPgmMsg( PxMsgId
016600050216                 : PxMsgF + '*LIBL'
016700050216                 : PxMsgDta
016800050216                 : %Len( PxMsgDta )
016900050216                 : '*ESCAPE'
017000050216                 : '*PGMBDY'
017100050216                 : 1
017200050216                 : MsgKey
017300050216                 : ERRC0100
017400050216                 );
017500050216
017600050216        If  ERRC0100.BytAvl > *Zero;
017700050216          Return  -1;
017800050216
017900050216        Else;
018000050216          Return   0;
018100050216        EndIf;
018200050216
018300050216      /End-Free
018400050216
018500050216     P SndEscMsg       E
