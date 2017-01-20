     **
     **  Program . . : CBX962V
     **  Description : Change Server Share - VCP
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Program description:
     **    This program checks the existence of a specified IFS object or
     **    a specified output queue
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX962V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX962V )
     **              Module( CBX962V )
     **              ActGrp( QILE )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a
     **-- access API constants:
     D F_OK            c                   0
     D X_OK            c                   1
     D W_OK            c                   2
     D R_OK            c                   4

     **-- IFS file functions:
     D access          Pr            10i 0 ExtProc( 'access' )
     D   Path                          *   Value  Options( *String )
     D   Amode                       10i 0 Value
     **-- Error number:
     D sys_errno       Pr              *    ExtProc( '__errno' )
     **-- Error string:
     D sys_strerror    Pr              *    ExtProc( 'strerror' )
     D  errno                        10i 0  Value
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
     D  MsgF_q                       20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  RplSubVal                    10a   Const
     D  RtnFmtChr                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  RtvOpt                       10a   Const  Options( *NoPass )
     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
     D  DtaCcsId                     10i 0 Const  Options( *NoPass )

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
     **-- Error identification:
     D errno           Pr            10i 0
     D strerror        Pr           128a   Varying

     **-- Entry parameters:
     D ObjNam_q        Ds                  Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     **
     D FilExt          Ds                  Qualified
     D  NbrExt                        5i 0
     D  FilExt                       46a   Varying  Dim( 128 )
     **
     D CBX962V         Pr
     D  PxShare                      12a
     D  PxShrTyp                     10a
     D  PxPthNam                   1024a   Varying
     D  PxTxtDsc                     50a
     D  PxPermis                     10i 0
     D  PxMaxUsr                     10i 0
     D  PxCcsId                      10i 0
     D  PxCnvTxt                      1a
     D  PxFilExt                           LikeDs( FilExt )
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxSpfTyp                     10i 0
     D  PxPrtDrv                     50a
     D  PxPrtFil_q                         LikeDs( ObjNam_q )
     D  PxPublish                     1a
     **
     D CBX962V         Pi
     D  PxShare                      12a
     D  PxShrTyp                     10a
     D  PxPthNam                   1024a   Varying
     D  PxTxtDsc                     50a
     D  PxPermis                     10i 0
     D  PxMaxUsr                     10i 0
     D  PxCcsId                      10i 0
     D  PxCnvTxt                      1a
     D  PxFilExt                           LikeDs( FilExt )
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxSpfTyp                     10i 0
     D  PxPrtDrv                     50a
     D  PxPrtFil_q                         LikeDs( ObjNam_q )
     D  PxPublish                     1a

      /Free

        If  PxShrTyp = '*FILE';

          If  PxPthNam <> '*SAME';

            If  access( PxPthNam: F_OK ) = -1;
              SndDiagMsg( 'CPD0006'
                        : '0000' + %Char( errno ) + ': ' + strerror
                        );

              SndEscMsg( 'CPF0002': '' );
            EndIf;
          EndIf;
        EndIf;

        If  PxShrTyp = '*PRINT';

          If  PxOutQue_q <> '*SAME';

            If  ChkObj( PxOutQue_q: '*OUTQ' ) = *Off;
              SndDiagMsg( 'CPD0006'
                        : '0000' +
                          RtvMsg( 'CPF2105': PxOutQue_q + 'OUTQ' )
                        );

              SndEscMsg( 'CPF0002': '' );
            EndIf;
          EndIf;

          If  PxPrtFil_q <> '*SAME';

            If  PxPrtFil_q.ObjNam > *Blanks;

              If  ChkObj( PxPrtFil_q: '*FILE' ) = *Off;
                SndDiagMsg( 'CPD0006'
                          : '0000' +
                            RtvMsg( 'CPF2105': PxPrtFil_q + 'FILE' )
                          );

                SndEscMsg( 'CPF0002': '' );
              EndIf;
            EndIf;
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

     **-- Local variables:
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
     **-- Retrieve message:  -------------------------------------------------**
     P RtvMsg          B
     D                 Pi          4096a   Varying
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Local variables:
     D RTVM0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RtnMsgLen                    10i 0
     D  RtnMsgAvl                    10i 0
     D  RtnHlpLen                    10i 0
     D  RtnHlpAvl                    10i 0
     D  Msg                        4096a
     **
     D NULL            c                   ''
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
     **-- Get runtime error number:  -----------------------------------------**
     P errno           B
     D                 Pi            10i 0

     **-- Local variables:
     D Error           s             10i 0  Based( pError )  NoOpt

      /Free

        pError = sys_errno;

        Return  Error;

      /End-Free

     P errno           E
     **-- Get runtime error text:  -------------------------------------------**
     P strerror        B
     D                 Pi           128a    Varying

      /Free

        Return  %Str( sys_strerror( errno ));

      /End-Free

     P strerror        E
     **-- Send diagnostic message:  ------------------------------------------**
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Local variables:
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
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Local variables:
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
