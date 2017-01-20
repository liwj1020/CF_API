     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX946
     **  Description : Enhanced system request menu
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxRtnCod . . :  BOTH:   Return code
     **                            1=Display system request menu (default)
     **                            0=Do not display system request menu
     **
     **    PxUsrOpt . . :  BOTH:   User option
     **                            Input line data
     **
     **
     **  Sequence of events:
     **    1. Every time the system request function is evoked by a user
     **       registered with the presystem request exit point, the exit
     **       point programs are called.  Up to 8 programs can be added to
     **       this exit point and are called in the order from 1 to 8.
     **
     **    2. The system request line is parsed into an option and a command
     **       parameter variable using the strtok C library function.
     **
     **    3. A message id is built from a predefined prefix and the retrieved
     **       menu option and subsequently retrieved from a system request menu
     **       message file by the QMHRTVM (Retrieve message) API.
     **
     **    4. If the message description exists in the message file, the returned
     **       message text is used as the command input to the QCAPCMD (Process
     **       commands) API.  If no such message description is found the exit
     **       point program returns control to the exit point facility, leaving
     **       the return code parameter unchanged.
     **
     **    5. If a command is retrieved from the mesage file the return code is
     **       set to bypass the system request function when the exit point has
     **       finished processing all exit point programs.
     **
     **    6. If an error occurred during the command processing in the service
     **       program the exception message is changed to a diagnostic message
     **       and percolated back to the calling program by the QMHMOVPM (Move
     **       program message) API.
     **
     **    7. The QMHRCVPM (Receive program message) API catches the returned
     **       diagnostic messages and the message text is retrieved and passed
     **       to the QUILNGTX (Display long text) API - which in turn displays
     **       the message text in a pop-up window.  To ensure that the problem
     **       is noticed the QsnBeep (Generate beep) API sends an alarm sound
     **       to the terminal session.
     **
     **
     **  Programmer's notes:
     **    A detailed description of presystem request exit point as well as
     **    the preattention exit point interface can be found in the Work
     **    Management API manual.
     **
     **    Please check if there has already been added an exit point program
     **    to the QIBM_QWT_SYSREQPGMS exit point prior to registering this
     **    API example: WRKREGINF QIBM_QWT_SYSREQPGMS followed by option 8
     **    will give you the answer.
     **
     **    CBX946C expects a single 10 byte parameter passing the name of
     **    the library to contain all the API example objects.  The library
     **    list is used by the exit point program to address all referenced
     **    objects so they should reside in a library included in the job's
     **    predefined library list.
     **
     **
     **  Prerequisites:
     **    1. CrtMsgF     MsgF( QUSRSYS/SRQMSGF )         +
     **                   Text( 'System request menu options' )
     **
     **    2. AddMsgd     Msgd( SRQ0021 )                 +
     **                   Msgf( QUSRSYS/SRQMSGF )         +
     **                   Msg( '<system request menu option 21 command>')
     **                   ... repeat for each option
     **
     **    3. AddExitPgm  ExitPnt( QIBM_QWT_SYSREQPGMS )  +
     **                   Format( SREQ0100 )              +
     **                   PgmNbr( 1 )                     +
     **                   Pgm( <library name>/CBX946 )    +
     **                   PgmDta( *JOB *CALC 1 )          +
     **                   Text( 'Enhanced system request menu' )
     **
     **    The above three steps are all performed by the CBX946C program
     **    including the adding of a number of sample system request menu
     **    options.  These options can of course be changed or deleted as
     **    you prefer.
     **
     **
     **  To activate exit program 1 for a given user profile:
     **    ChgPrfExit UsrId( <user profile> )          +
     **               Format( *SYSRQS )                +
     **               ExitPgm( *ON *OFF *OFF *OFF *OFF *OFF *OFF *OFF )
     **
     **  To deactivate exit program 1 for a given user profile:
     **    ChgPrfExit UsrId( <user profile> )          +
     **               Format( *SYSRQS )                +
     **               ExitPgm( *OFF *OFF *OFF *OFF *OFF *OFF *OFF *OFF )
     **
     **
     **  Compile options required:
     **    CrtRpgMod  Module( CBX946 )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( <library>/CBX946 )
     **               Module( CBX946 )
     **               BndSrvPgm( <library>/CBX946S )
     **               ActGrp( QILE )
     **
     **
     **-- Header Specifications:  --------------------------------------------
     H Option( *SrcStmt )  BndDir( 'QC2LE' )

     **-- Global variables:
     D MnuOpt          s              2a
     D MnuPrm          s            128a
     D CmdStr          s           1024a   Varying
     D MsgStr          s            512a
     **-- Global constants:
     D NO_SRQ_MNU      c                   0

     **-- Message text parameter:
     D RCVM0200        Ds                  Qualified
     D  BytPrv                       10i 0
     D  BytAvl                       10i 0
     D  MsgSev                       10i 0
     D  MsgId                         7a
     D  MsgTyp                        2a
     D  MsgKey                        4a
     D  MsgF                         10a
     D  MsgFlib                      10a
     D  MsgFlibUsd                   10a
     D  SndJob                       10a
     D  SndUsrPrf                    10a
     D  SndJobNbr                     6a
     D  SndPgm                       12a
     D                                4a
     D  SndDat                        7a
     D  SndTim                        6a
     D                               17a
     D  CcsIdCsiTxt                  10i 0
     D  CcsIdCsiDta                  10i 0
     D  AlrOpt                        9a
     D  CcsIdTxt                     10i 0
     D  CcsIdDta                     10i 0
     D  MsgDtaRtn                    10i 0
     D  MsgDtaAvl                    10i 0
     D  MsgTxtRtn                    10i 0
     D  MsgTxtAvl                    10i 0
     D  MsgHlpRtn                    10i 0
     D  MsgHlpAvl                    10i 0
     D  MsgVarFld                  4096a

     **-- Receive program message:
     D RcvPgmMsg       Pr                  ExtPgm( 'QMHRCVPM' )
     D  RpRcvVar                  32767a          Options( *VarSize )
     D  RpRcvVarLen                  10i 0 Const
     D  RpFmtNam                     10a   Const
     D  RpCalStkE                   256a   Const  Options( *VarSize )
     D  RpCalStkCtr                  10i 0 Const
     D  RpMsgTyp                     10a   Const
     D  RpMsgKey                      4a   Const
     D  RpWait                       10i 0 Const
     D  RpMsgAct                     10a   Const
     D  RpError                      10i 0 Const
     **-- Display long text:
     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
     D  DtLngTxt                   1024a   Const  Options( *VarSize )
     D  DtLngTxtLen                  10i 0 Const
     D  DtMsgId                       7a   Const
     D  DtMsgF                       20a   Const
     D  DtError                      10i 0 Const
     **-- Sound alarm:
     D Beep            Pr            10i 0 ExtProc( 'QsnBeep' )
     D  CmdBufHdl                    10i 0 Const  Options( *Omit )
     D  LlvEnvHdl                    10i 0 Const  Options( *Omit )
     D  ApiError                   1024a          Options( *Omit: *VarSize )
     **-- Parse string:
     D GetToken        Pr              *   ExtProc( 'strtok' )
     D  String                         *   Value  Options( *String )
     D  Delimiters                     *   Value  Options( *String )
     **-- Process command:
     D PrcCmd          Pr            10i 0
     D  CmdStr                     1024a   Const  Varying

     **-- Retrieve message text:
     D RtvMsgTxt       Pr          1024a   Varying
     D  MsgId                         7a   Value
     D  MsgF                         10a   Value
     D  MsgFlib                      10a   Value
     D  MsgDta                     1024a   Const  Options( *NoPass )
     **-- Get string:
     D GetStr          Pr          1024a   Varying
     D  StrPtr                         *   Value

     **-- Entry parameters:
     D CBX946          Pr
     D  PxRtnCod                     10i 0
     D  PxUsrOpt                    128a
     **
     D CBX946          Pi
     D  PxRtnCod                     10i 0
     D  PxUsrOpt                    128a

      /Free

        MnuOpt = GetStr( GetToken( PxUsrOpt: ' ' ));

        MnuPrm = GetStr( GetToken( *Null: x'00' ));

        If  MnuOpt >  '20'  And
            MnuOpt <> '80'  And
            MnuOpt <> '90'  Or
            MnuOpt =  '00';

          CmdStr = RtvMsgTxt( 'SRQ00' + MnuOpt: 'SRQMSGF': '*LIBL': MnuPrm );

          If  CmdStr <> *Blanks;
            PxRtnCod = NO_SRQ_MNU;

            If  PrcCmd( CmdStr ) = -1;
              MsgStr = *Blanks;

              DoU  RCVM0200.BytAvl = *Zero;

                CallP(e)  RcvPgmMsg( RCVM0200
                                   : %Len( RCVM0200 )
                                   : 'RCVM0200'
                                   : '*'
                                   : *Zero
                                   : '*DIAG'
                                   : *Blanks
                                   : *Zero
                                   : '*OLD'
                                   : *Zero
                                   );

                If  %Error;
                  Leave;
                EndIf;

                If  RCVM0200.BytAvl > *Zero;

                  MsgStr = %TrimR( MsgStr ) + '  ' +
                           %SubSt( RCVM0200.MsgVarFld
                                 : RCVM0200.MsgDtaRtn + 1
                                 : RCVM0200.MsgTxtRtn
                                 );
                EndIf;
              EndDo;

              Beep( *Omit: *Omit: *Omit );

              DspLngTxt( %TrimL( MsgStr )
                       : %Len( %TrimL( MsgStr ))
                       : 'CPF0006'
                       : *Blanks
                       : *Zero
                       );
            EndIf;
          EndIf;
        EndIf;

        Return;

      /End-Free
