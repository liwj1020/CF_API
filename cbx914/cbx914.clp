/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : CBX914                                             */
/*  Description : Display PTF information - CPP                      */
/*  Author  . . : Carsten Flensburg                                  */
/*                                                                   */
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtClPgm   Pgm( CBX914 )                                       */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
    Pgm      ( &PtfId  &Option )
 
/*-- Global variables:  ---------------------------------------------*/
    Dcl        &PtfId      *Char      7
    Dcl        &Option     *Char      4
 
    Dcl        &PtfInfo    *Char     50
    Dcl        &PrdId      *Char      7    '*ONLY'
    Dcl        &RelLvl     *Char      6
    Dcl        &CcsId      *Char      4
    Dcl        &Rsv        *Char     26
 
    Dcl        &RcvVar     *Char    112
    Dcl        &RcvVarLen  *Char      4    x'00000070'
 
    Dcl        &PtfPrdId   *Char      7
    Dcl        &PtfRelLvl  *Char      6
    Dcl        &PtfPrdOpt  *Char      4
    Dcl        &PtfLodId   *Char      4
    Dcl        &PtfLodSts  *Char      1
    Dcl        &PtfType    *Char      1
    Dcl        &PtfIplAct  *Char      1
    Dcl        &PtfActPnd  *Char      1
    Dcl        &PtfActRqd  *Char      1
    Dcl        &PtfSupSed  *Char      7
 
/*-- Global error monitor:  -----------------------------------------*/
    MonMsg     CPF0000     *N       GoTo Error
 
 
    ChgVar     &PtfInfo           ( &PtfId   *Cat     +
                                    &PrdId   *Cat     +
                                    &RelLvl  *Cat     +
                                    &CcsId   *Cat     +
                                    &Rsv              +
                                  )
 
    Call       QPZRTVFX           ( &RcvVar           +
                                    &RcvVarLen        +
                                    &PtfInfo          +
                                    'PTFR0100'        +
                                    x'00000000'       +
                                  )
 
    ChgVar     &PtfPrdId          %Sst( &RcvVar   13   7 )
    ChgVar     &PtfRelLvl         %Sst( &RcvVar   27   6 )
    ChgVar     &PtfPrdOpt         %Sst( &RcvVar   33   4 )
    ChgVar     &PtfLodId          %Sst( &RcvVar   37   4 )
    ChgVar     &PtfLodSts         %Sst( &RcvVar   41   1 )
    ChgVar     &PtfType           %Sst( &RcvVar   65   1 )
    ChgVar     &PtfIplAct         %Sst( &RcvVar   66   1 )
    ChgVar     &PtfActPnd         %Sst( &RcvVar   67   1 )
    ChgVar     &PtfActRqd         %Sst( &RcvVar   68   1 )
    ChgVar     &PtfSupSed         %Sst( &RcvVar   76   7 )
 
    If       ( &Option  = '*VFY' )  Do
 
    If       ( &PtfSupSed = ' ' )   ChgVar  &PtfSupSed  '*NONE'
 
    SndPgmMsg  MsgId( CPF9897 )                                 +
               MsgF( QSYS/QCPFMSG )                             +
               MsgDta( 'PTF'  *Bcat &PtfPrdId   *Tcat           +
                       '-'    *Cat  &PtfId      *Bcat           +
                                    &PtfRelLvl  *Bcat           +
                       'is currently loaded and superseeded by' +
                              *Bcat &PtfSupSed  *Tcat           +
                       '.'                                      +
                     )                                          +
               ToPgmQ( *PRV )                                   +
               MsgType( *INFO )
 
    EndDo
    Else If  ( &Option  = '*DSP' )  Do
 
    DspPtf     LicPgm( &PtfPrdId )  Select( &PtfId )  +
               CoverOnly( *NO )
    EndDo
    Else Do
 
    DspPtf     LicPgm( &PtfPrdId )  Select( &PtfId )  +
               CoverOnly( *YES )
    EndDo
 
 Return:
     Return
 
/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                   +
                             '*DIAG'                  +
                             x'00000001'              +
                             '*PGMBDY'                +
                             x'00000001'              +
                             x'0000000800000000'      +
                           )
 
     Call      QMHRSNEM    ( '    '                   +
                             x'0000000800000000'      +
                           )
 
 
Endpgm:
    EndPgm
