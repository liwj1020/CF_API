000100041110     **
000200061105     **  Program . . : CBX963E
000300061105     **  Description : Display Server Share - UIM Exit Program
000400061105     **  Author  . . : Carsten Flensburg
000500061105     **  Published . : System iNetwork Systems Management Tips Newsletter
000600051202     **
000700060514     **
000800060514     **  Programmer's notes:
000900061107     **    Activation group *CALLER ensures that this program is run in the
001000060514     **    same activation group as the CPP, thereby limiting all data and
001100060514     **    resources to a common scope.
001200051202     **
001300060514     **
001400060328     **  Compile options:
001500061105     **    CrtRpgMod  Module( CBX963E )
001600060328     **               DbgView( *LIST )
001700060328     **
001800061105     **    CrtPgm     Pgm( CBX963E )
001900061105     **               Module( CBX963E )
002000060512     **               ActGrp( *CALLER )
002100031115     **
002200031115     **
002300040605     **-- Control specification:  --------------------------------------------**
002400060311     H Option( *SrcStmt )
002500040722
002600041120     **-- System information:
002700041120     D PgmSts         SDs                  Qualified
002800041120     D  PgmNam           *Proc
002900041120     D  CurJob                       10a   Overlay( PgmSts: 244 )
003000041120     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
003100041120     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003200041120     D  CurUsr                       10a   Overlay( PgmSts: 358 )
003300060311
003400040728     **-- API error data structure:
003500040728     D ERRC0100        Ds                  Qualified
003600040728     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
003700040728     D  BytAvl                       10i 0
003800041119     D  MsgId                         7a
003900040728     D                                1a
004000041119     D  MsgDta                      512a
004100060311
004200041120     **-- Global constants:
004300060327     D NULL            c                   ''
004400060327     D NO_ENT          c                   x'00000000'
004500060703     D RES_OK          c                   0
004600060703     **-- Global variables:
004700060703     D MsgKey          s              4a
004800060423     **-- UIM variables:
004900060423     D UIM             Ds                  Qualified
005000060423     D  EntHdl                        4a
005100051129
005200060311     **-- UIM API return structures:
005300061105     **-- Cursor record:
005400061105     D CsrRcd          Ds                  Qualified
005500061105     D  CsrVar                       10a
005600061105     D  CsrNam                       10a
005700061105     D  CsrPos                        5i 0
005800061105     **-- UIM Detail record:
005900061105     D DtlRcd          Ds                  Qualified
006000061105     D  Permis                        1s 0
006100061105     D  MaxUsr                       10i 0
006200061105     D  CurUsr                       10i 0
006300061105     D  SpfTyp                        1s 0
006400061105     D  Path                       1000a
006500061105     D  Path_s                      256a
006600061105     D  OutQue_q                     20a
006700061105     D  PrtDrv                       50a
006800061105     D  PrtFil_q                     20a
006900061105     D  EnbTxtCnv                     1a
007000061105     D  PubPrtShr                     1a
007100061105     D  NbrFilExt                     3s 0
007200061105     D  FilExt                     1000a
007300060311
007400060311     **-- UIM exit program interfaces:
007500060327     **-- Parm interface:
007600060327     D UimExit         Ds            70    Qualified
007700060327     D  StcLvl                       10i 0
007800060327     D                                8a
007900060327     D  TypCall                      10i 0
008000060327     D  AppHdl                        8a
008100060311     **-- Function key - call:
008200060311     D Type1           Ds                  Qualified
008300060311     D  StcLvl                       10i 0
008400060311     D                                8a
008500060311     D  TypCall                      10i 0
008600060311     D  AppHdl                        8a
008700060311     D  PnlNam                       10a
008800060311     D  FncKey                       10i 0
008900060311
009000060311     **-- Get dialog variable:
009100060311     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
009200060311     D  AppHdl                        8a   Const
009300060311     D  VarBuf                    32767a          Options( *VarSize )
009400060311     D  VarBufLen                    10i 0 Const
009500060311     D  VarRcdNam                    10a   Const
009600060311     D  Error                     32767a          Options( *VarSize )
009700060327     **-- Display long text:
009800060327     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
009900060327     D  LngTxt                    32767a   Const  Options( *VarSize )
010000060327     D  LngTxtLen                    10i 0 Const
010100060327     D  MsgId                         7a   Const
010200060327     D  MsgF                         20a   Const
010300060327     D  Error                     32767a   Const  Options( *VarSize )
010400060327     **-- Send program message:
010500060327     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
010600060327     D  MsgId                         7a   Const
010700060327     D  MsgFq                        20a   Const
010800060327     D  MsgDta                      128a   Const
010900060327     D  MsgDtaLen                    10i 0 Const
011000060327     D  MsgTyp                       10a   Const
011100060327     D  CalStkE                      10a   Const  Options( *VarSize )
011200060327     D  CalStkCtr                    10i 0 Const
011300060327     D  MsgKey                        4a
011400060327     D  Error                     32767a          Options( *VarSize )
011500060327
011600060327     **-- Send escape message:
011700060327     D SndEscMsg       Pr            10i 0
011800060327     D  PxMsgId                       7a   Const
011900060327     D  PxMsgF                       10a   Const
012000060327     D  PxMsgDta                    512a   Const  Varying
012100051129
012200040722     **-- Entry parameters:
012300061105     D CBX963E         Pr
012400060327     D  PxUimExit                          LikeDs( UimExit )
012500051129     **
012600061105     D CBX963E         Pi
012700060327     D  PxUimExit                          LikeDs( UimExit )
012800040721
012900040724      /Free
013000041224
013100060703        Select;
013200060703        When  PxUimExit.TypCall = 1;
013300060703          Type1 = PxUimExit;
013400060703
013500061105          Select;
013600061105          When  Type1.FncKey = 20;
013700061105
013800061105            GetDlgVar( Type1.AppHdl
013900061105                     : DtlRcd
014000061105                     : %Size( DtlRcd )
014100061105                     : 'DTLRCD'
014200061105                     : ERRC0100
014300061105                     );
014400061105
014500061105            DspLngTxt( DtlRcd.FilExt
014600061105                     : %Len( %TrimR( DtlRcd.FilExt ))
014700061106                     : 'CBX0002'
014800061106                     : 'CBX963M   *LIBL'
014900061105                     : ERRC0100
015000061105                     );
015100061105
015200061105          When  Type1.FncKey = 22;
015300060703
015400060703            GetDlgVar( Type1.AppHdl
015500060703                     : CsrRcd
015600060703                     : %Size( CsrRcd )
015700060703                     : 'CSRRCD'
015800060703                     : ERRC0100
015900060703                     );
016000060703
016100061105            If  CsrRcd.CsrVar <> 'PATHS';
016200060703              SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );
016300060703
016400060703            Else;
016500061105              GetDlgVar( Type1.AppHdl
016600061105                       : DtlRcd
016700061105                       : %Size( DtlRcd )
016800061105                       : 'DTLRCD'
016900061105                       : ERRC0100
017000061105                       );
017100061105
017200061105              DspLngTxt( DtlRcd.Path
017300061105                       : %Len( %TrimR( DtlRcd.Path ))
017400061106                       : 'CBX0001'
017500061106                       : 'CBX963M   *LIBL'
017600060703                       : ERRC0100
017700060703                       );
017800060703
017900060703            EndIf;
018000061105          EndSl;
018100060703        EndSl;
018200040728
018300040605        Return;
018400040721
018500051126      /End-Free
018600060327
018700060327     **-- Send escape message:
018800060327     P SndEscMsg       B
018900060327     D                 Pi            10i 0
019000060327     D  PxMsgId                       7a   Const
019100060327     D  PxMsgF                       10a   Const
019200060327     D  PxMsgDta                    512a   Const  Varying
019300060327     **
019400060327     D MsgKey          s              4a
019500060327
019600060327      /Free
019700060327
019800060327        SndPgmMsg( PxMsgId
019900060327                 : PxMsgF + '*LIBL'
020000060327                 : PxMsgDta
020100060327                 : %Len( PxMsgDta )
020200060327                 : '*ESCAPE'
020300060327                 : '*PGMBDY'
020400060327                 : 1
020500060327                 : MsgKey
020600060327                 : ERRC0100
020700060327                 );
020800060327
020900060327        If  ERRC0100.BytAvl > *Zero;
021000060327          Return  -1;
021100060327
021200060327        Else;
021300060327          Return   0;
021400060327        EndIf;
021500060327
021600060327      /End-Free
021700060327
021800060327     P SndEscMsg       E
