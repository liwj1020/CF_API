     **
     **  Program . . : CBX931
     **  Description : Change object authority - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will replace the specified user's authority to the
     **    selected objects with the specified new authority.
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX931 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX931 )
     **                Module( CBX931 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )
     **-- System information:
     D PgmSts         sDs                  Qualified
     D  JobUsr                       10a   Overlay( PgmSts: 254 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global constants:
     D USR_SPC_Q       c                   'AUTLST    QTEMP'
     D OFS_MSGDTA      c                   16
     D NBR_KEY         c                   2
     **-- Global variables:
     D Idx             s             10i 0
     D ObjCntSlt       s             10i 0 Inz( *Zero )
     D ObjCntIgn       s             10i 0 Inz( *Zero )
     D NewAutL         s            110a   Varying
     **
     D CmpAut          Ds                  LikeDs( USRA0100 )
     **
     D CurAut          Ds                  Qualified
     D  NbrAut                        5i 0
     D  AutVal                       10a   Dim( 10 )
     **
     D NewAut          Ds                  Qualified
     D  NbrAut                        5i 0
     D  AutVal                       10a   Dim( 10 )
     **-- Entry format USRA0100:
     D USRA0100        Ds                  Qualified  Based( pLstEnt )
     D  UsrPrf                       10a
     D  AutVal                       10a
     D  AutLstMgt                     1a
     D  ObjOpr                        1a
     D  ObjMgt                        1a
     D  ObjExs                        1a
     D  DtaRead                       1a
     D  DtaAdd                        1a
     D  DtaUpd                        1a
     D  DtaDlt                        1a
     D  DtaExe                        1a
     D                               10a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     **-- USRA0100 - header information:
     D HdrInf          Ds                  Qualified  Based( pHdrInf )
     D  ObjNam                       10a
     D  LibNam                       10a
     D  ObjTyp                       10a
     D  OwnNam                       10a
     D  AutL                         10a
     D  PriGrp                       10a
     D  FldAut                        1a
     D  AspDevLib                    10a
     D  AspDevObj                    10a
     **-- User space generic header:
     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
     **-- Space pointers:
     D pUsrSpc         s               *   Inz( *Null )
     D pHdrInf         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( NBR_KEY )
     D  ObjTyp                       10a
     **-- Object information:
     D ObjInf          Ds          4096    Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  InfSts                        1a
     D                                1a
     D  FldNbrRtn                    10i 0
     D  Data                               Like( KeyInf )
     **-- Key information:
     D KeyInf          Ds                  Qualified  Based( pKeyInf )
     D  FldInfLen                    10i 0
     D  KeyFld                       10i 0
     D  DtaTyp                        1a
     D                                3a
     D  DtaLen                       10i 0
     D  Data                        256a
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a
     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 0 )
     D  SrtInf                       12a   Dim( 10 )
     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
     D   Rsv                          1a   Overlay( SrtInf: *Next )
     **-- Authority control:
     D AutCtl          Ds                  Qualified
     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
     D  CalLvl                       10i 0 Inz( 0 )
     D  DplObjAut                    10i 0 Inz( 0 )
     D  NbrObjAut                    10i 0 Inz( 0 )
     D  DplLibAut                    10i 0 Inz( 0 )
     D  NbrLibAut                    10i 0 Inz( 0 )
     D                               10i 0 Inz( 0 )
     D  ObjAut                       10a   Dim( 10 )
     D  LibAut                       10a   Dim( 10 )
     **-- Selection control:
     D SltCtl          Ds
     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
     D  SltOmt                       10i 0 Inz( 0 )
     D  DplSts                       10i 0 Inz( 20 )
     D  NbrSts                       10i 0 Inz( 1 )
     D                               10i 0 Inz( 0 )
     D  Status                        1a   Inz( '*' )
     **-- Object information key fields:
     D KEY0200         Ds                  Qualified
     D  InfSts                        1a
     D  ExtObjAtr                    10a
     D  TxtDsc                       50a
     D  UsrDfnAtr                    10a
     D  OrdLibL                      10i 0
     D                                5a
     **
     D ObjOwn          s             10a
     **-- Open list of objects:
     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
     D  LoRcvVar                  65535a          Options( *VarSize )
     D  LoRcvVarLen                  10i 0 Const
     D  LoLstInf                     80a
     D  LoNbrRcdRtn                  10i 0 Const
     D  LoSrtInf                   1024a   Const  Options( *VarSize )
     D  LoObjNam_q                   20a   Const
     D  LoObjTyp                     10a   Const
     D  LoAutCtl                   1024a   Const  Options( *VarSize )
     D  LoSltCtl                   1024a   Const  Options( *VarSize )
     D  LoNbrKeyRtn                  10i 0 Const
     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  LoError                    1024a          Options( *VarSize )
     **
     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
     **
     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  GlRcvVar                  65535a          Options( *VarSize )
     D  GlRcvVarLen                  10i 0 Const
     D  GlHandle                      4a   Const
     D  GlLstInf                     80a
     D  GlNbrRcdRtn                  10i 0 Const
     D  GlRtnRcdNbr                  10i 0 Const
     D  GlError                    1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  ClHandle                      4a   Const
     D  ClError                    1024a          Options( *VarSize )
     **-- List authorized users:
     D LstAutUsr       Pr                  ExtPgm( 'QSYLUSRA' )
     D  LaSpcNamQ                    20a   Const
     D  LaFmtNam                      8a   Const
     D  LaObjNamQ                    20a   Const
     D  LaObjTyp                     10a   Const
     D  LaError                   32767a          Options( *VarSize )
     D  LaAspDev                     10a          Options( *NoPass )
     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  CsSpcNamQ                    20a   Const
     D  CsExtAtr                     10a   Const
     D  CsInzSiz                     10i 0 Const
     D  CsInzVal                      1a   Const
     D  CsPubAut                     10a   Const
     D  CsText                       50a   Const
     D  CsReplace                    10a   Const  Options( *NoPass )
     D  CsError                   32767a          Options( *NoPass: *VarSize )
     D  CsDomain                     10a   Const  Options( *NoPass )
     D  CsTfrSizRqs                  10i 0 Const  Options( *NoPass )
     D  CsOptSpcAlg                   1a   Const  Options( *NoPass )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  RpSpcNamQ                    20a   Const
     D  RpPointer                      *
     D  RpError                   32767a          Options( *NoPass: *VarSize )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  DsSpcNamQ                    20a   Const
     D  DsError                   32767a          Options( *VarSize )
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
     D  SpError                    1024a          Options( *VarSize )

     **-- Compare authority values:
     D CmpAutVal       Pr              n
     D  PxAutVal1                          LikeDs( USRA0100 )
     D  PxAutVal2                          LikeDs( USRA0100 )
     **-- Process command:
     D PrcCmd          Pr             7a
     D  CmdStr                     1024a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX931          Pr
     D  PxObjNam_q                   20a
     D  PxObjTyp                      7a
     D  PxUsrPrf                     10a
     D  PxCurAut                           LikeDs( CurAut )
     D  PxNewAut                           LikeDs( NewAut )
     **
     D CBX931          Pi
     D  PxObjNam_q                   20a
     D  PxObjTyp                      7a
     D  PxUsrPrf                     10a
     D  PxCurAut                           LikeDs( CurAut )
     D  PxNewAut                           LikeDs( NewAut )

      /Free

        If  PxUsrPrf = '*CURRENT';
          PxUsrPrf = PgmSts.CurUsr;
        EndIf;

        LstApi.KeyFld(1) = 200;
        LstApi.KeyFld(2) = 302;

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        LstApi.RtnRcdNbr = 1;

        LstObjs( ObjInf
               : %Size( ObjInf )
               : LstInf
               : 1
               : SrtInf
               : PxObjNam_q
               : PxObjTyp
               : AutCtl
               : SltCtl
               : LstApi.NbrKeyRtn
               : LstApi.KeyFld
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                   );
        Else;

          CrtUsrSpc( USR_SPC_Q
                   : *Blanks
                   : 65535
                   : x'00'
                   : '*CHANGE'
                   : *Blanks
                   : '*YES'
                   : ERRC0100
                   );

          DoW  LstInf.LstSts <> '2'  Or
               LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

            ExSr  GetKeyDta;
            ExSr  ChkObjAut;

            LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

            GetLstEnt( ObjInf
                     : %Size( ObjInf )
                     : LstInf.Handle
                     : LstInf
                     : 1
                     : LstApi.RtnRcdNbr
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl > *Zero;
              Leave;
            EndIf;

          EndDo;

          DltUsrSpc( USR_SPC_Q: ERRC0100 );
        EndIf;

        CloseLst( LstInf.Handle: ERRC0100 );

        SndCmpMsg( 'Command completed normally. ' + %Char( ObjCntSlt ) +
                   ' objects changed. '           + %Char( ObjCntIgn ) +
                   ' objects not changed.'
                 );

        *InLr = *On;
        Return;


        BegSr  GetKeyDta;

          pKeyInf = %Addr( ObjInf.Data );

          For  Idx = 1  To  ObjInf.FldNbrRtn;

            Select;
            When  KeyInf.KeyFld = 200;
              KEY0200 = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 302;
              ObjOwn = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
            EndSl;

            If  Idx < ObjInf.FldNbrRtn;
              pKeyInf = pKeyInf + KeyInf.FldInfLen;
            EndIf;
          EndFor;

        EndSr;

        BegSr  ChkObjAut;

          LstAutUsr( USR_SPC_Q
                   : 'USRA0100'
                   : ObjInf.ObjNam + ObjInf.ObjLib
                   : ObjInf.ObjTyp
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;

            RtvPtrSpc( USR_SPC_Q: pUsrSpc );

            ExSr  ChkUsrAut;
          EndIf;

        EndSr;

        BegSr  ChkUsrAut;

          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          For  Idx = 1  To  UsrSpc.NumLstEnt;

            If  USRA0100.UsrPrf = PxUsrPrf;

              If  CmpAutVal( USRA0100: CmpAut ) = *On;

                PrcCmd( 'GRTOBJAUT OBJ(' + %Trim( ObjInf.ObjLib ) + '/'  +
                                           %Trim( ObjInf.ObjNam ) + ') ' +
                              'OBJTYPE(' + %Trim( ObjInf.ObjTyp ) + ') ' +
                              'USER('    + %Trim( PxUsrPrf )      + ') ' +
                              'AUT('     + %Trim( NewAutL )       + ') ' +
                              'REPLACE(*YES)'
                      );

                ObjCntSlt += 1;
              Else;
                ObjCntIgn += 1;
              EndIf;

              Leave;
            EndIf;

            If  Idx < UsrSpc.NumLstEnt;
              pLstEnt = pLstEnt + UsrSpc.SizLstEnt;
            EndIf;
          EndFor;

        EndSr;

        BegSr  ChkAutVal;

        EndSr;

        BegSr  *InzSr;

          NewAutL = PxNewAut.AutVal(1);

          For  Idx = 2  To  PxNewAut.NbrAut;
            NewAutL += ' ' + PxNewAut.AutVal(Idx);
          EndFor;

          CmpAut.ObjOpr  = 'N';
          CmpAut.ObjMgt  = 'N';
          CmpAut.ObjExs  = 'N';
          CmpAut.ObjAlt  = 'N';
          CmpAut.ObjRef  = 'N';
          CmpAut.DtaRead = 'N';
          CmpAut.DtaAdd  = 'N';
          CmpAut.DtaUpd  = 'N';
          CmpAut.DtaDlt  = 'N';
          CmpAut.DtaExe  = 'N';

          For  Idx = 1  To  PxCurAut.NbrAut;

            Select;
            When  PxCurAut.AutVal(Idx) = '*ALL';
              CmpAut.ObjOpr  = 'Y';
              CmpAut.ObjMgt  = 'Y';
              CmpAut.ObjExs  = 'Y';
              CmpAut.ObjAlt  = 'Y';
              CmpAut.ObjRef  = 'Y';
              CmpAut.DtaRead = 'Y';
              CmpAut.DtaAdd  = 'Y';
              CmpAut.DtaUpd  = 'Y';
              CmpAut.DtaDlt  = 'Y';
              CmpAut.DtaExe  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*CHANGE';
              CmpAut.ObjOpr  = 'Y';
              CmpAut.DtaRead = 'Y';
              CmpAut.DtaAdd  = 'Y';
              CmpAut.DtaUpd  = 'Y';
              CmpAut.DtaDlt  = 'Y';
              CmpAut.DtaExe  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*USE';
              CmpAut.ObjOpr  = 'Y';
              CmpAut.DtaRead = 'Y';
              CmpAut.DtaExe  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*EXCLUDE';

            When  PxCurAut.AutVal(Idx) = '*OBJOPR';
              CmpAut.ObjOpr  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*OBJMGT';
              CmpAut.ObjMgt  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*OBJEXIST';
              CmpAut.ObjExs  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*OBJALTER';
              CmpAut.ObjAlt  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*OBJREF';
              CmpAut.ObjRef  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*READ';
              CmpAut.DtaRead = 'Y';

            When  PxCurAut.AutVal(Idx) = '*ADD';
              CmpAut.DtaAdd  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*UPD';
              CmpAut.DtaUpd  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*DLT';
              CmpAut.DtaDlt  = 'Y';

            When  PxCurAut.AutVal(Idx) = '*EXECUTE';
              CmpAut.DtaExe  = 'Y';
            EndSl;
          EndFor;

        EndSr;

      /End-Free

     **-- Compare authority values:  -----------------------------------------**
     P CmpAutVal       B
     D                 Pi              n
     D  PxAutVal1                          LikeDs( USRA0100 )
     D  PxAutVal2                          LikeDs( USRA0100 )

      /Free

        If  %Subst( PxAutVal1: 22 ) = %Subst( PxAutVal2: 22 );
          Return  *On;
        Else;
          Return  *Off;
        EndIf;

      /End-Free

     P CmpAutVal       E
     **-- Process command:  --------------------------------------------------**
     P PrcCmd          B
     D                 Pi             7a
     D  PxCmdStr                   1024a   Const  Varying
     **-- Local variables:
     D CpOptCtlBlk     Ds
     D  CpTypPrc                     10i 0 Inz( 2 )
     D  CpDBCS                        1a   Inz( '0' )
     D  CpPmtAct                      1a   Inz( '2' )
     D  CpCmdStx                      1a   Inz( '0' )
     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
     D  CpRsv                         9a   Inz( *Allx'00' )
     **
     D CpChgCmd        s          32767a
     D CpChgCmdAvl     s             10i 0

      /Free

        PrcCmds( PxCmdStr
               : %Len( PxCmdStr )
               : CpOptCtlBlk
               : %Size( CpOptCtlBlk )
               : 'CPOP0100'
               : CpChgCmd
               : %Size( CpChgCmd )
               : CpChgCmdAvl
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  ERRC0100.MsgId;
        Else;
          Return  *Blanks;
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
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     **
     P SndCmpMsg       E
