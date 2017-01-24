     **-- Program description:  ----------------------------------------------**
     **
     **   This program will return the number of physical devices that a given
     **   privileged user profile - user class greater than *USER - is signed
     **   on to.  The user profile name is provided in the first parameter and
     **   two special values are accepted:
     **
     **     *JOBUSR - the user profile that started the current job.
     **     *CURUSR - the user profile currently registered as job user.
     **
     **   The number of currently signed on devices for the specified user
     **   profile is returned in the second parameter.  If the specified user
     **   profile has user class *USER, zero is returned.  The user class
     **   condition can simply be removed in the event that all users are to
     **   be checked.
     **
     **   Note that certain clients - like Citrix - actually runs on a central
     **   server, only the screen is sent to the work station.  In this case
     **   the server's IP address will be detected by this program and only
     **   counted as one and the same work station, regardless of the actual
     **   number of PC's connected to the server by the specified user profile.
     **
     **-- Compilation specification:  ----------------------------------------**
     **
     **   CrtBndRpg   Pgm( <library>/CBX904 )
     **               SrcFile( <library>/QRPGLESRC )
     **
     **
     **-- Header:  -----------------------------------------------------------**
     H Option( *SrcStmt )  DftActGrp( *No )
     **-- System information:  -----------------------------------------------**
     D PgmSts         SDs
     D  PsPgmNam         *Proc
     D  PsSts                         5a   Overlay( PgmSts:  11 )
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- API error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   128a
     **-- User space generic header:  ----------------------------------------**
     D UsrSpcHdr       Ds                  Based( pUsrSpc )
     D  UsOfsHdr                     10i 0 Overlay( UsrSpcHdr: 117 )
     D  UsOfsLst                     10i 0 Overlay( UsrSpcHdr: 125 )
     D  UsNumLstEnt                  10i 0 Overlay( UsrSpcHdr: 133 )
     D  UsSizLstEnt                  10i 0 Overlay( UsrSpcHdr: 137 )
     **-- User space pointers:  ----------------------------------------------**
     D pUsrSpc         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )
     **-- Signed-on user information:  ---------------------------------------**
     D SGNU0100        Ds                  Based( pLstEnt )
     D  SuDspNam                     10a
     D  SuUsrPrf                     10a
     D  SuJobNbr                      6a
     D  SuAct                        10a
     D  SuActNam                     10a
     D  SuDscJobAlw                   1a
     D                               17a
     **-- Global variables:  -------------------------------------------------**
     D UsrCls          s             10a
     D UsrSpc          c                   'QEZLSGNU  QTEMP'
     **
     D DevIpAdr        s             15a
     D DevIpLst        s             15a   Dim( 128 )
     D CurIdx          s              5u 0
     D SchIdx          s              5u 0
     D Idx             s              5u 0
     **-- Create user space: -------------------------------------------------**
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  CsSpcNamQ                    20a   Const
     D  CsExtAtr                     10a   Const
     D  CsInzSiz                     10i 0 Const
     D  CsInzVal                      1a   Const
     D  CsPubAut                     10a   Const
     D  CsText                       50a   Const
     **-- Optional 1:
     D  CsReplace                    10a   Const Options( *NoPass )
     D  CsError                   32767a         Options( *NoPass: *VarSize )
     **-- Optional 2:
     D  CsDomain                     10a   Const Options( *NoPass )
     **-- Delete user space: -------------------------------------------------**
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  DsSpcNamQ                    20a   Const
     D  DsError                   32767a         Options( *VarSize )
     **-- Retrieve pointer to user space: ------------------------------------**
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a         Options( *NoPass: *VarSize )
     **-- Retrieve user information:  ----------------------------------------**
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Retrieve device description:  --------------------------------------**
     D RtvDevDsc       Pr                  ExtPgm( 'QDCRDEVD' )
     D  RdRcvVar                  32767a          Options( *VarSize )
     D  RdRcvVarLen                  10i 0 Const
     D  RdFmtNam                     10a   Const
     D  RdDevNam                     10a   Const
     D  RdError                   32767a          Options( *VarSize )
     **-- List signed on users:  ---------------------------------------------**
     D LstSgnUsr       Pr                  ExtPgm( 'QEZLSGNU' )
     D  LuUsrSpc                     20a   Const
     D  LuFmtNam                      8a   Const
     D  LuUsrNam                     10a   Const
     D  LuDspNam                     10a   Const
     D  LuIncDsc                     10a   Const
     D  LuIncSgo                     10a   Const
     D  LuError                   32767a          Options( *VarSize )
     **-- Get user class:  ---------------------------------------------------**
     D GetUsrCls       Pr            10a
     D  PxUsrPrf                     10a   Value
     **-- Get device ip address:  --------------------------------------------**
     D GetDevIp        Pr            15a
     D  PxDevNam                     10a   Value
     **-- Parameters:  -------------------------------------------------------**
     D PxUsrPrf        s             10a
     D PxNbrDev        s              5p 0
     **
     C     *Entry        Plist
     C                   Parm                    PxUsrPrf
     C                   Parm                    PxNbrDev
     **
     **-- Check user device assignment:  -------------------------------------**
     **
     C                   Eval      PxNbrDev    = *Zero
     **
     C                   If        PxUsrPrf    = '*JOBUSR'
     C                   Eval      PxUsrPrf    = PsUsrPrf
     **
     C                   ElseIf    PxUsrPrf    = '*CURUSR'
     C                   Eval      PxUsrPrf    = PsCurUsr
     C                   EndIf
     **
     C                   If        GetUsrCls( PxUsrPrf ) <>  '*USER'
     **
     C                   CallP     CrtUsrSpc( UsrSpc
     C                                      : *Blanks
     C                                      : 65535
     C                                      : x'00'
     C                                      : '*CHANGE'
     C                                      : *Blanks
     C                                      : '*YES'
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    = *Zero
     **
     C                   CallP     LstSgnUsr( UsrSpc
     C                                      : 'SGNU0100'
     C                                      : PxUsrPrf
     C                                      : '*ALL'
     C                                      : '*YES'
     C                                      : '*NO'
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    = *Zero
     **
     C                   CallP     RtvPtrSpc( UsrSpc
     C                                      : pUsrSpc
     C                                      )
     **
     C                   Eval      pLstEnt     = pUsrSpc + UsOfsLst
     **
     C                   For       Idx = 1  to UsNumLstEnt
     **
     C                   ExSr      PrcLstEnt
     **
     C                   If        Idx         < UsNumLstEnt
     C                   Eval      pLstEnt     = pLstEnt + UsSizLstEnt
     C                   EndIf
     C                   EndFor
     **
     C                   Eval      PxNbrDev    = CurIdx
     **
     C                   EndIf
     **
     C                   CallP     DltUsrSpc( UsrSpc
     C                                      : ApiError
     C                                      )
     **
     C                   EndIf
     C                   EndIf
     **
     C                   Eval      *InLr      = *On
     C                   Return
     **
     **-- Process list entries:  ---------------------------------------------**
     C     PrcLstEnt     BegSr
     **
     C                   Eval      DevIpAdr   = GetDevIp( SuDspNam )
     **
     C                   If        DevIpAdr   = *Blanks
     C                   Eval      DevIpAdr   = SuDspNam
     C                   EndIf
     **
     C                   If        CurIdx     = *Zero
     C                   Eval      CurIdx     = 1
     C                   Eval      DevIpLst( CurIdx ) = DevIpAdr
     C                   Else
     **
     C                   Eval      SchIdx     = %Lookup( DevIpAdr
     C                                                 : DevIpLst
     C                                                 : 1
     C                                                 : CurIdx
     C                                                 )
     C
     C                   If        SchIdx     = *Zero
     **
     C                   If        CurIdx     < %Elem( DevIpLst )
     C                   Eval      CurIdx    += 1
     C                   Eval      DevIpLst( CurIdx ) = DevIpAdr
     C                   EndIf
     C                   EndIf
     C                   EndIf
     **
     C                   EndSr
     **-- Get user class:  ---------------------------------------------------**
     P GetUsrCls       B                   Export
     D                 Pi            10a
     D  PxUsrPrf                     10a   Value
     **
     D RuInfo          Ds
     D  RuBytRtn                     10i 0
     D  RuBytAvl                     10i 0
     D  RuUsrPrf                     10a
     D  RuUsrCls                     10a   Overlay( RuInfo: 19 )
     **
     C                   CallP     RtvUsrInf( RuInfo
     C                                      : %Size( RuInfo )
     C                                      : 'USRI0200'
     C                                      : PxUsrPrf
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    > *Zero
     C                   Eval      RuUsrCls    = *Blanks
     C                   EndIf
     **
     C                   Return    RuUsrCls
     **
     P GetUsrCls       E
     **-- Get device ip address:  --------------------------------------------**
     P GetDevIp        B                   Export
     D                 Pi            15a
     D  PxDevNam                     10a   Value
     **
     D RdInfo          Ds
     D  RdBytRtn                     10i 0
     D  RdBytAvl                     10i 0
     D  RdInfDat                      7a
     D  RdInfTim                      6a
     D  RdDevNam                     10a
     D  RdDevCtg                     10a
     D  RdIpAdr                      15a   Overlay( RdInfo: 878 )
     **
     C                   CallP     RtvDevDsc( RdInfo
     C                                      : %Size( RdInfo )
     C                                      : 'DEVD0600'
     C                                      : PxDevNam
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    > *Zero
     C                   Eval      RdIpAdr     = *Blanks
     C                   EndIf
     **
     C                   Return    RdIpAdr
     **
     P GetDevIp        E
