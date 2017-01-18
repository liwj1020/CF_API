000100050724     **
000200050724     **  Program . . : CBX9411
000300050724     **  Description : Retrieve SMTP name - CPP
000400050724     **  Author  . . : Carsten Flensburg
000500050724     **
000600010509     **
000700010509     **  Programmer's note:
000800010509     **    The system directory SMTP-name can be maintained using the command
000900010509     **    WRKDIRE USRPRF( userprofile-name ) then selecting change - option 2
001000010509     **    - followed by F19.
001100010509     **
001200050724     **
001300050724     **  Compile instructions:
001400050726     **    CrtRpgMod   Module( CBX9411 )
001500050724     **                DbgView( *LIST )
001600050724     **
001700050726     **    CrtPgm      Pgm( CBX9411 )
001800050726     **                Module( CBX9411 )
001900050724     **                ActGrp( *NEW )
002000050724     **
002100010508     **
002200010508     **-- Header specifications:  --------------------------------------------**
002300050724     H Option( *SrcStmt )
002400050724
002500050724     **-- System information:
002600050724     D PgmSts         Sds                  Qualified
002700050724     D  JobUsr                       10a   Overlay( PgmSts: 254 )
002800050724     D  CurUsr                       10a   Overlay( PgmSts: 358 )
002900050724     **-- API error data structure:
003000050724     D ERRC0100        Ds                  Qualified
003100050724     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003200050724     D  BytAvl                       10i 0 Inz
003300050724     D  MsgId                         7a
003400050724     D                                1a
003500050724     D  MsgDta                      128a
003600050724     **-- Global variables:
003700050724     D Idx             s             10i 0
003800050724     D SmtpDmn         s            256a   Varying
003900050724     D SmtpUsrId       s             64a   Varying
004000150327     D SmtpRte         s            256a   Varying
004100050724     **
004200050724     D UsrId           Ds
004300050724     D  NbrElm                        5i 0
004400050724     D  UserId                        8a
004500050724     D  UserAddr                      8a
004600050724     **-- Global constants:
004700150327     **AT_SIGN         c                   '@'
004800150327     D AT_SIGN         c                   x'7C'
004900050724     D CLO_TMP_RSC     c                   '0'
005000050724     D OFS_MSGDTA      c                   16
005100050724
005200050724     **-- Search directory parameters:
005300050724     D SREQ0100        Ds                  Qualified
005400050724     D  CcsId                        10i 0 Inz( 0 )
005500050724     D  ChrSet                       10i 0 Inz
005600050724     D  CodPag                       10i 0 Inz
005700050724     D  WldCrd                        4a   Inz
005800150328     D  CvtRcv                        1a   Inz( '1' )
005900050724     D  SchDta                        1a   Inz( '0' )
006000050724     D  RunVfy                        1a   Inz( '1' )
006100050724     D  ConHdl                        1a   Inz( '0' )
006200050724     D  RscHdl                       16a   Inz
006300050724     D  SrqFmt                        8a   Inz( 'SREQ0101' )
006400050812     D  SrqOfs                       10i 0 Inz( 110 )
006500050724     D  SrqNbrElm                    10i 0 Inz
006600050724     D  RtnFmt                        8a   Inz( 'SREQ0103' )
006700050812     D  RtnOfs                       10i 0 Inz( 100 )
006800050724     D  RtnNbrElm                    10i 0 Inz( 1 )
006900050724     D  RcvFmt                        8a   Inz( 'SRCV0101' )
007000050724     D  RcvNbrElm                    10i 0 Inz( 1 )
007100050724     D  UsrFmt                        8a   Inz( 'SRCV0111' )
007200050724     D  OrdFmt                        8a   Inz
007300050724     D  OrdRtnOpt                     1a   Inz( '0' )
007400990909     D                                3a
007500050724     D  SREQ0103                           LikeDs( SREQ0103 )
007600050724     D  SREQ0101                           LikeDs( SREQ0101 )
007700990909     **
007800050724     D SREQ0101        Ds                  Qualified  Inz
007900050724     D  Entry                              Dim( 2 )
008000050724     D  EntLen                       10i 0 Inz( %Size( SREQ0101.Entry ))
008100050724     D                                     Overlay( Entry: 1 )
008200050724     D  CmpVal                        1a   Inz( '1' )
008300050724     D                                     Overlay( Entry: *Next )
008400050724     D  FldNam                       10a   Overlay( Entry: *Next )
008500050724     D  PrdId                         7a   Inz( '*IBM' )
008600050724     D                                     Overlay( Entry: *Next )
008700050724     D  DtaCas                        1a   Overlay( Entry: *Next )
008800050724     D                                1a   Overlay( Entry: *Next )
008900050724     D  ValLen                       10i 0 Inz( %Size( SREQ0101.ValMtc ))
009000050724     D                                     Overlay( Entry: *Next )
009100050724     D  ValMtc                       10a   Overlay( Entry: *Next )
009200990910     **
009300050724     D SREQ0103        Ds                  Qualified
009400990910     D  S3SpcRtn                     10a   Inz( '*SMTP' )
009500990909     **
009600050724     D SRCV0100        Ds         32767    Qualified
009700050724     D  BytRtn                       10i 0
009800050724     D  OrdFldOfs                    10i 0
009900050724     D  UsrEntOfs                    10i 0
010000050724     D  DirEntNbr                    10i 0
010100050724     D  ConHdl                        1a
010200050724     D  RscHdl                       16a
010300050724     D  UsrMtcAry                          Like( SRCV0101 )
010400990909     **
010500050724     D SRCV0101        Ds                  Qualified  Based( pSRCV0101 )
010600050724     D  UsrDtaLen                    10i 0
010700050724     D  RtnNbrFld                    10i 0
010800050724     **
010900050724     D SRCV0111        Ds                  Qualified  Based( pSRCV0111 )
011000050724     D  FldNam                       10a
011100050724     D  PrdId                         7a
011200990910     D                                3a
011300050724     D  CcsId                        10i 0
011400050724     D  CodPag                       10i 0
011500050724     D  RtnFldLen                    10i 0
011600050724     **
011700050724     D SRCV0111V       Ds                  Based( pSRCV0111V )  Qualified
011800050724     D  RtnFld                      256a
011900050724
012000050724     **-- Search directory:
012100990910     D SchDir          Pr                  Extpgm( 'QOKSCHD' )
012200990910     D  SdRcvVar                                 Like( Srcv0100)
012300990910     D  SdRcvVarLen                  10i 0 Const
012400990910     D  SdFmtNam                      8a   Const
012500990910     D  SdFunction                   10a   Const
012600990910     D  SdKeepTmpRsc                  1a   Const
012700990910     D  SdRqsVar                           Const Like( Sreq0100 )
012800990910     D  SdRqsVarLen                  10i 0 Const
012900990910     D  SdRqsFmtNam                   8a   Const
013000990910     D  SdError                       8a
013100150327     **-- Convert string:
013200150327     D CvtString       Pr                  ExtPgm( 'QTQCVRT' )
013300150327     D  InpCcsId                     10i 0 Const
013400150327     D  InpStrTyp                    10i 0 Const
013500150327     D  InpStr                    32767a   Const  Options( *VarSize )
013600150327     D  InpStrSiz                    10i 0 Const
013700150327     D  OutCcsId                     10i 0 Const
013800150327     D  OutStrTyp                    10i 0 Const
013900150327     D  OutCvtAlt                    10i 0 Const
014000150327     D  OutStrSiz                    10i 0 Const
014100150327     D  OutStr                    32767a          Options( *VarSize )
014200150327     D  OutStrLenRt                  10i 0
014300150327     D  NotSup                       10i 0
014400150327     D  FB                           10i 0 Dim( 3 )
014500150327     **-- Retrieve job information:
014600150327     D RtvJobInf       Pr                  ExtPgm( 'QUSRJOBI' )
014700150327     D  RcvVar                    32767a          Options( *VarSize )
014800150327     D  RcvVarLen                    10i 0 Const
014900150327     D  FmtNam                        8a   Const
015000150327     D  JobNam_q                     26a   Const
015100150327     D  JobIntId                     16a   Const
015200150327     D  Error                     32767a          Options( *NoPass: *VarSize )
015300050724     **-- Send program message:
015400050724     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
015500050724     D  SpMsgId                       7a   Const
015600050724     D  SpMsgFq                      20a   Const
015700050724     D  SpMsgDta                    128a   Const
015800050724     D  SpMsgDtaLen                  10i 0 Const
015900050724     D  SpMsgTyp                     10a   Const
016000050724     D  SpCalStkE                    10a   Const  Options( *VarSize )
016100050724     D  SpCalStkCtr                  10i 0 Const
016200050724     D  SpMsgKey                      4a
016300050724     D  SpError                    1024a          Options( *VarSize )
016400050724
016500150327     **-- Convert string by CCSID:
016600150327     D CvtStrCcsId     Pr          4096a   Varying
016700150327     D  PxCcsId                      10i 0 Const
016800150327     D  PxCvtStr                   4096a   Const  Varying
016900150327     **-- Get job ccsid:
017000150327     D JobCcsId        Pr            10i 0
017100050724     **-- Send escape message:
017200050724     D SndEscMsg       Pr            10i 0
017300050724     D  PxMsgId                       7a   Const
017400050724     D  PxMsgF                       10a   Const
017500050724     D  PxMsgDta                    512a   Const  Varying
017600050724
017700050724     D CBX9411         Pr
017800050724     D  PxUsrId                            LikeDs( UsrId )
017900050724     D  PxUsrPrf                     10a
018000050724     D  PxSmtpName                   63a
018100050724     **
018200050724     D CBX9411         Pi
018300050724     D  PxUsrId                            LikeDs( UsrId )
018400050724     D  PxUsrPrf                     10a
018500050724     D  PxSmtpName                   63a
018600050724
018700050724      /Free
018800050724
018900050809        PxSmtpName = '*NONE';
019000050724
019100050724        If  PxUsrPrf = '*CURRENT';
019200050724          PxUsrPrf = PgmSts.CurUsr;
019300050724        EndIf;
019400050724
019500050724        If  PxUsrId.UserId = '*USRPRF';
019600050724          SREQ0100.SrqNbrElm = 1;
019700050724          SREQ0101.ValMtc(1) = PxUsrPrf;
019800050724          SREQ0101.FldNam(1) = 'USER';
019900050724
020000050724        Else;
020100050724          SREQ0100.SrqNbrElm = 2;
020200050724          SREQ0101.ValMtc(1) = PxUsrId.UserId;
020300050724          SREQ0101.ValMtc(2) = PxUsrId.UserAddr;
020400050724          SREQ0101.FldNam(1) = 'USRID';
020500050724          SREQ0101.FldNam(2) = 'USRADDR';
020600050724        EndIf;
020700050724
020800050724        SREQ0100.SREQ0103 = SREQ0103;
020900050724        SREQ0100.SREQ0101 = SREQ0101;
021000050724
021100050724        SchDir( SRCV0100
021200050724              : %Size( SRCV0100 )
021300050724              : 'SRCV0100'
021400050724              : '*SEARCH'
021500050724              : CLO_TMP_RSC
021600050724              : SREQ0100
021700050724              : %Size( SREQ0100 )
021800050724              : 'SREQ0100'
021900050724              : ERRC0100
022000050724              );
022100050724
022200050724        If  ERRC0100.BytAvl > *Zero;
022300050724
022400050724          If  ERRC0100.BytAvl < OFS_MSGDTA;
022500050724            ERRC0100.BytAvl = OFS_MSGDTA;
022600050724          EndIf;
022700050724
022800050724          SndEscMsg( ERRC0100.MsgId
022900050724                   : 'QCPFMSG'
023000050724                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
023100050724                   );
023200050724
023300050724        ElseIf  SRCV0100.DirEntNbr = 0;
023400050724          PxSmtpName = '*NONE';
023500050724
023600050724        Else;
023700050724          pSRCV0101 = %Addr( SRCV0100 ) + SRCV0100.UsrEntOfs;
023800050724          pSRCV0111 = pSRCV0101 + %Size( SRCV0101 );
023900050724
024000050724          For  Idx = 1  To  SRCV0101.RtnNbrFld;
024100050724
024200050724            pSRCV0111V = pSRCV0111 + %Size( SRCV0111 );
024300050724
024400050724            Select;
024500050724            When  SRCV0111.FldNam = 'SMTPUSRID';
024600050724              SmtpUsrId = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );
024700050724
024800050724            When  SRCV0111.FldNam = 'SMTPDMN';
024900050724              SmtpDmn = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );
025000150327
025100150327            When  SRCV0111.FldNam = 'SMTPRTE';
025200150327              SmtpRte = %Subst( SRCV0111V.RtnFld: 1: SRCV0111.RtnFldLen );
025300050724            EndSl;
025400050724
025500050724            If  Idx < SRCV0101.RtnNbrFld;
025600050724              pSRCV0111 = pSRCV0111 + %Size( SRCV0111 ) + SRCV0111.RtnFldLen;
025700050724            EndIf;
025800050724          EndFor;
025900050724
026000150327          Select;
026100150327          When  SmtpUsrId > *Blank;
026200150327            PxSmtpName = SmtpUsrId + CvtStrCcsId( 500: AT_SIGN ) + SmtpDmn;
026300050724
026400150327          When  SmtpRte > *Blank;
026500150328            PxSmtpName = SmtpRte;
026600150327
026700150327          Other;
026800150327            PxSmtpName = '*BLANK';
026900150327          EndSl;
027000050724
027100050724        EndIf;
027200050724
027300050724        *InLr = *On;
027400050724        Return;
027500050724
027600050724      /End-Free
027700050724
027800150327     **-- Convert string by CCSID:
027900150327     P CvtStrCcsId     B                   Export
028000150327     D                 Pi          4096a   Varying
028100150327     D  PxCcsId                      10i 0 Const
028200150327     D  PxCvtStr                   4096a   Const  Varying
028300150327
028400150327     **-- Local variables:
028500150327     D OutStr          s           4096a
028600150327     D OutStrLenRt     s             10i 0
028700150327     D NotSup          s             10i 0
028800150327     D FB              s             10i 0 Dim( 3 )
028900150327     **-- Local constants:
029000150327     D CHR_STR         c                   0
029100150327     D CAS_INS_DFT     c                   0
029200150327
029300150327      /Free
029400150327
029500150327        If  PxCcsId = 0      Or
029600150327            PxCcsId = 65535  Or
029700150327            PxCcsId = JobCcsId();
029800150327
029900150327          Return  PxCvtStr;
030000150327        EndIf;
030100150327
030200150327        CvtString( JobCcsId()
030300150327                 : CHR_STR
030400150327                 : PxCvtStr
030500150327                 : %Len( PxCvtStr )
030600150327                 : PxCcsId
030700150327                 : CHR_STR
030800150327                 : CAS_INS_DFT
030900150327                 : %Size( OutStr )
031000150327                 : OutStr
031100150327                 : OutStrLenRt
031200150327                 : NotSup
031300150327                 : FB
031400150327                 );
031500150327
031600150327        Return  %Subst( OutStr: 1: OutStrLenRt );
031700150327
031800150327      /End-Free
031900150327
032000150327     P CvtStrCcsId     E
032100150327     **-- Get job ccsid:
032200150327     P JobCcsId        B                   Export
032300150327     D                 Pi            10i 0
032400150327     **-- Job info format JOBI0400:
032500150327     D JOBI0400        Ds                  Qualified
032600150327     D  BytRtn                       10i 0
032700150327     D  BytAvl                       10i 0
032800150327     D  JobNam                       10a
032900150327     D  UsrNam                       10a
033000150327     D  JobNbr                        6a
033100150327     D  CcsId                        10i 0 Overlay( JOBI0400: 301 )
033200150327     D  CcsIdDft                     10i 0 Overlay( JOBI0400: 373 )
033300150327     **-- API error data structure:
033400150327     D ERRC0100        Ds                  Qualified
033500150327     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
033600150327     D  BytAvl                       10i 0
033700150327
033800150327      /Free
033900150327
034000150327        RtvJobInf( JOBI0400
034100150327                 : %Size( JOBI0400 )
034200150327                 : 'JOBI0400'
034300150327                 : '*'
034400150327                 : *Blank
034500150327                 : ERRC0100
034600150327                 );
034700150327
034800150327        Select;
034900150327        When  ERRC0100.BytAvl > *Zero;
035000150327          Return  -1;
035100150327
035200150327        When  JOBI0400.CcsId = 65535;
035300150327          Return  JOBI0400.CcsIdDft;
035400150327
035500150327        Other;
035600150327          Return  JOBI0400.CcsId;
035700150327        EndSl;
035800150327
035900150327      /End-Free
036000150327
036100150327     P JobCcsId        E
036200150327     **-- Send escape message:
036300050724     P SndEscMsg       B
036400050724     D                 Pi            10i 0
036500050724     D  PxMsgId                       7a   Const
036600050724     D  PxMsgF                       10a   Const
036700050724     D  PxMsgDta                    512a   Const  Varying
036800050724     **
036900050724     D MsgKey          s              4a
037000050724
037100050724      /Free
037200050724
037300050724        SndPgmMsg( PxMsgId
037400050724                 : PxMsgF + '*LIBL'
037500050724                 : PxMsgDta
037600050724                 : %Len( PxMsgDta )
037700050724                 : '*ESCAPE'
037800050724                 : '*PGMBDY'
037900050724                 : 1
038000050724                 : MsgKey
038100050724                 : ERRC0100
038200050724                 );
038300050724
038400050724        If  ERRC0100.BytAvl > *Zero;
038500050724          Return  -1;
038600050724
038700050724        Else;
038800050724          Return   0;
038900050724        EndIf;
039000050724
039100050724      /End-Free
039200050724
039300050724     P SndEscMsg       E
