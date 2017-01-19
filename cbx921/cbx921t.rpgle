000100040821     **-- Header specifications:  --------------------------------------------**
000200041204     H  Option( *SrcStmt )
000300041204     **
000400041204     D AudLvl          s              1a
000500040821     **-- API error information:
000600040821     D ERRC0100        Ds                  Qualified
000700040821     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
000800040821     D  BytAvl                       10i 0
000900040821     D  MsgId                         7a
001000040821     D                                1a
001100040821     D  MsgDta                      128a
001200040821     **-- Retrieve user information:
001300040821     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
001400040821     D  RuRcvVar                  32767a          Options( *VarSize )
001500040821     D  RuRcvVarLen                  10i 0 Const
001600040821     D  RuFmtNam                     10a   Const
001700040821     D  RuUsrPrf                     10a   Const
001800040821     D  RuError                   32767a          Options( *VarSize )
001900040821
002000041204     **-- Retrieve user audit:
002100041204     D RtvUsrAud       Pr             1a
002200041204     D  PxUsrPrf                     10a   Value
002300041204     D  PxAudVal                     10a   Value
002400041204
002500040821      /Free
002600040822
002700041204          AudLvl = RtvUsrAud( 'CF101': '*CMD' );
002800041204
002900041204          Return;
003000041204
003100041204      /End-Free
003200041204
003300041204     **-- Retrieve user audit value:  ----------------------------------------**
003400041204     P RtvUsrAud       B                   Export
003500041204     D                 Pi             1a
003600040821     D  PxUsrPrf                     10a   Value
003700041204     D  PxAudVal                     10a   Value
003800040821     **
003900040821     D USRI0300        Ds                  Qualified
004000040821     D  BytRtn                       10i 0
004100040821     D  BytAvl                       10i 0
004200040821     D  UsrPrf                       10a
004300041204     D  UsrAud                             Overlay( USRI0300: 511 )
004400041204     D                                     LikeDs( AudLvl )
004500041204     **
004600041204     D AudLvl          Ds                  Qualified
004700041204     D  Cmd                           1a
004800041204     D  Create                        1a
004900041204     D  Delete                        1a
005000041204     D  JobDta                        1a
005100041204     D  ObjMgt                        1a
005200041204     D  OfcSrv                        1a
005300041204     D  PgmAdp                        1a
005400041204     D  SavRst                        1a
005500041204     D  Security                      1a
005600041204     D  Service                       1a
005700041204     D  SplfDta                       1a
005800041204     D  SysMgt                        1a
005900041204     D  Optical                       1a
006000040821
006100040821      /Free
006200040821
006300040821        RtvUsrInf( USRI0300
006400040821                 : %Size( USRI0300 )
006500040821                 : 'USRI0300'
006600040821                 : PxUsrPrf
006700040821                 : ERRC0100
006800040821                 );
006900040821
007000041204        Select;
007100041204        When  ERRC0100.BytAvl > *Zero;
007200041204          Return  *Blank;
007300041204
007400041204        When  PxAudVal = '*CMD';
007500041204          Return  USRI0300.UsrAud.Cmd;
007600041204
007700041204        When  PxAudVal = '*CREATE';
007800041204          Return  USRI0300.UsrAud.Create;
007900041204
008000041204        When  PxAudVal = '*DELETE';
008100041204          Return  USRI0300.UsrAud.Delete;
008200041204
008300041204        When  PxAudVal = '*JOBDTA';
008400041204          Return  USRI0300.UsrAud.JobDta;
008500041204
008600041204        When  PxAudVal = '*OBJMGT';
008700041204          Return  USRI0300.UsrAud.ObjMgt;
008800041204
008900041204        When  PxAudVal = '*OFCSRV';
009000041204          Return  USRI0300.UsrAud.OfcSrv;
009100041204
009200041204        When  PxAudVal = '*OPTICAL';
009300041204          Return  USRI0300.UsrAud.Optical;
009400041204
009500041204        When  PxAudVal = '*PGMADP';
009600041204          Return  USRI0300.UsrAud.PgmAdp;
009700041204
009800041204        When  PxAudVal = '*SAVRST';
009900041204          Return  USRI0300.UsrAud.SavRst;
010000041204
010100041204        When  PxAudVal = '*SECURITY';
010200041204          Return  USRI0300.UsrAud.Security;
010300041204
010400041204        When  PxAudVal = '*SERVICE';
010500041204          Return  USRI0300.UsrAud.Service;
010600041204
010700041204        When  PxAudVal = '*SPLFDTA';
010800041204          Return  USRI0300.UsrAud.SplfDta;
010900041204
011000041204        When  PxAudVal = '*SYSMGT';
011100041204          Return  USRI0300.UsrAud.SysMgt;
011200041204
011300041204        Other;
011400041204          Return  *Blank;
011500041204        EndSl;
011600040821
011700040821      /End-Free
011800040821
011900041204     P RtvUsrAud       E
