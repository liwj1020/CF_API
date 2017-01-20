/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX930V                                            */
/*  Description : Print programs adopting special authorities - VCP  */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
/*    message is mandatory for a command validity checking program.  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX930V )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &PgmLib           +
                &SpcAutL          +
                &SrtOrd           +
                &SysObj           +
                &GrpPrf           +
                &JobD_q           +
                &OutQ_q           +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &PgmLib     *Char    10
     Dcl        &SpcAutL    *Char    82
     Dcl        &SysObj     *Char     4
     Dcl        &GrpPrf     *Char     4
     Dcl        &SrtOrd     *Char    10
     Dcl        &JobD_q     *Char    20
     Dcl        &OutQ_q     *Char    20

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JobD       *Char    10
     Dcl        &JobD_l     *Char    10
     Dcl        &OutQ       *Char    10
     Dcl        &OutQ_l     *Char    10

     Dcl        &Msg        *Char    80

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000     *N       GoTo Error

/*-- Mainline -------------------------------------------------------*/

     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )

     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )

     If       ( %Sst( &PgmLib  1  1 ) *NE '*' )   Do

     ChkObj     Obj( &PgmLib )         +
                ObjType( *LIB )
     EndDo

     If       ( %Sst( &JobD    1  1 ) *NE '*' )   Do

     ChkObj     Obj( &JobD_l/&JobD )   +
                ObjType( *JOBD )
     EndDo

     If       ( %Sst( &OutQ    1  1 ) *NE '*' )   Do

     ChkObj     Obj( &OutQ_l/&OutQ )   +
                ObjType( *OUTQ )
     EndDo

 Return:
     Return

/*-- Error processor ------------------------------------------------*/
 Error:
     RcvMsg     MsgType( *EXCP )                      +
                Msg( &Msg )

     ChgVar     &Msg         ( '0000' *Cat  &Msg )

     SndPgmMsg  MsgId( CPD0006 )                      +
                MsgF( QCPFMSG )                       +
                MsgDta( &Msg )                        +
                MsgType( *DIAG )

     SndPgmMsg  MsgId( CPF0002 )                      +
                MsgF( QCPFMSG )                       +
                MsgType( *ESCAPE )

 EndPgm:
     EndPgm
