000100041212     **
000200050325     **  Program . . : CBX933
000300050325     **  Description : Start journal for library - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Program description:
000800050327     **    This program will, depending on object type, run the STRJRNPF
000900050328     **    or STRJRNOBJ command for the objects defined by the input
001000050327     **    parameters.
001100041212     **
001200050325     **
001300041212     **  Compile and setup instructions:
001400050325     **    CrtRpgMod   Module( CBX933 )
001500041212     **                DbgView( *NONE )
001600041212     **                Aut( *USE )
001700041212     **
001800050325     **    CrtPgm      Pgm( CBX933 )
001900050325     **                Module( CBX933 )
002000041212     **                ActGrp( *NEW )
002100041212     **
002200041212     **
002300041212     **-- Control specification:  --------------------------------------------**
002400041212     H Option( *SrcStmt: *NoDebugIo )
002500041211     **-- API error data structure:
002600041211     D ERRC0100        Ds                  Qualified
002700041211     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
002800041211     D  BytAvl                       10i 0
002900041211     D  MsgId                         7a
003000990921     D                                1a
003100041211     D  MsgDta                      128a
003200041212     **-- Global variables:
003300041211     D Idx             s             10i 0
003400050325     D ObjCntSlt       s             10i 0 Inz( *Zero )
003500050325     D ObjCntIgn       s             10i 0 Inz( *Zero )
003600050325     **
003700050325     D ObjNam_q        Ds
003800050325     D  ObjNam                       10a
003900050325     D  ObjLib                       10a
004000050212     **-- List API parameters:
004100050212     D LstApi          Ds                  Qualified  Inz
004200050212     D  RtnRcdNbr                    10i 0
004300050212     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
004400050325     D  KeyFld                       10i 0 Dim( 2 )
004500050326     D  ObjTyp                       10a
004600040426     **-- Object information:
004700041211     D ObjInf          Ds          4096    Qualified
004800041212     D  ObjNam                       10a
004900041212     D  ObjLib                       10a
005000041212     D  ObjTyp                       10a
005100041211     D  InfSts                        1a
005200040426     D                                1a
005300041211     D  FldNbrRtn                    10i 0
005400041211     D  Data                               Like( KeyInf )
005500040426     **-- Key information:
005600041211     D KeyInf          Ds                  Qualified  Based( pKeyInf )
005700041211     D  FldInfLen                    10i 0
005800041211     D  KeyFld                       10i 0
005900041211     D  DtaTyp                        1a
006000041211     D                                3a
006100041211     D  DtaLen                       10i 0
006200041211     D  Data                        256a
006300040426     **-- List information:
006400041211     D LstInf          Ds                  Qualified
006500041211     D  RcdNbrTot                    10i 0
006600041211     D  RcdNbrRtn                    10i 0
006700041211     D  Handle                        4a
006800041211     D  RcdLen                       10i 0
006900041211     D  InfSts                        1a
007000041211     D  Dts                          13a
007100041211     D  LstSts                        1a
007200040426     D                                1a
007300041211     D  InfLen                       10i 0
007400041211     D  Rcd1                         10i 0
007500040426     D                               40a
007600040426     **-- Sort information:
007700041211     D SrtInf          Ds                  Qualified
007800041211     D  NbrKeys                      10i 0 Inz( 0 )
007900041211     D  SrtInf                       12a   Dim( 10 )
008000041211     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
008100041211     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
008200041211     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
008300041211     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
008400041211     D   Rsv                          1a   Overlay( SrtInf: *Next )
008500040426     **-- Authority control:
008600041211     D AutCtl          Ds                  Qualified
008700041211     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
008800041211     D  CalLvl                       10i 0 Inz( 0 )
008900041211     D  DplObjAut                    10i 0 Inz( 0 )
009000041211     D  NbrObjAut                    10i 0 Inz( 0 )
009100041211     D  DplLibAut                    10i 0 Inz( 0 )
009200041211     D  NbrLibAut                    10i 0 Inz( 0 )
009300040426     D                               10i 0 Inz( 0 )
009400041211     D  ObjAut                       10a   Dim( 10 )
009500041211     D  LibAut                       10a   Dim( 10 )
009600040426     **-- Selection control:
009700041211     D SltCtl          Ds
009800041211     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
009900041211     D  SltOmt                       10i 0 Inz( 0 )
010000041211     D  DplSts                       10i 0 Inz( 20 )
010100041211     D  NbrSts                       10i 0 Inz( 1 )
010200040426     D                               10i 0 Inz( 0 )
010300041211     D  Status                        1a   Inz( '*' )
010400040426     **-- Object information key fields:
010500050325     D KeyFld          Ds                  Qualified
010600050325     D  ExtObjAtr                    10a
010700050325     D  JrnSts                        1a
010800041211     **-- Open list of objects:
010900040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
011000040426     D  LoRcvVar                  65535a          Options( *VarSize )
011100040426     D  LoRcvVarLen                  10i 0 Const
011200040426     D  LoLstInf                     80a
011300040426     D  LoNbrRcdRtn                  10i 0 Const
011400040426     D  LoSrtInf                   1024a   Const  Options( *VarSize )
011500040426     D  LoObjNam_q                   20a   Const
011600040426     D  LoObjTyp                     10a   Const
011700040426     D  LoAutCtl                   1024a   Const  Options( *VarSize )
011800040426     D  LoSltCtl                   1024a   Const  Options( *VarSize )
011900041211     D  LoNbrKeyRtn                  10i 0 Const
012000041211     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
012100040426     D  LoError                    1024a          Options( *VarSize )
012200020531     **
012300040426     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
012400040426     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
012500040426     **
012600040426     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
012700041212     **-- Get list entry:
012800020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
012900020531     D  GlRcvVar                  65535a          Options( *VarSize )
013000020531     D  GlRcvVarLen                  10i 0 Const
013100020531     D  GlHandle                      4a   Const
013200020531     D  GlLstInf                     80a
013300020531     D  GlNbrRcdRtn                  10i 0 Const
013400020531     D  GlRtnRcdNbr                  10i 0 Const
013500020531     D  GlError                    1024a          Options( *VarSize )
013600041212     **-- Close list:
013700020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
013800020531     D  ClHandle                      4a   Const
013900020531     D  ClError                    1024a          Options( *VarSize )
014000050325     **-- Process commands:
014100050325     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
014200050325     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
014300050325     D  PcSrcCmdLen                  10i 0 Const
014400050325     D  PcOptCtlBlk                  20a   Const
014500050325     D  PcOptCtlBlkLn                10i 0 Const
014600050325     D  PcOptCtlBlkFm                 8a   Const
014700050325     D  PcChgCmd                  32767a          Options( *VarSize )
014800050325     D  PcChgCmdLen                  10i 0 Const
014900050325     D  PcChgCmdLenAv                10i 0
015000050325     D  PcError                   32767a          Options( *VarSize )
015100050325     **-- Send program message:
015200050325     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
015300050325     D  SpMsgId                       7a   Const
015400050325     D  SpMsgFq                      20a   Const
015500050325     D  SpMsgDta                    128a   Const
015600050325     D  SpMsgDtaLen                  10i 0 Const
015700050325     D  SpMsgTyp                     10a   Const
015800050325     D  SpCalStkE                    10a   Const  Options( *VarSize )
015900050325     D  SpCalStkCtr                  10i 0 Const
016000050325     D  SpMsgKey                      4a
016100050325     D  SpError                    1024a          Options( *VarSize )
016200050325
016300050325     **-- Process command:
016400050325     D PrcCmd          Pr             7a
016500050325     D  CmdStr                     1024a   Const  Varying
016600050325     **-- Send completion message:
016700050325     D SndCmpMsg       Pr            10i 0
016800050325     D  PxMsgDta                    512a   Const  Varying
016900041212
017000050325     D CBX933          Pr
017100050325     D  PxLibNam                     10a
017200050325     D  PxJrnNam                           LikeDs( ObjNam_q )
017300050325     D  PxObjNam                     10a
017400050325     D  PxObjTyp                     10a
017500050325     D  PxImages                      6a
017600050325     D  PxOmtJrnE                    10a
017700041212     **
017800050325     D CBX933          Pi
017900050325     D  PxLibNam                     10a
018000050325     D  PxJrnNam                           LikeDs( ObjNam_q )
018100050325     D  PxObjNam                     10a
018200050325     D  PxObjTyp                     10a
018300050325     D  PxImages                      6a
018400050325     D  PxOmtJrnE                    10a
018500041211
018600041211      /Free
018700041211
018800050325        LstApi.KeyFld(1) = 202;
018900050325        LstApi.KeyFld(2) = 513;
019000041211
019100041211        SrtInf.NbrKeys      = 0;
019200041211        SrtInf.KeyFldOfs(1) = 0;
019300041211        SrtInf.KeyFldLen(1) = 0;
019400041211        SrtInf.KeyFldTyp(1) = 0;
019500041211        SrtInf.SrtOrd(1)    = '1';
019600041211        SrtInf.Rsv(1)       = x'00';
019700041211
019800050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*FILE';
019900050326          LstApi.ObjTyp = '*FILE';
020000050326
020100050326          ExSr  PrcObjLst;
020200050326        EndIf;
020300050326
020400050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAQ';
020500050326          LstApi.ObjTyp = '*DTAQ';
020600050326
020700050326          ExSr  PrcObjLst;
020800050326        EndIf;
020900050326
021000050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAARA';
021100050326          LstApi.ObjTyp = '*DTAARA';
021200050326
021300050326          ExSr  PrcObjLst;
021400050326        EndIf;
021500050326
021600050326        SndCmpMsg( 'Command completed normally. ' + %Char( ObjCntSlt ) +
021700050326                   ' objects processed. '         + %Char( ObjCntIgn ) +
021800050326                   ' objects not processed.'
021900050326                 );
022000041216
022100041211        *InLr = *On;
022200041211        Return;
022300050326
022400050326
022500050326        BegSr  PrcObjLst;
022600050326
022700050326          LstApi.RtnRcdNbr = 1;
022800050326
022900050326          LstObjs( ObjInf
023000050326                 : %Size( ObjInf )
023100050326                 : LstInf
023200050326                 : 1
023300050326                 : SrtInf
023400050326                 : PxObjNam + PxLibNam
023500050326                 : LstApi.ObjTyp
023600050326                 : AutCtl
023700050326                 : SltCtl
023800050326                 : LstApi.NbrKeyRtn
023900050326                 : LstApi.KeyFld
024000050326                 : ERRC0100
024100050326                 );
024200050326
024300050326          If  ERRC0100.BytAvl = *Zero;
024400050326
024500050326            DoW  LstInf.LstSts <> '2'  Or
024600050326                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
024700050326
024800050326              ExSr  GetKeyDta;
024900050327              ExSr  StrJrnObj;
025000050326
025100050326              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
025200050326
025300050326              GetLstEnt( ObjInf
025400050326                       : %Size( ObjInf )
025500050326                       : LstInf.Handle
025600050326                       : LstInf
025700050326                       : 1
025800050326                       : LstApi.RtnRcdNbr
025900050326                       : ERRC0100
026000050326                       );
026100050326
026200050326              If  ERRC0100.BytAvl > *Zero;
026300050326                Leave;
026400050326              EndIf;
026500050326            EndDo;
026600050326
026700050326            CloseLst( LstInf.Handle: ERRC0100 );
026800050326          EndIf;
026900050326
027000050326        EndSr;
027100041211
027200041211        BegSr  GetKeyDta;
027300041211
027400041211          pKeyInf = %Addr( ObjInf.Data );
027500041211
027600041211          For  Idx = 1  To ObjInf.FldNbrRtn;
027700041211
027800041211            Select;
027900050325            When  KeyInf.KeyFld = 202;
028000050325              KeyFld.ExtObjAtr = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
028100041211
028200050325            When  KeyInf.KeyFld = 513;
028300050325              KeyFld.JrnSts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
028400041211            EndSl;
028500041211
028600041211            If  Idx < ObjInf.FldNbrRtn;
028700041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
028800041211            EndIf;
028900041211          EndFor;
029000041211
029100041211        EndSr;
029200041211
029300050327        BegSr  StrJrnObj;
029400050325
029500050325          Select;
029600050325          When  ObjInf.ObjTyp = '*FILE'  And  KeyFld.ExtObjAtr = 'PF';
029700050325
029800050325            If  KeyFld.JrnSts = '0';
029900050325
030000050325              PrcCmd( 'STRJRNPF FILE(' + %Trim( ObjInf.ObjLib )   + '/'  +
030100050325                                         %Trim( ObjInf.ObjNam )   + ') ' +
030200050325                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
030300050325                                         %Trim( PxJrnNam.ObjNam ) + ') ' +
030400050325                             'IMAGES(' + %Trim( PxImages  )     + ') ' +
030500050325                            'OMTJRNE(' + %Trim( PxOmtJrnE )     + ') '
030600050325                    );
030700050325
030800050325              ObjCntSlt += 1;
030900050325            Else;
031000050325              ObjCntIgn += 1;
031100050325            EndIf;
031200050325
031300050326          When  ObjInf.ObjTyp = '*DTAQ';
031400050325
031500050325            If  KeyFld.JrnSts = '0';
031600050325
031700050325              PrcCmd( 'STRJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
031800050325                                         %Trim( ObjInf.ObjNam )   + ') ' +
031900050325                            'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') ' +
032000050325                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
032100050327                                         %Trim( PxJrnNam.ObjNam ) + ') '
032200050325                    );
032300050325
032400050325              ObjCntSlt += 1;
032500050325            Else;
032600050325              ObjCntIgn += 1;
032700050325            EndIf;
032800050326
032900050326          When  ObjInf.ObjTyp = '*DTAARA';
033000050326
033100050326            If  KeyFld.JrnSts = '0';
033200050326
033300050326              PrcCmd( 'STRJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
033400050326                                         %Trim( ObjInf.ObjNam )   + ') ' +
033500050326                            'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') ' +
033600050326                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
033700050326                                         %Trim( PxJrnNam.ObjNam ) + ') ' +
033800050326                             'IMAGES(' + %Trim( PxImages  )     + ') '
033900050326                    );
034000050326
034100050326              ObjCntSlt += 1;
034200050326            Else;
034300050326              ObjCntIgn += 1;
034400050326            EndIf;
034500050325          EndSl;
034600050325
034700050325        EndSr;
034800041212
034900050122      /End-Free
035000050122
035100050325     **-- Process command:  --------------------------------------------------**
035200050325     P PrcCmd          B
035300050325     D                 Pi             7a
035400050325     D  PxCmdStr                   1024a   Const  Varying
035500050325     **-- Local variables:
035600050325     D CpOptCtlBlk     Ds
035700050325     D  CpTypPrc                     10i 0 Inz( 2 )
035800050325     D  CpDBCS                        1a   Inz( '0' )
035900050325     D  CpPmtAct                      1a   Inz( '2' )
036000050325     D  CpCmdStx                      1a   Inz( '0' )
036100050325     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
036200050325     D  CpRsv                         9a   Inz( *Allx'00' )
036300050325     **
036400050325     D CpChgCmd        s          32767a
036500050325     D CpChgCmdAvl     s             10i 0
036600050325
036700050325      /Free
036800050325
036900050325        PrcCmds( PxCmdStr
037000050325               : %Len( PxCmdStr )
037100050325               : CpOptCtlBlk
037200050325               : %Size( CpOptCtlBlk )
037300050325               : 'CPOP0100'
037400050325               : CpChgCmd
037500050325               : %Size( CpChgCmd )
037600050325               : CpChgCmdAvl
037700050325               : ERRC0100
037800050325               );
037900050325
038000050325        If  ERRC0100.BytAvl > *Zero;
038100050325          Return  ERRC0100.MsgId;
038200050325        Else;
038300050325          Return  *Blanks;
038400050325        EndIf;
038500050325
038600050325      /End-Free
038700050325
038800050325     P PrcCmd          E
038900050325     **-- Send completion message:  ------------------------------------------**
039000050325     P SndCmpMsg       B
039100050325     D                 Pi            10i 0
039200050325     D  PxMsgDta                    512a   Const  Varying
039300050325     **
039400050325     D MsgKey          s              4a
039500050325
039600050325      /Free
039700050325
039800050325        SndPgmMsg( 'CPF9897'
039900050325                 : 'QCPFMSG   *LIBL'
040000050325                 : PxMsgDta
040100050325                 : %Len( PxMsgDta )
040200050325                 : '*COMP'
040300050325                 : '*PGMBDY'
040400050325                 : 1
040500050325                 : MsgKey
040600050325                 : ERRC0100
040700050325                 );
040800050325
040900050325        If  ERRC0100.BytAvl > *Zero;
041000050325          Return  -1;
041100050325
041200050325        Else;
041300050325          Return  0;
041400050325
041500050325        EndIf;
041600050325
041700050325      /End-Free
041800050325
041900050325     **
042000050325     P SndCmpMsg       E
