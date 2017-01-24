     **
     **  Program . . : CBX911
     **  Description : Validate CCSID
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compilation specification:
     **
     **    CrtRpgMod Module( CBX911 )
     **              DbgView( *NONE )
     **
     **    CrtPgm    Pgm( CBX911 )
     **              Module( CBX911 )
     **              ActGrp( QILE )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- Send program message:  ---------------------------------------------**
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                      10i 0 Const
     **-- Run system command:  -----------------------------------------------**
     D ValidateCCSID   Pr            10i 0 ExtProc( 'QtqValidateCCSID' )
     D  CCSID                        10i 0 Value
     **-- Send completion message:  ------------------------------------------**
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Global variable:  --------------------------------------------------**
     D CCSID           s              5s 0
     **-- Parameter:  --------------------------------------------------------**
     D PxCCSID         s             10i 0
     **
     C     *Entry        Plist
     C                   Parm                    PxCCSID
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   Eval      CCSID       = PxCCSID
     **
     C                   If        ValidateCCSID( PxCCSID ) > *Zero
     **
     C                   CallP     SndCmpMsg( 'CCSID '               +
     C                                        %EditC( CCSID: 'X' )   +
     C                                        ' is valid.'
     C                                      )
     **
     C                   Else
     C                   CallP     SndCmpMsg( 'CCSID '               +
     C                                        %EditC( CCSID: 'X' )   +
     C                                        ' is not supported.'
     C                                      )
     C                   EndIf
     **
     C                   Return
     **
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a
     **
     C                   CallP(e)  SndPgmMsg( 'CPF9897'
     C                                      : 'QCPFMSG   *LIBL'
     C                                      : PxMsgDta
     C                                      : %Len( PxMsgDta )
     C                                      : '*COMP'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : *Zero
     C                                      )
     **
     C                   If        %Error
     C                   Return    -1
     **
     C                   Else
     C                   Return    0
     C                   EndIf
     **
     P SndCmpMsg       E
