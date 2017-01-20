     **
     **  Program . . : CBX9182
     **  Description : Receive & set encrypted user password
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program waits on the specified data queue for entries to
     **    arrive.  Each received data queue entry is, if identified
     **    correctly, processed in accordance with the user profile event
     **    that generated it:
     **
     **    1. User profiles having been created and restored are ignored
     **       and an informational message is sent to the user profile
     **       runnning this program.
     **
     **    2. User profiles having had their password changed will have
     **       the new password applied to the local user profile.
     **
     **    3. User profiles having been deleted will have a password value
     **       of *NONE applied to the local user profile.
     **
     **    The above actions will only occur if the following criteria are
     **    met:
     **
     **    1. The local user profile user class must be *USER.
     **
     **    2. The local system name must be different from the system name
     **       where the data queue entry was generated.
     **
     **    3. The release level must be the same for both the remote and
     **       the local system.
     **
     **    4. The password level must be the same for both the remote and
     **       the local system.
     **
     **    The above events and rules are naturally subject to any change
     **    that might be appropriate for any individual installation.
     **
     **
     **  Programmer's notes:
     **    The programs CBX9181 and CBX9182 along with CBX918S are intended
     **    to offer a starting point for an iSeries password synchronization
     **    facility.  The most obvious considerations and restrictions are
     **    taken into account, but it is important to emphasize that further
     **    individual aspects should be investigated thoroughly before any
     **    attempts are made to put this type of utility into production.
     **
     **
     **    Service program CBX918S should either be located in a library
     **    present in the library list of all jobs directly or indirectly
     **    - through exit point - calling the CBX9181 and CBX9182 programs
     **    or the library of CBX918S should be specified directly on the
     **    the CRTPGM command's BNDSRVPGM parameter.
     **
     **
     **    To ensure that the arriving data queue entries are processed
     **    immediately, this program should be submitted to a job queue
     **    available for a never ending processing type of job:
     **
     **      SbmJob Cmd( CALL PGM( CBX9182 ))
     **             Job( SECPRFEVT )
     **             JobQ( <job queue name> )
     **
     **    To end the job controlled, run the following command:
     **
     **      EndJob Job( SECPRFEVT )
     **             Option( *CNTRLD )
     **             Delay( 30 )
     **
     **    Option controlled and delay 30 seconds will allow the job
     **    to detect the end request and stop processing gracefully.
     **
     **
     **  Create user profile event notification setup:
     **
     **    CrtDtaQ    Dtaq( <library>/<data queue> )
     **               MaxLen( 4150 )
     **               Seq( *FIFO )
     **               Size( *MAX2GB )
     **               AutoRcl( *YES )
     **               Text( 'User profile event notification - target' )
     **
     **    Example:   CrtDtaQ    Dtaq( QGPL/USRPRFEVT )
     **                          MaxLen( 4150 )
     **                          Seq( *FIFO )
     **                          Size( *MAX2GB )
     **                          AutoRcl( *YES )
     **                          Text( 'User profile event notification - target' )
     **
     **
     **  Authority and security restrictions:
     **    To retrieve and set an encrypted user password *ALLOBJ and *SECADM
     **    special authority is required.  To change a user password using the
     **    QSYCHGPW API, *ALLOBJ special authority and *USE authority to the
     **    user profile to be changed is required.                          ch
     **
     **    If appropriate, the required authority can be obtained by means of
     **    adopted authority:  Change the program object's UsrPrf attribute
     **    to *OWNER using the ChgPgm command, and change the program object
     **    owner to a user profile having sufficient authority using the
     **    ChgObjOwn command:
     **
     **      ChpPgm     Pgm( CBX9182 )  UsrPrf( *OWNER )
     **      ChgObjOwn  Obj( CBX9182 )  ObjType( *PGM )  NewOwn( <user profile> )
     **
     **
     **  Compilation specification:
     **
     **    CrtRpgMod  Module( CBX9182 )
     **               DbgView( *NONE )
     **
     **    CrtPgm     Pgm( CBX9182 )
     **               Module( CBX9182 )
     **               BndSrvPgm( CBX918S )
     **               ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- System information:
     D PgmSts         SDs                  NoOpt
     D  PsPgmNam         *Proc
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- API Error data structure:
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   256a
     **-- API receiver variable:
     D UPWD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PwdDtaEnc                  4096a
     **-- User profile event structure:
     D UsrPrfEvt       Ds                  Qualified
     D  RcdTyp                        5a
     D  UsrPrf                       10a
     D  UsrPrfAct                     3a
     D  SysNam                        8a
     D  SysRls                        6a
     D  PwdLvl                       10i 0
     D  PwdDta                             LikeDs( UPWD0100 )
     **-- Global variables:
     D RtnCod          s             10i 0
     **-- Data queue API parameters:
     D DqDtaLen        s              5p 0
     D DQ_WAIT_SEC     c                   25
     **-- Retrieve data queue entry:
     D RcvDtaQe        Pr                  ExtPgm( 'QRCVDTAQ' )
     D  RqName                       10a   Const
     D  RqLib                        10a   Const
     D  RqDtaLen                      5p 0
     D  RqDta                     32767a          Options( *VarSize )
     D  RqWait                        5p 0 Const
     D  RqKeyOrder                    2a   Const  Options( *NoPass )
     D  RqKeyLen                      3p 0 Const  Options( *NoPass )
     D  RqKey                       256a   Const  Options( *VarSize: *NoPass )
     D  RqSndInLg                     3p 0 Const  Options( *NoPass)
     D  RqSndInfo                    44a          Options( *VarSize: *Nopass )
     **-- Set encrypted user password:
     D SetUsrPwd       Pr                  ExtPgm( 'QSYSUPWD' )
     D  SpInpVar                  32767a          Options( *VarSize )
     D  SpFmtNam                      8a   Const
     D  SpError                   32767a          Options( *VarSize )
     **-- Change user password:
     D ChgUsrPwd       Pr                  ExtPgm( 'QSYCHGPW' )
     D  CpUsrId                      10a   Const
     D  CpCurPwd                    128a   Const  Options( *VarSize )
     D  CpNewPwd                    128a   Const  Options( *VarSize )
     D  CpError                   32767a          Options( *VarSize )
     D  CpCurPwdLen                  10i 0 Const  Options( *NoPass )
     D  CpCurPwdCcsId                10i 0 Const  Options( *NoPass )
     D  CpNewPwdLen                  10i 0 Const  Options( *NoPass )
     D  CpNewPwdCcsId                10i 0 Const  Options( *NoPass )
     **
     **-- Get system password level:
     D GetPwdLvl       Pr            10i 0
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get system release level:
     D GetRlsLvl       Pr             6a
     **-- Get user last password change timestamp:
     D GetPwdDts       Pr              z
     D  PxUsrPrf                     10a   Value
     **-- Get user class:
     D GetUsrCls       Pr            10a   Varying
     D  PxUsrPrf                     10a   Value
     **-- Send error message:
     D SndErrMsg       Pr            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying

      /Free

        DoW  Not *InLr;

          RcvDtaqE( 'USRPRFEVT'
                  : 'QGPL'
                  : DqDtaLen
                  : UsrPrfEvt
                  : DQ_WAIT_SEC
                  );

          Select;
          When  %Error;
            SndErrMsg( PsCurUsr
                     : 'Job ' +  %TrimR( PsJobNbr ) +
                       '/'    +  %TrimR( PsUsrPrf ) +
                       '/'    +  %TrimR( PsCurJob ) +
                       ' encountered an error, please check the joblog'
                     );

          When  DqDtaLen  > *Zero;
            ExSr  PrcDtaQe;
          EndSl;

          *InLr  = %Shtdn();
        EndDo;

        Return;

        BegSr  PrcDtaQe;

          Select;
          When  UsrPrfEvt.RcdTyp  <> '*PRFE';
            RtnCod  = 1;

          When  GetUsrCls( UsrPrfEvt.UsrPrf )  <> '*USER';
            RtnCod  = 11;

          When  UsrPrfEvt.SysNam  =  GetSysNam();
            RtnCod  = 12;

          When  UsrPrfEvt.PwdLvl  <> GetPwdLvl();
            RtnCod  = 13;

          When  UsrPrfEvt.SysRls  <> GetRlsLvl();
            RtnCod  = 14;

          When  UsrPrfEvt.UsrPrfAct  = 'CRT';
            RtnCod  = 21;

          When  UsrPrfEvt.UsrPrfAct  = 'RST';
            RtnCod  = 22;

          Other;
            RtnCod  = *Zero;
          EndSl;

          If  RtnCod  = *Zero;

            If  UsrPrfEvt.UsrPrfAct  = 'DLT';
              ChgUsrPwd( UsrPrfEvt.UsrPrf: '*NOPWD': '*NONE': ApiError );

              If  AeBytAvl  > *Zero;
                RtnCod  = 31;
              EndIf;

            Else;
              SetUsrPwd( UsrPrfEvt.PwdDta: 'UPWD0100': ApiError );

              If  AeBytAvl  > *Zero;
                RtnCod  = 32;
              EndIf;
            EndIf;

            If  RtnCod  > *Zero;

              SndErrMsg( PsCurUsr
                       : 'Security event terminated due to return code ' +
                         %Char( RtnCod )
                       );
            EndIf;
          EndIf;

        EndSr;

      /End-Free
