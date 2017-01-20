/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX923                                             */
/*  Description : Change user status - CPP                           */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX923 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*               Option( *NOSRCDBG )                                 */
/*               UsrPrf( *OWNER )                                    */
/*               Log( *NO )                                          */
/*               AlwRtvSrc( *NO  )                                   */
/*                                                                   */
/*    ChgPgm     Pgm( CBX923 )                                       */
/*               RmvObs( *ALL )                                      */
/*                                                                   */
/*    ChgObjOwn  Obj( CBX923 )                                       */
/*               ObjType( *PGM )                                     */
/*               NewOwn( QSECOFR )                                   */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &UsrPrf  &RstPwd  &EnbPrf )

     Dcl        &UsrPrf      *Char        10
     Dcl        &RstPwd      *Char         4
     Dcl        &EnbPrf      *Char         4

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &UsrPwd      *Char        10    '*SAME'
     Dcl        &PwdExp      *Char        10    '*SAME'
     Dcl        &Status      *Char        10    '*SAME'

     Dcl        &CurUsr      *Char        10
     Dcl        &SecAdm      *Char         2
     Dcl        &GrpPrf      *Char        10

     Dcl        &UsrInf      *Char       128
     Dcl        &NoPwdI      *Char         1
     Dcl        &SpcAut      *Char         8
     Dcl        &PrvSgn      *Char        13
     Dcl        &PrvDat      *Char         7

     Dcl        &SysDat      *Char         6
     Dcl        &SysDay      *Dec          3
     Dcl        &SysYear     *Dec          4
     Dcl        &SysDatJ     *Char         7
     Dcl        &PrvDay      *Dec          3
     Dcl        &PrvYear     *Dec          4
     Dcl        &PrvDatJ     *Char         7

     Dcl        &RtnCod      *Char         1    '0'
     Dcl        &AudJrn      *Char        10    'QAUDJRN'
     Dcl        &AutL        *Char        10    'CHGUSRSTS'
     Dcl        &UseAut      *Char        10

/*-- Global error monitor:  -----------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error


/*-- Check specified & prerequisite objects:  -----------------------*/
     ChkObj     &UsrPrf      *USRPRF

     ChkObj     &AutL        *AUTL

     Call       QSYRUSRI    ( &UsrInf                 +
                              x'00000080'             +
                              'USRI0300'              +
                              '*CURRENT'              +
                              x'00000000'             +
                            )

     ChgVar     &CurUsr       %Sst( &UsrInf   9  10 )
     ChgVar     &SecAdm       %Sst( &UsrInf  84   2 )

     If       ( &SecAdm *NE 'YY' )     Do

/*-- Check authorization list:  -------------------------------------*/

     RtvAutLe   AutL( &AutL )               +
                User( &CurUsr )             +
                Use( &UseAut )

     MonMsg     CPF22A7     *N    Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

     ChgVar     &UseAut     ' '
     EndDo

     If       ( &UseAut *EQ ' ' )      Do
     ChgVar     &RtnCod     '1'

     GoTo       LogEvt
     EndDo

/*-- Check 'no password' indicator:  --------------------------------*/
     Call       QSYRUSRI    ( &UsrInf                 +
                              x'00000080'             +
                              'USRI0100'              +
                              &UsrPrf                 +
                              x'00000000'             +
                            )

     ChgVar     &PrvSgn       %Sst( &UsrInf  19 13 )
     ChgVar     &NoPwdI       %Sst( &UsrInf  55  1 )

     If       ( &NoPwdI *EQ 'Y' )      Do
     ChgVar     &RtnCod     '2'

     GoTo       LogEvt
     EndDo

/*-- Check special authorities:  ------------------------------------*/
     Call       QSYRUSRI    ( &UsrInf                 +
                              x'00000080'             +
                              'USRI0300'              +
                              &UsrPrf                 +
                              x'00000000'             +
                            )

     ChgVar     &SpcAut       %Sst( &UsrInf  84  8 )

     If       ( &SpcAut *NE 'NNNNNNNN' )    Do
     ChgVar     &RtnCod     '3'

     GoTo       LogEvt
     EndDo

