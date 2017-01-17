000100060316     **
000200060316     **  Program . . : CBX953
000300060316     **  Description : Add Group Profile - VCP
000400060316     **  Author  . . : Carsten Flensburg
000500060316     **  Published . : Club Tech iSeries System Management Tips Newsletter
000600060316     **
000700060316     **
000800060316     **  Program description:
000900060322     **    This program adds a specified group profile to all user profiles
001000060322     **    that meet the specified selection criteria.
001100060322     **
001200060322     **    The group profile is added as the primary group if the user
001300060322     **    profile does not already have one. Otherwise the group profile is
001400060322     **    added as a supplemental group, provided that not all supplemental
001500060322     **    group have already been specified.
001600060322     **
001700060322     **    A completion status report is written to a spooled file and
001800060322     **    placed in the current job's default output queue.
001900060322     **
002000060316     **
002100060316     **  Compile options:
002200060316     **    CrtRpgMod Module( CBX953 )
002300060316     **              DbgView( *LIST )
002400060316     **
002500060316     **    CrtPgm    Pgm( CBX953 )
002600060316     **              Module( CBX953 )
002700060316     **              ActGrp( CBX953 )
002800060316     **
002900060316     **
003000060316     **-- Control specification:  --------------------------------------------**
003100050319     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
003200051023
003300060316     **-- File specifications:
003400060316     FUSRFILE   IF   F   10        Disk    InfDs( FilInf )  UsrOpn
003500060316     F                                     ExtFile( FilNam )
003600060319     FQSYSPRT   O    F  132        Printer InfDs( PrtLinInf )  OflInd( *InOf )
003700051023
003800060316     **-- Data file information:
003900060316     D FilInf          Ds                  Qualified
004000060316     D  FilNam                       10a   Overlay( FilInf:  83 )
004100060316     D  RcdLen                        5i 0 Overlay( FilInf: 125 )
004200060316     D  MbrNam                       10a   Overlay( FilInf: 129 )
004300060316     D  NbrRcd                       10i 0 Overlay( FilInf: 156 )
004400060316     D  Rrn                          10i 0 Overlay( FilInf: 397 )
004500041212     **-- Printer file information:
004600050212     D PrtLinInf       Ds                  Qualified
004700050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
004800050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
004900050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
005000060316     **-- System information:
005100060316     D PgmSts         Sds                  Qualified
005200060316     D  PgmNam           *Proc
005300060316     D  CurJob                       10a   Overlay( PgmSts: 244 )
005400060316     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
005500060316     D  JobNbr                        6a   Overlay( PgmSts: 264 )
005600060316     D  CurUsr                       10a   Overlay( PgmSts: 358 )
005700051023
005800041211     **-- API error data structure:
005900041211     D ERRC0100        Ds                  Qualified
006000041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
006100041211     D  BytAvl                       10i 0
006200041211     D  MsgId                         7a
006300990921     D                                1a
006400041211     D  MsgDta                      128a
006500060316
006600060316     **-- Input record:
006700060316     D InpRcd          Ds                  Qualified
006800060316     D  UsrPrf                       10a
006900060316     **-- Global constants:
007000060317     D NULL            c                   ''
007100060316     D PRF_USR         c                   '0'
007200060316     D PRF_GRP         c                   '1'
007300041212     **-- Global variables:
007400060316     D FilNam          s             21a
007500060317     D PrfSts          s             10i 0
007600060319     D GrpSts          s             10i 0
007700060317     D CmdSts          s             10i 0
007800060319     D PrfPrc          s             10i 0
007900060319     D PrfChg1         s             10i 0
008000060319     D PrfChg2         s             10i 0
008100051029     D Idx             s             10i 0 Inz
008200060320     D ClsIdx          s             10i 0 Inz
008300041212     D LstTim          s              6s 0
008400050319     D SysNam          s              8a
008500060317     D TrlTxt          s             64a
008600060322     D CrtOwn          s             10a
008700060317     D SupGrps         s            165a   Varying
008800060320     D ChkUsrCls       s             10a   Dim( 5 )
008900060320     **
009000060320     D UsrCls          Ds                  Qualified
009100060320     D  NbrCls                        5i 0
009200060320     D  ClsVal                       10a   Dim( 5 )
009300060316     **
009400060320     D File_q          Ds                  Qualified
009500060320     D  File                         10a
009600060316     D  LibNam                       10a
009700050122     **-- List record:
009800050122     D LstRcd          Ds                  Qualified
009900050507     D  UsrPrf                       10a
010000050507     D  UsrCls                       10a
010100060317     D  GrpPrf                       10a
010200060319     D  PrfSts                       10a
010300060322     D  NbrSpGp                       2s 0
010400060322     D  ChgSts                       75a
010500060316
010600050212     **-- List API parameters:
010700050212     D LstApi          Ds                  Qualified  Inz
010800050212     D  RtnRcdNbr                    10i 0
010900060319     D  GrpPrf                       10a
011000050506     D  SltCri                       10a
011100060319     D  UsrPrf                       10a
011200060317     **-- Retrieve API parameters:
011300060317     D RtvApi          Ds                  Qualified  Inz
011400060317     D  UsrPrf                       10a
011500040426     **-- List information:
011600041211     D LstInf          Ds                  Qualified
011700041211     D  RcdNbrTot                    10i 0
011800041211     D  RcdNbrRtn                    10i 0
011900041211     D  Handle                        4a
012000041211     D  RcdLen                       10i 0
012100041211     D  InfSts                        1a
012200041211     D  Dts                          13a
012300041211     D  LstSts                        1a
012400040426     D                                1a
012500041211     D  InfLen                       10i 0
012600041211     D  Rcd1                         10i 0
012700040426     D                               40a
012800050507     **-- User information:
012900050507     D AUTU0100        Ds                  Qualified
013000050506     D  UsrPrf                       10a
013100050506     D  UsrGrpI                       1a
013200050506     D  GrpMbrI                       1a
013300050507     **-- User information:
013400060316     D USRI0300        Ds          4096    Qualified
013500060316     D  BytRtn                       10i 0
013600060316     D  BytAvl                       10i 0
013700060316     D  UsrPrf                       10a
013800060316     D  PrfSts                       10a   Overlay( USRI0300:  37 )
013900060317     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
014000060317     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
014100060316     D  UsrCls                       10a   Overlay( USRI0300:  74 )
014200060316     D  SpcAut                       15a   Overlay( USRI0300:  84 )
014300060316     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
014400060316     D  LmtCap                       10a   Overlay( USRI0300: 189 )
014500060316     D  OfsSupGrp                    10i 0 Overlay( USRI0300: 585 )
014600060316     D  NbrSupGrp                    10i 0 Overlay( USRI0300: 589 )
014700060319     D  GID                          10i 0 Overlay( USRI0300: 597 )
014800060316     **
014900060316     D SupGrp          s             10a   Dim( 15 )  Based( pSupGrp )
015000051023
015100050506     **-- Open list of authorized users:
015200050506     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
015300051023     D  RcvVar                    65535a          Options( *VarSize )
015400051023     D  RcvVarLen                    10i 0 Const
015500051023     D  LstInf                       80a
015600051023     D  NbrRcdRtn                    10i 0 Const
015700051023     D  FmtNam                        8a   Const
015800051023     D  SltCri                       10a   Const
015900060319     D  GrpPrf                       10a   Const
016000051023     D  Error                      1024a          Options( *VarSize )
016100060319     D  UsrPrf                       10a   Const  Options( *NoPass )
016200041212     **-- Get list entry:
016300020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
016400051023     D  RcvVar                    65535a          Options( *VarSize )
016500051023     D  RcvVarLen                    10i 0 Const
016600051023     D  Handle                        4a   Const
016700051023     D  LstInf                       80a
016800051023     D  NbrRcdRtn                    10i 0 Const
016900051023     D  RtnRcdNbr                    10i 0 Const
017000051023     D  Error                      1024a          Options( *VarSize )
017100041212     **-- Close list:
017200020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
017300051023     D  Handle                        4a   Const
017400051023     D  Error                      1024a          Options( *VarSize )
017500051028     **-- Process commands:
017600051028     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
017700051028     D  SrcCmd                    32702a   Const  Options( *VarSize )
017800051028     D  SrcCmdLen                    10i 0 Const
017900051028     D  OptCtlBlk                    20a   Const
018000051028     D  OptCtlBlkLn                  10i 0 Const
018100051028     D  OptCtlBlkFm                   8a   Const
018200051028     D  ChgCmd                    32767a          Options( *VarSize )
018300051028     D  ChgCmdLen                    10i 0 Const
018400051028     D  ChgCmdLenAvl                 10i 0
018500051028     D  Error                     32767a          Options( *VarSize )
018600050319     **-- Send program message:
018700050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
018800051023     D  MsgId                         7a   Const
018900051023     D  MsgFq                        20a   Const
019000051023     D  MsgDta                      128a   Const
019100051023     D  MsgDtaLen                    10i 0 Const
019200051023     D  MsgTyp                       10a   Const
019300051023     D  CalStkE                      10a   Const  Options( *VarSize )
019400051023     D  CalStkCtr                    10i 0 Const
019500051023     D  MsgKey                        4a
019600051023     D  Error                     32767a          Options( *VarSize )
019700050319     **-- Retrieve net attribute:
019800050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
019900051023     D  RcvVar                    32767a          Options( *VarSize )
020000051023     D  RcvVarLen                    10i 0 Const
020100051023     D  NbrNetAtr                    10i 0 Const
020200051023     D  NetAtr                       10a   Const  Dim( 256 )
020300050319     D                                            Options( *VarSize )
020400051023     D  Error                     32767a          Options( *VarSize )
020500050506     **-- Retrieve user information:
020600050506     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
020700051023     D  RcvVar                    32767a          Options( *VarSize )
020800051023     D  RcvVarLen                    10i 0 Const
020900051023     D  FmtNam                       10a   Const
021000051023     D  UsrPrf                       10a   Const
021100051023     D  Error                     32767a          Options( *VarSize )
021200050506     **-- Retrieve object description:
021300050506     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
021400051023     D  RcvVar                    32767a         Options( *VarSize )
021500051023     D  RcvVarLen                    10i 0 Const
021600051023     D  FmtNam                        8a   Const
021700051023     D  ObjNamQ                      20a   Const
021800051023     D  ObjTyp                       10a   Const
021900051023     D  Error                     32767a         Options( *VarSize )
022000041212
022100050319     **-- Get system name:
022200050319     D GetSysNam       Pr             8a   Varying
022300051029     **-- Get creating user profile:
022400051029     D GetCrtUsr       Pr            10a
022500050506     D  PxUsrPrf                     10a   Value
022600051028     **-- Process command:
022700051028     D PrcCmd          Pr            10i 0
022800051101     D  PxCmdStr                   1024a   Const  Varying
022900050507     **-- Send completion message:
023000050507     D SndCmpMsg       Pr            10i 0
023100050507     D  PxMsgDta                    512a   Const  Varying
023200051028
023300041216     **-- Write detail line:
023400041216     D WrtDtlLin       Pr
023500050507     **-- Write list header:
023600050507     D WrtLstHdr       Pr
023700050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
023800041216     **-- Write list trailer:
023900041216     D WrtLstTrl       Pr
024000060317     D  PxTrlTxt                     64a   Const
024100041212
024200060316     **-- Entry parameters:
024300060316     D CBX953          Pr
024400060316     D  PxUsrPrf                     10a
024500060320     D  PxNewGrpPrf                  10a
024600060322     D  PxGrpOwn                     10a
024700060320     D  PxUsrCls                           LikeDs( UsrCls )
024800060320     D  PxGrpPrf                     10a
024900060323     D  PxRplPriGrp                   4a
025000060323     D  PxPrfOpt                      7a
025100060320     D  PxFile_q                           LikeDs( File_q )
025200060316     **
025300060316     D CBX953          Pi
025400060316     D  PxUsrPrf                     10a
025500060320     D  PxNewGrpPrf                  10a
025600060322     D  PxGrpOwn                     10a
025700060320     D  PxUsrCls                           LikeDs( UsrCls )
025800060320     D  PxGrpPrf                     10a
025900060323     D  PxRplPriGrp                   4a
026000060323     D  PxPrfOpt                      7a
026100060320     D  PxFile_q                           LikeDs( File_q )
026200041211
026300041211      /Free
026400041211
026500060316        If  PxUsrPrf = '*FILE';
026600060316          ExSr  GetFile;
026700060316        Else;
026800060316          ExSr  LstUser;
026900060316        EndIf;
027000060316
027100060316        *InLr = *On;
027200060316        Return;
027300050506
027400060316        BegSr  GetFile;
027500060316
027600060320          FilNam = %TrimR( PxFile_q.LibNam ) + '/' + PxFile_q.File;
027700060316
027800060316          Open  USRFILE;
027900060316          SetLl  *Start  USRFILE;
028000060316
028100060316          Read  USRFILE  InpRcd;
028200060316          DoW  Not %EoF;
028300060316
028400060317            ExSr  GetPrfInf;
028500060316
028600060316            Read  USRFILE  InpRcd;
028700060316          EndDo;
028800060316
028900060316          Close USRFILE;
029000060316
029100060316        EndSr;
029200050415
029300060316        BegSr  LstUser;
029400060316
029500060316          LstApi.RtnRcdNbr = 1;
029600060319          LstApi.SltCri = '*ALL';
029700060319          LstApi.GrpPrf = '*NONE';
029800060319          LstApi.UsrPrf = PxUsrPrf;
029900060316
030000060316          LstAutUsr( AUTU0100
030100060316                   : %Size( AUTU0100 )
030200060316                   : LstInf
030300060316                   : 1
030400060316                   : 'AUTU0100'
030500060316                   : LstApi.SltCri
030600060319                   : LstApi.GrpPrf
030700060316                   : ERRC0100
030800060319                   : LstApi.UsrPrf
030900060316                   );
031000060316
031100060316          If  ERRC0100.BytAvl = *Zero;
031200060316
031300060316            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
031400060316
031500060319              ExSr  GetPrfInf;
031600060316
031700060316              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
031800060316
031900060316              GetLstEnt( AUTU0100
032000060316                       : %Size( AUTU0100 )
032100060316                       : LstInf.Handle
032200060316                       : LstInf
032300060316                       : 1
032400060316                       : LstApi.RtnRcdNbr
032500060316                       : ERRC0100
032600060316                       );
032700060316
032800060316              If  ERRC0100.BytAvl > *Zero;
032900060316                Leave;
033000060316              EndIf;
033100060316
033200060316            EndDo;
033300060316
033400060316            CloseLst( LstInf.Handle: ERRC0100 );
033500060316          EndIf;
033600060319
033700060319          If  PrfPrc = *Zero;
033800060319            WrtLstTrl( '(No user profiles met selection criteria)' );
033900060319          EndIf;
034000060316
034100060319          WrtLstTrl( *Blanks );
034200060319          WrtLstTrl( 'Profiles processed . . . . . . :  ' + %Char( PrfPrc ));
034300060319          WrtLstTrl( 'Primary groups added . . . . . :  ' + %Char( PrfChg1 ));
034400060319          WrtLstTrl( 'Supplemental groups added  . . :  ' + %Char( PrfChg2 ));
034500060319          WrtLstTrl( *Blanks );
034600060316          WrtLstTrl( '***  E N D  O F  L I S T  ***' );
034700060316
034800060323          SndCmpMsg( 'Completion status report has been printed.' );
034900060316
035000060316        EndSr;
035100060316
035200050507        BegSr  GetPrfInf;
035300050507
035400060317          If  PxUsrPrf = '*FILE';
035500060319            RtvApi.UsrPrf = InpRcd.UsrPrf;
035600060317          Else;
035700060319            RtvApi.UsrPrf = AUTU0100.UsrPrf;
035800060317          EndIf;
035900060317
036000050507          RtvUsrInf( USRI0300
036100050507                   : %Size( USRI0300 )
036200050507                   : 'USRI0300'
036300060319                   : RtvApi.UsrPrf
036400050507                   : ERRC0100
036500050507                   );
036600050507
036700060320          Select;
036800060320          When  ERRC0100.BytAvl > *Zero;
036900060319            Clear  USRI0300;
037000060319            USRI0300.UsrPrf = RtvApi.UsrPrf;
037100060320
037200060320            ExSr  ChkPrfInf;
037300060320
037400060320          When  %Lookup( USRI0300.UsrCls: ChkUsrCls: 1: ClsIdx ) > *Zero;
037500060320
037600060320            If  PxGrpPrf = '*ANY'  Or  PxGrpPrf = USRI0300.GrpPrf;
037700060320              ExSr  ChkPrfInf;
037800060320            EndIf;
037900060320          EndSl;
038000041211
038100041211        EndSr;
038200041211
038300050507        BegSr  ChkPrfInf;
038400060319
038500060319          PrfPrc += 1;
038600060319          pSupGrp = %Addr( USRI0300 ) + USRI0300.OfsSupGrp;
038700051029
038800060319          Select;
038900060319          When  ERRC0100.BytAvl > *Zero;
039000060319            PrfSts = -1;
039100060319
039200060319          When  USRI0300.GID > *Zero;
039300060319            PrfSts = -2;
039400060319
039500060319          When  GetCrtUsr( USRI0300.UsrPrf ) = '*IBM';
039600060319            PrfSts = -3;
039700060319
039800060322          When  %Subst( USRI0300.UsrPrf: 1: 1 ) = 'Q';
039900060322            PrfSts = -3;
040000060322
040100060319          When  USRI0300.GrpPrf <> '*NONE'  And  USRI0300.NbrSupGrp >= 15;
040200060319            PrfSts = -4;
040300060319
040400060320          When  USRI0300.GrpPrf = PxNewGrpPrf;
040500060319            PrfSts = -5;
040600060319
040700060320          When  %Lookup( PxNewGrpPrf: SupGrp: 1: USRI0300.NbrSupGrp ) > 1;
040800060319            PrfSts = -6;
040900060319
041000060319          Other;
041100060319            PrfSts = *Zero;
041200060319          EndSl;
041300060319
041400060319          If  PrfSts = *Zero;
041500060319            ExSr  AddGrpPrf;
041600060319          EndIf;
041700060319
041800060319          ExSr WrtPrfInf;
041900050319
042000050319        EndSr;
042100060317
042200060317        BegSr  AddGrpPrf;
042300050507
042400060330          Select;
042500060330          When  USRI0300.GrpPrf = '*NONE'  Or  PxRplPriGrp = '*YES';
042600060330            GrpSts = 1;
042700060330            PrfChg1 += 1;
042800060330
042900060330            ExSr  UpdPriGrp;
043000060330
043100060330          When  PxRplPriGrp = '*SUPGRP';
043200060330            GrpSts = 3;
043300060330            PrfChg3 += 1;
043400060330
043500060330            ExSr  UpdPriGrp;
043600060330            ExSr  UpdSupGrp;
043700060330
043800060330          Other;
043900060319            GrpSts = 2;
044000060319            PrfChg2 += 1;
044100060317
044200060330            ExSr  UpdSupGrp;
044300060330          EndSl;
044400060317
044500060319          Select;
044600060319          When  CmdSts < *Zero;
044700060317            PrfSts = -11;
044800060317
044900060323          When  GrpSts = 1  And  PxPrfOpt = '*UPDATE';
045000060317            SndCmpMsg( 'Group profile '               +
045100060320                       %Trim( PxNewGrpPrf )           +
045200060317                       ' added to user profile '      +
045300060317                       %Trim( USRI0300.UsrPrf )       +
045400060317                       '.'
045500060317                     );
045600060319
045700060323          When  GrpSts = 2  And  PxPrfOpt = '*UPDATE';
045800060319            SndCmpMsg( 'Supplemental group profile '  +
045900060320                       %Trim( PxNewGrpPrf )           +
046000060319                       ' added to user profile '      +
046100060319                       %Trim( USRI0300.UsrPrf )       +
046200060319                       '.'
046300060319                     );
046400060330
046500060330          When  GrpSts = 3  And  PxPrfOpt = '*UPDATE';
046600060330            SndCmpMsg( 'Supplemental group profile '  +
046700060330                       %Trim( PxNewGrpPrf )           +
046800060330                       ' added to user profile '      +
046900060330                       %Trim( USRI0300.UsrPrf )       +
047000060330                       '.'
047100060330                     );
047200060319          EndSl;
047300060317
047400060317        EndSr;
047500060330
047600060330        BegSr  UpdPriGrp;
047700060317
047800060330          If  PxPrfOpt = '*UPDATE';
047900060330            CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
048000060330                              %Trim( USRI0300.UsrPrf )    +
048100060330                              ') GRPPRF('                 +
048200060330                              %Trim( PxNewGrpPrf )        +
048300060330                              ') OWNER('                  +
048400060330                              %Trim( CrtOwn )             +
048500060330                              ')'
048600060330                            );
048700060330          EndIf;
048800060330
048900060330        EndSr;
049000060330
049100060330        BegSr  UpdSupGrp;
049200060330
049300060330          If  PxPrfOpt = '*UPDATE';
049400060330            SupGrps = NULL;
049500060330
049600060330            For  Idx = 1  to  USRI0300.NbrSupGrp;
049700060330              SupGrps += %TrimR( SupGrp(Idx)) + ' ';
049800060330            EndFor;
049900060330
050000060330            SupGrps += PxNewGrpPrf;
050100060330
050200060330            CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
050300060330                              %Trim( USRI0300.UsrPrf )    +
050400060330                              ') SUPGRPPRF('              +
050500060330                              SupGrps                     +
050600060330                              ') OWNER('                  +
050700060330                              %Trim( CrtOwn )             +
050800060330                              ')'
050900060330                            );
051000060330          EndIf;
051100060330
051200060330        EndSr;
051300060330
051400050507        BegSr  WrtPrfInf;
051500050507
051600060322          LstRcd.UsrPrf  = USRI0300.UsrPrf;
051700060322          LstRcd.UsrCls  = USRI0300.UsrCls;
051800060322          LstRcd.GrpPrf  = USRI0300.GrpPrf;
051900060322          LstRcd.NbrSpGp = USRI0300.NbrSupGrp;
052000060322          LstRcd.PrfSts  = USRI0300.PrfSts;
052100050507
052200060319          Select;
052300060319          When  PrfSts = -1;
052400060319            LstRcd.ChgSts = 'Error occurred when retrieving user profile data.';
052500060319
052600060319          When  PrfSts = -2;
052700060321            LstRcd.ChgSts = 'User profile is a group profile.';
052800060319
052900060319          When  PrfSts = -3;
053000060322            LstRcd.ChgSts = 'System user profile cannot be changed.';
053100050507
053200060319          When  PrfSts = -4;
053300060321            LstRcd.ChgSts = 'Group profile overflow.  Group profile not added.';
053400060319
053500060319          When  PrfSts = -5;
053600060321            LstRcd.ChgSts = 'Group profile already assigned.';
053700060319
053800060319          When  PrfSts = -6;
053900060321            LstRcd.ChgSts = 'Supplemental group profile already assigned.';
054000060319
054100060319          When  PrfSts = -11;
054200060319            LstRcd.ChgSts = 'Change user profile command failed.';
054300060319
054400060319          When  GrpSts = 1;
054500060319            LstRcd.ChgSts = 'Group profile added as primary group.';
054600060319
054700060319          When  GrpSts = 2;
054800060319            LstRcd.ChgSts = 'Group profile added as supplemental group.';
054900060319          EndSl;
055000060319
055100050507          WrtDtlLin();
055200050507
055300050507        EndSr;
055400050507
055500041212        BegSr  *InzSr;
055600051029
055700060320          For  Idx = 1  to PxUsrCls.NbrCls;
055800060320
055900060320            Select;
056000060320            When  PxUsrCls.ClsVal(Idx) = '*ALL';
056100060320              ChkUsrCls(1) = '*USER';
056200060320              ChkUsrCls(2) = '*PGMR';
056300060320              ChkUsrCls(3) = '*SYSOPR';
056400060320              ChkUsrCls(4) = '*SECADM';
056500060320              ChkUsrCls(5) = '*SECOFR';
056600060320              ClsIdx = 5;
056700060320
056800060320            When  PxUsrCls.ClsVal(Idx) = '*NONUSER';
056900060320              ChkUsrCls(1) = '*PGMR';
057000060320              ChkUsrCls(2) = '*SYSOPR';
057100060320              ChkUsrCls(3) = '*SECADM';
057200060320              ChkUsrCls(4) = '*SECOFR';
057300060320              ClsIdx = 4;
057400060320
057500060320            Other;
057600060320              ChkUsrCls(Idx) = PxUsrCls.ClsVal(Idx);
057700060320              ClsIdx += 1;
057800060320            EndSl;
057900060320          EndFor;
058000060322
058100060322          Select;
058200060322          When  PxGrpOwn = '*SAME';
058300060322            CrtOwn = '*SAME';
058400060322
058500060322          When  PxGrpOwn = '*YES';
058600060322            CrtOwn = '*GRPPRF';
058700060322
058800060322          When  PxGrpOwn = '*NO';
058900060322            CrtOwn = '*USRPRF';
059000060322          EndSl;
059100060320
059200041212          LstTim = %Int( %Char( %Time(): *ISO0));
059300050319          SysNam = GetSysNam();
059400050507
059500050507          WrtLstHdr();
059600041212
059700041212        EndSr;
059800041212
059900050122      /End-Free
060000050122
060100041212     **-- Printer file definition:  ------------------------------------------**
060200041212     OQSYSPRT   EF           Header         2  2
060300041212     O                       UDATE         Y      8
060400041212     O                       LstTim              18 '  :  :  '
060500050319     O                                           36 'System:'
060600050319     O                       SysNam              45
060700060323     O                                           88 'Add group profile comple-
060800060323     O                                              tion report'
060900041212     O                                          107 'Program:'
061000050319     O                       PgmSts.PgmNam      118
061100041212     O                                          126 'Page:'
061200041212     O                       PAGE             +   1
061300050415     **
061400051029     OQSYSPRT   EF           LstHdr         1
061500060319     O                                           27 'User profile  . . . . . . -
061600051029     O                                              :'
061700060319     O                       PxUsrPrf            39
061800060320     O                       PxFile_q.File       50
061900060320     O                                           80 'User classes to select  . -
062000060320     O                                              :'
062100060320     O                       ChkUsrCls          132
062200051029     **
062300060323     OQSYSPRT   EF           LstHdr         1
062400060320     O                                           27 'Group profile to add  . . -
062500051029     O                                              :'
062600060320     O                       PxNewGrpPrf         39
062700060320     O                                           80 'Group profile to select . -
062800060320     O                                              :'
062900060320     O                       PxGrpPrf            92
063000060323     OQSYSPRT   EF           LstHdr         2
063100060323     O                                           27 'Replace group profile . . -
063200060323     O                                              :'
063300060323     O                       PxRplPriGrp         33
063400060323     O                                           80 'User profile option . . . -
063500060323     O                                              :'
063600060323     O                       PxPrfOpt            89
063700060323     O                                          120 'Group ownership . . . . . -
063800060323     O                                              :'
063900060323     O                       PxGrpOwn           132
064000051029     **
064100041212     OQSYSPRT   EF           LstHdr         1
064200050507     O                                            4 'User'
064300050507     O                                           17 'Class'
064400051029     O                                           28 'Group'
064500060322     O                                           43 'Sup.grp.'
064600060322     O                                           51 'Status'
064700060322     O                                           70 'Change status'
064800041216     **
064900041212     OQSYSPRT   EF           DtlLin         1
065000050507     O                       LstRcd.UsrPrf       10
065100050507     O                       LstRcd.UsrCls       22
065200051029     O                       LstRcd.GrpPrf       33
065300060322     O                       LstRcd.NbrSpGp3     41
065400060322     O                       LstRcd.PrfSts       55
065500060319     O                       LstRcd.ChgSts      132
065600041212     **
065700050123     OQSYSPRT   EF           LstTrl         1
065800060317     O                       TrlTxt              66
065900041216     **-- Write detail line:  ------------------------------------------------**
066000041216     P WrtDtlLin       B
066100041212     D                 Pi
066200041212
066300041212      /Free
066400041212
066500050507        WrtLstHdr( 3 );
066600041212
066700041216        Except  DtlLin;
066800041212
066900041212      /End-Free
067000041212
067100041216     P WrtDtlLin       E
067200060322     **-- Write list header:
067300050507     P WrtLstHdr       B
067400050507     D                 Pi
067500050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
067600050507
067700050507      /Free
067800050507
067900050507        If  %Parms = *Zero;
068000050507
068100050507          Except  Header;
068200050507          Except  LstHdr;
068300050507        Else;
068400050507
068500050507          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
068600050507
068700050507            Except  Header;
068800050507            Except  LstHdr;
068900050507          EndIf;
069000050507        EndIf;
069100050507
069200050507      /End-Free
069300050507
069400050507     P WrtLstHdr       E
069500060322     **-- Write list trailer:
069600041216     P WrtLstTrl       B
069700041216     D                 Pi
069800060317     D  PxTrlTxt                     64a   Const
069900041216
070000041216      /Free
070100041216
070200050415        TrlTxt = PxTrlTxt;
070300050415
070400041216        Except  LstTrl;
070500041216
070600041216      /End-Free
070700041216
070800041216     P WrtLstTrl       E
070900060322     **-- Get system name:
071000050319     P GetSysNam       B
071100050319     D                 Pi             8a   Varying
071200051029
071300050319     **-- Local variables:
071400050319     D Idx             s             10i 0
071500050319     D SysNam          s              8a   Varying
071600050319     **
071700050319     D RtnAtrLen       s             10i 0
071800050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
071900050319     D NetAtr          s             10a   Dim( 1 )
072000050319     **
072100050319     D RtnVar          Ds                  Qualified
072200050319     D  RtnVarNbr                    10i 0
072300050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
072400050319     D  RtnVarDta                  1024a
072500050319
072600050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
072700050319     D  AtrNam                       10a
072800050319     D  DtaTyp                        1a
072900050319     D  InfSts                        1a
073000050319     D  AtrLen                       10i 0
073100050319     D  Atr                        1008a
073200050319
073300050319      /Free
073400050319
073500050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
073600050319
073700050319        NetAtr(1) = 'SYSNAME';
073800050319
073900050319        RtvNetAtr( RtnVar
074000050319                 : RtnAtrLen
074100050319                 : NetAtrNbr
074200050319                 : NetAtr
074300050319                 : ERRC0100
074400050319                 );
074500050319
074600050319        If  ERRC0100.BytAvl > *Zero;
074700050319          SysNam = '';
074800050319
074900050319        Else;
075000050319          For  Idx = 1  to RtnVar.RtnVarNbr;
075100050319
075200050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
075300050319
075400050319            If  RtnAtr.AtrNam = 'SYSNAME';
075500050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
075600050319            EndIf;
075700050319
075800050319          EndFor;
075900050319        EndIf;
076000050319
076100050319        Return  SysNam;
076200050319
076300050319      /End-Free
076400050319
076500050319     P GetSysNam       E
076600060322     **-- Get creating user profile:
076700051029     P GetCrtUsr       B
076800050506     D                 Pi            10a
076900050506     D  PxUsrPrf                     10a   Value
077000050506     **
077100050506     D OBJD0300        Ds                  Qualified
077200050506     D  BytRtn                       10i 0
077300050506     D  BytAvl                       10i 0
077400050506     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )
077500050506
077600050506      /Free
077700050506
077800050506        RtvObjD( OBJD0300
077900050506               : %Size( OBJD0300 )
078000050506               : 'OBJD0300'
078100050506               : PxUsrPrf + 'QSYS'
078200050506               : '*USRPRF'
078300050506               : ERRC0100
078400050506               );
078500050506
078600050506        If  ERRC0100.BytAvl > *Zero;
078700050506          Return  *Blanks;
078800050506
078900050506        Else;
079000050506          Return  OBJD0300.ObjCrt;
079100050506        EndIf;
079200050506
079300050506      /End-Free
079400050506
079500051029     P GetCrtUsr       E
079600060322     **-- Process command:
079700051028     P PrcCmd          B                   Export
079800051028     D                 Pi            10i 0
079900051028     D  PxCmdStr                   1024a   Const  Varying
080000051028
080100051028     **-- Local variables:
080200051028     D CPOP0100        Ds                  Qualified
080300051028     D  TypPrc                       10i 0 Inz( 2 )
080400051028     D  DBCS                          1a   Inz( '0' )
080500051028     D  PmtAct                        1a   Inz( '2' )
080600051028     D  CmdStx                        1a   Inz( '0' )
080700051028     D  MsgRtvKey                     4a   Inz( *Allx'00' )
080800051028     D  Rsv                           9a   Inz( *Allx'00' )
080900051028     **
081000051028     D ChgCmd          s          32767a
081100051028     D ChgCmdAvl       s             10i 0
081200051028
081300051028      /Free
081400060319
081500051028        PrcCmds( PxCmdStr
081600051028               : %Len( PxCmdStr )
081700051028               : CPOP0100
081800051028               : %Size( CPOP0100 )
081900051028               : 'CPOP0100'
082000051028               : ChgCmd
082100051028               : %Size( ChgCmd )
082200051028               : ChgCmdAvl
082300051028               : ERRC0100
082400051028               );
082500051028
082600051029        If  ERRC0100.BytAvl > *Zero;
082700051028          Return  -1;
082800051028
082900051028        Else;
083000051028          Return  0;
083100051028        EndIf;
083200051028
083300051028      /End-Free
083400051028
083500051029     P PrcCmd          E
083600060322     **-- Send completion message:
083700050507     P SndCmpMsg       B
083800050507     D                 Pi            10i 0
083900050507     D  PxMsgDta                    512a   Const  Varying
084000050507     **
084100050507     D MsgKey          s              4a
084200050507
084300050507      /Free
084400050507
084500050507        SndPgmMsg( 'CPF9897'
084600050507                 : 'QCPFMSG   *LIBL'
084700050507                 : PxMsgDta
084800050507                 : %Len( PxMsgDta )
084900050507                 : '*COMP'
085000050507                 : '*PGMBDY'
085100050507                 : 1
085200050507                 : MsgKey
085300050507                 : ERRC0100
085400050507                 );
085500050507
085600050507        If  ERRC0100.BytAvl > *Zero;
085700050507          Return  -1;
085800050507
085900050507        Else;
086000050507          Return  0;
086100050507
086200050507        EndIf;
086300050507
086400050507      /End-Free
086500050507
086600050507     P SndCmpMsg       E
