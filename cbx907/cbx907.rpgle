     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX907
     **  Description : Process and print QHST log performance entries
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameter:
     **    PxFilNam    INPUT   File name, the history log file to process.
     **
     **
     **  Program description:
     **    This program is designed to read and process the history log
     **    files and produce a list of the retrieved performance records.
     **
     **    To keep track of the progress of the record retrieval a user
     **    space is used to store the processed file names and records'
     **    timestamp and relative record number.  In this program there
     **    is further an age limit of 3 days for the history log files to
     **    prevent very large spooled files to be produced.  This limit can
     **    be changed to any value appropriate for your enviroment.
     **
     **
     **  Programmer's notes:
     **    The CL Programming manual, chapter 8 - Working with messages,
     **    holds a lot of information about the history log and its content
     **    and use:
     **
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/books/c415721512.htm#HDRSYSTL
     **
     **    Automatic cleanup of the history log files is controlled by the
     **    Operational Assistant's CLEANUP menu, option 1, as part of the
     **    'System journals and system logs' entry.
     **
     **    Depending on the number of history log files this can be a long
     **    running function.  To avoid interference with your interactive
     **    workload this program should therefore be run in batch.
     **
     **
     **  Compilation specification:
     **    CrtRpgMod  Module( CBX907 )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX907 )
     **               Module( CBX907 )
     **               ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DecEdit( *JobRun )
     **-- File specifications:  ----------------------------------------------**
     FQHST      IF   F  142        Disk     InfDs( HstLogInf )  UsrOpn
     F                                      ExtFile( PxFilNam )
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
     **-- Data file information:  --------------------------------------------**
     D HstLogInf       Ds
     D  HlFilNam                     10a    Overlay( HstLogInf:  83 )
     D  HlMbrNam                     10a    Overlay( HstLogInf: 129 )
     D  HlMbrDat                      5a    Overlay( HstLogInf: 133 )
     D  HlNbrRcd                     10i 0  Overlay( HstLogInf: 156 )
     D  HlRrn                        10i 0  Overlay( HstLogInf: 397 )
     **-- Printer file information:  -----------------------------------------**
     D PrtLinInf       Ds
     D  PlOvfLin                      5i 0  Overlay( PrtLinInf: 188 )
     D  PlCurLin                      5i 0  Overlay( PrtLinInf: 367 )
     D  PlCurPag                      5i 0  Overlay( PrtLinInf: 369 )
     **-- System information:  -----------------------------------------------**
     D                SDs
     D  PsPgmNam         *Proc
     **-- History log offset:  -----------------------------------------------**
     D HstLogOfs       Ds                   Based( pUsrSpc )
     D  LoDatTim                     13a
     D  LoFilNam                     10a
     D  LoRrn                        10s 0
     **-- History log record description:  -----------------------------------**
     D R1MsgInf        Ds
     D  MiJob                        26a
     D   MiJobNam                    10a    Overlay( MiJob )
     D   MiUsrPrf                    10a    Overlay( MiJob: *Next )
     D   MiJobNbr                     6a    Overlay( MiJob: *Next )
     D  MiCvtDtm                     13a
     D   MiCvtDat                     7a    Overlay( MiCvtDtm )
     D   MiCvtTim                     6a    Overlay( MiCvtDtm: *Next )
     D  MiMsgId                       7a
     D  MiMsgF                       10a
     D  MiMsgFlib                    10a
     D  MiMsgTyp                      2a
     D  MiSevCod                      2a
     D  MiSndPgmNam                  12a
     D  MiSndPgmInst                  4a
     D  MiRcvPgmNam                  10a
     D  MiRcvPgmInst                  4a
     D  MiMsgTxtLen                   5i 0
     D  MiMsgDtaLen                   5i 0
     D  MiMsgCcsId                   10i 0
     D                               24a
     **
     D R2MsgTxt        s            132a
     D R3MsgDta        s           1024a   Varying
     **
     D CPF1164         Ds
     D  JbJobNam                     10a
     D  JbUsrPrf                     10a
     D  JbJobNbr                      6a
     D  JbEndTim                      8a
     D  JbEndDat                      8a
     D  JbCpuTim                     10i 0
     D  JbRtgStp                      5i 0
     D  JbCmpCod                      5i 0
     D  JbSecEcd                      5i 0
     D                               20a
     D  JbEntTim                      8a
     D  JbEntDat                      8a
     D  JbStrTim                      8a
     D  JbStrDat                      8a
     D  JbTotRsp                      9b 1
     D  JbNbrTrn                     10i 0
     D  JbSncXio                     10i 0
     D  JbJobTyp                      1a
     **-- Global declarations:  ----------------------------------------------**
     D Null            c                   ''
     **
     D OfsLvl          s              3i 0 Inz( *Zero )
     D MsgPnd          s               n   Inz( *Off )
     D MsgDtaLen       s             10i 0
     D MsgRemLen       s             10i 0
     **
     D Time            s              6s 0
     D NbrRcds         s             10u 0
     D MsgTxt80        s             80a
     D MsgDat          s               d
     D MsgTim          s               t
     **
     D PxFilNam        s             10a
     **-- Retrieve pointer to user space: ------------------------------------**
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a         Options( *NoPass: *VarSize )
     **-- Input file record description:  ------------------------------------**
     IQHST      Ns  01
     I                             a    1    8  HLSDTS
     I                             i    9   10 0HLRCDN
     I                             a   11  142  HLDATA
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C     *Entry        Plist
     C                   Parm                    PxFilNam
     **
     C                   If        %Parms      = *Zero
     C                   Eval      *InLr       = *On
     **
     C                   If        NbrRcds     = *Zero
     C                   Except    NoRcds
     C                   EndIf
     **
     C                   Else
     C                   Open      QHST
     **
     C                   If        %Diff( %Date()
     C                                  : %Date( HlMbrDat: *JUL0 )
     C                                  : *Days
     C                                  )     <= 3
     **
     C     *Start        SetLl     QHST
     C                   Read      QHST
     C                   DoW       Not %EoF
     **
     C                   If        OfsLvl      = *Zero
     C                   ExSr      SetOfsLvl
     **
     C                   If        OfsLvl      = -1
     C                   Eval      OfsLvl      = *Zero
     **
     C                   Leave
     C                   EndIf
     C                   EndIf
     **
     C                   If        OfsLvl      > *Zero
     **
     C                   Select
     C                   When      HLRCDN      = 1
     C                   ExSr      PrcLogMsg
     **
     C                   Eval      R1MsgInf    = HLDATA
     C                   Eval      MsgRemLen   = MiMsgDtaLen
     C                   Eval      MsgPnd      = *On
     **
     C                   When      HLRCDN      = 2
     C                   Eval      R2MsgTxt    = %Subst( HLDATA: 1: MiMsgTxtLen)
     **
     C                   When      HLRCDN     >= 3
     C                   ExSr      BldMsgDta
     C                   EndSl
     C                   EndIf
     **
     C                   Read      QHST
     C                   EndDo
     **
     C                   ExSr      PrcLogMsg
     C                   EndIf
     **
     C                   Close     QHST
     C                   EndIf
     **
     C                   Return
     **
     **-- Process log message:  ----------------------------------------------**
     C     PrcLogMsg     BegSr
     **
     C                   If        MsgPnd      = *On
     **
     C                   If        MiMsgId     = 'CPF1164'
     C                   Eval      CPF1164     = R3MsgDta
     C                   ExSr      WrtLstLin
     C                   EndIf
     **
     C                   Eval      LoDatTim    = MiCvtDtm
     C                   Eval      LoFilNam    = HlFilNam
     C                   Eval      LoRrn       = HlRrn
     **
     C                   Eval      MsgPnd      = *Off
     C                   Eval      R3MsgDta    = Null
     C                   EndIf
     **
     C                   EndSr
     **-- Build message data:  -----------------------------------------------**
     C     BldMsgDta     BegSr
     **
     C                   If        MsgRemLen   > %Size( HLDATA )
     C                   Eval      MsgDtaLen   = %Size( HLDATA )
     C                   Else
     C                   Eval      MsgDtaLen   = MsgRemLen
     C                   EndIf
     **
     C                   Eval      R3MsgDta    = R3MsgDta  +
     C                                           %Subst( HLDATA: 1: MsgDtaLen )
     **
     C                   Eval      MsgRemLen   = MsgRemLen - MsgDtaLen
     **
     C                   EndSr
     **-- Set offset level:  -------------------------------------------------**
     C     SetOfsLvl     BegSr
     **
     C                   If        HlRrn       = 1
     C                   Eval      R1MsgInf    = HLDATA
     C                   EndIf
     **
     C                   Select
     C                   When      LoFilNam    = *Blanks
     C                   Eval      OfsLvl      = 1
     **
     C                   When      HlFilNam    = LoFilNam
     C                   If        HlRrn       > LoRrn
     C                   Eval      OfsLvl      = 1
     **
     C                   ElseIf    HlNbrRcd    = LoRrn
     C                   Eval      OfsLvl      = -1
     C                   EndIf
     **
     C                   When      MiCvtDtm   >= LoDatTim
     C                   Eval      OfsLvl      = 1
     **
     C                   Other
     C                   Eval      OfsLvl      = -1
     C                   EndSl
     **
     C                   EndSr
     **-- Initial subroutine:  -----------------------------------------------**
     C     *InzSr        BegSr
     **
     C                   CallP     RtvPtrSpc( 'CBX907U   *CURLIB'
     C                                      : pUsrSpc
     C                                      )
     **
     C                   Time                    Time
     C                   Except    Header
     **
     C                   EndSr
     **-- Write list line:  --------------------------------------------------**
     C     WrtLstLin     BegSr
     **
     C                   Eval      MsgDat      = %Date( MiCvtDat: *CYMD0 )
     C                   Eval      MsgTim      = %Time( MiCvtTim: *HMS0 )
     **
     C                   Eval      MsgTxt80    = R2MsgTxt
     **
     C                   If        PlCurLin    > PlOvfLin - 3
     C                   Except    Header
     C                   EndIf
     **
     C                   Eval      NbrRcds     = NbrRcds + 1
     C                   Except    Detail
     **
     C                   EndSr
     **-- Print file definition:  --------------------------------------------**
     OQSYSPRT   EF           Header         2  3
     O                       UDATE         Y      8
     O                       Time                18 '  :  :  '
     O                                           82 'Print history log -
     O                                              performance information'
     O                                          107 'Program:'
     O                       PsPgmNam           118
     O                                          126 'Page:'
     O                       PAGE             +   1
     OQSYSPRT   EF           Header         1
     O                                            8 'Job name'
     O                                           15 'User'
     O                                           28 'Number'
     O                                           36 'Entered'
     O                                           54 'Started'
     O                                           70 'Ended'
     O                                           88 'Comp'
     O                                           98 'CPU sec'
     O                                          108 'Tot resp'
     O                                          118 'Nbr trn'
     O                                          127 'AuxIO'
     O                                          132 'Type'
     **
     OQSYSPRT   EF           Detail         1
     O                       JbJobNam            10
     O                       JbUsrPrf            21
     O                       JbJobNbr            28
     O                       JbEntTim            37
     O                       JbEntDat            46
     O                       JbStrTim            55
     O                       JbStrDat            64
     O                       JbEndTim            73
     O                       JbEndDat            82
     O                       JbCmpCod      3     87
     O                       JbCpuTim      3     97
     O                       JbTotRsp      3    107
     O                       JbNbrTrn      3    117
     O                       JbSncXio      3    127
     O                       JbJobTyp           131
     **
     OQSYSPRT   EF           NoRcds      1
     O                                           26 '(No messages found)'
