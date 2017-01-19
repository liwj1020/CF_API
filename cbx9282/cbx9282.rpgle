000100041201     **
000200041202     **  Program . . : CBX9282
000300041201     **  Description : Check user special authority - CPP
000400041201     **  Author  . . : Carsten Flensburg
000500041201     **
000600041201     **
000700041201     **  Authority and security restrictions:
000800041201     **    To successfully run this program *ALLOBJ special authority is
000900041201     **    necessary.  The required authority can be obtained by means of
001000041201     **    adopted authority:
001100041201     **
001200041201     **    -  Change the program object's USRPRF attribute to *OWNER using
001300041201     **       the CHGPGM command.
001400041201     **
001500041201     **    -  Change the program object owner to QSECOFR using the CHGOBJOWN
001600041201     **       command.
001700041201     **
001800041201     **    If you successfully follow the compile and setup instructions below,
001900041201     **    the program will be capable of performing the necessary operations.
002000041201     **
002100041201     **
002200041201     **  Compile and setup instructions:
002300041202     **    CrtRpgMod   Module( CBX9282 )
002400041201     **                DbgView( *NONE )
002500041201     **                Aut( *USE )
002600041201     **
002700041202     **    CrtPgm      Pgm( CBX9282 )
002800041202     **                Module( CBX9282 )
002900041201     **                ActGrp( *NEW )
003000041201     **                UsrPrf( *OWNER )
003100041201     **                Aut( *USE )
003200041201     **
003300041202     **    ChgObjOwn   Obj( CBX9282 )
003400041201     **                ObjType( *PGM )
003500041201     **                NewOwn( QSECOFR )
003600041201     **
003700041201     **
003800040723     **-- Control specification:  --------------------------------------------**
003900041201     H Option( *SrcStmt )
004000040723
004100041201     **-- Global variables:
004200041201     D AutFlg          s              1a
004300041201     **
004400041201     D SpcAut          Ds                  Qualified
004500041201     D  NbrAut                        5i 0
004600041201     D  AutVal                       10a   Dim( 8 )
004700041203     **-- Global constants:
004800041203     D ADP_PRV_INVLVL  c                   1
004900050107     D NULL            c                   ''
005000041201
005100040723     **-- API error data structure:
005200040723     D ERRC0100        Ds                  Qualified
005300040723     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
005400040723     D  BytAvl                       10i 0
005500041201     D  MsgId                         7a
005600040723     D                                1a
005700041201     D  MsgDta                      512a
005800040723
005900041201     **-- Check user special authority
006000041201     D ChkUsrSpcAut    Pr                  ExtPgm( 'QSYCUSRS' )
006100041201     D  CsAutInf                      1a
006200041201     D  CsUsrPrf                     10a   Const
006300041201     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
006400041201     D  CsNbrAut                     10i 0 Const
006500041201     D  CsCalLvl                     10i 0 Const
006600041201     D  CsError                   32767a          Options( *VarSize )
006700041202     **-- Retrieve job information:
006800041202     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
006900041202     D  RiRcvVar                  32767a         Options( *VarSize )
007000041202     D  RiRcvVarLen                  10i 0 Const
007100041202     D  RiFmtNam                      8a   Const
007200041202     D  RiJobNamQ                    26a   Const
007300041202     D  RiJobIntId                   16a   Const
007400041202     D  RiError                   32767a         Options( *NoPass: *VarSize )
007500041201     **-- Send program message:
007600041201     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
007700041201     D  SpMsgId                       7a   Const
007800041201     D  SpMsgFq                      20a   Const
007900041201     D  SpMsgDta                    128a   Const
008000041201     D  SpMsgDtaLen                  10i 0 Const
008100041201     D  SpMsgTyp                     10a   Const
008200041201     D  SpCalStkE                    10a   Const  Options( *VarSize )
008300041201     D  SpCalStkCtr                  10i 0 Const
008400041201     D  SpMsgKey                      4a
008500041201     D  SpError                    1024a          Options( *VarSize )
008600041201
008700041201     **-- Send escape message:
008800041201     D SndEscMsg       Pr            10i 0
008900041201     D  PxMsgId                       7a   Const
009000041201     D  PxMsgDta                    512a   Const  Varying
009100040727
009200041202     D CBX9282         Pr
009300041201     D  PxUsrPrf                     10a
009400041201     D  PxSpcAut                           LikeDs( SpcAut )
009500041201     **
009600041202     D CBX9282         Pi
009700041201     D  PxUsrPrf                     10a
009800041201     D  PxSpcAut                           LikeDs( SpcAut )
009900040723
010000040723      /Free
010100040723
010200041201        ChkUsrSpcAut( AutFlg
010300041201                    : PxUsrPrf
010400041201                    : PxSpcAut.AutVal
010500041201                    : PxSpcAut.NbrAut
010600041203                    : ADP_PRV_INVLVL
010700041201                    : ERRC0100
010800041201                    );
010900040723
011000041201        If  ERRC0100.BytAvl > *Zero;
011100050107
011200041201          SndEscMsg( ERRC0100.MsgId
011300041201                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
011400041201                   );
011500050107
011600041201        Else;
011700041202          If  AutFlg = 'N';
011800050107
011900050107            SndEscMsg( 'CPFB304': NULL );
012000041202          EndIf;
012100040723        EndIf;
012200040723
012300041201        *InLr = *On;
012400040723        Return;
012500040723
012600040723      /End-Free
012700040723
012800041201     **-- Send escape message:  ----------------------------------------------**
012900041201     P SndEscMsg       B
013000041201     D                 Pi            10i 0
013100041201     D  PxMsgId                       7a   Const
013200041201     D  PxMsgDta                    512a   Const  Varying
013300041201     **
013400041201     D MsgKey          s              4a
013500041201
013600041201      /Free
013700041201
013800041201        SndPgmMsg( PxMsgId
013900041201                 : 'QCPFMSG   *LIBL'
014000041201                 : PxMsgDta
014100041201                 : %Len( PxMsgDta )
014200041201                 : '*ESCAPE'
014300041201                 : '*PGMBDY'
014400041201                 : 1
014500041201                 : MsgKey
014600041201                 : ERRC0100
014700041201                 );
014800041201
014900041201        If  ERRC0100.BytAvl > *Zero;
015000041201          Return  -1;
015100041201
015200041201        Else;
015300041201          Return   0;
015400041201        EndIf;
015500041201
015600041201      /End-Free
015700041201
015800041201     P SndEscMsg       E
