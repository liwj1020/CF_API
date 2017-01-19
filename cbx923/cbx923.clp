000100040828/*-------------------------------------------------------------------*/
000200040828/*                                                                   */
000300040919/*  Program . . : CBX923                                             */
000400040828/*  Description : Change user status - CPP                           */
000500040828/*  Author  . . : Carsten Flensburg                                  */
000600040828/*                                                                   */
000700040828/*                                                                   */
000800040828/*  Compile options:                                                 */
000900040828/*                                                                   */
001000040919/*    CrtClPgm   Pgm( CBX923 )                                       */
001100040828/*               SrcFile( QCLSRC )                                   */
001200040828/*               SrcMbr( *PGM )                                      */
001300040828/*               Option( *NOSRCDBG )                                 */
001400040828/*               UsrPrf( *OWNER )                                    */
001500040828/*               Log( *NO )                                          */
001600040828/*               AlwRtvSrc( *NO  )                                   */
001700040828/*                                                                   */
001800040919/*    ChgPgm     Pgm( CBX923 )                                       */
001900040828/*               RmvObs( *ALL )                                      */
002000040828/*                                                                   */
002100040919/*    ChgObjOwn  Obj( CBX923 )                                       */
002200040828/*               ObjType( *PGM )                                     */
002300040828/*               NewOwn( QSECOFR )                                   */
002400040828/*                                                                   */
002500040828/*                                                                   */
002600040828/*-------------------------------------------------------------------*/
002700040827     Pgm      ( &UsrPrf  &RstPwd  &EnbPrf )
002800021010
002900040926     Dcl        &UsrPrf      *Char        10
003000040926     Dcl        &RstPwd      *Char         4
003100040926     Dcl        &EnbPrf      *Char         4
003200021010
003300040828/*-- Global variables:  ---------------------------------------------*/
003400040827     Dcl        &UsrPwd      *Char        10    '*SAME'
003500040827     Dcl        &PwdExp      *Char        10    '*SAME'
003600040827     Dcl        &Status      *Char        10    '*SAME'
003700040827
003800021010     Dcl        &CurUsr      *Char        10
003900040924     Dcl        &SecAdm      *Char         2
004000040831     Dcl        &GrpPrf      *Char        10
004100040831
004200040924     Dcl        &UsrInf      *Char       128
004300040828     Dcl        &NoPwdI      *Char         1
004400040831     Dcl        &SpcAut      *Char         8
004500030215     Dcl        &PrvSgn      *Char        13
004600030805     Dcl        &PrvDat      *Char         7
004700040831
004800030805     Dcl        &SysDat      *Char         6
004900040831     Dcl        &SysDay      *Dec          3
005000040831     Dcl        &SysYear     *Dec          4
005100030805     Dcl        &SysDatJ     *Char         7
005200030805     Dcl        &PrvDay      *Dec          3
005300040831     Dcl        &PrvYear     *Dec          4
005400040831     Dcl        &PrvDatJ     *Char         7
005500040827
005600040831     Dcl        &RtnCod      *Char         1    '0'
005700040827     Dcl        &AudJrn      *Char        10    'QAUDJRN'
005800040924     Dcl        &AutL        *Char        10    'CHGUSRSTS'
005900040827     Dcl        &UseAut      *Char        10
006000021010
006100040924/*-- Global error monitor:  -----------------------------------------*/
006200040827     MonMsg     CPF0000      *N        GoTo Error
006300951127
006400040827
006500040924/*-- Check specified & prerequisite objects:  -----------------------*/
006600040827     ChkObj     &UsrPrf      *USRPRF
006700040924
006800040924     ChkObj     &AutL        *AUTL
006900000802
007000040924     Call       QSYRUSRI    ( &UsrInf                 +
007100040924                              x'00000080'             +
007200040924                              'USRI0300'              +
007300040924                              '*CURRENT'              +
007400040924                              x'00000000'             +
007500040924                            )
007600040924
007700040924     ChgVar     &CurUsr       %Sst( &UsrInf   9  10 )
007800040924     ChgVar     &SecAdm       %Sst( &UsrInf  84   2 )
007900040924
008000040924     If       ( &SecAdm *NE 'YY' )     Do
008100040828
008200040924/*-- Check authorization list:  -------------------------------------*/
008300040828
008400040828     RtvAutLe   AutL( &AutL )               +
008500040828                User( &CurUsr )             +
008600040828                Use( &UseAut )
008700040828
008800040828     MonMsg     CPF22A7     *N    Do
008900040828     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
009000040828
009100040924     ChgVar     &UseAut     ' '
009200040828     EndDo
009300040828
009400040924     If       ( &UseAut *EQ ' ' )      Do
009500040924     ChgVar     &RtnCod     '1'
009600040828
009700040924     GoTo       LogEvt
009800040828     EndDo
009900040827
010000040831/*-- Check 'no password' indicator:  --------------------------------*/
010100040828     Call       QSYRUSRI    ( &UsrInf                 +
010200040924                              x'00000080'             +
010300040828                              'USRI0100'              +
010400040828                              &UsrPrf                 +
010500040828                              x'00000000'             +
010600040828                            )
010700040828
010800040831     ChgVar     &PrvSgn       %Sst( &UsrInf  19 13 )
010900040828     ChgVar     &NoPwdI       %Sst( &UsrInf  55  1 )
011000040828
011100040924     If       ( &NoPwdI *EQ 'Y' )      Do
011200040924     ChgVar     &RtnCod     '2'
011300040828
011400040924     GoTo       LogEvt
011500040828     EndDo
011600040828
011700040831/*-- Check special authorities:  ------------------------------------*/
011800040831     Call       QSYRUSRI    ( &UsrInf                 +
011900040924                              x'00000080'             +
012000040831                              'USRI0300'              +
012100040831                              &UsrPrf                 +
012200040831                              x'00000000'             +
012300040831                            )
012400040831
012500040924     ChgVar     &SpcAut       %Sst( &UsrInf  84  8 )
012600040827
012700040924     If       ( &SpcAut *NE 'NNNNNNNN' )    Do
012800040924     ChgVar     &RtnCod     '3'
012900040827
013000040924     GoTo       LogEvt
013100040827     EndDo
013200030805
013300040831/*-- Check profile inactivity:  -------------------------------------*/
013400040924     If       ( &PrvSgn *EQ ' '     )       Do
013500040828
013600040828     RtvObjD    &UsrPrf       *USRPRF       CrtDate( &PrvSgn )
013700040828     EndDo
013800040828
013900030805     ChgVar     &PrvDat       %Sst( &PrvSgn  1  7 )
014000030805
014100030805     CvtDat     Date( &PrvDat )                                 +
014200030805                ToVar( &PrvDatJ )                               +
014300030805                FromFmt( *CYMD )                                +
014400030805                ToFmt( *LONGJUL )                               +
014500030805                ToSep( *NONE )
014600030805
014700030805     RtvSysVal  QDATE    &SysDat
014800030805
014900030805     CvtDat     Date( &SysDat )                                 +
015000030805                ToVar( &SysDatJ )                               +
015100030805                FromFmt( *SYSVAL )                              +
015200030805                ToFmt( *LONGJUL )                               +
015300030805                ToSep( *NONE )
015400030805
015500030805     ChgVar     &PrvYear            %Sst( &PrvDatJ  1  4 )
015600030805     ChgVar     &PrvDay             %Sst( &PrvDatJ  5  3 )
015700030805     ChgVar     &SysYear            %Sst( &SysDatJ  1  4 )
015800030805     ChgVar     &SysDay             %Sst( &SysDatJ  5  3 )
015900030805
016000030805     If     ((( &SysYear - &PrvYear ) * 365 )    +              +
016100040831              ( &SysDay  - &PrvDay )  > 60 )     Do
016200040924     ChgVar     &RtnCod     '4'
016300040827
016400040924     GoTo       LogEvt
016500030805     EndDo
016600040831
016700040831/*-- Check group profile special authorities:  ----------------------*/
016800040831     Call       QSYRUSRI    ( &UsrInf                 +
016900040924                              x'00000080'             +
017000040831                              'USRI0200'              +
017100040831                              &UsrPrf                 +
017200040831                              x'00000000'             +
017300040831                            )
017400040831
017500040831     ChgVar     &GrpPrf       %Sst( &UsrInf  44 10 )
017600040924
017700040924     If       ( &GrpPrf *NE '*NONE' )       Do
017800040831
017900040831     Call       QSYRUSRI    ( &UsrInf                 +
018000040924                              x'00000080'             +
018100040831                              'USRI0300'              +
018200040831                              &GrpPrf                 +
018300040831                              x'00000000'             +
018400040831                            )
018500040831
018600040924     ChgVar     &SpcAut       %Sst( &UsrInf  84  8 )
018700040831
018800040924     If       ( &SpcAut *NE 'NNNNNNNN' )    Do
018900040924     ChgVar     &RtnCod     '5'
019000040831
019100040924     GoTo       LogEvt
019200040831     EndDo
019300040924     EndDo
019400040924
019500040831     EndDo
019600030805
019700040831/*-- Change user profile status:  -----------------------------------*/
019800040924     If       ( &RstPwd *EQ '*YES')    Do
019900040924     ChgVar     &UsrPwd     &UsrPrf
020000040924     ChgVar     &PwdExp     '*YES'
020100040827     EndDo
020200040827
020300040924     If       ( &EnbPrf *EQ '*YES')    Do
020400040924     ChgVar     &Status     '*ENABLED'
020500040827     EndDo
020600040827
020700040827     ChgUsrPrf  UsrPrf( &UsrPrf )                     +
020800040827                Password( &UsrPwd )                   +
020900040827                PwdExp( &PwdExp )                     +
021000040827                Status( &Status )
021100040828
021200040828     Call       QMHMOVPM    ( '    '                  +
021300040828                              '*COMP'                 +
021400040828                              x'00000001'             +
021500040828                              '*PGMBDY'               +
021600040828                              x'00000001'             +
021700040828                              x'0000000800000000'     +
021800040828                            )
021900040926
022000040926     SndPgmMsg  MsgId( CPF9897 )                                +
022100040926                MsgF( QCPFMSG )                                 +
022200040926                MsgDta( 'User profile'                    *Bcat +
022300040926                        &UsrPrf                           *Bcat +
022400040926                        'had status changed by user'      *Bcat +
022500040926                        &CurUsr                           *Tcat +
022600040926                        '.')                                    +
022700040926                ToMsgQ( QSECOFR )
022800951127
022900040831/*-- Log profile change event to audit journal - if available:  -----*/
023000040831LogEvt:
023100040831     ChkObj     &AudJrn     *JRN
023200040831
023300040831     MonMsg     CPF9801     *N          Do
023400040831     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
023500040831
023600040831     GoTo       No_AudJrn
023700040831     EndDo
023800040831
023900040831     SndJrnE    Jrn( &AudJrn )                        +
024000040924                Type( 'US' )                          +
024100040831                EntDta( &CurUsr *Cat  &UsrPrf *Cat    +
024200040924                        &RstPwd *Cat  &EnbPrf *Cat    +
024300040924                        &RtnCod )
024400040831No_AudJrn:
024500040924     If       ( &RtnCod  > '0' )       Do
024600040924     GoTo       EscMsg
024700040924     EndDo
024800040924
024900040924Return:
025000040924     Return
025100040831
025200040919/*-- Send error message to caller:  ---------------------------------*/
025300040919EscMsg:
025400040919     SndPgmMsg  MsgId( CPF9898 )                                +
025500040919                MsgF( QCPFMSG )                                 +
025600040919                MsgDta( 'User profile'                    *Bcat +
025700040919                        &UsrPrf                           *Bcat +
025800040919                        'was not changed.'                *Bcat +
025900040919                        'Please contact the security officer' )     +
026000040919                MsgType( *ESCAPE )
026100040919
026200040831/*-- Resend system error messages:  ---------------------------------*/
026300021010Error:
026400040827     Call       QMHMOVPM    ( '    '                  +
026500040827                              '*DIAG'                 +
026600040827                              x'00000001'             +
026700040827                              '*PGMBDY'               +
026800040827                              x'00000001'             +
026900040827                              x'0000000800000000'     +
027000040827                            )
027100040827
027200040828     Call       QMHRSNEM    ( '    '                  +
027300040827                              x'0000000800000000'     +
027400040828                            )
027500040827
027600040831EndPgm:
027700021010     EndPgm
