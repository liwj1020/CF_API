     **
     **  Program . . : CBX916
     **  Description : Display language ID's default CCSID
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **     This program retrieve the default CCSID for a specified language
     **     ID.  The information is returned in a completion message.
     **
     **  Programmers note:
     **     The Retrieve Default CCSID (QLGRTVDC) API was introduced in V5R2
     **     and this program will therefore not run on prior releases.
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX916 )
     **
     **    CrtPgm    Pgm( CBX916 )
     **              Module( CBX916 )
     **              ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- Api error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0 Inz
     D  AeMsgId                       7a
     D                                1a
     D  AeMsgDta                    128a
     **-- Global declarations:  ----------------------------------------------**
     D CcsId           s             10i 0
     D MsgKey          s              4a
     D MsgDta          s            256a   Varying
     **-- Retrieve default CCSID:  -------------------------------------------**
     D RtvDftCcsId     Pr                  ExtPgm( 'QLGRTVDC' )
     D  DcCcsId                      10i 0
     D  DcLngId                       3a   Const
     D  DcError                   32767a          Options( *VarSize )
     **-- Send program message:  ---------------------------------------------**
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    512a   Const  Options( *VarSize )
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                     512a          Options( *VarSize )
     **
     D  SpCalStkElen                 10i 0 Const  Options( *NoPass )
     D  SpCalStkEq                   20a   Const  Options( *NoPass )
     D  SpDspWait                    10i 0 Const  Options( *NoPass )
     **
     D  SpCalStkEtyp                 20a   Const  Options( *NoPass )
     D  SpCcsId                      10i 0 Const  Options( *NoPass )
     **-- Parameter:  --------------------------------------------------------**
     D PxLngId         s              3a
     **
     C     *Entry        Plist
     C                   Parm                    PxLngId
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   CallP(e)  RtvDftCcsId( CcsId
     C                                        : PxLngId
     C                                        : ApiError
     C                                        )
     **
     C                   Select
     C                   When      %Error
     **
     C                   Eval      MsgDta      = 'This command requires '  +
     C                                           'V5R2 to run'
     **
     C                   CallP     SndPgmMsg( 'CPF9898'
     C                                      : 'QCPFMSG   *LIBL'
     C                                      : MsgDta
     C                                      : %Len( MsgDta )
     C                                      : '*ESCAPE'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : ApiError
     C                                      )
     **
     C                   When      AeBytAvl    > *Zero
     **
     C                   CallP     SndPgmMsg( AeMsgId
     C                                      : 'QCPFMSG   *LIBL'
     C                                      : AeMsgDta
     C                                      : AeBytAvl - 16
     C                                      : '*ESCAPE'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : ApiError
     C                                      )
     **
     C                   Other
     **
     C                   Eval      MsgDta      = 'Language ID '            +
     C                                           %TrimR( PxLngId )         +
     C                                           ' has default CCSID '     +
     C                                           %EditC( %Dec( CcsId: 5: 0 )
     C                                                 : 'X'
     C                                                 )                   +
     C                                           '.'
     **
     C                   CallP     SndPgmMsg( *Blanks
     C                                      : *Blanks
     C                                      : MsgDta
     C                                      : %Len( MsgDta )
     C                                      : '*COMP'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : ApiError
     C                                      )
     **
     C                   EndSl
     **
     C                   Eval      *InLr       = *On
     C                   Return
     **
