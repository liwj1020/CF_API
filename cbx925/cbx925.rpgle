000100000000     **-----------------------------------------------------------------------**
000200000000     **
000300041017     **  Program . . : CBX925
000400041017     **  Description : Receive IFS journal entry exit program
000500000000     **  Author  . . : Carsten Flensburg
000600000000     **
000700000000     **
000800000000     **  Parameters:
000900000000     **    TYPE2  . . :  INPUT:  Journal entry
001000000000     **                          - Journal entry information     - TYPE2 fixed
001100000000     **                          - Journal entry data            - JODTA
001200000000     **
001300000000     **    JOCOM  . . :  BOTH:   Journal exit control
001400000000     **                          - Entry type specification      - JOCTL
001500000000     **                          - Process control
001600000000     **                          - Additional entry availability - JOENTAVL
001700000000     **                          - State of entry passed         - JOENTPAS
001800000000     **
001900000000     **
002000000000     **  Program summary
002100000000     **  ---------------
002200000000     **
002300000000     **  Sequence of events:
002400000000     **    1. The RCVJRNE command's Delay parameter controls how the journal
002500000000     **       entries are processed.  In this setup the Delay( *NEXTENT 25 )
002600000000     **       ensures that journal entries are processed as they arrive in
002700000000     **       the journal receiver.
002800000000     **
002900000000     **       If no entry arrives within the number of seconds specified in
003000000000     **       the second part of the parameter - in this case 25 seconds -  e
003100000000     **       control is passed to the exit program and JOCTL is set to '0'
003200000000     **       to indicate thto no journal entries are available.
003300000000     **
003400000000     **       The 25 seconds allow the job to detect if an end job request
003500000000     **       has been issued, within the 30 seconds that are by default the
003600000000     **       delay time for a controlled end job request.
003700000000     **
003800000000     **    2. For every journal entry that is recieved by the RCVJRNE command
003900000000     **       and for every time-out that the RCVJRNE command is encountering
004000000000     **       while waiting for new journal entries, control is passed to the
004100000000     **       exit program specified on the command.
004200000000     **
004300041017     **    3. Only IFS related journal entries are considered candidates for
004400041017     **       processing as specified by the receive journal entry (RCVJRNE)
004500041017     **       commands journal code (JRNCDE) parameter value 'B'.  In this
004600041017     **       case case the entry selection is also further narrowed to IFS
004700041017     **       objects being created as specified by the entry type (ENTTYP)
004800041017     **       'B1' which is generated as a 'Create Summary' whenever a new
004900041017     **       object is created in a journaled IFS directory.
005000000000     **
005100000000     **    4. To ensure that we have recieved entries to process, the entry
005200000000     **       type, journal code and object name are checked against the
005300000000     **       relevant conditions.
005400000000     **
005500000000     **    5. Immediately following the processing of each journal entry it's
005600000000     **       sequence number is registered in a data area.  The sequence
005700000000     **       number stored in the data area provides the synchronization
005800000000     **       point for the journal exit program's entry processing.
005900000000     **
006000000000     **    6. Whenever a complete journal event has been processed the job
006100000000     **       ending status is checked, and if a job termination request has
006200000000     **       been issued, a stop proces is signalled to the RCVJRNE command
006300000000     **       by entering a '9' in the JOCTL parameter.
006400000000     **
006500000000     **
006600000000     **  Prerequisites:
006700041017     **    Run program CBX925X to create sample application and related
006800041017     **    objects.  CPX925X requires two parameters specifying the library
006900041017     **    to contain all created objects and the IFS directory to monitor
007000041017     **    for objects being created into.
007100041017     **
007200000000     **    When the sample application and objects are installed, submit
007300041017     **    program CBX925 to a job queue available for a never ending
007400000000     **    processing type of job:
007500000000     **
007600041017     **      SbmJob Cmd( CALL PGM( CBX925C ))
007700041017     **             Job( CBXIFSLOG )
007800000000     **             JobQ( <job queue name> )
007900000000     **
008000000000     **    To end the sample log job controlled run the following command:
008100000000     **
008200041017     **      EndJob Job( CBXIFSLOG )
008300000000     **             Option( *CNTRLD )
008400000000     **             Delay( 30 )
008500000000     **
008600000000     **    Option controlled and delay 30 seconds will allow the journal
008700000000     **    exit program to detect the end request and stop the journal
008800000000     **    processing gracefully.
008900000000     **
009000000000     **
009100000000     **  Programmer's notes:
009200000000     **    The journal log sample application provided here should only be
009300000000     **    regarded as a starting point for your own implementation - that
009400000000     **    would need to be researched carefully in order to meet the
009500000000     **    specific requirements of your environment and objectives.
009600000000     **
009700041017     **    IBM documentation about journal entries and their layout can be
009800041017     **    found here:
009900041017     **
010000041017     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/rzaki/
010100041017     **           rzakijrnentry.htm
010200041017     **
010300041017     **    Please note the journal code finder:
010400041017     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/rzaki/
010500041017     **           finder/rzakijournalfinder.htm
010600041017     **
010700041017     **    - And also please note that the QP0LJRNL.H include member that
010800041017     **      the journal code B - Integrated File System - refers to is
010900041017     **      spelled with a zero as the third letter, not an O as it wrongly
011000041017     **      appears in the page's typography.
011100041017     **
011200041017     **    The Receive Journal Entry (RCVJRNE) command is documented in
011300041017     **    great detail here:
011400041017     **
011500041017     **    http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/cl/rcvjrne.htm
011600041017     **
011700041017     **    - And also directly on your system as part of the command's help
011800041017     **      text.
011900000000     **
012000041017     **
012100000000     **-- Header specifications:  --------------------------------------------**
012200041016     H Option( *SrcStmt )
012300041017     **-- System information:
012400041017     D PgmSts         SDs
012500041017     D  PsPgmNam         *Proc
012600041017     D  PsSts                         5a   Overlay( PgmSts:  11 )
012700041017     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
012800041017     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
012900041017     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
013000041017     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
013100041016     **-- API error data structure:
013200041016     D ERRC0100        Ds                  Qualified
013300041016     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
013400041016     D  BytAvl                       10i 0
013500041016     D  MsgId                         7a
013600041016     D                                1a
013700041016     D  MsgDta                      256a
013800041016     **-- Journal exit program interface:
013900041016     D TYPE2           Ds                  Based( pNull )
014000000000     D  JOENTL                        5s 0
014100000000     D  JOSEQN                       10s 0
014200000000     D  JOCODE                        1a
014300000000     D  JOENTT                        2a
014400000000     D  JODATE                        6a
014500000000     D  JOTIME                        6s 0
014600000000     D  JOJOB                        10a
014700000000     D  JOUSER                       10a
014800000000     D  JONBR                         6s 0
014900000000     D  JOPGM                        10a
015000041016     D  JOOBJ_Q                      20a
015100041016     D   JOOBJ                       10a   Overlay( JOOBJ_Q: 1 )
015200041016     D   JOLIB                       10a   Overlay( JOOBJ_Q: *Next )
015300041016     D   JOFILID                     16a   Overlay( JOOBJ_Q: 1 )
015400000000     D  JOMBR                        10a
015500000000     D  JOCTRR                       10s 0
015600000000     D  JOFLAG                        1a
015700000000     D  JOCCID                       10s 0
015800000000     D  JOUSPF                       10a
015900000000     D  JOSYNM                        8a
016000000000     D  JOINCDAT                      1a
016100000000     D  JOMINESD                      1a
016200000000     D  JORES                        18a
016300000000     D  JODTA                     32767a
016400000000     **
016500041016     D JOCOM           Ds                  Based( pNull )
016600000000     D  JOCTL                         1a
016700000000     D  JOENTAVL                      1a
016800000000     D  JOENTPAS                      1a
016900041017
017000041016     **-- JOCTL - journal control:
017100041016     D  NO_ENT         c                   '0'
017200041016     D  SNG_ENT        c                   '1'
017300041016     D  BLK_ENT        c                   '2'
017400041016     D  RCV_CHG_END    c                   '3'
017500041016     D  BEG_BLK_MOD    c                   '8'
017600041016     D  END_RCV_JRNE   c                   '9'
017700000000     **-- JOCODE - journal code:
017800041016     D  IFS_TYP        c                   'B'
017900041016     **-- JOENTT - entry type:
018000041016     D  CRT_TYP        c                   'B1'
018100041017
018200041017     **-- Journal entry B1 structure:
018300041017     D Jrn_Ent_B1      Ds                  Based( pJrn_Ent_B1 )  Qualified
018400041016     D  OfsName                      10u 0
018500041016     D  OfsPath                      10u 0
018600041016     D  OfsSymLnk                    10u 0
018700041016     D  SymLnkObjTyp                  7a
018800041016     D                                1a
018900041016     D  ObjFilId                     16a
019000041016     D  ObjOwnNam                    10a
019100041016     D  ObjGrpNam                    10a
019200041016     D  ObjAudVal                    10a
019300041016     D  ObjCcsId                      5u 0
019400041016     D  ObjOwnAut                          LikeDs( Jrn_Ent_Aut )
019500041016     D  ObjGrpAut                          LikeDs( Jrn_Ent_Aut )
019600041016     D  ObjPubAut                          LikeDs( Jrn_Ent_Aut )
019700041016     D  ObjAutLst                    10a
019800041016     D  AutLstPubAut                  1a
019900041016     D  FmtInd                        1a
020000041016     D  PC_Read_Only                  1a
020100041016     D  PC_Hidden                     1a
020200041016     D  PC_System                     1a
020300041016     D  PC_Chg                        1a
020400041016     D  JrnInfo                            LikeDs( Jrn_Inf_t )
020500041016     D  DevId                        20u 0
020600041016     D  VarDta                     1024a
020700041017     **-- Qp0l_Journal_Entry_Auth structure:
020800041016     D Jrn_Ent_Aut     Ds                  Based( pNull )
020900041016     D  ObjExs                        1a
021000041016     D  ObjMgt                        1a
021100041016     D  ObjOpr                        1a
021200041016     D  ObjAlt                        1a
021300041016     D  ObjRef                        1a
021400041016     D  Read                          1a
021500041016     D  Add                           1a
021600041016     D  Upd                           1a
021700041016     D  Dlt                           1a
021800041016     D  Exclude                       1a
021900041016     D  Exe                           1a
022000041016     D                                1a
022100041017     **-- Qp0l_Journal_Info_t structure:
022200041016     D Jrn_Inf_t       Ds                  Based( pNull )
022300041016     D  Status                        1a
022400041016     D  Opt                           1a
022500041016     D  JrnID                        10a
022600041016     D  JrnNam                       10a
022700041016     D  JrnLib                       10a
022800041016     D  JrnStrDts                    10u 0
022900041017     **-- Qp0l_Object_Name_t structure:
023000041017     D Obj_Nam_t       Ds                  Based( pObj_Nam_t )  Qualified
023100041016     D  ObjNamLen                    10u 0
023200041016     D  CcsId                        10i 0
023300041016     D  CtrId                         2a
023400041016     D  LngId                         3a
023500041016     D  Rsv                           3a
023600041016     D  ObjNam                     1024a
023700041017     **-- Qp0l_Path_Name_t structure:
023800041016     D Pth_Nam_t       Ds                  Based( pPth_Nam_t )  Qualified
023900041016     D  PthInd                        1a
024000041016     D  RelDirFilId                  16a
024100041016     D  CcsId                        10i 0
024200041016     D  CtrId                         2a
024300041016     D  LngId                         3a
024400041016     D  Rsv                           3a
024500041016     D  PthTyp                       10u 0
024600041016     D  PthNamLen                    10i 0
024700041016     D  PthNamDlm                     2a
024800041016     D  Rsv2                         10a
024900041016     D  PthNam                     1024a
025000041016     **-- Global variables:
025100041016     D ObjNam          s           1024a
025200041016     D PthNam          s           1024a
025300041016     **
025400041016     D OutStrLenRt     s             10i 0
025500041016     D NotSup          s             10i 0
025600041016     D FB              s             10i 0 Dim( 3 )
025700041018     **
025800041018     D RtnCod          s             10i 0
025900041017     **
026000041017     D MsgDta          s            256a   Varying
026100041017     D MsgKey          s              4a
026200041016
026300041016     **-- Current journal entry sequence number:
026400041016     D CurSeqNbr       s             10s 0 DtaAra( CBX925D )
026500041016
026600041016     **-- Convert string:
026700041016     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
026800041016     D  CsInpCcsId                   10i 0 Const
026900041016     D  CsInpStrTyp                  10i 0 Const
027000041016     D  CsInpStr                  32767a   Const Options( *VarSize )
027100041016     D  CsInpStrSiz                  10i 0 Const
027200041016     D  CsOutCcsId                   10i 0 Const
027300041016     D  CsOutStrTyp                  10i 0 Const
027400041016     D  CsOutCvtAlt                  10i 0 Const
027500041016     D  CsOutStrSiz                  10i 0 Const
027600041016     D  CsOutStr                  32767a         Options( *VarSize )
027700041016     D  CsOutStrLenRt                10i 0
027800041016     D  CsNotSup                     10i 0
027900041016     D  CsFB                         10i 0 Dim( 3 )
028000041016     **-- Retrieve job information:
028100041016     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
028200041016     D  RiRcvVar                  32767a         Options( *VarSize )
028300041016     D  RiRcvVarLen                  10i 0 Const
028400041016     D  RiFmtNam                      8a   Const
028500041016     D  RiJobNamQ                    26a   Const
028600041016     D  RiJobIntId                   16a   Const
028700041016     **-- Optional:
028800041016     D  RiError                   32767a         Options( *NoPass: *VarSize )
028900041017     **-- Send message:
029000041017     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
029100041017     D  SmMsgId                       7a   Const
029200041017     D  SmMsgFq                      20a   Const
029300041017     D  SmMsgDta                    512a   Const Options( *VarSize )
029400041017     D  SmMsgDtaLen                  10i 0 Const
029500041017     D  SmMsgTyp                     10a   Const
029600041017     D  SmMsgQq                    1000a   Const Options( *VarSize )
029700041017     D  SmMsgQnbr                    10i 0 Const
029800041017     D  SmMsgQrpy                    20a   Const
029900041017     D  SmMsgKey                      4a
030000041017     D  SmError                      10i 0 Const
030100041017     **
030200041017     D  SmCcsId                      10i 0 Const Options( *NoPass )
030300041016
030400041016     **-- Get job ccsid:
030500041016     D JobCcsId        Pr            10i 0
030600041018     **-- Check IFS object lock:
030700041018     D ChkIfsLck       Pr                  ExtPgm( 'CBX9262' )
030800041018     D  PxPthNam                   1024a   Const  Varying
030900041018     D  PxRtnCod                     10i 0
031000041016
031100041016     **-- Entry parameters:
031200041016     D CBX925          Pr
031300041016     D  PxTYPE2                            LikeDs( TYPE2 )
031400041016     D  PxJOCOM                            LikeDs( JOCOM )
031500041016     **
031600041016     D CBX925          Pi
031700041016     D  PxTYPE2                            LikeDs( TYPE2 )
031800041016     D  PxJOCOM                            LikeDs( JOCOM )
031900041016
032000041016      /Free
032100041016
032200041016        If  PxJOCOM.JOCTL  = SNG_ENT;
032300041016
032400041016          If  PxTYPE2.JOCODE = IFS_TYP  And
032500041016              PxTYPE2.JOENTT = CRT_TYP;
032600041016
032700041017            pJrn_Ent_B1 = %Addr( PxTYPE2.JODTA );
032800041016
032900041017            pObj_Nam_t = %Addr( Jrn_Ent_B1 ) + Jrn_Ent_B1.OfsName;
033000041017            pPth_Nam_t = %Addr( Jrn_Ent_B1 ) + Jrn_Ent_B1.OfsPath;
033100041016
033200041017            CvtString( Obj_Nam_t.CcsId
033300041017                     : 0
033400041017                     : Obj_Nam_t.ObjNam
033500041017                     : Obj_Nam_t.ObjNamLen
033600041017                     : JobCcsId()
033700041017                     : 0
033800041017                     : 0
033900041017                     : %Size( ObjNam )
034000041017                     : ObjNam
034100041017                     : OutStrLenRt
034200041017                     : NotSup
034300041017                     : FB
034400041017                     );
034500041016
034600041017            CvtString( Pth_Nam_t.CcsId
034700041017                     : 0
034800041017                     : Pth_Nam_t.PthNam
034900041017                     : Pth_Nam_t.PthNamLen
035000041017                     : JobCcsId()
035100041017                     : 0
035200041017                     : 0
035300041017                     : %Size( PthNam )
035400041017                     : PthNam
035500041017                     : OutStrLenRt
035600041017                     : NotSup
035700041017                     : FB
035800041017                     );
035900041017
036000041017            MsgDta = 'IFS object '''              +
036100041017                     %Trim( ObjNam )              +
036200041017                     ''' created in directory ''' +
036300041017                     %Trim( PthNam )              +
036400041017                     '''.';
036500041017
036600041017            CallP(e)  SndMsg( *Blanks
036700041017                            : *Blanks
036800041017                            : MsgDta
036900041017                            : %Len( MsgDta )
037000041017                            : '*INFO'
037100041017                            : PsCurUsr + '*LIBL'
037200041017                            : 1
037300041017                            : *Blanks
037400041017                            : MsgKey
037500041017                            : 0
037600041017                            );
037700041018
037800041018            ChkIfsLck( %Trim( PthNam ) + '/' + %Trim( ObjNam ): RtnCod );
037900041018
038000041018            //-- Process file example: CallP(e)  PrcIfsFil( ObjNam: PthNam )
038100041017
038200041017            ExSr  UpdSeqNbr;
038300041016
038400041016          EndIf;
038500041016        EndIf;
038600041016
038700041016        ExSr  ChkEndRqs;
038800041016
038900041016        Return;
039000041016
039100041016
039200041016        BegSr  UpdSeqNbr;
039300041016
039400041016          In  *Lock  CurSeqNbr;
039500041016
039600041016          CurSeqNbr = PxTYPE2.JOSEQN;
039700041016
039800041016          Out  CurSeqNbr;
039900041016
040000041016        EndSr;
040100041016
040200041016        BegSr  ChkEndRqs;
040300041016
040400041016          If  %Shtdn();
040500041016
040600041016            PxJOCOM.JOCTL = END_RCV_JRNE;
040700041017
040800041016            *InLr = *On;
040900041016
041000041016          EndIf;
041100041016
041200041016        EndSr;
041300041016
041400041016      /End-Free
041500041016
041600041016     **-- Get job ccsid:  ----------------------------------------------------**
041700041016     P JobCcsId        B
041800041016     D                 Pi            10i 0
041900041016     **-- Job info format JOBI0400:
042000041016     D JOBI0400        Ds                  Qualified
042100041016     D  BytRtn                       10i 0
042200041016     D  BytAvl                       10i 0
042300041016     D  JobNam                       10a
042400041016     D  UsrNam                       10a
042500041016     D  JobNbr                        6a
042600041016     D  CcsId                        10i 0 Overlay( JOBI0400: 301 )
042700041016     D  CcsIdDft                     10i 0 Overlay( JOBI0400: 373 )
042800041016
042900041016      /Free
043000041016
043100041016        RtvJobInf( JOBI0400
043200041016                 : %Size( JOBI0400 )
043300041016                 : 'JOBI0400'
043400041016                 : '*'
043500041016                 : *Blank
043600041016                 : ERRC0100
043700041016                 );
043800041016
043900041016        Select;
044000041016        When  ERRC0100.BytAvl > *Zero;
044100041016          Return  -1;
044200041016
044300041016        When  JOBI0400.CcsId = 65535;
044400041016          Return  JOBI0400.CcsIdDft;
044500041016
044600041016        Other;
044700041016          Return  JOBI0400.CcsId;
044800041016        EndSl;
044900041016
045000041016      /End-Free
045100041016
045200041016     P JobCcsId        E
