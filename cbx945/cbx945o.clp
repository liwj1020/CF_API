/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX945O                                            */
/*  Description : Change profile exit program - POP                  */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*                                                                   */
/*  Parameters:                                                      */
/*    CmdNamQ     INPUT      Qualified command name                  */
/*                                                                   */
/*    KeyPrm1     INPUT      Key parameter indentifying the          */
/*                           user profile to retrieve exit           */
/*                           point information about.                */
/*                                                                   */
/*    KeyPrm2     INPUT      Key parameter identifying the           */
/*                           format name of the exit point           */
/*                           to retrieve information about.          */
/*                                                                   */
/*    CmdStr      OUTPUT     The formatted command prompt            */
/*                           string returning the current            */
/*                           activation status of the exit           */
/*                           point's registered programs.            */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX945O )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &CmdNamQ               +
                &KeyPrm1               +
                &KeyPrm2               +
                &CmdStr                +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &CmdNamQ     *Char       20
     Dcl        &KeyPrm1     *Char       10
     Dcl        &KeyPrm2     *Char        8
     Dcl        &CmdStr      *Char     1024

     Dcl        &RcvVar      *Char       40
     Dcl        &RcvLen      *Char        4    x'00000028'
     Dcl        &Flags       *Char       32

     Dcl        &Parm        *Char        4
     Dcl        &PgmFlg      *Dec         9
     Dcl        &NbrEnt      *Dec         5
     Dcl        &OffSet      *Dec         5    1

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N             GoTo Error


     Call       QWTRTVPX    ( &RcvVar            +
                              &RcvLen            +
                              &KeyPrm2           +
                              &KeyPrm1           +
                              x'00000000'        )

     ChgVar     &NbrEnt       %Bin( &RcvVar  1  4 )
     ChgVar     &Flags        %Sst( &RcvVar  9 32 )

     ChgVar     %Sst( &CmdStr  1   2 )      x'0040'
     ChgVar     %Sst( &CmdStr  3  10 )      '?<EXITPGM('

Next:
     ChgVar     &PgmFlg       %Bin( &Flags  &OffSet  4 )

     If       ( &PgmFlg   =   1  )     ChgVar    &Parm     '*ON '
     Else                              ChgVar    &Parm     '*OFF'

     ChgVar     &CmdStr     ( &CmdStr *Bcat  &Parm )
     ChgVar     &OffSet     ( &OffSet + 4 )

     If       ( &OffSet   <   &NbrEnt * 4 )      Do
     GoTo       Next
     EndDo

     ChgVar     &CmdStr     ( &CmdStr *Bcat ')' )

 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     SndPgmMsg  MsgId( CPF0011 )  MsgF( QCPFMSG )  MsgType( *ESCAPE )

 EndPgm:
     EndPgm
