000100000810     **-- Header specifications:  --------------------------------------------**
000200040215     H BndDir( 'QC2LE' )  Option( *SrcStmt )
000300040724     **-- Api error data structure:
000400040815     D ERRC0100        Ds                  Qualified
000500040815     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
000600040815     D  BytAvl                       10i 0 Inz
000700040815     D  MsgId                         7a
000800010329     D                                1a
000900040815     D  MsgDta                      128a
001000040814     **-- Api parameters:
001100040814     D FilNamRtnQ      s             20a
001200040828     D ApiRcvSiz       s             10u 0
001300040724     **-- Global variables:
001400040901     D Idx             s             10i 0
001500040815     **-- FILD0100 formats:
001600040814     D Qdb_Qdbfh       Ds                  Based( pQdb_Qdbfh )  Qualified
001700040814     D  Qdbfyret                     10i 0
001800040814     D  Qdbfyavl                     10i 0
001900040814     D  Qdbfhflg                      2a
002000040814     D*  Reserved_1    :2
002100040814     D*  Qdbfhfpl      :1
002200040814     D*  Reserved_2    :1
002300040814     D*  Qdbfhfsu      :1
002400040814     D*  Reserved_3    :1
002500040814     D*  Qdbfhfky      :1
002600040814     D*  Reserved_4    :1
002700040814     D*  Qdbfhflc      :1
002800040814     D*  Qdbfkfso      :1
002900040814     D*  Reserved_5    :4
003000040814     D*  Qdbfigcd      :1
003100040814     D*  Qdbfigcl      :1
003200040814     D  Reserved_7                    4a
003300040814     D  Qdbflbnum                     5i 0
003400040814     D  Qdbfkdat                     14a
003500040814     D  Qdbfknum                      5i 0 Overlay( Qdbfkdat: 1 )
003600040814     D  Qdbfkmxl                      5i 0 Overlay( Qdbfkdat: *Next )
003700040814     D  Qdbfkflg                      1a   Overlay( Qdbfkdat: *Next )
003800040814     D*  Reserved_8    :1
003900040814     D*  Qdbfkfcs      :1
004000040814     D*  Reserved_9    :4
004100040814     D*  Qdbfkfrc      :1
004200040814     D*  Qdbfkflt      :1
004300040814     D  Qdbfkfdm                      1a   Overlay( Qdbfkdat: *Next )
004400040814     D  Reserved_10                   8a   Overlay( Qdbfkdat: *Next )
004500040814     D  Qdbfhaut                     10a
004600040814     D  Qdbfhupl                      1a
004700040814     D  Qdbfhmxm                      5i 0
004800040814     D  Qdbfwtfi                      5i 0
004900040814     D  Qdbfhfrt                      5i 0
005000040814     D  Qdbfhmnum                     5i 0
005100040814     D  Reserved_11                   9a
005200040814     D  Qdbfbrwt                      5i 0
005300040814     D  Qaaf                          1a
005400040814     D*  Reserved_12   :7
005500040814     D*  Qdbfpgmd      :1
005600040814     D  Qdbffmtnum                    5i 0
005700040814     D  Qdbfhfl2                      2a
005800040814     D*  Qdbfjnap      :1
005900040814     D*  Reserved_13   :1
006000040814     D*  Qdbfrdcp      :1
006100040814     D*  Qdbfwtcp      :1
006200040814     D*  Qdbfupcp      :1
006300040814     D*  Qdbfdlcp      :1
006400040814     D*  Reserved_14   :9
006500040814     D*  Qdbfkfnd      :1
006600040814     D  Qdbfvrm                       5i 0
006700040814     D  Qaaf2                         2a
006800040814     D*  Qdbfhmcs      :1
006900040814     D*  Reserved_15   :1
007000040814     D*  Qdbfknll      :1
007100040814     D*  Qdbf_nfld     :1
007200040814     D*  Qdbfvfld      :1
007300040814     D*  Qdbftfld      :1
007400040814     D*  Qdbfgrph      :1
007500040814     D*  Qdbfpkey      :1
007600040814     D*  Qdbfunqc      :1
007700040814     D*  Reserved_118  :2
007800040814     D*  Qdbfapsz      :1
007900040814     D*  Qdbfdisf      :1
008000040814     D*  Reserved_68   :1
008100040814     D*  Reserved_69   :1
008200040814     D*  Reserved_70   :1
008300040814     D  Qdbfhcrt                     13a
008400040814     D  Qdbfhtx                      52a
008500040814     D   Reserved_18                  2a   Overlay( Qdbfhtx: 1 )
008600040814     D   Qdbfhtxt                    50a   Overlay( Qdbfhtx: *Next )
008700040814     D  Reserved_19                  13a
008800040814     D  Qdbfsrc                      30a
008900040814     D   Qdbfsrcf                    10a   Overlay( Qdbfsrc: 1 )
009000040814     D   Qdbfsrcm                    10a   Overlay( Qdbfsrc: *Next )
009100040814     D   Qdbfsrcl                    10a   Overlay( Qdbfsrc: *Next )
009200040814     D  Qdbfkrcv                      1a
009300040814     D  Reserved_20                  23a
009400040814     D  Qdbftcid                      5i 0
009500040814     D  Qdbfasp                       2a
009600040814     D  Qdbfnbit                      1a
009700040814     D*  Qdbfhudt      :1
009800040814     D*  Qdbfhlob      :1
009900040814     D*  Qdbfhdtl      :1
010000040814     D*  Qdbfhudf      :1
010100040814     D*  Qdbfhlon      :1
010200040814     D*  Qdbfhlop      :1
010300040814     D*  Qdbfhdll      :1
010400040814     D*  Reserved_21   :1
010500040814     D  Qdbfmxfnum                    5i 0
010600040814     D  Reserved_22                  76a
010700040814     D  Qdbfodic                     10i 0
010800040814     D  Reserved_23                  14a
010900040814     D  Qdbffigl                      5i 0
011000040814     D  Qdbfmxrl                      5i 0
011100040814     D  Reserved_24                   8a
011200040814     D  Qdbfgkct                      5i 0
011300040814     D  Qdbfos                       10i 0
011400040814     D  Reserved_25                   8a
011500040814     D  Qdbfocs                      10i 0
011600040814     D  Reserved_26                   4a
011700040814     D  Qdbfpact                      2a
011800040814     D  Qdbfhrls                      6a
011900040814     D  Reserved_27                  20a
012000040814     D  Qdbpfof                      10i 0
012100040814     D  Qdblfof                      10i 0
012200040814     D  Qdbfssfp                      6a
012300040814     D   Qdbfnlsb                     1a   Overlay( Qdbfssfp: 1 )
012400040814     D*   Qdbfsscs     :3
012500040814     D*   Reserved_103 :5
012600040814     D   Qdbflang                     3a   Overlay( Qdbfssfp: *Next )
012700040814     D   Qdbfcnty                     2a   Overlay( Qdbfssfp: *Next )
012800040814     D  Qdbfjorn                     10i 0
012900040814     D  Qdbfevid                     10i 0
013000040814     D  Reserved_28                  14a
013100040215     **
013200040814     D Qdb_Qdbfb       Ds                  Qualified  Based( pQdb_Qdbfb )
013300040814     D  Reserved_48                  48a
013400040814     D  Qdbfbf                       10a
013500040814     D  Qdbfbfl                      10a
013600040814     D  Qdbft                        10a
013700040814     D  Reserved_49                  37a
013800040814     D  Qdbfbgky                      5i 0
013900040814     D  Reserved_50                   2a
014000040814     D  Qdbfblky                      5i 0
014100040814     D  Reserved_51                   2a
014200040814     D  Qdbffogl                      5i 0
014300040814     D  Reserved_52                   3a
014400040814     D  Qdbfsoon                      5i 0
014500040814     D  Qdbfsoof                     10i 0
014600040814     D  Qdbfksof                     10i 0
014700040814     D  Qdbfkyct                      5i 0
014800040814     D  Qdbfgenf                      5i 0
014900040814     D  Qdbfodis                     10i 0
015000040814     D  Reserved_53                  14a
015100040724     **-- Retrieve database file description:
015200030627     D RtvDbfDsc       Pr                  ExtPgm( 'QDBRTVFD' )
015300030627     D  RdRcvVar                  32767a          Options( *VarSize )
015400030627     D  RdRcvVarLen                  10i 0 Const
015500030627     D  RdFilNamRtnQ                 20a
015600030627     D  RdFmtNam                      8a   Const
015700030627     D  RdFilNamQ                    20a   Const
015800030627     D  RdRcdFmtNam                  10a   Const
015900040216     D  RdOvrPrc                      1a   Const
016000030627     D  RdSystem                     10a   Const
016100030627     D  RdFmtTyp                     10a   Const
016200030627     D  RdError                   32767a          Options( *VarSize )
016300040828
016400040828     **-- Entry parameters:
016500040901     D CBX123T         Pr
016600040828     D  PxDbfNamQ                    20a
016700040828     **
016800040901     D CBX123T         Pi
016900040828     D  PxDbfNamQ                    20a
017000040731
017100040724      /Free
017200040724
017300040828        ApiRcvSiz  = 65535;
017400040828        pQdb_Qdbfh = %Alloc( ApiRcvSiz );
017500040814
017600040828        DoU  Qdb_Qdbfh.Qdbfyavl <= ApiRcvSiz;
017700040828
017800040828          If  Qdb_Qdbfh.Qdbfyavl > ApiRcvSiz;
017900040828            ApiRcvSiz = Qdb_Qdbfh.Qdbfyavl;
018000040828            pQdb_Qdbfh  = %ReAlloc( pQdb_Qdbfh: ApiRcvSiz );
018100040828          EndIf;
018200040828
018300040828          RtvDbfDsc( Qdb_Qdbfh
018400040828                   : ApiRcvSiz
018500040828                   : FilNamRtnQ
018600040828                   : 'FILD0100'
018700040828                   : PxDbfNamQ
018800040828                   : '*FIRST'
018900040828                   : '0'
019000040828                   : '*LCL'
019100040828                   : '*EXT'
019200040828                   : ERRC0100
019300040828                   );
019400040828        EndDo;
019500040724
019600040815        If  ERRC0100.BytAvl = *Zero;
019700040724
019800040815          pQdb_Qdbfb = pQdb_Qdbfh + Qdb_Qdbfh.Qdbfos;
019900040814
020000040901          For Idx = 1  To Qdb_Qdbfh.Qdbflbnum;
020100040815
020200040814
020300040901            If  Idx < Qdb_Qdbfh.Qdbflbnum;
020400040814              pQdb_Qdbfb = pQdb_Qdbfb + %Size( Qdb_Qdbfb );
020500040814            EndIf;
020600040814          EndFor;
020700040724
020800040724        EndIf;
020900040815
021000040815        DeAlloc  pQdb_Qdbfh;
021100040815
021200040815        *InLr = *On;
021300040724        Return;
021400040814
021500040724      /End-Free
