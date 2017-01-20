     **
     **  Program . . : CBX9562
     **  Description : List user's objects
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX9562 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX9562 )
     **                Module( CBX9562 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

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

     **-- Entry format OBJA0100:
     D OBJA0100        Ds                  Qualified  Based( pLstEnt )
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  AutHlr                        1a
     D  ObjOwn                        1a
     D  AspDevLib                    10a
     D  AspDevObj                    10a
     **-- Entry format OBJA0110:
     D OBJA0110        Ds          5120    Qualified  Based( pLstEnt )
     D  OfsPthNam                    10i 0
     D  LenPthNam                    10i 0
     D  ObjTyp                       10a
     D  AutHlr                        1a
     D  ObjOwn                        1a
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

     **-- List user objects:
     D LstUsrObj       Pr                  ExtPgm( 'QSYLOBJA' )
     D  SpcNamQ                      20a   Const
     D  FmtNam                        8a   Const
     D  UsrPrf                       10a   Const
     D  ObjTyp                       10a   Const
     D  RtnObj                       10a   Const
     D  CntHdl                       20a   Const
     D  Error                     32767a          Options( *VarSize )
     D  RqsLst                       30a          Options( *VarSize: *NoPass )
     **-- Create user space:
     D CrtUsrSpc       Pr                  ExtPgm( 'QUSCRTUS' )
     D  SpcNamQ                      20a   Const
     D  ExtAtr                       10a   Const
     D  InzSiz                       10i 0 Const
     D  InzVal                        1a   Const
     D  PubAut                       10a   Const
     D  Text                         50a   Const
     D  Replace                      10a   Const  Options( *NoPass )
     D  Error                     32767a          Options( *NoPass: *VarSize )
     D  Domain                       10a   Const  Options( *NoPass )
     D  TfrSizRqs                    10i 0 Const  Options( *NoPass )
     D  OptSpcAlg                     1a   Const  Options( *NoPass )
     **-- Retrieve pointer to user space:
     D RtvPtrSpc       Pr                  ExtPgm( 'QUSPTRUS' )
     D  SpcNamQ                      20a   Const
     D  Pointer                        *
     D  Error                     32767a          Options( *NoPass: *VarSize )
     **-- Delete user space:
     D DltUsrSpc       Pr                  ExtPgm( 'QUSDLTUS' )
     D  SpcNamQ                      20a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                      1024a          Options( *VarSize )

     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX9562         Pr
     D  PxUsrPrf                     10a
     **
     D CBX9562         Pi
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
                   : 'OBJA0100'
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

        DoU  CntHdl = *Blanks;

          LstUsrObj( USR_SPC_Q
                   : 'OBJA0110'
                   : PxUsrPrf
                   : '*ALL'
                   : '*OBJOWN'
                   : CntHdl
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl > *Zero;

            Leave;
          Else;

            ExSr  GetUsrFil;
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


            If  Idx < UsrSpc.NumLstEnt;
              pLstEnt += UsrSpc.SizLstEnt;
            EndIf;
          EndFor;

          CntHdl = HdrInf.CntHdl;

        EndSr;

        BegSr  GetUsrFil;

          pInpPrm = pUsrSpc + UsrSpc.OfsInp;
          pHdrInf = pUsrSpc + UsrSpc.OfsHdr;
          pLstEnt = pUsrSpc + UsrSpc.OfsLst;

          For  Idx = 1  To  UsrSpc.NumLstEnt;

            pPath = pUsrSpc + OBJA0110.OfsPthNam;
            PthNam = %Subst( Path.PthNam: 1: Path.PthNamLen );

            If  Idx < UsrSpc.NumLstEnt;
              pLstEnt += UsrSpc.SizLstEnt + OBJA0110.LenPthNam;
            EndIf;
          EndFor;

          CntHdl = HdrInf.CntHdl;

        EndSr;

      /End-Free

     **-- Send escape message:
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
     **-- Send completion message:
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

     P SndCmpMsg       E
