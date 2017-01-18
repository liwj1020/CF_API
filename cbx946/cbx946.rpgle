000100951011     **-----------------------------------------------------------------------**
000200030829     **
000300050917     **  Program . . : CBX946
000400050927     **  Description : Enhanced system request menu
000500030829     **  Author  . . : Carsten Flensburg
000600030829     **
000700030829     **
000800030829     **  Parameters:
000900050917     **    PxRtnCod . . :  BOTH:   Return code
001000050917     **                            1=Display system request menu (default)
001100050917     **                            0=Do not display system request menu
001200030829     **
001300050917     **    PxUsrOpt . . :  BOTH:   User option
001400050917     **                            Input line data
001500030829     **
001600050917     **
001700030829     **  Sequence of events:
001800030830     **    1. Every time the system request function is evoked by a user
001900030830     **       registered with the presystem request exit point, the exit
002000030830     **       point programs are called.  Up to 8 programs can be added to
002100030830     **       this exit point and are called in the order from 1 to 8.
002200030830     **
002300030830     **    2. The system request line is parsed into an option and a command
002400030830     **       parameter variable using the strtok C library function.
002500030829     **
002600030830     **    3. A message id is built from a predefined prefix and the retrieved
002700030830     **       menu option and subsequently retrieved from a system request menu
002800030830     **       message file by the QMHRTVM (Retrieve message) API.
002900030830     **
003000030830     **    4. If the message description exists in the message file, the returned
003100030830     **       message text is used as the command input to the QCAPCMD (Process
003200030830     **       commands) API.  If no such message description is found the exit
003300030830     **       point program returns control to the exit point facility, leaving
003400030830     **       the return code parameter unchanged.
003500030830     **
003600030830     **    5. If a command is retrieved from the mesage file the return code is
003700030830     **       set to bypass the system request function when the exit point has
003800030830     **       finished processing all exit point programs.
003900030830     **
004000030830     **    6. If an error occurred during the command processing in the service
004100030830     **       program the exception message is changed to a diagnostic message
004200030830     **       and percolated back to the calling program by the QMHMOVPM (Move
004300030830     **       program message) API.
004400030830     **
004500030830     **    7. The QMHRCVPM (Receive program message) API catches the returned
004600030830     **       diagnostic messages and the message text is retrieved and passed
004700030830     **       to the QUILNGTX (Display long text) API - which in turn displays
004800030830     **       the message text in a pop-up window.  To ensure that the problem
004900030830     **       is noticed the QsnBeep (Generate beep) API sends an alarm sound
005000030830     **       to the terminal session.
005100030830     **
005200030830     **
005300030829     **  Programmer's notes:
005400030830     **    A detailed description of presystem request exit point as well as
005500030830     **    the preattention exit point interface can be found in the Work
005600030830     **    Management API manual.
005700030829     **
005800030830     **    Please check if there has already been added an exit point program
005900030830     **    to the QIBM_QWT_SYSREQPGMS exit point prior to registering this
006000030830     **    API example: WRKREGINF QIBM_QWT_SYSREQPGMS followed by option 8
006100030830     **    will give you the answer.
006200030830     **
006300050925     **    CBX946C expects a single 10 byte parameter passing the name of
006400030830     **    the library to contain all the API example objects.  The library
006500030830     **    list is used by the exit point program to address all referenced
006600030830     **    objects so they should reside in a library included in the job's
006700030830     **    predefined library list.
006800030830     **
006900030830     **
007000030829     **  Prerequisites:
007100030830     **    1. CrtMsgF     MsgF( QUSRSYS/SRQMSGF )         +
007200030830     **                   Text( 'System request menu options' )
007300030829     **
007400030830     **    2. AddMsgd     Msgd( SRQ0021 )                 +
007500030830     **                   Msgf( QUSRSYS/SRQMSGF )         +
007600030830     **                   Msg( '<system request menu option 21 command>')
007700050927     **                   ... repeat for each option
007800030829     **
007900030830     **    3. AddExitPgm  ExitPnt( QIBM_QWT_SYSREQPGMS )  +
008000030830     **                   Format( SREQ0100 )              +
008100030830     **                   PgmNbr( 1 )                     +
008200050917     **                   Pgm( <library name>/CBX946 )    +
008300030830     **                   PgmDta( *JOB *CALC 1 )          +
008400030830     **                   Text( 'Enhanced system request menu' )
008500030829     **
008600050917     **    The above three steps are all performed by the CBX946C program
008700030830     **    including the adding of a number of sample system request menu
008800030830     **    options.  These options can of course be changed or deleted as
008900030830     **    you prefer.
009000030830     **
009100030830     **
009200030830     **  To activate exit program 1 for a given user profile:
009300050917     **    ChgPrfExit UsrId( <user profile> )          +
009400030829     **               Format( *SYSRQS )                +
009500030829     **               ExitPgm( *ON *OFF *OFF *OFF *OFF *OFF *OFF *OFF )
009600030829     **
009700030830     **  To deactivate exit program 1 for a given user profile:
009800050917     **    ChgPrfExit UsrId( <user profile> )          +
009900030829     **               Format( *SYSRQS )                +
010000030829     **               ExitPgm( *OFF *OFF *OFF *OFF *OFF *OFF *OFF *OFF )
010100030829     **
010200030829     **
010300030829     **  Compile options required:
010400050917     **    CrtRpgMod  Module( CBX946 )
010500050917     **               DbgView( *LIST )
010600030829     **
010700050925     **    CrtPgm     Pgm( <library>/CBX946 )
010800050917     **               Module( CBX946 )
010900050925     **               BndSrvPgm( <library>/CBX946S )
011000030829     **               ActGrp( QILE )
011100030829     **
011200030829     **
011300030829     **-- Header Specifications:  --------------------------------------------
011400030804     H Option( *SrcStmt )  BndDir( 'QC2LE' )
011500050917
011600050917     **-- Global variables:
011700000314     D MnuOpt          s              2a
011800030803     D MnuPrm          s            128a
011900030804     D CmdStr          s           1024a   Varying
012000030805     D MsgStr          s            512a
012100050917     **-- Global constants:
012200050917     D NO_SRQ_MNU      c                   0
012300050917
012400050917     **-- Message text parameter:
012500050917     D RCVM0200        Ds                  Qualified
012600050917     D  BytPrv                       10i 0
012700050917     D  BytAvl                       10i 0
012800050917     D  MsgSev                       10i 0
012900050917     D  MsgId                         7a
013000050917     D  MsgTyp                        2a
013100050917     D  MsgKey                        4a
013200050917     D  MsgF                         10a
013300050917     D  MsgFlib                      10a
013400050917     D  MsgFlibUsd                   10a
013500050917     D  SndJob                       10a
013600050917     D  SndUsrPrf                    10a
013700050917     D  SndJobNbr                     6a
013800050917     D  SndPgm                       12a
013900030803     D                                4a
014000050917     D  SndDat                        7a
014100050917     D  SndTim                        6a
014200030803     D                               17a
014300050917     D  CcsIdCsiTxt                  10i 0
014400050917     D  CcsIdCsiDta                  10i 0
014500050917     D  AlrOpt                        9a
014600050917     D  CcsIdTxt                     10i 0
014700050917     D  CcsIdDta                     10i 0
014800050917     D  MsgDtaRtn                    10i 0
014900050917     D  MsgDtaAvl                    10i 0
015000050917     D  MsgTxtRtn                    10i 0
015100050917     D  MsgTxtAvl                    10i 0
015200050917     D  MsgHlpRtn                    10i 0
015300050917     D  MsgHlpAvl                    10i 0
015400050917     D  MsgVarFld                  4096a
015500050917
015600050917     **-- Receive program message:
015700011102     D RcvPgmMsg       Pr                  ExtPgm( 'QMHRCVPM' )
015800030830     D  RpRcvVar                  32767a          Options( *VarSize )
015900011102     D  RpRcvVarLen                  10i 0 Const
016000011102     D  RpFmtNam                     10a   Const
016100030830     D  RpCalStkE                   256a   Const  Options( *VarSize )
016200011102     D  RpCalStkCtr                  10i 0 Const
016300011102     D  RpMsgTyp                     10a   Const
016400011102     D  RpMsgKey                      4a   Const
016500011102     D  RpWait                       10i 0 Const
016600011102     D  RpMsgAct                     10a   Const
016700011102     D  RpError                      10i 0 Const
016800050917     **-- Display long text:
016900030804     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
017000030823     D  DtLngTxt                   1024a   Const  Options( *VarSize )
017100030804     D  DtLngTxtLen                  10i 0 Const
017200030804     D  DtMsgId                       7a   Const
017300030804     D  DtMsgF                       20a   Const
017400030804     D  DtError                      10i 0 Const
017500050917     **-- Sound alarm:
017600030805     D Beep            Pr            10i 0 ExtProc( 'QsnBeep' )
017700030805     D  CmdBufHdl                    10i 0 Const  Options( *Omit )
017800030805     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
017900030805     D  ApiError                   1024a          Options( *Omit: *VarSize )
018000050917     **-- Parse string:
018100000602     D GetToken        Pr              *   ExtProc( 'strtok' )
018200000602     D  String                         *   Value  Options( *String )
018300000602     D  Delimiters                     *   Value  Options( *String )
018400050917     **-- Process command:
018500030805     D PrcCmd          Pr            10i 0
018600030804     D  CmdStr                     1024a   Const  Varying
018700050917
018800050917     **-- Retrieve message text:
018900030823     D RtvMsgTxt       Pr          1024a   Varying
019000030804     D  MsgId                         7a   Value
019100030804     D  MsgF                         10a   Value
019200030804     D  MsgFlib                      10a   Value
019300030823     D  MsgDta                     1024a   Const  Options( *NoPass )
019400050917     **-- Get string:
019500030823     D GetStr          Pr          1024a   Varying
019600000602     D  StrPtr                         *   Value
019700050917
019800050917     **-- Entry parameters:
019900050917     D CBX946          Pr
020000050917     D  PxRtnCod                     10i 0
020100050917     D  PxUsrOpt                    128a
020200050917     **
020300050917     D CBX946          Pi
020400050917     D  PxRtnCod                     10i 0
020500050917     D  PxUsrOpt                    128a
020600050917
020700050917      /Free
020800050917
020900050917        MnuOpt = GetStr( GetToken( PxUsrOpt: ' ' ));
021000050917
021100050917        MnuPrm = GetStr( GetToken( *Null: x'00' ));
021200050917
021300050917        If  MnuOpt >  '20'  And
021400050917            MnuOpt <> '80'  And
021500050917            MnuOpt <> '90'  Or
021600050917            MnuOpt =  '00';
021700050917
021800050917          CmdStr = RtvMsgTxt( 'SRQ00' + MnuOpt: 'SRQMSGF': '*LIBL': MnuPrm );
021900050917
022000050917          If  CmdStr <> *Blanks;
022100050917            PxRtnCod = NO_SRQ_MNU;
022200050917
022300050917            If  PrcCmd( CmdStr ) = -1;
022400050917              MsgStr = *Blanks;
022500050917
022600050917              DoU  RCVM0200.BytAvl = *Zero;
022700050917
022800050917                CallP(e)  RcvPgmMsg( RCVM0200
022900050917                                   : %Len( RCVM0200 )
023000050917                                   : 'RCVM0200'
023100050917                                   : '*'
023200050917                                   : *Zero
023300050917                                   : '*DIAG'
023400050917                                   : *Blanks
023500050917                                   : *Zero
023600050917                                   : '*OLD'
023700050917                                   : *Zero
023800050917                                   );
023900050917
024000050917                If  %Error;
024100050917                  Leave;
024200050917                EndIf;
024300050917
024400050917                If  RCVM0200.BytAvl > *Zero;
024500050917
024600050917                  MsgStr = %TrimR( MsgStr ) + '  ' +
024700050917                           %SubSt( RCVM0200.MsgVarFld
024800050917                                 : RCVM0200.MsgDtaRtn + 1
024900050917                                 : RCVM0200.MsgTxtRtn
025000050917                                 );
025100050917                EndIf;
025200050917              EndDo;
025300050917
025400050917              Beep( *Omit: *Omit: *Omit );
025500050917
025600050917              DspLngTxt( %TrimL( MsgStr )
025700050917                       : %Len( %TrimL( MsgStr ))
025800050917                       : 'CPF0006'
025900050917                       : *Blanks
026000050917                       : *Zero
026100050917                       );
026200050917            EndIf;
026300050917          EndIf;
026400050917        EndIf;
026500050917
026600050917        Return;
026700050917
026800050917      /End-Free
