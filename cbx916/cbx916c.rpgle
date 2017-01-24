     **
     **  Program . . : CBX916
     **  Description : Display language ID's default CCSID - choice program
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **     This program will list all available language IDs and their
     **     corresponding description.
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX916C )
     **
     **    CrtPgm    Pgm( CBX916C )
     **              Module( CBX916C )
     **              ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )
     **-- Api error data structure:  -----------------------------------------**
     D ApiError        Ds
     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0 Inz
     D  AeMsgId                       7a
     D                                1a
     D  AeMsgDta                    128a
     **-- Global declarations:  ----------------------------------------------**
     D Idx             s             10i 0
     **-- Retrieve language ids:  --------------------------------------------**
     D RtvLngIds       Pr                  ExtPgm( 'QLGRTVLI' )
     D  LiRcvVar                  32767a          Options( *VarSize )
     D  LiRcvVarLen                  10i 0 Const
     D  LiFmtNam                      8a   Const
     D  LiError                   32767a          Options( *VarSize )
     **-- Language id list:  -------------------------------------------------**
     D RTVL0100        Ds         65535
     D  R1BytRtn                     10i 0
     D  R1BytAvl                     10i 0
     D  R1NbrLngIds                  10i 0
     D  R1DscCcsId                   10i 0
     D  R1OfsLngIds                  10i 0
     **
     D LngId           Ds                  Based( pLngId )
     D  LiLngId                       3a
     D  LiLngIdDsc                   40a
     **-- Parameters:  -------------------------------------------------------**
     D Parm1           Ds
     D  P1Cmd                        10a
     D  P1Kwd                        10a
     D  P1Typ                         1a
     **
     D Parm2           Ds         10240
     D  P2Choice                     30a   Overlay( Parm2: 1 )
     D  P2NbrEnt                      5i 0 Overlay( Parm2: 1 )
     D  P2PmsVal                  10238a   Overlay( Parm2: 3 )
     **-- Global variables:  -------------------------------------------------**
     D ChcTxt          s             64a   Varying
     D ChcVal          s             64a   Varying
     D PmsTxt          s             32a   Varying
     D TxtLen          s              5i 0
     D ChcLen          s              5i 0
     D PmsLen          s              5i 0
     **-- Scan reverse:  -----------------------------------------------------**
     D ScanR           Pr             5u 0
     D  PxArg                       128a   Const  Varying
     D  PxString                   4096a   Const  Varying
     D  PxOfs                         5u 0 Const  Options( *NoPass )
     **-- Copy memory:  ------------------------------------------------------**
     D memcpy          Pr              *   ExtProc( '_MEMMOVE' )
     D  outmem                         *   Value
     D  inpmem                         *   Value
     D  memsiz                       10u 0 Value
     **-- Parameters:  -------------------------------------------------------**
     **
     C     *Entry        Plist
     C                   Parm                    Parm1
     C                   Parm                    Parm2
     **
     **-- Mainline:  ---------------------------------------------------------**
     **
     C                   Clear                   Parm2
     **
     C                   CallP     RtvLngIds( RTVL0100
     C                                      : %Size( RTVL0100 )
     C                                      : 'RTVL0100'
     C                                      : ApiError
     C                                      )
     **
     C                   If        AeBytAvl    = *Zero
     **
     C                   Select
     C                   When      P1Typ       = 'P'
     C                   Exsr      GetPmsVal
     **
     C                   When      P1Typ       = 'C'
     C                   Exsr      GetChcTxt
     C                   EndSl
     C                   EndIf
     **
     C                   Eval      *InLr = *On
     C                   Return
     **
     **-- Get permissible values:  -------------------------------------------**
     C     GetPmsVal     BegSr
     **
     C                   Eval      P2NbrEnt   =  0
     C                   Eval      PmsLen     =  0
     **
     C                   Eval      pLngId      = %Addr( RTVL0100 ) +
     C                                           R1OfsLngIds
     **
     C                   For       Idx = 1  To R1NbrLngIds
     **
     C                   If        PmsLen     >  %Size( P2PmsVal )
     C                   Leave
     C                   EndIf
     **
     C                   Eval      PmsTxt     =  LiLngId + '  ' + LiLngIdDsc
     C                   Eval      TxtLen     =  %Len( PmsTxt )
     **
     C                   If        PmsLen +
     C                             TxtLen +
     C                             %Size( TxtLen )
     C                                       <=  %Size( P2PmsVal )
     **
     C                   CallP     memcpy( %Addr( P2PmsVal ) +
     C                                     PmsLen
     C                                   : %Addr( TxtLen )
     C                                   : %Size( TxtLen )
     C                                   )
     **
     C                   CallP     memcpy( %Addr( P2PmsVal ) +
     C                                     PmsLen + %Size( TxtLen )
     C                                   : %Addr( PmsTxt ) + %Size( TxtLen )
     C                                   : TxtLen
     C                                   )
     **
     C                   Eval      PmsLen     =  PmsLen +
     C                                           TxtLen +
     C                                           %Size( TxtLen )
     **
     C                   Eval      P2NbrEnt    = P2NbrEnt + 1
     C                   EndIf
     **
     C                   If        Idx         < R1NbrLngIds
     C                   Eval      pLngId     += %Size( LngId )
     C                   EndIf
     C                   EndFor
     **
     C                   Endsr
     **-- Get choice text:  --------------------------------------------------**
     C     GetChcTxt     BegSr
     **
     C                   Eval      pLngId      = %Addr( RTVL0100 ) +
     C                                           R1OfsLngIds
     **
     C                   For       Idx = 1  To R1NbrLngIds
     **
     C                   Eval      ChcVal     =  %Trim( LiLngId )
     **
     C                   If        ChcTxt     =  *Blanks
     C                   Eval      ChcTxt     =  ChcVal
     C                   Else
     C                   Eval      ChcTxt     =  ChcTxt + ', ' + ChcVal
     C                   EndIf
     **
     C                   If        %Len( ChcTxt ) > %Size( P2Choice )
     **
     C                   Eval      ChcLen     =  ScanR( ','
     C                                                : ChcTxt
     C                                                : %Size( P2Choice ) - 2
     C                                                ) - 1
     **
     C                   If        ChcLen     =  *Zero
     C                   Eval      ChcLen     =  %Size( P2Choice ) - 3
     C                   EndIf
     **
     C                   Eval      ChcTxt     =  %Subst( ChcTxt
     C                                                 : 1
     C                                                 : ChcLen
     C                                                 ) + '...'
     C
     C                   Leave
     C                   EndIf
     **
     C                   If        Idx         < R1NbrLngIds
     C                   Eval      pLngId     += %Size( LngId )
     C                   EndIf
     C                   EndFor
     **
     C                   Eval      P2Choice   =  ChcTxt
     **
     C                   Endsr
     **-- Scan reverse:  -----------------------------------------------------**
     P ScanR           B                   Export
     D                 Pi             5u 0
     D  PxArg                       128a   Const  Varying
     D  PxString                   4096a   Const  Varying
     D  PxOfs                         5u 0 Const  Options( *NoPass )
     **
     D Pos             s              5u 0
     D Ofs             s              5u 0
     **
     C                   If        %Parms     = 3
     C                   Eval      Ofs        = PxOfs - %Len( PxArg ) + 1
     **
     C                   Else
     C                   Eval      Ofs        = %Len( PxString ) -
     C                                          %Len( PxArg )    + 1
     C                   EndIf
     **
     C                   If        Ofs        > %Len( PxString )
     C                   Eval      Pos        = %Len( PxString ) + 1
     C                   Else
     **
     C                   For       Pos = Ofs  DownTo 1
     **
     C                   If        %SubSt( PxString
     C                                   : Pos
     C                                   : %Len( PxArg )
     C                                   )    =  PxArg
     C                   Leave
     C                   EndIf
     C                   EndFor
     C                   EndIf
     **
     C                   Return    Pos
     **
     P ScanR           E
