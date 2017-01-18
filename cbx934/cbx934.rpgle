000100041212     **
000200050328     **  Program . . : CBX934
000300050328     **  Description : End journal for library - CPP
000400041212     **  Author  . . : Carsten Flensburg
000500041212     **
000600041212     **
000700041212     **  Program description:
000800050328     **    This program will, depending on object type, run the ENDJRNPF
000900050328     **    or ENDJRNOBJ command for the objects defined by the input
001000050327     **    parameters.
001100041212     **
001200050325     **
001300041212     **  Compile and setup instructions:
001400050328     **    CrtRpgMod   Module( CBX934 )
001500041212     **                DbgView( *NONE )
001600041212     **                Aut( *USE )
001700041212     **
001800050328     **    CrtPgm      Pgm( CBX934 )
001900050328     **                Module( CBX934 )
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
004400050328     D  KeyFld                       10i 0 Dim( 4 )
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
010800050328     D  JrnNam                             LikeDs( ObjNam_q )
010900041211     **-- Open list of objects:
011000040426     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
011100040426     D  LoRcvVar                  65535a          Options( *VarSize )
011200040426     D  LoRcvVarLen                  10i 0 Const
011300040426     D  LoLstInf                     80a
011400040426     D  LoNbrRcdRtn                  10i 0 Const
011500040426     D  LoSrtInf                   1024a   Const  Options( *VarSize )
011600040426     D  LoObjNam_q                   20a   Const
011700040426     D  LoObjTyp                     10a   Const
011800040426     D  LoAutCtl                   1024a   Const  Options( *VarSize )
011900040426     D  LoSltCtl                   1024a   Const  Options( *VarSize )
012000041211     D  LoNbrKeyRtn                  10i 0 Const
012100041211     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
012200040426     D  LoError                    1024a          Options( *VarSize )
012300020531     **
012400040426     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
012500040426     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
012600040426     **
012700040426     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
012800041212     **-- Get list entry:
012900020531     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
013000020531     D  GlRcvVar                  65535a          Options( *VarSize )
013100020531     D  GlRcvVarLen                  10i 0 Const
013200020531     D  GlHandle                      4a   Const
013300020531     D  GlLstInf                     80a
013400020531     D  GlNbrRcdRtn                  10i 0 Const
013500020531     D  GlRtnRcdNbr                  10i 0 Const
013600020531     D  GlError                    1024a          Options( *VarSize )
013700041212     **-- Close list:
013800020531     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
013900020531     D  ClHandle                      4a   Const
014000020531     D  ClError                    1024a          Options( *VarSize )
014100050328     **-- Retrieve object description:
014200050328     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
014300050328     D  RoRcvVar                  32767a          Options( *VarSize )
014400050328     D  RoRcvVarLen                  10i 0 Const
014500050328     D  RoFmtNam                      8a   Const
014600050328     D  RoObjNamQ                    20a   Const
014700050328     D  RoObjTyp                     10a   Const
014800050328     D  RoError                   32767a          Options( *VarSize )
014900050325     **-- Process commands:
015000050325     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
015100050325     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
015200050325     D  PcSrcCmdLen                  10i 0 Const
015300050325     D  PcOptCtlBlk                  20a   Const
015400050325     D  PcOptCtlBlkLn                10i 0 Const
015500050325     D  PcOptCtlBlkFm                 8a   Const
015600050325     D  PcChgCmd                  32767a          Options( *VarSize )
015700050325     D  PcChgCmdLen                  10i 0 Const
015800050325     D  PcChgCmdLenAv                10i 0
015900050325     D  PcError                   32767a          Options( *VarSize )
016000050325     **-- Send program message:
016100050325     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
016200050325     D  SpMsgId                       7a   Const
016300050325     D  SpMsgFq                      20a   Const
016400050325     D  SpMsgDta                    128a   Const
016500050325     D  SpMsgDtaLen                  10i 0 Const
016600050325     D  SpMsgTyp                     10a   Const
016700050325     D  SpCalStkE                    10a   Const  Options( *VarSize )
016800050325     D  SpCalStkCtr                  10i 0 Const
016900050325     D  SpMsgKey                      4a
017000050325     D  SpError                    1024a          Options( *VarSize )
017100050325
017200050325     **-- Process command:
017300050325     D PrcCmd          Pr             7a
017400050325     D  CmdStr                     1024a   Const  Varying
017500050325     **-- Send completion message:
017600050325     D SndCmpMsg       Pr            10i 0
017700050325     D  PxMsgDta                    512a   Const  Varying
017800050328     **-- Get object library:
017900050328     D GetObjLib       Pr            10a
018000050328     D  PxObjNam                     10a   Const
018100050328     D  RaObjLib                     10a   Const
018200050328     D  PxObjTyp                     10a   Const
018300041212
018400050328     D CBX934          Pr
018500050325     D  PxLibNam                     10a
018600050325     D  PxObjNam                     10a
018700050325     D  PxObjTyp                     10a
018800050328     D  PxJrnNam                           LikeDs( ObjNam_q )
018900041212     **
019000050328     D CBX934          Pi
019100050325     D  PxLibNam                     10a
019200050325     D  PxObjNam                     10a
019300050325     D  PxObjTyp                     10a
019400050328     D  PxJrnNam                           LikeDs( ObjNam_q )
019500041211
019600041211      /Free
019700050408        If  PxJrnNam.ObjLib = '*LIBL';
019800050408
019900050408          PxJrnNam.ObjLib = GetObjLib( PxJrnNam.ObjNam
020000050408                                     : PxJrnNam.ObjLib
020100050408                                     : '*JRN'
020200050408                                     );
020300050408        EndIf;
020400050328
020500050325        LstApi.KeyFld(1) = 202;
020600050325        LstApi.KeyFld(2) = 513;
020700050328        LstApi.KeyFld(3) = 514;
020800050328        LstApi.KeyFld(4) = 515;
020900041211
021000041211        SrtInf.NbrKeys      = 0;
021100041211        SrtInf.KeyFldOfs(1) = 0;
021200041211        SrtInf.KeyFldLen(1) = 0;
021300041211        SrtInf.KeyFldTyp(1) = 0;
021400041211        SrtInf.SrtOrd(1)    = '1';
021500041211        SrtInf.Rsv(1)       = x'00';
021600041211
021700050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*FILE';
021800050326          LstApi.ObjTyp = '*FILE';
021900050326
022000050326          ExSr  PrcObjLst;
022100050326        EndIf;
022200050326
022300050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAQ';
022400050326          LstApi.ObjTyp = '*DTAQ';
022500050326
022600050326          ExSr  PrcObjLst;
022700050326        EndIf;
022800050326
022900050326        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAARA';
023000050326          LstApi.ObjTyp = '*DTAARA';
023100050326
023200050326          ExSr  PrcObjLst;
023300050326        EndIf;
023400050326
023500050326        SndCmpMsg( 'Command completed normally. ' + %Char( ObjCntSlt ) +
023600050326                   ' objects processed. '         + %Char( ObjCntIgn ) +
023700050326                   ' objects not processed.'
023800050326                 );
023900041216
024000041211        *InLr = *On;
024100041211        Return;
024200050326
024300050326
024400050326        BegSr  PrcObjLst;
024500050326
024600050326          LstApi.RtnRcdNbr = 1;
024700050326
024800050326          LstObjs( ObjInf
024900050326                 : %Size( ObjInf )
025000050326                 : LstInf
025100050326                 : 1
025200050326                 : SrtInf
025300050326                 : PxObjNam + PxLibNam
025400050326                 : LstApi.ObjTyp
025500050326                 : AutCtl
025600050326                 : SltCtl
025700050326                 : LstApi.NbrKeyRtn
025800050326                 : LstApi.KeyFld
025900050326                 : ERRC0100
026000050326                 );
026100050326
026200050326          If  ERRC0100.BytAvl = *Zero;
026300050326
026400050326            DoW  LstInf.LstSts <> '2'  Or
026500050326                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;
026600050326
026700050326              ExSr  GetKeyDta;
026800050328              ExSr  EndJrnObj;
026900050326
027000050326              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;
027100050326
027200050326              GetLstEnt( ObjInf
027300050326                       : %Size( ObjInf )
027400050326                       : LstInf.Handle
027500050326                       : LstInf
027600050326                       : 1
027700050326                       : LstApi.RtnRcdNbr
027800050326                       : ERRC0100
027900050326                       );
028000050326
028100050326              If  ERRC0100.BytAvl > *Zero;
028200050326                Leave;
028300050326              EndIf;
028400050326            EndDo;
028500050326
028600050326            CloseLst( LstInf.Handle: ERRC0100 );
028700050326          EndIf;
028800050326
028900050326        EndSr;
029000041211
029100041211        BegSr  GetKeyDta;
029200041211
029300041211          pKeyInf = %Addr( ObjInf.Data );
029400041211
029500041211          For  Idx = 1  To ObjInf.FldNbrRtn;
029600041211
029700041211            Select;
029800050325            When  KeyInf.KeyFld = 202;
029900050325              KeyFld.ExtObjAtr = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
030000041211
030100050325            When  KeyInf.KeyFld = 513;
030200050325              KeyFld.JrnSts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
030300050328
030400050328            When  KeyInf.KeyFld = 514;
030500050328              KeyFld.JrnNam.ObjNam = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
030600050328
030700050328            When  KeyInf.KeyFld = 515;
030800050328              KeyFld.JrnNam.ObjLib = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
030900041211            EndSl;
031000041211
031100041211            If  Idx < ObjInf.FldNbrRtn;
031200041211              pKeyInf = pKeyInf + KeyInf.FldInfLen;
031300041211            EndIf;
031400041211          EndFor;
031500041211
031600041211        EndSr;
031700041211
031800050328        BegSr  EndJrnObj;
031900050325
032000050408          If  PxJrnNam = '*OBJ'  Or  PxJrnNam = KeyFld.JrnNam;
032100050328
032200050328            Select;
032300050328            When  ObjInf.ObjTyp = '*FILE'  And  KeyFld.ExtObjAtr = 'PF';
032400050328
032500050328              If  KeyFld.JrnSts = '1';
032600050328
032700050328                PrcCmd( 'ENDJRNPF FILE(' + %Trim( ObjInf.ObjLib )   + '/'  +
032800050328                                           %Trim( ObjInf.ObjNam )   + ') '
032900050328                      );
033000050328
033100050328                ObjCntSlt += 1;
033200050328              Else;
033300050328                ObjCntIgn += 1;
033400050328              EndIf;
033500050328
033600050328            When  ObjInf.ObjTyp = '*DTAQ';
033700050328
033800050328              If  KeyFld.JrnSts = '1';
033900050328
034000050328                PrcCmd( 'ENDJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
034100050328                                           %Trim( ObjInf.ObjNam )   + ') ' +
034200050328                              'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') '
034300050328                      );
034400050328
034500050328                ObjCntSlt += 1;
034600050328              Else;
034700050328                ObjCntIgn += 1;
034800050328              EndIf;
034900050328
035000050328            When  ObjInf.ObjTyp = '*DTAARA';
035100050328
035200050328              If  KeyFld.JrnSts = '1';
035300050328
035400050328                PrcCmd( 'ENDJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
035500050328                                           %Trim( ObjInf.ObjNam )   + ') ' +
035600050328                              'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') '
035700050328                      );
035800050328
035900050328                ObjCntSlt += 1;
036000050328              Else;
036100050328                ObjCntIgn += 1;
036200050328              EndIf;
036300050328            EndSl;
036400050328
036500050328          Else;
036600050328            ObjCntIgn += 1;
036700050328          EndIf;
036800050325
036900050325        EndSr;
037000041212
037100050122      /End-Free
037200050122
037300050325     **-- Process command:  --------------------------------------------------**
037400050325     P PrcCmd          B
037500050325     D                 Pi             7a
037600050325     D  PxCmdStr                   1024a   Const  Varying
037700050325     **-- Local variables:
037800050325     D CpOptCtlBlk     Ds
037900050325     D  CpTypPrc                     10i 0 Inz( 2 )
038000050325     D  CpDBCS                        1a   Inz( '0' )
038100050325     D  CpPmtAct                      1a   Inz( '2' )
038200050325     D  CpCmdStx                      1a   Inz( '0' )
038300050325     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
038400050325     D  CpRsv                         9a   Inz( *Allx'00' )
038500050325     **
038600050325     D CpChgCmd        s          32767a
038700050325     D CpChgCmdAvl     s             10i 0
038800050325
038900050325      /Free
039000050325
039100050325        PrcCmds( PxCmdStr
039200050325               : %Len( PxCmdStr )
039300050325               : CpOptCtlBlk
039400050325               : %Size( CpOptCtlBlk )
039500050325               : 'CPOP0100'
039600050325               : CpChgCmd
039700050325               : %Size( CpChgCmd )
039800050325               : CpChgCmdAvl
039900050325               : ERRC0100
040000050325               );
040100050325
040200050325        If  ERRC0100.BytAvl > *Zero;
040300050325          Return  ERRC0100.MsgId;
040400050325        Else;
040500050325          Return  *Blanks;
040600050325        EndIf;
040700050325
040800050325      /End-Free
040900050325
041000050325     P PrcCmd          E
041100050325     **-- Send completion message:  ------------------------------------------**
041200050325     P SndCmpMsg       B
041300050325     D                 Pi            10i 0
041400050325     D  PxMsgDta                    512a   Const  Varying
041500050325     **
041600050325     D MsgKey          s              4a
041700050325
041800050325      /Free
041900050325
042000050325        SndPgmMsg( 'CPF9897'
042100050325                 : 'QCPFMSG   *LIBL'
042200050325                 : PxMsgDta
042300050325                 : %Len( PxMsgDta )
042400050325                 : '*COMP'
042500050325                 : '*PGMBDY'
042600050325                 : 1
042700050325                 : MsgKey
042800050325                 : ERRC0100
042900050325                 );
043000050325
043100050325        If  ERRC0100.BytAvl > *Zero;
043200050325          Return  -1;
043300050325
043400050325        Else;
043500050325          Return  0;
043600050325
043700050325        EndIf;
043800050325
043900050325      /End-Free
044000050325
044100050325     **
044200050325     P SndCmpMsg       E
044300050328     **-- Get object library:  -----------------------------------------------**
044400050328     P GetObjLib       B                   Export
044500050328     D                 Pi            10a
044600050328     D  RaObjNam                     10a   Const
044700050328     D  RaObjLib                     10a   Const
044800050328     D  PxObjTyp                     10a   Const
044900050328     **
045000050328     D OBJD0100        Ds                  Qualified
045100050328     D  BytRtn                       10i 0
045200050328     D  BytAvl                       10i 0
045300050328     D  ObjNam                       10a
045400050328     D  ObjLib                       10a
045500050328     D  ObjTyp                       10a
045600050328     D  ObjLibRtn                    10a
045700050328     D  ObjASP                       10i 0
045800050328     D  ObjOwn                       10a
045900050328     D  ObjDmn                        2a
046000050328
046100050328      /Free
046200050328
046300050328         RtvObjD( OBJD0100
046400050328                : %Size( OBJD0100 )
046500050328                : 'OBJD0100'
046600050328                : RaObjNam + RaObjLib
046700050328                : PxObjTyp
046800050328                : ERRC0100
046900050328                );
047000050328
047100050328         If  ERRC0100.BytAvl > *Zero;
047200050328           Return  *Blanks;
047300050328
047400050328         Else;
047500050328           Return  OBJD0100.ObjLibRtn;
047600050328         EndIf;
047700050328
047800050328      /End-Free
047900050328
048000050328     P GetObjLib       E
