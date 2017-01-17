000100031030     **
000200060925     **  Program . . : CBX962
000300060925     **  Description : Change Server Share - POP
000400031030     **  Author  . . : Carsten Flensburg
000500031030     **
000600031030     **
000700061014     **  Parameters:
000800061014     **    PxCmdNam_q  INPUT      Qualified command name
000900061014     **
001000061014     **    PxKeyPrm1   INPUT      Key parameter identifying the
001100061014     **                           server share to retrieve attribute
001200061014     **                           information about.
001300061014     **
001400061014     **    PxKeyPrm2   INPUT      Key parameter specifying the
001500061014     **                           server share type.
001600061014     **
001700061014     **    PxCmdStr    OUTPUT     The formatted command prompt
001800061014     **                           string returning the current
001900061014     **                           attribute setting of the
002000061014     **                           specified server share.
002100061014     **
002200031101     **
002300031030     **  Compile options:
002400061023     **    CrtRpgMod Module( CBX962O )
002500060624     **              DbgView( *LIST )
002600060624     **
002700061023     **    CrtPgm    Pgm( CBX962O )
002800061023     **              Module( CBX962O )
002900061023     **              ActGrp( QILE )
003000031030     **
003100031030     **
003200030911     **-- Header specifications:  --------------------------------------------**
003300000926     H Option( *SrcStmt )
003400060624
003500050216     **-- API error data structure:
003600050216     D ERRC0100        Ds                  Qualified
003700050216     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003800050216     D  BytAvl                       10i 0
003900050216     D  MsgId                         7a
004000990921     D                                1a
004100050216     D  MsgDta                      256a
004200050216
004300050216     **-- Global constants:
004400050216     D OFS_MSGDTA      c                   16
004500060923     **-- Global variables:
004600060925     D Path            s           1024a   Varying
004700050216
004800060925     **-- File extension table:
004900061015     D FilExtTbl       Ds                  Qualified
005000061015     D  TblEnt                             Dim( 128 )
005100061015     D   ExtLen                      10i 0 Overlay( TblEnt: 1 )
005200061015     D   FilExt                      46a   Overlay( TblEnt: 5 )
005300060925     **-- List information:
005400060925     D ZLSL0101        Ds         32767    Qualified
005500060925     D  EntLen                       10i 0
005600060925     D  Share                        12a
005700060925     D  DevTyp                       10i 0
005800060925     D  Permis                       10i 0
005900060925     D  MaxUsr                       10i 0
006000060925     D  CurUsr                       10i 0
006100060925     D  SpfTyp                       10i 0
006200060925     D  OfsPthNam                    10i 0
006300060925     D  LenPthNam                    10i 0
006400060925     D  OutQue_q                     20a
006500061014     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
006600061014     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
006700060925     D  PrtDrv                       50a
006800060925     D  TxtDsc                       50a
006900061014     D  PrtFil_q                     20a
007000061014     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
007100061014     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
007200060925     D  TxtCcsId                     10i 0
007300060925     D  OfsExtTbl                    10i 0
007400060925     D  NbrTblEnt                    10i 0
007500060925     D  EnbTxtCnv                     1a
007600060925     D  Publish                       1a
007700060925     **-- List information:
007800060925     D LstInf          Ds                  Qualified
007900060925     D  RcdNbrTot                    10i 0
008000060925     D  RcdNbrRtn                    10i 0
008100060925     D  RcdLen                       10i 0
008200060925     D  InfLen                       10i 0
008300060925     D  InfSts                        1a
008400060925     D  Dts                          13a
008500060925     D                               34a
008600050216
008700060925     **-- Open list of server information:
008800060925     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
008900060925     D  RcvVar                    32767a          Options( *VarSize )
009000060925     D  RcvVarLen                    10i 0 Const
009100060925     D  LstInf                       64a
009200060925     D  Format                        8a   Const
009300060925     D  InfQual                      15a   Const
009400060624     D  Error                     32767a          Options( *VarSize )
009500060925     D  SsnUsr                       10a   Const  Options( *NoPass )
009600060925     D  SsnId                        20u 0 Const  Options( *NoPass )
009700050216     **-- Send program message:
009800050216     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
009900060624     D  MsgId                         7a   Const
010000061023     D  MsgFil_q                     20a   Const
010100060624     D  MsgDta                      512a   Const  Options( *VarSize )
010200060624     D  MsgDtaLen                    10i 0 Const
010300060624     D  MsgTyp                       10a   Const
010400060624     D  CalStkEnt                    10a   Const  Options( *VarSize )
010500060624     D  CalStkCtr                    10i 0 Const
010600060624     D  MsgKey                        4a
010700060624     D  Error                       512a          Options( *VarSize )
010800050216     **
010900060624     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
011000060624     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
011100060624     D  DspWait                      10i 0 Const  Options( *NoPass )
011200050216     **
011300060624     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
011400060624     D  CcsId                        10i 0 Const  Options( *NoPass )
011500050216
011600061015     **-- Double quotes:
011700061015     D DblQuotes       Pr           256a   Varying
011800061015     D  PxTxtDsc                    256a   Value  Varying
011900061015     **-- Format file extension:
012000061015     D FmtFilExt       Pr          6000a   Varying
012100061015     D  PxFilExtTbl                        LikeDs( FilExtTbl )
012200061015     D                                     Const
012300061015     D  PxNbrFilEnt                  10i 0 Const
012400061014     **-- Send diagnostic message:
012500061014     D SndDiagMsg      Pr            10i 0
012600061014     D  PxMsgId                       7a   Const
012700061014     D  PxMsgDta                    512a   Const  Varying
012800061014     **-- Send escape message:
012900061014     D SndEscMsg       Pr            10i 0
013000061014     D  PxMsgId                       7a   Const
013100061014     D  PxMsgDta                    512a   Const  Varying
013200050216
013300060624     **-- Entry parameters:
013400061014     D CBX962O         Pr
013500061014     D  PxCmdNam_q                   20a
013600061014     D  PxKeyPrm1                    12a
013700061014     D  PxKeyPrm2                    10a
013800061014     D  PxCmdStr                  32674a   Varying
013900060624     **
014000061014     D CBX962O         Pi
014100061014     D  PxCmdNam_q                   20a
014200061014     D  PxKeyPrm1                    12a
014300061014     D  PxKeyPrm2                    10a
014400061014     D  PxCmdStr                  32674a   Varying
014500060624
014600050216      /Free
014700050216
014800060925        LstSvrInf( ZLSL0101
014900060925                 : %Len( ZLSL0101 )
015000060925                 : LstInf
015100060925                 : 'ZLSL0101'
015200061014                 : PxKeyPrm1
015300060925                 : ERRC0100
015400060925                 );
015500060923
015600060923        If  ERRC0100.BytAvl > *Zero;
015700060923
015800060923          If  ERRC0100.BytAvl < OFS_MSGDTA;
015900060923            ERRC0100.BytAvl = OFS_MSGDTA;
016000060923          EndIf;
016100060923
016200061014          SndDiagMsg( ERRC0100.MsgId
016300061014                    : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
016400061014                    );
016500061014
016600061014          SndEscMsg( 'CPF0011': '' );
016700061014
016800060923        Else;
016900061023          If  PxKeyPrm2 = '*FILE'   And  ZLSL0101.DevTyp = 0  Or
017000061023              PxKeyPrm2 = '*PRINT'  And  ZLSL0101.DevTyp = 1;
017100061023
017200061014          ExSr  RtvShrInf;
017300061023          EndIf;
017400060923        EndIf;
017500060923
017600050216
017700060624        *InLr = *On;
017800060624        Return;
017900050216
018000061014        BegSr  RtvShrInf;
018100061014
018200061015          ZLSL0101.TxtDsc = DblQuotes( ZLSL0101.TxtDsc );
018300061015
018400061015          If  ZLSL0101.TxtDsc = *Blanks;
018500061015            PxCmdStr += '?<TEXT(*BLANK) ';
018600061015          Else;
018700061015            PxCmdStr += '?<TEXT(''' + ZLSL0101.TxtDsc + ''') ';
018800061015          EndIf;
018900061015
019000061014          If  PxKeyPrm2 = '*FILE';
019100061014            Path = %Subst( ZLSL0101
019200061014                         : ZLSL0101.OfsPthNam + 1
019300061014                         : ZLSL0101.LenPthNam
019400061014                         );
019500061015
019600061014            PxCmdStr += '?<PATH(''' + Path + ''') ';
019700061014
019800061014            If  ZLSL0101.Permis = 1;
019900061014              PxCmdStr += '?<PERMISSION(*READONLY) ';
020000061014            Else;
020100061014              PxCmdStr += '?<PERMISSION(*READWRITE) ';
020200061014            EndIf;
020300061014
020400061014            If  ZLSL0101.MaxUsr = -1;
020500061014              PxCmdStr += '?<MAXUSERS(*NOMAX) ';
020600061014            Else;
020700061014              PxCmdStr += '?<MAXUSERS(' + %Char( ZLSL0101.MaxUsr ) + ') ';
020800061014            EndIf;
020900061014
021000061014            If  ZLSL0101.TxtCcsId = 0;
021100061014              PxCmdStr += '?<CCSID(*SVRCCSID) ';
021200061014            Else;
021300061014              PxCmdStr += '?<CCSID(' + %Char( ZLSL0101.TxtCcsId ) + ') ';
021400061014            EndIf;
021500061014
021600061014            Select;
021700061014            When  ZLSL0101.EnbTxtCnv = '0';
021800061014              PxCmdStr += '?<CVTTXT(*NO) ';
021900061015
022000061014            When  ZLSL0101.EnbTxtCnv = '1';
022100061014              PxCmdStr += '?<CVTTXT(*YES) ';
022200061015
022300061014            Other;
022400061014              PxCmdStr += '?<CVTTXT(*MIXED) ';
022500061014            EndSl;
022600061014
022700061014            If  ZLSL0101.NbrTblEnt = 0;
022800061014              PxCmdStr += '?<FILEXT(*NONE) ';
022900061014            Else;
023000061015              FilExtTbl = %Subst( ZLSL0101
023100061015                                : ZLSL0101.OfsExtTbl + 1
023200061015                                : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
023300061015                                );
023400061015
023500061015              PxCmdStr += FmtFilExt( FilExtTbl: ZLSL0101.NbrTblEnt );
023600061014            EndIf;
023700061014
023800061014          Else;
023900061014            PxCmdStr += '?<OUTQ(' + %Trim( ZLSL0101.OutQueLib ) +
024000061014                              '/' + %Trim( ZLSL0101.OutQueNam ) + ') ';
024100061014
024200061014            Select;
024300061014            When  ZLSL0101.SpfTyp = 1;
024400061014              PxCmdStr += '?<SPLFTYPE(*USERASCII) ';
024500061015
024600061014            When  ZLSL0101.SpfTyp = 2;
024700061014              PxCmdStr += '?<SPLFTYPE(*AFPDS) ';
024800061015
024900061014            When  ZLSL0101.SpfTyp = 3;
025000061014              PxCmdStr += '?<SPLFTYPE(*SCS) ';
025100061015
025200061014            Other;
025300061014              PxCmdStr += '?<SPLFTYPE(*AUTO) ';
025400061014            EndSl;
025500061014
025600061014            If  ZLSL0101.PrtDrv = *Blanks;
025700061014              PxCmdStr += '?<PRTDRV(*BLANK) ';
025800061014            Else;
025900061014              PxCmdStr += '?<PRTDRV(''' + %Trim( ZLSL0101.PrtDrv ) + ''') ';
026000061014            EndIf;
026100061014
026200061014            If  ZLSL0101.PrtFil_q = *Blanks;
026300061014              PxCmdStr += '?<PRTF(*NONE) ';
026400061014            Else;
026500061014              PxCmdStr += '?<PRTF(' + %Trim( ZLSL0101.PrtFilLib ) +
026600061014                                '/' + %Trim( ZLSL0101.PrtFilNam ) + ') ';
026700061014            EndIf;
026800061014
026900061014            If  ZLSL0101.Publish = '0';
027000061014              PxCmdStr += '?<PUBLISH(*NO) ';
027100061014            Else;
027200061014              PxCmdStr += '?<PUBLISH(*YES) ';
027300061014            EndIf;
027400061014          EndIf;
027500061014
027600061014        EndSr;
027700061014
027800050216      /End-Free
027900050216
028000061015     **-- Double quotes:  ----------------------------------------------------**
028100061015     P DblQuotes       B
028200061015     D                 Pi           256a   Varying
028300061015     D  PxTxtDsc                    256a   Value  Varying
028400061015
028500061015     D Pos             s             10i 0
028600061015
028700061015      /Free
028800061015
028900061015          Pos = %Scan( '''': PxTxtDsc );
029000061015
029100061015          DoW  Pos > *Zero;
029200061015            PxTxtDsc = %Replace( '''': PxTxtDsc: Pos: 0 );
029300061015
029400061015            If  Pos + 2 <= %Len( PxTxtDsc );
029500061015              Pos = %Scan( '''': PxTxtDsc: Pos + 2 );
029600061015            Else;
029700061015              Pos = *Zero;
029800061015            EndIf;
029900061015          EndDo;
030000061015
030100061015          Return  %TrimR( PxTxtDsc );
030200061015
030300061015      /End-Free
030400061015
030500061015     P DblQuotes       E
030600061015     **-- Format file extension:  --------------------------------------------**
030700061015     P FmtFilExt       B
030800061015     D                 Pi          6000a   Varying
030900061015     D  PxFilExtTbl                        LikeDs( FilExtTbl )
031000061015     D                                     Const
031100061015     D  PxNbrFilEnt                  10i 0 Const
031200061015
031300061015     D Idx             s             10i 0
031400061015     D FilExt          s             46a   Varying
031500061015     D CmdStr          s           6000a   Varying
031600061015
031700061015      /Free
031800061015
031900061015          CmdStr = ' ?<FILEXT(';
032000061015
032100061015          For  Idx = 1  to  PxNbrFilEnt;
032200061015            FilExt = %Subst( PxFilExtTbl.FilExt(Idx)
032300061015                           : 1
032400061015                           : PxFilExtTbl.ExtLen(Idx)
032500061015                           );
032600061015
032700061015            Select;
032800061015            When  FilExt = '*';
032900061015              CmdStr += '*ALL';
033000061015
033100061015            When  FilExt = '.';
033200061015              CmdStr += '*NOEXT';
033300061015
033400061015            Other;
033500061023              CmdStr += '''' + FilExt + ''' ';
033600061015            EndSl;
033700061015          EndFor;
033800061015
033900061015          Return  %TrimR( CmdStr ) + ')';
034000061015
034100061015      /End-Free
034200061015
034300061015     P FmtFilExt       E
034400061014     **-- Send diagnostic message:  ------------------------------------------**
034500061014     P SndDiagMsg      B
034600061014     D                 Pi            10i 0
034700061014     D  PxMsgId                       7a   Const
034800061014     D  PxMsgDta                    512a   Const  Varying
034900061014     **
035000061014     D MsgKey          s              4a
035100061014
035200061014      /Free
035300061014
035400061014        SndPgmMsg( PxMsgId
035500061014                 : 'QCPFMSG   *LIBL'
035600061014                 : PxMsgDta
035700061014                 : %Len( PxMsgDta )
035800061014                 : '*DIAG'
035900061014                 : '*PGMBDY'
036000061014                 : 1
036100061014                 : MsgKey
036200061014                 : ERRC0100
036300061014                 );
036400061014
036500061014        If  ERRC0100.BytAvl > *Zero;
036600061014          Return  -1;
036700061014
036800061014        Else;
036900061014          Return   0;
037000061014        EndIf;
037100061014
037200061014      /End-Free
037300061014
037400061014     P SndDiagMsg      E
037500061014     **-- Send escape message:  ----------------------------------------------**
037600061014     P SndEscMsg       B
037700061014     D                 Pi            10i 0
037800061014     D  PxMsgId                       7a   Const
037900061014     D  PxMsgDta                    512a   Const  Varying
038000061014     **
038100061014     D MsgKey          s              4a
038200061014
038300061014      /Free
038400061014
038500061014        SndPgmMsg( PxMsgId
038600061014                 : 'QCPFMSG   *LIBL'
038700061014                 : PxMsgDta
038800061014                 : %Len( PxMsgDta )
038900061014                 : '*ESCAPE'
039000061014                 : '*PGMBDY'
039100061014                 : 1
039200061014                 : MsgKey
039300061014                 : ERRC0100
039400061014                 );
039500061014
039600061014        If  ERRC0100.BytAvl > *Zero;
039700061014          Return  -1;
039800061014
039900061014        Else;
040000061014          Return   0;
040100061014        EndIf;
040200061014
040300061014      /End-Free
040400061014
040500061014     P SndEscMsg       E
