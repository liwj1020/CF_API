000100050630/*-------------------------------------------------------------------*/
000200050630/*                                                                   */
000300050630/*  Program . . : CBX939T                                            */
000400050630/*  Description : Retrieve system data - Test                        */
000500050630/*  Author  . . : Carsten Flensburg                                  */
000600050630/*                                                                   */
000700050630/*                                                                   */
000800050630/*  Compile options:                                                 */
000900050630/*                                                                   */
001000050630/*    CrtClPgm   Pgm( CBX939T )                                      */
001100050630/*               SrcFile( QCLSRC )                                   */
001200050630/*               SrcMbr( *PGM )                                      */
001300050630/*                                                                   */
001400050630/*-------------------------------------------------------------------*/
001500041201     Pgm
001600021010
001700050625     Dcl        &PrcTyp      *Char     4
001800050625     Dcl        &PrcGrp      *Char     4
001900050626     Dcl        &MainStgSiz  *Dec     10
002000050626     Dcl        &TotAuxStg   *Dec     10
002100050626     Dcl        &SysAspSiz   *Dec     10
002200050626     Dcl        &SysAspUsd   *Dec   (  7  4 )
002300050626     Dcl        &SysAspThr   *Dec   (  4  1 )
002400050626     Dcl        &CpuPctUsd   *Dec   (  4  1 )
002500050626     Dcl        &DbCapUsd    *Dec   (  4  1 )
002600050625     Dcl        &PrcIntThr   *Dec   (  4  1 )
002700050625     Dcl        &PrcIntLmt   *Dec   (  4  1 )
002800050625     Dcl        &DbCapThr    *Dec   (  4  1 )
002900050625     Dcl        &DbCapLmt    *Dec   (  4  1 )
003000050625     Dcl        &OsRel       *Char     6
003100050625     Dcl        &SysStt      *Char     1
003200050625     Dcl        &TcpSts      *Char     1
003300050625     Dcl        &IplDts      *Char    17
003400050625     Dcl        &CurIplTyp   *Char     1
003500050625     Dcl        &PnlKeyPos   *Char     6
003600951127
003700050628
003800050630     RtvSysDta  Reset( *YES )               +
003900050628                CpuPctUsed( &CpuPctUsd )
004000050628
004100050628     RtvSysDta  Reset( *NO )                +
004200050630                CpuPctUsed( &CpuPctUsd )    +
004300050628                SysAspThr( &SysAspThr )     +
004400050628                PrcIntThr( &PrcIntThr )     +
004500050628                SysStt( &SysStt )
004600050628
004700050626     RtvSysDta  Reset( *NO )                +
004800050626                PrcType( &PrcTyp )          +
004900050625                PrcGroup( &PrcGrp )         +
005000050626                MainStgSiz( &MainStgSiz )   +
005100050626                TotAuxStg( &TotAuxStg )     +
005200050626                SysAspSiz( &SysAspSiz )     +
005300050626                SysAspUsed( &SysAspUsd )    +
005400050626                SysAspThr( &SysAspThr )     +
005500050626                CpuPctUsed( &CpuPctUsd )    +
005600050626                DbCapUsed( &DbCapUsd )      +
005700050625                PrcIntThr( &PrcIntThr )     +
005800050626                PrcIntLmt( &PrcIntLmt )     +
005900050626                DbCapThr( &DbCapThr )       +
006000050626                DbCapLmt( &DbCapLmt )       +
006100050625                OsRel( &OsRel )             +
006200050625                SysStt( &SysStt )           +
006300050625                TcpSts( &TcpSts )           +
006400050625                IplDts( &IplDts )           +
006500050625                CurIplTyp( &CurIplTyp )     +
006600050625                PnlKeyPos( &PnlKeyPos )
006700041203
006800041203EndPgm:
006900021010     EndPgm
