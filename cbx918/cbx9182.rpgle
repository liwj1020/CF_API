000100040712     **
000200040712     **  Program . . : CBX9182
000300040716     **  Description : Receive & set encrypted user password
000400040712     **  Author  . . : Carsten Flensburg
000500040712     **
000600040712     **
000700040712     **  Program description:
000800040716     **    This program waits on the specified data queue for entries to
000900040716     **    arrive.  Each received data queue entry is, if identified
001000040716     **    correctly, processed in accordance with the user profile event
001100040716     **    that generated it:
001200040716     **
001300040716     **    1. User profiles having been created and restored are ignored
001400040716     **       and an informational message is sent to the user profile
001500040716     **       runnning this program.
001600040716     **
001700040716     **    2. User profiles having had their password changed will have
001800040716     **       the new password applied to the local user profile.
001900040716     **
002000040716     **    3. User profiles having been deleted will have a password value
002100040716     **       of *NONE applied to the local user profile.
002200040716     **
002300040716     **    The above actions will only occur if the following criteria are
002400040716     **    met:
002500040716     **
002600040716     **    1. The local user profile user class must be *USER.
002700040716     **
002800040716     **    2. The local system name must be different from the system name
002900040716     **       where the data queue entry was generated.
003000040716     **
003100040716     **    3. The release level must be the same for both the remote and
003200040716     **       the local system.
003300040716     **
003400040716     **    4. The password level must be the same for both the remote and
003500040716     **       the local system.
003600040716     **
003700040716     **    The above events and rules are naturally subject to any change
003800040716     **    that might be appropriate for any individual installation.
003900040716     **
004000040716     **
004100040716     **  Programmer's notes:
004200040716     **    The programs CBX9181 and CBX9182 along with CBX918S are intended
004300040716     **    to offer a starting point for an iSeries password synchronization
004400040716     **    facility.  The most obvious considerations and restrictions are
004500040716     **    taken into account, but it is important to emphasize that further
004600040716     **    individual aspects should be investigated thoroughly before any
004700040716     **    attempts are made to put this type of utility into production.
004800040716     **
004900040716     **
005000040716     **    Service program CBX918S should either be located in a library
005100040716     **    present in the library list of all jobs directly or indirectly
005200040716     **    - through exit point - calling the CBX9181 and CBX9182 programs
005300040716     **    or the library of CBX918S should be specified directly on the
005400040716     **    the CRTPGM command's BNDSRVPGM parameter.
005500040716     **
005600040716     **
005700040716     **    To ensure that the arriving data queue entries are processed
005800040716     **    immediately, this program should be submitted to a job queue
005900040716     **    available for a never ending processing type of job:
006000040716     **
006100040716     **      SbmJob Cmd( CALL PGM( CBX9182 ))
006200040716     **             Job( SECPRFEVT )
006300040716     **             JobQ( <job queue name> )
006400040716     **
006500040716     **    To end the job controlled, run the following command:
006600040716     **
006700040716     **      EndJob Job( SECPRFEVT )
006800040716     **             Option( *CNTRLD )
006900040716     **             Delay( 30 )
007000040716     **
007100040716     **    Option controlled and delay 30 seconds will allow the job
007200040716     **    to detect the end request and stop processing gracefully.
007300040716     **
007400040712     **
007500040712     **  Create user profile event notification setup:
007600040712     **
007700040712     **    CrtDtaQ    Dtaq( <library>/<data queue> )
007800040712     **               MaxLen( 4150 )
007900040712     **               Seq( *FIFO )
008000040712     **               Size( *MAX2GB )
008100040712     **               AutoRcl( *YES )
008200040712     **               Text( 'User profile event notification - target' )
008300040712     **
008400040712     **    Example:   CrtDtaQ    Dtaq( QGPL/USRPRFEVT )
008500040712     **                          MaxLen( 4150 )
008600040712     **                          Seq( *FIFO )
008700040712     **                          Size( *MAX2GB )
008800040712     **                          AutoRcl( *YES )
008900040712     **                          Text( 'User profile event notification - target' )
009000040712     **
009100040714     **
009200040714     **  Authority and security restrictions:
009300040714     **    To retrieve and set an encrypted user password *ALLOBJ and *SECADM
009400040714     **    special authority is required.  To change a user password using the
009500040714     **    QSYCHGPW API, *ALLOBJ special authority and *USE authority to the
009600040714     **    user profile to be changed is required.                          ch
009700040714     **
009800040714     **    If appropriate, the required authority can be obtained by means of
009900040714     **    adopted authority:  Change the program object's UsrPrf attribute
010000040714     **    to *OWNER using the ChgPgm command, and change the program object
010100040714     **    owner to a user profile having sufficient authority using the
010200040714     **    ChgObjOwn command:
010300040714     **
010400040714     **      ChpPgm     Pgm( CBX9182 )  UsrPrf( *OWNER )
010500040714     **      ChgObjOwn  Obj( CBX9182 )  ObjType( *PGM )  NewOwn( <user profile> )
010600040714     **
010700040712     **
010800040712     **  Compilation specification:
010900040712     **
011000040714     **    CrtRpgMod  Module( CBX9182 )
011100040714     **               DbgView( *NONE )
011200040712     **
011300040714     **    CrtPgm     Pgm( CBX9182 )
011400040714     **               Module( CBX9182 )
011500040716     **               BndSrvPgm( CBX918S )
011600040714     **               ActGrp( QILE )
011700040716     **
011800040712     **
011900040712     **-- Header specifications:  --------------------------------------------**
012000040714     H Option( *SrcStmt )
012100040714     **-- System information:
012200040715     D PgmSts         SDs                  NoOpt
012300040714     D  PsPgmNam         *Proc
012400040714     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
012500040714     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
012600040714     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
012700040714     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
012800040605     **-- API Error data structure:
012900040715     D ApiError        Ds
013000990817     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
013100990817     D  AeBytAvl                     10i 0
013200990817     D  AeExcpId                      7a
013300990817     D                                1a
013400990817     D  AeExcpDta                   256a
013500040712     **-- API receiver variable:
013600040712     D UPWD0100        Ds                  Qualified
013700040712     D  BytRtn                       10i 0
013800040712     D  BytAvl                       10i 0
013900040712     D  UsrPrf                       10a
014000040712     D  PwdDtaEnc                  4096a
014100040712     **-- User profile event structure:
014200040712     D UsrPrfEvt       Ds                  Qualified
014300040712     D  RcdTyp                        5a
014400040712     D  UsrPrf                       10a
014500040712     D  UsrPrfAct                     3a
014600040712     D  SysNam                        8a
014700040712     D  SysRls                        6a
014800040712     D  PwdLvl                       10i 0
014900040712     D  PwdDta                             LikeDs( UPWD0100 )
015000040714     **-- Global variables:
015100040714     D RtnCod          s             10i 0
015200040714     **-- Data queue API parameters:
015300040712     D DqDtaLen        s              5p 0
015400040714     D DQ_WAIT_SEC     c                   25
015500040712     **-- Retrieve data queue entry:
015600040714     D RcvDtaQe        Pr                  ExtPgm( 'QRCVDTAQ' )
015700040712     D  RqName                       10a   Const
015800040712     D  RqLib                        10a   Const
015900040712     D  RqDtaLen                      5p 0
016000040712     D  RqDta                     32767a          Options( *VarSize )
016100040712     D  RqWait                        5p 0 Const
016200040712     D  RqKeyOrder                    2a   Const  Options( *NoPass )
016300040712     D  RqKeyLen                      3p 0 Const  Options( *NoPass )
016400040712     D  RqKey                       256a   Const  Options( *VarSize: *NoPass )
016500040712     D  RqSndInLg                     3p 0 Const  Options( *NoPass)
016600040712     D  RqSndInfo                    44a          Options( *VarSize: *Nopass )
016700040605     **-- Set encrypted user password:
016800040605     D SetUsrPwd       Pr                  ExtPgm( 'QSYSUPWD' )
016900040605     D  SpInpVar                  32767a          Options( *VarSize )
017000040605     D  SpFmtNam                      8a   Const
017100040605     D  SpError                   32767a          Options( *VarSize )
017200040714     **-- Change user password:
017300040714     D ChgUsrPwd       Pr                  ExtPgm( 'QSYCHGPW' )
017400040714     D  CpUsrId                      10a   Const
017500040714     D  CpCurPwd                    128a   Const  Options( *VarSize )
017600040714     D  CpNewPwd                    128a   Const  Options( *VarSize )
017700040714     D  CpError                   32767a          Options( *VarSize )
017800040714     D  CpCurPwdLen                  10i 0 Const  Options( *NoPass )
017900040714     D  CpCurPwdCcsId                10i 0 Const  Options( *NoPass )
018000040714     D  CpNewPwdLen                  10i 0 Const  Options( *NoPass )
018100040714     D  CpNewPwdCcsId                10i 0 Const  Options( *NoPass )
018200040712     **
018300040712     **-- Get system password level:
018400040712     D GetPwdLvl       Pr            10i 0
018500040712     **-- Get system name:
018600040712     D GetSysNam       Pr             8a   Varying
018700040712     **-- Get system release level:
018800040712     D GetRlsLvl       Pr             6a
018900040714     **-- Get user last password change timestamp:
019000040712     D GetPwdDts       Pr              z
019100040712     D  PxUsrPrf                     10a   Value
019200040712     **-- Get user class:
019300040712     D GetUsrCls       Pr            10a   Varying
019400040712     D  PxUsrPrf                     10a   Value
019500040714     **-- Send error message:
019600040714     D SndErrMsg       Pr            10i 0
019700040714     D  PxUsrPrf                     10a   Const
019800040714     D  PxMsgDta                    512a   Const  Varying
019900040716
020000040714      /Free
020100040712
020200040714        DoW  Not *InLr;
020300040712
020400040714          RcvDtaqE( 'USRPRFEVT'
020500040714                  : 'QGPL'
020600040714                  : DqDtaLen
020700040714                  : UsrPrfEvt
020800040714                  : DQ_WAIT_SEC
020900040714                  );
021000040712
021100040714          Select;
021200040714          When  %Error;
021300040714            SndErrMsg( PsCurUsr
021400040714                     : 'Job ' +  %TrimR( PsJobNbr ) +
021500040714                       '/'    +  %TrimR( PsUsrPrf ) +
021600040714                       '/'    +  %TrimR( PsCurJob ) +
021700040714                       ' encountered an error, please check the joblog'
021800040714                     );
021900040712
022000040714          When  DqDtaLen  > *Zero;
022100040714            ExSr  PrcDtaQe;
022200040714          EndSl;
022300040712
022400040714          *InLr  = %Shtdn();
022500040714        EndDo;
022600040605
022700040714        Return;
022800040714
022900040714        BegSr  PrcDtaQe;
023000040714
023100040714          Select;
023200040714          When  UsrPrfEvt.RcdTyp  <> '*PRFE';
023300040714            RtnCod  = 1;
023400040715
023500040714          When  GetUsrCls( UsrPrfEvt.UsrPrf )  <> '*USER';
023600040714            RtnCod  = 11;
023700040715
023800040714          When  UsrPrfEvt.SysNam  =  GetSysNam();
023900040714            RtnCod  = 12;
024000040715
024100040714          When  UsrPrfEvt.PwdLvl  <> GetPwdLvl();
024200040714            RtnCod  = 13;
024300040715
024400040714          When  UsrPrfEvt.SysRls  <> GetRlsLvl();
024500040714            RtnCod  = 14;
024600040715
024700040714          When  UsrPrfEvt.UsrPrfAct  = 'CRT';
024800040714            RtnCod  = 21;
024900040715
025000040714          When  UsrPrfEvt.UsrPrfAct  = 'RST';
025100040714            RtnCod  = 22;
025200040715
025300040714          Other;
025400040714            RtnCod  = *Zero;
025500040714          EndSl;
025600040714
025700040714          If  RtnCod  = *Zero;
025800040714
025900040714            If  UsrPrfEvt.UsrPrfAct  = 'DLT';
026000040714              ChgUsrPwd( UsrPrfEvt.UsrPrf: '*NOPWD': '*NONE': ApiError );
026100040714
026200040714              If  AeBytAvl  > *Zero;
026300040714                RtnCod  = 31;
026400040714              EndIf;
026500040714
026600040714            Else;
026700040714              SetUsrPwd( UsrPrfEvt.PwdDta: 'UPWD0100': ApiError );
026800040714
026900040714              If  AeBytAvl  > *Zero;
027000040714                RtnCod  = 32;
027100040714              EndIf;
027200040714            EndIf;
027300040714
027400040714            If  RtnCod  > *Zero;
027500040714
027600040714              SndErrMsg( PsCurUsr
027700040714                       : 'Security event terminated due to return code ' +
027800040714                         %Char( RtnCod )
027900040714                       );
028000040714            EndIf;
028100040714          EndIf;
028200040714
028300040714        EndSr;
028400040714
028500040714      /End-Free
