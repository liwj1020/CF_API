     **
     **  Program . . : CBX9263
     **  Description : Process IFS file - sample
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxFilNam . :  INPUT   IFS file name; the IFS file to process
     **
     **    PxPthNam . :  INPUT   IFS path name; the path used to locate
     **                          the IFS file
     **
     **    PxRtnVal . :  OUTPUT  The return value indicating how the IFS
     **                          file processing ended:
     **
     **                            0 =  IFS file processed succesfully
     **
     **                           -1 =  Error occurred while retrieving
     **                                 IFS file information
     **
     **                           -2 =  Error occurred while opening the
     **                                 IFS file
     **
     **
     **  Program description:
     **    This program will perform the following processing against
     **    the specified IFS file:
     **
     **    1. Verify the file's existence and retrieve file informaton
     **       using the lstat IFS API.
     **
     **    2. Convert an EPOCH timestamp to a timestamp data type, as an
     **       example of how to make this type of IFS object information
     **       available - here it's the data last modified timestamp.
     **
     **    3. Open the specified IFS file and read it, line by line.
     **
     **    4. Insert your data processing code in subroutine 'PrcFilDta'.
     **
     **    5. Close the file and archive it in (move to) a subdirectory
     **       called 'archive'.  If the 'archive' subdirectory does not
     **       exists, it is created.  If a file by the same name already
     **       exists in the archive directory, that file is implicitly
     **       deleted by the unlink API, prior to moving the new file.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX9263 )  DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX9263 )
     **              Module( CBX9263 )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  BndDir( 'QC2LE' )
     **-- Global variables:
     D PxObjNam        s           1024a   Inz( '/qopensys/MQ/SysApiRef.pdf' )
     D PxRtnVal        s             10i 0
     D fd              s             10i 0
     D sizread         s             10i 0
     D RcdBuf          s           4096a
     D RcdLin          s           4096a   Varying
     D IfsFil          s           2048a   Varying
     D ArcDir          s           1048a   Varying
     D CmdStr          s            512a   Varying
     D rc              s             10i 0
     D Mode            s             10u 0
     **
     D bufdta          s          65535a   Based( pbufdta )
     **
     D MI_Time         s              8a
     D MI_DTS          s             20a
     D DtaModDts       s               z
     **-- open API constants:
     D O_RDONLY        c                   1
     **-- access API constants:
     D F_OK            c                   0
     D X_OK            c                   1
     D W_OK            c                   2
     D R_OK            c                   4
     **-- Qp0zCvtToMITime API constants:
     D CVTTIME_TO_OFFSET...
     D                 c                   0
     D CVTTIME_TO_TIMESTAMP...
     D                 c                   1
     D CVTTIME_FACTOR_EPOCH_ONLY...
     D                 c                   2
     D CVTTIME_FACTOR_UTCOFFSET_ONLY...
     D                 c                   3
     **-- mkdir API mode constants:
     D S_IRUSR         c                   x'00000100'
     D S_IWUSR         c                   x'00000080'
     D S_IXUSR         c                   x'00000040'
     D S_IRWXU         c                   x'000001C0'
     D S_IRGRP         c                   x'00000020'
     D S_IWGRP         c                   x'00000010'
     D S_IXGRP         c                   x'00000008'
     D S_IRWXG         c                   x'00000038'
     D S_IROTH         c                   x'00000004'
     D S_IWOTH         c                   x'00000002'
     D S_IXOTH         c                   x'00000001'
     D S_IRWXO         c                   x'00000007'
     D S_ISUID         c                   x'00000800'
     D S_ISGID         c                   x'00000400'
     **-- File stat structure:
     D Buf             Ds                  Align
     D  st_mode                      10u 0                                      File permissions
     D  st_ino                       10u 0                                      File id
     D  st_nlink                      5u 0                                      Number of links
     D                                2a
     D  st_uid                       10u 0                                      File user id
     D  st_gid                       10u 0                                      File group id
     D  st_size                      10i 0                                      Size in bytes
     D  st_atime                     10i 0                                      File last accessed
     D  st_mtime                     10i 0                                      Data last changed
     D  st_ctime                     10i 0                                      Status last changed
     D  st_dev                       10u 0                                      File system id
     D  st_blksize                   10u 0                                      Blocksize in bytes
     D  st_allocsize                 10u 0                                      Bytes allocated
     D  st_objtype                   11a                                        Object type
     D                                1a
     D  st_codepage                   5u 0                                      Codepage
     D  st_reserv1                   62a
     D  st_ino_gen_id                10u 0                                      File generation id
     **-- timeval structure:
     D timeval         Ds                  Qualified
     D  sec                          10i 0
     D  usec                         10i 0

     **-- IFS stream file processing functions:
     D open            Pr            10i 0 ExtProc( 'open' )
     D  path                           *   Value  Options( *String )
     D  oflag                        10i 0 Value
     D  mode                         10i 0 Value  Options( *NoPass )
     D  codepage                     10i 0 Value  Options( *NoPass )
     **
     D read            Pr            10i 0 ExtProc( 'read' )
     D  fd                           10i 0 Value
     D  buf                            *   Value
     D  bufsize                      10i 0 Value
     **
     D close           Pr            10i 0 ExtProc( 'close' )
     D  fd                           10i 0 Value
     **-- IFS file functions:
     D access          Pr            10i 0 ExtProc( 'access' )
     D   Path                          *   Value  Options( *String )
     D   Amode                       10i 0 Value
     **
     D lstat           Pr            10i 0 ExtProc( 'lstat' )
     D                                 *   Value  Options( *String )
     D                                 *   Value
     **
     D mkdir           Pr            10i 0 ExtProc( 'mkdir' )
     D                                 *   Value  Options( *String )
     D                               10u 0 Value
     **
     D rename          Pr            10i 0 ExtProc( 'Qp0lRenameUnlink' )
     D                                 *   Value  Options( *String )
     D                                 *   Value  Options( *String )
     **-- Convert timeval to MItime:
     D CvtTvtoMi       Pr            10i 0 ExtProc( 'Qp0zCvtToMITime' )
     D                                 *   Value
     D                                 *   Value
     D                               10i 0 Value
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const
     D  CdOutVar                     17a          Options( *VarSize )
     D  CdError                      10i 0 Const
     **-- Execute command:
     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
     D  XcCmd                       512a   Const  Options( *VarSize )
     D  XcCmdLen                     15p 5 Const
     D  XcCmdIGC                      3a   Const  Options( *NoPass )

      /Free

        PxRtnVal = *Zero;

        IfsFil = %Trim( PxObjNam );

        If  lstat( IfsFil: %Addr( Buf )) = -1;

          PxRtnVal = -1;
        Else;

          //-- Get data modified timestamp:
          timeval.sec  = st_mtime;
          timeval.usec = *zero;

          rc = CvtTvToMi( %Addr( MI_Time )
                        : %Addr( timeval )
                        : CVTTIME_TO_TIMESTAMP
                        );

          CvtDtf( '*DTS': MI_Time: '*YYMD': MI_DTS: *Zero );

          DtaModDts = %Timestamp( MI_DTS: *ISO0 );

          //-- Process IFS file:
          fd = open( IfsFil: O_RDONLY );

          If  fd = -1;
            PxRtnVal = -2;
          Else;

            pbufdta = %Alloc( st_size );

            sizread = read( fd: pbufdta: st_size );

              ExSr      PrcFilDta;

            rc = close( fd );
          EndIf;
        EndIf;


        *InLr = *On;
        Return;


        BegSr  PrcFilDta;


          //-- Process file data here:


        EndSr;

      /End-Free
