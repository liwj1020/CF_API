     **
     **  Program . . : CBX9411
     **  Description : Retrieve SMTP name - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Programmer's note:
     **    The system directory SMTP-name can be maintained using the command
     **    WRKDIRE USRPRF( userprofile-name ) then selecting change - option 2
     **    - followed by F19.
     **
     **
     **  Compile instructions:
     **    CrtRpgMod   Module( CBX9411 )
     **                DbgView( *LIST )
     **
     **    CrtPgm      Pgm( CBX9411 )
     **                Module( CBX9411 )
     **                ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- System information:
     D PgmSts         Sds                  Qualified
     D  JobUsr                       10a   Overlay( PgmSts: 254 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global variables:
     D Idx             s             10i 0
     D SmtpDmn         s            256a   Varying
     D SmtpUsrId       s             64a   Varying
     D SmtpRte         s            256a   Varying
     **
     D UsrId           Ds
     D  NbrElm                        5i 0
     D  UserId                        8a
     D  UserAddr                      8a
     **-- Global constants:
     **AT_SIGN         c                   '@'
     D AT_SIGN         c                   x'7C'
     D CLO_TMP_RSC     c                   '0'
     D OFS_MSGDTA      c                   16

     **-- Search directory parameters:
     D SREQ0100        Ds                  Qualified
     D  CcsId                        10i 0 Inz( 0 )
     D  ChrSet                       10i 0 Inz
     D  CodPag                       10i 0 Inz
     D  WldCrd                        4a   Inz
     D  CvtRcv                        1a   Inz( '1' )
     D  SchDta                        1a   Inz( '0' )
     D  RunVfy                        1a   Inz( '1' )
     D  ConHdl                        1a   Inz( '0' )
     D  RscHdl                       16a   Inz
     D  SrqFmt                        8a   Inz( 'SREQ0101' )
     D  SrqOfs                       10i 0 Inz( 110 )
     D  SrqNbrElm                    10i 0 Inz
     D  RtnFmt                        8a   Inz( 'SREQ0103' )
     D  RtnOfs                       10i 0 Inz( 100 )
     D  RtnNbrElm                    10i 0 Inz( 1 )
     D  RcvFmt                        8a   Inz( 'SRCV0101' )
     D  RcvNbrElm                    10i 0 Inz( 1 )
     D  UsrFmt                        8a   Inz( 'SRCV0111' )
     D  OrdFmt                        8a   Inz
     D  OrdRtnOpt                     1a   Inz( '0' )
     D                                3a
     D  SREQ0103                           LikeDs( SREQ0103 )
     D  SREQ0101                           LikeDs( SREQ0101 )
     **
     D SREQ0101        Ds                  Qualified  Inz
     D  Entry                              Dim( 2 )
     D  EntLen                       10i 0 Inz( %Size( SREQ0101.Entry ))
     D                                     Overlay( Entry: 1 )
     D  CmpVal                        1a   Inz( '1' )
     D                                     Overlay( Entry: *Next )
     D  FldNam                       10a   Overlay( Entry: *Next )
     D  PrdId                         7a   Inz( '*IBM' )
     D                                     Overlay( Entry: *Next )
     D  DtaCas                        1a   Overlay( Entry: *Next )
     D                                1a   Overlay( Entry: *Next )
     D  ValLen                       10i 0 Inz( %Size( SREQ0101.ValMtc ))
     D                                     Overlay( Entry: *Next )
     D  ValMtc                       10a   Overlay( Entry: *Next )
     **
     D SREQ0103        Ds                  Qualified
     D  S3SpcRtn                     10a   Inz( '*SMTP' )
     **
     D SRCV0100        Ds         32767    Qualified
     D  BytRtn                       10i 0
     D  OrdFldOfs                    10i 0
     D  UsrEntOfs                    10i 0
     D  DirEntNbr                    10i 0
     D  ConHdl                        1a
     D  RscHdl                       16a
     D  UsrMtcAry                          Like( SRCV0101 )
     **
     D SRCV0101        Ds                  Qualified  Based( pSRCV0101 )
     D  UsrDtaLen                    10i 0
     D  RtnNbrFld                    10i 0
     **
     D SRCV0111        Ds                  Qualified  Based( pSRCV0111 )
     D  FldNam                       10a
     D  PrdId                         7a
     D                                3a
     D  CcsId                        10i 0
     D  CodPag                       10i 0
     D  RtnFldLen                    10i 0
     **
     D SRCV0111V       Ds                  Based( pSRCV0111V )  Qualified
     D  RtnFld                      256a

     **-- Search directory:
     D SchDir          Pr                  Extpgm( 'QOKSCHD' )
     D  SdRcvVar                                 Like( Srcv0100)
     D  SdRcvVarLen                  10i 0 Const
     D  SdFmtNam                      8a   Const
     D  SdFunction                   10a   Const
     D  SdKeepTmpRsc                  1a   Const
     D  SdRqsVar                           Const Like( Sreq0100 )
     D  SdRqsVarLen                  10i 0 Const
     D  SdRqsFmtNam                   8a   Const
     D  SdError                       8a
     **-- Convert string:
     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
     D  InpCcsId                     10i 0 Const
     D  InpStrTyp                    10i 0 Const
     D  InpStr                    32767a   Const  Options( *VarSize )
     D  InpStrSiz                    10i 0 Const
     D  OutCcsId                     10i 0 Const
     D  OutStrTyp                    10i 0 Const
     D  OutCvtAlt                    10i 0 Const
     D  OutStrSiz                    10i 0 Const
     D  OutStr                    32767a          Options( *VarSize )
     D  OutStrLenRt                  10i 0
     D  NotSup                       10i 0
     D  FB                           10i 0 Dim( 3 )
     **-- Retrieve job information:
     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                        8a   Const
     D  JobNam_q                     26a   Const
     D  JobIntId                     16a   Const
     D  Error                     32767a          Options( *NoPass: *VarSize )
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

     **-- Convert string by CCSID:
     D CvtStrCcsId     Pr          4096a   Varying
     D  PxCcsId                      10i 0 Const
     D  PxCvtStr                   4096a   Const  Varying
     **-- Get job ccsid:
     D JobCcsId        Pr            10i 0
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     D CBX9411         Pr
     D  PxUsrId                            LikeDs( UsrId )
     D  PxUsrPrf                     10a
     D  PxSmtpName                   63a
     **
     D CBX9411         Pi
     D  PxUsrId                            LikeDs( UsrId )
     D  PxUsrPrf                     10a
     D  PxSmtpName                   63a

      /Free

        PxSmtpName = '*NONE';

        If  PxUsrPrf = '*CURRENT';
          PxUsrPrf = PgmSts.CurUsr;
        EndIf;

        If  PxUsrId.UserId = '*USRPRF';
          SREQ0100.SrqNbrElm = 1;
          SREQ0101.ValMtc(1) = PxUsrPrf;
          SREQ0101.FldNam(1) = 'USER';

        Else;
          SREQ0100.SrqNbrElm = 2;
          SREQ0101.ValMtc(1) = PxUsrId.UserId;
          SREQ0101.ValMtc(2) = PxUsrId.UserAddr;
          SREQ0101.FldNam(1) = 'USRID';
          SREQ0101.FldNam(2) = 'USRADDR';
        EndIf;

        SREQ0100.SREQ0103 = SREQ0103;
        SREQ0100.SREQ0101 = SREQ0101;

        SchDir( SRCV0100
              : %Size( SRCV0100 )
              : 'SRCV0100'
              : '*SEARCH'
              : CLO_TMP_RSC
              : SREQ0100
              : %Size( SREQ0100 )
              : 'SREQ0100'
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

        ElseIf  SRCV0100.DirEntNbr = 0;
          PxSmtpName = '*NONE';

        Else;
          pSRCV0101 = %Addr( SRCV0100 ) + SRCV0100.UsrEntOfs;
          pSRCV0111 = pSRCV0101 + %Size( SRCV0101 );

          For  Idx = 1  To  SRCV0101.RtnNbrFld;

            pSRCV0111V = pSRCV0111 + %Size( SRCV0111 );

            Select;
            When  SRCV0111.FldNam = 'SMTPUSRID';
              SmtpUsrId = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );

            When  SRCV0111.FldNam = 'SMTPDMN';
              SmtpDmn = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );

            When  SRCV0111.FldNam = 'SMTPRTE';
              SmtpRte = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );
            EndSl;

            If  Idx < SRCV0101.RtnNbrFld;
              pSRCV0111 = pSRCV0111 + %Size( SRCV0111 ) + SRCV0111.RtnFldLen;
            EndIf;
          EndFor;

          Select;
          When  SmtpUsrId > *Blank;
            PxSmtpName = SmtpUsrId + CvtStrCcsId( 500: AT_SIGN ) + SmtpDmn;

          When  SmtpRte > *Blank;
            PxSmtpName = SmtpRte;

          Other;
            PxSmtpName = '*BLANK';
          EndSl;

        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Convert string by CCSID:
     P CvtStrCcsId     B                   Export
     D                 Pi          4096a   Varying
     D  PxCcsId                      10i 0 Const
     D  PxCvtStr                   4096a   Const  Varying

     **-- Local variables:
     D OutStr          s           4096a
     D OutStrLenRt     s             10i 0
     D NotSup          s             10i 0
     D FB              s             10i 0 Dim( 3 )
     **-- Local constants:
     D CHR_STR         c                   0
     D CAS_INS_DFT     c                   0

      /Free

        If  PxCcsId = 0      Or
            PxCcsId = 65535  Or
            PxCcsId = JobCcsId();

          Return  PxCvtStr;
        EndIf;

        CvtString( JobCcsId()
                 : CHR_STR
                 : PxCvtStr
                 : %Len( PxCvtStr )
                 : PxCcsId
                 : CHR_STR
                 : CAS_INS_DFT
                 : %Size( OutStr )
                 : OutStr
                 : OutStrLenRt
                 : NotSup
                 : FB
                 );

        Return  %Subst( OutStr: 1: OutStrLenRt );

      /End-Free

     P CvtStrCcsId     E
     **-- Get job ccsid:
     P JobCcsId        B                   Export
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
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0

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