/*-- Check profile inactivity:  -------------------------------------*/
     If       ( &PrvSgn *EQ ' '     )       Do

     RtvObjD    &UsrPrf       *USRPRF       CrtDate( &PrvSgn )
     EndDo

     ChgVar     &PrvDat       %Sst( &PrvSgn  1  7 )

     CvtDat     Date( &PrvDat )                                 +
                ToVar( &PrvDatJ )                               +
                FromFmt( *CYMD )                                +
                ToFmt( *LONGJUL )                               +
                ToSep( *NONE )

     RtvSysVal  QDATE    &SysDat

     CvtDat     Date( &SysDat )                                 +
                ToVar( &SysDatJ )                               +
                FromFmt( *SYSVAL )                              +
                ToFmt( *LONGJUL )                               +
                ToSep( *NONE )

     ChgVar     &PrvYear            %Sst( &PrvDatJ  1  4 )
     ChgVar     &PrvDay             %Sst( &PrvDatJ  5  3 )
     ChgVar     &SysYear            %Sst( &SysDatJ  1  4 )
     ChgVar     &SysDay             %Sst( &SysDatJ  5  3 )

     If     ((( &SysYear - &PrvYear ) * 365 )    +              +
              ( &SysDay  - &PrvDay )  > 60 )     Do
     ChgVar     &RtnCod     '4'

     GoTo       LogEvt
     EndDo

/*-- Check group profile special authorities:  ----------------------*/
     Call       QSYRUSRI    ( &UsrInf                 +
                              x'00000080'             +
                              'USRI0200'              +
                              &UsrPrf                 +
                              x'00000000'             +
                            )

     ChgVar     &GrpPrf       %Sst( &UsrInf  44 10 )

     If       ( &GrpPrf *NE '*NONE' )       Do

     Call       QSYRUSRI    ( &UsrInf                 +
                              x'00000080'             +
                              'USRI0300'              +
                              &GrpPrf                 +
                              x'00000000'             +
                            )

     ChgVar     &SpcAut       %Sst( &UsrInf  84  8 )

     If       ( &SpcAut *NE 'NNNNNNNN' )    Do
     ChgVar     &RtnCod     '5'

     GoTo       LogEvt
     EndDo
     EndDo

     EndDo

/*-- Change user profile status:  -----------------------------------*/
     If       ( &RstPwd *EQ '*YES')    Do
     ChgVar     &UsrPwd     &UsrPrf
     ChgVar     &PwdExp     '*YES'
     EndDo

     If       ( &EnbPrf *EQ '*YES')    Do
     ChgVar     &Status     '*ENABLED'
     EndDo

     ChgUsrPrf  UsrPrf( &UsrPrf )                     +
                Password( &UsrPwd )                   +
                PwdExp( &PwdExp )                     +
                Status( &Status )

     Call       QMHMOVPM    ( '    '                  +
                              '*COMP'                 +
                              x'00000001'             +
                              '*PGMBDY'               +
                              x'00000001'             +
                              x'0000000800000000'     +
                            )

     SndPgmMsg  MsgId( CPF9897 )                                +
                MsgF( QCPFMSG )                                 +
                MsgDta( 'User profile'                    *Bcat +
                        &UsrPrf                           *Bcat +
                        'had status changed by user'      *Bcat +
                        &CurUsr                           *Tcat +
                        '.')                                    +
                ToMsgQ( QSECOFR )

/*-- Log profile change event to audit journal - if available:  -----*/
LogEvt:
     ChkObj     &AudJrn     *JRN

     MonMsg     CPF9801     *N          Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

     GoTo       No_AudJrn
     EndDo

     SndJrnE    Jrn( &AudJrn )                        +
                Type( 'US' )                          +
                EntDta( &CurUsr *Cat  &UsrPrf *Cat    +
                        &RstPwd *Cat  &EnbPrf *Cat    +
                        &RtnCod )
No_AudJrn:
     If       ( &RtnCod  > '0' )       Do
     GoTo       EscMsg
     EndDo

Return:
     Return

/*-- Send error message to caller:  ---------------------------------*/
EscMsg:
     SndPgmMsg  MsgId( CPF9898 )                                +
                MsgF( QCPFMSG )                                 +
                MsgDta( 'User profile'                    *Bcat +
                        &UsrPrf                           *Bcat +
                        'was not changed.'                *Bcat +
                        'Please contact the security officer' )     +
                MsgType( *ESCAPE )

/*-- Resend system error messages:  ---------------------------------*/
Error:
     Call       QMHMOVPM    ( '    '                  +
                              '*DIAG'                 +
                              x'00000001'             +
                              '*PGMBDY'               +
                              x'00000001'             +
                              x'0000000800000000'     +
                            )

     Call       QMHRSNEM    ( '    '                  +
                              x'0000000800000000'     +
                            )

EndPgm:
     EndPgm
