000100030812/*-------------------------------------------------------------------*/
000200050917/*                                                                   */
000300050917/*  Program . . : CBX945O                                            */
000400050917/*  Description : Change profile exit program - POP                  */
000500050917/*  Author  . . : Carsten Flensburg                                  */
000600030812/*                                                                   */
000700030824/*                                                                   */
000800030812/*                                                                   */
000900030812/*  Parameters:                                                      */
001000030812/*    CmdNamQ     INPUT      Qualified command name                  */
001100030812/*                                                                   */
001200030812/*    KeyPrm1     INPUT      Key parameter indentifying the          */
001300030812/*                           user profile to retrieve exit           */
001400030812/*                           point information about.                */
001500030812/*                                                                   */
001600030812/*    KeyPrm2     INPUT      Key parameter identifying the           */
001700030812/*                           format name of the exit point           */
001800030812/*                           to retrieve information about.          */
001900030812/*                                                                   */
002000030812/*    CmdStr      OUTPUT     The formatted command prompt            */
002100030812/*                           string returning the current            */
002200030812/*                           activation status of the exit           */
002300030812/*                           point's registered programs.            */
002400030812/*                                                                   */
002500030812/*                                                                   */
002600030812/*  Compile options:                                                 */
002700050917/*    CrtClPgm   Pgm( CBX945O )                                      */
002800030812/*               SrcFile( QCLSRC )                                   */
002900030812/*               SrcMbr( *PGM )                                      */
003000030812/*                                                                   */
003100030824/*                                                                   */
003200030812/*-------------------------------------------------------------------*/
003300030812     Pgm      ( &CmdNamQ               +
003400030812                &KeyPrm1               +
003500030812                &KeyPrm2               +
003600030823                &CmdStr                +
003700030823              )
003800000212
003900000315/*-- Parameters:  ---------------------------------------------------*/
004000050917     Dcl        &CmdNamQ     *Char       20
004100050917     Dcl        &KeyPrm1     *Char       10
004200050917     Dcl        &KeyPrm2     *Char        8
004300050917     Dcl        &CmdStr      *Char     1024
004400000317
004500050917     Dcl        &RcvVar      *Char       40
004600050917     Dcl        &RcvLen      *Char        4    x'00000028'
004700050917     Dcl        &Flags       *Char       32
004800000315
004900050917     Dcl        &Parm        *Char        4
005000050917     Dcl        &PgmFlg      *Dec         9
005100050917     Dcl        &NbrEnt      *Dec         5
005200050917     Dcl        &OffSet      *Dec         5    1
005300960724
005400000315/*-- Global error monitoring:  --------------------------------------*/
005500000317     MonMsg     CPF0000      *N             GoTo Error
005600000315
005700000317
005800011102     Call       QWTRTVPX    ( &RcvVar            +
005900000315                              &RcvLen            +
006000030812                              &KeyPrm2           +
006100030812                              &KeyPrm1           +
006200000315                              x'00000000'        )
006300000315
006400011102     ChgVar     &NbrEnt       %Bin( &RcvVar  1  4 )
006500030812     ChgVar     &Flags        %Sst( &RcvVar  9 32 )
006600011102
006700030812     ChgVar     %Sst( &CmdStr  1   2 )      x'0040'
006800030812     ChgVar     %Sst( &CmdStr  3  10 )      '?<EXITPGM('
006900000317
007000000317Next:
007100011102     ChgVar     &PgmFlg       %Bin( &Flags  &OffSet  4 )
007200011102
007300050917     If       ( &PgmFlg   =   1  )     ChgVar    &Parm     '*ON '
007400050917     Else                              ChgVar    &Parm     '*OFF'
007500000317
007600050917     ChgVar     &CmdStr     ( &CmdStr *Bcat  &Parm )
007700000317     ChgVar     &OffSet     ( &OffSet + 4 )
007800030824
007900011102     If       ( &OffSet   <   &NbrEnt * 4 )      Do
008000000317     GoTo       Next
008100000317     EndDo
008200000317
008300000317     ChgVar     &CmdStr     ( &CmdStr *Bcat ')' )
008400000315
008500000315 Return:
008600000315     Return
008700000315
008800000315/*-- Error handling:  -----------------------------------------------*/
008900000315 Error:
009000000317     SndPgmMsg  MsgId( CPF0011 )  MsgF( QCPFMSG )  MsgType( *ESCAPE )
009100000212
009200000315 EndPgm:
009300000315     EndPgm
