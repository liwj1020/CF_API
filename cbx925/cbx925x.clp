000100041017/*-------------------------------------------------------------------*/
000200041017/*                                                                   */
000300041017/*  Program . . : CBX925X                                            */
000400041017/*  Description : Receive IFS journal entry exit program - setup     */
000500041017/*  Author  . . : Carsten Flensburg                                  */
000600041017/*                                                                   */
000700041017/*  Programmer's note:                                               */
000800041017/*    This program expects two parameters:                           */
000900041017/*                                                                   */
001000041017/*      &AppLib : The library to contain all the objects that are    */
001100041017/*                created and compiled by this program               */
001200041017/*                                                                   */
001300041017/*      &IfsDir : The IFS directory to start journaling.             */
001400041017/*                                                                   */
001500041017/*    To ensure that the &IfsDir parameter is passed correctly if    */
001600041017/*    you call this program from the command line, you will need     */
001700041017/*    to place the right apostrophe at the end of the parameter      */
001800041017/*    prompt:                                                        */
001900041017/*                                                                   */
002000041017/*    Call Pgm( CBX925X )                                            */
002100041017/*         Parm( 'JRNLIB    '                                        */
002200041017/*               '/QOpenSys/IFSDIR                                ') */
002300041017/*                                                                   */
002400041017/*                                                                   */
002500041017/*  Compile options:                                                 */
002600041017/*    CrtClPgm    Pgm( CBX925X )                                     */
002700041017/*                SrcFile( QCLSRC )                                  */
002800041017/*                SrcMbr( *PGM )                                     */
002900041017/*                                                                   */
003000041017/*-------------------------------------------------------------------*/
003100041017     Pgm      ( &AppLib  &IfsDir )
003200030905
003300031004/*-- Parameter - library to contain log system:  --------------------*/
003400030909     Dcl        &AppLib      *Char    10
003500041017     Dcl        &IfsDir      *Char    48
003600960126
003700030909
003800030907     MonMsg     CPF0000      *N       GoTo Error
003900030907
004000960704
004100041017     CrtDtaAra  &AppLib/CBX925D       *Dec    10   Value( 0 )
004200030909
004300041017     CrtJrnRcv  &AppLib/CBXIFS0001    Threshold( 1000000 )
004400030909
004500041017     CrtJrn     &AppLib/CBXIFSJRN     +
004600041017                &AppLib/CBXIFS0001    +
004700030909                MngRcv( *System )     +
004800030909                RcvSizOpt( *MaxOpt2 )
004900911227
005000041017     STRJRN     Obj(( &IfsDir  *INCLUDE ))             +
005100041017                Jrn( '/QSYS.LIB/'    *Cat              +
005200041017                     &AppLib         *Tcat             +
005300041017                     '.LIB/CBXIFSJRN.JRN' )            +
005400041017                SubTree( *NONE )                       +
005500041017                Inherit( *NO )                         +
005600041017                Images( *BOTH )                        +
005700041017                OmtJrnE( *OPNCLOSYN )
005800030909
005900041017     CrtClPgm   &AppLib/CBX925C                  +
006000030909                SrcFile( &AppLib/QCLSRC )        +
006100030909                SrcMbr( *Pgm )
006200030909
006300041017     CrtRpgMod  &AppLib/CBX925                   +
006400030909                SrcFile( &AppLib/QRPGLESRC )     +
006500030909                SrcMbr( *Module )
006600030909
006700041017     CrtPgm     &AppLib/CBX925
006800041017
006900041017     SndPgmMsg   Msg( 'IFS journal monitor has been'     *Bcat  +
007000041017                      'successfully created in library'  *Bcat  +
007100041017                      &AppLib                            *Tcat  +
007200041017                      '.' )                                     +
007300041017                 MsgType( *COMP )
007400041017
007500030909
007600030905 Return:
007700030905     Return
007800030905
007900030905/*-- Error handling:  -----------------------------------------------*/
008000030905 Error:
008100030905     Call      QMHMOVPM    ( '    '                                  +
008200030905                             '*DIAG'                                 +
008300030905                             x'00000001'                             +
008400030905                             '*PGMBDY'                               +
008500030905                             x'00000001'                             +
008600030905                             x'0000000800000000'                     +
008700030905                           )
008800030905
008900030905     Call      QMHRSNEM    ( '    '                                  +
009000030905                             x'0000000800000000'                     +
009100030905                           )
009200030905
009300030905 EndPgm:
009400030905     EndPgm
