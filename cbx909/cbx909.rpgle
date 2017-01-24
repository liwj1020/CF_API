     **
     **  Program . . : CBX909
     **  Description : Process spooled file creation data queue entries
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **
     **    This program gives an example of how to setup spooled file
     **    creation notification through a data queue and how to process
     **    the generated data queue entries.
     **
     **    In this example an informational message describing each spooled
     **    file created - either within one or more individual jobs or on
     **    the system in general - is sent to the user profile running this
     **    program.
     **
     **
     **  Create spooled file notification setup:
     **
     **    CrtDtaQ    Dtaq( <library name>/<data queue name> )
     **               MaxLen( 144 )
     **               Seq( *FIFO )
     **               Size( *MAX2GB )
     **               AutoRcl( *YES )
     **               Text( 'Spooled file creation notification' )
     **
     **    AddEnvVar  EnvVar( QIBM_NOTIFY_CRTSPLF )
     **               Value( '*DTAQ <library name>/<data queue name>' )
     **               Level( *JOB | *SYS )
     **
     **    Level *JOB affects all spooled file created by the job adding
     **    the enviroment variable whereas level *SYS affects all spooled
     **    files created on the system.
     **
     **    Note: An environment variable specified at the job level takes
     **    precedence over the same environment variable specified at the
     **    system level.
     **
     **    User profile QSPL must have *OBJOPR and *ADD authorization to
     **    the data queue and *EXECUTE to the library specified.
     **
     **    The change is immediately effective for any spooled file created
     **    following the completion of the above setup.
     **
     **      Example:  CrtDtaQ    Dtaq( QGPL/SPLFCRTNTF )
     **                           MaxLen( 144 )
     **                           Seq( *FIFO )
     **                           Size( *MAX2GB )
     **                           AutoRcl( *YES )
     **                           Text( 'Spooled file creation notification')
     **
     **                AddEnvVar  EnvVar( QIBM_NOTIFY_CRTSPLF )
     **                           Value( '*DTAQ QGPL/SPLFCRTNTF' )
     **                           Level( *JOB )
     **
     **    If, for some reason, the spool function is not able to succesfully
     **    add entries to the data queue specified, diagnostic messages can
     **    be found in the joblog for the job creating the spooled file.
     **
     **    APAR SE07090 describes the correct format of the spooled file
     **    creation data queue entry type 02. The description in the Printer
     **    Device Programming V5R2 manual chapter 3 is incorrect.
     **
     **    Note: There is currently a bug in the Auxiliary Storage Pool
     **    subfield as it returns a zero. The bug will be corrected in a
     **    future release.
     **
     **    Note: The Thread Id subfield is defined as a character subfield
     **    but the value in this field is actually designed as a handle type
     **    - and will contain the thread id in hexadecimal format.
     **
     **      Example: Thread Id 00000012 will appear as x'0000000000000012'.
     **
     **    If a spooled file is associated with a QPRTJOB job - as a result
     **    of a user profile swap - the qualified QPRTJOB name will appear
     **    in the associated job field in the data queue record format, and
     **    the original job name will appear in the creator job field. In
     **    all other cases the two job names will be identical.
     **
     **    The printer device manual V5R2 documents the sitauations where a
     **    spooled file will be associated with QPRTJOB on page 157.
     **
     **
     **  Compilation specification:
     **
     **    CrtRpgMod Module( CBX909 )
     **              DbgView( *NONE )
     **
     **    CrtPgm    Pgm( CBX909 )
     **              Module( CBX909 )
     **              ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- System information:  -----------------------------------------------**
     D PgmSts         SDs                  NoOpt
     D  PsPgmNam         *Proc
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- Global declarations:  ----------------------------------------------**
     D MsgDta          s            128a   Varying
     D MsgKey          s              4a
     **-- Spooled file data queue entry record format type 02:  --------------**
     D SPLF0002        Ds           144
     D  S2FncId                      10a
     D  S2RcdTyp                      2a
     D  S2AscJob                     26a
     D   S2AscJobNam                 10a   Overlay( S2AscJob: 1 )
     D   S2AscUsrNam                 10a   Overlay( S2AscJob: *Next )
     D   S2AscJobNbr                  6a   Overlay( S2AscJob: *Next )
     D  S2SplfNam                    10a
     D  S2SplfNbr                    10i 0
     D  S2Outq                       20a
     D   S2OutqNam                   10a   Overlay( S2Outq: 1 )
     D   S2OutqLib                   10a   Overlay( S2Outq: *Next )
     D  S2CrtJob                     26a
     D   S2CrtJobNam                 10a   Overlay( S2CrtJob: 1 )
     D   S2CrtUsrNam                 10a   Overlay( S2CrtJob: *Next )
     D   S2CrtJobNbr                  6a   Overlay( S2CrtJob: *Next )
     D  S2UsrDta                     10a
     D  S2AuxStgPool                 10i 0
     D  S2ThrId                       8a
     D  S2SysNam                     10a
     D  S2CrtDat                      7a
     D  S2CrtTim                      6a
     D  S2Rsv2                        1a
     **-- Data queue API parameters:  ----------------------------------------**
     D DqDtaLen        s              5p 0
     D DqDtqRcv        s             10a   Inz( 'SPLFCRTNTF' )
     D DqDtqLib        s             10a   Inz( 'QGPL' )
     **-- Send Message:  -----------------------------------------------------**
     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
     D  SmMsgId                       7a   Const
     D  SmMsgFq                      20a   Const
     D  SmMsgDta                    512a   Const  Options( *VarSize )
     D  SmMsgDtaLen                  10i 0 Const
     D  SmMsgTyp                     10a   Const
     D  SmMsgQq                    1000a   Const  Options( *VarSize )
     D  SmMsgQnbr                    10i 0 Const
     D  SmMsgQrpy                    20a   Const
     D  SmMsgKey                      4a
     D  SmError                      10i 0 Const
     **
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
     **-- Retrieve data queue entry:  ----------------------------------------**
     D RcvDtaqE        Pr                  ExtPgm( 'QRCVDTAQ' )
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
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   DoW       Not *InLr
     **
     C                   CallP(e)  RcvDtaqE( DqDtqRcv
     C                                     : DqDtqLib
     C                                     : DqDtaLen
     C                                     : SPLF0002
     C                                     : 25
     C                                     )
     **
     C                   Select
     C                   When      %Error
     C                   ExSr      SndErrNtf
     **
     C                   When      DqDtaLen    > *Zero
     C                   ExSr      PrcDtaqE
     C                   EndSl
     **
     C                   Eval      *InLr       = %Shtdn()
     C                   EndDo
     **
     C                   Return
     **
     **-- Process data queue entry:  -----------------------------------------**
     C     PrcDtaqE      BegSr
     **
     C                   Eval      MsgDta     = 'Spooled file '        +
     C                                          %TrimR( S2SplfNam )    +
     C                                          ' number '             +
     C                                          %Char( S2SplfNbr )     +
     C                                          ' created in job '     +
     C                                          %TrimR( S2AscJobNam )  +
     C                                          ' on '                 +
     C                                          %Char( %Date( S2CrtDat: *CYMD0 )
     C                                               : *DMY-
     C                                               )                 +
     C                                          ' at '                 +
     C                                          %Char( %Time( S2CrtTim: *HMS0 )
     C                                               : *HMS:
     C                                               )                 +
     C                                          '.'
     **
     C                   CallP(e)  SndMsg( 'CPF9897'
     C                                   : 'QCPFMSG   *LIBL'
     C                                   : MsgDta
     C                                   : %Len( MsgDta )
     C                                   : '*INFO'
     C                                   : PsCurUsr + '*LIBL'
     C                                   : 1
     C                                   : *Blanks
     C                                   : MsgKey
     C                                   : 0
     C                                   )
     **
     C                   EndSr
     **-- Send error notification:  ------------------------------------------**
     C     SndErrNtf     BegSr
     **
     C                   Eval      MsgDta     = 'Job '                    +
     C                                          %TrimR( PsJobNbr )        +
     C                                          '/'                       +
     C                                          %TrimR( PsUsrPrf )        +
     C                                          '/'                       +
     C                                          %TrimR( PsCurJob )        +
     C                                          ' encountered an error, ' +
     C                                          'please check the joblog'
     **
     C                   CallP(e)  SndMsg( 'CPF9898'
     C                                   : 'QCPFMSG   *LIBL'
     C                                   : MsgDta
     C                                   : %Len( MsgDta )
     C                                   : '*INFO'
     C                                   : PsCurUsr + '*LIBL'
     C                                   : 1
     C                                   : *Blanks
     C                                   : MsgKey
     C                                   : 0
     C                                   )
     **
     C                   EndSr
