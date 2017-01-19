000100040314     **
000200041104     **  Program . . : CBX9262
000300041018     **  Description : Check IFS object lock
000400040314     **  Author  . . : Carsten Flensburg
000500040314     **
000600041105     **
000700041105     **  Parameters:
000800041105     **    PxPthNam . :  INPUT   The full path name of the IFS object for
000900041105     **                          which to check the current lock status
001000041105     **
001100041105     **    PxRtnVal . :  OUTPUT  The return value indicating how the object
001200041105     **                          lock check ended:
001300041105     **
001400041105     **                            0 =  IFS object not currently locked
001500041105     **
001600041105     **                           -1 =  Error occurred while retrieving
001700041105     **                                 the lock status
001800041105     **
001900041105     **                           -2 =  IFS object currently locked
002000041105     **
002100041105     **                           -3 =  IFS object currently checked out
002200041105     **
002300041105     **
002400041105     **  Program description:
002500041105     **    This program will return information about the current lock
002600041105     **    status of the specified IFS file.
002700040318     **
002800041105     **
002900040314     **  Programmer's notes:
003000041030     **    Both the QP0LROR (Retrieve object references) was introduced with
003100041030     **    release V5R2 and this program will therefore not be able to run
003200041030     **    succesfully on earlier releases.
003300040314     **
003400040318     **    QP0LROR documentation and comprehensive usage notes can be found here:
003500040318     **    http://as400bks.rochester.ibm.com/iseries/v5r2/ic2924/info/apis/qp0lror.htm
003600040318     **
003700040318     **
003800040314     **  Compile options:
003900041104     **    CrtRpgMod Module( CBX9262 )  DbgView( *LIST )
004000040314     **
004100041104     **    CrtPgm    Pgm( CBX9262 )
004200041104     **              Module( CBX9262 )
004300040314     **
004400040314     **
004500040314     **-- Control specification:  --------------------------------------------**
004600041030     H Option( *SrcStmt )
004700010329     **-- Api error data structure:  -----------------------------------------**
004800041018     D ERRC0100        Ds                  Qualified
004900041018     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
005000041018     D  BytAvl                       10i 0 Inz
005100041018     D  MsgId                         7a
005200010329     D                                1a
005300041018     D  MsgDta                      128a
005400041018     **-- Global declarations:  ----------------------------------------------**
005500041018     D CurCcsId        c                   0
005600041018     D CurCtrId        c                   x'0000'
005700041018     D CurLngId        c                   x'000000'
005800041018     D ChrDlm1         c                   0
005900040314     **-- Api path:  ---------------------------------------------------------**
006000041018     D Path            Ds                  Qualified
006100041018     D  CcsId                        10i 0 Inz( CurCcsId )
006200041018     D  CtrId                         2a   Inz( CurCtrId )
006300041018     D  LngId                         3a   Inz( CurLngId )
006400030529     D                                3a   Inz( *Allx'00' )
006500041018     D  PthTypI                      10i 0 Inz( ChrDlm1 )
006600041018     D  PthNamLen                    10i 0
006700041018     D  PthNamDlm                     2a   Inz( '/ ' )
006800030529     D                               10a   Inz( *Allx'00' )
006900041018     D  PthNam                     1024a
007000030529     **-- Object reference information: --------------------------------------**
007100041018     D RORO0100        Ds                  Qualified
007200041018     D  BytRtn                       10u 0
007300041018     D  BytAvl                       10u 0
007400041018     D  OfsSmpRef                    10u 0
007500041018     D  LenSmpRef                    10u 0
007600041018     D  RefCnt                       10u 0
007700041018     D  InUseI                       10u 0
007800030529     **-- Retrieve object references:  ---------------------------------------**
007900040319     D RtvObjRef       Pr                  ExtPgm( 'QP0LROR' )
008000030529     D  RoRcvVar                  65535a          Options( *VarSize )
008100030529     D  RoRcvVarLen                  10u 0 Const
008200030529     D  RoFmtNam                      8a   Const
008300040314     D  RoPthStr                   4096a   Const  Options( *VarSize )
008400030529     D  RoError                   32767a          Options( *VarSize: *NoPass)
008500041018     **-- Entry parameters:
008600041104     D CBX9262         Pr
008700041030     D  PxPthNam                   2048a   Const  Varying
008800041105     D  PxRtnVal                     10i 0
008900041018     **
009000041104     D CBX9262         Pi
009100041030     D  PxPthNam                   2048a   Const  Varying
009200041105     D  PxRtnVal                     10i 0
009300041018
009400041018      /Free
009500041018
009600041105        PxRtnVal = *Zero;
009700041018
009800041018        Path.PthNam = PxPthNam;
009900041018        Path.PthNamLen = %Len( PxPthNam );
010000041018
010100041018        RtvObjRef( RORO0100: %Size( RORO0100 ): 'RORO0100': Path: ERRC0100 );
010200041018
010300041018        Select;
010400041018        When ERRC0100.BytAvl > *Zero;
010500041105          PxRtnVal = -1;
010600041018
010700041018        When RORO0100.RefCnt > *Zero;
010800041105          PxRtnVal = -2;
010900041018
011000041018        When RORO0100.InUseI > *Zero;
011100041105          PxRtnVal = -3;
011200041018        EndSl;
011300041018
011400041018        *InLr = *On;
011500041018        Return;
011600041018
011700041018      /End-Free
