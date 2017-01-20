     **-- Header specifications:  --------------------------------------------**
     H BndDir( 'QC2LE' )  Option( *SrcStmt )
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Api parameters:
     D FilNamRtnQ      s             20a
     D ApiRcvSiz       s             10u 0
     **-- Global variables:
     D Idx             s             10i 0
     **-- FILD0100 formats:
     D Qdb_Qdbfh       Ds                  Based( pQdb_Qdbfh )  Qualified
     D  Qdbfyret                     10i 0
     D  Qdbfyavl                     10i 0
     D  Qdbfhflg                      2a
     D*  Reserved_1    :2
     D*  Qdbfhfpl      :1
     D*  Reserved_2    :1
     D*  Qdbfhfsu      :1
     D*  Reserved_3    :1
     D*  Qdbfhfky      :1
     D*  Reserved_4    :1
     D*  Qdbfhflc      :1
     D*  Qdbfkfso      :1
     D*  Reserved_5    :4
     D*  Qdbfigcd      :1
     D*  Qdbfigcl      :1
     D  Reserved_7                    4a
     D  Qdbflbnum                     5i 0
     D  Qdbfkdat                     14a
     D  Qdbfknum                      5i 0 Overlay( Qdbfkdat: 1 )
     D  Qdbfkmxl                      5i 0 Overlay( Qdbfkdat: *Next )
     D  Qdbfkflg                      1a   Overlay( Qdbfkdat: *Next )
     D*  Reserved_8    :1
     D*  Qdbfkfcs      :1
     D*  Reserved_9    :4
     D*  Qdbfkfrc      :1
     D*  Qdbfkflt      :1
     D  Qdbfkfdm                      1a   Overlay( Qdbfkdat: *Next )
     D  Reserved_10                   8a   Overlay( Qdbfkdat: *Next )
     D  Qdbfhaut                     10a
     D  Qdbfhupl                      1a
     D  Qdbfhmxm                      5i 0
     D  Qdbfwtfi                      5i 0
     D  Qdbfhfrt                      5i 0
     D  Qdbfhmnum                     5i 0
     D  Reserved_11                   9a
     D  Qdbfbrwt                      5i 0
     D  Qaaf                          1a
     D*  Reserved_12   :7
     D*  Qdbfpgmd      :1
     D  Qdbffmtnum                    5i 0
     D  Qdbfhfl2                      2a
     D*  Qdbfjnap      :1
     D*  Reserved_13   :1
     D*  Qdbfrdcp      :1
     D*  Qdbfwtcp      :1
     D*  Qdbfupcp      :1
     D*  Qdbfdlcp      :1
     D*  Reserved_14   :9
     D*  Qdbfkfnd      :1
     D  Qdbfvrm                       5i 0
     D  Qaaf2                         2a
     D*  Qdbfhmcs      :1
     D*  Reserved_15   :1
     D*  Qdbfknll      :1
     D*  Qdbf_nfld     :1
     D*  Qdbfvfld      :1
     D*  Qdbftfld      :1
     D*  Qdbfgrph      :1
     D*  Qdbfpkey      :1
     D*  Qdbfunqc      :1
     D*  Reserved_118  :2
     D*  Qdbfapsz      :1
     D*  Qdbfdisf      :1
     D*  Reserved_68   :1
     D*  Reserved_69   :1
     D*  Reserved_70   :1
     D  Qdbfhcrt                     13a
     D  Qdbfhtx                      52a
     D   Reserved_18                  2a   Overlay( Qdbfhtx: 1 )
     D   Qdbfhtxt                    50a   Overlay( Qdbfhtx: *Next )
     D  Reserved_19                  13a
     D  Qdbfsrc                      30a
     D   Qdbfsrcf                    10a   Overlay( Qdbfsrc: 1 )
     D   Qdbfsrcm                    10a   Overlay( Qdbfsrc: *Next )
     D   Qdbfsrcl                    10a   Overlay( Qdbfsrc: *Next )
     D  Qdbfkrcv                      1a
     D  Reserved_20                  23a
     D  Qdbftcid                      5i 0
     D  Qdbfasp                       2a
     D  Qdbfnbit                      1a
     D*  Qdbfhudt      :1
     D*  Qdbfhlob      :1
     D*  Qdbfhdtl      :1
     D*  Qdbfhudf      :1
     D*  Qdbfhlon      :1
     D*  Qdbfhlop      :1
     D*  Qdbfhdll      :1
     D*  Reserved_21   :1
     D  Qdbfmxfnum                    5i 0
     D  Reserved_22                  76a
     D  Qdbfodic                     10i 0
     D  Reserved_23                  14a
     D  Qdbffigl                      5i 0
     D  Qdbfmxrl                      5i 0
     D  Reserved_24                   8a
     D  Qdbfgkct                      5i 0
     D  Qdbfos                       10i 0
     D  Reserved_25                   8a
     D  Qdbfocs                      10i 0
     D  Reserved_26                   4a
     D  Qdbfpact                      2a
     D  Qdbfhrls                      6a
     D  Reserved_27                  20a
     D  Qdbpfof                      10i 0
     D  Qdblfof                      10i 0
     D  Qdbfssfp                      6a
     D   Qdbfnlsb                     1a   Overlay( Qdbfssfp: 1 )
     D*   Qdbfsscs     :3
     D*   Reserved_103 :5
     D   Qdbflang                     3a   Overlay( Qdbfssfp: *Next )
     D   Qdbfcnty                     2a   Overlay( Qdbfssfp: *Next )
     D  Qdbfjorn                     10i 0
     D  Qdbfevid                     10i 0
     D  Reserved_28                  14a
     **
     D Qdb_Qdbfb       Ds                  Qualified  Based( pQdb_Qdbfb )
     D  Reserved_48                  48a
     D  Qdbfbf                       10a
     D  Qdbfbfl                      10a
     D  Qdbft                        10a
     D  Reserved_49                  37a
     D  Qdbfbgky                      5i 0
     D  Reserved_50                   2a
     D  Qdbfblky                      5i 0
     D  Reserved_51                   2a
     D  Qdbffogl                      5i 0
     D  Reserved_52                   3a
     D  Qdbfsoon                      5i 0
     D  Qdbfsoof                     10i 0
     D  Qdbfksof                     10i 0
     D  Qdbfkyct                      5i 0
     D  Qdbfgenf                      5i 0
     D  Qdbfodis                     10i 0
     D  Reserved_53                  14a
     **-- Retrieve database file description:
     D RtvDbfDsc       Pr                  ExtPgm( 'QDBRTVFD' )
     D  RdRcvVar                  32767a          Options( *VarSize )
     D  RdRcvVarLen                  10i 0 Const
     D  RdFilNamRtnQ                 20a
     D  RdFmtNam                      8a   Const
     D  RdFilNamQ                    20a   Const
     D  RdRcdFmtNam                  10a   Const
     D  RdOvrPrc                      1a   Const
     D  RdSystem                     10a   Const
     D  RdFmtTyp                     10a   Const
     D  RdError                   32767a          Options( *VarSize )

     **-- Entry parameters:
     D CBX123T         Pr
     D  PxDbfNamQ                    20a
     **
     D CBX123T         Pi
     D  PxDbfNamQ                    20a

      /Free

        ApiRcvSiz  = 65535;
        pQdb_Qdbfh = %Alloc( ApiRcvSiz );

        DoU  Qdb_Qdbfh.Qdbfyavl <= ApiRcvSiz;

          If  Qdb_Qdbfh.Qdbfyavl > ApiRcvSiz;
            ApiRcvSiz = Qdb_Qdbfh.Qdbfyavl;
            pQdb_Qdbfh  = %ReAlloc( pQdb_Qdbfh: ApiRcvSiz );
          EndIf;

          RtvDbfDsc( Qdb_Qdbfh
                   : ApiRcvSiz
                   : FilNamRtnQ
                   : 'FILD0100'
                   : PxDbfNamQ
                   : '*FIRST'
                   : '0'
                   : '*LCL'
                   : '*EXT'
                   : ERRC0100
                   );
        EndDo;

        If  ERRC0100.BytAvl = *Zero;

          pQdb_Qdbfb = pQdb_Qdbfh + Qdb_Qdbfh.Qdbfos;

          For Idx = 1  To Qdb_Qdbfh.Qdbflbnum;


            If  Idx < Qdb_Qdbfh.Qdbflbnum;
              pQdb_Qdbfb = pQdb_Qdbfb + %Size( Qdb_Qdbfb );
            EndIf;
          EndFor;

        EndIf;

        DeAlloc  pQdb_Qdbfh;

        *InLr = *On;
        Return;

      /End-Free
