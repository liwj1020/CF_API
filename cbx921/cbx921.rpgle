     **
     **  Program . . : CBX921
     **  Description : Break message handling program
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxMsgQueNam  INPUT    Name of the message queue receiving
     **                          the message.
     **
     **    PxMsgQueLib  INPUT    The name of the library containing
     **                          the message queue.
     **
     **    PxMsgQue     INPUT    The message reference key of the
     **                          message received.
     **
     **
     **  Activation of break message handling:
     **    ChgMsgQ    MsgQ( message-queue-name )
     **               Dlvry( *BREAK )
     **               Pgm( CBX921  *ALWRPY )
     **
     **
     **  Program function:
     **    Once this program is registered as a specific message queue's
     **    break message handling program (see above) this program will
     **    get called every time a message is received at that message
     **    queue.  The break message handling program will run in the job
     **    that issued the Change Message Queue command - and only as long
     **    as that job is active.
     **
     **    Every message that is received is displayed in a pop-up window
     **    for the duration of 3 seconds, which is controlled by the window
     **    display file's WAITRCD parameter.  Pressing Enter will remove
     **    the window immediately.
     **
     **    In order to prevent the window from clearing the current screen,
     **    the current display mode is retrieved and the window's display
     **    mode is set accordingly.
     **
     **    If the message has a severity of 50 or higher a beep is sent to
     **    the screen.
     **
     **    Only messages that are up to 60 seconds old will be displayed
     **    in the pop-up window.  All other messages will be sent as a
     **    status message and appear at the bottom of the current screen.
     **
     **    The following F-keys are available in the window to perform a
     **    number of functions and settings:
     **
     **    F6=WrkMsg     Work with messages for the message queue of the
     **                  received message.
     **
     **    F7=WrkJob     Work with the job that sent the received message.
     **
     **    F8=Suspend    Suspend the pop-up window for a duration of 2
     **                  minutes.  While the window is suspended all
     **                  messages are sent as a status message and will
     **                  appear at the bottom of the current screen.
     **
     **    F9=Keep       To keep the window open and not time-out after 3
     **                  seconds.  The window will remain open until Enter,
     **                  F9 or F11 is pressed.
     **
     **    F10=CmdEnt    Calls the command entry panel.
     **
     **    F11=DltMsg    Deletes the received message from the message queue.
     **
     **    F13=Reply     Runs the Send Message (SNDMSG) command, specifying
     **                  the user profile that sent the received message as
     **                  the target message queue.
     **
     **
     **  Programmer's note:
     **    Please ignore the SEU RNF2418 error message complaining about the
     **    MaxDev() keyword in the display file F-specification - the error
     **    text is in contradiction to the actual keyword parameter - and
     **    consequently the compiler also has no problem with it.
     **
     **    The display file qualification in the ExtFile() specification
     **    ensures that this program is always able to find the display
     **    file, regardless of the job's current library list setting.
     **
     **    If you choose to place the CBX921D display file in another library
     **    than QGPL, please replace the library name accordingly in the
     **    ExtFile() specification.
     **
     **
     **  Authority and security restrictions:
     **    To retrieve user profile information *READ information is required
     **    required to the user profile.
     **
     **    If appropriate, the required authority can be obtained by means of
     **    adopted authority:  Change the program object's UsrPrf attribute
     **    to *OWNER using the ChgPgm command, and change the program object
     **    owner to a user profile having sufficient authority using the
     **    ChgObjOwn command:
     **
     **      ChpPgm     Pgm( CBX921 )  UsrPrf( *OWNER )
     **      ChgObjOwn  Obj( CBX921 )  ObjType( *PGM )  NewOwn( <user profile> )
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX921 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX921 )
     **              Module( CBX921 )
     **              ActGrp( CBX921 )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H DatFmt( *ISO )  TimFmt( *ISO )  Option( *SrcStmt: *NoDebugIo )

     **-- Display file:
     FCBX921D   CF   E             WorkStn ExtFile( 'QGPL/CBX921D' )
     F                                     MaxDev( *FILE )
     F                                     InfDs( DspInf )
     F                                     UsrOpn

     **-- Display file information:
     D DspInf          Ds           512    Qualified
     D  Status           *Status
     D  FilNam           *File
     D  Fkey                          1a   Overlay( DspInf: 369 )
     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  PgmLib                       10a   Overlay( PgmSts:  81 )
     D  JobNam                       10a   Overlay( PgmSts: 244 )
     D  JobUsr                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )

     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Message information structure:
     D RCVM0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  MsgSev                       10i 0
     D  MsgId                         7a
     D  MsgTyp                        2s 0
     D  MsgKey                        4a
     D  MsgFnam                      10a
     D  MsgFlib_s                    10a
     D  MsgFlib_u                    10a
     D  SndJobNam                    10a
     D  SndUsrPrf                    10a
     D  SndJobNbr                     6a
     D  SndPgmNam                    12a
     D                                4a
     D  DatSnt                        7s 0
     D  TimSnt                        6s 0
     D  TimSntMs                      6s 0
     D                               11a
     D  CcsIdStsTxt                  10i 0
     D  CcsIdStsDta                  10i 0
     D  AlrOpt                        9a
     D  CcsIdMsgTxt                  10i 0
     D  CcsIdMsgDta                  10i 0
     D  DtaLenRtn                    10i 0
     D  DtaLenAvl                    10i 0
     D  MsgLenRtn                    10i 0
     D  MsgLenAvl                    10i 0
     D  HlpLenRtn                    10i 0
     D  HlpLenAvl                    10i 0
     D  VarDta                     4096a
     **
     D MsgTxt          s           1024a   Varying
     D MsgDta          s           1024a   Varying
     **-- Low level environment description:
     D LowLvlEnv       Ds                  Qualified
     D  ColSup                        1a   Inz( '0')
     D  ChrCvs                        1a   Inz( '0')
     D  CdraCvs                       1a   Inz( '0')
     D  DbcsSup                       1a   Inz( '0')
     D  CoExist                       1a   Inz( '1')
     D  AltHlpSup                     1a   Inz( '0')
     D  TgtDev                       10a   Inz( '*REQUESTER' )

     **-- Message type table:
     D TypTbl          Ds
     D  MsgTyp                       12a   Dim( 25 )
     D                              300a   Overlay( TypTbl )
     D                                     Inz( 'Completion  +
     D                                           Diagnostic  +
     D                                           *N          +
     D                                           Info        +
     D                                           Inquiry     +
     D                                           Senders copy+
     D                                           *N          +
     D                                           Request     +
     D                                           *N          +
     D                                           Request pmt +
     D                                           *N          +
     D                                           *N          +
     D                                           *N          +
     D                                           Notify      +
     D                                           Escape      +
     D                                           *N          +
     D                                           *N          +
     D                                           *N          +
     D                                           *N          +
     D                                           *N          +
     D                                           Reply (nvc) +
     D                                           Reply (vch) +
     D                                           Reply (mdu) +
     D                                           Reply (sdu) +
     D                                           Reply (sru) ' )
     **-- Global variables:
     D CurDts          s               z   Inz
     D ChkDts          s               z   Inz
     D KeepWdw         s               n
     D StsMsg          s               n
     D DspMod          s              1a
     D Row             s             10i 0
     D Col             s             10i 0
     **-- Global constants:
     D SUSPEND_SEC     c                   120
     D MAX_AGE_SEC     c                   60
     D NULL            c                   ''
     **-- Fkeys:
     D F06             c                   x'36'
     D F07             c                   x'37'
     D F08             c                   x'38'
     D F09             c                   x'39'
     D F10             c                   x'3A'
     D F11             c                   x'3B'
     D F13             c                   x'B1'
     **-- *IN array:
     D IN              Ds                  Based( pIN )
     D  VldCmdKey                      n   Overlay( IN: 15 )
     D  DS4                            n   Overlay( IN: 19 )
     **
     D pIN             s               *   Inz( %Addr( *IN ))

     **-- Receive non-program message:
     D RcvMsg          Pr                  ExtPgm( 'QMHRCVM' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  MsgQueQ                      20a   Const
     D  MsgTyp                       10a   Const
     D  MsgKey                        4a   Const
     D  Wait                         10i 0 Const
     D  MsgAct                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  CcsId                        10i 0 Const  Options( *NoPass )
     D  AlwDftRpyRjt                 10i 0 Const  Options( *NoPass )
     **-- Remove non-program message:
     D RmvMsg          Pr                  ExtPgm( 'QMHRMVM' )
     D  MsgQueQ                      20a   Const
     D  MsgKey                        4a   Const
     D  RmvOpt                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  UsrPrf                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Command entry panel:
     D CmdEntPnl       Pr                  ExtPgm( 'QCMD' )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                    32767a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )
     **
     D  CalStkElen                   10i 0 Const  Options( *NoPass )
     D  CalStkEq                     20a   Const  Options( *NoPass )
     D  DspWait                      10i 0 Const  Options( *NoPass )
     **
     D  CalStkEtyp                   20a   Const  Options( *NoPass )
     D  CcsId                        10i 0 Const  Options( *NoPass )
     **-- Retrieve message:
     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  RplSubVal                    10a   Const
     D  RtnFmtChr                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **
     D  RtvOpt                       10a   Const  Options( *NoPass )
     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
     D  RplCcsId                     10i 0 Const  Options( *NoPass )
     **-- Process commands:
     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
     D  SrcCmd                    32702a   Const  Options( *VarSize )
     D  SrcCmdLen                    10i 0 Const
     D  OptCtlBlk                    20a   Const
     D  OptCtlBlkLn                  10i 0 Const
     D  OptCtlBlkFm                   8a   Const
     D  ChgCmd                    32767a          Options( *VarSize )
     D  ChgCmdLen                    10i 0 Const
     D  ChgCmdLenAv                  10i 0
     D  Error                     32767a          Options( *VarSize )

     **-- Retrieve display mode:
     D RtvDspMod       Pr             1a   ExtProc( *CWIDEN: 'QsnRtvMod' )
     D  DspMod                        1a          Options( *Omit )
     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
     D  ApiError                   1024a          Options( *Omit: *VarSize )
     **-- Get cursor address:
     D GetCsrAdr       Pr            10i 0 ExtProc( 'QsnGetCsrAdr' )
     D  Row                          10i 0
     D  Col                          10i 0
     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
     D  ApiError                   1024a          Options( *Omit: *VarSize )
     **-- Change low level environment:
     D ChgEnv          Pr            10i 0 ExtProc( 'QsnChgEnv' )
     D  LlvEnvDsc                    38a   Const  Options( *VarSize )
     D  LlvEnvDscLen                 10i 0 Const
     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
     D  ApiError                   1024a          Options( *Omit: *VarSize )
     **-- Send beep to screen:
     D Beep            Pr            10i 0 ExtProc( 'QsnBeep' )
     D  CmdBufHdl                    10i 0 Const  Options( *Omit )
     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
     D  ApiError                   1024a          Options( *Omit: *VarSize )

     **-- Send status message:
     D SndStsMsg       Pr            10i 0
     D  PxMsgDta                   1024a   Const  Varying
     **-- Process command:
     D PrcCmd          Pr             7a
     D  CmdStr                     1024a   Const  Varying
     **-- Retrieve user text:
     D RtvUsrTxt       Pr            50a   Varying
     D  PxUsrPrf                     10a   Value

     **-- Entry parameters:
     D CBX921          Pr
     D  PxMsgQueNam                  10a
     D  PxMsgQueLib                  10a
     D  PxMsgKey                      4a
     **
     D CBX921          Pi
     D  PxMsgQueNam                  10a
     D  PxMsgQueLib                  10a
     D  PxMsgKey                      4a

      /Free

        KeepWdw = *Off;
        CurDts  = %Timestamp();

        ExSr  GetMsg;

        If  StsMsg = *On;

          If  %Diff( CurDts: ChkDts: *Seconds ) > SUSPEND_SEC;
            StsMsg = *Off;
          EndIf;
        EndIf;

        If  StsMsg = *Off;

          ChkDts = %Date( RCVM0200.DatSnt: *CYMD ) +
                   %Time( RCVM0200.TimSnt: *ISO );
        EndIf;

        Select;
        When  StsMsg = *On;
          ExSr  DspStsMsg;

        When  %Diff( CurDts: ChkDts: *Seconds ) < MAX_AGE_SEC;
          ExSr  DspMsgWdw;

        Other;
          ExSr  DspStsMsg;
        EndSl;

        ExSr  EndPgm;


        BegSr  GetMsg;

          RcvMsg( RCVM0200
                : %Size( RCVM0200 )
                : 'RCVM0200'
                : PxMsgQueNam + PxMsgQueLib
                : '*ANY'
                : PxMsgKey
                : *Zero
                : '*OLD'
                : ERRC0100
                );

          If  ERRC0100.BytAvl = *Zero;

            MsgDta = %Subst( RCVM0200.VarDta
                           : 1
                           : RCVM0200.DtaLenRtn
                           );

            MsgTxt = %Subst( RCVM0200.VarDta
                           : RCVM0200.DtaLenRtn + 1
                           : RCVM0200.MsgLenRtn
                           );
          Else;
            MsgDta = NULL;
            MsgTxt = '*ERROR: Message not found in message queue.';
          EndIf;

        EndSr;

        BegSr  DspMsgWdw;

          ExSr  SetWdwLin;
          ExSr  SetDspMod;

          Open  CBX921D;

          If  RCVM0200.MsgSev >= 50;
            Beep( *Omit: *Omit: *Omit );
          EndIf;

          ExSr  FmtMsgInf;

          DoU  VldCmdKey = *Off;

            If  KeepWdw = *On;
              ExFmt  WDW001;
            Else;

              Write  WDW001;
              Read(e)  CBX921D;
            EndIf;

            Select;
            When  %Error = *On  And  DspInf.Status = 01331;
              ExSr  EndPgm;

            When  VldCmdKey = *On;
              ExSr  PrcFkey;
            EndSl;

          EndDo;

        EndSr;

        BegSr  FmtMsgInf;

          WDWTTL = PxMsgQueNam;

          W1DATE = %Char( %Date( ChkDts ): *JOBRUN );
          W1TIME = %Char( %Time( ChkDts ): *ISO );
          W1MSID = RCVM0200.MsgId;
          W1JBNM = RCVM0200.SndJobNam;
          W1USPF = RCVM0200.SndUsrPrf;
          W1UPTX = RtvUsrTxt( RCVM0200.SndUsrPrf );
          W1MSTP = MsgTyp( RCVM0200.MsgTyp );

          If  RCVM0200.MsgSev  > 0;
            W1MSSV = %Char( RCVM0200.MsgSev );
          Else;
            W1MSSV = *Blanks;
          EndIf;

          If  MsgTxt > *Blanks;
            W1MSG = MsgTxt;

            If  %Len( MsgTxt ) > %Size( W1MSG );
              W1MSG = %TrimR( %Subst( W1MSG: 1: %Size( W1MSG ) - 3 )) + '...';
            EndIf;

          Else;
            W1MSG = MsgDta;

            If  %Len( MsgDta ) > %Size( W1MSG );
              W1MSG = %TrimR( %Subst( W1MSG: 1: %Size( W1MSG ) - 3 )) + '...';
            EndIf;
          EndIf;

        EndSr;

        Begsr  SetWdwLin;

          GetCsrAdr( Row: Col: *Omit: *Omit );

          If  Row > 12;
            WDWLIN = 3;
          Else;
            WDWLIN = 13;
          EndIf;

        EndSr;

        BegSr  SetDspMod;

          RtvDspMod( DspMod: *Omit: *Omit );

          Select;
          When  DspMod = '3';
            DS4 = *Off;

          When  DspMod = '4';
            DS4 = *On;
          EndSl;

        EndSr;

        BegSr  DspStsMsg;

          If  MsgTxt > *Blanks;
            SndStsMsg( MsgTxt );
          Else;
            SndStsMsg( MsgDta );
          EndIf;

        EndSr;

        BegSr  PrcFkey;

          Select;
          When  DspInf.Fkey = F06;
            ExSr  WrkMsgQ;

          When  DspInf.Fkey = F07;
            ExSr  WrkSndJob;

          When  DspInf.Fkey = F08;
            ExSr  SetStsMsg;

          When  DspInf.Fkey = F09;
            ExSr  TglKeepWdw;

          When  DspInf.Fkey = F10;
            ExSr  CmdEnt;

          When  DspInf.Fkey = F11;
            ExSr  DltMsg;

          When  DspInf.Fkey = F13;
            ExSr  RpyToSnd;
          EndSl;

        EndSr;

        BegSr  WrkMsgQ;

          PrcCmd( 'WRKMSG '              +
                  %TrimR( PxMsgQueLib )  + '/' +
                  %TrimR( PxMsgQueNam )
                );

        EndSr;

        BegSr  WrkSndJob;

          If  PrcCmd( 'WRKJOB '                    +
                      %TrimR( RCVM0200.SndJobNbr ) + '/' +
                      %TrimR( RCVM0200.SndUsrPrf ) + '/' +
                      %TrimR( RCVM0200.SndJobNam )
                    ) = 'CPF1070';

            SndStsMsg( 'Job no longer on system.' );
          EndIf;

        EndSr;

        BegSr  SetStsMsg;

          ChkDts  = %Timestamp();
          StsMsg  = *On;
          KeepWdw = *Off;

          SndStsMsg( 'Break messages temporarily suspended.' );

        EndSr;

        BegSr  TglKeepWdw;

          KeepWdw = Not KeepWdw;

        EndSr;

        BegSr  CmdEnt;

          CallP  CmdEntPnl();

        EndSr;

        BegSr  DltMsg;

          RmvMsg( PxMsgQueNam + PxMsgQueLib
                : PxMsgKey
                : '*BYKEY'
                : ERRC0100
                );

          If  ERRC0100.BytAvl = *Zero;

            W1MSG = '*DELETED';
            KeepWdw = *Off;
          EndIf;

        EndSr;

        BegSr  RpyToSnd;

          PrcCmd( '?SNDMSG ??MSG() ?*TOUSR('          +
                  %TrimR( RCVM0200.SndUsrPrf )        +
                  ') ?-TOMSGQ() ??MSGTYPE(*INFO)'
                );

        EndSr;
        BegSr  EndPgm;

          If  %Open( CBX921D );
            Close  CBX921D;
          EndIf;

          Return;

        EndSr;

        BegSr  *InzSr;

          ChgEnv( LowLvlEnv
                : %Size( LowLvlEnv )
                : *Omit
                : ERRC0100
                );

        EndSr;

      /End-Free

     **-- Process command:  --------------------------------------------------**
     P PrcCmd          B                   Export
     D                 Pi             7a
     D  PxCmdStr                   1024a   Const  Varying

     **-- Local variables:
     D CpOptCtlBlk     Ds
     D  CpTypPrc                     10i 0 Inz( 2 )
     D  CpDBCS                        1a   Inz( '0' )
     D  CpPmtAct                      1a   Inz( '2' )
     D  CpCmdStx                      1a   Inz( '0' )
     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
     D  CpRsv                         9a   Inz( *Allx'00' )
     **
     D CpChgCmd        s          32767a
     D CpChgCmdAvl     s             10i 0

      /Free

        PrcCmds( PxCmdStr
               : %Len( PxCmdStr )
               : CpOptCtlBlk
               : %Size( CpOptCtlBlk )
               : 'CPOP0100'
               : CpChgCmd
               : %Size( CpChgCmd )
               : CpChgCmdAvl
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  ERRC0100.MsgId;
        Else;
          Return  *Blanks;
        EndIf;

      /End-Free

     P PrcCmd          E
     **-- Retrieve user text:
     P RtvUsrTxt       B                   Export
     D                 Pi            50a   Varying
     D  PxUsrPrf                     10a   Value
     **
     D USRI0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  UsrTxt                       50a   Overlay( USRI0300: 199 )

      /Free

        RtvUsrInf( USRI0300
                 : %Size( USRI0300 )
                 : 'USRI0300'
                 : PxUsrPrf
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  NULL;

        Else;
          Return  %Trim( USRI0300.UsrTxt );
        EndIf;

      /End-Free

     P RtvUsrTxt       E
     **-- Send status message:
     P SndStsMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                   1024a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*STATUS'
                 : '*EXT'
                 : 0
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndStsMsg       E
