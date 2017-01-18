000100951011     **-----------------------------------------------------------------------**
000200030829     **
000300050917     **  Program . . : CBX946S
000400050917     **  Description : Enhanced system request menu - services
000500030829     **  Author  . . : Carsten Flensburg
000600030829     **
000700031119     **
000800031119     **
000900031119     **  Compile options required:
001000050917     **    CrtRpgMod  CBX946S
001100031119     **
001200050917     **    CrtSrvPgm  CBX946S                        +
001300050917     **               Module( CBX946S )              +
001400031119     **               Export( *ALL )                 +
001500031119     **               ActGrp( QSRVPGM )
001600031119     **
001700031119     **
001800951011     **-- Header Specifications:  --------------------------------------------**
001900030804     H NoMain  Option( *SrcStmt )
002000050917
002100050917     **-- API Error data structure:
002200050917     D ERRC0100        Ds                  Inz
002300050917     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
002400050917     D  BytAvl                       10i 0
002500050917     D  MsgId                         7a
002600000320     D                                1a
002700050917     D  MsgDta                      256a
002800050917     **-- Global constants:
002900050917     D NULL            c                   ''
003000050917
003100050917     **-- Retrieve message:
003200030804     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
003300050917     D  RcvVar                    32767a          Options( *VarSize )
003400050917     D  RcvVarLen                    10i 0 Const
003500050917     D  FmtNam                       10a   Const
003600050917     D  MsgId                         7a   Const
003700050917     D  MsgFq                        20a   Const
003800050917     D  MsgDta                      512a   Const  Options( *VarSize )
003900050917     D  MsgDtaLen                    10i 0 Const
004000050917     D  RplSubVal                    10a   Const
004100050917     D  RtnFmtChr                    10a   Const
004200050917     D  Error                     32767a          Options( *VarSize )
004300030804     **
004400050917     D  RtvOpt                       10a   Const  Options( *NoPass )
004500050917     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
004600050917     D  RplCcsId                     10i 0 Const  Options( *NoPass )
004700050917     **-- Move program messages:
004800030829     D MovPgmMsgs      Pr                  ExtPgm( 'QMHMOVPM' )
004900050917     D  MsgKey                        4a   Const
005000050917     D  MsgTyps                      10a   Const  Options( *VarSize )
005100030829     D                                     Dim( 4 )
005200050917     D  NbrMsgTyps                   10i 0 Const
005300050917     D  ToCalStkE                  4102a   Const  Options( *VarSize )
005400050917     D  ToCalStkCnt                  10i 0 Const
005500050917     D  Error                     32767a          Options( *VarSize )
005600050917     **
005700050917     D  ToCalStkLen                  10i 0 Const  Options( *NoPass )
005800050917     D  ToCalStkEq                   20a   Const  Options( *NoPass )
005900050917     **
006000050917     D  ToCalStkEdt                  10a   Const  Options( *NoPass )
006100050917     D  FrCalStkEad                    *   Const  Options( *NoPass )
006200050917     D  FrCalStkCnt                  10i 0 Const  Options( *NoPass )
006300050917     **-- Process commands:
006400050927     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
006500050927     D  SrcCmd                    32702a   Const  Options( *VarSize )
006600050927     D  SrcCmdLen                    10i 0 Const
006700050927     D  OptCtlBlk                    20a   Const
006800050927     D  OptCtlBlkLn                  10i 0 Const
006900050927     D  OptCtlBlkFm                   8a   Const
007000050927     D  ChgCmd                    32767a          Options( *VarSize )
007100050927     D  ChgCmdLen                    10i 0 Const
007200050927     D  ChgCmdLenAvl                 10i 0
007300050927     D  Error                     32767a          Options( *VarSize )
007400050917
007500050917     **-- Retrieve message text:
007600030823     D RtvMsgTxt       Pr          1024a   Varying
007700000314     D  MsgId                         7a   Value
007800000314     D  MsgF                         10a   Value
007900000314     D  MsgFlib                      10a   Value
008000050917     D  MsgDta                     1024a   Const  Options( *NoPass )
008100050917     **-- Process command:
008200030805     D PrcCmd          Pr            10i 0
008300030804     D  CmdStr                     1024a   Const  Varying
008400050917     **-- Get string:
008500030823     D GetStr          Pr          1024a   Varying
008600000602     D  StrPtr                         *   Value
008700050917
008800050917     **-- Retrieve message text:
008900030804     P RtvMsgTxt       B                   Export
009000030823     D                 Pi          1024a   Varying
009100030804     D  PxMsgId                       7a   Value
009200030804     D  PxMsgF                       10a   Value
009300030804     D  PxMsgFlib                    10a   Value
009400030823     D  PxMsgDta                   1024a   Const  Options( *NoPass )
009500050917
009600030804     **-- Local variables:
009700030823     D MsgDta          s           1024a   Varying
009800030804     **-- Return structure:
009900050917     D RTVM0100        Ds                  Qualified
010000050917     D  BytRtn                       10i 0
010100050917     D  BytAvl                       10i 0
010200050917     D  RtnMsgLen                    10i 0
010300050917     D  RtnMsgAvl                    10i 0
010400050917     D  RtnHlpLen                    10i 0
010500050917     D  RtnHlpAvl                    10i 0
010600050917     D  Msg                        1024a
010700050917
010800050917      /Free
010900050917
011000050917        If  %Parms >= 4;
011100050917          MsgDta = %TrimL( PxMsgDta );
011200050917        EndIf;
011300050917
011400050917        RtvMsg( RTVM0100
011500050917              : %Size( RTVM0100 )
011600050917              :'RTVM0100'
011700050917              : PxMsgId
011800050917              : PxMsgF + PxMsgFlib
011900050917              : MsgDta
012000050917              : %Len( MsgDta )
012100050917              : '*YES'
012200050917              : '*NO'
012300050917              : ERRC0100
012400050917              );
012500050917
012600050917        If  ERRC0100.BytAvl = *Zero;
012700050917          Return  %SubSt( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
012800050917
012900050917        Else;
013000050917          Return  NULL;
013100050917        EndIf;
013200050917
013300050917      /End-Free
013400050917
013500030804     P RtvMsgTxt       E
013600030804     **-- Process command:  --------------------------------------------------**
013700000320     P PrcCmd          B                   Export
013800030805     D                 Pi            10i 0
013900030804     D  PxCmdStr                   1024a   Const  Varying
014000050917
014100030804     **-- Local variables:
014200050917     D CPOP0100        Ds                  Qualified
014300050917     D  TypPrc                       10i 0 Inz( 2 )
014400050917     D  DBCS                          1a   Inz( '0' )
014500050917     D  PmtAct                        1a   Inz( '2' )
014600050917     D  CmdStx                        1a   Inz( '0' )
014700050917     D  MsgRtvKey                     4a   Inz( *Allx'00' )
014800050917     D  Rsv                           9a   Inz( *Allx'00' )
014900000320     **
015000050917     D ChgCmd          s          32767a
015100050917     D ChgCmdAvl       s             10i 0
015200000320     **
015300050917     D ERRC0100        Ds                  Qualified
015400050917     D  BytPro                       10i 0 Inz( 0 )
015500030803     **
015600030823     D TypTbl          Ds
015700030823     D  MsgTyps                      10a   Dim( 2 )
015800030823     D                               20a   Overlay( TypTbl )
015900030823     D                                     Inz( '*DIAG     *ESCAPE ' )
016000050917
016100050917      /Free
016200050917
016300050917        CallP(e)  PrcCmds( PxCmdStr
016400050917                         : %Len( PxCmdStr )
016500050917                         : CPOP0100
016600050917                         : %Size( CPOP0100 )
016700050917                         : 'CPOP0100'
016800050917                         : ChgCmd
016900050917                         : %Size( ChgCmd )
017000050917                         : ChgCmdAvl
017100050917                         : ERRC0100
017200050917                         );
017300050917
017400050917        If  %Error;
017500050917
017600050917          CallP(e)  MovPgmMsgs( *Blanks
017700050917                              : MsgTyps
017800050917                              : %Elem( MsgTyps )
017900050917                              : '*PGMBDY'
018000050917                              : 1
018100050917                              : ERRC0100
018200050917                              );
018300050917
018400050917          Return  -1;
018500050917        EndIf;
018600050917
018700050917        Return  0;
018800050917
018900050917      /End-Free
019000050917
019100000320     P PrcCmd          E
019200000602     **-- Get string:  -------------------------------------------------------**
019300000602     P GetStr          B                   Export
019400030823     D                 Pi          1024a   Varying
019500000602     D  StrPtr                         *   Value
019600050917
019700050917      /Free
019800050917
019900050917        If  StrPtr = *Null;
020000050917          Return  NULL;
020100050917
020200050917        Else;
020300050917          Return  %Str( StrPtr );
020400050917        EndIf;
020500050917
020600050917      /End-Free
020700050917
020800000602     P GetStr          E
