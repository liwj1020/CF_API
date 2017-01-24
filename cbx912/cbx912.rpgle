     **  Program . . : CBX912
     **  Description : Delete journal receiver exit program
     **  Author  . . : Carsten Flensburg
 
     **  Program description:
 
     **     Adapt and register this program to be called by the journal
     **     system function every time the DLTJRNRCV command is executed.
 
     **     Specify the qualified journal name(s) of the journal(s) to be
     **     controlled by this exit program by replacing the <jrnname> and
     **     <libname> substitution values below.  The specified journal(s)
     **     will not have their associated journal receivers deleted until
     **     7 days have passed since the journal receiver was detached -
     **     and the journal receiver has been saved.
 
     **     This will ensure that the journal receivers protected by this
     **     exit program will not be deleted by accident, and that the
     **     journal receivers are available online after detachment for at
     **     least a week.  Depending on the backup scheme being run, this
     **     will also ensure that journal receivers will be included in
     **     more than one backup cycle.
 
     **     For each journal receiver that this exit program prevents from
     **     being deleted, diagnostice message CPF70ED is issued and finally
     **     the escape message CPF2117 is sent to the program running the
     **     DLTJRNRCV command.
 
     **     Note: The exit program function of the DLTJRNRCV command can
     **           be suppressed by specifying DLTOPT(*IGNEXITPGM) on the
     **           DLTJRNRCV command.
 
     **  Exit point registration:
 
     **     AddExitPgm ExitPnt( QIBM_QJO_DLT_JRNRCV )
     **                Format( DRCV0100 )
     **                PgmNbr( *LOW )
     **                Pgm( <library>/CBX912 )
     **                PgmDta( *JOB 10 'QSYSOPR   ' )
 
     **     - The PGMDTA entry is optional and specifies the user profile
     **       under which the journal system function should run the exit
     **       program.  If not specified, user profile QUSER is used to
     **       run the exit program.
 
     **  Programmer's notes:
 
     **    Due to the system's implementation of the Delete journal receiver
     **    exit point, it will not be possible to run the debug function
     **    against the registered exit program during execution.
 
     **  Exit point documentation:
     **
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/XDLTRCV.htmm
 
     **  Compile options:
 
     **    CrtRpgMod Module( <library>/CBX912 )
 
     **    CrtPgm    Pgm( <library>/CBX912 )
     **              Module( <library>/CBX912 )
     **              ActGrp( QILE )
 
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     FEXITJRNPF O  A E             DISK    BLOCK(*NO)
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
     D KEEP_RCV        c                   '0'
     D DELETE_RCV      c                   '1'
     D SAVED           c                   '1'
     **-- Delete journal receiver exit information:  -------------------------**
     D XitInf          Ds
     D  XiInfLen                     10i 0
     D  XiXitPntNam                  20a
     D  XiXitFmtNam                   8a
     D  XiJrnRcvNam                  10a
     D  XiJrnRcvLib                  10a
     D  XiJrnNam                     10a
     D  XiJrnLib                     10a
     D  XiCllSysJob                   1a
     D  XiCllIpl                      1a
     D  XiCllPrcEnd                   1a
     D  XiJrnTyp                      1a
     D  XiRmtJrnTyp                   1a
     D  XiSavSts                      1a
     D  XiPtlSts                      1a
     D  XiDtcDts                     13a
     D   XiDtcDat                     7a   Overlay( XiDtcDts: 1 )
     D   XiDtcTim                     6a   Overlay( XiDtcDts: *Next )
     **-- Delete journal status information:  --------------------------------**
     D StsInf          Ds
     D  SiInfLen                     10i 0
     D  SiDltSts                      1a
     **-- Receiver information:  ---------------------------------------------**
     D RRCV0100        Ds
     D  RrBytRtn                     10i 0
     D  RrBytAvl                     10i 0
     D  RrRcvNam                     10a
     D  RrRcvLib                     10a
     D  RrJrnNam                     10a
     D  RrJrnLib                     10a
     D  RrThh                        10i 0
     D  RrSiz                        10i 0
     D  RrASP                        10i 0
     D  RrNbrJrnEnt                  10i 0
     D  RrMaxEspDtaLn                10i 0
     D  RrMaxNulInd                  10i 0
     D  RrFstSeqNbr                  10i 0
     D  RrMinEntDtaAr                 1a
     D  RrMinEntFiles                 1a
     D  RrRsv1                        2a
     D  RrLstSeqNbr                  10i 0
     D  RrRsv2                       10i 0
     D  RrSts                         1a
     D  RrMinFxlVal                   1a
     D  RrRcvMaxOpt                   1a
     D  RrRsv3                        4a
     D  RrAtcDts                     13a
     D   RrAtcDat                     7a   Overlay( RrAtcDts: 1 )
     D   RrAtcTim                     6a   Overlay( RrAtcDts: *Next )
     D  RrDtcDts                     13a
     D   RrDtcDat                     7a   Overlay( RrDtcDts: 1 )
     D   RrDtcTim                     6a   Overlay( RrDtcDts: *Next )
     D  RrSavDts                     13a
     D   RrSavDat                     7a   Overlay( RrSavDts: 1 )
     D   RrSavTim                     6a   Overlay( RrSavDts: *Next )
     D  RrTxt                        50a
     D  RrPndTrn                      1a
     D  RrRmtJrnTyp                   1a
     D  RrLocJrnNam                  10a
     D  RrLocJrnLib                  10a
     D  RrLocJrnSys                   8a
     D  RrLocRcvLib                  10a
     D  RrSrcJrnNam                  10a
     D  RrSrcJrnLib                  10a
     D  RrSrcJrnSys                   8a
     D  RrSrcRcvLib                  10a
     D  RrRdcRcvLib                  10a
     D  RrDuaRcvNam                  10a
     D  RrDuaRcvLib                  10a
     D  RrPrvRcvNam                  10a
     D  RrPrvRcvLib                  10a
     D  RrPrvRcvNamDu                10a
     D  RrPrvRcvLibDu                10a
     D  RrNxtRcvNam                  10a
     D  RrNxtRcvLib                  10a
     D  RrNxtRcvNamDu                10a
     D  RrNxtRcvLibDu                10a
     D  RrNbrJrnEntL                 20s 0
     D  RrMaxEspDtlL                 20s 0
     D  RrFstSeqNbrL                 20s 0
     D  RrLstSeqNbrL                 20s 0
     D  RrRsv4                       60a
     **-- Retrieve journal receiver information:  ----------------------------**
     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
     D                                     Information' )
     D  RiRcvVar                  65535a          Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiRcvNam                     20a   Const
     D  RiFmtNam                      8a   Const
     D  RiError                   32767a          Options( *VarSize: *NoPass )
     **-- Parameters:  -------------------------------------------------------**
 
     C     *Entry        Plist
     C                   Parm                    XitInf
     C                   Parm                    StsInf
 
     **-- Mainline:  ---------------------------------------------------------**
 
     C                   Eval      SiInfLen     = 5
     C                   Eval      SiDltSts     = DELETE_RCV
 
     C                   ExSr      AddRcd
     **-- Specify the journal(s) to be controlled by this exit program here:
 
     C                   If        XiJrnNam     = 'CBXIFSJRN'  And
     C                             XiJrnLIb     = 'CLIB  '
 
     C                   Eval      SiDltSts     = KEEP_RCV
 
     C                   If        XiSavSts     = SAVED
 
     C                   CallP     RtvRcvInf( RRCV0100
     C                                      : %Size( RRCV0100 )
     C                                      : XiJrnRcvNam + XiJrnRcvLib
     C                                      : 'RRCV0100'
     C                                      : ApiError
     C                                      )
 
     C                   If        RrDtcDat>*Zeros
 
     C*                  If        %Diff( %Date()
     C*                                 : %Date( RrDtcDat: *CYMD0 )
     C*                                 : *Days
     C*                                 )>7
 
     C                   ExSr      AddRcd
 
     C                   Eval      SiDltSts=DELETE_RCV
     C*                  EndIf
     C                   EndIf
 
     C                   EndIf
     C                   EndIf
 
     C                   Return
     C     AddRcd        BegSr
     C                   Eval      RBYTRTN=RRBYTRTN
     C                   Eval      RBYTAVL=RRBYTAVL
     C                   Eval      RRCVNAM=RRRCVNAM
     C                   Eval      RRCVLIB=RRRCVLIB
     C                   Eval      RJRNNAM=RRJRNNAM
     C                   Eval      RJRNLIB=RRJRNLIB
     C                   Eval      RTHH   =%Char(RRTHH)
     C                   Write     REXITPGM
     C                   EndSr
