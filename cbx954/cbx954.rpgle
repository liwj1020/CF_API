000100060316     **
000200060520     **  Program . . : CBX954
000300060520     **  Description : Remove Group Profile - VCP
000400060316     **  Author  . . : Carsten Flensburg
000500060316     **  Published . : Club Tech iSeries System Management Tips Newsletter
000600060316     **
000700060316     **
000800060316     **  Program description:
000900060520     **    This program removes a specified group profile from all user
001000060520     **    profiles that meet the specified selection criteria.
001100060322     **
001200060520     **    If a primary group profile is removed and supplemental group
001300060520     **    profiles exist, the first supplemental group profile becomes the
001400060520     **    new primary group profile, unless the following is true:
001500060520     **
001600060520     **    A group profile name has been specified for the promote to
001700060520     **    primary group parameter, and is found in the supplemental group
001800060520     **    profile array.  In this case the found group profile becomes the
001900060520     **    new primary group profile.
002000060520     **
002100060322     **    A completion status report is written to a spooled file and
002200060322     **    placed in the current job's default output queue.
002300060322     **
002400060316     **
002500060316     **  Compile options:
002600060520     **    CrtRpgMod Module( CBX954 )
002700060316     **              DbgView( *LIST )
002800060316     **
002900060520     **    CrtPgm    Pgm( CBX954 )
003000060520     **              Module( CBX954 )
003100060520     **              ActGrp( CBX954 )
003200060316     **
003300060316     **
003400060316     **-- Control specification:  --------------------------------------------**
003500050319     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
003600051023
003700060316     **-- File specifications:
003800060316     FUSRFILE   IF   F   10        Disk    InfDs( FilInf )  UsrOpn
003900060316     F                                     ExtFile( FilNam )
004000060319     FQSYSPRT   O    F  132        Printer InfDs( PrtLinInf )  OflInd( *InOf )
004100051023
004200060316     **-- Data file information:
004300060316     D FilInf          Ds                  Qualified
004400060316     D  FilNam                       10a   Overlay( FilInf:  83 )
004500060316     D  RcdLen                        5i 0 Overlay( FilInf: 125 )
004600060316     D  MbrNam                       10a   Overlay( FilInf: 129 )
004700060316     D  NbrRcd                       10i 0 Overlay( FilInf: 156 )
004800060316     D  Rrn                          10i 0 Overlay( FilInf: 397 )
004900041212     **-- Printer file information:
005000050212     D PrtLinInf       Ds                  Qualified
005100050212     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
005200050212     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
005300050212     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
005400060316     **-- System information:
005500060316     D PgmSts         Sds                  Qualified
005600060316     D  PgmNam           *Proc
005700060316     D  CurJob                       10a   Overlay( PgmSts: 244 )
005800060316     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
005900060316     D  JobNbr                        6a   Overlay( PgmSts: 264 )
006000060316     D  CurUsr                       10a   Overlay( PgmSts: 358 )
006100051023
006200041211     **-- API error data structure:
006300041211     D ERRC0100        Ds                  Qualified
006400041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
006500041211     D  BytAvl                       10i 0
006600041211     D  MsgId                         7a
006700990921     D                                1a
006800041211     D  MsgDta                      128a
006900060316
007000060316     **-- Input record:
007100060316     D InpRcd          Ds                  Qualified
007200060316     D  UsrPrf                       10a
007300060316     **-- Global constants:
007400060317     D NULL            c                   ''
007500060316     D PRF_USR         c                   '0'
007600060316     D PRF_GRP         c                   '1'
007700060529     D MAX_SUPGRP      c                   15
007800041212     **-- Global variables:
007900060316     D FilNam          s             21a
008000060317     D PrfSts          s             10i 0
008100060317     D CmdSts          s             10i 0
008200060319     D PrfPrc          s             10i 0
008300060319     D PrfChg1         s             10i 0
008400060319     D PrfChg2         s             10i 0
008500051029     D Idx             s             10i 0 Inz
008600060320     D ClsIdx          s             10i 0 Inz
008700041212     D LstTim          s              6s 0
008800050319     D SysNam          s              8a
008900060317     D TrlTxt          s             64a
009000060322     D CrtOwn          s             10a
009100060530     D GrpPrf          s             10a
009200060317     D SupGrps         s            165a   Varying
009300060320     D ChkUsrCls       s             10a   Dim( 5 )
009400060320     **
009500060320     D UsrCls          Ds                  Qualified
009600060320     D  NbrCls                        5i 0
009700060320     D  ClsVal                       10a   Dim( 5 )
009800060316     **
009900060320     D File_q          Ds                  Qualified
010000060320     D  File                         10a
010100060316     D  LibNam                       10a
010200050122     **-- List record:
010300050122     D LstRcd          Ds                  Qualified
010400050507     D  UsrPrf                       10a
010500050507     D  UsrCls                       10a
010600060317     D  GrpPrf                       10a
010700060319     D  PrfSts                       10a
010800060322     D  NbrSpGp                       2s 0
010900060322     D  ChgSts                       75a
011000060316
011100050212     **-- List API parameters:
011200050212     D LstApi          Ds                  Qualified  Inz
011300050212     D  RtnRcdNbr                    10i 0
011400060319     D  GrpPrf                       10a
011500050506     D  SltCri                       10a
011600060319     D  UsrPrf                       10a
011700060317     **-- Retrieve API parameters:
011800060317     D RtvApi          Ds                  Qualified  Inz
011900060317     D  UsrPrf                       10a
012000040426     **-- List information:
012100041211     D LstInf          Ds                  Qualified
012200041211     D  RcdNbrTot                    10i 0
012300041211     D  RcdNbrRtn                    10i 0
012400041211     D  Handle                        4a
012500041211     D  RcdLen                       10i 0
012600041211     D  InfSts                        1a
012700041211     D  Dts                          13a
012800041211     D  LstSts                        1a
012900040426     D                                1a
013000041211     D  InfLen                       10i 0
013100041211     D  Rcd1                         10i 0
013200040426     D                               40a
013300050507     **-- User information:
013400050507     D AUTU0100        Ds                  Qualified
013500050506     D  UsrPrf                       10a
013600050506     D  UsrGrpI                       1a
013700050506     D  GrpMbrI                       1a
013800050507     **-- User information:
013900060316     D USRI0300        Ds          4096    Qualified
014000060316     D  BytRtn                       10i 0
014100060316     D  BytAvl                       10i 0
014200060316     D  UsrPrf                       10a
014300060316     D  PrfSts                       10a   Overlay( USRI0300:  37 )
014400060317     D  NoPwdI                        1a   Overlay( USRI0300:  55 )
014500060317     D  PwdExpI                       1a   Overlay( USRI0300:  73 )
014600060316     D  UsrCls                       10a   Overlay( USRI0300:  74 )
014700060316     D  SpcAut                       15a   Overlay( USRI0300:  84 )
014800060316     D  GrpPrf                       10a   Overlay( USRI0300:  99 )
014900060316     D  LmtCap                       10a   Overlay( USRI0300: 189 )
015000060316     D  OfsSupGrp                    10i 0 Overlay( USRI0300: 585 )
015100060316     D  NbrSupGrp                    10i 0 Overlay( USRI0300: 589 )
015200060319     D  GID                          10i 0 Overlay( USRI0300: 597 )
015300060316     **
015400060529     D SupGrp          s             10a   Dim( MAX_SUPGRP )  Based( pSupGrp )
015500051023
015600050506     **-- Open list of authorized users:
015700050506     D LstAutUsr       Pr                  ExtPgm( 'QGYOLAUS' )
015800051023     D  RcvVar                    65535a          Options( *VarSize )
015900051023     D  RcvVarLen                    10i 0 Const
016000051023     D  LstInf                       80a
016100051023     D  NbrRcdRtn                    10i 0 Const
016200051023     D  FmtNam                        8a   Const
016300051023     D  SltCri                       10a   Const
016400060319     D  GrpPrf                       10a   Const
016500051023     D  Error                      1024a          Options( *VarSize )
016600060319     D  UsrPrf                       10a   Const  Options( *NoPass )
016700041212     **-- Get list entry:
016800020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
016900051023     D  RcvVar                    65535a          Options( *VarSize )
017000051023     D  RcvVarLen                    10i 0 Const
017100051023     D  Handle                        4a   Const
017200051023     D  LstInf                       80a
017300051023     D  NbrRcdRtn                    10i 0 Const
017400051023     D  RtnRcdNbr                    10i 0 Const
017500051023     D  Error                      1024a          Options( *VarSize )
017600041212     **-- Close list:
017700020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
017800051023     D  Handle                        4a   Const
017900051023     D  Error                      1024a          Options( *VarSize )
018000051028     **-- Process commands:
018100051028     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
018200051028     D  SrcCmd                    32702a   Const  Options( *VarSize )
018300051028     D  SrcCmdLen                    10i 0 Const
018400051028     D  OptCtlBlk                    20a   Const
018500051028     D  OptCtlBlkLn                  10i 0 Const
018600051028     D  OptCtlBlkFm                   8a   Const
018700051028     D  ChgCmd                    32767a          Options( *VarSize )
018800051028     D  ChgCmdLen                    10i 0 Const
018900051028     D  ChgCmdLenAvl                 10i 0
019000051028     D  Error                     32767a          Options( *VarSize )
019100050319     **-- Send program message:
019200050319     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
019300051023     D  MsgId                         7a   Const
019400051023     D  MsgFq                        20a   Const
019500051023     D  MsgDta                      128a   Const
019600051023     D  MsgDtaLen                    10i 0 Const
019700051023     D  MsgTyp                       10a   Const
019800051023     D  CalStkE                      10a   Const  Options( *VarSize )
019900051023     D  CalStkCtr                    10i 0 Const
020000051023     D  MsgKey                        4a
020100051023     D  Error                     32767a          Options( *VarSize )
020200050319     **-- Retrieve net attribute:
020300050319     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
020400051023     D  RcvVar                    32767a          Options( *VarSize )
020500051023     D  RcvVarLen                    10i 0 Const
020600051023     D  NbrNetAtr                    10i 0 Const
020700051023     D  NetAtr                       10a   Const  Dim( 256 )
020800050319     D                                            Options( *VarSize )
020900051023     D  Error                     32767a          Options( *VarSize )
021000050506     **-- Retrieve user information:
021100050506     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
021200051023     D  RcvVar                    32767a          Options( *VarSize )
021300051023     D  RcvVarLen                    10i 0 Const
021400051023     D  FmtNam                       10a   Const
021500051023     D  UsrPrf                       10a   Const
021600051023     D  Error                     32767a          Options( *VarSize )
021700050506     **-- Retrieve object description:
021800050506     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
021900051023     D  RcvVar                    32767a         Options( *VarSize )
022000051023     D  RcvVarLen                    10i 0 Const
022100051023     D  FmtNam                        8a   Const
022200051023     D  ObjNamQ                      20a   Const
022300051023     D  ObjTyp                       10a   Const
022400051023     D  Error                     32767a         Options( *VarSize )
022500041212
022600050319     **-- Get system name:
022700050319     D GetSysNam       Pr             8a   Varying
022800060529     **-- Remove supplemental group profile:
022900060529     D RmvSupGrp       Pr           165a   Varying
023000060529     D  PxGrpPrf                     10a
023100060529     D  PxSupGrp                     10a   Dim( MAX_SUPGRP )
023200060529     D  PxNbrSupGrp                  10i 0
023300051028     **-- Process command:
023400051028     D PrcCmd          Pr            10i 0
023500051101     D  PxCmdStr                   1024a   Const  Varying
023600050507     **-- Send completion message:
023700050507     D SndCmpMsg       Pr            10i 0
023800050507     D  PxMsgDta                    512a   Const  Varying
023900051028
024000041216     **-- Write detail line:
024100041216     D WrtDtlLin       Pr
024200050507     **-- Write list header:
024300050507     D WrtLstHdr       Pr
024400050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
024500041216     **-- Write list trailer:
024600041216     D WrtLstTrl       Pr
024700060317     D  PxTrlTxt                     64a   Const
024800041212
024900060316     **-- Entry parameters:
025000060520     D CBX954          Pr
025100060520     D  PxUsrPrf                     10a
025200060530     D  PxRmvGrp                     10a
025300060520     D  PxGrpOwn                     10a
025400060520     D  PxUsrCls                           LikeDs( UsrCls )
025500060530     D  PxPmtGrp                     10a
025600060520     D  PxPrfOpt                      7a
025700060520     D  PxFile_q                           LikeDs( File_q )
025800060316     **
025900060520     D CBX954          Pi
026000060520     D  PxUsrPrf                     10a
026100060530     D  PxRmvGrp                     10a
026200060520     D  PxGrpOwn                     10a
026300060520     D  PxUsrCls                           LikeDs( UsrCls )
026400060530     D  PxPmtGrp                     10a
026500060520     D  PxPrfOpt                      7a
026600060520     D  PxFile_q                           LikeDs( File_q )
026700041211
026800041211      /Free
026900041211
027000060316        If  PxUsrPrf = '*FILE';
027100060316          ExSr  GetFile;
027200060316        Else;
027300060316          ExSr  LstUser;
027400060316        EndIf;
027500060316
027600060316        *InLr = *On;
027700060316        Return;
027800050506
027900060316        BegSr  GetFile;
028000060316
028100060320          FilNam = %TrimR( PxFile_q.LibNam ) + '/' + PxFile_q.File;
028200060316
028300060316          Open  USRFILE;
028400060316          SetLl  *Start  USRFILE;
028500060316
028600060316          Read  USRFILE  InpRcd;
028700060316          DoW  Not %EoF;
028800060316
028900060317            ExSr  GetPrfInf;
029000060316
029100060316            Read  USRFILE  InpRcd;
029200060316          EndDo;
029300060316
029400060316          Close USRFILE;
029500060530
029600060530          If  PrfPrc = *Zero;
029700060530            WrtLstTrl( '(No user profiles met selection criteria)' );
029800060530          EndIf;
029900060530
030000060530          WrtLstTrl( *Blanks );
030100060530          WrtLstTrl( 'Profiles processed . . . . . . :  ' + %Char( PrfPrc ));
030200060530          WrtLstTrl( 'Primary groups removed . . . . :  ' + %Char( PrfChg1 ));
030300060530          WrtLstTrl( 'Supplemental groups removed  . :  ' + %Char( PrfChg2 ));
030400060530          WrtLstTrl( *Blanks );
030500060530          WrtLstTrl( '***  E N D  O F  L I S T  ***' );
030600060530
030700060530          SndCmpMsg( 'Completion status report has been printed.' );
030800060530
030900060316
031000060316        EndSr;
031100050415
031200060316        BegSr  LstUser;
031300060316
031400060316          LstApi.RtnRcdNbr = 1;
031500060319          LstApi.SltCri = '*ALL';
031600060319          LstApi.GrpPrf = '*NONE';
031700060319          LstApi.UsrPrf = PxUsrPrf;
031800060316
031900060316          LstAutUsr( AUTU0100
032000060316                   : %Size( AUTU0100 )
032100060316                   : LstInf
032200060316                   : 1
032300060316                   : 'AUTU0100'
032400060316                   : LstApi.SltCri
032500060319                   : LstApi.GrpPrf
032600060316                   : ERRC0100
032700060319                   : LstApi.UsrPrf
032800060316                   );
032900060316
033000060316          If  ERRC0100.BytAvl = *Zero;
033100060316
033200060316            DoW  LstInf.LstSts <> '2'  Or  LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
033300060316
033400060319              ExSr  GetPrfInf;
033500060316
033600060316              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
033700060316
033800060316              GetLstEnt( AUTU0100
033900060316                       : %Size( AUTU0100 )
034000060316                       : LstInf.Handle
034100060316                       : LstInf
034200060316                       : 1
034300060316                       : LstApi.RtnRcdNbr
034400060316                       : ERRC0100
034500060316                       );
034600060316
034700060316              If  ERRC0100.BytAvl > *Zero;
034800060316                Leave;
034900060316              EndIf;
035000060316
035100060316            EndDo;
035200060316
035300060316            CloseLst( LstInf.Handle: ERRC0100 );
035400060316          EndIf;
035500060319
035600060319          If  PrfPrc = *Zero;
035700060319            WrtLstTrl( '(No user profiles met selection criteria)' );
035800060319          EndIf;
035900060316
036000060319          WrtLstTrl( *Blanks );
036100060319          WrtLstTrl( 'Profiles processed . . . . . . :  ' + %Char( PrfPrc ));
036200060529          WrtLstTrl( 'Primary groups removed . . . . :  ' + %Char( PrfChg1 ));
036300060529          WrtLstTrl( 'Supplemental groups removed  . :  ' + %Char( PrfChg2 ));
036400060319          WrtLstTrl( *Blanks );
036500060316          WrtLstTrl( '***  E N D  O F  L I S T  ***' );
036600060316
036700060323          SndCmpMsg( 'Completion status report has been printed.' );
036800060316
036900060316        EndSr;
037000060316
037100050507        BegSr  GetPrfInf;
037200050507
037300060317          If  PxUsrPrf = '*FILE';
037400060319            RtvApi.UsrPrf = InpRcd.UsrPrf;
037500060317          Else;
037600060319            RtvApi.UsrPrf = AUTU0100.UsrPrf;
037700060317          EndIf;
037800060317
037900050507          RtvUsrInf( USRI0300
038000050507                   : %Size( USRI0300 )
038100050507                   : 'USRI0300'
038200060319                   : RtvApi.UsrPrf
038300050507                   : ERRC0100
038400050507                   );
038500050507
038600060320          Select;
038700060320          When  ERRC0100.BytAvl > *Zero;
038800060319            Clear  USRI0300;
038900060319            USRI0300.UsrPrf = RtvApi.UsrPrf;
039000060320
039100060320            ExSr  ChkPrfInf;
039200060320
039300060320          When  %Lookup( USRI0300.UsrCls: ChkUsrCls: 1: ClsIdx ) > *Zero;
039400060529            ExSr  ChkPrfInf;
039500060320          EndSl;
039600041211
039700041211        EndSr;
039800041211
039900050507        BegSr  ChkPrfInf;
040000060319          PrfPrc += 1;
040100060319          pSupGrp = %Addr( USRI0300 ) + USRI0300.OfsSupGrp;
040200051029
040300060319          Select;
040400060319          When  ERRC0100.BytAvl > *Zero;
040500060319            PrfSts = -1;
040600060319
040700060319          When  USRI0300.GID > *Zero;
040800060319            PrfSts = -2;
040900060319
041000060530          When  USRI0300.GrpPrf = PxRmvGrp;
041100060529            PrfSts = 1;
041200060529
041300060530          When  %Lookup( PxRmvGrp: SupGrp: 1: USRI0300.NbrSupGrp ) > *Zero;
041400060529            PrfSts = 2;
041500060319
041600060319          Other;
041700060529            PrfSts = -3;
041800060319          EndSl;
041900060319
042000060529          If  PrfSts > *Zero;
042100060529            ExSr  RmvGrpPrf;
042200060319          EndIf;
042300060319
042400060319          ExSr WrtPrfInf;
042500050319
042600050319        EndSr;
042700060317
042800060529        BegSr  RmvGrpPrf;
042900060319
043000060530          If  PrfSts = 1;
043100060319            PrfChg1 += 1;
043200060317
043300060323            If  PxPrfOpt = '*UPDATE';
043400060530
043500060530              Select;
043600060530              When  USRI0300.NbrSupGrp = *Zero;
043700060530                GrpPrf = '*NONE';
043800060530                SupGrps = '*NONE';
043900060530
044000060530              When  %Lookup( PxPmtGrp: SupGrp: 1: USRI0300.NbrSupGrp ) > *Zero;
044100060530                GrpPrf = PxPmtGrp;
044200060530                SupGrps = RmvSupGrp( PxPmtGrp: SupGrp: USRI0300.NbrSupGrp );
044300060530
044400060530              Other;
044500060530                GrpPrf = SupGrp(1);
044600060530                SupGrps = RmvSupGrp( SupGrp(1): SupGrp: USRI0300.NbrSupGrp );
044700060530              EndSl;
044800060530
044900060323              CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
045000060323                                %Trim( USRI0300.UsrPrf )    +
045100060323                                ') GRPPRF('                 +
045200060530                                %Trim( GrpPrf )             +
045300060530                                ') SUPGRPPRF('              +
045400060530                                SupGrps                     +
045500060323                                ') OWNER('                  +
045600060323                                %Trim( CrtOwn )             +
045700060323                                ')'
045800060323                              );
045900060323            EndIf;
046000060317          Else;
046100060319            PrfChg2 += 1;
046200060317
046300060324            If  PxPrfOpt = '*UPDATE';
046400060530              SupGrps = RmvSupGrp( PxRmvGrp: SupGrp: USRI0300.NbrSupGrp );
046500060317
046600060323              CmdSts = PrcCmd( 'CHGUSRPRF USRPRF('          +
046700060323                                %Trim( USRI0300.UsrPrf )    +
046800060323                                ') SUPGRPPRF('              +
046900060323                                SupGrps                     +
047000060323                                ') OWNER('                  +
047100060323                                %Trim( CrtOwn )             +
047200060323                                ')'
047300060323                              );
047400060323            EndIf;
047500060317          EndIf;
047600060317
047700060319          Select;
047800060319          When  CmdSts < *Zero;
047900060317            PrfSts = -11;
048000060317
048100060530          When  PrfSts = 1  And  PxPrfOpt = '*UPDATE';
048200060317            SndCmpMsg( 'Group profile '               +
048300060530                       %Trim( PxRmvGrp )              +
048400060530                       ' removed from user profile '  +
048500060317                       %Trim( USRI0300.UsrPrf )       +
048600060317                       '.'
048700060317                     );
048800060319
048900060530          When  PrfSts = 2  And  PxPrfOpt = '*UPDATE';
049000060319            SndCmpMsg( 'Supplemental group profile '  +
049100060530                       %Trim( PxRmvGrp )              +
049200060529                       ' removed from user profile '  +
049300060319                       %Trim( USRI0300.UsrPrf )       +
049400060319                       '.'
049500060319                     );
049600060319          EndSl;
049700060317
049800060317        EndSr;
049900060317
050000050507        BegSr  WrtPrfInf;
050100050507
050200060322          LstRcd.UsrPrf  = USRI0300.UsrPrf;
050300060322          LstRcd.UsrCls  = USRI0300.UsrCls;
050400060322          LstRcd.GrpPrf  = USRI0300.GrpPrf;
050500060322          LstRcd.NbrSpGp = USRI0300.NbrSupGrp;
050600060322          LstRcd.PrfSts  = USRI0300.PrfSts;
050700050507
050800060319          Select;
050900060319          When  PrfSts = -1;
051000060319            LstRcd.ChgSts = 'Error occurred when retrieving user profile data.';
051100060319
051200060319          When  PrfSts = -2;
051300060321            LstRcd.ChgSts = 'User profile is a group profile.';
051400060319
051500060319          When  PrfSts = -3;
051600060530            LstRcd.ChgSts = 'Specified group profile not assigned.';
051700060319
051800060319          When  PrfSts = -11;
051900060319            LstRcd.ChgSts = 'Change user profile command failed.';
052000060319
052100060530          When  PrfSts = 1;
052200060530            LstRcd.ChgSts = 'Group profile removed as primary group.';
052300060319
052400060530          When  PrfSts = 2;
052500060530            LstRcd.ChgSts = 'Group profile removed as supplemental group.';
052600060319          EndSl;
052700060319
052800050507          WrtDtlLin();
052900050507
053000050507        EndSr;
053100050507
053200041212        BegSr  *InzSr;
053300051029
053400060320          For  Idx = 1  to PxUsrCls.NbrCls;
053500060320
053600060320            Select;
053700060320            When  PxUsrCls.ClsVal(Idx) = '*ALL';
053800060320              ChkUsrCls(1) = '*USER';
053900060320              ChkUsrCls(2) = '*PGMR';
054000060320              ChkUsrCls(3) = '*SYSOPR';
054100060320              ChkUsrCls(4) = '*SECADM';
054200060320              ChkUsrCls(5) = '*SECOFR';
054300060320              ClsIdx = 5;
054400060320
054500060320            When  PxUsrCls.ClsVal(Idx) = '*NONUSER';
054600060320              ChkUsrCls(1) = '*PGMR';
054700060320              ChkUsrCls(2) = '*SYSOPR';
054800060320              ChkUsrCls(3) = '*SECADM';
054900060320              ChkUsrCls(4) = '*SECOFR';
055000060320              ClsIdx = 4;
055100060320
055200060320            Other;
055300060320              ChkUsrCls(Idx) = PxUsrCls.ClsVal(Idx);
055400060320              ClsIdx += 1;
055500060320            EndSl;
055600060320          EndFor;
055700060322
055800060322          Select;
055900060322          When  PxGrpOwn = '*SAME';
056000060322            CrtOwn = '*SAME';
056100060322
056200060322          When  PxGrpOwn = '*YES';
056300060322            CrtOwn = '*GRPPRF';
056400060322
056500060322          When  PxGrpOwn = '*NO';
056600060322            CrtOwn = '*USRPRF';
056700060322          EndSl;
056800060320
056900041212          LstTim = %Int( %Char( %Time(): *ISO0));
057000050319          SysNam = GetSysNam();
057100050507
057200050507          WrtLstHdr();
057300041212
057400041212        EndSr;
057500041212
057600050122      /End-Free
057700050122
057800041212     **-- Printer file definition:  ------------------------------------------**
057900041212     OQSYSPRT   EF           Header         2  2
058000041212     O                       UDATE         Y      8
058100041212     O                       LstTim              18 '  :  :  '
058200050319     O                                           36 'System:'
058300050319     O                       SysNam              45
058400060530     O                                           89 'Remove group profile -
058500060529     O                                              completion report'
058600041212     O                                          107 'Program:'
058700050319     O                       PgmSts.PgmNam      118
058800041212     O                                          126 'Page:'
058900041212     O                       PAGE             +   1
059000050415     **
059100051029     OQSYSPRT   EF           LstHdr         1
059200060530     O                                           27 'User profile  . . . . . . -
059300060530     O                                              :'
059400060319     O                       PxUsrPrf            39
059500060320     O                       PxFile_q.File       50
059600060530     O                                           80 'User classes to select  . -
059700060530     O                                              :'
059800060320     O                       ChkUsrCls          132
059900051029     **
060000060323     OQSYSPRT   EF           LstHdr         1
060100060529     O                                           27 'Group profile to remove . -
060200051029     O                                              :'
060300060530     O                       PxRmvGrp            39
060400060530     O                                           80 'Group ownership . . . . . -
060500060530     O                                              :'
060600060530     O                       PxGrpOwn            92
060700060323     OQSYSPRT   EF           LstHdr         2
060800060530     O                                           27 'Group profile to promote  -
060900060530     O                                              :'
061000060530     O                       PxPmtGrp            39
061100060323     O                                           80 'User profile option . . . -
061200060323     O                                              :'
061300060323     O                       PxPrfOpt            89
061400051029     **
061500041212     OQSYSPRT   EF           LstHdr         1
061600050507     O                                            4 'User'
061700050507     O                                           17 'Class'
061800051029     O                                           28 'Group'
061900060322     O                                           43 'Sup.grp.'
062000060322     O                                           51 'Status'
062100060322     O                                           70 'Change status'
062200041216     **
062300041212     OQSYSPRT   EF           DtlLin         1
062400050507     O                       LstRcd.UsrPrf       10
062500050507     O                       LstRcd.UsrCls       22
062600051029     O                       LstRcd.GrpPrf       33
062700060322     O                       LstRcd.NbrSpGp3     41
062800060322     O                       LstRcd.PrfSts       55
062900060319     O                       LstRcd.ChgSts      132
063000041212     **
063100050123     OQSYSPRT   EF           LstTrl         1
063200060317     O                       TrlTxt              66
063300041216     **-- Write detail line:  ------------------------------------------------**
063400041216     P WrtDtlLin       B
063500041212     D                 Pi
063600041212
063700041212      /Free
063800041212
063900050507        WrtLstHdr( 3 );
064000041212
064100041216        Except  DtlLin;
064200041212
064300041212      /End-Free
064400041212
064500041216     P WrtDtlLin       E
064600060322     **-- Write list header:
064700050507     P WrtLstHdr       B
064800050507     D                 Pi
064900050507     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
065000050507
065100050507      /Free
065200050507
065300050507        If  %Parms = *Zero;
065400050507
065500050507          Except  Header;
065600050507          Except  LstHdr;
065700050507        Else;
065800050507
065900050507          If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;
066000050507
066100050507            Except  Header;
066200050507            Except  LstHdr;
066300050507          EndIf;
066400050507        EndIf;
066500050507
066600050507      /End-Free
066700050507
066800050507     P WrtLstHdr       E
066900060322     **-- Write list trailer:
067000041216     P WrtLstTrl       B
067100041216     D                 Pi
067200060317     D  PxTrlTxt                     64a   Const
067300041216
067400041216      /Free
067500041216
067600050415        TrlTxt = PxTrlTxt;
067700050415
067800041216        Except  LstTrl;
067900041216
068000041216      /End-Free
068100041216
068200041216     P WrtLstTrl       E
068300060322     **-- Get system name:
068400050319     P GetSysNam       B
068500050319     D                 Pi             8a   Varying
068600051029
068700050319     **-- Local variables:
068800050319     D Idx             s             10i 0
068900050319     D SysNam          s              8a   Varying
069000050319     **
069100050319     D RtnAtrLen       s             10i 0
069200050319     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
069300050319     D NetAtr          s             10a   Dim( 1 )
069400050319     **
069500050319     D RtnVar          Ds                  Qualified
069600050319     D  RtnVarNbr                    10i 0
069700050319     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
069800050319     D  RtnVarDta                  1024a
069900050319
070000050319     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
070100050319     D  AtrNam                       10a
070200050319     D  DtaTyp                        1a
070300050319     D  InfSts                        1a
070400050319     D  AtrLen                       10i 0
070500050319     D  Atr                        1008a
070600050319
070700050319      /Free
070800050319
070900050319        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;
071000050319
071100050319        NetAtr(1) = 'SYSNAME';
071200050319
071300050319        RtvNetAtr( RtnVar
071400050319                 : RtnAtrLen
071500050319                 : NetAtrNbr
071600050319                 : NetAtr
071700050319                 : ERRC0100
071800050319                 );
071900050319
072000050319        If  ERRC0100.BytAvl > *Zero;
072100050319          SysNam = '';
072200050319
072300050319        Else;
072400050319          For  Idx = 1  to RtnVar.RtnVarNbr;
072500050319
072600050319            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);
072700050319
072800050319            If  RtnAtr.AtrNam = 'SYSNAME';
072900050319              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
073000050319            EndIf;
073100050319
073200050319          EndFor;
073300050319        EndIf;
073400050319
073500050319        Return  SysNam;
073600050319
073700050319      /End-Free
073800050319
073900050319     P GetSysNam       E
074000060529     **-- Remove supplemental group profile:
074100060529     P RmvSupGrp       B
074200060529     D                 Pi           165a   Varying
074300060529     D  PxGrpPrf                     10a
074400060529     D  PxSupGrp                     10a   Dim( MAX_SUPGRP )
074500060529     D  PxNbrSupGrp                  10i 0
074600060529
074700060529     D Idx             s             10i 0
074800060529     D SupGrps         s            165a   Varying  Inz( NULL )
074900060529
075000060529      /Free
075100060529
075200060529        For  Idx = 1  to  PxNbrSupGrp;
075300060529
075400060529          If  PxGrpPrf <> PxSupGrp(Idx);
075500060529            SupGrps += %TrimR( PxSupGrp(Idx)) + ' ';
075600060529          EndIf;
075700060529        EndFor;
075800060530
075900060530        If SupGrps = NULL;
076000060530          SupGrps = '*NONE';
076100060530        EndIf;
076200060529
076300060529        Return  %TrimR( SupGrps );
076400060529
076500060529      /End-Free
076600060529
076700060529     P RmvSupGrp       E
076800060322     **-- Process command:
076900051028     P PrcCmd          B                   Export
077000051028     D                 Pi            10i 0
077100051028     D  PxCmdStr                   1024a   Const  Varying
077200051028
077300051028     **-- Local variables:
077400051028     D CPOP0100        Ds                  Qualified
077500051028     D  TypPrc                       10i 0 Inz( 2 )
077600051028     D  DBCS                          1a   Inz( '0' )
077700051028     D  PmtAct                        1a   Inz( '2' )
077800051028     D  CmdStx                        1a   Inz( '0' )
077900051028     D  MsgRtvKey                     4a   Inz( *Allx'00' )
078000051028     D  Rsv                           9a   Inz( *Allx'00' )
078100051028     **
078200051028     D ChgCmd          s          32767a
078300051028     D ChgCmdAvl       s             10i 0
078400051028
078500051028      /Free
078600060319
078700051028        PrcCmds( PxCmdStr
078800051028               : %Len( PxCmdStr )
078900051028               : CPOP0100
079000051028               : %Size( CPOP0100 )
079100051028               : 'CPOP0100'
079200051028               : ChgCmd
079300051028               : %Size( ChgCmd )
079400051028               : ChgCmdAvl
079500051028               : ERRC0100
079600051028               );
079700051028
079800051029        If  ERRC0100.BytAvl > *Zero;
079900051028          Return  -1;
080000051028
080100051028        Else;
080200051028          Return  0;
080300051028        EndIf;
080400051028
080500051028      /End-Free
080600051028
080700051029     P PrcCmd          E
080800060322     **-- Send completion message:
080900050507     P SndCmpMsg       B
081000050507     D                 Pi            10i 0
081100050507     D  PxMsgDta                    512a   Const  Varying
081200050507     **
081300050507     D MsgKey          s              4a
081400050507
081500050507      /Free
081600050507
081700050507        SndPgmMsg( 'CPF9897'
081800050507                 : 'QCPFMSG   *LIBL'
081900050507                 : PxMsgDta
082000050507                 : %Len( PxMsgDta )
082100050507                 : '*COMP'
082200050507                 : '*PGMBDY'
082300050507                 : 1
082400050507                 : MsgKey
082500050507                 : ERRC0100
082600050507                 );
082700050507
082800050507        If  ERRC0100.BytAvl > *Zero;
082900050507          Return  -1;
083000050507
083100050507        Else;
083200050507          Return  0;
083300050507
083400050507        EndIf;
083500050507
083600050507      /End-Free
083700050507
083800050507     P SndCmpMsg       E
