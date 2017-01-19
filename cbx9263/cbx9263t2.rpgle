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
005700041207     D PxObjNam        s           1024a   Inz( '/qopensys/MQ/Buchungsanl_Cente-
005800041207     D                                     r_Parcs.pdf' )
005900041207     D PxRtnVal        s             10i 0
006000041207     D fd              s             10i 0
006100041029     D RcdBuf          s           4096a
006200041029     D RcdLin          s           4096a   Varying
006300041029     D IfsFil          s           2048a   Varying
006400041029     D ArcDir          s           1048a   Varying
006500041030     D CmdStr          s            512a   Varying
006600001018     D rc              s             10i 0
006700041029     D Mode            s             10u 0
006800041207     **
006900041207     D bufdta          s          65535a   Based( pbufdta )
007000041029     **
007100041029     D MI_Time         s              8a
007200041029     D MI_DTS          s             20a
007300041030     D DtaModDts       s               z
007400041207     **-- open API constants:
007500041207     D O_RDONLY        c                   1
007600041106     **-- access API constants:
007700041029     D F_OK            c                   0
007800041029     D X_OK            c                   1
007900041029     D W_OK            c                   2
008000041029     D R_OK            c                   4
008100041106     **-- Qp0zCvtToMITime API constants:
008200041029     D CVTTIME_TO_OFFSET...
008300041029     D                 c                   0
008400041029     D CVTTIME_TO_TIMESTAMP...
008500041029     D                 c                   1
008600041029     D CVTTIME_FACTOR_EPOCH_ONLY...
008700041029     D                 c                   2
008800041029     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
008900041029     D                 c                   3
009000041106     **-- mkdir API mode constants:
009100041029     D S_IRUSR         c                   x'00000100'
009200041029     D S_IWUSR         c                   x'00000080'
009300041029     D S_IXUSR         c                   x'00000040'
009400041029     D S_IRWXU         c                   x'000001C0'
009500041029     D S_IRGRP         c                   x'00000020'
009600041029     D S_IWGRP         c                   x'00000010'
009700041029     D S_IXGRP         c                   x'00000008'
009800041029     D S_IRWXG         c                   x'00000038'
009900041029     D S_IROTH         c                   x'00000004'
010000041029     D S_IWOTH         c                   x'00000002'
010100041029     D S_IXOTH         c                   x'00000001'
010200041029     D S_IRWXO         c                   x'00000007'
010300041029     D S_ISUID         c                   x'00000800'
010400041029     D S_ISGID         c                   x'00000400'
010500041029     **-- File stat structure:
010600041029     D Buf             Ds                  Align
010700041029     D  st_mode                      10u 0                                      File permissions
010800041029     D  st_ino                       10u 0                                      File id
010900041029     D  st_nlink                      5u 0                                      Number of links
011000041029     D                                2a
011100041029     D  st_uid                       10u 0                                      File user id
011200041029     D  st_gid                       10u 0                                      File group id
011300041029     D  st_size                      10i 0                                      Size in bytes
011400041029     D  st_atime                     10i 0                                      File last accessed
011500041029     D  st_mtime                     10i 0                                      Data last changed
011600041029     D  st_ctime                     10i 0                                      Status last changed
011700041029     D  st_dev                       10u 0                                      File system id
011800041029     D  st_blksize                   10u 0                                      Blocksize in bytes
011900041029     D  st_allocsize                 10u 0                                      Bytes allocated
012000041029     D  st_objtype                   11a                                        Object type
012100041029     D                                1a
012200041029     D  st_codepage                   5u 0                                      Codepage
012300041029     D  st_reserv1                   62a
012400041029     D  st_ino_gen_id                10u 0                                      File generation id
012500041029     **-- timeval structure:
012600041029     D timeval         Ds                  Qualified
012700041029     D  sec                          10i 0
012800041029     D  usec                         10i 0
012900041029
013000041106     **-- IFS stream file processing functions:
013100041207     D open            Pr            10i 0 ExtProc( 'open' )
013200041207     D  path                           *   Value  Options( *String )
013300041207     D  oflag                        10i 0 Value
013400041207     D  mode                         10i 0 Value  Options( *NoPass )
013500041207     D  codepage                     10i 0 Value  Options( *NoPass )
013600001011     **
013700041207     D read            Pr            10i 0 ExtProc( 'read' )
013800041207     D  fd                           10i 0 Value
013900041207     D  buf                            *   Value
014000041207     D  bufsize                      10i 0 Value
014100020923     **
014200041207     D close           Pr            10i 0 ExtProc( 'close' )
014300041207     D  fd                           10i 0 Value
014400041029     **-- IFS file functions:
014500041029     D access          Pr            10i 0 ExtProc( 'access' )
014600041029     D   Path                          *   Value  Options( *String )
014700041029     D   Amode                       10i 0 Value
014800041029     **
014900041029     D lstat           Pr            10i 0 ExtProc( 'lstat' )
015000041029     D                                 *   Value  Options( *String )
015100041029     D                                 *   Value
015200041029     **
015300041029     D mkdir           Pr            10i 0 ExtProc( 'mkdir' )
015400041029     D                                 *   Value  Options( *String )
015500041029     D                               10u 0 Value
015600041029     **
015700041029     D rename          Pr            10i 0 ExtProc( 'Qp0lRenameUnlink' )
015800041029     D                                 *   Value  Options( *String )
015900041029     D                                 *   Value  Options( *String )
016000041029     **-- Convert timeval to MItime:
016100041029     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
016200041029     D                                 *   Value
016300041029     D                                 *   Value
016400041029     D                               10i 0 Value
016500041029     **-- Convert date & time:
016600041029     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
016700041029     D  CdInpFmt                     10a   Const
016800041029     D  CdInpVar                     17a   Const  Options( *VarSize )
016900041029     D  CdOutFmt                     10a   Const
017000041029     D  CdOutVar                     17a          Options( *VarSize )
017100041029     D  CdError                      10i 0 Const
017200041030     **-- Execute command:
017300041030     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
017400041030     D  XcCmd                       512a   Const  Options( *VarSize )
017500041030     D  XcCmdLen                     15p 5 Const
017600041030     D  XcCmdIGC                      3a   Const  Options( *NoPass )
017700041029
017800041029      /Free
017900041029
018000041105        PxRtnVal = *Zero;
018100041029
018200041207        IfsFil = %Trim( PxObjNam );
018300041105
018400041105        If  lstat( IfsFil: %Addr( Buf )) = -1;
018500041105
018600041105          PxRtnVal = -1;
018700041105        Else;
018800041105
018900041106          //-- Get data modified timestamp:
019000041029          timeval.sec  = st_mtime;
019100041029          timeval.usec = *zero;
019200041029
019300041029          rc = CvtTvToMi( %Addr( MI_Time )
019400041029                        : %Addr( timeval )
019500041029                        : CVTTIME_TO_TIMESTAMP
019600041029                        );
019700041029
019800041029          CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );
019900041029
020000041030          DtaModDts = %Timestamp( MI_DTS: *ISO0 );
020100041105
020200041106          //-- Process IFS file:
020300041207          fd = open( IfsFil: O_RDONLY );
020400041029
020500041207          If  fd = -1;
020600041105            PxRtnVal = -2;
020700041029          Else;
020800041029
020900041207            pbufdta = %Alloc( st_size );
021000041207
021100041207            DoW  read( fd: pbufdta: st_size ) > *Zero;
021200041029
021300041029              ExSr      PrcFilDta;
021400041029            EndDo;
021500041029
021600041207            rc = close( fd );
021700041029          EndIf;
021800041207        EndIf;
021900041030
022000041029
022100041030        *InLr = *On;
022200041029        Return;
022300041029
022400041105
022500041029        BegSr  PrcFilDta;
022600041029
022700041030
022800041207          //-- Process file data here:
022900041106
023000041106
023100041029        EndSr;
023200041029
023300041029      /End-Free
