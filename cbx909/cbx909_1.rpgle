     **-- Program description:  ----------------------------------------------**
     **
     **
     **
     **-- Create spooled file notification setup:  ---------------------------**
     **
     **   CrtDtaQ    Dtaq( <library name>/<data queue name> )
     **              MaxLen( 144 )
     **              Seq( *FIFO )
     **              Size( *MAX2GB )
     **              AutoRcl( *YES )
     **              Text( 'Spooled file creation notification' )
     **
     **
     **   AddEnvVar  EnvVar( QIBM_NOTIFY_CRTSPLF )
     **              Value( '*DTAQ <library name>/<data queue name>' )
     **              Level( *JOB | *SYS )
     **
     **   Level *JOB affects all spooled file created by the job adding
     **   the enviroment variable whereas level *SYS affects all spooled
     **   files created on the system.
     **
     **   Note: An environment variable specified at the job level takes
     **   precedence over the same environment variable specified at the
     **   system level.
     **
     **   User profile QSPL must have *OBJOPR and *ADD authorization to
     **   the data queue and *EXECUTE to the library specified.
     **
     **   The change is immediately effective for any spooled file created
     **   following the completion of the above setup.                      hr.htm
     **
     **
     **-- Compilation specification:  ----------------------------------------**
     **
     **   CrtRpgMod Module( CBX908 )   DbgView( *NONE )
     **   CrtPgm    Pgm( CBX909 )      Module( CBX909 )   ActGrp( QILE )
     **
     **
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
     D  S2Job                        26a
     D   S2JobNam                    10a   Overlay( S2Job: 1 )
     D   S2UsrNam                    10a   Overlay( S2Job: *Next )
     D   S2JobNbr                     6a   Overlay( S2Job: *Next )
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
     D  S2ThrId                      10i 0
     D  S2SysNam                     10a
     D  S2CrtDat                      7a
     D  S2CrtTim                      6a
     D  S2Rsv                         9a
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
     C                   If        %Error
     **...
     C                   ElseIf    DqDtaLen    > *Zero
     **
     C                   ExSr      PrcDtaqE
     C                   EndIf
     **
     C                   Eval      *InLr     = %Shtdn()
     C                   EndDo
     **
     C                   Return
     **
     **-- Process data queue entry:  -----------------------------------------**
     C     PrcDtaqE      BegSr
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
     **
