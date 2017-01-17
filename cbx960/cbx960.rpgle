000100031030     **
000200060923     **  Program . . : CBX960
000300060923     **  Description : Add Server Share - CPP
000400031030     **  Author  . . : Carsten Flensburg
000500031030     **
000600031030     **
000700031030     **
000800031030     **  Programmer's notes:
000900060923     **    To use the QZLSADFS API, you must have *IOSYSCFG special
001000060923     **    authority or own the integrated file system directory.
001100060923     **
001200060923     **    To use the QZLSADPS API, you must have *IOSYSCFG special
001300060923     **    authority or own the output queue.
001400031101     **
001500031101     **
001600031030     **  Compile options:
001700060923     **    CrtRpgMod Module( CBX960 )
001800060624     **              DbgView( *LIST )
001900060624     **
002000060924     **    CrtPgm    Pgm( CBX960 )
002100060923     **              Module( CBX960 )
002200060624     **              ActGrp( *NEW )
002300031030     **
002400031030     **
002500030911     **-- Header specifications:  --------------------------------------------**
002600000926     H Option( *SrcStmt )
002700060624
002800050216     **-- API error data structure:
002900050216     D ERRC0100        Ds                  Qualified
003000050216     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003100050216     D  BytAvl                       10i 0
003200050216     D  MsgId                         7a
003300990921     D                                1a
003400050216     D  MsgDta                      256a
003500050216
003600050216     **-- Global constants:
003700050216     D OFS_MSGDTA      c                   16
003800060923     D JOB_CCSID       c                   0
003900060923     D NULL            c                   x'00'
004000060923     **-- Global variables:
004100060923     D Idx             s             10i 0
004200050216
004300020702     **-- Request variable:
004400060923     D FilExtTbl       Ds                  Qualified  Dim( 128 )
004500060923     D  ExtLen                       10i 0
004600060923     D  FilExt                       46a
004700050216
004800060923     **-- Add file server share:
004900060923     D AddFilShr       Pr                  ExtPgm( 'QZLSADFS' )
005000060923     D  Share                        12a   Const
005100060923     D  PthNam                     1024a   Const  Options( *VarSize )
005200060923     D  PthNamLen                    10i 0 Const
005300060923     D  PthNamCcsId                  10i 0 Const
005400060923     D  TxtDsc                       50a   Const
005500060923     D  Permis                       10i 0 Const
005600060923     D  MaxUsr                       10i 0 Const
005700060624     D  Error                     32767a          Options( *VarSize )
005800060923     D  TxtCnvCcsId                  10i 0 Const  Options( *NoPass )
005900060923     D  EnbTxtCnv                     1a   Const  Options( *NoPass )
006000060923     D  FilExtTbl                          LikeDs( FilExtTbl )  Dim(128)
006100060923     D                                     Const  Options( *NoPass: *VarSize )
006200060923     D  NbrFilExt                    10i 0 Const  Options( *NoPass )
006300060923     **-- Add print server share:
006400060923     D AddPrtShr       Pr                  ExtPgm( 'QZLSADPS' )
006500060923     D  Share                        12a   Const
006600060923     D  OutQue_q                     20a   Const
006700060923     D  TxtDsc                       50a   Const
006800060923     D  SpfTyp                       10i 0 Const
006900060923     D  PrtDrv                       50a   Const
007000060923     D  Error                     32767a          Options( *VarSize )
007100060923     D  PrtF_q                       20a   Const  Options( *NoPass )
007200060923     D  Publish                       1a   Const  Options( *NoPass )
007300050216     **-- Send program message:
007400050216     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
007500060624     D  MsgId                         7a   Const
007600060624     D  MsgF_q                       20a   Const
007700060624     D  MsgDta                      512a   Const  Options( *VarSize )
007800060624     D  MsgDtaLen                    10i 0 Const
007900060624     D  MsgTyp                       10a   Const
008000060624     D  CalStkEnt                    10a   Const  Options( *VarSize )
008100060624     D  CalStkCtr                    10i 0 Const
008200060624     D  MsgKey                        4a
008300060624     D  Error                       512a          Options( *VarSize )
008400050216     **
008500060624     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
008600060624     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
008700060624     D  DspWait                      10i 0 Const  Options( *NoPass )
008800050216     **
008900060624     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
009000060624     D  CcsId                        10i 0 Const  Options( *NoPass )
009100050216
009200050216     **-- Send completion message:
009300050216     D SndCmpMsg       Pr            10i 0
009400050216     D  PxMsgDta                    512a   Const  Varying
009500050216     **-- Send escape message:
009600050216     D SndEscMsg       Pr            10i 0
009700050216     D  PxMsgId                       7a   Const
009800050216     D  PxMsgF                       10a   Const
009900050216     D  PxMsgDta                    512a   Const  Varying
010000050216
010100060624     **-- Entry parameters:
010200060923     D ObjNam_q        Ds                  Qualified
010300060923     D  ObjNam                       10a
010400060923     D  ObjLib                       10a
010500060923     **
010600060923     D FilExt          Ds                  Qualified
010700060923     D  NbrExt                        5i 0
010800060923     D  FilExt                       46a   Varying  Dim( 128 )
010900060923     **
011000060923     D CBX960          Pr
011100060923     D  PxShare                      12a
011200060923     D  PxShrTyp                     10a
011300060923     D  PxPthNam                   1024a   Varying
011400060923     D  PxTxtDsc                     50a
011500060923     D  PxPermis                     10i 0
011600060923     D  PxMaxUsr                     10i 0
011700060923     D  PxCcsId                      10i 0
011800060923     D  PxCnvTxt                      1a
011900060923     D  PxFilExt                           LikeDs( FilExt )
012000060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
012100060923     D  PxSpfTyp                     10i 0
012200060923     D  PxPrtDrv                     50a
012300060923     D  PxPrtF_q                           LikeDs( ObjNam_q )
012400060923     D  PxPublish                     1a
012500060624     **
012600060923     D CBX960          Pi
012700060923     D  PxShare                      12a
012800060923     D  PxShrTyp                     10a
012900060923     D  PxPthNam                   1024a   Varying
013000060923     D  PxTxtDsc                     50a
013100060923     D  PxPermis                     10i 0
013200060923     D  PxMaxUsr                     10i 0
013300060923     D  PxCcsId                      10i 0
013400060923     D  PxCnvTxt                      1a
013500060923     D  PxFilExt                           LikeDs( FilExt )
013600060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
013700060923     D  PxSpfTyp                     10i 0
013800060923     D  PxPrtDrv                     50a
013900060923     D  PxPrtF_q                           LikeDs( ObjNam_q )
014000060923     D  PxPublish                     1a
014100060624
014200050216      /Free
014300050216
014400060923        If  PxShrTyp = '*FILE';
014500060923
014600060924          If  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = *Blank;
014700060923            PxFilExt.NbrExt = *Zero;
014800060923
014900060923          Else;
015000060923            For  Idx = 1  To  PxFilExt.NbrExt;
015100060923
015200060923              FilExtTbl(Idx).ExtLen = %Len( PxFilExt.FilExt(Idx));
015300060923              FilExtTbl(Idx).FilExt = PxFilExt.FilExt(Idx) + NULL;
015400060923            EndFor;
015500060923          EndIf;
015600060923
015700060923          AddFilShr( PxShare
015800060923                   : PxPthNam
015900060923                   : %Len( PxPthNam )
016000060923                   : JOB_CCSID
016100060923                   : PxTxtDsc
016200060923                   : PxPermis
016300060923                   : PxMaxUsr
016400060923                   : ERRC0100
016500060923                   : PxCcsId
016600060923                   : PxCnvTxt
016700060923                   : FilExtTbl
016800060923                   : PxFilExt.NbrExt
016900060923                   );
017000060624        Else;
017100060923          AddPrtShr( PxShare
017200060923                   : PxOutQue_q
017300060923                   : PxTxtDsc
017400060923                   : PxSpfTyp
017500060923                   : PxPrtDrv
017600060923                   : ERRC0100
017700060923                   : PxPrtF_q
017800060923                   : PxPublish
017900060923                   );
018000060624        EndIf;
018100060923
018200060923        If  ERRC0100.BytAvl > *Zero;
018300060923
018400060923          If  ERRC0100.BytAvl < OFS_MSGDTA;
018500060923            ERRC0100.BytAvl = OFS_MSGDTA;
018600060923          EndIf;
018700060923
018800060923          SndEscMsg( ERRC0100.MsgId
018900060923                   : 'QCPFMSG'
019000060923                   : %Subst( ERRC0100.MsgDta
019100060923                           : 1
019200060923                           : ERRC0100.BytAvl - OFS_MSGDTA
019300060923                           )
019400060923                   );
019500060923        Else;
019600060923          SndCmpMsg( 'Share ' + %Trim( PxShare ) + ' added.' );
019700060923        EndIf;
019800060923
019900050216
020000060624        *InLr = *On;
020100060624        Return;
020200050216
020300050216      /End-Free
020400050216
020500050216     **-- Send completion message:  ------------------------------------------**
020600050216     P SndCmpMsg       B
020700050216     D                 Pi            10i 0
020800050216     D  PxMsgDta                    512a   Const  Varying
020900050216     **
021000050216     D MsgKey          s              4a
021100050216
021200050216      /Free
021300050216
021400050216        SndPgmMsg( 'CPF9897'
021500050216                 : 'QCPFMSG   *LIBL'
021600050216                 : PxMsgDta
021700050216                 : %Len( PxMsgDta )
021800050216                 : '*COMP'
021900050216                 : '*PGMBDY'
022000050216                 : 1
022100050216                 : MsgKey
022200050216                 : ERRC0100
022300050216                 );
022400050216
022500050216        If  ERRC0100.BytAvl > *Zero;
022600050216          Return  -1;
022700050216
022800050216        Else;
022900050216          Return  0;
023000050216
023100050216        EndIf;
023200050216
023300050216      /End-Free
023400050216
023500050216     P SndCmpMsg       E
023600050216     **-- Send escape message:  ----------------------------------------------**
023700050216     P SndEscMsg       B
023800050216     D                 Pi            10i 0
023900050216     D  PxMsgId                       7a   Const
024000050216     D  PxMsgF                       10a   Const
024100050216     D  PxMsgDta                    512a   Const  Varying
024200050216     **
024300050216     D MsgKey          s              4a
024400050216
024500050216      /Free
024600050216
024700050216        SndPgmMsg( PxMsgId
024800050216                 : PxMsgF + '*LIBL'
024900050216                 : PxMsgDta
025000050216                 : %Len( PxMsgDta )
025100050216                 : '*ESCAPE'
025200050216                 : '*PGMBDY'
025300050216                 : 1
025400050216                 : MsgKey
025500050216                 : ERRC0100
025600050216                 );
025700050216
025800050216        If  ERRC0100.BytAvl > *Zero;
025900050216          Return  -1;
026000050216
026100050216        Else;
026200050216          Return   0;
026300050216        EndIf;
026400050216
026500050216      /End-Free
026600050216
026700050216     P SndEscMsg       E
