000100040711     **
000200040715     **  Program . . : CBX9181
000300040712     **  Description : Retrieve & send encrypted user password
000400040711     **  Author  . . : Carsten Flensburg
000500040711     **
000600040711     **
000700040711     **  Program description:
000800040715     **    After registering this program as a user profile event exit
000900040715     **    program - see instructions below - the exit point will call
001000040715     **    this program every time the related user profile event is
001100040715     **    performed (create, change, restore or delete user profile).
001200040715     **
001300040715     **    Based on the passed information a data queue entry is generated
001400040715     **    and put on a DDM data queue pointing to a remote system to where
001500040715     **    the change to the local user profile's password or existence
001600040716     **    should be mirrored.
001700040715     **
001800040715     **    In this sample application only user profiles having a user
001900040715     **    class of *USER will generate a data queue entry.
002000040715     **
002100040716     **
002200040716     **  Programmer's notes:
002300040716     **    Service program CBX918S should either be located in a library
002400040716     **    present in the library list of all jobs directly or indirectly
002500040716     **    - through exit point - calling the CBX9181 and CBX9182 programs
002600040716     **    or the library of CBX918S should be specified directly on the
002700040716     **    the CRTPGM command's BNDSRVPGM parameter.
002800040716     **
002900040715     **
003000040711     **  Exit point registration:
003100040711     **
003200040711     **    AddExitPgm ExitPnt( QIBM_QSY_CRT_PROFILE )
003300040711     **               Format( CRTP0100 )
003400040711     **               PgmNbr( *LOW )
003500040711     **               Pgm( <library>/CBX9181 )
003600040711     **               PgmDta( *NONE )
003700040715     **
003800040711     **    AddExitPgm ExitPnt( QIBM_QSY_CHG_PROFILE )
003900040711     **               Format( CHGP0100 )
004000040711     **               PgmNbr( *LOW )
004100040711     **               Pgm( <library>/CBX9181 )
004200040711     **               PgmDta( *NONE )
004300040711     **
004400040711     **    AddExitPgm ExitPnt( QIBM_QSY_RST_PROFILE )
004500040711     **               Format( RSTP0100 )
004600040711     **               PgmNbr( *LOW )
004700040711     **               Pgm( <library>/CBX9181 )
004800040711     **               PgmDta( *NONE )
004900040711     **
005000040711     **    AddExitPgm ExitPnt( QIBM_QSY_DLT_PROFILE )
005100040711     **               Format( DLTP0100 )
005200040711     **               PgmNbr( *LOW )
005300040711     **               Pgm( <library>/CBX9181 )
005400040711     **               PgmDta( *NONE )
005500040711     **
005600040711     **
005700040711     **  Create user profile event notification setup:
005800040711     **
005900040711     **    CrtDtaQ    Dtaq( <library>/<data queue> )
006000040711     **               Type( *DDM )
006100040711     **               RmtDtaQ( QGPL/USRPRFEVT )
006200040711     **               RmtLocName( <remote system> )
006300040711     **               Dev( *LOC )
006400040711     **               LclLocName( *LOC )
006500040711     **               Mode( *NETATR )
006600040711     **               RmtNetId( *LOC )
006700040711     **               Text( 'User profile event notification - source' )
006800040711     **
006900040711     **    Example:   CrtDtaQ    Dtaq( QGPL/USRPRFEVT )
007000040711     **                          Type( *DDM )
007100040711     **                          RmtDtaQ( QGPL/USRPRFEVT )
007200040711     **                          RmtLocName( <remote system> )
007300040711     **                          Dev( *LOC )
007400040711     **                          LclLocName( *LOC )
007500040711     **                          Mode( *NETATR )
007600040711     **                          RmtNetId( *LOC )
007700040711     **                          Text( 'User profile event notification - source' )
007800040711     **
007900040711     **               - The above example assumes that the default values
008000040711     **                 for the SNA configuration parameters are mapping to
008100040711     **                 the correct values for the source and target systems.
008200040711     **
008300040711     **                 Details about the SNA configuration parameters can be
008400040711     **                 found in the IBM Software Knowledge Base document
008500040711     **                 number 15863050:
008600040711     **
008700040714     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
008800040714     **                          1ac66549a21402188625680b0002037e/
008900040714     **                          66603a67c13a4f118625676a00601dd6?OpenDocument
009000040711     **
009100040714     **                 Details about a SNA configuration over TCP/IP using
009200040714     **                 AnyNet can likewise be found in the IBM Software
009300040714     **                 Knowledge Base document number 8923426:
009400040714     **
009500040714     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
009600040714     **                          1ac66549a21402188625680b0002037e/
009700040714     **                          c5057870085200f8862565c2007cdc47?OpenDocument
009800070524     **
009900070524     **                 The easiest way to configure DDM data queue support
010000070524     **                 over TCP/IP is however to use the Relational Database
010100070524     **                 Directory (RDB) method. The following IBM Software
010200070524     **                 Knowledge Base document number 8923426 describes
010300070524     **                 how to configure this type of connection:
010400070524     **
010500070524     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
010600070524     **                   21401ac66549a2188625680b0002037e/e95c5072635554dd86256e9800
010700070524     **                   e95c5072635554dd86256e980068aada?OpenDocument
010800070524     **
010900070524     **
011000040711     **
011100040714     **
011200040714     **  Authority and security restrictions:
011300040714     **    To retrieve and set an encrypted user password *ALLOBJ and *SECADM
011400040714     **    special authority is required.  To change a user password using the
011500040714     **    QSYCHGPW API, *ALLOBJ special authority and *USE authority to the
011600040714     **    user profile to be changed is required.                          ch
011700040714     **
011800040714     **    If appropriate, the required authority can be obtained by means of
011900040714     **    adopted authority:  Change the program object's UsrPrf attribute
012000040714     **    to *OWNER using the ChgPgm command, and change the program object
012100040714     **    owner to a user profile having sufficient authority using the
012200040714     **    ChgObjOwn command:
012300040714     **
012400040714     **      ChpPgm     Pgm( CBX9181 )  UsrPrf( *OWNER )
012500040714     **      ChgObjOwn  Obj( CBX9181 )  ObjType( *PGM )  NewOwn( <user profile> )
012600040714     **
012700040711     **
012800040711     **  Compilation specification:
012900040711     **
013000040714     **    CrtRpgMod  Module( CBX9181 )
013100040714     **               DbgView( *NONE )
013200040711     **
013300040714     **    CrtPgm     Pgm( CBX9181 )
013400040714     **               Module( CBX9181 )
013500040716     **               BndSrvPgm( CBX918S )
013600040714     **               ActGrp( QILE )
013700040711     **
013800040711     **
013900040711     **-- Header specifications:  --------------------------------------------**
014000040714     H Option( *SrcStmt )
014100040716     **-- API error data structure:
014200040715     D ApiError        Ds
014300990817     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
014400990817     D  AeBytAvl                     10i 0
014500990817     D  AeExcpId                      7a
014600990817     D                                1a
014700990817     D  AeExcpDta                   256a
014800040716     **-- Encrypted password receiver variable:
014900040711     D UPWD0100        Ds                  Qualified
015000040711     D  BytRtn                       10i 0
015100040711     D  BytAvl                       10i 0
015200040711     D  UsrPrf                       10a
015300040712     D  PwdDtaEnc                  4096a
015400040711     **-- User profile event structure:
015500040711     D UsrPrfEvt       Ds                  Qualified
015600040711     D  RcdTyp                        5a   Inz( '*PRFE' )
015700040711     D  UsrPrf                       10a
015800040711     D  UsrPrfAct                     3a
015900040711     D  SysNam                        8a
016000040711     D  SysRls                        6a
016100040711     D  PwdLvl                       10i 0
016200040711     D  PwdDta                             LikeDs( UPWD0100 )
016300040711     **
016400040712     **-- Retrieve encrypted user password:
016500040712     D RtvUsrPwd       Pr                  ExtPgm( 'QSYRUPWD' )
016600040712     D  RpRcvVar                  32767a          Options( *VarSize )
016700040712     D  RpRcvVarLen                  10i 0 Const
016800040712     D  RpFmtNam                      8a   Const
016900040712     D  RpUsrPrf                     10a   Const
017000040712     D  RpError                   32767a          Options( *VarSize )
017100040714     **-- Change user password:
017200040714     D ChgUsrPwd       Pr                  ExtPgm( 'QSYCHGPW' )
017300040714     D  CpUsrId                      10a   Const
017400040714     D  CpCurPwd                    128a   Const  Options( *VarSize )
017500040714     D  CpNewPwd                    128a   Const  Options( *VarSize )
017600040714     D  CpError                   32767a          Options( *VarSize )
017700040714     D  CpCurPwdLen                  10i 0 Const  Options( *NoPass )
017800040714     D  CpCurPwdCcsId                10i 0 Const  Options( *NoPass )
017900040714     D  CpNewPwdLen                  10i 0 Const  Options( *NoPass )
018000040714     D  CpNewPwdCcsId                10i 0 Const  Options( *NoPass )
018100040712     **-- Send data queue entry:
018200040712     D SndDtaQe        Pr                  ExtPgm( 'QSNDDTAQ' )
018300040712     D  SqName                       10a   Const
018400040712     D  SqLib                        10a   Const
018500040712     D  SqDtaLen                      5p 0 Const
018600040712     D  SqDta                     32767a   Const  Options( *VarSize )
018700040712     D  SqKeyLen                      3p 0 Const  Options( *NoPass )
018800040712     D  SqKey                       256a   Const  Options( *VarSize: *NoPass )
018900040711     **-- Get system password level:
019000040711     D GetPwdLvl       Pr            10i 0
019100040711     **-- Get system name:
019200040711     D GetSysNam       Pr             8a   Varying
019300040711     **-- Get system release level:
019400040711     D GetRlsLvl       Pr             6a
019500040711     **-- Get user last password change timestamp:  --------------------------**
019600040711     D GetPwdDts       Pr              z
019700040711     D  PxUsrPrf                     10a   Value
019800040712     **-- Get user class:
019900040712     D GetUsrCls       Pr            10a   Varying
020000040712     D  PxUsrPrf                     10a   Value
020100040716     **
020200040716     **-- User profile exit parameter:
020300040716     D XitParm         Ds                  Qualified
020400040716     D  XitPntNam                    20a
020500040716     D  XitPntFmt                     8a
020600040716     D   UsrPrfAct                    3a   Overlay( XitPntFmt: 1 )
020700040716     D  UsrPrf                       10a
020800040716     **-- Entry parameter:
020900040716     D CBX9181         Pr
021000040716     D  PxXitParm                          Like( XitParm )
021100040716     **
021200040716     D CBX9181         Pi
021300040716     D  PxXitParm                          Like( XitParm )
021400040711
021500040711      /Free
021600040712
021700040716        XitParm  = PxXitParm;
021800040716
021900040714        If  XitParm.XitPntFmt  = 'CRTP0100'  Or
022000040714            XitParm.XitPntFmt  = 'CHGP0100'  Or
022100040714            XitParm.XitPntFmt  = 'RSTP0100'  Or
022200040714            XitParm.XitPntFmt  = 'DLTP0100';
022300040712
022400040712          If  GetUsrCls( XitParm.UsrPrf ) = '*USER';
022500040605
022600040714            If  XitParm.UsrPrfAct  = 'CRT'  Or
022700040714                XitParm.UsrPrfAct  = 'RST'  Or
022800040714                XitParm.UsrPrfAct  = 'CHG'  And
022900040712                %Diff( %Timestamp()
023000040712                     : GetPwdDts( XitParm.UsrPrf )
023100040712                     : *Seconds
023200040714                     )             < 5;
023300040711
023400040712              RtvUsrPwd( UPWD0100: %Size( UPWD0100 ): 'UPWD0100'
023500040712                       : XitParm.UsrPrf
023600040712                       : ApiError
023700040712                       );
023800040711
023900040712            Else;
024000040712              Clear  UPWD0100;
024100040712            EndIf;
024200040711
024300040712            UsrPrfEvt.UsrPrf    = XitParm.UsrPrf;
024400040712            UsrPrfEvt.UsrPrfAct = XitParm.UsrPrfAct;
024500040712            UsrPrfEvt.SysNam    = GetSysNam();
024600040712            UsrPrfEvt.PwdLvl    = GetPwdLvl();
024700040712            UsrPrfEvt.SysRls    = GetRlsLvl();
024800040712            UsrPrfEvt.PwdDta    = UPWD0100;
024900040711
025000040712            SndDtaQe( 'USRPRFEVT'
025100040712                    : 'QGPL'
025200040712                    : %Size( UsrPrfEvt )
025300040712                    : UsrPrfEvt
025400040712                    );
025500040711
025600040712          EndIf;
025700040712        EndIf;
025800040605
025900040605        Return;
026000040605
026100040711      /End-Free
