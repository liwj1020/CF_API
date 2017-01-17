000100031030     **
000200060924     **  Program . . : CBX961
000300060924     **  Description : Remove Server Share - CPP
000400031030     **  Author  . . : Carsten Flensburg
000500031030     **
000600031030     **
000700031030     **
000800031030     **  Programmer's notes:
000900060924     **    To use the QZLSRMS API, you must have *IOSYSCFG special
001000060924     **    authority or own the integrated file system directory or
001100060924     **    the output queue that the share references.
001200031101     **
001300031101     **
001400031030     **  Compile options:
001500060924     **    CrtRpgMod Module( CBX961 )
001600060624     **              DbgView( *LIST )
001700060624     **
001800060924     **    CrtPgm    Pgm( CBX961 )
001900060924     **              Module( CBX961 )
002000060624     **              ActGrp( *NEW )
002100031030     **
002200031030     **
002300030911     **-- Header specifications:  --------------------------------------------**
002400000926     H Option( *SrcStmt )
002500060624
002600050216     **-- API error data structure:
002700050216     D ERRC0100        Ds                  Qualified
002800050216     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002900050216     D  BytAvl                       10i 0
003000050216     D  MsgId                         7a
003100990921     D                                1a
003200050216     D  MsgDta                      256a
003300050216
003400050216     **-- Global constants:
003500050216     D OFS_MSGDTA      c                   16
003600050216
003700060924     **-- Remove server share:
003800060924     D RmvSvrShr       Pr                  ExtPgm( 'QZLSRMS' )
003900060923     D  Share                        12a   Const
004000060624     D  Error                     32767a          Options( *VarSize )
004100050216     **-- Send program message:
004200050216     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
004300060624     D  MsgId                         7a   Const
004400060624     D  MsgF_q                       20a   Const
004500060624     D  MsgDta                      512a   Const  Options( *VarSize )
004600060624     D  MsgDtaLen                    10i 0 Const
004700060624     D  MsgTyp                       10a   Const
004800060624     D  CalStkEnt                    10a   Const  Options( *VarSize )
004900060624     D  CalStkCtr                    10i 0 Const
005000060624     D  MsgKey                        4a
005100060624     D  Error                       512a          Options( *VarSize )
005200050216     **
005300060624     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
005400060624     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
005500060624     D  DspWait                      10i 0 Const  Options( *NoPass )
005600050216     **
005700060624     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
005800060624     D  CcsId                        10i 0 Const  Options( *NoPass )
005900050216
006000050216     **-- Send completion message:
006100050216     D SndCmpMsg       Pr            10i 0
006200050216     D  PxMsgDta                    512a   Const  Varying
006300050216     **-- Send escape message:
006400050216     D SndEscMsg       Pr            10i 0
006500050216     D  PxMsgId                       7a   Const
006600050216     D  PxMsgF                       10a   Const
006700050216     D  PxMsgDta                    512a   Const  Varying
006800050216
006900060624     **-- Entry parameters:
007000060924     D CBX961          Pr
007100060923     D  PxShare                      12a
007200060624     **
007300060924     D CBX961          Pi
007400060923     D  PxShare                      12a
007500060624
007600050216      /Free
007700060923
007800060924        RmvSvrShr( PxShare: ERRC0100 );
007900060923
008000060923        If  ERRC0100.BytAvl > *Zero;
008100060923
008200060923          If  ERRC0100.BytAvl < OFS_MSGDTA;
008300060923            ERRC0100.BytAvl = OFS_MSGDTA;
008400060923          EndIf;
008500060923
008600060923          SndEscMsg( ERRC0100.MsgId
008700060923                   : 'QCPFMSG'
008800060923                   : %Subst( ERRC0100.MsgDta
008900060923                           : 1
009000060923                           : ERRC0100.BytAvl - OFS_MSGDTA
009100060923                           )
009200060923                   );
009300060923        Else;
009400060924          SndCmpMsg( 'Share ' + %Trim( PxShare ) + ' removed.' );
009500060923        EndIf;
009600060923
009700060624        *InLr = *On;
009800060624        Return;
009900050216
010000050216      /End-Free
010100050216
010200050216     **-- Send completion message:  ------------------------------------------**
010300050216     P SndCmpMsg       B
010400050216     D                 Pi            10i 0
010500050216     D  PxMsgDta                    512a   Const  Varying
010600050216     **
010700050216     D MsgKey          s              4a
010800050216
010900050216      /Free
011000050216
011100050216        SndPgmMsg( 'CPF9897'
011200050216                 : 'QCPFMSG   *LIBL'
011300050216                 : PxMsgDta
011400050216                 : %Len( PxMsgDta )
011500050216                 : '*COMP'
011600050216                 : '*PGMBDY'
011700050216                 : 1
011800050216                 : MsgKey
011900050216                 : ERRC0100
012000050216                 );
012100050216
012200050216        If  ERRC0100.BytAvl > *Zero;
012300050216          Return  -1;
012400050216
012500050216        Else;
012600050216          Return  0;
012700050216
012800050216        EndIf;
012900050216
013000050216      /End-Free
013100050216
013200050216     P SndCmpMsg       E
013300050216     **-- Send escape message:  ----------------------------------------------**
013400050216     P SndEscMsg       B
013500050216     D                 Pi            10i 0
013600050216     D  PxMsgId                       7a   Const
013700050216     D  PxMsgF                       10a   Const
013800050216     D  PxMsgDta                    512a   Const  Varying
013900050216     **
014000050216     D MsgKey          s              4a
014100050216
014200050216      /Free
014300050216
014400050216        SndPgmMsg( PxMsgId
014500050216                 : PxMsgF + '*LIBL'
014600050216                 : PxMsgDta
014700050216                 : %Len( PxMsgDta )
014800050216                 : '*ESCAPE'
014900050216                 : '*PGMBDY'
015000050216                 : 1
015100050216                 : MsgKey
015200050216                 : ERRC0100
015300050216                 );
015400050216
015500050216        If  ERRC0100.BytAvl > *Zero;
015600050216          Return  -1;
015700050216
015800050216        Else;
015900050216          Return   0;
016000050216        EndIf;
016100050216
016200050216      /End-Free
016300050216
016400050216     P SndEscMsg       E
