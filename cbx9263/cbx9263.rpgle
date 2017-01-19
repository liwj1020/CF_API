000100041030     **
000200041104     **  Program . . : CBX9263
000300041030     **  Description : Process IFS file - sample
000400041030     **  Author  . . : Carsten Flensburg
000500041030     **
000600041105     **
000700041105     **  Parameters:
000800041105     **    PxFilNam . :  INPUT   IFS file name; the IFS file to process
000900041105     **
001000041105     **    PxPthNam . :  INPUT   IFS path name; the path used to locate
001100041105     **                          the IFS file
001200041105     **
001300041105     **    PxRtnVal . :  OUTPUT  The return value indicating how the IFS
001400041105     **                          file processing ended:
001500041105     **
001600041105     **                            0 =  IFS file processed succesfully
001700041105     **
001800041105     **                           -1 =  Error occurred while retrieving
001900041105     **                                 IFS file information
002000041105     **
002100041105     **                           -2 =  Error occurred while opening the
002200041105     **                                 IFS file
002300041105     **
002400041105     **
002500041105     **  Program description:
002600041105     **    This program will perform the following processing against
002700041105     **    the specified IFS file:
002800041105     **
002900041105     **    1. Verify the file's existence and retrieve file informaton
003000041105     **       using the lstat IFS API.
003100041105     **
003200041106     **    2. Convert an EPOCH timestamp to a timestamp data type, as an
003300041106     **       example of how to make this type of IFS object information
003400041106     **       available - here it's the data last modified timestamp.
003500041106     **
003600041105     **    3. Open the specified IFS file and read it, line by line.
003700041105     **
003800041105     **    4. Insert your data processing code in subroutine 'PrcFilDta'.
003900041105     **
004000041105     **    5. Close the file and archive it in (move to) a subdirectory
004100041106     **       called 'archive'.  If the 'archive' subdirectory does not
004200041106     **       exists, it is created.  If a file by the same name already
004300041106     **       exists in the archive directory, that file is implicitly
004400041106     **       deleted by the unlink API, prior to moving the new file.
004500041106     **
004600041105     **
004700041030     **  Compile options:
004800041104     **    CrtRpgMod Module( CBX9263 )  DbgView( *LIST )
004900041030     **
005000041104     **    CrtPgm    Pgm( CBX9263 )
005100041104     **              Module( CBX9263 )
005200041030     **
005300041030     **
005400020921     **-- Header specifications:  --------------------------------------------**
005500041029     H Option( *SrcStmt: *NoDebugIo )  BndDir( 'QC2LE' )
005600041029     **-- Global variables:
005700010327     D FILE_i          s               *
005800041029     D RcdBuf          s           4096a
005900041029     D RcdLin          s           4096a   Varying
006000041029     D IfsFil          s           2048a   Varying
006100041029     D ArcDir          s           1048a   Varying
006200041030     D CmdStr          s            512a   Varying
006300001018     D rc              s             10i 0
006400041029     D Mode            s             10u 0
006500041029     **
006600041029     D MI_Time         s              8a
006700041029     D MI_DTS          s             20a
006800041030     D DtaModDts       s               z
006900041106     **-- access API constants:
007000041029     D F_OK            c                   0
007100041029     D X_OK            c                   1
007200041029     D W_OK            c                   2
007300041029     D R_OK            c                   4
007400041106     **-- Qp0zCvtToMITime API constants:
007500041029     D CVTTIME_TO_OFFSET...
007600041029     D                 c                   0
007700041029     D CVTTIME_TO_TIMESTAMP...
007800041029     D                 c                   1
007900041029     D CVTTIME_FACTOR_EPOCH_ONLY...
008000041029     D                 c                   2
008100041029     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
008200041029     D                 c                   3
008300041106     **-- mkdir API mode constants:
008400041029     D S_IRUSR         c                   x'00000100'
008500041029     D S_IWUSR         c                   x'00000080'
008600041029     D S_IXUSR         c                   x'00000040'
008700041029     D S_IRWXU         c                   x'000001C0'
008800041029     D S_IRGRP         c                   x'00000020'
008900041029     D S_IWGRP         c                   x'00000010'
009000041029     D S_IXGRP         c                   x'00000008'
009100041029     D S_IRWXG         c                   x'00000038'
009200041029     D S_IROTH         c                   x'00000004'
009300041029     D S_IWOTH         c                   x'00000002'
009400041029     D S_IXOTH         c                   x'00000001'
009500041029     D S_IRWXO         c                   x'00000007'
009600041029     D S_ISUID         c                   x'00000800'
009700041029     D S_ISGID         c                   x'00000400'
009800041029     **-- File stat structure:
009900041029     D Buf             Ds                  Align
010000041029     D  st_mode                      10u 0                                      File permissions
010100041029     D  st_ino                       10u 0                                      File id
010200041029     D  st_nlink                      5u 0                                      Number of links
010300041029     D                                2a
010400041029     D  st_uid                       10u 0                                      File user id
010500041029     D  st_gid                       10u 0                                      File group id
010600041029     D  st_size                      10i 0                                      Size in bytes
010700041029     D  st_atime                     10i 0                                      File last accessed
010800041029     D  st_mtime                     10i 0                                      Data last changed
010900041029     D  st_ctime                     10i 0                                      Status last changed
011000041029     D  st_dev                       10u 0                                      File system id
011100041029     D  st_blksize                   10u 0                                      Blocksize in bytes
011200041029     D  st_allocsize                 10u 0                                      Bytes allocated
011300041029     D  st_objtype                   11a                                        Object type
011400041029     D                                1a
011500041029     D  st_codepage                   5u 0                                      Codepage
011600041029     D  st_reserv1                   62a
011700041029     D  st_ino_gen_id                10u 0                                      File generation id
011800041029     **-- timeval structure:
011900041029     D timeval         Ds                  Qualified
012000041029     D  sec                          10i 0
012100041029     D  usec                         10i 0
012200041029
012300041106     **-- IFS stream file processing functions:
012400021025     D open            Pr              *   ExtProc( '_C_IFS_fopen' )
012500980417     D                                 *   Value  Options( *String )
012600001011     D                                 *   Value  Options( *String )
012700001011     **
012800021025     D fgets           Pr              *   ExtProc( '_C_IFS_fgets' )
012900001013     D                                 *   Value
013000001011     D                               10i 0 Value
013100001012     D                                 *   Value
013200020923     **
013300021025     D close           Pr            10i 0 ExtProc( '_C_IFS_fclose' )
013400001012     D                                 *   Value
013500041029     **-- IFS file functions:
013600041029     D access          Pr            10i 0 ExtProc( 'access' )
013700041029     D   Path                          *   Value  Options( *String )
013800041029     D   Amode                       10i 0 Value
013900041029     **
014000041029     D lstat           Pr            10i 0 ExtProc( 'lstat' )
014100041029     D                                 *   Value  Options( *String )
014200041029     D                                 *   Value
014300041029     **
014400041029     D mkdir           Pr            10i 0 ExtProc( 'mkdir' )
014500041029     D                                 *   Value  Options( *String )
014600041029     D                               10u 0 Value
014700041029     **
014800041029     D rename          Pr            10i 0 ExtProc( 'Qp0lRenameUnlink' )
014900041029     D                                 *   Value  Options( *String )
015000041029     D                                 *   Value  Options( *String )
015100041029     **-- Convert timeval to MItime:
015200041029     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
015300041029     D                                 *   Value
015400041029     D                                 *   Value
015500041029     D                               10i 0 Value
015600041029     **-- Convert date & time:
015700041029     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
015800041029     D  CdInpFmt                     10a   Const
015900041029     D  CdInpVar                     17a   Const  Options( *VarSize )
016000041029     D  CdOutFmt                     10a   Const
016100041029     D  CdOutVar                     17a          Options( *VarSize )
016200041029     D  CdError                      10i 0 Const
016300041030     **-- Execute command:
016400041030     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
016500041030     D  XcCmd                       512a   Const  Options( *VarSize )
016600041030     D  XcCmdLen                     15p 5 Const
016700041030     D  XcCmdIGC                      3a   Const  Options( *NoPass )
016800041029
016900041029     **-- Entry parameters:
017000041104     D CBX9263         Pr
017100041029     D  PxObjNam                   1024a   Const  Varying
017200041029     D  PxPthNam                   1024a   Const  Varying
017300041105     D  PxRtnVal                     10i 0
017400041029     **
017500041104     D CBX9263         Pi
017600041029     D  PxObjNam                   1024a   Const  Varying
017700041029     D  PxPthNam                   1024a   Const  Varying
017800041105     D  PxRtnVal                     10i 0
017900041029
018000041029      /Free
018100041029
018200041105        PxRtnVal = *Zero;
018300041029
018400041029        IfsFil =  PxPthNam + '/' + PxObjNam;
018500041105
018600041105        If  lstat( IfsFil: %Addr( Buf )) = -1;
018700041105
018800041105          PxRtnVal = -1;
018900041105        Else;
019000041105
019100041106          //-- Get data modified timestamp:
019200041029          timeval.sec  = st_mtime;
019300041029          timeval.usec = *zero;
019400041029
019500041029          rc = CvtTvToMi( %Addr( MI_Time )
019600041029                        : %Addr( timeval )
019700041029                        : CVTTIME_TO_TIMESTAMP
019800041029                        );
019900041029
020000041029          CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );
020100041029
020200041030          DtaModDts = %Timestamp( MI_DTS: *ISO0 );
020300041105
020400041106          //-- Check out IFS file:
020500041030          CmdStr = 'CHKOUT OBJ(''' + IfsFil + ''')';
020600041030
020700041030          ExcCmd( CmdStr: %Len( CmdStr ));
020800041029
020900041106          //-- Process IFS file:
021000041029          FILE_i = open( IfsFil: 'r' );
021100041029
021200041029          If  FILE_i = *Null;
021300041105            PxRtnVal = -2;
021400041029          Else;
021500041029
021600041029            DoW  fgets( %Addr( RcdBuf ): %Size( RcdBuf ): FILE_i ) <> *Null;
021700041029
021800041029              ExSr      PrcFilDta;
021900041029            EndDo;
022000041029
022100041029            rc = close( FILE_i );
022200041029          EndIf;
022300041030
022400041106          //-- Check in IFS file:
022500041030          CmdStr = 'CHKIN OBJ(''' + IfsFil + ''')';
022600041030
022700041030          ExcCmd( CmdStr: %Len( CmdStr ));
022800041029
022900041106          //-- Archive IFS file:
023000041029          ArcDir = PxPthNam + '/archive';
023100041029
023200041029          If  access( ArcDir: F_OK ) = -1;
023300041029            Mode = %BitOr( S_IRWXU: S_IRGRP: S_IROTH );
023400041030
023500041029            rc = Mkdir( ArcDir: Mode );
023600041029          EndIf;
023700041029
023800041029          rc = rename( IfsFil: ArcDir + '/' + PxObjNam );
023900041029        EndIf;
024000041029
024100041030        *InLr = *On;
024200041029        Return;
024300041029
024400041105
024500041029        BegSr  PrcFilDta;
024600041029
024700041029          RcdLin = %Str( %Addr( RcdBuf ));
024800041030
024900041106          //-- Process file data here - line-by-line.
025000041106          //-- Each line includes a suffixed <new line> x'25' character:
025100041106
025200041106
025300041029        EndSr;
025400041029
025500041029      /End-Free
