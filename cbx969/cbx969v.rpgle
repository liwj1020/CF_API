     **
     **  Program . . : CBX969V
     **  Description : Work with jobs - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **  Program description:
     **    This program checks the existence of the specified object.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX969V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX969V )
     **              Module( CBX969V )
     **              ActGrp( *CALLER )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  ExcpId                        7a
     D                                1a
     D  ExcpDta                     512a
     **-- Global constants:
     D NULL            c                   ''

     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  ObjNamQ                      20a   Const
     D  ObjTyp                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve message description:
     D RtvMsgD         Pr                  ExtPgm( 'QMHRTVM' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  RplSubVal                    10a   Const
     D  RtnFmtChr                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  RtvOpt                       10a   Const  Options( *NoPass )
     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
     D  DtaCcsId                     10i 0 Const  Options( *NoPass )
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

     **-- Check object existence:
     D ChkObj          Pr              n
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Retrieve message:
     D RtvMsg          Pr          4096a   Varying
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D Period          Ds                  Based( pNull )
     D  NbrElm                        5i 0
     D  OfsElm1                       5i 0
     D  OfsElm2                       5i 0
     D  NbrEnd                        5i 0
     D  TimEnd                        6a
     D  DatEnd                        7a
     D  NbrBeg                        5i 0
     D  TimBeg                        6a
     D  DatBeg                        7a
     **
     D CBX969V         Pr
     D  PxJobNam                     10a
     D  PxUsrPrf                     10a
     D  PxJobSts                     10a
     D  PxJobTyp                      1a
     D  PxCurUsr                     10a
     D  PxCmpSts                     10a
     D  PxPeriod                           LikeDs( Period )
     **
     D CBX969V         Pi
     D  PxJobNam                     10a
     D  PxUsrPrf                     10a
     D  PxJobSts                     10a
     D  PxJobTyp                      1a
     D  PxCurUsr                     10a
     D  PxCmpSts                     10a
     D  PxPeriod                           LikeDs( Period )

      /Free

        If  %Scan( '*': PxUsrPrf ) = *Zero;

          If  ChkObj( PxUsrPrf + 'QSYS': '*USRPRF' ) = *Off;

            SndDiagMsg( 'CPD0006'
                      : '0000' +
                        RtvMsg( 'CPF2204': PxUsrPrf )
                      );

            SndEscMsg( 'CPF0002': '' );
          EndIf;
        EndIf;

        If  PxCurUsr > *Blanks;

          If  ChkObj( PxCurUsr + 'QSYS' : '*USRPRF' ) = *Off;

            SndDiagMsg( 'CPD0006'
                      : '0000' +
                        RtvMsg( 'CPF2204': PxUsrPrf )
                      );

            SndEscMsg( 'CPF0002': '' );
          EndIf;
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Check object existence:  -------------------------------------------**
     P ChkObj          B                   Export
     D                 Pi              n
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **
     D OBJD0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a

      /Free

         RtvObjD( OBJD0100
                : %Size( OBJD0100 )
                : 'OBJD0100'
                : PxObjNam_q
                : PxObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Off;

         Else;
           Return  *On;
         EndIf;

      /End-Free

     P ChkObj          E
     **-- Retrieve message:
     P RtvMsg          B
     D                 Pi          4096a   Varying
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D RTVM0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RtnMsgLen                    10i 0
     D  RtnMsgAvl                    10i 0
     D  RtnHlpLen                    10i 0
     D  RtnHlpAvl                    10i 0
     D  Msg                        4096a
     **
     D RPL_SUB_VAL     c                   '*YES'
     D NOT_FMT_CTL     c                   '*NO'

      /Free

        RtvMsgD( RTVM0100
               : %Size( RTVM0100 )
               : 'RTVM0100'
               : PxMsgId
               : 'QCPFMSG   *LIBL'
               : PxMsgDta
               : %Len( PxMsgDta )
               : RPL_SUB_VAL
               : NOT_FMT_CTL
               : ERRC0100
               );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  NULL;

        When  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen ) = PxMsgId;
          Return  %Subst( RTVM0100.Msg
                        : RTVM0100.RtnMsgLen + 1
                        : RTVM0100.RtnHlpLen
                        );

        Other;
          Return  %Subst( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );
        EndSl;

      /End-Free

     P RtvMsg          E
     **-- Send diagnostic message:
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*DIAG'
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

     P SndDiagMsg      E
     **-- Send escape message:
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
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
