000100041002     **
000200060819     **  Program . . : CBX959
000300060819     **  Description : Remove Journal Receivers - VCP
000400060819     **  Author  . . : Carsten Flensburg
000500060824     **  Published . : System iNetwork Systems Management Newsletter
000600041002     **
000700041002     **
000800041002     **  Program summary
000900041002     **  ---------------
001000041002     **
001100041020     **  Journal and Commit APIs:
001200041020     **    QjoRetrieveJournalInformation       The Retrieve Journal Information
001300041020     **                                        API provides access to journal-
001400041020     **                                        related information that helps
001500041020     **                                        manage a journal environment.
001600041020     **
001700041020     **                                        General information is available
001800041020     **                                        in the return variable's header
001900041020     **                                        section and if requested, lists
002000041020     **                                        describing the journal receiver
002100041020     **                                        directory, journaled objects and
002200041020     **                                        remote journals can be returned.
002300041020     **
002400041020     **    QjoRtvJrnReceiverInformation        The Retrieve Journal Receiver
002500041020     **                                        Information API provides access
002600041020     **                                        to all journal receiver related
002700041020     **                                        information required to manage a
002800041020     **                                        journal environment.
002900041020     **
003000041020     **                                        The information made available is
003100041020     **                                        similar the information provided
003200041020     **                                        by the Display Journal Receiver
003300041020     **                                        Attributes (DSPJRNRCVA) command.
003400041020     **
003500041019     **  Program and CL command APIs:
003600041020     **    QCAPCMD      Process commands       Performs command analyzer
003700041019     **                                        processing on command strings
003800041019     **                                        and checks or runs CL commmands.
003900041019     **
004000041019     **                                        This API is also capable of
004100041019     **                                        syntax checking specific source
004200041019     **                                        definition types.
004300041019     **
004400041002     **  Message handling API:
004500041020     **    QMHSNDPM     Send program message   Sends a message to a program stack
004600041002     **                                        entry (current, previous, etc.) or
004700041002     **                                        an external message queue.
004800041002     **
004900041002     **                                        Both messages defined in a message
005000041002     **                                        file and immediate messages can be
005100041002     **                                        used. For specific message types
005200041002     **                                        only one or the other is allowed.
005300041024     **
005400041024     **    QMHMOVPM     Move program           Moves one or more program
005500041024     **                 message                messages of the specified
005600041024     **                                        message type(s) to the
005700041024     **                                        specified earlier call
005800041024     **                                        level.
005900041024     **
006000041024     **                                        Message sender information
006100041024     **                                        is not changed by the API,
006200041024     **                                        but escape messages are
006300041024     **                                        automatically changed to
006400041024     **                                        diagnostic messages.
006500041024     **
006600041020     **  ILE CEE APIs:
006700041020     **    CEERTX       Register call stack    Registers a procedure that runs
006800041020     **                 entry termination      when the call stack entry, for
006900041020     **                 user exit procedure    which it is registered, is ended
007000041020     **                                        by anything other than a return
007100041020     **                                        to the caller.
007200041020     **
007300041020     **    CEEUTX       Unregister call stack  Unregisters a procedure that was
007400041020     **                 entry termination      previously registered by the
007500041020     **                 user exit procedure    CEERTX API.
007600041020     **
007700041020     **                                        The CEEUTX API operates on the
007800041020     **                                        call stack entry termination user
007900041020     **                                        exits that are registered for the
008000041020     **                                        call stack entry from which the
008100041020     **                                        CEEUTX API is called.
008200041020     **
008300041020     **
008400041002     **  Sequence of events:
008500041022     **    1. The special value parameters received from the command interface
008600041022     **       are checked and converted to appropriate values for the selection
008700041022     **       process to be performed.
008800041022     **
008900041022     **    2. Storage is allocated for the API receiver variable and the API is
009000041022     **       is called.  If more data is available than the receiver can hold,
009100041022     **       sufficient storage is reallocated and the API call repeated.
009200041022     **
009300041022     **    3. A job termination procedure is registered to ensure that allocated
009400041022     **       storage is properly deallocated in the event that the program is
009500041022     **       terminated unexpectedly - or as a result of sending an escape
009600041022     **       message if case of an error being encountered calling an API or
009700041022     **       issuing the DLTJRNRCV command.
009800041022     **
009900041022     **    4. The returned journal receiver directory list is processed, and for
010000041022     **       each receiver the Retrieve Journal Receiver Information API is
010100041022     **       called to make the receiver's attributes available to the receiver
010200041022     **       selection process.
010300041022     **
010400041022     **    5. Each listed journal receiver is evaluated against the specified
010500041022     **       selection criteria and if passed, the journal receiver is then
010600041022     **       processed in accordance with the specified option; if deletion
010700041022     **       was requested, it is deleted, and for both options it is counted.
010800041022     **
010900041022     **    6. When the whole journal receiver directory has been processed, an
011000041022     **       informational message is sent to the caller, specifying the number
011100041022     **       or journal receivers that matched the selection criteria.
011200041022     **
011300041022     **    7. The job termination procedure is unregistered and called directly
011400041022     **       to deallacate the storage previously allocated.
011500041002     **
011600060819     **
011700060819     **  Compile options:
011800060819     **    CrtRpgMod   Module( CBX959 )
011900060819     **                DbgView( *LIST )
012000060819     **
012100060819     **    CrtPgm      Pgm( CBX959 )
012200060819     **                Module( CBX959 )
012300060819     **                ActGrp( *NEW )
012400041002     **
012500041002     **
012600000810     **-- Header specifications:  --------------------------------------------**
012700010806     H Option( *SrcStmt )
012800040709     **-- Api error data structure:
012900040710     D ERRC0100        Ds                  Qualified
013000040710     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
013100040710     D  BytAvl                       10i 0 Inz
013200040710     D  MsgId                         7a
013300010329     D                                1a
013400040710     D  MsgDta                      128a
013500041017     **-- Global variables:
013600041017     D Idx             s             10u 0
013700041017     D ApiRcvSiz       s             10u 0
013800041018     D RcvRtnDat       s               d
013900041023     D SltRcv          s               n
014000041019     D NbrRcv          s             10i 0 Inz( *Zero )
014100041017     D MsgKey          s              4a
014200041017     D MsgTxt          s            512a   Varying
014300041017     D CmdStr          s            512a   Varying
014400041017     **-- Global constants:
014500041017     D OFS_MSGDTA      c                   16
014600040709     **-- Journal information:
014700040710     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
014800040710     D  BytRtn                       10i 0
014900040710     D  BytAvl                       10i 0
015000040710     D  OfsKeyInf                    10i 0
015100040710     D  JrnNam                       10a
015200040710     D  JrnLib                       10a
015300040710     D  ASP                          10i 0
015400040710     D  MsgQnam                      10a
015500040710     D  MsgQlib                      10a
015600040710     D  MngRcvOpt                     1a
015700040710     D  DltRcvOpt                     1a
015800040710     D  RsoRit                        1a
015900040710     D  RsoMfl                        1a
016000040710     D  RsoMo1                        1a
016100040710     D  RsoMo2                        1a
016200040710     D  Rsv1                          3a
016300040710     D  JrnTyp                        1a
016400040710     D  RmtJrnTyp                     1a
016500040710     D  JrnStt                        1a
016600040710     D  JrnDlvMod                     1a
016700040710     D  LocJrnNam                    10a
016800040710     D  LocJrnLib                    10a
016900040710     D  LocJrnSys                     8a
017000040710     D  SrcJrnNam                    10a
017100040710     D  SrcJrnLib                    10a
017200040710     D  SrcJrnSys                     8a
017300040710     D  RdrRcvLib                    10a
017400040710     D  JrnTxt                       50a
017500040710     D  MinEntDtaAr                   1a
017600040710     D  MinEntFiles                   1a
017700040710     D  Rsv2                          9a
017800040710     D  NbrAtcRcv                    10i 0
017900040710     D  AtcRcvNam                    10a
018000040710     D  AtcRcvLib                    10a
018100040710     D  AtcLocSys                     8a
018200040710     D  AtcSrcSys                     8a
018300040710     D  AtcRcvNamDu                  10a
018400040710     D  AtcRcvLibDu                  10a
018500040710     D  Rsv3                        192a
018600040710     D  NbrKey                       10i 0
018700020509     **
018800040710     D JrnKey          Ds                  Based( pJrnKey )  Qualified
018900040710     D  Key                          10i 0
019000040710     D  OfsKeyInf                    10i 0
019100040710     D  KeyHdrSecLn                  10i 0
019200040710     D  NbrEnt                       10i 0
019300040710     D  KeyInfEntLn                  10i 0
019400020509     **
019500040710     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
019600040710     D  RcvNbrTot                    10i 0
019700040710     D  RcvSizTot                    10i 0
019800040710     D  RcvSizMtp                    10i 0
019900040710     D  Rsv                           8a
020000020509     **
020100040710     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
020200040710     D  RcvNam                       10a
020300040710     D  RcvLib                       10a
020400040710     D  RcvNbr                        5a
020500040710     D  RcvAtcDts                    13a
020600040710     D  RcvSts                        1a
020700040710     D  RcvSavDts                    13a
020800040710     D  LocJrnSys                     8a
020900040710     D  SrcJrnSys                     8a
021000040710     D  RcvSiz                       10i 0
021100040710     D  Rsv                          56a
021200040709     **-- Journal information specification:
021300040710     D JrnInfRtv       Ds                  Qualified
021400040710     D  NbrVarRcd                    10i 0 Inz( 1 )
021500040710     D  VarRcdLen                    10i 0 Inz( 12 )
021600040710     D  Key                          10i 0 Inz( 1 )
021700040710     D  DtaLen                       10i 0 Inz( 0 )
021800040709     **-- Receiver information:
021900040710     D RRCV0100        Ds                  Qualified
022000040710     D  BytRtn                       10i 0
022100040710     D  BytAvl                       10i 0
022200040710     D  RcvNam                       10a
022300040710     D  RcvLib                       10a
022400040710     D  JrnNam                       10a
022500040710     D  JrnLib                       10a
022600040710     D  Thh                          10i 0
022700040710     D  Siz                          10i 0
022800040710     D  ASP                          10i 0
022900040710     D  NbrJrnEnt                    10i 0
023000040710     D  MaxEspDtaLn                  10i 0
023100040710     D  MaxNulInd                    10i 0
023200040710     D  FstSeqNbr                    10i 0
023300040710     D  MinEntDtaAr                   1a
023400040710     D  MinEntFiles                   1a
023500040710     D  Rsv1                          2a
023600040710     D  LstSeqNbr                    10i 0
023700040710     D  Rsv2                         10i 0
023800041017     D  Status                        1a
023900040710     D  MinFxlVal                     1a
024000040710     D  RcvMaxOpt                     1a
024100040710     D  Rsv3                          4a
024200040710     D  AtcDts                       13a
024300040710     D  DtcDts                       13a
024400041018     D   DtcDat                       7a   Overlay( DtcDts: 1 )
024500041018     D   DtcTim                       6a   Overlay( DtcDts: *Next )
024600040710     D  SavDts                       13a
024700041017     D   SavDat                       7a   Overlay( SavDts: 1 )
024800041017     D   SavTim                       6a   Overlay( SavDts: *Next )
024900040710     D  Txt                          50a
025000040710     D  PndTrn                        1a
025100040710     D  RmtJrnTyp                     1a
025200040710     D  LocJrnNam                    10a
025300040710     D  LocJrnLib                    10a
025400040710     D  LocJrnSys                     8a
025500040710     D  LocRcvLib                    10a
025600040710     D  SrcJrnNam                    10a
025700040710     D  SrcJrnLib                    10a
025800040710     D  SrcJrnSys                     8a
025900040710     D  SrcRcvLib                    10a
026000040710     D  RdcRcvLib                    10a
026100040710     D  DuaRcvNam                    10a
026200040710     D  DuaRcvLib                    10a
026300040710     D  PrvRcvNam                    10a
026400040710     D  PrvRcvLib                    10a
026500040710     D  PrvRcvNamDu                  10a
026600040710     D  PrvRcvLibDu                  10a
026700040710     D  NxtRcvNam                    10a
026800040710     D  NxtRcvLib                    10a
026900040710     D  NxtRcvNamDu                  10a
027000040710     D  NxtRcvLibDu                  10a
027100040710     D  NbrJrnEntL                   20s 0
027200040710     D  MaxEspDtlL                   20s 0
027300040710     D  FstSeqNbrL                   20s 0
027400040710     D  LstSeqNbrL                   20s 0
027500040710     D  AspDevNam                    10a
027600040710     D  LocJrnAspGn                  10a
027700040710     D  SrcJrnAspGn                  10a
027800040710     D  FldJob                        1a
027900040710     D  FldUsr                        1a
028000040710     D  FldPgm                        1a
028100040710     D  FldPgmLib                     1a
028200040710     D  FldSysSeq                     1a
028300040710     D  FldRmtAdr                     1a
028400040710     D  FldThd                        1a
028500040710     D  FldLuw                        1a
028600040710     D  FldXid                        1a
028700040710     D  Rsv4                         21a
028800040709     **-- Retrieve journal information:
028900020509     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
029000020509     D                                     Information' )
029100020509     D  JiRcvVar                  65535a         Options( *VarSize )
029200020509     D  JiRcvVarLen                  10i 0 Const
029300020509     D  JiJrnNam                     20a   Const
029400020509     D  JiFmtNam                      8a   Const
029500020509     D  JiInfRtv                  65535a   Const Options( *VarSize )
029600040511     D  JiError                   32767a         Options( *VarSize: *Omit )
029700040709     **-- Retrieve journal receiver information:
029800020509     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
029900020509     D                                     Information' )
030000020509     D  RiRcvVar                  65535a         Options( *VarSize )
030100020509     D  RiRcvVarLen                  10i 0 Const
030200020509     D  RiRcvNam                     20a   Const
030300020509     D  RiFmtNam                      8a   Const
030400040511     D  RiError                   32767a         Options( *VarSize: *Omit )
030500041019     **-- Register termination exit:
030600041019     D CeeRtx          Pr                    ExtProc( 'CEERTX' )
030700041019     D  procedure                      *     ProcPtr   Const
030800041019     D  token                          *     Options( *Omit )
030900041019     D  fb                           12a     Options( *Omit )
031000041019     **-- Unregister termination exit:
031100041019     D CeeUtx          Pr                    ExtProc( 'CEEUTX' )
031200041019     D  procedure                      *     ProcPtr   Const
031300041019     D  fb                           12a     Options( *Omit )
031400041019     **-- Process commands:
031500041019     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
031600041019     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
031700041019     D  PcSrcCmdLen                  10i 0 Const
031800041019     D  PcOptCtlBlk                  20a   Const
031900041019     D  PcOptCtlBlkLn                10i 0 Const
032000041019     D  PcOptCtlBlkFm                 8a   Const
032100041019     D  PcChgCmd                  32767a          Options( *VarSize )
032200041019     D  PcChgCmdLen                  10i 0 Const
032300041019     D  PcChgCmdLenAv                10i 0
032400041019     D  PcError                   32767a          Options( *VarSize )
032500041017     **-- Send program message:
032600041002     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
032700041002     D  SpMsgId                       7a   Const
032800041002     D  SpMsgFq                      20a   Const
032900041002     D  SpMsgDta                    128a   Const
033000041002     D  SpMsgDtaLen                  10i 0 Const
033100041002     D  SpMsgTyp                     10a   Const
033200041002     D  SpCalStkE                    10a   Const  Options( *VarSize )
033300041002     D  SpCalStkCtr                  10i 0 Const
033400041002     D  SpMsgKey                      4a
033500041017     D  SpError                   32767a          Options( *VarSize )
033600041024     **-- Move program messages:
033700041024     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
033800041024     D  MpMsgKey                      4a   Const
033900041024     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
034000041024     D  MpNbrMsgTyps                 10i 0 Const
034100041024     D  MpToCalStkE                4102a   Const  Options( *VarSize )
034200041024     D  MpToCalStkCnt                10i 0 Const
034300041024     D  MpError                   32767a          Options( *VarSize )
034400041024     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
034500041024     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
034600041024     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
034700041024     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
034800041024     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )
034900041017
035000041019     **-- Process command:
035100041019     D PrcCmd          Pr            10i 0
035200041019     D  CmdStr                     1024a   Const  Varying
035300041017     **-- Send escape message:
035400041017     D SndEscMsg       Pr            10i 0
035500041017     D  PxMsgId                       7a   Const
035600041017     D  PxMsgF                       10a   Const
035700041017     D  PxMsgDta                    512a   Const  Varying
035800041017     **-- Send message by type:
035900041017     D SndMsgTyp       Pr            10i 0
036000041017     D  PxMsgDta                    512a   Const  Varying
036100041017     D  PxMsgTyp                     10a   Const
036200041019     **-- Terminate program:
036300041019     D TrmPgm          Pr
036400041020     D  pPtr                           *
036500041017
036600041017     **-- Entry parameters:
036700060819     D ObjNam_q        Ds                  Qualified
036800060819     D  ObjNam                       10a
036900060819     D  ObjLib                       10a
037000060819     **
037100060819     D ObjNam_e        Ds                  Qualified
037200060819     D  NbrObj                        5i 0
037300060819     D  ObjNam_q                           LikeDs( ObjNam_q )  Dim( 2 )
037400060819     **
037500060819     D CBX959          Pr
037600060819     D  PxJrnNam_q                         LikeDs( ObjNam_q )
037700060819     D  PxRcvRtnDays                  5i 0
037800060819     D  PxRcvRtnNbr                   5i 0
037900060819     D  PxForce                       3a
038000060819     D  PxChgJrn                      3a
038100060819     D  PxJrnRcv                           LikeDs( ObjNam_e )
038200060819     D  PxSeqOpt                      6a
038300060819     **
038400060819     D CBX959          Pi
038500060819     D  PxJrnNam_q                         LikeDs( ObjNam_q )
038600060819     D  PxRcvRtnDays                  5i 0
038700060819     D  PxRcvRtnNbr                   5i 0
038800060819     D  PxForce                       3a
038900060819     D  PxChgJrn                      3a
039000060819     D  PxJrnRcv                           LikeDs( ObjNam_e )
039100060819     D  PxSeqOpt                      6a
039200040710
039300041017      /Free
039400040709
039500041017        ExSr  InzParms;
039600041017
039700060819        If  PxChgJrn = 'YES';
039800060819          ExSr  ChgJrnRcv;
039900060819        EndIf;
040000060819
040100041017        ApiRcvSiz = 65535;
040200041017        pJrnInf   = %Alloc( ApiRcvSiz );
040300041017        RJRN0100.BytAvl = *Zero;
040400040709
040500041017        DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
040600041017             ERRC0100.BytAvl  > *Zero;
040700040709
040800041017          If  RJRN0100.BytAvl > ApiRcvSiz;
040900041017            ApiRcvSiz  = RJRN0100.BytAvl;
041000041017            pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
041100041017          EndIf;
041200040709
041300041017          RtvJrnInf( RJRN0100
041400041017                   : ApiRcvSiz
041500041017                   : PxJrnNam_q
041600041017                   : 'RJRN0100'
041700041017                   : JrnInfRtv
041800041017                   : ERRC0100
041900041017                   );
042000041017        EndDo;
042100041019
042200041019        CeeRtx( %Paddr( TrmPgm ): pJrnInf: *Omit );
042300040709
042400041017        If  ERRC0100.BytAvl > *Zero;
042500041017
042600041017          SndEscMsg( ERRC0100.MsgId
042700041017                   : 'QCPFMSG'
042800041017                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
042900041017                   );
043000041017        Else;
043100041017
043200041017          ExSr  PrcKeyEnt;
043300041017          ExSr  SndCmpMsg;
043400041017        EndIf;
043500040709
043600041019        CeeUtx( %Paddr( TrmPgm ): *Omit );
043700041019
043800041019        TrmPgm( pJrnInf );
043900040709
044000041017        Return;
044100040709
044200041017
044300041017        BegSr PrcKeyEnt;
044400040709
044500041017          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );
044600040709
044700041017          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
044800041017          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );
044900040709
045000041017          For  Idx = 1  to JrnKey.NbrEnt;
045100040709
045200041017            RtvRcvInf( RRCV0100
045300041017                     : %Size( RRCV0100 )
045400041017                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
045500041017                     : 'RRCV0100'
045600041017                     : ERRC0100
045700041017                     );
045800040709
045900041017            If  ERRC0100.BytAvl = *Zero;
046000041017              ExSr  PrcLstEnt;
046100041017            EndIf;
046200040709
046300041017            If  Idx < JrnKey.NbrEnt;
046400041017              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
046500041017            EndIf;
046600041017          EndFor;
046700040709
046800041017        EndSr;
046900041017
047000041017        BegSr  InzParms;
047100041017
047200041017          If  PxRcvRtnDays = -1;
047300041018            RcvRtnDat = %Date() + %Days(1);
047400041017          Else;
047500041018            RcvRtnDat = %Date() - %Days( PxRcvRtnDays );
047600041017          EndIf;
047700041017
047800041017        EndSr;
047900041017
048000041017        BegSr  PrcLstEnt;
048100041017
048200041023          SltRcv = *On;
048300041023
048400041017          Select;
048500041017          When  RRCV0100.Status = '1';
048600041023            SltRcv = *Off;
048700041017
048800041017          When  PxRcvRtnNbr > -1        And
048900041018                PxRcvRtnNbr > JrnKey.NbrEnt - Idx;
049000041023            SltRcv = *Off;
049100041017
049200070613          When  RRCV0100.DtcDat = *Zeros  Or  RRCV0100.DtcDat = *Blanks;
049300070613            SltRcv = *Off;
049400070613
049500060819          When  RcvRtnDat <= %Date( RRCV0100.DtcDat: *CYMD0 );
049600060819            SltRcv = *Off;
049700060819
049800060819          When  PxForce = 'NO'          And
049900041017                RRCV0100.Status <> '3'  And
050000041017                RRCV0100.Status <> '4';
050100060819
050200060819            SltRcv = *Off;
050300041017          EndSl;
050400041017
050500041023          If  SltRcv = *On;
050600060819            ExSr  DltJrnRcv;
050700041019          EndIf;
050800041017
050900041017        EndSr;
051000041017
051100060819        BegSr  DltJrnRcv;
051200041017
051300060819          CmdStr = 'DLTJRNRCV JRNRCV('      +
051400060820                   %Trim( RRCV0100.RcvLib ) + '/' +
051500060820                   %Trim( RRCV0100.RcvNam ) + ')';
051600060820
051700060820          If  PxForce = 'YES';
051800060820            CmdStr += ' DLTOPT(*IGNINQMSG *IGNTGTRCV)';
051900060820          Else;
052000060820            CmdStr += ' DLTOPT(*IGNINQMSG)';
052100060820          EndIf;
052200060819
052300060819          If  PrcCmd( CmdStr) < *Zero;
052400060819            SndEscMsg( 'CPF0001': 'QCPFMSG': 'DLTJRNRCV' );
052500060820          Else;
052600041017            NbrRcv += 1;
052700041017          EndIf;
052800041017
052900041017        EndSr;
053000060819
053100060819        BegSr  ChgJrnRcv;
053200060819
053300060820          If  PxJrnRcv.ObjNam_q(1).ObjNam = '*GEN';
053400060820            PxJrnRcv.ObjNam_q(1).ObjLib = '*N';
053500060819          EndIf;
053600060819
053700060819          CmdStr = 'CHGJRN JRN('                       +
053800060819                   %Trim( PxJrnNam_q.ObjLib )          + '/'  +
053900060819                   %Trim( PxJrnNam_q.ObjNam )          + ') ' +
054000060819                   'JRNRCV('                           +
054100060819                   %Trim( PxJrnRcv.ObjNam_q(1).ObjLib ) + '/'  +
054200060820                   %Trim( PxJrnRcv.ObjNam_q(1).ObjNam ) + ') ' +
054300060819                   'SEQOPT('                           +
054400060819                   %Trim( PxSeqOpt )                   + ')';
054500060819
054600060819          If  PrcCmd( CmdStr) < *Zero;
054700060819            SndEscMsg( 'CPF0001': 'QCPFMSG': 'CHGJRN' );
054800060819          EndIf;
054900060820
055000060820        EndSr;
055100041017
055200041017        BegSr  SndCmpMsg;
055300041017
055400060819          MsgTxt = %Char( NbrRcv ) + ' journal receivers met the ' +
055500060819                   'selection criteria and were deleted.';
055600060819
055700041017          SndMsgTyp( MsgTxt: '*COMP' );
055800041017
055900041017        EndSr;
056000041017
056100041020      /End-Free
056200041020
056300041019     **-- Process command:  --------------------------------------------------**
056400041019     P PrcCmd          B                   Export
056500041019     D                 Pi            10i 0
056600041019     D  PxCmdStr                   1024a   Const  Varying
056700041019     **
056800041019     D CPOP0100        Ds                  Qualified
056900041019     D  TypPrc                       10i 0 Inz( 2 )
057000041019     D  DBCS                          1a   Inz( '0' )
057100041019     D  PmtAct                        1a   Inz( '2' )
057200041019     D  CmdStx                        1a   Inz( '0' )
057300041019     D  MsgRtvKey                     4a   Inz( *Allx'00' )
057400041019     D  Rsv                           9a   Inz( *Allx'00' )
057500041019     **
057600041019     D ChgCmd          s           2048a
057700041019     D ChgCmdAvl       s             10i 0
057800041019     **-- Api error data structure:
057900041019     D ERRC0100        Ds                  Qualified
058000041019     D  BytPro                       10i 0 Inz( *Zero )
058100041019     **
058200041019
058300041019      /Free
058400041019
058500041020        CallP(e) PrcCmds( PxCmdStr
058600041019                        : %Len( PxCmdStr )
058700041019                        : CPOP0100
058800041019                        : %Size( CPOP0100 )
058900041019                        : 'CPOP0100'
059000041019                        : ChgCmd
059100041019                        : %Size( ChgCmd )
059200041019                        : ChgCmdAvl
059300041019                        : ERRC0100
059400041019                        );
059500041019
059600041019        If  %Error;
059700041019
059800041019          Return -1;
059900041019        Else;
060000041024
060100041024          MovPgmMsg( *Blanks
060200041024                   : '*COMP'
060300041024                   : 1
060400041024                   : '*PGMBDY'
060500041024                   : 1
060600041024                   : ERRC0100
060700041024                   );
060800041019
060900041019          Return 0;
061000041019        EndIf;
061100041019
061200041019      /End-Free
061300041019
061400041019     P PrcCmd          E
061500041017     **-- Send escape message:  ----------------------------------------------**
061600041017     P SndEscMsg       B
061700041017     D                 Pi            10i 0
061800041017     D  PxMsgId                       7a   Const
061900041017     D  PxMsgF                       10a   Const
062000041017     D  PxMsgDta                    512a   Const  Varying
062100041017     **
062200041017     D MsgKey          s              4a
062300041017
062400041017      /Free
062500041017
062600041017        SndPgmMsg( PxMsgId
062700041017                 : PxMsgF + '*LIBL'
062800041017                 : PxMsgDta
062900041017                 : %Len( PxMsgDta )
063000041017                 : '*ESCAPE'
063100041017                 : '*PGMBDY'
063200041017                 : 1
063300041017                 : MsgKey
063400041017                 : ERRC0100
063500041017                 );
063600041017
063700041017        If  ERRC0100.BytAvl > *Zero;
063800041017          Return  -1;
063900041017
064000041017        Else;
064100041017          Return   0;
064200041017        EndIf;
064300041017
064400041017      /End-Free
064500041017
064600041017     P SndEscMsg       E
064700041017     **-- Send message by type:  ---------------------------------------------**
064800041017     P SndMsgTyp       B
064900041017     D                 Pi            10i 0
065000041017     D  PxMsgDta                    512a   Const  Varying
065100041017     D  PxMsgTyp                     10a   Const
065200041017     **
065300041017     D MsgKey          s              4a
065400041017
065500041017      /Free
065600041017
065700041017        SndPgmMsg( 'CPF9897'
065800041017                 : 'QCPFMSG   *LIBL'
065900041017                 : PxMsgDta
066000041017                 : %Len( PxMsgDta )
066100041017                 : PxMsgTyp
066200041017                 : '*PGMBDY'
066300041017                 : 1
066400041017                 : MsgKey
066500041017                 : ERRC0100
066600041017                 );
066700041017
066800041017        If  ERRC0100.BytAvl > *Zero;
066900041017          Return  -1;
067000041017
067100041017        Else;
067200041017          Return   0;
067300041017        EndIf;
067400041017
067500041017      /End-Free
067600041017
067700041017     P SndMsgTyp       E
067800041019     **-- Terminate program:  ------------------------------------------------**
067900041019     P TrmPgm          B
068000041019     D                 Pi
068100041020     D  pPtr                           *
068200041019
068300041019      /Free
068400041019
068500041020        DeAlloc  pPtr;
068600041019
068700041019        *InLr = *On;
068800041019
068900041019        Return;
069000041019
069100041019      /End-Free
069200041019
069300041019     P TrmPgm          E
