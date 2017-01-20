     **
     **  Program . . : CBX9181
     **  Description : Retrieve & send encrypted user password
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    After registering this program as a user profile event exit
     **    program - see instructions below - the exit point will call
     **    this program every time the related user profile event is
     **    performed (create, change, restore or delete user profile).
     **
     **    Based on the passed information a data queue entry is generated
     **    and put on a DDM data queue pointing to a remote system to where
     **    the change to the local user profile's password or existence
     **    should be mirrored.
     **
     **    In this sample application only user profiles having a user
     **    class of *USER will generate a data queue entry.
     **
     **
     **  Programmer's notes:
     **    Service program CBX918S should either be located in a library
     **    present in the library list of all jobs directly or indirectly
     **    - through exit point - calling the CBX9181 and CBX9182 programs
     **    or the library of CBX918S should be specified directly on the
     **    the CRTPGM command's BNDSRVPGM parameter.
     **
     **
     **  Exit point registration:
     **
     **    AddExitPgm ExitPnt( QIBM_QSY_CRT_PROFILE )
     **               Format( CRTP0100 )
     **               PgmNbr( *LOW )
     **               Pgm( <library>/CBX9181 )
     **               PgmDta( *NONE )
     **
     **    AddExitPgm ExitPnt( QIBM_QSY_CHG_PROFILE )
     **               Format( CHGP0100 )
     **               PgmNbr( *LOW )
     **               Pgm( <library>/CBX9181 )
     **               PgmDta( *NONE )
     **
     **    AddExitPgm ExitPnt( QIBM_QSY_RST_PROFILE )
     **               Format( RSTP0100 )
     **               PgmNbr( *LOW )
     **               Pgm( <library>/CBX9181 )
     **               PgmDta( *NONE )
     **
     **    AddExitPgm ExitPnt( QIBM_QSY_DLT_PROFILE )
     **               Format( DLTP0100 )
     **               PgmNbr( *LOW )
     **               Pgm( <library>/CBX9181 )
     **               PgmDta( *NONE )
     **
     **
     **  Create user profile event notification setup:
     **
     **    CrtDtaQ    Dtaq( <library>/<data queue> )
     **               Type( *DDM )
     **               RmtDtaQ( QGPL/USRPRFEVT )
     **               RmtLocName( <remote system> )
     **               Dev( *LOC )
     **               LclLocName( *LOC )
     **               Mode( *NETATR )
     **               RmtNetId( *LOC )
     **               Text( 'User profile event notification - source' )
     **
     **    Example:   CrtDtaQ    Dtaq( QGPL/USRPRFEVT )
     **                          Type( *DDM )
     **                          RmtDtaQ( QGPL/USRPRFEVT )
     **                          RmtLocName( <remote system> )
     **                          Dev( *LOC )
     **                          LclLocName( *LOC )
     **                          Mode( *NETATR )
     **                          RmtNetId( *LOC )
     **                          Text( 'User profile event notification - source' )
     **
     **               - The above example assumes that the default values
     **                 for the SNA configuration parameters are mapping to
     **                 the correct values for the source and target systems.
     **
     **                 Details about the SNA configuration parameters can be
     **                 found in the IBM Software Knowledge Base document
     **                 number 15863050:
     **
     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
     **                          1ac66549a21402188625680b0002037e/
     **                          66603a67c13a4f118625676a00601dd6?OpenDocument
     **
     **                 Details about a SNA configuration over TCP/IP using
     **                 AnyNet can likewise be found in the IBM Software
     **                 Knowledge Base document number 8923426:
     **
     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
     **                          1ac66549a21402188625680b0002037e/
     **                          c5057870085200f8862565c2007cdc47?OpenDocument
     **
     **                 The easiest way to configure DDM data queue support
     **                 over TCP/IP is however to use the Relational Database
     **                 Directory (RDB) method. The following IBM Software
     **                 Knowledge Base document number 8923426 describes
     **                 how to configure this type of connection:
     **
     **                   http://www-912.ibm.com/s_dir/slkbase.nsf/
     **                   21401ac66549a2188625680b0002037e/e95c5072635554dd86256e9800
     **                   e95c5072635554dd86256e980068aada?OpenDocument
     **
     **
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
     **      ChpPgm     Pgm( CBX9181 )  UsrPrf( *OWNER )
     **      ChgObjOwn  Obj( CBX9181 )  ObjType( *PGM )  NewOwn( <user profile> )
     **
     **
     **  Compilation specification:
     **
     **    CrtRpgMod  Module( CBX9181 )
     **               DbgView( *NONE )
     **
     **    CrtPgm     Pgm( CBX9181 )
     **               Module( CBX9181 )
     **               BndSrvPgm( CBX918S )
     **               ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- API error data structure:
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   256a
     **-- Encrypted password receiver variable:
     D UPWD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PwdDtaEnc                  4096a
     **-- User profile event structure:
     D UsrPrfEvt       Ds                  Qualified
     D  RcdTyp                        5a   Inz( '*PRFE' )
     D  UsrPrf                       10a
     D  UsrPrfAct                     3a
     D  SysNam                        8a
     D  SysRls                        6a
     D  PwdLvl                       10i 0
     D  PwdDta                             LikeDs( UPWD0100 )
     **
     **-- Retrieve encrypted user password:
     D RtvUsrPwd       Pr                  ExtPgm( 'QSYRUPWD' )
     D  RpRcvVar                  32767a          Options( *VarSize )
     D  RpRcvVarLen                  10i 0 Const
     D  RpFmtNam                      8a   Const
     D  RpUsrPrf                     10a   Const
     D  RpError                   32767a          Options( *VarSize )
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
     **-- Send data queue entry:
     D SndDtaQe        Pr                  ExtPgm( 'QSNDDTAQ' )
     D  SqName                       10a   Const
     D  SqLib                        10a   Const
     D  SqDtaLen                      5p 0 Const
     D  SqDta                     32767a   Const  Options( *VarSize )
     D  SqKeyLen                      3p 0 Const  Options( *NoPass )
     D  SqKey                       256a   Const  Options( *VarSize: *NoPass )
     **-- Get system password level:
     D GetPwdLvl       Pr            10i 0
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get system release level:
     D GetRlsLvl       Pr             6a
     **-- Get user last password change timestamp:  --------------------------**
     D GetPwdDts       Pr              z
     D  PxUsrPrf                     10a   Value
     **-- Get user class:
     D GetUsrCls       Pr            10a   Varying
     D  PxUsrPrf                     10a   Value
     **
     **-- User profile exit parameter:
     D XitParm         Ds                  Qualified
     D  XitPntNam                    20a
     D  XitPntFmt                     8a
     D   UsrPrfAct                    3a   Overlay( XitPntFmt: 1 )
     D  UsrPrf                       10a
     **-- Entry parameter:
     D CBX9181         Pr
     D  PxXitParm                          Like( XitParm )
     **
     D CBX9181         Pi
     D  PxXitParm                          Like( XitParm )

      /Free

        XitParm  = PxXitParm;

        If  XitParm.XitPntFmt  = 'CRTP0100'  Or
            XitParm.XitPntFmt  = 'CHGP0100'  Or
            XitParm.XitPntFmt  = 'RSTP0100'  Or
            XitParm.XitPntFmt  = 'DLTP0100';

          If  GetUsrCls( XitParm.UsrPrf ) = '*USER';

            If  XitParm.UsrPrfAct  = 'CRT'  Or
                XitParm.UsrPrfAct  = 'RST'  Or
                XitParm.UsrPrfAct  = 'CHG'  And
                %Diff( %Timestamp()
                     : GetPwdDts( XitParm.UsrPrf )
                     : *Seconds
                     )             < 5;

              RtvUsrPwd( UPWD0100: %Size( UPWD0100 ): 'UPWD0100'
                       : XitParm.UsrPrf
                       : ApiError
                       );

            Else;
              Clear  UPWD0100;
            EndIf;

            UsrPrfEvt.UsrPrf    = XitParm.UsrPrf;
            UsrPrfEvt.UsrPrfAct = XitParm.UsrPrfAct;
            UsrPrfEvt.SysNam    = GetSysNam();
            UsrPrfEvt.PwdLvl    = GetPwdLvl();
            UsrPrfEvt.SysRls    = GetRlsLvl();
            UsrPrfEvt.PwdDta    = UPWD0100;

            SndDtaQe( 'USRPRFEVT'
                    : 'QGPL'
                    : %Size( UsrPrfEvt )
                    : UsrPrfEvt
                    );

          EndIf;
        EndIf;

        Return;

      /End-Free
