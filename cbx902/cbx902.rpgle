     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX902
     **  Description : Receive journal entry exit program
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    TYPE2  . . :  INPUT:  Journal entry
     **                          - Journal entry information     - TYPE2 fixed
     **                          - Journal entry data            - JODTA
     **
     **    JOCOM  . . :  BOTH:   Journal exit control
     **                          - Entry type specification      - JOCTL
     **                          - Process control
     **                          - Additional entry availability - JOENTAVL
     **                          - State of entry passed         - JOENTPAS
     **
     **
     **  Program summary
     **  ---------------
     **
     **  Sequence of events:
     **    1. The RCVJRNE command's Delay parameter controls how the journal
     **       entries are processed.  In this setup the Delay( *NEXTENT 25 )
     **       ensures that journal entries are processed as they arrive in
     **       the journal receiver.
     **
     **       If no entry arrives within the number of seconds specified in
     **       the second part of the parameter - in this case 25 seconds -  e
     **       control is passed to the exit program and JOCTL is set to '0'
     **       to indicate thto no journal entries are available.
     **
     **       The 25 seconds allow the job to detect if an end job request
     **       has been issued, within the 30 seconds that are by default the
     **       delay time for a controlled end job request.
     **
     **    2. For every journal entry that is recieved by the RCVJRNE command
     **       and for every time-out that the RCVJRNE command is encountering
     **       while waiting for new journal entries, control is passed to the
     **       exit program specified on the command.
     **
     **    3. Only record entry types are considered candidates for processing
     **       as specified by the EntTyp( *RCD ) parameter on the RCVJRNE
     **       command.  Use an appropriate combination of the journal code and
     **       entry type parameters to select other groups of entries.
     **
     **    4. To ensure that we have recieved entries to process, the entry
     **       type, journal code and object name are checked against the
     **       relevant conditions.
     **
     **    5. Immediately following the processing of each journal entry it's
     **       sequence number is registered in a data area.  The sequence
     **       number stored in the data area provides the synchronization
     **       point for the journal exit program's entry processing.
     **
     **    6. Whenever a complete journal event has been processed the job
     **       ending status is checked, and if a job termination request has
     **       been issued, a stop proces is signalled to the RCVJRNE command
     **       by entering a '9' in the JOCTL parameter.
     **
     **
     **  Prerequisites:
     **    Run program CBX902X to create sample application and related
     **    objects.  CPX902X requires a single parameter specifying the
     **    library to contain all created objects.
     **
     **    When the sample application and objects are installed, submit
     **    program CBX902 to a job queue available for a never ending
     **    processing type of job:
     **
     **      SbmJob Cmd( CALL PGM( CBX902C ))
     **             Job( CBXLOG )
     **             JobQ( <job queue name> )
     **
     **    To test the journal log sample application use your favorite DFU
     **    tool to insert and change a couple of records in the CBX902F file.
     **
     **    Having inserted and modified the test records use the DSPPFM,
     **    RUNQRY or another similar command to inspect the CBX902F file and
     **    check if the actions you performed against the CBXDTAF file have
     **    been recorded correctly.
     **
     **    To end the sample log job controlled run the following command:
     **
     **      EndJob Job( CBXLOG )
     **             Option( *CNTRLD )
     **             Delay( 30 )
     **
     **    Option controlled and delay 30 seconds will allow the journal
     **    exit program to detect the end request and stop the journal
     **    processing gracefully.
     **
     **
     **  Programmer's notes:
     **    The journal log sample application provided here should only be
     **    regarded as a starting point for your own implementation - that
     **    would need to be researched carefully in order to meet the
     **    specific requirements of your environment and objectives.
     **
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )
     **-- File specifications:  ----------------------------------------------**
     FCBX902F   O    E             Disk    Block(*NO)
     **-- Journal exit program interface:  -----------------------------------**
     D TYPE2           Ds
     D  JOENTL                        5s 0
     D  JOSEQN                       10s 0
     D  JOCODE                        1a
     D  JOENTT                        2a
     D  JODATE                        6a
     D  JOTIME                        6s 0
     D  JOJOB                        10a
     D  JOUSER                       10a
     D  JONBR                         6s 0
     D  JOPGM                        10a
     D  JOOBJ                        10a
     D  JOLIB                        10a
     D  JOMBR                        10a
     D  JOCTRR                       10s 0
     D  JOFLAG                        1a
     D  JOCCID                       10s 0
     D  JOUSPF                       10a
     D  JOSYNM                        8a
     D  JOINCDAT                      1a
     D  JOMINESD                      1a
     D  JORES                        18a
     D  JODTA                     32767a
     **
     D JOCOM           Ds
     D  JOCTL                         1a
     D  JOENTAVL                      1a
     D  JOENTPAS                      1a
     **-- JOCTL - journal control:  ------------------------------------------**
     D  NoEnt          c                   '0'
     D  SngEnt         c                   '1'
     D  BlkEnt         c                   '2'
     D  RcvChgEnd      c                   '3'
     D  BegBlkMod      c                   '8'
     D  EndRcvJrnE     c                   '9'
     **-- JOCODE - journal code:
     D  RcdTyp         c                   'R'
     **-- Current journal entry sequence number:  ----------------------------**
     D CurSeqNbr       s             10s 0 DtaAra( CBX902D )
     **-- Record images:  ----------------------------------------------------**
     D BfrDs         E Ds                  ExtName( CBXDTAF )  PreFix( B_ )
     D AftDs         E Ds                  ExtName( CBXDTAF )  PreFix( A_ )
     **-- Global variables:  -------------------------------------------------**
     D HdrLen          s             10i 0
     D RcdLen          s             10i 0
     **
     **-- Parameters:  -------------------------------------------------------**
     **
     C     *Entry        Plist
     C                   Parm                    TYPE2
     C                   Parm                    JOCOM
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   If        JOCTL      =  SngEnt        And
     C                             JOCODE     =  RcdTyp
     **
     C                   If        JOOBJ      =  'CBXDTAF'
     C                   Eval      RcdLen     =  JOENTL - HdrLen
     **
     C                   ExSr      InzLogRcd
     **
     C                   Select
     C                   When      JOENTT     =  'UB'
     C                   Exsr      UpdBfr
     **
     C                   When      JOENTT     =  'UP'
     C                   Exsr      UpdAft
     **
     C                   When      JOENTT     =  'PT'          Or
     C                             JOENTT     =  'PX'
     C                   Exsr      RcdAdd
     **
     C                   When      JOENTT     =  'DL'
     C                   Exsr      RcdDlt
     C                   EndSl
     **
     C                   ExSr      UpdSeqNbr
     **
     C                   EndIf
     C                   EndIf
     **
     C                   If        JOENTT     <> 'UB'
     C                   ExSr      ChkEndRqs
     C                   EndIf
     **
     C                   Return
     **
     **-- Update journal sequence number:  -----------------------------------**
     C     UpdSeqNbr     BegSr
     **
     C     *Lock         In        CurSeqNbr
     C                   Eval      CurSeqNbr  =  JOSEQN
     C                   Out       CurSeqNbr
     **
     C                   EndSr
     **-- Check pending endjob request:  -------------------------------------**
     C     ChkEndRqs     BegSr
     **
     C                   If        %Shtdn
     **
     C                   Eval      JOCTL      =  EndRcvJrnE
     C                   Eval      *InLr      =  *On
     C                   EndIf
     **
     C                   EndSr
     **-- Initialize log record:  --------------------------------------------**
     C     InzLogRcd     BegSr
     **
     C                   Clear     *All          CBX902R
     **
     C                   Eval      JLDATE     =  %Date( JODATE: *YMD0 )
     C                   Eval      JLTIME     =  %Time( JOTIME: *HMS  )
     C                   Eval      JLJOB      =  JOJOB
     C                   Eval      JLUSER     =  JOUSER
     C                   Eval      JLNBR      =  JONBR
     C                   Eval      JLUSPF     =  JOUSPF
     C                   Eval      JLPGM      =  JOPGM
     C                   Eval      JLOBJ      =  JOOBJ
     C                   Eval      JLLIB      =  JOLIB
     **
     C                   EndSr
     **-- Update before:  ----------------------------------------------------**
     C     UpdBfr        BegSr
     **
     C                   Eval      BfrDs      =  %Subst( JODTA: 1: RcdLen )
     **
     C                   EndSr
     **-- Update after:  -----------------------------------------------------**
     C     UpdAft        BegSr
     **
     C                   Eval      AftDs      =  %Subst( JODTA: 1: RcdLen )
     C                   ExSr      LogUpdRcd
     **
     C                   EndSr
     **-- Record added:  -----------------------------------------------------**
     C     RcdAdd        BegSr
     **
     C                   Clear                   BfrDs
     **
     C                   Eval      AftDs      =  %Subst( JODTA: 1: RcdLen )
     C                   ExSr      LogAddRcd
     **
     C                   EndSr
     **-- Record deleted:  ---------------------------------------------------**
     C     RcdDlt        BegSr
     **
     C                   Clear                   AftDs
     **
     C                   Eval      BfrDs      =  %Subst( JODTA: 1: RcdLen )
     C                   ExSr      LogDltRcd
     **
     C                   EndSr
     **-- Log added record:  -------------------------------------------------**
     C     LogAddRcd     BegSr
     **
     C                   Eval      JLKEY      =  A_CXPRID
     C                   Eval      JLENTP     =  'A'
     **
     C                   Write     CBX902R
     **
     C                   EndSr
     **-- Log updated record:  -----------------------------------------------**
     C     LogUpdRcd     BegSr
     **
     C                   Eval      JLKEY      =  A_CXPRID
     C                   Eval      JLENTP     =  'C'
     **
     C                   If        B_CXPRGP  <>  A_CXPRGP
     C                   Eval      JLFLD      =  'CXPRGP'
     C                   Eval      JLVALB     =  B_CXPRGP
     C                   Eval      JLVALA     =  A_CXPRGP
     **
     C                   Write     CBX902R
     C                   EndIf
     **
     C                   If        B_CXCTNO  <>  A_CXCTNO
     C                   Eval      JLFLD      =  'CXCTNO'
     C                   Eval      JLVALB     =  %Char( B_CXCTNO )
     C                   Eval      JLVALA     =  %Char( A_CXCTNO )
     **
     C                   Write     CBX902R
     C                   EndIf
     **
     C                   EndSr
     **-- Log deleted record:  -----------------------------------------------**
     C     LogDltRcd     BegSr
     **
     C                   Eval      JLKEY      =  B_CXPRID
     C                   Eval      JLENTP     =  'D'
     **
     C                   Write     CBX902R
     **
     C                   EndSr
     **-- Initial routines:  -------------------------------------------------**
     C     *InzSr        BegSr
     **
     C                   Eval      HdrLen     =  %Addr( JODTA ) - %Addr( TYPE2 )
     **
     C                   EndSr
