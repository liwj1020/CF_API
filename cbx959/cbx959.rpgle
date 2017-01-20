     **
     **  Program . . : CBX959
     **  Description : Remove Journal Receivers - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Newsletter
     **
     **
     **  Program summary
     **  ---------------
     **
     **  Journal and Commit APIs:
     **    QjoRetrieveJournalInformation       The Retrieve Journal Information
     **                                        API provides access to journal-
     **                                        related information that helps
     **                                        manage a journal environment.
     **
     **                                        General information is available
     **                                        in the return variable's header
     **                                        section and if requested, lists
     **                                        describing the journal receiver
     **                                        directory, journaled objects and
     **                                        remote journals can be returned.
     **
     **    QjoRtvJrnReceiverInformation        The Retrieve Journal Receiver
     **                                        Information API provides access
     **                                        to all journal receiver related
     **                                        information required to manage a
     **                                        journal environment.
     **
     **                                        The information made available is
     **                                        similar the information provided
     **                                        by the Display Journal Receiver
     **                                        Attributes (DSPJRNRCVA) command.
     **
     **  Program and CL command APIs:
     **    QCAPCMD      Process commands       Performs command analyzer
     **                                        processing on command strings
     **                                        and checks or runs CL commmands.
     **
     **                                        This API is also capable of
     **                                        syntax checking specific source
     **                                        definition types.
     **
     **  Message handling API:
     **    QMHSNDPM     Send program message   Sends a message to a program stack
     **                                        entry (current, previous, etc.) or
     **                                        an external message queue.
     **
     **                                        Both messages defined in a message
     **                                        file and immediate messages can be
     **                                        used. For specific message types
     **                                        only one or the other is allowed.
     **
     **    QMHMOVPM     Move program           Moves one or more program
     **                 message                messages of the specified
     **                                        message type(s) to the
     **                                        specified earlier call
     **                                        level.
     **
     **                                        Message sender information
     **                                        is not changed by the API,
     **                                        but escape messages are
     **                                        automatically changed to
     **                                        diagnostic messages.
     **
     **  ILE CEE APIs:
     **    CEERTX       Register call stack    Registers a procedure that runs
     **                 entry termination      when the call stack entry, for
     **                 user exit procedure    which it is registered, is ended
     **                                        by anything other than a return
     **                                        to the caller.
     **
     **    CEEUTX       Unregister call stack  Unregisters a procedure that was
     **                 entry termination      previously registered by the
     **                 user exit procedure    CEERTX API.
     **
     **                                        The CEEUTX API operates on the
     **                                        call stack entry termination user
     **                                        exits that are registered for the
     **                                        call stack entry from which the
     **                                        CEEUTX API is called.
     **
     **
     **  Sequence of events:
     **    1. The special value parameters received from the command interface
     **       are checked and converted to appropriate values for the selection
     **       process to be performed.
     **
     **    2. Storage is allocated for the API receiver variable and the API is
     **       is called.  If more data is available than the receiver can hold,
     **       sufficient storage is reallocated and the API call repeated.
     **
     **    3. A job termination procedure is registered to ensure that allocated
     **       storage is properly deallocated in the event that the program is
     **       terminated unexpectedly - or as a result of sending an escape
     **       message if case of an error being encountered calling an API or
     **       issuing the DLTJRNRCV command.
     **
     **    4. The returned journal receiver directory list is processed, and for
     **       each receiver the Retrieve Journal Receiver Information API is
     **       called to make the receiver's attributes available to the receiver
     **       selection process.
     **
     **    5. Each listed journal receiver is evaluated against the specified
     **       selection criteria and if passed, the journal receiver is then
     **       processed in accordance with the specified option; if deletion
     **       was requested, it is deleted, and for both options it is counted.
     **
     **    6. When the whole journal receiver directory has been processed, an
     **       informational message is sent to the caller, specifying the number
     **       or journal receivers that matched the selection criteria.
     **
     **    7. The job termination procedure is unregistered and called directly
     **       to deallacate the storage previously allocated.
     **
     **
     **  Compile options:
     **    CrtRpgMod   Module( CBX959 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX959 )
     **                Module( CBX959 )
     **                ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global variables:
     D Idx             s             10u 0
     D ApiRcvSiz       s             10u 0
     D RcvRtnDat       s               d
     D SltRcv          s               n
     D NbrRcv          s             10i 0 Inz( *Zero )
     D MsgKey          s              4a
     D MsgTxt          s            512a   Varying
     D CmdStr          s            512a   Varying
     **-- Global constants:
     D OFS_MSGDTA      c                   16
     **-- Journal information:
     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OfsKeyInf                    10i 0
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  ASP                          10i 0
     D  MsgQnam                      10a
     D  MsgQlib                      10a
     D  MngRcvOpt                     1a
     D  DltRcvOpt                     1a
     D  RsoRit                        1a
     D  RsoMfl                        1a
     D  RsoMo1                        1a
     D  RsoMo2                        1a
     D  Rsv1                          3a
     D  JrnTyp                        1a
     D  RmtJrnTyp                     1a
     D  JrnStt                        1a
     D  JrnDlvMod                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  RdrRcvLib                    10a
     D  JrnTxt                       50a
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv2                          9a
     D  NbrAtcRcv                    10i 0
     D  AtcRcvNam                    10a
     D  AtcRcvLib                    10a
     D  AtcLocSys                     8a
     D  AtcSrcSys                     8a
     D  AtcRcvNamDu                  10a
     D  AtcRcvLibDu                  10a
     D  Rsv3                        192a
     D  NbrKey                       10i 0
     **
     D JrnKey          Ds                  Based( pJrnKey )  Qualified
     D  Key                          10i 0
     D  OfsKeyInf                    10i 0
     D  KeyHdrSecLn                  10i 0
     D  NbrEnt                       10i 0
     D  KeyInfEntLn                  10i 0
     **
     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
     D  RcvNbrTot                    10i 0
     D  RcvSizTot                    10i 0
     D  RcvSizMtp                    10i 0
     D  Rsv                           8a
     **
     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  RcvNbr                        5a
     D  RcvAtcDts                    13a
     D  RcvSts                        1a
     D  RcvSavDts                    13a
     D  LocJrnSys                     8a
     D  SrcJrnSys                     8a
     D  RcvSiz                       10i 0
     D  Rsv                          56a
     **-- Journal information specification:
     D JrnInfRtv       Ds                  Qualified
     D  NbrVarRcd                    10i 0 Inz( 1 )
     D  VarRcdLen                    10i 0 Inz( 12 )
     D  Key                          10i 0 Inz( 1 )
     D  DtaLen                       10i 0 Inz( 0 )
     **-- Receiver information:
     D RRCV0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  Thh                          10i 0
     D  Siz                          10i 0
     D  ASP                          10i 0
     D  NbrJrnEnt                    10i 0
     D  MaxEspDtaLn                  10i 0
     D  MaxNulInd                    10i 0
     D  FstSeqNbr                    10i 0
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv1                          2a
     D  LstSeqNbr                    10i 0
     D  Rsv2                         10i 0
     D  Status                        1a
     D  MinFxlVal                     1a
     D  RcvMaxOpt                     1a
     D  Rsv3                          4a
     D  AtcDts                       13a
     D  DtcDts                       13a
     D   DtcDat                       7a   Overlay( DtcDts: 1 )
     D   DtcTim                       6a   Overlay( DtcDts: *Next )
     D  SavDts                       13a
     D   SavDat                       7a   Overlay( SavDts: 1 )
     D   SavTim                       6a   Overlay( SavDts: *Next )
     D  Txt                          50a
     D  PndTrn                        1a
     D  RmtJrnTyp                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  LocRcvLib                    10a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  SrcRcvLib                    10a
     D  RdcRcvLib                    10a
     D  DuaRcvNam                    10a
     D  DuaRcvLib                    10a
     D  PrvRcvNam                    10a
     D  PrvRcvLib                    10a
     D  PrvRcvNamDu                  10a
     D  PrvRcvLibDu                  10a
     D  NxtRcvNam                    10a
     D  NxtRcvLib                    10a
     D  NxtRcvNamDu                  10a
     D  NxtRcvLibDu                  10a
     D  NbrJrnEntL                   20s 0
     D  MaxEspDtlL                   20s 0
     D  FstSeqNbrL                   20s 0
     D  LstSeqNbrL                   20s 0
     D  AspDevNam                    10a
     D  LocJrnAspGn                  10a
     D  SrcJrnAspGn                  10a
     D  FldJob                        1a
     D  FldUsr                        1a
     D  FldPgm                        1a
     D  FldPgmLib                     1a
     D  FldSysSeq                     1a
     D  FldRmtAdr                     1a
     D  FldThd                        1a
     D  FldLuw                        1a
     D  FldXid                        1a
     D  Rsv4                         21a
     **-- Retrieve journal information:
     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
     D                                     Information' )
     D  JiRcvVar                  65535a         Options( *VarSize )
     D  JiRcvVarLen                  10i 0 Const
     D  JiJrnNam                     20a   Const
     D  JiFmtNam                      8a   Const
     D  JiInfRtv                  65535a   Const Options( *VarSize )
     D  JiError                   32767a         Options( *VarSize: *Omit )
     **-- Retrieve journal receiver information:
     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
     D                                     Information' )
     D  RiRcvVar                  65535a         Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiRcvNam                     20a   Const
     D  RiFmtNam                      8a   Const
     D  RiError                   32767a         Options( *VarSize: *Omit )
     **-- Register termination exit:
     D CeeRtx          Pr                    ExtProc( 'CEERTX' )
     D  procedure                      *     ProcPtr   Const
     D  token                          *     Options( *Omit )
     D  fb                           12a     Options( *Omit )
     **-- Unregister termination exit:
     D CeeUtx          Pr                    ExtProc( 'CEEUTX' )
     D  procedure                      *     ProcPtr   Const
     D  fb                           12a     Options( *Omit )
     **-- Process commands:
     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
     D  PcSrcCmdLen                  10i 0 Const
     D  PcOptCtlBlk                  20a   Const
     D  PcOptCtlBlkLn                10i 0 Const
     D  PcOptCtlBlkFm                 8a   Const
     D  PcChgCmd                  32767a          Options( *VarSize )
     D  PcChgCmdLen                  10i 0 Const
     D  PcChgCmdLenAv                10i 0
     D  PcError                   32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                   32767a          Options( *VarSize )
     **-- Move program messages:
     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
     D  MpMsgKey                      4a   Const
     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
     D  MpNbrMsgTyps                 10i 0 Const
     D  MpToCalStkE                4102a   Const  Options( *VarSize )
     D  MpToCalStkCnt                10i 0 Const
     D  MpError                   32767a          Options( *VarSize )
     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )

     **-- Process command:
     D PrcCmd          Pr            10i 0
     D  CmdStr                     1024a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send message by type:
     D SndMsgTyp       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const
     **-- Terminate program:
     D TrmPgm          Pr
     D  pPtr                           *

     **-- Entry parameters:
     D ObjNam_q        Ds                  Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     **
     D ObjNam_e        Ds                  Qualified
     D  NbrObj                        5i 0
     D  ObjNam_q                           LikeDs( ObjNam_q )  Dim( 2 )
     **
     D CBX959          Pr
     D  PxJrnNam_q                         LikeDs( ObjNam_q )
     D  PxRcvRtnDays                  5i 0
     D  PxRcvRtnNbr                   5i 0
     D  PxForce                       3a
     D  PxChgJrn                      3a
     D  PxJrnRcv                           LikeDs( ObjNam_e )
     D  PxSeqOpt                      6a
     **
     D CBX959          Pi
     D  PxJrnNam_q                         LikeDs( ObjNam_q )
     D  PxRcvRtnDays                  5i 0
     D  PxRcvRtnNbr                   5i 0
     D  PxForce                       3a
     D  PxChgJrn                      3a
     D  PxJrnRcv                           LikeDs( ObjNam_e )
     D  PxSeqOpt                      6a

      /Free

        ExSr  InzParms;

        If  PxChgJrn = 'YES';
          ExSr  ChgJrnRcv;
        EndIf;

        ApiRcvSiz = 65535;
        pJrnInf   = %Alloc( ApiRcvSiz );
        RJRN0100.BytAvl = *Zero;

        DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
             ERRC0100.BytAvl  > *Zero;

          If  RJRN0100.BytAvl > ApiRcvSiz;
            ApiRcvSiz  = RJRN0100.BytAvl;
            pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
          EndIf;

          RtvJrnInf( RJRN0100
                   : ApiRcvSiz
                   : PxJrnNam_q
                   : 'RJRN0100'
                   : JrnInfRtv
                   : ERRC0100
                   );
        EndDo;

        CeeRtx( %Paddr( TrmPgm ): pJrnInf: *Omit );

        If  ERRC0100.BytAvl > *Zero;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );
        Else;

          ExSr  PrcKeyEnt;
          ExSr  SndCmpMsg;
        EndIf;

        CeeUtx( %Paddr( TrmPgm ): *Omit );

        TrmPgm( pJrnInf );

        Return;


        BegSr PrcKeyEnt;

          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );

          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );

          For  Idx = 1  to JrnKey.NbrEnt;

            RtvRcvInf( RRCV0100
                     : %Size( RRCV0100 )
                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
                     : 'RRCV0100'
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;
              ExSr  PrcLstEnt;
            EndIf;

            If  Idx < JrnKey.NbrEnt;
              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
            EndIf;
          EndFor;

        EndSr;

        BegSr  InzParms;

          If  PxRcvRtnDays = -1;
            RcvRtnDat = %Date() + %Days(1);
          Else;
            RcvRtnDat = %Date() - %Days( PxRcvRtnDays );
          EndIf;

        EndSr;

        BegSr  PrcLstEnt;

          SltRcv = *On;

          Select;
          When  RRCV0100.Status = '1';
            SltRcv = *Off;

          When  PxRcvRtnNbr > -1        And
                PxRcvRtnNbr > JrnKey.NbrEnt - Idx;
            SltRcv = *Off;

          When  RRCV0100.DtcDat = *Zeros  Or  RRCV0100.DtcDat = *Blanks;
            SltRcv = *Off;

          When  RcvRtnDat <= %Date( RRCV0100.DtcDat: *CYMD0 );
            SltRcv = *Off;

          When  PxForce = 'NO'          And
                RRCV0100.Status <> '3'  And
                RRCV0100.Status <> '4';

            SltRcv = *Off;
          EndSl;

          If  SltRcv = *On;
            ExSr  DltJrnRcv;
          EndIf;

        EndSr;

        BegSr  DltJrnRcv;

          CmdStr = 'DLTJRNRCV JRNRCV('      +
                   %Trim( RRCV0100.RcvLib ) + '/' +
                   %Trim( RRCV0100.RcvNam ) + ')';

          If  PxForce = 'YES';
            CmdStr += ' DLTOPT(*IGNINQMSG *IGNTGTRCV)';
          Else;
            CmdStr += ' DLTOPT(*IGNINQMSG)';
          EndIf;

          If  PrcCmd( CmdStr) < *Zero;
            SndEscMsg( 'CPF0001': 'QCPFMSG': 'DLTJRNRCV' );
          Else;
            NbrRcv += 1;
          EndIf;

        EndSr;

        BegSr  ChgJrnRcv;

          If  PxJrnRcv.ObjNam_q(1).ObjNam = '*GEN';
            PxJrnRcv.ObjNam_q(1).ObjLib = '*N';
          EndIf;

          CmdStr = 'CHGJRN JRN('                       +
                   %Trim( PxJrnNam_q.ObjLib )          + '/'  +
                   %Trim( PxJrnNam_q.ObjNam )          + ') ' +
                   'JRNRCV('                           +
                   %Trim( PxJrnRcv.ObjNam_q(1).ObjLib ) + '/'  +
                   %Trim( PxJrnRcv.ObjNam_q(1).ObjNam ) + ') ' +
                   'SEQOPT('                           +
                   %Trim( PxSeqOpt )                   + ')';

          If  PrcCmd( CmdStr) < *Zero;
            SndEscMsg( 'CPF0001': 'QCPFMSG': 'CHGJRN' );
          EndIf;

        EndSr;

        BegSr  SndCmpMsg;

          MsgTxt = %Char( NbrRcv ) + ' journal receivers met the ' +
                   'selection criteria and were deleted.';

          SndMsgTyp( MsgTxt: '*COMP' );

        EndSr;

      /End-Free

     **-- Process command:  --------------------------------------------------**
     P PrcCmd          B                   Export
     D                 Pi            10i 0
     D  PxCmdStr                   1024a   Const  Varying
     **
     D CPOP0100        Ds                  Qualified
     D  TypPrc                       10i 0 Inz( 2 )
     D  DBCS                          1a   Inz( '0' )
     D  PmtAct                        1a   Inz( '2' )
     D  CmdStx                        1a   Inz( '0' )
     D  MsgRtvKey                     4a   Inz( *Allx'00' )
     D  Rsv                           9a   Inz( *Allx'00' )
     **
     D ChgCmd          s           2048a
     D ChgCmdAvl       s             10i 0
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( *Zero )
     **

      /Free

        CallP(e) PrcCmds( PxCmdStr
                        : %Len( PxCmdStr )
                        : CPOP0100
                        : %Size( CPOP0100 )
                        : 'CPOP0100'
                        : ChgCmd
                        : %Size( ChgCmd )
                        : ChgCmdAvl
                        : ERRC0100
                        );

        If  %Error;

          Return -1;
        Else;

          MovPgmMsg( *Blanks
                   : '*COMP'
                   : 1
                   : '*PGMBDY'
                   : 1
                   : ERRC0100
                   );

          Return 0;
        EndIf;

      /End-Free

     P PrcCmd          E
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
     **-- Send message by type:  ---------------------------------------------**
     P SndMsgTyp       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : PxMsgTyp
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndMsgTyp       E
     **-- Terminate program:  ------------------------------------------------**
     P TrmPgm          B
     D                 Pi
     D  pPtr                           *

      /Free

        DeAlloc  pPtr;

        *InLr = *On;

        Return;

      /End-Free

     P TrmPgm          E
