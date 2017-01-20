     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX925
     **  Description : Receive IFS journal entry exit program
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
     **    3. Only IFS related journal entries are considered candidates for
     **       processing as specified by the receive journal entry (RCVJRNE)
     **       commands journal code (JRNCDE) parameter value 'B'.  In this
     **       case case the entry selection is also further narrowed to IFS
     **       objects being created as specified by the entry type (ENTTYP)
     **       'B1' which is generated as a 'Create Summary' whenever a new
     **       object is created in a journaled IFS directory.
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
     **    Run program CBX925X to create sample application and related
     **    objects.  CPX925X requires two parameters specifying the library
     **    to contain all created objects and the IFS directory to monitor
     **    for objects being created into.
     **
     **    When the sample application and objects are installed, submit
     **    program CBX925 to a job queue available for a never ending
     **    processing type of job:
     **
     **      SbmJob Cmd( CALL PGM( CBX925C ))
     **             Job( CBXIFSLOG )
     **             JobQ( <job queue name> )
     **
     **    To end the sample log job controlled run the following command:
     **
     **      EndJob Job( CBXIFSLOG )
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
     **    IBM documentation about journal entries and their layout can be
     **    found here:
     **
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/rzaki/
     **           rzakijrnentry.htm
     **
     **    Please note the journal code finder:
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/rzaki/
     **           finder/rzakijournalfinder.htm
     **
     **    - And also please note that the QP0LJRNL.H include member that
     **      the journal code B - Integrated File System - refers to is
     **      spelled with a zero as the third letter, not an O as it wrongly
     **      appears in the page's typography.
     **
     **    The Receive Journal Entry (RCVJRNE) command is documented in
     **    great detail here:
     **
     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/cl/rcvjrne.htm
     **
     **    - And also directly on your system as part of the command's help
     **      text.
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- System information:
     D PgmSts         SDs
     D  PsPgmNam         *Proc
     D  PsSts                         5a   Overlay( PgmSts:  11 )
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Journal exit program interface:
     D TYPE2           Ds                  Based( pNull )
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
     D  JOOBJ_Q                      20a
     D   JOOBJ                       10a   Overlay( JOOBJ_Q: 1 )
     D   JOLIB                       10a   Overlay( JOOBJ_Q: *Next )
     D   JOFILID                     16a   Overlay( JOOBJ_Q: 1 )
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
     D JOCOM           Ds                  Based( pNull )
     D  JOCTL                         1a
     D  JOENTAVL                      1a
     D  JOENTPAS                      1a

     **-- JOCTL - journal control:
     D  NO_ENT         c                   '0'
     D  SNG_ENT        c                   '1'
     D  BLK_ENT        c                   '2'
     D  RCV_CHG_END    c                   '3'
     D  BEG_BLK_MOD    c                   '8'
     D  END_RCV_JRNE   c                   '9'
     **-- JOCODE - journal code:
     D  IFS_TYP        c                   'B'
     **-- JOENTT - entry type:
     D  CRT_TYP        c                   'B1'

     **-- Journal entry B1 structure:
     D Jrn_Ent_B1      Ds                  Based( pJrn_Ent_B1 )  Qualified
     D  OfsName                      10u 0
     D  OfsPath                      10u 0
     D  OfsSymLnk                    10u 0
     D  SymLnkObjTyp                  7a
     D                                1a
     D  ObjFilId                     16a
     D  ObjOwnNam                    10a
     D  ObjGrpNam                    10a
     D  ObjAudVal                    10a
     D  ObjCcsId                      5u 0
     D  ObjOwnAut                          LikeDs( Jrn_Ent_Aut )
     D  ObjGrpAut                          LikeDs( Jrn_Ent_Aut )
     D  ObjPubAut                          LikeDs( Jrn_Ent_Aut )
     D  ObjAutLst                    10a
     D  AutLstPubAut                  1a
     D  FmtInd                        1a
     D  PC_Read_Only                  1a
     D  PC_Hidden                     1a
     D  PC_System                     1a
     D  PC_Chg                        1a
     D  JrnInfo                            LikeDs( Jrn_Inf_t )
     D  DevId                        20u 0
     D  VarDta                     1024a
     **-- Qp0l_Journal_Entry_Auth structure:
     D Jrn_Ent_Aut     Ds                  Based( pNull )
     D  ObjExs                        1a
     D  ObjMgt                        1a
     D  ObjOpr                        1a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     D  Read                          1a
     D  Add                           1a
     D  Upd                           1a
     D  Dlt                           1a
     D  Exclude                       1a
     D  Exe                           1a
     D                                1a
     **-- Qp0l_Journal_Info_t structure:
     D Jrn_Inf_t       Ds                  Based( pNull )
     D  Status                        1a
     D  Opt                           1a
     D  JrnID                        10a
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  JrnStrDts                    10u 0
     **-- Qp0l_Object_Name_t structure:
     D Obj_Nam_t       Ds                  Based( pObj_Nam_t )  Qualified
     D  ObjNamLen                    10u 0
     D  CcsId                        10i 0
     D  CtrId                         2a
     D  LngId                         3a
     D  Rsv                           3a
     D  ObjNam                     1024a
     **-- Qp0l_Path_Name_t structure:
     D Pth_Nam_t       Ds                  Based( pPth_Nam_t )  Qualified
     D  PthInd                        1a
     D  RelDirFilId                  16a
     D  CcsId                        10i 0
     D  CtrId                         2a
     D  LngId                         3a
     D  Rsv                           3a
     D  PthTyp                       10u 0
     D  PthNamLen                    10i 0
     D  PthNamDlm                     2a
     D  Rsv2                         10a
     D  PthNam                     1024a
     **-- Global variables:
     D ObjNam          s           1024a
     D PthNam          s           1024a
     **
     D OutStrLenRt     s             10i 0
     D NotSup          s             10i 0
     D FB              s             10i 0 Dim( 3 )
     **
     D RtnCod          s             10i 0
     **
     D MsgDta          s            256a   Varying
     D MsgKey          s              4a

     **-- Current journal entry sequence number:
     D CurSeqNbr       s             10s 0 DtaAra( CBX925D )

     **-- Convert string:
     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
     D  CsInpCcsId                   10i 0 Const
     D  CsInpStrTyp                  10i 0 Const
     D  CsInpStr                  32767a   Const Options( *VarSize )
     D  CsInpStrSiz                  10i 0 Const
     D  CsOutCcsId                   10i 0 Const
     D  CsOutStrTyp                  10i 0 Const
     D  CsOutCvtAlt                  10i 0 Const
     D  CsOutStrSiz                  10i 0 Const
     D  CsOutStr                  32767a         Options( *VarSize )
     D  CsOutStrLenRt                10i 0
     D  CsNotSup                     10i 0
     D  CsFB                         10i 0 Dim( 3 )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RiRcvVar                  32767a         Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiFmtNam                      8a   Const
     D  RiJobNamQ                    26a   Const
     D  RiJobIntId                   16a   Const
     **-- Optional:
     D  RiError                   32767a         Options( *NoPass: *VarSize )
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
     D  SmMsgId                       7a   Const
     D  SmMsgFq                      20a   Const
     D  SmMsgDta                    512a   Const Options( *VarSize )
     D  SmMsgDtaLen                  10i 0 Const
     D  SmMsgTyp                     10a   Const
     D  SmMsgQq                    1000a   Const Options( *VarSize )
     D  SmMsgQnbr                    10i 0 Const
     D  SmMsgQrpy                    20a   Const
     D  SmMsgKey                      4a
     D  SmError                      10i 0 Const
     **
     D  SmCcsId                      10i 0 Const Options( *NoPass )

     **-- Get job ccsid:
     D JobCcsId        Pr            10i 0
     **-- Check IFS object lock:
     D ChkIfsLck       Pr                  ExtPgm( 'CBX9262' )
     D  PxPthNam                   1024a   Const  Varying
     D  PxRtnCod                     10i 0

     **-- Entry parameters:
     D CBX925          Pr
     D  PxTYPE2                            LikeDs( TYPE2 )
     D  PxJOCOM                            LikeDs( JOCOM )
     **
     D CBX925          Pi
     D  PxTYPE2                            LikeDs( TYPE2 )
     D  PxJOCOM                            LikeDs( JOCOM )

      /Free

        If  PxJOCOM.JOCTL  = SNG_ENT;

          If  PxTYPE2.JOCODE = IFS_TYP  And
              PxTYPE2.JOENTT = CRT_TYP;

            pJrn_Ent_B1 = %Addr( PxTYPE2.JODTA );

            pObj_Nam_t = %Addr( Jrn_Ent_B1 ) + Jrn_Ent_B1.OfsName;
            pPth_Nam_t = %Addr( Jrn_Ent_B1 ) + Jrn_Ent_B1.OfsPath;

            CvtString( Obj_Nam_t.CcsId
                     : 0
                     : Obj_Nam_t.ObjNam
                     : Obj_Nam_t.ObjNamLen
                     : JobCcsId()
                     : 0
                     : 0
                     : %Size( ObjNam )
                     : ObjNam
                     : OutStrLenRt
                     : NotSup
                     : FB
                     );

            CvtString( Pth_Nam_t.CcsId
                     : 0
                     : Pth_Nam_t.PthNam
                     : Pth_Nam_t.PthNamLen
                     : JobCcsId()
                     : 0
                     : 0
                     : %Size( PthNam )
                     : PthNam
                     : OutStrLenRt
                     : NotSup
                     : FB
                     );

            MsgDta = 'IFS object '''              +
                     %Trim( ObjNam )              +
                     ''' created in directory ''' +
                     %Trim( PthNam )              +
                     '''.';

            CallP(e)  SndMsg( *Blanks
                            : *Blanks
                            : MsgDta
                            : %Len( MsgDta )
                            : '*INFO'
                            : PsCurUsr + '*LIBL'
                            : 1
                            : *Blanks
                            : MsgKey
                            : 0
                            );

            ChkIfsLck( %Trim( PthNam ) + '/' + %Trim( ObjNam ): RtnCod );

            //-- Process file example: CallP(e)  PrcIfsFil( ObjNam: PthNam )

            ExSr  UpdSeqNbr;

          EndIf;
        EndIf;

        ExSr  ChkEndRqs;

        Return;


        BegSr  UpdSeqNbr;

          In  *Lock  CurSeqNbr;

          CurSeqNbr = PxTYPE2.JOSEQN;

          Out  CurSeqNbr;

        EndSr;

        BegSr  ChkEndRqs;

          If  %Shtdn();

            PxJOCOM.JOCTL = END_RCV_JRNE;

            *InLr = *On;

          EndIf;

        EndSr;

      /End-Free

     **-- Get job ccsid:  ----------------------------------------------------**
     P JobCcsId        B
     D                 Pi            10i 0
     **-- Job info format JOBI0400:
     D JOBI0400        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  JobNam                       10a
     D  UsrNam                       10a
     D  JobNbr                        6a
     D  CcsId                        10i 0 Overlay( JOBI0400: 301 )
     D  CcsIdDft                     10i 0 Overlay( JOBI0400: 373 )

      /Free

        RtvJobInf( JOBI0400
                 : %Size( JOBI0400 )
                 : 'JOBI0400'
                 : '*'
                 : *Blank
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  -1;

        When  JOBI0400.CcsId = 65535;
          Return  JOBI0400.CcsIdDft;

        Other;
          Return  JOBI0400.CcsId;
        EndSl;

      /End-Free

     P JobCcsId        E
