     **
     **  Program . . : CBX9262
     **  Description : Check IFS object lock
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxPthNam . :  INPUT   The full path name of the IFS object for
     **                          which to check the current lock status
     **
     **    PxRtnVal . :  OUTPUT  The return value indicating how the object
     **                          lock check ended:
     **
     **                            0 =  IFS object not currently locked
     **
     **                           -1 =  Error occurred while retrieving
     **                                 the lock status
     **
     **                           -2 =  IFS object currently locked
     **
     **                           -3 =  IFS object currently checked out
     **
     **
     **  Program description:
     **    This program will return information about the current lock
     **    status of the specified IFS file.
     **
     **
     **  Programmer's notes:
     **    Both the QP0LROR (Retrieve object references) was introduced with
     **    release V5R2 and this program will therefore not be able to run
     **    succesfully on earlier releases.
     **
     **    QP0LROR documentation and comprehensive usage notes can be found here:
     **    http://as400bks.rochester.ibm.com/iseries/v5r2/ic2924/info/apis/qp0lror.htm
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX9262 )  DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX9262 )
     **              Module( CBX9262 )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- Api error data structure:  -----------------------------------------**
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global declarations:  ----------------------------------------------**
     D CurCcsId        c                   0
     D CurCtrId        c                   x'0000'
     D CurLngId        c                   x'000000'
     D ChrDlm1         c                   0
     **-- Api path:  ---------------------------------------------------------**
     D Path            Ds                  Qualified
     D  CcsId                        10i 0 Inz( CurCcsId )
     D  CtrId                         2a   Inz( CurCtrId )
     D  LngId                         3a   Inz( CurLngId )
     D                                3a   Inz( *Allx'00' )
     D  PthTypI                      10i 0 Inz( ChrDlm1 )
     D  PthNamLen                    10i 0
     D  PthNamDlm                     2a   Inz( '/ ' )
     D                               10a   Inz( *Allx'00' )
     D  PthNam                     1024a
     **-- Object reference information: --------------------------------------**
     D RORO0100        Ds                  Qualified
     D  BytRtn                       10u 0
     D  BytAvl                       10u 0
     D  OfsSmpRef                    10u 0
     D  LenSmpRef                    10u 0
     D  RefCnt                       10u 0
     D  InUseI                       10u 0
     **-- Retrieve object references:  ---------------------------------------**
     D RtvObjRef       Pr                  ExtPgm( 'QP0LROR' )
     D  RoRcvVar                  65535a          Options( *VarSize )
     D  RoRcvVarLen                  10u 0 Const
     D  RoFmtNam                      8a   Const
     D  RoPthStr                   4096a   Const  Options( *VarSize )
     D  RoError                   32767a          Options( *VarSize: *NoPass)
     **-- Entry parameters:
     D CBX9262         Pr
     D  PxPthNam                   2048a   Const  Varying
     D  PxRtnVal                     10i 0
     **
     D CBX9262         Pi
     D  PxPthNam                   2048a   Const  Varying
     D  PxRtnVal                     10i 0

      /Free

        PxRtnVal = *Zero;

        Path.PthNam = PxPthNam;
        Path.PthNamLen = %Len( PxPthNam );

        RtvObjRef( RORO0100: %Size( RORO0100 ): 'RORO0100': Path: ERRC0100 );

        Select;
        When ERRC0100.BytAvl > *Zero;
          PxRtnVal = -1;

        When RORO0100.RefCnt > *Zero;
          PxRtnVal = -2;

        When RORO0100.InUseI > *Zero;
          PxRtnVal = -3;
        EndSl;

        *InLr = *On;
        Return;

      /End-Free
