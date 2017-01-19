000100041201     **
000200050107     **  Program . . : CBX9281
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
002300041202     **    CrtRpgMod   Module( CBX9281 )
002400041201     **                DbgView( *NONE )
002500041201     **                Aut( *USE )
002600041201     **
002700041202     **    CrtPgm      Pgm( CBX9281 )
002800041202     **                Module( CBX9281 )
002900041201     **                ActGrp( *NEW )
003000041201     **                UsrPrf( *OWNER )
003100041201     **                Aut( *USE )
003200041201     **
003300041202     **    ChgObjOwn   Obj( CBX9281 )
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
004900041201
005000040723     **-- API error data structure:
005100040723     D ERRC0100        Ds                  Qualified
005200040723     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
005300040723     D  BytAvl                       10i 0
005400041201     D  MsgId                         7a
005500040723     D                                1a
005600041201     D  MsgDta                      512a
005700040723
005800041201     **-- Check user special authority
005900041201     D ChkUsrSpcAut    Pr                  ExtPgm( 'QSYCUSRS' )
006000041201     D  CsAutInf                      1a
006100041201     D  CsUsrPrf                     10a   Const
006200041201     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
006300041201     D  CsNbrAut                     10i 0 Const
006400041201     D  CsCalLvl                     10i 0 Const
006500041201     D  CsError                   32767a          Options( *VarSize )
006600041201     **-- Send program message:
006700041201     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
006800041201     D  SpMsgId                       7a   Const
006900041201     D  SpMsgFq                      20a   Const
007000041201     D  SpMsgDta                    128a   Const
007100041201     D  SpMsgDtaLen                  10i 0 Const
007200041201     D  SpMsgTyp                     10a   Const
007300041201     D  SpCalStkE                    10a   Const  Options( *VarSize )
007400041201     D  SpCalStkCtr                  10i 0 Const
007500041201     D  SpMsgKey                      4a
007600041201     D  SpError                    1024a          Options( *VarSize )
007700041201
007800041201     **-- Send escape message:
007900041201     D SndEscMsg       Pr            10i 0
008000041201     D  PxMsgId                       7a   Const
008100041201     D  PxMsgDta                    512a   Const  Varying
008200040727
008300041202     D CBX9281         Pr
008400041201     D  PxUsrPrf                     10a
008500041201     D  PxSpcAut                           LikeDs( SpcAut )
008600041201     D  PxAutFlg                      1a
008700041201     **
008800041202     D CBX9281         Pi
008900041201     D  PxUsrPrf                     10a
009000041201     D  PxSpcAut                           LikeDs( SpcAut )
009100041201     D  PxAutFlg                      1a
009200040723
009300040723      /Free
009400040723
009500041201        ChkUsrSpcAut( AutFlg
009600041201                    : PxUsrPrf
009700041201                    : PxSpcAut.AutVal
009800041201                    : PxSpcAut.NbrAut
009900041203                    : ADP_PRV_INVLVL
010000041201                    : ERRC0100
010100041201                    );
010200040723
010300041201        If  ERRC0100.BytAvl > *Zero;
010400050107
010500041201          SndEscMsg( ERRC0100.MsgId
010600041201                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
010700041201                   );
010800050107
010900041201        Else;
011000041201          PxAutFlg = AutFlg;
011100040723        EndIf;
011200040723
011300041201        *InLr = *On;
011400040723        Return;
011500040723
011600040723      /End-Free
011700040723
011800041201     **-- Send escape message:  ----------------------------------------------**
011900041201     P SndEscMsg       B
012000041201     D                 Pi            10i 0
012100041201     D  PxMsgId                       7a   Const
012200041201     D  PxMsgDta                    512a   Const  Varying
012300041201     **
012400041201     D MsgKey          s              4a
012500041201
012600041201      /Free
012700041201
012800041201        SndPgmMsg( PxMsgId
012900041201                 : 'QCPFMSG   *LIBL'
013000041201                 : PxMsgDta
013100041201                 : %Len( PxMsgDta )
013200041201                 : '*ESCAPE'
013300041201                 : '*PGMBDY'
013400041201                 : 1
013500041201                 : MsgKey
013600041201                 : ERRC0100
013700041201                 );
013800041201
013900041201        If  ERRC0100.BytAvl > *Zero;
014000041201          Return  -1;
014100041201
014200041201        Else;
014300041201          Return   0;
014400041201        EndIf;
014500041201
014600041201      /End-Free
014700041201
014800041201     P SndEscMsg       E
