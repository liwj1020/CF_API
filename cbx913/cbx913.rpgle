     **
     **  Program . . : CBX913
     **  Description : Critical ASP usage % exit program
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **
     **     Registering this program as described below ensures that all
     **     user profiles having a user class of *SYSOPR receive a break
     **     message if a critical auxillary storage pool usage should
     **     occur.  If the user is not signed on when the message is sent,
     **     the message goes to the user profile's message queue.
     **
     **     Note: When the ASP lower limit condition is met, the exit point
     **           submits the registered program to run in the subsystem
     **           QSYSWRK under the QPGMR user profile using the QSYSJOBD
     **           job description.  If the job for some reason does not run,
     **           no other actions are taken.
     **
     **
     **  Exit point registration:
     **
     **     AddExitPgm ExitPnt( QIBM_QWC_QSTGLOWACN )
     **                Format( STGL0100 )
     **                PgmNbr( *LOW )
     **                Pgm( <library>/CBX913 )
     **                PgmDta( *NONE )
     **
     **     ChgSysVal  QSTGLOWACN   Value( *REGFAC )
     **
     **     ChgSysVal  QSTGLOWLMT   Value( 8.0000 )
     **
     **     - The above setting of the QSTGLOWLMT system value causes the
     **       registered exit program to be called when there is less than
     **       8 % of the system ASP disk space available; or in other words
     **       92 % or more of the system ASP is used.
     **
     **
     **  Programmer's notes:
     **
     **    In order to optimize the performance of this exit program, if the
     **    grouping (or non-grouping) of the system operators' user profiles
     **    allow it, there are three different sets of the list user profile
     **    selection parameters below.  Please delete two of the selection
     **    sets prior to compiling this program.  The fastest selection set
     **    is specified as the first set, the slowest set as the last.
     **
     **
     **  Exit point documentation:
     **
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/xstglow.htm
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( <library>/CBX913 )
     **
     **    CrtPgm    Pgm( <library>/CBX913 )
     **              Module( <library>/CBX913 )
     **              ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- API error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   128a
     **-- Open list API parameters:  -----------------------------------------**
     D UlCurRcdNbr     s             10i 0 Inz( 1 )
     **-- User information:
     D AUTU0100        Ds
     D  A1UsrPrf                     10a
     D  A1UsrGrpI                     1a
     D  A1GrpMbrI                     1a
     **-- List information:
     D UlLstInf        Ds
     D  LiRcdNbrTot                  10i 0
     D  LiRcdNbrRtn                  10i 0
     D  LiHandle                      4a
     D  LiRcdLen                     10i 0
     D  LiInfSts                      1a
     D  LiDts                        13a
     D  LiLstSts                      1a
     D                                1a
     D  LiInfLen                     10i 0
     D  LiRcd1                       10i 0
     D                               40a
     **-- System status information:  ----------------------------------------**
     D SSTS0200        Ds
     D  S2BytAvl                     10i 0
     D  S2BytRtn                     10i 0
     D  S2RstStt                      1a   Overlay( SSTS0200: 31 )
     D  S2SysAsp                      9b 3 Overlay( SSTS0200: 49 )
     D  S2SysAspUsd                   9b 4 Overlay( SSTS0200: 53 )
     **-- Global variables:  -------------------------------------------------**
     D MsgTxt          s            512a   Varying
     D UsrNam          s             10a   Dim( 299 )
     D UsrNbr          s             10i 0 Inz
     D GrpNam          s             10a
     D SltCri          s             10a
     D MsgSntInd       s             10i 0
     D FncRqs          s             10i 0
     **-- Open list of jobs:  ------------------------------------------------**
     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
     D  LuRcvVar                  65535a          Options( *VarSize )
     D  LuRcvVarLen                  10i 0 Const
     D  LuLstInf                     80a
     D  LuNbrRcdRtn                  10i 0 Const
     D  LuFmtNam                      8a   Const
     D  LuSltCri                     10a   Const
     D  LuGrpNam                     10a   Const
     D  LuError                    1024a          Options( *VarSize )
     **-- Get list entry:  ---------------------------------------------------**
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  GlRcvVar                  65535a          Options( *VarSize )
     D  GlRcvVarLen                  10i 0 Const
     D  GlHandle                      4a   Const
     D  GlLstInf                     80a
     D  GlNbrRcdRtn                  10i 0 Const
     D  GlRtnRcdNbr                  10i 0 Const
     D  GlError                    1024a          Options( *VarSize )
     **-- Close list:  -------------------------------------------------------**
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  ClHandle                      4a   Const
     D  ClError                    1024a          Options( *VarSize )
     **-- Retrieve system status:  -------------------------------------------**
     D RtvSysSts       Pr                  ExtPgm( 'QWCRSSTS' )
     D  RsRcvVar                  32767a          Options( *VarSize )
     D  RsRcvVarLen                  10i 0 Const
     D  RsFmtNam                     10a   Const
     D  RsRstStc                     10a   Const
     D  RsError                   32767a          Options( *VarSize )
     **
     D  RsPoolSltInf                 24a   Const  Options( *VarSize: *NoPass )
     D  RsPoolSltSiz                 10i 0 Const  Options( *NoPass )
     **-- Retrieve user information:  ----------------------------------------**
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Retrieve object description:  --------------------------------------**
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RoRcvVar                  32767a         Options( *VarSize )
     D  RoRcvVarLen                  10i 0 Const
     D  RoFmtNam                      8a   Const
     D  RoObjNamQ                    20a   Const
     D  RoObjTyp                     10a   Const
     D  RoError                   32767a         Options( *VarSize )
     **-- Send message:  -----------------------------------------------------**
     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
     D  SmMsgTyp                     10a   Const
     D  SmDlvMod                     10a   Const
     D  SmMsgTxt                    494a   Const  Options( *VarSize )
     D  SmMsgTxtLen                  10i 0 Const
     D  SmMsgRcv                     10a   Const  Options( *VarSize ) Dim( 299 )
     D  SmMsgRcvNbr                  10i 0 Const
     D  SmMsgSntInd                  10i 0
     D  SmFncRqs                     10i 0
     D  SmError                   32767a          Options( *VarSize )
     **
     D  SmShwSndMsgDs                 1a   Const  Options( *NoPass )
     D  SmMsgQueNam                  20a   Const  Options( *NoPass )
     D  SmNamTypInd                   4a   Const  Options( *NoPass )
     **
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
     **-- Get user class:  ---------------------------------------------------**
     D GetUsrCls       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get user creator:  -------------------------------------------------**
     D GetUsrCrt       Pr            10a
     D  PxUsrPrf                     10a   Value
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   CallP     RtvSysSts( SSTS0200
     C                                      : %Size( SSTS0200 )
     C                                      : 'SSTS0200'
     C                                      : '*NO'
     C                                      : ApiError
     C                                      )
     **
     C                   Eval      MsgTxt  = 'Currently % system ASP used: '   +
     C                                        %Char( S2SysAspUsd )             +
     C                                       '. The auxiliary storage lower '  +
     C                                       'limit has been exceeded!'
     **
     **-- Please select the condition that applies to your environment and
     **-- delete the other two:
     **
     **-- - if system operators belong to same group profile, f.x. QSYSOPR:
     C                   Eval      SltCri      = '*MEMBER'
     C                   Eval      GrpNam      = 'QSYSOPR'
     **
     **-- - if system operators do not belong to any group profile:
     C                   Eval      SltCri      = '*MEMBER'
     C                   Eval      GrpNam      = '*NOGROUP'
     **
     **-- - if system operators do not belong to same group profile:
     C                   Eval      SltCri      = '*ALL'
     C                   Eval      GrpNam      = ' '
     **
     C                   CallP     LstAutUsr( AUTU0100
     C                                      : %Size( AUTU0100 )
     C                                      : UlLstInf
     C                                      : 1
     C                                      : 'AUTU0100'
     C                                      : SltCri
     C                                      : GrpNam
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    =  *Zero
     **
     C                   DoW       LiLstSts    <> '2'           Or
     C                             LiRcdNbrTot >= UlCurRcdNbr
     **
     C                   ExSr      PrcLstEnt
     **
     C                   Eval      UlCurRcdNbr =  UlCurRcdNbr + 1
     **
     C                   CallP     GetLstEnt( AUTU0100
     C                                      : %Size( AUTU0100 )
     C                                      : LiHandle
     C                                      : UlLstInf
     C                                      : 1
     C                                      : UlCurRcdNbr
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    > *Zero
     C                   Leave
     C                   EndIf
     **
     C                   EndDo
     **
     C                   CallP     CloseLst( LiHandle
     C                                     : ApiError
     C                                     )
     **
     C                   EndIf
     **
     C                   If        UsrNbr      > *Zero
     C                   ExSr      SndBrkMsg
     C                   EndIf
     **
     C                   Eval      *InLr       = *On
     **
     C                   Return
     **
     **-- Process list entry:  -----------------------------------------------**
     C     PrcLstEnt     BegSr
     **
     C                   If        GetUsrCls( A1UsrPrf ) =  '*SYSOPR'
     **
     C                   If        GetUsrCrt( A1UsrPrf ) <> '*IBM'
     **
     C                   Eval      UsrNbr      = UsrNbr + 1
     C                   Eval      UsrNam(UsrNbr)  = A1UsrPrf
     **
     C                   If        UsrNbr      = %Elem( UsrNam )
     C                   ExSr      SndBrkMsg
     **
     C                   Eval      UsrNbr      = *Zero
     C                   EndIf
     **
     C                   EndIf
     C                   EndIf
     **
     C                   EndSr
     **-- Send break message:  -----------------------------------------------**
     C     SndBrkMsg     BegSr
     **
     C                   CallP     SndMsg( '*INFO'
     C                                   : '*BREAK'
     C                                   : MsgTxt
     C                                   : %Len( MsgTxt )
     C                                   : UsrNam
     C                                   : UsrNbr
     C                                   : MsgSntInd
     C                                   : FncRqs
     C                                   : ApiError
     C                                   : 'N'
     C                                   : *Blanks
     C                                   : '*USR'
     C                                   )
     **
     C                   EndSr
     **-- Get user class:  ---------------------------------------------------**
     P GetUsrCls       B                   Export
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value
     **
     D USRI0200        Ds
     D  U2BytRtn                     10i 0
     D  U2BytAvl                     10i 0
     D  U2UsrPrf                     10a
     D  U2UsrCls                     10a   Overlay( USRI0200: 19 )
     **
     C                   CallP     RtvUsrInf( USRI0200
     C                                      : %Size( USRI0200 )
     C                                      : 'USRI0200'
     C                                      : PxUsrPrf
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    > *Zero
     C                   Eval      U2UsrCls    = *Blanks
     C                   EndIf
     **
     C                   Return    U2UsrCls
     **
     P GetUsrCls       E
     **-- Get user creator:  -------------------------------------------------**
     P GetUsrCrt       B                   Export
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value
     **
     D OBJD0300        Ds
     D  O3BytRtn                     10i 0
     D  O3BytAvl                     10i 0
     D  O3ObjCrt                     10a   Overlay( OBJD0300: 220 )
     **
     C                   CallP     RtvObjD( OBJD0300
     C                                    : %Size( OBJD0300 )
     C                                    : 'OBJD0300'
     C                                    : PxUsrPrf + 'QSYS'
     C                                    : '*USRPRF'
     C                                    : ApiError
     C                                    )
     **
     C                   If        AeBytAvl    > *Zero
     C                   Eval      O3ObjCrt    = *Blanks
     C                   EndIf
     **
     C                   Return    O3ObjCrt
     **
     P GetUsrCrt       E
