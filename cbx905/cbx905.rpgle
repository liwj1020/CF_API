     **-- API description:  --------------------------------------------------**
     **
     **   The Retrieve identity of last spooled file created (QSPRILSP) API
     **   returns the complete spooled file identity of the last spooled
     **   file created for the current job or thread.
     **
     **   The QSPRILSP is available as of V5R2.
     **
     **
     **-- Compilation specification:  ----------------------------------------**
     **
     **   CrtBndRpg   Pgm( <library>/CBX905 )
     **               SrcFile( <library>/QRPGLESRC )
     **
     **
     **-- Header:  -----------------------------------------------------------**
     H Option( *SrcStmt )  DftActGrp( *No )
     **-- API error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPrv                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeExcpId                      7a
     D                                1a
     D  AeExcpDta                   128a
     **-- Spooled file information:  -----------------------------------------**
     D SPRL0100        Ds
     D  SiBytRtn                     10i 0
     D  SiBytAvl                     10i 0
     D  SiSplfNam                    10a
     D  SiJobNam                     10a
     D  SiUsrNam                     10a
     D  SiJobNbr                      6a
     D  SiSplfNbr                    10i 0
     D  SiJobSysNam                   8a
     D  SiSplfCrtDat                  7a
     D                                1a
     D  SiSplfCrtTim                  6a
     **-- Retrieve last spooled file identity:  ------------------------------**
     D RtvLstSplfId    Pr                  ExtPgm( 'QSPRILSP' )
     D  RsRcvVar                  32767a          Options( *VarSize )
     D  RsRcvVarLen                  10i 0 Const
     D  RsFmtNam                      8a   Const
     D  RsError                   32767a          Options( *VarSize )
     **
     **-- Retrieve last spooled file identity:  ------------------------------**
     **
     C                   CallP     RtvLstSplfId( SPRL0100
     C                                         : %Size( SPRL0100 )
     C                                         : 'SPRL0100'
     C                                         : ApiError
     C                                         )
     **
     C                   If        AeBytAvl    = *Zero
     **.. Do whatever...
     C                   EndIf
     **
     C                   Eval      *InLr      = *On
     C                   Return
     **
