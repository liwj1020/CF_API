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
005700041207     D PxObjNam        s           1024a   Inz( '/qopensys/MQ/test.pdf' )
005800041207     D PxRtnVal        s             10i 0
005900041207     D fd              s             10i 0
006000041029     D RcdBuf          s           4096a
006100041029     D RcdLin          s           4096a   Varying
006200041029     D IfsFil          s           2048a   Varying
006300041029     D ArcDir          s           1048a   Varying
006400041030     D CmdStr          s            512a   Varying
006500001018     D rc              s             10i 0
006600041029     D Mode            s             10u 0
006700041207     **
006800041207     D bufdta          s          65535a   Based( pbufdta )
006900041029     **
007000041029     D MI_Time         s              8a
007100041029     D MI_DTS          s             20a
007200041030     D DtaModDts       s               z
007300041207     **-- open API constants:
007400041207     D O_RDONLY        c                   1
007500041106     **-- access API constants:
007600041029     D F_OK            c                   0
007700041029     D X_OK            c                   1
007800041029     D W_OK            c                   2
007900041029     D R_OK            c                   4
008000041106     **-- Qp0zCvtToMITime API constants:
008100041029     D CVTTIME_TO_OFFSET...
008200041029     D                 c                   0
008300041029     D CVTTIME_TO_TIMESTAMP...
008400041029     D                 c                   1
008500041029     D CVTTIME_FACTOR_EPOCH_ONLY...
008600041029     D                 c                   2
008700041029     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
008800041029     D                 c                   3
008900041106     **-- mkdir API mode constants:
009000041029     D S_IRUSR         c                   x'00000100'
009100041029     D S_IWUSR         c                   x'00000080'
009200041029     D S_IXUSR         c                   x'00000040'
009300041029     D S_IRWXU         c                   x'000001C0'
009400041029     D S_IRGRP         c                   x'00000020'
009500041029     D S_IWGRP         c                   x'00000010'
009600041029     D S_IXGRP         c                   x'00000008'
009700041029     D S_IRWXG         c                   x'00000038'
009800041029     D S_IROTH         c                   x'00000004'
009900041029     D S_IWOTH         c                   x'00000002'
010000041029     D S_IXOTH         c                   x'00000001'
010100041029     D S_IRWXO         c                   x'00000007'
010200041029     D S_ISUID         c                   x'00000800'
010300041029     D S_ISGID         c                   x'00000400'
010400041029     **-- File stat structure:
010500041029     D Buf             Ds                  Align
010600041029     D  st_mode                      10u 0                                      File permissions
010700041029     D  st_ino                       10u 0                                      File id
010800041029     D  st_nlink                      5u 0                                      Number of links
010900041029     D                                2a
011000041029     D  st_uid                       10u 0                                      File user id
011100041029     D  st_gid                       10u 0                                      File group id
011200041029     D  st_size                      10i 0                                      Size in bytes
011300041029     D  st_atime                     10i 0                                      File last accessed
011400041029     D  st_mtime                     10i 0                                      Data last changed
011500041029     D  st_ctime                     10i 0                                      Status last changed
011600041029     D  st_dev                       10u 0                                      File system id
011700041029     D  st_blksize                   10u 0                                      Blocksize in bytes
011800041029     D  st_allocsize                 10u 0                                      Bytes allocated
011900041029     D  st_objtype                   11a                                        Object type
012000041029     D                                1a
012100041029     D  st_codepage                   5u 0                                      Codepage
012200041029     D  st_reserv1                   62a
012300041029     D  st_ino_gen_id                10u 0                                      File generation id
012400041029     **-- timeval structure:
012500041029     D timeval         Ds                  Qualified
012600041029     D  sec                          10i 0
012700041029     D  usec                         10i 0
012800041029
012900041106     **-- IFS stream file processing functions:
013000041207     D open            Pr            10i 0 ExtProc( 'open' )
013100041207     D  path                           *   Value  Options( *String )
013200041207     D  oflag                        10i 0 Value
013300041207     D  mode                         10i 0 Value  Options( *NoPass )
013400041207     D  codepage                     10i 0 Value  Options( *NoPass )
013500001011     **
013600041207     D read            Pr            10i 0 ExtProc( 'read' )
013700041207     D  fd                           10i 0 Value
013800041207     D  buf                            *   Value
013900041207     D  bufsize                      10i 0 Value
014000020923     **
014100041207     D close           Pr            10i 0 ExtProc( 'close' )
014200041207     D  fd                           10i 0 Value
014300041029     **-- IFS file functions:
014400041029     D access          Pr            10i 0 ExtProc( 'access' )
014500041029     D   Path                          *   Value  Options( *String )
014600041029     D   Amode                       10i 0 Value
014700041029     **
014800041029     D lstat           Pr            10i 0 ExtProc( 'lstat' )
014900041029     D                                 *   Value  Options( *String )
015000041029     D                                 *   Value
015100041029     **
015200041029     D mkdir           Pr            10i 0 ExtProc( 'mkdir' )
015300041029     D                                 *   Value  Options( *String )
015400041029     D                               10u 0 Value
015500041029     **
015600041029     D rename          Pr            10i 0 ExtProc( 'Qp0lRenameUnlink' )
015700041029     D                                 *   Value  Options( *String )
015800041029     D                                 *   Value  Options( *String )
015900041029     **-- Convert timeval to MItime:
016000041029     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
016100041029     D                                 *   Value
016200041029     D                                 *   Value
016300041029     D                               10i 0 Value
016400041029     **-- Convert date & time:
016500041029     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
016600041029     D  CdInpFmt                     10a   Const
016700041029     D  CdInpVar                     17a   Const  Options( *VarSize )
016800041029     D  CdOutFmt                     10a   Const
016900041029     D  CdOutVar                     17a          Options( *VarSize )
017000041029     D  CdError                      10i 0 Const
017100041030     **-- Execute command:
017200041030     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
017300041030     D  XcCmd                       512a   Const  Options( *VarSize )
017400041030     D  XcCmdLen                     15p 5 Const
017500041030     D  XcCmdIGC                      3a   Const  Options( *NoPass )
017600041029
017700041029      /Free
017800041029
017900041105        PxRtnVal = *Zero;
018000041029
018100041207        IfsFil = %Trim( PxObjNam );
018200041105
018300041105        If  lstat( IfsFil: %Addr( Buf )) = -1;
018400041105
018500041105          PxRtnVal = -1;
018600041105        Else;
018700041105
018800041106          //-- Get data modified timestamp:
018900041029          timeval.sec  = st_mtime;
019000041029          timeval.usec = *zero;
019100041029
019200041029          rc = CvtTvToMi( %Addr( MI_Time )
019300041029                        : %Addr( timeval )
019400041029                        : CVTTIME_TO_TIMESTAMP
019500041029                        );
019600041029
019700041029          CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );
019800041029
019900041030          DtaModDts = %Timestamp( MI_DTS: *ISO0 );
020000041105
020100041106          //-- Process IFS file:
020200041207          fd = open( IfsFil: O_RDONLY );
020300041029
020400041207          If  fd = -1;
020500041105            PxRtnVal = -2;
020600041029          Else;
020700041029
020800041207            pbufdta = %Alloc( st_size );
020900041207
021000041207            DoW  read( fd: pbufdta: st_size ) > *Zero;
021100041029
021200041029              ExSr      PrcFilDta;
021300041029            EndDo;
021400041029
021500041207            rc = close( fd );
021600041029          EndIf;
021700041207        EndIf;
021800041030
021900041029
022000041030        *InLr = *On;
022100041029        Return;
022200041029
022300041105
022400041029        BegSr  PrcFilDta;
022500041029
022600041030
022700041207          //-- Process file data here:
022800041106
022900041106
023000041029        EndSr;
023100041029
023200041029      /End-Free
