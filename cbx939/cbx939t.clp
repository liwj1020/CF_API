/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX939T                                            */
/*  Description : Retrieve system data - Test                        */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX939T )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm

     Dcl        &PrcTyp      *Char     4
     Dcl        &PrcGrp      *Char     4
     Dcl        &MainStgSiz  *Dec     10
     Dcl        &TotAuxStg   *Dec     10
     Dcl        &SysAspSiz   *Dec     10
     Dcl        &SysAspUsd   *Dec   (  7  4 )
     Dcl        &SysAspThr   *Dec   (  4  1 )
     Dcl        &CpuPctUsd   *Dec   (  4  1 )
     Dcl        &DbCapUsd    *Dec   (  4  1 )
     Dcl        &PrcIntThr   *Dec   (  4  1 )
     Dcl        &PrcIntLmt   *Dec   (  4  1 )
     Dcl        &DbCapThr    *Dec   (  4  1 )
     Dcl        &DbCapLmt    *Dec   (  4  1 )
     Dcl        &OsRel       *Char     6
     Dcl        &SysStt      *Char     1
     Dcl        &TcpSts      *Char     1
     Dcl        &IplDts      *Char    17
     Dcl        &CurIplTyp   *Char     1
     Dcl        &PnlKeyPos   *Char     6


     RtvSysDta  Reset( *YES )               +
                CpuPctUsed( &CpuPctUsd )

     RtvSysDta  Reset( *NO )                +
                CpuPctUsed( &CpuPctUsd )    +
                SysAspThr( &SysAspThr )     +
                PrcIntThr( &PrcIntThr )     +
                SysStt( &SysStt )

     RtvSysDta  Reset( *NO )                +
                PrcType( &PrcTyp )          +
                PrcGroup( &PrcGrp )         +
                MainStgSiz( &MainStgSiz )   +
                TotAuxStg( &TotAuxStg )     +
                SysAspSiz( &SysAspSiz )     +
                SysAspUsed( &SysAspUsd )    +
                SysAspThr( &SysAspThr )     +
                CpuPctUsed( &CpuPctUsd )    +
                DbCapUsed( &DbCapUsd )      +
                PrcIntThr( &PrcIntThr )     +
                PrcIntLmt( &PrcIntLmt )     +
                DbCapThr( &DbCapThr )       +
                DbCapLmt( &DbCapLmt )       +
                OsRel( &OsRel )             +
                SysStt( &SysStt )           +
                TcpSts( &TcpSts )           +
                IplDts( &IplDts )           +
                CurIplTyp( &CurIplTyp )     +
                PnlKeyPos( &PnlKeyPos )

EndPgm:
     EndPgm
