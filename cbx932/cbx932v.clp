/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX932V                                            */
/*  Description : Print save information - CPP                       */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Programmer's notes:                                              */
/*    The CPD0006 diagnostic message followed by a CPF0002 escape    */
/*    message is mandatory for a command validity checking program.  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( CBX932V )                                      */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
     Pgm      ( &LibNam           +
                &ObjLvl           +
                &IncDat           +
                &SrtOrd           +
                &JobD_q           +
                &OutQ_q           +
              )

/*-- Parameters:  ---------------------------------------------------*/
     Dcl        &LibNam     *Char    12
     Dcl        &ObjLvl     *Char    10
     Dcl        &IncDat     *Char    19
     Dcl        &SrtOrd     *Char    22
     Dcl        &JobD_q     *Char    20
     Dcl        &OutQ_q     *Char    20

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JobD       *Char    10
     Dcl        &JobD_l     *Char    10
     Dcl        &OutQ       *Char    10
     Dcl        &OutQ_l     *Char    10

     Dcl        &ChkLib     *Char    10
     Dcl        &ChkSiz     *Dec      5

     Dcl        &Msg        *Char    80

/*-- Global error monitoring:  --------------------------------------*/
     MonMsg   ( CPF0000  CPD0000 )   *N       GoTo Error


     ChgVar     &JobD        %SSt( &JobD_q   1  10 )
     ChgVar     &JobD_l      %SSt( &JobD_q  11  10 )

     ChgVar     &OutQ        %SSt( &OutQ_q   1  10 )
     ChgVar     &OutQ_l      %SSt( &OutQ_q  11  10 )

     If       ( &JobD_l = ' ' )    Do
     ChgVar     &JobD_l   '*N'
     EndDo

     Else Do
     ChkObj     &JobD_l/&JobD      *JOBD
     EndDo

     If       ( &OutQ_l = ' ' )    Do
     ChgVar     &OutQ_l   '*N'
     EndDo

     Else Do
     ChkObj     &OutQ_l/&OutQ      *OUTQ
     EndDo

     ChgVar     &ChkSiz   %Bin( &LibNam  1  2 )
     ChgVar     &ChkLib   %Sst( &LibNam  3 10 )

     If      (( %Sst( &ChkLib        1  1 ) *NE '*' )  *And     +
              ( %Sst( &ChkLib  &ChkSiz  1 ) *NE '*' )) Do

     ChkObj     &ChkLib            *LIB
     EndDo

     If       ( &ObjLvl *EQ '*OBJ' )                   Do

     If       ( %Sst( &ChkLib  &ChkSiz  1 ) *EQ '*' )  Do

     SndPgmMsg  MsgId( CPD3C45 )                      +
                MsgF( QCPFMSG )                       +
                MsgDta( &ChkLib )                     +
                ToPgmQ( *SAME * )                     +
                MsgType( *ESCAPE )
     EndDo
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
