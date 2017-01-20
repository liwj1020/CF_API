     **
     **  Program . . : CBX951
     **  Description : List user's authorization list entries
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX951 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX951 )
     **                Module( CBX951 )
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
     D USR_SPC_Q       c                   'AUTOBJLST QTEMP'
     D OFS_MSGDTA      c                   16
     **-- Global variables:
     D Idx             s             10i 0
     D CntHdl          s             20a   Inz

     **-- Entry format OBJA0200:
     D OBJA0200        Ds                  Qualified  Based( pLstEnt )
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  AutHlr                        1a
     D  ObjOwn                        1a
     D  AutVal                       10a
     D  AutlMgt                       1a
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
     D  AspDevLib                    10a
     D  AspDevObj                    10a
     **-- Entry format OBJA0210:
     D OBJA0210        Ds          5120    Qualified  Based( pLstEnt )
     D  OfsPthNam                    10i 0
     D  LenPthNam                    10i 0
     D  ObjTyp                       10a
     D  AutHlr                        1a
     D  ObjOwn                        1a
     D  AutVal                       10a
     D  AutlMgt                       1a
     D  ObjOpr                        1a
     D  ObjMgt                        1a
     D  ObjExs                        1a
     D  ObjAlt                        1a
     D  ObjRef                        1a
     D                               10a
     D  DtaRead                       1a
     D  DtaAdd                        1a
     D  DtaUpd                        1a
     D  DtaDlt                        1a
     D  DtaExe                        1a
     D  AspDevNam                    10a
     **
     D Path            Ds                  Qualified  Based( pPath )
     D  PthCcsId                     10i 0
     D  CtrRegId                      2a
     D  LngId                         3a
     D                                3a
     D  FlgByt                       10i 0
     D  PthNamLen                    10i 0
     D  PthDlm                        2a
     D                               10a
     D  PthNam                     5000a
     **
     D PthNam          s           5000a   Varying
     **-- API input parameter information:
     D InpPrm          Ds                  Qualified  Based( pInpPrm )
     D  UsrSpc                       10a
     D  UsrSpcLib                    10a
     D  FmtNam                        8a
     D  UsrPrf                       10a
     D  ObjTyp                       10a
     D  RtnObj                       10a
     D  CntHdl                       20a
     D  OfsRqsLst                    10i 0
     D  NbrLstEnt                    10i 0
     D  RqsLst                       30a
     **-- API header information:
     D HdrInf          Ds                  Qualified  Based( pHdrInf )
     D  UsrPrf                       10a
     D  CntHdl                       20a
     D  RsnCod                       10i 0
     **-- User space generic header:
     D UsrSpc          Ds                  Qualified  Based( pUsrSpc )
     D  HdrSiz                       10i 0 Overlay( UsrSpc:  65 )
     D  RelLvl                        4a   Overlay( UsrSpc:  69 )
     D  FmtNam                        8a   Overlay( UsrSpc:  73 )
     D  ApiNam                       10a   Overlay( UsrSpc:  81 )
     D  CrtDtm                       13a   Overlay( UsrSpc:  91 )
     D  InfSts                        1a   Overlay( UsrSpc: 104 )
     D  UsrSpcSiz                    10i 0 Overlay( UsrSpc: 105 )
     D  OfsInp                       10i 0 Overlay( UsrSpc: 109 )
     D  SizInp                       10i 0 Overlay( UsrSpc: 113 )
     D  OfsHdr                       10i 0 Overlay( UsrSpc: 117 )
     D  SizHdr                       10i 0 Overlay( UsrSpc: 121 )
     D  OfsLst                       10i 0 Overlay( UsrSpc: 125 )
     D  SizLst                       10i 0 Overlay( UsrSpc: 129 )
     D  NumLstEnt                    10i 0 Overlay( UsrSpc: 133 )
     D  SizLstEnt                    10i 0 Overlay( UsrSpc: 137 )
     D  LstCcsId                     10i 0 Overlay( UsrSpc: 141 )
     D  CtrRegId                      2a   Overlay( UsrSpc: 145 )
     D  LngId                         3a   Overlay( UsrSpc: 147 )
     D  SubSetInd                     1a   Overlay( UsrSpc: 149 )
     **-- Space pointers:
     D pUsrSpc         s               *   Inz( *Null )
     D pInpPrm         s               *   Inz( *Null )
     D pHdrInf         s               *   Inz( *Null )
     D pLstEnt         s               *   Inz( *Null )

     **-- List authorized users:
     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
     D  LuSpcNamQ                    20a   Const
     D  LuFmtNam                      8a   Const
     D  LuUsrPrf                     10a   Const
     D  LuObjTyp                     10a   Const
     D  LuRtnObj                     10a   Const
     D  LuCntHdl                     20a   Const
     D  LuError                   32767a          Options( *VarSize )
     D  LuRqsLst                     30a          Options( *VarSize: *NoPass )
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

     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX9512         Pr
     D  PxUsrPrf                     10a
     **
     D CBX9512         Pi
     D  PxUsrPrf                     10a

      /Free

        CrtUsrSpc( USR_SPC_Q
                 : *Blanks
                 : 65535
                 : x'00'
                 : '*CHANGE'
                 : *Blanks
                 : '*YES'
                 : ERRC0100
                 );

        RtvPtrSpc( USR_SPC_Q: pUsrSpc );

        DoU  CntHdl = *Blanks;

          LstUsrObj( USR_SPC_Q
                   : 'OBJA0210'
                   : PxUsrPrf
                   : '*ALL'
                   : '*OBJOWN'
                   : CntHdl
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl > *Zero;

            Leave;
          Else;

            ExSr  GetUsrObj;
          EndIf;
        EndDo;

        DltUsrSpc( USR_SPC_Q: ERRC0100 );

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl-OFS_MSGDTA )
                   );
        Else;

          SndCmpMsg( 'Command completed normally.' );
        EndIf;

        *InLr = *On;
        Return;


        BegSr  GetUsrObj;

          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          For  Idx = 1  To  UsrSpc.NumLstEnt;

            pPath = pUsrSpc + OBJA0210.OfsPthNam;
            PthNam = %Subst( Path.PthNam: 1: Path.PthNamLen );

            If  Idx < UsrSpc.NumLstEnt;
              pLstEnt += UsrSpc.SizLstEnt + OBJA0210.LenPthNam;
            EndIf;
          EndFor;

          CntHdl = InpPrm.CntHdl;

        EndSr;

      /End-Free

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
