000100041030     **
000200041106     **  Program . . : CBX9261
000300041105     **  Description : Run IFS file processing
000400041030     **  Author  . . : Carsten Flensburg
000500041030     **
000600041105     **
000700041105     **  Parameters:
000800041105     **    PxFilNam . :  INPUT   IFS file name; the IFS file to process
000900041105     **
001000041105     **    PxPthNam . :  INPUT   IFS path name; the path used to locate
001100041105     **                          the IFS file
001200041105     **
001300041105     **
001400041105     **  Program description:
001500041105     **    This program will perform two operations against the IFS file
001600041105     **    specified in the two input parameters, file name and path name:
001700041105     **
001800041105     **    1. Check that no one is currently holding a lock against the
001900041105     **       specified file.  This check is repeated for the number of
002000041105     **       times specified by the program constant NBR_RTY.  The delay
002100041105     **       in seconds between each check is specified by the constant
002200041105     **       RTY_ITV_SEC.
002300041105     **
002400041106     **       Currently the above setting defines a maximum of 120 retreis
002500041106     **       and a 30 second interval between each retry.  This enables
002600041106     **       this function to wait up to an hour for the file creation to
002700041106     **       complete.  Please adjust this setting to accommodate your
002800041106     **       specific requirements.
002900041106     **
003000041105     **       If the attempt to achieve a non-lock situation fails, an
003100041105     **       informational message is sent to the user message queue of
003200041105     **       the user running this program.
003300041105     **
003400041105     **       This function is performed by the program CBX9262.
003500041105     **
003600041105     **    2. Open, read and close the specified IFS file.  While this
003700041105     **       process is run, the IFS file will be checked out to prevent
003800041105     **       other processes from updating it.  Once the file has been
003900041105     **       it will be moved to an archive subdirectory.
004000041105     **
004100041105     **       Any processing of the file data itself can be added to the
004200041105     **       sample program performing this process, CBX9263.
004300041105     **
004400041105     **
004500041030     **  Compile options:
004600041104     **    CrtRpgMod Module( CBX9261 )
004700041030     **              DbgView( *LIST )
004800041030     **
004900041104     **    CrtPgm    Pgm( CBX9261 )
005000041104     **              Module( CBX9261 )
005100041030     **              ActGrp( QILE )
005200041030     **
005300041030     **
005400041030     **-- Header specifications:  --------------------------------------------**
005500041030     H Option( *SrcStmt )
005600041030     **-- System information:
005700041030     D PgmSts         Sds
005800041030     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
005900041030     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
006000041030     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
006100041030     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
006200041030     **-- API error information:
006300041030     D ERRC0100        Ds                  Qualified
006400041030     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
006500041030     D  BytAvl                       10i 0
006600041030     D  MsgId                         7a
006700041030     D                                1a
006800041030     D  MsgDta                      256a
006900041030     **-- Global variables:
007000041030     D MsgDta          s            512a   Varying
007100041030     D MsgKey          s              4a
007200041105     D RtnVal          s             10i 0
007300041030     D RtyCnt          s             10i 0
007400041030     **-- Global constants:
007500041106     D NBR_RTY         c                   120
007600041106     D RTY_ITV_SEC     c                   30
007700041029     **
007800041105     D ChkIfsLck       Pr                  ExtPgm( 'CBX9262' )
007900041030     D  PxPthNam                   2048a   Const  Varying
008000041105     D  PxRtnVal                     10i 0
008100041030     **
008200041105     D PrcIfsFil       Pr                  ExtPgm( 'CBX9263' )
008300041105     D  PxFilNam                   1024a   Const  Varying
008400041030     D  PxPthNam                   1024a   Const  Varying
008500041105     D  PxRtnVal                     10i 0
008600041030     **-- Send message:
008700041030     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
008800041030     D  SmMsgId                       7a   Const
008900041030     D  SmMsgFq                      20a   Const
009000041030     D  SmMsgDta                    512a   Const  Options( *VarSize )
009100041030     D  SmMsgDtaLen                  10i 0 Const
009200041030     D  SmMsgTyp                     10a   Const
009300041030     D  SmMsgQq                    1000a   Const  Options( *VarSize )
009400041030     D  SmMsgQnbr                    10i 0 Const
009500041030     D  SmMsgQrpy                    20a   Const
009600041030     D  SmMsgKey                      4a
009700041030     D  SmError                   32767a          Options( *VarSize )
009800041030     **
009900041030     D  SmCcsId                      10i 0 Const  Options( *NoPass )
010000041030     **-- Delay job:
010100041030     D sleep           Pr            10i 0 ExtProc( 'sleep' )
010200041030     D  seconds                      10u 0 Value
010300041104
010400041104     **-- Entry parameters:
010500041104     D CBX9261         Pr
010600041105     D  PxFilNam                   1024a   Const  Varying
010700041104     D  PxPthNam                   1024a   Const  Varying
010800041104     **
010900041104     D CBX9261         Pi
011000041105     D  PxFilNam                   1024a   Const  Varying
011100041104     D  PxPthNam                   1024a   Const  Varying
011200041016
011300041016      /Free
011400041030
011500041030        For  RtyCnt = 1  To NBR_RTY;
011600041030
011700041105          ChkIfsLck( PxPthNam + '/' + PxFilNam: RtnVal );
011800041030
011900041105          If  RtnVal <= -2;
012000041030            sleep( RTY_ITV_SEC );
012100041030
012200041030          Else;
012300041030            Leave;
012400041030
012500041030          EndIf;
012600041030        EndFor;
012700041030
012800041105        If  RtnVal < *Zero;
012900041030
013000041106          MsgDta = 'IFS file '''        + PxFilNam +
013100041106                   ''' in directory ''' + PxPthNam +
013200041030                   ''' is currently in use and could not be processed.';
013300041030        Else;
013400041030
013500041105          PrcIfsFil( PxFilNam: PxPthNam: RtnVal );
013600041030
013700041105          If  RtnVal < *Zero;
013800041105            MsgDta = 'The attempt to process IFS file ''' + PxFilNam +
013900041104                     ''' in directory '''                 + PxPthNam +
014000041030                     ''' ended in error.';
014100041030          Else;
014200041105            MsgDta = 'The IFS file '''    + PxFilNam +
014300041104                     ''' in directory ''' + PxPthNam +
014400041030                     ''' was processed succesfully.';
014500041030          EndIf;
014600041030        EndIf;
014700041030
014800041030        SndMsg( 'CPF9897'
014900041030              : 'QCPFMSG   *LIBL'
015000041030              : MsgDta
015100041030              : %Len( MsgDta )
015200041030              : '*INFO'
015300041030              : PsCurUsr + '*LIBL'
015400041030              : 1
015500041030              : *Blanks
015600041030              : MsgKey
015700041030              : ERRC0100
015800041030              );
015900041017
016000041030        *InLr = *On;
016100041030        Return;
016200041030
016300041016      /End-Free
