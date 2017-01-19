000100040822     **
000200040822     **  Program . . : CBX921
000300040822     **  Description : Break message handling program
000400040822     **  Author  . . : Carsten Flensburg
000500040822     **
000600040822     **
000700040822     **  Parameters:
000800040822     **    PxMsgQueNam  INPUT    Name of the message queue receiving
000900040822     **                          the message.
001000040822     **
001100040822     **    PxMsgQueLib  INPUT    The name of the library containing
001200040822     **                          the message queue.
001300040822     **
001400040822     **    PxMsgQue     INPUT    The message reference key of the
001500040822     **                          message received.
001600040822     **
001700040822     **
001800040822     **  Activation of break message handling:
001900040822     **    ChgMsgQ    MsgQ( message-queue-name )
002000040822     **               Dlvry( *BREAK )
002100040822     **               Pgm( CBX921  *ALWRPY )
002200040822     **
002300040827     **
002400040827     **  Program function:
002500040827     **    Once this program is registered as a specific message queue's
002600040827     **    break message handling program (see above) this program will
002700040827     **    get called every time a message is received at that message
002800040827     **    queue.  The break message handling program will run in the job
002900040827     **    that issued the Change Message Queue command - and only as long
003000040827     **    as that job is active.
003100040827     **
003200040827     **    Every message that is received is displayed in a pop-up window
003300040827     **    for the duration of 3 seconds, which is controlled by the window
003400040827     **    display file's WAITRCD parameter.  Pressing Enter will remove
003500040827     **    the window immediately.
003600040827     **
003700040827     **    In order to prevent the window from clearing the current screen,
003800040827     **    the current display mode is retrieved and the window's display
003900040827     **    mode is set accordingly.
004000040827     **
004100040827     **    If the message has a severity of 50 or higher a beep is sent to
004200040827     **    the screen.
004300040827     **
004400040827     **    Only messages that are up to 60 seconds old will be displayed
004500040827     **    in the pop-up window.  All other messages will be sent as a
004600040828     **    status message and appear at the bottom of the current screen.
004700040827     **
004800040827     **    The following F-keys are available in the window to perform a
004900040827     **    number of functions and settings:
005000040827     **
005100040827     **    F6=WrkMsg     Work with messages for the message queue of the
005200040827     **                  received message.
005300040827     **
005400040827     **    F7=WrkJob     Work with the job that sent the received message.
005500040827     **
005600040827     **    F8=Suspend    Suspend the pop-up window for a duration of 2
005700040827     **                  minutes.  While the window is suspended all
005800040827     **                  messages are sent as a status message and will
005900040828     **                  appear at the bottom of the current screen.
006000040827     **
006100040827     **    F9=Keep       To keep the window open and not time-out after 3
006200040827     **                  seconds.  The window will remain open until Enter,
006300040827     **                  F9 or F11 is pressed.
006400040827     **
006500060414     **    F10=CmdEnt    Calls the command entry panel.
006600040828     **
006700040828     **    F11=DltMsg    Deletes the received message from the message queue.
006800040827     **
006900060414     **    F13=Reply     Runs the Send Message (SNDMSG) command, specifying
007000060414     **                  the user profile that sent the received message as
007100060414     **                  the target message queue.
007200060414     **
007300040827     **
007400040822     **  Programmer's note:
007500040828     **    Please ignore the SEU RNF2418 error message complaining about the
007600040828     **    MaxDev() keyword in the display file F-specification - the error
007700060414     **    text is in contradiction to the actual keyword parameter - and
007800040828     **    consequently the compiler also has no problem with it.
007900040828     **
008000040828     **    The display file qualification in the ExtFile() specification
008100040828     **    ensures that this program is always able to find the display
008200040822     **    file, regardless of the job's current library list setting.
008300040822     **
008400040828     **    If you choose to place the CBX921D display file in another library
008500040828     **    than QGPL, please replace the library name accordingly in the
008600040828     **    ExtFile() specification.
008700040827     **
008800040828     **
008900040822     **  Authority and security restrictions:
009000040822     **    To retrieve user profile information *READ information is required
009100040822     **    required to the user profile.
009200040822     **
009300040822     **    If appropriate, the required authority can be obtained by means of
009400040822     **    adopted authority:  Change the program object's UsrPrf attribute
009500040822     **    to *OWNER using the ChgPgm command, and change the program object
009600040822     **    owner to a user profile having sufficient authority using the
009700040822     **    ChgObjOwn command:
009800040822     **
009900040822     **      ChpPgm     Pgm( CBX921 )  UsrPrf( *OWNER )
010000040822     **      ChgObjOwn  Obj( CBX921 )  ObjType( *PGM )  NewOwn( <user profile> )
010100040822     **
010200040822     **
010300040822     **  Compile options:
010400040822     **    CrtRpgMod Module( CBX921 )
010500040822     **              DbgView( *LIST )
010600040822     **
010700040822     **    CrtPgm    Pgm( CBX921 )
010800040822     **              Module( CBX921 )
010900081229     **              ActGrp( CBX921 )
011000040822     **
011100040822     **
011200040821     **-- Header specifications:  --------------------------------------------**
011300040821     H DatFmt( *ISO )  TimFmt( *ISO )  Option( *SrcStmt: *NoDebugIo )
011400060414
011500040822     **-- Display file:
011600040822     FCBX921D   CF   E             WorkStn ExtFile( 'QGPL/CBX921D' )
011700060420     F                                     MaxDev( *FILE )
011800040822     F                                     InfDs( DspInf )
011900040822     F                                     UsrOpn
012000060414
012100040821     **-- Display file information:
012200040821     D DspInf          Ds           512    Qualified
012300040821     D  Status           *Status
012400040821     D  FilNam           *File
012500040821     D  Fkey                          1a   Overlay( DspInf: 369 )
012600040821     **-- System information:
012700060420     D PgmSts         SDs                  Qualified
012800060420     D  PgmNam           *Proc
012900060423     D  PgmLib                       10a   Overlay( PgmSts:  81 )
013000060420     D  JobNam                       10a   Overlay( PgmSts: 244 )
013100060420     D  JobUsr                       10a   Overlay( PgmSts: 254 )
013200060420     D  JobNbr                        6a   Overlay( PgmSts: 264 )
013300060420     D  CurUsr                       10a   Overlay( PgmSts: 358 )
013400060414
013500040821     **-- API error information:
013600040821     D ERRC0100        Ds                  Qualified
013700040821     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
013800040821     D  BytAvl                       10i 0
013900040821     D  MsgId                         7a
014000040821     D                                1a
014100040821     D  MsgDta                      128a
014200040821     **-- Message information structure:
014300040821     D RCVM0200        Ds                  Qualified
014400040821     D  BytRtn                       10i 0
014500040821     D  BytAvl                       10i 0
014600040821     D  MsgSev                       10i 0
014700040821     D  MsgId                         7a
014800040821     D  MsgTyp                        2s 0
014900040821     D  MsgKey                        4a
015000040821     D  MsgFnam                      10a
015100040821     D  MsgFlib_s                    10a
015200040821     D  MsgFlib_u                    10a
015300040821     D  SndJobNam                    10a
015400040821     D  SndUsrPrf                    10a
015500040821     D  SndJobNbr                     6a
015600040821     D  SndPgmNam                    12a
015700040821     D                                4a
015800040821     D  DatSnt                        7s 0
015900040821     D  TimSnt                        6s 0
016000040821     D  TimSntMs                      6s 0
016100040821     D                               11a
016200040821     D  CcsIdStsTxt                  10i 0
016300040821     D  CcsIdStsDta                  10i 0
016400040821     D  AlrOpt                        9a
016500040821     D  CcsIdMsgTxt                  10i 0
016600040821     D  CcsIdMsgDta                  10i 0
016700040821     D  DtaLenRtn                    10i 0
016800040821     D  DtaLenAvl                    10i 0
016900040821     D  MsgLenRtn                    10i 0
017000040821     D  MsgLenAvl                    10i 0
017100040821     D  HlpLenRtn                    10i 0
017200040821     D  HlpLenAvl                    10i 0
017300040821     D  VarDta                     4096a
017400971027     **
017500040821     D MsgTxt          s           1024a   Varying
017600040821     D MsgDta          s           1024a   Varying
017700060414     **-- Low level environment description:
017800040821     D LowLvlEnv       Ds                  Qualified
017900040821     D  ColSup                        1a   Inz( '0')
018000040821     D  ChrCvs                        1a   Inz( '0')
018100040821     D  CdraCvs                       1a   Inz( '0')
018200040821     D  DbcsSup                       1a   Inz( '0')
018300040821     D  CoExist                       1a   Inz( '1')
018400040821     D  AltHlpSup                     1a   Inz( '0')
018500040821     D  TgtDev                       10a   Inz( '*REQUESTER' )
018600060414
018700040821     **-- Message type table:
018800040821     D TypTbl          Ds
018900040821     D  MsgTyp                       12a   Dim( 25 )
019000040821     D                              300a   Overlay( TypTbl )
019100040821     D                                     Inz( 'Completion  +
019200040821     D                                           Diagnostic  +
019300040821     D                                           *N          +
019400040821     D                                           Info        +
019500040821     D                                           Inquiry     +
019600040821     D                                           Senders copy+
019700040821     D                                           *N          +
019800040821     D                                           Request     +
019900040821     D                                           *N          +
020000040821     D                                           Request pmt +
020100040821     D                                           *N          +
020200040821     D                                           *N          +
020300040821     D                                           *N          +
020400040821     D                                           Notify      +
020500040821     D                                           Escape      +
020600040821     D                                           *N          +
020700040821     D                                           *N          +
020800040821     D                                           *N          +
020900040821     D                                           *N          +
021000040821     D                                           *N          +
021100040821     D                                           Reply (nvc) +
021200040821     D                                           Reply (vch) +
021300040821     D                                           Reply (mdu) +
021400040821     D                                           Reply (sdu) +
021500040821     D                                           Reply (sru) ' )
021600040821     **-- Global variables:
021700040821     D CurDts          s               z   Inz
021800040821     D ChkDts          s               z   Inz
021900040821     D KeepWdw         s               n
022000040821     D StsMsg          s               n
022100040821     D DspMod          s              1a
022200040821     D Row             s             10i 0
022300040821     D Col             s             10i 0
022400040822     **-- Global constants:
022500040822     D SUSPEND_SEC     c                   120
022600040822     D MAX_AGE_SEC     c                   60
022700040822     D NULL            c                   ''
022800040821     **-- Fkeys:
022900040821     D F06             c                   x'36'
023000040821     D F07             c                   x'37'
023100040821     D F08             c                   x'38'
023200040821     D F09             c                   x'39'
023300040821     D F10             c                   x'3A'
023400040821     D F11             c                   x'3B'
023500060414     D F13             c                   x'B1'
023600040821     **-- *IN array:
023700040821     D IN              Ds                  Based( pIN )
023800040821     D  VldCmdKey                      n   Overlay( IN: 15 )
023900040821     D  DS4                            n   Overlay( IN: 19 )
024000040821     **
024100040821     D pIN             s               *   Inz( %Addr( *IN ))
024200060414
024300040821     **-- Receive non-program message:
024400040821     D RcvMsg          Pr                  ExtPgm( 'QMHRCVM' )
024500060414     D  RcvVar                    32767a          Options( *VarSize )
024600060414     D  RcvVarLen                    10i 0 Const
024700060414     D  FmtNam                       10a   Const
024800060414     D  MsgQueQ                      20a   Const
024900060414     D  MsgTyp                       10a   Const
025000060414     D  MsgKey                        4a   Const
025100060414     D  Wait                         10i 0 Const
025200060414     D  MsgAct                       10a   Const
025300060414     D  Error                     32767a          Options( *VarSize )
025400060414     D  CcsId                        10i 0 Const  Options( *NoPass )
025500060414     D  AlwDftRpyRjt                 10i 0 Const  Options( *NoPass )
025600040821     **-- Remove non-program message:
025700040821     D RmvMsg          Pr                  ExtPgm( 'QMHRMVM' )
025800060414     D  MsgQueQ                      20a   Const
025900060414     D  MsgKey                        4a   Const
026000060414     D  RmvOpt                       10a   Const
026100060414     D  Error                     32767a          Options( *VarSize )
026200040821     **-- Retrieve user information:
026300040821     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
026400060414     D  RcvVar                    32767a          Options( *VarSize )
026500060414     D  RcvVarLen                    10i 0 Const
026600060414     D  FmtNam                       10a   Const
026700060414     D  UsrPrf                       10a   Const
026800060414     D  Error                     32767a          Options( *VarSize )
026900060414     **-- Command entry panel:
027000060414     D CmdEntPnl       Pr                  ExtPgm( 'QCMD' )
027100040821     **-- Send program message:
027200040821     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
027300060414     D  MsgId                         7a   Const
027400060414     D  MsgFq                        20a   Const
027500060414     D  MsgDta                    32767a   Const  Options( *VarSize )
027600060414     D  MsgDtaLen                    10i 0 Const
027700060414     D  MsgTyp                       10a   Const
027800060414     D  CalStkE                      10a   Const  Options( *VarSize )
027900060414     D  CalStkCtr                    10i 0 Const
028000060414     D  MsgKey                        4a
028100060414     D  Error                     32767a          Options( *VarSize )
028200040821     **
028300060414     D  CalStkElen                   10i 0 Const  Options( *NoPass )
028400060414     D  CalStkEq                     20a   Const  Options( *NoPass )
028500060414     D  DspWait                      10i 0 Const  Options( *NoPass )
028600040821     **
028700060414     D  CalStkEtyp                   20a   Const  Options( *NoPass )
028800060414     D  CcsId                        10i 0 Const  Options( *NoPass )
028900040822     **-- Retrieve message:
029000040822     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
029100060414     D  RcvVar                    32767a          Options( *VarSize )
029200060414     D  RcvVarLen                    10i 0 Const
029300060414     D  FmtNam                       10a   Const
029400060414     D  MsgId                         7a   Const
029500060414     D  MsgFq                        20a   Const
029600060414     D  MsgDta                      512a   Const  Options( *VarSize )
029700060414     D  MsgDtaLen                    10i 0 Const
029800060414     D  RplSubVal                    10a   Const
029900060414     D  RtnFmtChr                    10a   Const
030000060414     D  Error                     32767a          Options( *VarSize )
030100040822     **
030200060414     D  RtvOpt                       10a   Const  Options( *NoPass )
030300060414     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
030400060414     D  RplCcsId                     10i 0 Const  Options( *NoPass )
030500040821     **-- Process commands:
030600040821     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
030700060414     D  SrcCmd                    32702a   Const  Options( *VarSize )
030800060414     D  SrcCmdLen                    10i 0 Const
030900060414     D  OptCtlBlk                    20a   Const
031000060414     D  OptCtlBlkLn                  10i 0 Const
031100060414     D  OptCtlBlkFm                   8a   Const
031200060414     D  ChgCmd                    32767a          Options( *VarSize )
031300060414     D  ChgCmdLen                    10i 0 Const
031400060414     D  ChgCmdLenAv                  10i 0
031500060414     D  Error                     32767a          Options( *VarSize )
031600060414
031700060414     **-- Retrieve display mode:
031800050511     D RtvDspMod       Pr             1a   ExtProc( *CWIDEN: 'QsnRtvMod' )
031900040821     D  DspMod                        1a          Options( *Omit )
032000040821     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
032100040821     D  ApiError                   1024a          Options( *Omit: *VarSize )
032200040821     **-- Get cursor address:
032300040821     D GetCsrAdr       Pr            10i 0 ExtProc( 'QsnGetCsrAdr' )
032400040821     D  Row                          10i 0
032500040821     D  Col                          10i 0
032600040821     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
032700040821     D  ApiError                   1024a          Options( *Omit: *VarSize )
032800040821     **-- Change low level environment:
032900040821     D ChgEnv          Pr            10i 0 ExtProc( 'QsnChgEnv' )
033000040821     D  LlvEnvDsc                    38a   Const  Options( *VarSize )
033100040821     D  LlvEnvDscLen                 10i 0 Const
033200040821     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
033300040821     D  ApiError                   1024a          Options( *Omit: *VarSize )
033400040821     **-- Send beep to screen:
033500040821     D Beep            Pr            10i 0 ExtProc( 'QsnBeep' )
033600040821     D  CmdBufHdl                    10i 0 Const  Options( *Omit )
033700040821     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
033800040821     D  ApiError                   1024a          Options( *Omit: *VarSize )
033900060414
034000040821     **-- Send status message:
034100040821     D SndStsMsg       Pr            10i 0
034200040821     D  PxMsgDta                   1024a   Const  Varying
034300040821     **-- Process command:
034400040821     D PrcCmd          Pr             7a
034500040821     D  CmdStr                     1024a   Const  Varying
034600040821     **-- Retrieve user text:
034700040821     D RtvUsrTxt       Pr            50a   Varying
034800040821     D  PxUsrPrf                     10a   Value
034900040821
035000040821     **-- Entry parameters:
035100040822     D CBX921          Pr
035200040821     D  PxMsgQueNam                  10a
035300040821     D  PxMsgQueLib                  10a
035400040821     D  PxMsgKey                      4a
035500040821     **
035600040822     D CBX921          Pi
035700040821     D  PxMsgQueNam                  10a
035800040821     D  PxMsgQueLib                  10a
035900040821     D  PxMsgKey                      4a
036000040821
036100040821      /Free
036200040822
036300040822        KeepWdw = *Off;
036400040822        CurDts  = %Timestamp();
036500040821
036600040821        ExSr  GetMsg;
036700040821
036800040821        If  StsMsg = *On;
036900040821
037000040822          If  %Diff( CurDts: ChkDts: *Seconds ) > SUSPEND_SEC;
037100040821            StsMsg = *Off;
037200040821          EndIf;
037300040821        EndIf;
037400040821
037500040821        If  StsMsg = *Off;
037600040821
037700040821          ChkDts = %Date( RCVM0200.DatSnt: *CYMD ) +
037800040821                   %Time( RCVM0200.TimSnt: *ISO );
037900040821        EndIf;
038000040821
038100040821        Select;
038200040821        When  StsMsg = *On;
038300040821          ExSr  DspStsMsg;
038400040821
038500040822        When  %Diff( CurDts: ChkDts: *Seconds ) < MAX_AGE_SEC;
038600040821          ExSr  DspMsgWdw;
038700040821
038800040821        Other;
038900040821          ExSr  DspStsMsg;
039000040821        EndSl;
039100040821
039200040821        ExSr  EndPgm;
039300040821
039400040821
039500040821        BegSr  GetMsg;
039600040821
039700040821          RcvMsg( RCVM0200
039800040821                : %Size( RCVM0200 )
039900040821                : 'RCVM0200'
040000040821                : PxMsgQueNam + PxMsgQueLib
040100040821                : '*ANY'
040200040821                : PxMsgKey
040300040821                : *Zero
040400040821                : '*OLD'
040500040821                : ERRC0100
040600040821                );
040700040821
040800040821          If  ERRC0100.BytAvl = *Zero;
040900040821
041000040821            MsgDta = %Subst( RCVM0200.VarDta
041100040821                           : 1
041200040821                           : RCVM0200.DtaLenRtn
041300040821                           );
041400040821
041500040821            MsgTxt = %Subst( RCVM0200.VarDta
041600040821                           : RCVM0200.DtaLenRtn + 1
041700040821                           : RCVM0200.MsgLenRtn
041800040821                           );
041900040822          Else;
042000040822            MsgDta = NULL;
042100040822            MsgTxt = '*ERROR: Message not found in message queue.';
042200040821          EndIf;
042300040821
042400040821        EndSr;
042500040821
042600040821        BegSr  DspMsgWdw;
042700040821
042800040821          ExSr  SetWdwLin;
042900040821          ExSr  SetDspMod;
043000040821
043100040822          Open  CBX921D;
043200040821
043300040821          If  RCVM0200.MsgSev >= 50;
043400040821            Beep( *Omit: *Omit: *Omit );
043500040821          EndIf;
043600040821
043700040821          ExSr  FmtMsgInf;
043800040821
043900040821          DoU  VldCmdKey = *Off;
044000040821
044100040821            If  KeepWdw = *On;
044200040821              ExFmt  WDW001;
044300040821            Else;
044400040821
044500040821              Write  WDW001;
044600040822              Read(e)  CBX921D;
044700040821            EndIf;
044800040821
044900040821            Select;
045000040821            When  %Error = *On  And  DspInf.Status = 01331;
045100040821              ExSr  EndPgm;
045200040821
045300040821            When  VldCmdKey = *On;
045400040821              ExSr  PrcFkey;
045500040821            EndSl;
045600040821
045700040821          EndDo;
045800040821
045900040821        EndSr;
046000040821
046100040821        BegSr  FmtMsgInf;
046200040821
046300040822          WDWTTL = PxMsgQueNam;
046400040822
046500040821          W1DATE = %Char( %Date( ChkDts ): *JOBRUN );
046600040821          W1TIME = %Char( %Time( ChkDts ): *ISO );
046700040821          W1MSID = RCVM0200.MsgId;
046800040821          W1JBNM = RCVM0200.SndJobNam;
046900040821          W1USPF = RCVM0200.SndUsrPrf;
047000040821          W1UPTX = RtvUsrTxt( RCVM0200.SndUsrPrf );
047100040821          W1MSTP = MsgTyp( RCVM0200.MsgTyp );
047200040821
047300040821          If  RCVM0200.MsgSev  > 0;
047400040821            W1MSSV = %Char( RCVM0200.MsgSev );
047500040821          Else;
047600040821            W1MSSV = *Blanks;
047700040821          EndIf;
047800040821
047900040821          If  MsgTxt > *Blanks;
048000040821            W1MSG = MsgTxt;
048100040821
048200040821            If  %Len( MsgTxt ) > %Size( W1MSG );
048300040821              W1MSG = %TrimR( %Subst( W1MSG: 1: %Size( W1MSG ) - 3 )) + '...';
048400040821            EndIf;
048500040821
048600040821          Else;
048700040821            W1MSG = MsgDta;
048800040821
048900040821            If  %Len( MsgDta ) > %Size( W1MSG );
049000040821              W1MSG = %TrimR( %Subst( W1MSG: 1: %Size( W1MSG ) - 3 )) + '...';
049100040821            EndIf;
049200040821          EndIf;
049300040821
049400040821        EndSr;
049500040821
049600040821        Begsr  SetWdwLin;
049700040821
049800040821          GetCsrAdr( Row: Col: *Omit: *Omit );
049900040821
050000040821          If  Row > 12;
050100040822            WDWLIN = 3;
050200040821          Else;
050300040822            WDWLIN = 13;
050400040821          EndIf;
050500040821
050600040821        EndSr;
050700040821
050800040821        BegSr  SetDspMod;
050900040821
051000040821          RtvDspMod( DspMod: *Omit: *Omit );
051100040821
051200040821          Select;
051300040821          When  DspMod = '3';
051400040821            DS4 = *Off;
051500040821
051600040821          When  DspMod = '4';
051700040821            DS4 = *On;
051800040821          EndSl;
051900040821
052000040821        EndSr;
052100040821
052200040821        BegSr  DspStsMsg;
052300040821
052400040821          If  MsgTxt > *Blanks;
052500040821            SndStsMsg( MsgTxt );
052600040821          Else;
052700040821            SndStsMsg( MsgDta );
052800040821          EndIf;
052900040821
053000040821        EndSr;
053100040821
053200040821        BegSr  PrcFkey;
053300040821
053400040821          Select;
053500040821          When  DspInf.Fkey = F06;
053600040821            ExSr  WrkMsgQ;
053700040821
053800040821          When  DspInf.Fkey = F07;
053900040821            ExSr  WrkSndJob;
054000040821
054100040821          When  DspInf.Fkey = F08;
054200040821            ExSr  SetStsMsg;
054300040821
054400040821          When  DspInf.Fkey = F09;
054500040822            ExSr  TglKeepWdw;
054600040821
054700040821          When  DspInf.Fkey = F10;
054800060414            ExSr  CmdEnt;
054900040821
055000040821          When  DspInf.Fkey = F11;
055100040821            ExSr  DltMsg;
055200060414
055300060414          When  DspInf.Fkey = F13;
055400060414            ExSr  RpyToSnd;
055500040821          EndSl;
055600040821
055700040821        EndSr;
055800040821
055900040821        BegSr  WrkMsgQ;
056000040821
056100040822          PrcCmd( 'WRKMSG '              +
056200040822                  %TrimR( PxMsgQueLib )  + '/' +
056300040822                  %TrimR( PxMsgQueNam )
056400040821                );
056500040821
056600040821        EndSr;
056700040821
056800040821        BegSr  WrkSndJob;
056900040821
057000040822          If  PrcCmd( 'WRKJOB '                    +
057100040822                      %TrimR( RCVM0200.SndJobNbr ) + '/' +
057200040822                      %TrimR( RCVM0200.SndUsrPrf ) + '/' +
057300040822                      %TrimR( RCVM0200.SndJobNam )
057400040821                    ) = 'CPF1070';
057500040821
057600040821            SndStsMsg( 'Job no longer on system.' );
057700040821          EndIf;
057800040821
057900040821        EndSr;
058000040821
058100040821        BegSr  SetStsMsg;
058200040821
058300040821          ChkDts  = %Timestamp();
058400040821          StsMsg  = *On;
058500040821          KeepWdw = *Off;
058600040821
058700040821          SndStsMsg( 'Break messages temporarily suspended.' );
058800040821
058900040821        EndSr;
059000040821
059100040822        BegSr  TglKeepWdw;
059200040821
059300040821          KeepWdw = Not KeepWdw;
059400040821
059500040821        EndSr;
059600040821
059700060414        BegSr  CmdEnt;
059800040821
059900060414          CallP  CmdEntPnl();
060000040821
060100040821        EndSr;
060200040821
060300040821        BegSr  DltMsg;
060400040821
060500040821          RmvMsg( PxMsgQueNam + PxMsgQueLib
060600040821                : PxMsgKey
060700040821                : '*BYKEY'
060800040821                : ERRC0100
060900040821                );
061000040821
061100040821          If  ERRC0100.BytAvl = *Zero;
061200040822
061300040821            W1MSG = '*DELETED';
061400040821            KeepWdw = *Off;
061500040821          EndIf;
061600040821
061700040821        EndSr;
061800040821
061900060414        BegSr  RpyToSnd;
062000060414
062100060414          PrcCmd( '?SNDMSG ??MSG() ?*TOUSR('          +
062200060414                  %TrimR( RCVM0200.SndUsrPrf )        +
062300060414                  ') ?-TOMSGQ() ??MSGTYPE(*INFO)'
062400060414                );
062500060414
062600060414        EndSr;
062700040821        BegSr  EndPgm;
062800040821
062900040822          If  %Open( CBX921D );
063000040822            Close  CBX921D;
063100040821          EndIf;
063200040821
063300040821          Return;
063400040821
063500040821        EndSr;
063600040821
063700040821        BegSr  *InzSr;
063800040821
063900040821          ChgEnv( LowLvlEnv
064000040821                : %Size( LowLvlEnv )
064100040821                : *Omit
064200040821                : ERRC0100
064300040821                );
064400040821
064500040821        EndSr;
064600040821
064700040821      /End-Free
064800040821
064900040821     **-- Process command:  --------------------------------------------------**
065000040821     P PrcCmd          B                   Export
065100040821     D                 Pi             7a
065200040821     D  PxCmdStr                   1024a   Const  Varying
065300060414
065400040821     **-- Local variables:
065500040821     D CpOptCtlBlk     Ds
065600040821     D  CpTypPrc                     10i 0 Inz( 2 )
065700040821     D  CpDBCS                        1a   Inz( '0' )
065800040821     D  CpPmtAct                      1a   Inz( '2' )
065900040821     D  CpCmdStx                      1a   Inz( '0' )
066000040821     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
066100040821     D  CpRsv                         9a   Inz( *Allx'00' )
066200040821     **
066300040821     D CpChgCmd        s          32767a
066400040821     D CpChgCmdAvl     s             10i 0
066500040821
066600040821      /Free
066700040821
066800040821        PrcCmds( PxCmdStr
066900040821               : %Len( PxCmdStr )
067000040821               : CpOptCtlBlk
067100040821               : %Size( CpOptCtlBlk )
067200040821               : 'CPOP0100'
067300040821               : CpChgCmd
067400040821               : %Size( CpChgCmd )
067500040821               : CpChgCmdAvl
067600040821               : ERRC0100
067700040821               );
067800040821
067900040821        If  ERRC0100.BytAvl > *Zero;
068000040821          Return  ERRC0100.MsgId;
068100040821        Else;
068200040821          Return  *Blanks;
068300040821        EndIf;
068400040821
068500040821      /End-Free
068600040821
068700040821     P PrcCmd          E
068800060414     **-- Retrieve user text:
068900040821     P RtvUsrTxt       B                   Export
069000040821     D                 Pi            50a   Varying
069100040821     D  PxUsrPrf                     10a   Value
069200040821     **
069300040821     D USRI0300        Ds                  Qualified
069400040821     D  BytRtn                       10i 0
069500040821     D  BytAvl                       10i 0
069600040821     D  UsrPrf                       10a
069700040821     D  UsrTxt                       50a   Overlay( USRI0300: 199 )
069800040821
069900040821      /Free
070000040821
070100040821        RtvUsrInf( USRI0300
070200040821                 : %Size( USRI0300 )
070300040821                 : 'USRI0300'
070400040821                 : PxUsrPrf
070500040821                 : ERRC0100
070600040821                 );
070700040821
070800040821        If  ERRC0100.BytAvl > *Zero;
070900040822          Return  NULL;
071000040821
071100040821        Else;
071200040821          Return  %Trim( USRI0300.UsrTxt );
071300040821        EndIf;
071400040821
071500040821      /End-Free
071600040821
071700040821     P RtvUsrTxt       E
071800060414     **-- Send status message:
071900040821     P SndStsMsg       B
072000040821     D                 Pi            10i 0
072100040821     D  PxMsgDta                   1024a   Const  Varying
072200040821     **
072300040821     D MsgKey          s              4a
072400040821
072500040821      /Free
072600040821
072700040821        SndPgmMsg( 'CPF9897'
072800040821                 : 'QCPFMSG   *LIBL'
072900040821                 : PxMsgDta
073000040821                 : %Len( PxMsgDta )
073100040821                 : '*STATUS'
073200040821                 : '*EXT'
073300040821                 : 0
073400040821                 : MsgKey
073500040821                 : ERRC0100
073600040821                 );
073700040821
073800040821        If  ERRC0100.BytAvl > *Zero;
073900040821          Return  -1;
074000040821
074100040821        Else;
074200040821          Return   0;
074300040821        EndIf;
074400040821
074500040821      /End-Free
074600040821
074700040821     P SndStsMsg       E
