     **-- Program description:  ----------------------------------------------**
     **
     **     Call or submit this program to have job notification exit
     **     point data queue entries processed.
     **
     **     For each entry type an appropriate message is sent to the
     **     message queue of the user profile running the program.
     **
     **
     **-- Exit point registration:  ------------------------------------------**
     **
     **   Exit point documentation:
     **     http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/xjobntfy.htm
     **
     **     Check also APAR SE06696 for changes to NTFY0100 format.
     **
     **
     **   Prerequisites:
     **
     **     Create system default data queue:
     **
     **     CRTDTAQ DTAQ( QSYS/QSYSDTAQ )
     **             MAXLEN( 144 )
     **             SEQ( *KEYED )
     **             KEYLEN( 4 )
     **             SIZE( *MAX2GB )
     **             AUTORCL( *YES )
     **             TEXT( 'Exit point: QIBM_QWT_JOBNOTIFY -default data queue' )
     **
     **
     **     Create exit point data queue:
     **
     **     CRTDTAQ DTAQ( QGPL/JOBNOTIFY )
     **             MAXLEN( 144 )
     **             SEQ( *KEYED )
     **             KEYLEN( 4 )
     **             SIZE( *MAX2GB )
     **             AUTORCL( *YES )
     **             TEXT( 'Exit point: QIBM_QWT_JOBNOTIFY -format: NTFY0100' )
     **
     **
     **     Register exit point subsystem and data queue:
     **       - Subsystem QINTER in any library for all events:
     **
     **     ADDEXITPGM EXITPNT( QIBM_QWT_JOBNOTIFY )
     **                FORMAT( NTFY0100 )
     **                PGMNBR( *LOW )
     **                PGM( QGPL/JOBNOTIFY )
     **                PGMDTA( *JOB 24 '0007QINTER    *ANY      ' )
     **
     **     - Restart subsystem(s) to make change take effect.
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- API error information:  --------------------------------------------**
     D ApiError        Ds
     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AaExcpDta                   256a
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
     D JobEntDts       s             20a   Inz( *All'0' )
     D JobStrDts       s             20a   Inz( *All'0' )
     D JobEndDts       s             20a   Inz( *All'0' )
     **-- Job start & end notification message:  -----------------------------**
     D MsgJob          Ds
     D  JbMsgId                      10a
     D  JbMsgFmt                      2a
     D  JbJobIdInt                   16a
     D  JbJobIdQ                     26a
     D   JbJobNam                    10a   Overlay( JbJobIdQ: 1 )
     D   JbJobUsr                    10a   Overlay( JbJobIdQ: *Next )
     D   JbJobNbr                     6a   Overlay( JbJobIdQ: *Next )
     D  JbJobQ                       20a
     D   JbJobQnam                   10a   Overlay( JbJobQ: 1 )
     D   JbJobQlib                   10a   Overlay( JbJobQ: *Next )
     D  JbJobEntDts                   8a
     D  JbJobStrDts                   8a
     D  JbJobEndDts                   8a
     D  JbRes1                        2a
     D  JbJobEndSev                  10i 0
     D  JbJobPrcTimMs                20i 0
     D  JbRes2                       32a
     **-- Job queue notification message:  -----------------------------------**
     D MsgJobQ         Ds
     D  JqMsgId                      10a
     D  JqMsgFmt                      2a
     D  JqJobIdInt                   16a
     D  JqJobIdQ                     26a
     D   JqJobNam                    10a   Overlay( JqJobIdQ: 1 )
     D   JqJobUsr                    10a   Overlay( JqJobIdQ: *Next )
     D   JqJobNbr                     6a   Overlay( JqJobIdQ: *Next )
     D  JqJobQ                       20a
     D   JqJobQnam                   10a   Overlay( JqJobQ: 1 )
     D   JqJobQlib                   10a   Overlay( JqJobQ: *Next )
     D  JqJobEntDts                   8a
     D  JqRes1                       62a
     **-- Convert date & time:  ----------------------------------------------**
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const
     D  CdOutVar                     17a          Options( *VarSize )
     D  CdError                      10i 0 Const
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
     **-- Data queue API parameters:  ----------------------------------------**
     D DqDta           Ds           144
     D  DqMsgId                      10a
     D  DqMsgFmt                      2a
     **
     D DqDtaLen        s              5p 0
     D DqKey           s              4a   Inz( '0000' )
     D DqSndInfo       s              1a
     D DqDtqRcv        s             10a   Inz( 'JOBNOTIFY' )
     D DqDtqLib        s             10a   Inz( 'QGPL' )
     **-- Retrieve data queue entry:  ----------------------------------------**
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
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   DoW       Not *InLr
     **
     C                   CallP(e)  RcvDtaQe( DqDtqRcv
     C                                     : DqDtqLib
     C                                     : DqDtaLen
     C                                     : DqDta
     C                                     : 25
     C                                     : 'GT'
     C                                     : %Size( DqKey )
     C                                     : DqKey
     C                                     : 0
     C                                     : DqSndInfo
     C                                     )
     **
     C                   If        %Error
     **...
     C                   ElseIf    DqDtaLen    > *Zero
     **
     C                   Select
     C                   When      DqMsgFmt    = '01'
     C                   ExSr      PrcMsgJob
     **
     C                   When      DqMsgFmt    = '02'
     C                   ExSr      PrcMsgJobQ
     C                   EndSl
     **
     C                   Reset                   DqKey
     C                   EndIf
     **
     C                   Eval      *InLr     = %Shtdn()
     C                   EndDo
     **
     C                   Return
     **
     **-- Process message - job start & end:  --------------------------------**
     C     PrcMsgJob     BegSr
     **
     C                   Eval      MsgJob      = DqDta
     **
     C                   CallP     CvtDtf( '*DTS'
     C                                   : JbJobEntDts
     C                                   : '*YYMD'
     C                                   : JobEntDts
     C                                   : 0
     C                                   )
     **
     C                   CallP     CvtDtf( '*DTS'
     C                                   : JbJobStrDts
     C                                   : '*YYMD'
     C                                   : JobStrDts
     C                                   : 0
     C                                   )
     **
     C                   If        DqKey       = '0002'
     **
     C                   CallP     CvtDtf( '*DTS'
     C                                   : JbJobEndDts
     C                                   : '*YYMD'
     C                                   : JobEndDts
     C                                   : 0
     C                                   )
     **
     C                   Eval      MsgDta      = 'Job '                 +
     C                                           %TrimR( JbJobNam )     +
     C                                           ' ended at '           +
     C                                           %Char( %Timestamp( JobEntDts
     C                                                            : *ISO0
     C                                                            ))    +
     C                                           ' severity '           +
     C                                           %Char( JbJobEndSev )   +
     C                                           ' using '              +
     C                                           %Char( JbJobPrcTimMs ) +
     C                                           ' milliseconds.'
     **
     C                   Else
     C                   Eval      MsgDta      = 'Job '                 +
     C                                           %TrimR( JbJobNam )     +
     C                                           ' entered system at '  +
     C                                           %Char( %Timestamp( JobEntDts
     C                                                            : *ISO0
     C                                                            ))    +
     C                                           ' started at '         +
     C                                           %Char( %Timestamp( JobStrDts
     C                                                            : *ISO0
     C                                                            ))    +
     C                                           '.'
     **
     C                   EndIf
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
     **-- Process message - job queue:  --------------------------------------**
     C     PrcMsgJobQ    BegSr
     **
     C                   Eval      MsgJobQ     = DqDta
     **
     C                   CallP     CvtDtf( '*DTS'
     C                                   : JqJobEntDts
     C                                   : '*YYMD'
     C                                   : JobEntDts
     C                                   : 0
     C                                   )
     **
     C                   Eval      MsgDta      = 'Job '                 +
     C                                           %TrimR( JqJobNam )     +
     C                                           ' entered job queue '  +
     C                                           %TrimR( JqJobQnam )    +
     C                                           ' at '                 +
     C                                           %Char( %Timestamp( JobEntDts
     C                                                            : *ISO0
     C                                                            ))    +
     C                                           '.'
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
