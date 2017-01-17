000100041110     **
000200060316     **  Program . . : CBX953V
000300060316     **  Description : Add Group Profile - VCP
000400041110     **  Author  . . : Carsten Flensburg
000500060316     **  Published . : Club Tech iSeries System Management Tips Newsletter
000600041110     **
000700041110     **
000800041110     **  Program description:
000900060316     **    Validity checking program for the Add Group Profile
001000060316     **    (ADDGRPPRF) command.
001100050804     **
001200050804     **
001300031115     **  Compile options:
001400060316     **    CrtRpgMod Module( CBX953V )
001500040722     **              DbgView( *LIST )
001600031115     **
001700060324     **    CrtPgm    Pgm( CBX953V )
001800060316     **              Module( CBX953V )
001900060316     **              ActGrp( CBX953 )
002000031115     **
002100031115     **
002200040605     **-- Control specification:  --------------------------------------------**
002300050804     H Option( *SrcStmt )
002400040722
002500050803     **-- System information:
002600050803     D PgmSts         SDs                  Qualified
002700050803     D  PgmNam           *Proc
002800050803     D  CurJob                       10a   Overlay( PgmSts: 244 )
002900050803     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
003000050803     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003100050803     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003200040728     **-- API error data structure:
003300040728     D ERRC0100        Ds                  Qualified
003400040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003500040728     D  BytAvl                       10i 0
003600040728     D  ExcpId                        7a
003700040728     D                                1a
003800040728     D  ExcpDta                     512a
003900060316
004000060316     **-- Global constants:
004100060316     D ADP_PRV_INVLVL  c                   1
004200040722     **-- Global variables:
004300050803     D AutFlg          s              1a
004400060316     D SpcAut          s             10a   Dim( 8 )
004500060316     D FilNamRtn_q     s             20a
004600060320     **
004700060320     D UsrCls          Ds                  Qualified
004800060320     D  NbrCls                        5i 0
004900060320     D  ClsVal                       10a   Dim( 5 )
005000050803     **
005100060320     D File_q          Ds                  Qualified
005200060316     D  FilNam                       10a
005300060316     D  LibNam                       10a
005400060316     **-- FILD0100 format - partial:
005500060316     D Qdb_Qdbfh       Ds           512    Qualified
005600060316     D  Qdbfyret                     10i 0
005700060316     D  Qdbfyavl                     10i 0
005800060316     D  Qdbfhflg                      2a
005900060316     D  Reserved_7                    4a
006000060316     D  Qdbflbnum                     5i 0
006100060316     D  Qdbfkdat                     14a
006200060316     D  Qdbfhaut                     10a
006300060316     D  Qdbfhupl                      1a
006400060316     D  Qdbfhmxm                      5i 0
006500060316     D  Qdbfwtfi                      5i 0
006600060316     D  Qdbfhfrt                      5i 0
006700060316     D  Qdbfhmnum                     5i 0
006800060316     D  Reserved_11                   9a
006900060316     D  Qdbfbrwt                      5i 0
007000060316     D  Qaaf                          1a
007100060316     D  Qdbffmtnum                    5i 0
007200060316     D  Qdbfhfl2                      2a
007300060316     D  Qdbfvrm                       5i 0
007400060316     D  Qaaf2                         2a
007500060316     D  Qdbfhcrt                     13a
007600060316     D  Qdbfhtx                      52a
007700060316     D  Reserved_19                  13a
007800060316     D  Qdbfsrc                      30a
007900060316     D  Qdbfkrcv                      1a
008000060316     D  Reserved_20                  23a
008100060316     D  Qdbftcid                      5i 0
008200060316     D  Qdbfasp                       2a
008300060316     D  Qdbfnbit                      1a
008400060316     D  Qdbfmxfnum                    5i 0
008500060316     D  Reserved_22                  76a
008600060316     D  Qdbfodic                     10i 0
008700060316     D  Reserved_23                  14a
008800060316     D  Qdbffigl                      5i 0
008900060316     D  Qdbfmxrl                      5i 0
009000050731
009100050802     **-- Check special authority
009200050802     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
009300050802     D  AutInf                        1a
009400050802     D  UsrPrf                       10a   Const
009500050802     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
009600050802     D  NbrAut                       10i 0 Const
009700050802     D  CalLvl                       10i 0 Const
009800050802     D  Error                     32767a          Options( *VarSize )
009900060316     **-- Retrieve object description:
010000060316     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
010100060316     D  RcvVar                    32767a          Options( *VarSize )
010200060316     D  RcvVarLen                    10i 0 Const
010300060316     D  FmtNam                        8a   Const
010400060316     D  ObjNamQ                      20a   Const
010500060316     D  ObjTyp                       10a   Const
010600060316     D  Error                     32767a          Options( *VarSize )
010700060316     **-- Retrieve user information:
010800060316     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
010900060316     D  RcvVar                    32767a          Options( *VarSize )
011000060316     D  RcvVarLen                    10i 0 Const
011100060316     D  FmtNam                       10a   Const
011200060316     D  UsrPrf                       10a   Const
011300060316     D  Error                     32767a          Options( *VarSize )
011400060316     **-- Retrieve database file description:
011500060316     D RtvDbfDsc       Pr                  ExtPgm( 'QDBRTVFD' )
011600060316     D  RcvVar                    32767a          Options( *VarSize )
011700060316     D  RcvVarLen                    10i 0 Const
011800060316     D  FilNamRtnQ                   20a
011900060316     D  FmtNam                        8a   Const
012000060316     D  FilNamQ                      20a   Const
012100060316     D  RcdFmtNam                    10a   Const
012200060316     D  OvrPrc                        1a   Const
012300060316     D  System                       10a   Const
012400060316     D  FmtTyp                       10a   Const
012500060316     D  Error                     32767a          Options( *VarSize )
012600040728     **-- Send program message:
012700040728     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
012800050802     D  MsgId                         7a   Const
012900050802     D  MsgFq                        20a   Const
013000050802     D  MsgDta                      128a   Const
013100050802     D  MsgDtaLen                    10i 0 Const
013200050802     D  MsgTyp                       10a   Const
013300050802     D  CalStkE                      10a   Const  Options( *VarSize )
013400050802     D  CalStkCtr                    10i 0 Const
013500050802     D  MsgKey                        4a
013600050802     D  Error                      1024a          Options( *VarSize )
013700040722
013800060316     **-- Check object existence:
013900060316     D ChkObj          Pr              n
014000060316     D  PxObjNam                     10a   Const
014100060316     D  PxObjLib                     10a   Const
014200060316     D  PxObjTyp                     10a   Const
014300060322     **-- Get creating user profile:
014400060322     D GetCrtUsr       Pr            10a
014500060322     D  PxUsrPrf                     10a   Value
014600060316     **-- Get user profile GID:
014700060316     D GetPrfGid       Pr            10i 0
014800060316     D  PxUsrPrf                     10a   Const
014900040728     **-- Send diagnostic message:
015000040728     D SndDiagMsg      Pr            10i 0
015100040722     D  PxMsgId                       7a   Const
015200040722     D  PxMsgDta                    512a   Const  Varying
015300040728     **-- Send escape message:
015400040728     D SndEscMsg       Pr            10i 0
015500040728     D  PxMsgId                       7a   Const
015600040728     D  PxMsgDta                    512a   Const  Varying
015700040722
015800040722     **-- Entry parameters:
015900060316     D CBX953V         Pr
016000060316     D  PxUsrPrf                     10a
016100060320     D  PxNewGrpPrf                  10a
016200060322     D  PxGrpOwn                     10a
016300060320     D  PxUsrCls                           LikeDs( UsrCls )
016400060320     D  PxGrpPrf                     10a
016500060323     D  PxRplPriGrp                   4a
016600060323     D  PxPrfOpt                      7a
016700060320     D  PxFile_q                           LikeDs( File_q )
016800050731     **
016900060316     D CBX953V         Pi
017000060316     D  PxUsrPrf                     10a
017100060320     D  PxNewGrpPrf                  10a
017200060322     D  PxGrpOwn                     10a
017300060320     D  PxUsrCls                           LikeDs( UsrCls )
017400060320     D  PxGrpPrf                     10a
017500060323     D  PxRplPriGrp                   4a
017600060323     D  PxPrfOpt                      7a
017700060320     D  PxFile_q                           LikeDs( File_q )
017800040721
017900040724      /Free
018000050804
018100060316        SpcAut( 1 ) = '*SECADM';
018200060316        SpcAut( 2 ) = '*ALLOBJ';
018300060316
018400050802        ChkSpcAut( AutFlg
018500050802                 : PgmSts.UsrPrf
018600060316                 : SpcAut
018700060316                 : 2
018800050802                 : ADP_PRV_INVLVL
018900050802                 : ERRC0100
019000050802                 );
019100050802
019200050802        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
019300050802          SndDiagMsg( 'CPD0006'
019400060316                    : '0000Special authority *SECADM and *ALLOBJ required.'
019500050802                    );
019600060322
019700050802          SndEscMsg( 'CPF0002': '' );
019800050802        EndIf;
019900060316
020000060320        If  ChkObj( PxNewGrpPrf: '*LIBL': '*USRPRF' ) = *Off;
020100060316          SndDiagMsg( 'CPD0006': '0000Group profile does not exist.' );
020200060316          SndEscMsg( 'CPF0002': '' );
020300060316        EndIf;
020400060322
020500060322        If  GetCrtUsr( PxNewGrpPrf ) = '*IBM';
020600060322          SndDiagMsg( 'CPD0006'
020700060322                    : '0000Group profile cannot be a system profile.'
020800060322                    );
020900060322
021000060322          SndEscMsg( 'CPF0002': '' );
021100060322        EndIf;
021200060322
021300060322        If  %Subst( PxNewGrpPrf: 1: 1 ) = 'Q';
021400060322          SndDiagMsg( 'CPD0006'
021500060322                    : '0000Group profile cannot be a system profile.'
021600060322                    );
021700060322
021800060322          SndEscMsg( 'CPF0002': '' );
021900060322        EndIf;
022000060316
022100060320        If  GetPrfGid( PxNewGrpPrf ) = *Zero;
022200060316          SndDiagMsg( 'CPD0006': '0000Group profile is not correct type.' );
022300060316          SndEscMsg( 'CPF0002': '' );
022400060316        EndIf;
022500060316
022600060316        If  PxUsrPrf = '*FILE';
022700060316
022800060316          If  ChkObj( PxFile_q.FilNam: PxFile_q.LibNam: '*FILE' ) = *Off;
022900060316            SndDiagMsg( 'CPD0006': '0000Specified file does not exist.' );
023000060316            SndEscMsg( 'CPF0002': '' );
023100060316          EndIf;
023200060316
023300060316          RtvDbfDsc( Qdb_Qdbfh
023400060316                   : %Size( Qdb_Qdbfh )
023500060316                   : FilNamRtn_q
023600060316                   : 'FILD0100'
023700060316                   : PxFile_q
023800060316                   : '*FIRST'
023900060316                   : '0'
024000060316                   : '*LCL'
024100060316                   : '*EXT'
024200060316                   : ERRC0100
024300060316                   );
024400060316
024500060316          If  ERRC0100.BytAvl > *Zero  Or  Qdb_qdbfh.Qdbfmxrl <> 10;
024600060316            SndDiagMsg( 'CPD0006'
024700060316                      : '0000File must have a record length of 10 bytes.'
024800060316                      );
024900060316
025000060316            SndEscMsg( 'CPF0002': '' );
025100060316          EndIf;
025200060316        EndIf;
025300050408
025400040605        *InLr = *On;
025500040605        Return;
025600040605
025700040721      /End-Free
025800040721
025900060316     **-- Check object existence:  -------------------------------------------**
026000060316     P ChkObj          B
026100060316     D                 Pi              n
026200060316     D  PxObjNam                     10a   Const
026300060316     D  PxObjLib                     10a   Const
026400060316     D  PxObjTyp                     10a   Const
026500060316     **
026600060316     D OBJD0100        Ds                  Qualified
026700060316     D  BytRtn                       10i 0
026800060316     D  BytAvl                       10i 0
026900060316     D  ObjNam                       10a
027000060316     D  ObjLib                       10a
027100060316     D  ObjTyp                       10a
027200060316
027300060316      /Free
027400060316
027500060316         RtvObjD( OBJD0100
027600060316                : %Size( OBJD0100 )
027700060316                : 'OBJD0100'
027800060316                : PxObjNam + PxObjLib
027900060316                : PxObjTyp
028000060316                : ERRC0100
028100060316                );
028200060316
028300060316         If  ERRC0100.BytAvl > *Zero;
028400060316           Return  *Off;
028500060316
028600060316         Else;
028700060316           Return  *On;
028800060316         EndIf;
028900060316
029000060316      /End-Free
029100060316
029200060316     P ChkObj          E
029300060322     **-- Get creating user profile:
029400060322     P GetCrtUsr       B
029500060322     D                 Pi            10a
029600060322     D  PxUsrPrf                     10a   Value
029700060322     **
029800060322     D OBJD0300        Ds                  Qualified
029900060322     D  BytRtn                       10i 0
030000060322     D  BytAvl                       10i 0
030100060322     D  ObjCrt                       10a   Overlay( OBJD0300: 220 )
030200060322
030300060322      /Free
030400060322
030500060322        RtvObjD( OBJD0300
030600060322               : %Size( OBJD0300 )
030700060322               : 'OBJD0300'
030800060322               : PxUsrPrf + 'QSYS'
030900060322               : '*USRPRF'
031000060322               : ERRC0100
031100060322               );
031200060322
031300060322        If  ERRC0100.BytAvl > *Zero;
031400060322          Return  *Blanks;
031500060322
031600060322        Else;
031700060322          Return  OBJD0300.ObjCrt;
031800060322        EndIf;
031900060322
032000060322      /End-Free
032100060322
032200060322     P GetCrtUsr       E
032300060316     **-- Get user profile GID:
032400060316     P GetPrfGid       B
032500060316     D                 Pi            10i 0
032600060316     D  PxUsrPrf                     10a   Const
032700060316
032800060316     **-- User information:
032900060316     D USRI0300        Ds                  Qualified
033000060316     D  BytRtn                       10i 0
033100060316     D  BytAvl                       10i 0
033200060316     D  GID                          10i 0 Overlay( USRI0300: 597 )
033300060316
033400060316      /Free
033500060316
033600060316          RtvUsrInf( USRI0300
033700060316                   : %Size( USRI0300 )
033800060316                   : 'USRI0300'
033900060316                   : PxUsrPrf
034000060316                   : ERRC0100
034100060316                   );
034200060316
034300060316         If  ERRC0100.BytAvl > *Zero;
034400060316           Return  *Zero;
034500060316
034600060316         Else;
034700060316           Return  USRI0300.GID;
034800060316         EndIf;
034900060316
035000060316      /End-Free
035100060316
035200060316     P GetPrfGid       E
035300060316     **-- Send diagnostic message:
035400040728     P SndDiagMsg      B
035500040722     D                 Pi            10i 0
035600040722     D  PxMsgId                       7a   Const
035700040722     D  PxMsgDta                    512a   Const  Varying
035800040722     **
035900040722     D MsgKey          s              4a
036000040722
036100040722      /Free
036200040722
036300040722        SndPgmMsg( PxMsgId
036400040722                 : 'QCPFMSG   *LIBL'
036500040722                 : PxMsgDta
036600040722                 : %Len( PxMsgDta )
036700040728                 : '*DIAG'
036800040722                 : '*PGMBDY'
036900040722                 : 1
037000040722                 : MsgKey
037100040722                 : ERRC0100
037200040722                 );
037300040722
037400040722        If  ERRC0100.BytAvl > *Zero;
037500040722          Return  -1;
037600040722
037700040722        Else;
037800040722          Return   0;
037900040722        EndIf;
038000040722
038100040722      /End-Free
038200040722
038300040728     P SndDiagMsg      E
038400060316     **-- Send escape message:
038500040728     P SndEscMsg       B
038600040728     D                 Pi            10i 0
038700040728     D  PxMsgId                       7a   Const
038800040728     D  PxMsgDta                    512a   Const  Varying
038900040728     **
039000040728     D MsgKey          s              4a
039100040728
039200040728      /Free
039300040728
039400040728        SndPgmMsg( PxMsgId
039500040728                 : 'QCPFMSG   *LIBL'
039600040728                 : PxMsgDta
039700040728                 : %Len( PxMsgDta )
039800040728                 : '*ESCAPE'
039900040728                 : '*PGMBDY'
040000040728                 : 1
040100040728                 : MsgKey
040200040728                 : ERRC0100
040300040728                 );
040400040728
040500040728        If  ERRC0100.BytAvl > *Zero;
040600040728          Return  -1;
040700040728
040800040728        Else;
040900040728          Return   0;
041000040728        EndIf;
041100040728
041200040728      /End-Free
041300040728
041400040728     P SndEscMsg       E
