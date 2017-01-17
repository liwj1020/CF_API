000100031030     **
000200061014     **  Program . . : CBX962
000300061014     **  Description : Change Server Share - CPP
000400031030     **  Author  . . : Carsten Flensburg
000500031030     **
000600031030     **
000700031030     **
000800031030     **  Programmer's notes:
000900061014     **    To use the QZLSCHFS API, you must have *IOSYSCFG special
001000060923     **    authority or own the integrated file system directory.
001100060923     **
001200061014     **    To use the QZLSCHPS API, you must have *IOSYSCFG special
001300060923     **    authority or own the output queue.
001400031101     **
001500031101     **
001600031030     **  Compile options:
001700061014     **    CrtRpgMod Module( CBX962 )
001800060624     **              DbgView( *LIST )
001900060624     **
002000061014     **    CrtPgm    Pgm( CBX962 )
002100061014     **              Module( CBX962 )
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
004200061023     D PthNam          s           1024a   Varying
004300061023     D TxtDsc          s             50a
004400061023     D Permis          s             10i 0
004500061023     D MaxUsr          s             10i 0
004600061023     D CcsId           s             10i 0
004700061023     D CnvTxt          s              1a
004800061023     D SpfTyp          s             10i 0
004900061023     D OutQue_q        s             20a
005000061023     D PrtFil_q        s             20a
005100061023     D PrtDrv          s             50a
005200061023     D Publish         s              1a
005300061023     D NbrTblEnt       s             10i 0
005400050216
005500061023     **-- File extension table:
005600061023     D FilExtTbl       Ds                  Qualified
005700061023     D  TblEnt                             Dim( 128 )
005800061023     D   ExtLen                      10i 0 Overlay( TblEnt: 1 )
005900061023     D   FilExt                      46a   Overlay( TblEnt: 5 )
006000061023     **-- List information:
006100061023     D ZLSL0101        Ds         32767    Qualified
006200061023     D  EntLen                       10i 0
006300061023     D  Share                        12a
006400061023     D  DevTyp                       10i 0
006500061023     D  Permis                       10i 0
006600061023     D  MaxUsr                       10i 0
006700061023     D  CurUsr                       10i 0
006800061023     D  SpfTyp                       10i 0
006900061023     D  OfsPthNam                    10i 0
007000061023     D  LenPthNam                    10i 0
007100061023     D  OutQue_q                     20a
007200061023     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
007300061023     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
007400061023     D  PrtDrv                       50a
007500061023     D  TxtDsc                       50a
007600061023     D  PrtFil_q                     20a
007700061023     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
007800061023     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
007900061023     D  TxtCcsId                     10i 0
008000061023     D  OfsExtTbl                    10i 0
008100061023     D  NbrTblEnt                    10i 0
008200061023     D  EnbTxtCnv                     1a
008300061023     D  Publish                       1a
008400061023     **-- List information:
008500061023     D LstInf          Ds                  Qualified
008600061023     D  RcdNbrTot                    10i 0
008700061023     D  RcdNbrRtn                    10i 0
008800061023     D  RcdLen                       10i 0
008900061023     D  InfLen                       10i 0
009000061023     D  InfSts                        1a
009100061023     D  Dts                          13a
009200061023     D                               34a
009300061023
009400061023     **-- Open list of server information:
009500061023     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
009600061023     D  RcvVar                    32767a          Options( *VarSize )
009700061023     D  RcvVarLen                    10i 0 Const
009800061023     D  LstInf                       64a
009900061023     D  Format                        8a   Const
010000061023     D  InfQual                      15a   Const
010100061023     D  Error                     32767a          Options( *VarSize )
010200061023     D  SsnUsr                       10a   Const  Options( *NoPass )
010300061023     D  SsnId                        20u 0 Const  Options( *NoPass )
010400061014     **-- Change file server share:
010500061014     D ChgFilShr       Pr                  ExtPgm( 'QZLSCHFS' )
010600060923     D  Share                        12a   Const
010700060923     D  PthNam                     1024a   Const  Options( *VarSize )
010800060923     D  PthNamLen                    10i 0 Const
010900060923     D  PthNamCcsId                  10i 0 Const
011000060923     D  TxtDsc                       50a   Const
011100060923     D  Permis                       10i 0 Const
011200060923     D  MaxUsr                       10i 0 Const
011300060624     D  Error                     32767a          Options( *VarSize )
011400060923     D  TxtCnvCcsId                  10i 0 Const  Options( *NoPass )
011500060923     D  EnbTxtCnv                     1a   Const  Options( *NoPass )
011600061023     D  FilExtTbl                          LikeDs( FilExtTbl )
011700060923     D                                     Const  Options( *NoPass: *VarSize )
011800060923     D  NbrFilExt                    10i 0 Const  Options( *NoPass )
011900061014     **-- Change print server share:
012000061014     D ChgPrtShr       Pr                  ExtPgm( 'QZLSCHPS' )
012100060923     D  Share                        12a   Const
012200060923     D  OutQue_q                     20a   Const
012300060923     D  TxtDsc                       50a   Const
012400060923     D  SpfTyp                       10i 0 Const
012500060923     D  PrtDrv                       50a   Const
012600060923     D  Error                     32767a          Options( *VarSize )
012700061023     D  PrtFil_q                     20a   Const  Options( *NoPass )
012800060923     D  Publish                       1a   Const  Options( *NoPass )
012900050216     **-- Send program message:
013000050216     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
013100060624     D  MsgId                         7a   Const
013200061023     D  MsgFil_q                     20a   Const
013300060624     D  MsgDta                      512a   Const  Options( *VarSize )
013400060624     D  MsgDtaLen                    10i 0 Const
013500060624     D  MsgTyp                       10a   Const
013600060624     D  CalStkEnt                    10a   Const  Options( *VarSize )
013700060624     D  CalStkCtr                    10i 0 Const
013800060624     D  MsgKey                        4a
013900060624     D  Error                       512a          Options( *VarSize )
014000050216     **
014100060624     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
014200060624     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
014300060624     D  DspWait                      10i 0 Const  Options( *NoPass )
014400050216     **
014500060624     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
014600060624     D  CcsId                        10i 0 Const  Options( *NoPass )
014700050216
014800050216     **-- Send completion message:
014900050216     D SndCmpMsg       Pr            10i 0
015000050216     D  PxMsgDta                    512a   Const  Varying
015100050216     **-- Send escape message:
015200050216     D SndEscMsg       Pr            10i 0
015300050216     D  PxMsgId                       7a   Const
015400050216     D  PxMsgF                       10a   Const
015500050216     D  PxMsgDta                    512a   Const  Varying
015600050216
015700060624     **-- Entry parameters:
015800060923     D ObjNam_q        Ds                  Qualified
015900060923     D  ObjNam                       10a
016000060923     D  ObjLib                       10a
016100060923     **
016200060923     D FilExt          Ds                  Qualified
016300060923     D  NbrExt                        5i 0
016400060923     D  FilExt                       46a   Varying  Dim( 128 )
016500060923     **
016600061014     D CBX962          Pr
016700060923     D  PxShare                      12a
016800060923     D  PxShrTyp                     10a
016900060923     D  PxPthNam                   1024a   Varying
017000060923     D  PxTxtDsc                     50a
017100060923     D  PxPermis                     10i 0
017200060923     D  PxMaxUsr                     10i 0
017300060923     D  PxCcsId                      10i 0
017400060923     D  PxCnvTxt                      1a
017500060923     D  PxFilExt                           LikeDs( FilExt )
017600060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
017700060923     D  PxSpfTyp                     10i 0
017800060923     D  PxPrtDrv                     50a
017900061023     D  PxPrtFil_q                         LikeDs( ObjNam_q )
018000060923     D  PxPublish                     1a
018100060624     **
018200061014     D CBX962          Pi
018300060923     D  PxShare                      12a
018400060923     D  PxShrTyp                     10a
018500060923     D  PxPthNam                   1024a   Varying
018600060923     D  PxTxtDsc                     50a
018700060923     D  PxPermis                     10i 0
018800060923     D  PxMaxUsr                     10i 0
018900060923     D  PxCcsId                      10i 0
019000060923     D  PxCnvTxt                      1a
019100060923     D  PxFilExt                           LikeDs( FilExt )
019200060923     D  PxOutQue_q                         LikeDs( ObjNam_q )
019300060923     D  PxSpfTyp                     10i 0
019400060923     D  PxPrtDrv                     50a
019500061023     D  PxPrtFil_q                         LikeDs( ObjNam_q )
019600060923     D  PxPublish                     1a
019700060624
019800050216      /Free
019900050216
020000061023        LstSvrInf( ZLSL0101
020100061023                 : %Len( ZLSL0101 )
020200061023                 : LstInf
020300061023                 : 'ZLSL0101'
020400061023                 : PxShare
020500061023                 : ERRC0100
020600061023                 );
020700061023
020800061023        If  ERRC0100.BytAvl = *Zero;
020900061023
021000061023          If  PxShrTyp = '*FILE';
021100061023
021200061023            If  ZLSL0101.DevTyp = 0;
021300061023
021400061023              ExSr  SetFilInf;
021500061023
021600061023              ChgFilShr( PxShare
021700061023                       : PthNam
021800061023                       : %Len( PthNam )
021900061023                       : JOB_CCSID
022000061023                       : TxtDsc
022100061023                       : Permis
022200061023                       : MaxUsr
022300061023                       : ERRC0100
022400061023                       : CcsId
022500061023                       : CnvTxt
022600061023                       : FilExtTbl
022700061023                       : NbrTblEnt
022800061023                       );
022900061023              EndIf;
023000061023          Else;
023100061023
023200061023            If  ZLSL0101.DevTyp = 1;
023300061023
023400061023              ExSr  SetOutQueInf;
023500061023
023600061023              ChgPrtShr( PxShare
023700061023                       : OutQue_q
023800061023                       : TxtDsc
023900061023                       : SpfTyp
024000061023                       : PrtDrv
024100061023                       : ERRC0100
024200061023                       : PrtFil_q
024300061023                       : Publish
024400061023                       );
024500061023            EndIf;
024600061023          EndIf;
024700061023        EndIf;
024800060923
024900060923        If  ERRC0100.BytAvl > *Zero;
025000060923
025100060923          If  ERRC0100.BytAvl < OFS_MSGDTA;
025200060923            ERRC0100.BytAvl = OFS_MSGDTA;
025300060923          EndIf;
025400060923
025500060923          SndEscMsg( ERRC0100.MsgId
025600060923                   : 'QCPFMSG'
025700060923                   : %Subst( ERRC0100.MsgDta
025800060923                           : 1
025900060923                           : ERRC0100.BytAvl - OFS_MSGDTA
026000060923                           )
026100060923                   );
026200060923        Else;
026300061014          SndCmpMsg( 'Share ' + %Trim( PxShare ) + ' changed.' );
026400060923        EndIf;
026500060923
026600050216
026700060624        *InLr = *On;
026800060624        Return;
026900050216
027000061023
027100061023        BegSr  SetFilInf;
027200061023
027300061023          If  PxPthNam = '*SAME';
027400061023            PthNam = %Subst( ZLSL0101
027500061023                           : ZLSL0101.OfsPthNam + 1
027600061023                           : ZLSL0101.LenPthNam
027700061023                           );
027800061023          Else;
027900061023            PthNam = PxPthNam;
028000061023          EndIf;
028100061023
028200061023          If  PxTxtDsc = '*SAME';
028300061023            TxtDsc = ZLSL0101.TxtDsc;
028400061023          Else;
028500061023            TxtDsc = PxTxtDsc;
028600061023          EndIf;
028700061023
028800061023          If  PxPermis = *Zero;
028900061023            Permis = ZLSL0101.Permis;
029000061023          Else;
029100061023            Permis = PxPermis;
029200061023          EndIf;
029300061023
029400061023          If  PxMaxUsr = *Zero;
029500061023            MaxUsr = ZLSL0101.MaxUsr;
029600061023          Else;
029700061023            MaxUsr = PxMaxUsr;
029800061023          EndIf;
029900061023
030000061023          If  PxCcsId = -1;
030100061023            CcsId = ZLSL0101.TxtCcsId;
030200061023          Else;
030300061023            CcsId = PxCcsId;
030400061023          EndIf;
030500061023
030600061023          If  PxCnvTxt = '*';
030700061023            CnvTxt = ZLSL0101.EnbTxtCnv;
030800061023          Else;
030900061023            CnvTxt = PxCnvTxt;
031000061023          EndIf;
031100061023
031200061023          Select;
031300061023          When  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = '*SAME';
031400061023            FilExtTbl = %Subst( ZLSL0101
031500061023                              : ZLSL0101.OfsExtTbl + 1
031600061023                              : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
031700061023                              );
031800061023
031900061023            NbrTblEnt = ZLSL0101.NbrTblEnt;
032000061023
032100061023          When  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = *Blank;
032200061023            NbrTblEnt = *Zero;
032300061023
032400061023          Other;
032500061023            For  Idx = 1  To  PxFilExt.NbrExt;
032600061023              FilExtTbl.ExtLen(Idx) = %Len( PxFilExt.FilExt(Idx));
032700061023              FilExtTbl.FilExt(Idx) = PxFilExt.FilExt(Idx) + NULL;
032800061023            EndFor;
032900061023
033000061023            NbrTblEnt = PxFilExt.NbrExt;
033100061023          EndSl;
033200061023
033300061023        EndSr;
033400061023
033500061023        BegSr  SetOutQueInf;
033600061023
033700061023          If  PxTxtDsc = '*SAME';
033800061023            TxtDsc = ZLSL0101.TxtDsc;
033900061023          Else;
034000061023            TxtDsc = PxTxtDsc;
034100061023          EndIf;
034200061023
034300061023          If  PxOutQue_q = '*SAME';
034400061023            OutQue_q = ZLSL0101.OutQue_q;
034500061023          Else;
034600061023            OutQue_q = PxOutQue_q;
034700061023          EndIf;
034800061023
034900061023          If  PxPrtFil_q = '*SAME';
035000061023            PrtFil_q = ZLSL0101.PrtFil_q;
035100061023          Else;
035200061023            PrtFil_q = PxPrtFil_q;
035300061023          EndIf;
035400061023
035500061023          If  PxPrtDrv = '*SAME';
035600061023            PrtDrv = ZLSL0101.PrtDrv;
035700061023          Else;
035800061023            PrtDrv = PxPrtDrv;
035900061023          EndIf;
036000061023
036100061023          If  PxSpfTyp = *Zero;
036200061023            SpfTyp = ZLSL0101.SpfTyp;
036300061023          Else;
036400061023            SpfTyp = PxSpfTyp;
036500061023          EndIf;
036600061023
036700061023          If  PxPublish = '*';
036800061023            Publish = ZLSL0101.Publish;
036900061023          Else;
037000061023            Publish = PxPublish;
037100061023          EndIf;
037200061023
037300061023        EndSr;
037400061023
037500050216      /End-Free
037600050216
037700050216     **-- Send completion message:  ------------------------------------------**
037800050216     P SndCmpMsg       B
037900050216     D                 Pi            10i 0
038000050216     D  PxMsgDta                    512a   Const  Varying
038100050216     **
038200050216     D MsgKey          s              4a
038300050216
038400050216      /Free
038500050216
038600050216        SndPgmMsg( 'CPF9897'
038700050216                 : 'QCPFMSG   *LIBL'
038800050216                 : PxMsgDta
038900050216                 : %Len( PxMsgDta )
039000050216                 : '*COMP'
039100050216                 : '*PGMBDY'
039200050216                 : 1
039300050216                 : MsgKey
039400050216                 : ERRC0100
039500050216                 );
039600050216
039700050216        If  ERRC0100.BytAvl > *Zero;
039800050216          Return  -1;
039900050216        Else;
040000050216          Return  0;
040100050216        EndIf;
040200050216
040300050216      /End-Free
040400050216
040500050216     P SndCmpMsg       E
040600050216     **-- Send escape message:  ----------------------------------------------**
040700050216     P SndEscMsg       B
040800050216     D                 Pi            10i 0
040900050216     D  PxMsgId                       7a   Const
041000050216     D  PxMsgF                       10a   Const
041100050216     D  PxMsgDta                    512a   Const  Varying
041200050216     **
041300050216     D MsgKey          s              4a
041400050216
041500050216      /Free
041600050216
041700050216        SndPgmMsg( PxMsgId
041800050216                 : PxMsgF + '*LIBL'
041900050216                 : PxMsgDta
042000050216                 : %Len( PxMsgDta )
042100050216                 : '*ESCAPE'
042200050216                 : '*PGMBDY'
042300050216                 : 1
042400050216                 : MsgKey
042500050216                 : ERRC0100
042600050216                 );
042700050216
042800050216        If  ERRC0100.BytAvl > *Zero;
042900050216          Return  -1;
043000050216
043100050216        Else;
043200050216          Return   0;
043300050216        EndIf;
043400050216
043500050216      /End-Free
043600050216
043700050216     P SndEscMsg       E
