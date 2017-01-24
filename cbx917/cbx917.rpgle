     **
     **  Program . . : CBX917
     **  Description : Print server authentication entries
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **     This program prints the server authentication entries for
     **     either a specific user profile or all user profiles on the
     **     system.
     **
     **  Programmer's note:
     **     Retrieving all user profiles' server authentication entries
     **     can be a long running function - depending on the number of
     **     user profiles on the system.
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX917 )
     **
     **    CrtPgm    Pgm( CBX917 )
     **              Module( CBX917 )
     **              ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )
     **-- Printer file:  -----------------------------------------------------**
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
     **-- Printer file information:  -----------------------------------------**
     D PrtLinInf       Ds
     D  PlOvfLin                      5i 0  Overlay( PrtLinInf: 188 )
     D  PlCurLin                      5i 0  Overlay( PrtLinInf: 367 )
     D  PlCurPag                      5i 0  Overlay( PrtLinInf: 369 )
     **-- System information:  -----------------------------------------------**
     D PgmSts         SDs
     D  PsPgmNam         *Proc
     D  PsJobUsr                     10a   Overlay( PgmSts: 254 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- Global variables:  -------------------------------------------------**
     D Lix             s             10i 0
     D Eix             s             10i 0
     D UsrPrf          s             10a
     **
     D Time            s              6s 0
     D NbrRcds         s             10u 0
     **
     D SvrNam          s             64a
     D UsrId           s             16a
     D SvrCcsId        s              5s 0
     D UsrCcsId        s              5s 0
     D PwdSto          s              3a
     **-- API error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0 Inz
     D  AeExcpId                      7a
     D                                1a
     D  AaExcpDta                   256a
     **-- Create User Space Parameter:  --------------------------------------**
     D CuUsrSpcQ       Ds
     D  CuUsrSpcNam                  10    Inz( 'USRLST   ' )
     D  CuUsrSpcLib                  10    Inz( 'QTEMP ' )
     **-- Entry format AUTU0100:  --------------------------------------------**
     D AUTU0100        Ds                  Based( pLstEnt )
     D  U1UsrPrf                     10a
     D  U1GrpPrf                     10a
     D  U1NbrSupGrp                  10i 0
     D  U1SupGrpPrf                  10a   Dim( 15 )
     D  U1UsrGrpI                     1a
     D  U1GrpMbrI                     1a
     **-- Return records feedback information:  ------------------------------**
     D RtnRcdFbi       Ds
     D  RrBytRtn                     10i 0
     D  RrBytAvl                     10i 0
     D  RrNbrSvrAutE                 10i 0
     **-- Entry format SVRE0100:  --------------------------------------------**
     D SVRE0100        Ds         65535    Based( pSvrEnt )
     D  S1EntLen                     10i 0
     D  S1SvrNamLen                  10i 0
     D  S1SvrNamCcsId                10i 0
     D  S1SvrNam                    200a
     D  S1UsrIdDsp                   10i 0
     D  S1UsrIdLen                   10i 0
     D  S1UsrIdCcsId                 10i 0
     D  S1PwdStoI                     1a
     **
     D  S1UsrId        s            200a
     **-- User Space Generic Header:  ---------- -----------------------------**
     D UsrSpc          Ds                  Based( pUsrSpc )
     D  UsOfsHdr                     10i 0 Overlay( UsrSpc: 117 )
     D  UsOfsLst                     10i 0 Overlay( UsrSpc: 125 )
     D  UsNumLstEnt                  10i 0 Overlay( UsrSpc: 133 )
     D  UsSizLstEnt                  10i 0 Overlay( UsrSpc: 137 )
     **-- Pointers:  ---------------------------------------------------------**
     D pUsrSpc         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )
     D pSvrEnt         s               *   Inz( *Null )
     **-- List authorized users:  --------------------------------------------**
     D LstAutUsr       Pr                  ExtPgm( 'QSYLAUTU' )
     D  LaSpcNamQ                    20a   Const
     D  LaFmtNam                      8a   Const
     D  LaError                   32767a         Options( *VarSize )
     **-- Retrieve server authentication entries:  ---------------------------**
     D RtvSvrAutE      Pr                  ExtProc( 'QsyRetrieveServerEntries' )
     D  SaRcvVar                  65535a          Options( *VarSize )
     D  SaRcvVarLen                  10i 0 Value
     D  SaRtnRcdFbi                  12a
     D  SaFmtNam                      8a   Const
     D  SaStrSvrNam                 200a   Const  Options( *VarSize )
     D  SaStrSvrLen                  10i 0 Value
     D  SaStrSvrOpt                   1a   Value
     D  SaUsrPrf                     10a   Const
     D  SaError                   32767a          Options( *VarSize )
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
     **-- Retrieve pointer to user space: ------------------------------------**
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a         Options( *NoPass: *VarSize )
     **-- Delete user space: -------------------------------------------------**
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  DsSpcNamQ                    20a   Const
     D  DsError                   32767a         Options( *VarSize )
     **-- Send program message:  ---------------------------------------------**
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                      10i 0 Const
     **-- Send completion message:  ------------------------------------------**
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Parameters:  -------------------------------------------------------**
     D PxUsrPrf        s             10a
     **
     C     *Entry        Plist
     C                   Parm                    PxUsrPrf
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   Time                    Time
     C                   Except    Header
     **
     C                   If        PxUsrPrf    = '*CURRENT'
     C                   Eval      PxUsrPrf    = PsCurUsr
     C                   EndIf
     **
     C                   If        PxUsrPrf    = '*ALL'
     **
     C                   CallP     CrtUsrSpc( CuUsrSpcQ                         Create UserSpace
     C                                      : *Blanks
     C                                      : 65535
     C                                      : x'00'
     C                                      : '*CHANGE'
     C                                      : *Blanks
     C                                      : '*YES'
     C                                      : ApiError
     C                                      )
     **
     C                   CallP     LstAutUsr( CuUsrSpcQ                         Create UserSpace
     C                                      : 'AUTU0100'
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    = *Zero
     **
     C                   CallP     RtvPtrSpc( CuUsrSpcQ                         Create UserSpace
     C                                      : pUsrSpc                           Create UserSpace
     C                                      )
     **
     C                   ExSr      PrcLstEnt
     C                   EndIf
     **
     C                   CallP     DltUsrSpc( CuUsrSpcQ                         Create UserSpace
     C                                      : ApiError                          Create UserSpace
     C                                      )
     **
     C                   Else
     C                   Eval      UsrPrf      = PxUsrPrf
     C                   ExSr      PrtSvrAut
     C                   EndIf
     **
     C                   If        NbrRcds    =  *Zero
     C                   Except    NoRcds
     C                   EndIf
     **
     C                   CallP     SndCmpMsg( 'List has been printed.' )
     **
     C                   Eval      *InLr       = *On
     C                   Return
     **
     **-- Process list entries:  ---------------------------------------------**
     C     PrcLstEnt     BegSr
     **
     C                   Eval      pLstEnt     = pUsrSpc + UsOfsLst
     **
     C                   For       Lix = 1  to  UsNumLstEnt
     **
     C                   Eval      UsrPrf      = U1UsrPrf
     C                   ExSr      PrtSvrAut
     **
     C                   If        Lix         < UsNumLstEnt
     C                   Eval      pLstEnt     = pLstEnt + UsSizLstEnt
     C                   EndIf
     C                   EndFor
     **
     C                   EndSr
     **-- Print server authentication entries:  ------------------------------**
     C     PrtSvrAut     BegSr
     **
     C                   Eval      pSvrEnt    = %Alloc( %Size( SVRE0100 ))
     **
     C                   CallP     RtvSvrAutE( SVRE0100                         Create UserSpace
     C                                       : %Size( SVRE0100 )
     C                                       : RtnRcdFbi
     C                                       : 'SVRE0100'
     C                                       : '*FIRST'
     C                                       : 6
     C                                       : '1'
     C                                       : UsrPrf
     C                                       : ApiError
     C                                       )
     **
     C                   If        AeBytAvl    = *Zero
     **
     C                   For       Eix = 1  to RrNbrSvrAutE
     **
     C                   Eval      S1UsrId     = %Subst( SVRE0100
     C                                                 : S1UsrIdDsp + 1
     C                                                 : S1UsrIdLen
     C                                                 )
     **
     C                   ExSr      PrtSvrDtl
     **
     C                   If        Eix         < RrNbrSvrAutE
     C                   Eval      pSvrEnt     = pSvrEnt + S1EntLen
     C                   EndIf
     **
     C                   EndFor
     C                   EndIf
     **
     C                   EndSr
     **-- Print server authentication entry detail line:  --------------------**
     C     PrtSvrDtl     BegSr
     **
     C                   If        PlCurLin    > PlOvfLin - 3
     C                   Except    Header
     C                   EndIf
     **
     C                   Eval      SvrNam      =  S1SvrNam
     C                   If        S1SvrNamLen > %Size( SvrNam )
     C                   EvalR     SvrNam      =  '...'
     C                   EndIf
     **
     C                   Eval      UsrId       =  S1UsrId
     C                   If        S1UsrIdLen  > %Size( UsrId )
     C                   EvalR     UsrId       =  '...'
     C                   EndIf
     **
     C                   Eval      SvrCcsId    = S1SvrNamCcsId
     C                   Eval      UsrCcsId    = S1UsrIdCcsId
     **
     C                   If        S1PwdStoI   = '1'
     C                   Eval      PwdSto      = 'Yes'
     C                   Else
     C                   Eval      PwdSto      = 'No '
     C                   EndIf
     **
     C                   Eval      NbrRcds     = NbrRcds + 1
     C                   Except    SvrDtl
     **
     C                   EndSr
     **-- Print file definition:  --------------------------------------------**
     OQSYSPRT   EF           Header         2  3
     O                       UDATE         Y      8
     O                       Time                18 '  :  :  '
     O                                           75 'Print server authenticatio-
     O                                              n entries'
     O                                          107 'Program:'
     O                       PsPgmNam           118
     O                                          126 'Page:'
     O                       PAGE             +   1
     OQSYSPRT   EF           Header         1
     O                                            7 'User Id'
     O                                           23 '- CCSID'
     O                                           37 'Server name'
     O                                           97 '- CCSID'
     O                                          108 'Password'
     **
     OQSYSPRT   EF           SvrDtl         1
     O                       UsrId               16
     O                       UsrCcsId      X     23
     O                       SvrNam              90
     O                       SvrCcsId      X     97
     O                       PwdSto             105
     **
     OQSYSPRT   EF           NoRcds      1
     O                                           26 '(No entries found)'
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a
     **
     C                   CallP(e)  SndPgmMsg( 'CPF9897'
     C                                      : 'QCPFMSG   *LIBL'
     C                                      : PxMsgDta
     C                                      : %Len( PxMsgDta )
     C                                      : '*COMP'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : *Zero
     C                                      )
     **
     C                   If        %Error
     C                   Return    -1
     **
     C                   Else
     C                   Return    0
     C                   EndIf
     **
     P SndCmpMsg       E
