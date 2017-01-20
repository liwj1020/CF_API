     **
     **  Program . . : CBX922
     **  Description : Process record locks - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX922 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX922 )
     **              Module( CBX922 )
     **              ActGrp( QILE )
     **
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )
     **-- System information:
     D PgmSts         Sds
     D  PsCurJob                     10a   Overlay( PgmSts: 244 )
     D  PsUsrPrf                     10a   Overlay( PgmSts: 254 )
     D  PsJobNbr                      6a   Overlay( PgmSts: 264 )
     D  PsCurUsr                     10a   Overlay( PgmSts: 358 )
     **-- Global variables:
     D JobIdx          s             10u 0
     **
     D FncRqs          s             10i 0
     D MsgSntInd       s             10i 0
     **
     D CmdStr          s            512a   Varying
     D MsgTyps         s             10a   Dim( 4 )
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Record lock information:  ------------------------------------------**
     D RRCD0100        Ds         65535    Qualified
     D  JobAvl                       10i 0
     D  JobRtn                       10i 0
     D  OfsJobInf                    10i 0
     D  SizJobInf                    10i 0
     **
     D JobInf          Ds                  Qualified  Based( pJobInf )
     D  JobNam                       10a
     D  JobUsr                       10a
     D  JobNbr                        6a
     D  LckSts                        1a
     D  LckStt                        1a
     D  LckRrn                       10u 0
     D  ThrId                         8a
     D  ThrHdl                       10u 0
     **-- Retrieve record locks:
     D RtvRcdLck       Pr                  ExtPgm( 'QDBRRCDL' )
     D  RlRcvVar                  65535a         Options( *VarSize )
     D  RlRcvVarLen                  10i 0 Const
     D  RlFmtNam                      8a   Const
     D  RlRcdIdInf                   48a   Const Options( *VarSize )
     D  RlMbrNam                     10a   Const
     D  RlRcdRrn                     10u 0 Const
     D  RlError                   32767a         Options( *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Retrieve object description:
     D RtvObjD         Pr                  ExtPgm( 'QUSROBJD' )
     D  RoRcvVar                  32767a          Options( *VarSize )
     D  RoRcvVarLen                  10i 0 Const
     D  RoFmtNam                      8a   Const
     D  RoObjNamQ                    20a   Const
     D  RoObjTyp                     10a   Const
     D  RoError                   32767a          Options( *VarSize )
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
     **-- Execute command:
     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
     D  XcCmd                       512a   Const  Options( *VarSize )
     D  XcCmdLen                     15p 5 Const
     D  XcCmdIGC                      3a   Const  Options( *NoPass )
     **-- Send break message:
     D SndBrkMsg       Pr                  ExtPgm( 'QMHSNDBM' )
     D  SbMsgTxt                   6000a   Const  Options( *VarSize )
     D  SbMsgTxtLen                  10i 0 Const
     D  SbMsgTyp                     10a   Const
     D  SbMsgQueQ                    20a   Const  Options( *VarSize )  Dim( 50 )
     D  SbMsgQueNbr                  10i 0 Const
     D  SbMsgQueRpy                  20a   Const
     D  SbError                   32767a          Options( *VarSize )
     D  SbCcsId                      10i 0 Const  Options( *NoPass )
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QEZSNDMG' )
     D  SmMsgTyp                     10a   Const
     D  SmDlvMod                     10a   Const
     D  SmMsgTxt                    494a   Const  Options( *VarSize )
     D  SmMsgTxtLen                  10i 0 Const
     D  SmMsgRcv                     10a   Const  Options( *VarSize ) Dim( 299 )
     D  SmMsgRcvNbr                  10i 0 Const
     D  SmMsgSntInd                  10i 0
     D  SmFncRqs                     10i 0
     D  SmError                   32767a          Options( *VarSize )
     D  SmShwSndMsgDs                 1a   Const  Options( *NoPass )
     D  SmMsgQueNam                  20a   Const  Options( *NoPass )
     D  SmNamTypInd                   4a   Const  Options( *NoPass )
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const  Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                    1024a          Options( *VarSize )
     **-- Move program messages:
     D MovPgmMsg       Pr                  ExtPgm( 'QMHMOVPM' )
     D  MpMsgKey                      4a   Const
     D  MpMsgTyps                    10a   Const  Options( *VarSize )  Dim( 4 )
     D  MpNbrMsgTyps                 10i 0 Const
     D  MpToCalStkE                4102a   Const  Options( *VarSize )
     D  MpToCalStkCnt                10i 0 Const
     D  MpError                   32767a          Options( *VarSize )
     D  MpToCalStkLen                10i 0 Const  Options( *NoPass )
     D  MpToCalStkEq                 20a   Const  Options( *NoPass )
     D  MpToCalStkEdt                10a   Const  Options( *NoPass )
     D  MpFrCalStkEad                  *   Const  Options( *NoPass )
     D  MpFrCalStkCnt                10i 0 Const  Options( *NoPass )

     **-- Validate special authority:
     D ValSpcAut       Pr            10i 0
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value
     **-- Retrieve object attribute:
     D RtvObjAtr       Pr            10a
     D  RaObjNamQ                    20a   Const
     D  RaObjTyp                     10a   Const
     **-- Get physical file name from logical:
     D GetPhyFil       Pr            20a
     D  GpFilNamQ                    20a   Const
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send message by type:
     D SndMsgTyp       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const

     **-- Entry parameters:
     D CBX922          Pr
     D  PxFilNamQ                    20a
     D  PxMbrNam                     10a
     D  PxRrn                        10u 0
     D  PxAction                      7a
     D  PxMsgTxt                    512a   Varying
     D  PxMsgTo                       5a
     D  PxEndOpt                      7a
     D  PxDelay                      10i 0
     **
     D CBX922          Pi
     D  PxFilNamQ                    20a
     D  PxMbrNam                     10a
     D  PxRrn                        10u 0
     D  PxAction                      7a
     D  PxMsgTxt                    512a   Varying
     D  PxMsgTo                       5a
     D  PxEndOpt                      7a
     D  PxDelay                      10i 0

      /Free

        If  ValSpcAut( PsUsrPrf: '*JOBCTL' ) = -1;

          SndEscMsg( 'CPFB0CE'
                   : 'QCPFMSG'
                   : '*JOBCTL'
                   );
        Else;
          If  RtvObjAtr( PxFilNamQ: '*FILE' ) = 'LF';
            Eval  PxFilNamQ = GetPhyFil( PxFilNamQ );
          EndIf;

          RtvRcdLck( RRCD0100
                   : %Size( RRCD0100 )
                   : 'RRCD0100'
                   : PxFilNamQ
                   : PxMbrNam
                   : PxRrn
                   : ERRC0100
                   );

          If  ERRC0100.BytAvl = *Zero;
            ExSr  PrcLstEnt;

          Else;
            SndEscMsg( ERRC0100.MsgId
                     : 'QCPFMSG'
                     : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
                     );

          EndIf;
        EndIf;

        *InLr = *On;

        Return;

        BegSr  PrcLstEnt;

          pJobInf = %Addr( RRCD0100 ) + RRCD0100.OfsJobInf;

          For  JobIdx = 1  to RRCD0100.JobRtn;

            If  PxAction = '*BRKMSG';
              ExSr  SndNtfMsg;

            Else;
              ExSr  RunEndJob;
            EndIf;

            If  JobIdx < RRCD0100.JobRtn;
              pJobInf = pJobInf + RRCD0100.SizJobInf;
            EndIf;
          EndFor;

          SndMsgTyp( 'Lock processing completed normally.': '*COMP' );

        EndSr;

        BegSr  RunEndJob;

          CmdStr = 'ENDJOB JOB('                      +
                    %Trim( JobInf.JobNbr )            + '/'  +
                    %Trim( JobInf.JobUsr )            + '/'  +
                    %Trim( JobInf.JobNam )            + ') ' +
                   'OPTION(' + %Trim( PxEndOpt )      + ') ' +
                   'DELAY(' + %Char( PxDelay )        + ') ' +
                   'SPLFILE(*NO) LOGLMT(*SAME) ADLINTJOBS(*NONE)';

          Monitor;
            ExcCmd( CmdStr: %Len( CmdStr ));

          On-Error;
            MsgTyps(1) = '*DIAG';
            MsgTyps(2) = '*ESCAPE';

            MovPgmMsg( *Blanks
                     : MsgTyps
                     : 2
                     : '*PGMBDY'
                     : 1
                     : ERRC0100
                     );

            LeaveSr;
          EndMon;

            MovPgmMsg( *Blanks
                     : '*COMP'
                     : 1
                     : '*PGMBDY'
                     : 1
                     : ERRC0100
                     );

        EndSr;

        BegSr  SndNtfMsg;

          If  PxMsgTo = '*JOB';

            SndBrkMsg( PxMsgTxt
                     : %Len( PxMsgTxt )
                     : '*INFO'
                     : JobInf.JobNam + '*LIBL'
                     : 1
                     : ' '
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl > *Zero;

              MovPgmMsg( *Blanks
                       : '*DIAG'
                       : 1
                       : '*PGMBDY'
                       : 1
                       : ERRC0100
                       );
            EndIf;

          Else;

            SndMsg( '*INFO'
                  : '*BREAK'
                  : PxMsgTxt
                  : %Len( PxMsgTxt )
                  : JobInf.JobUsr
                  : 1
                  : MsgSntInd
                  : FncRqs
                  : ERRC0100
                  : 'N'
                  : *Blanks
                  : '*USR'
                  );
          EndIf;

        EndSr;

      /End-Free

     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*ESCAPE'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndEscMsg       E
     **-- Send message by type:  ---------------------------------------------**
     P SndMsgTyp       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     D  PxMsgTyp                     10a   Const
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : PxMsgTyp
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return   0;
        EndIf;

      /End-Free

     P SndMsgTyp       E
     **-- Validate special authority:  ---------------------------------------**
     P ValSpcAut       B                   Export
     D                 Pi            10i 0
     D  PxUsrPrf                     10a   Value
     D  PxSpcAut                     10a   Value
     **
     D USRI0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  SpcAut                       15a   Overlay( USRI0200: 29 )
     D   AllObj                       1a   Overlay( SpcAut: 1 )
     D   SecAdm                       1a   Overlay( SpcAut: *Next )
     D   JobCtl                       1a   Overlay( SpcAut: *Next )
     D   SplCtl                       1a   Overlay( SpcAut: *Next )
     D   SavSys                       1a   Overlay( SpcAut: *Next )
     D   Service                      1a   Overlay( SpcAut: *Next )
     D   Audit                        1a   Overlay( SpcAut: *Next )
     D   IoSysCfg                     1a   Overlay( SpcAut: *Next )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return -1;

        When  PxSpcAut = '*ALLOBJ'   And  USRI0200.AllObj   = 'Y';
          Return  0;

        When  PxSpcAut = '*SECADM'   And  USRI0200.SecAdm   = 'Y';
          Return  0;

        When  PxSpcAut = '*JOBCTL'   And  USRI0200.JobCtl   = 'Y';
          Return  0;

        When  PxSpcAut = '*SPLCTL'   And  USRI0200.SplCtl   = 'Y';
          Return  0;

        When  PxSpcAut = '*SAVSYS'   And  USRI0200.SavSys   = 'Y';
          Return  0;

        When  PxSpcAut = '*SERVICE'  And  USRI0200.Service  = 'Y';
          Return  0;

        When  PxSpcAut = '*AUDIT'    And  USRI0200.Audit    = 'Y';
          Return  0;

        When  PxSpcAut = '*IOSYSCFG' And  USRI0200.IoSysCfg = 'Y';
          Return  0;

        Other;
          Return -1;
        EndSl;

      /End-Free

     P ValSpcAut       E
     **-- Retrieve object attribute:  ----------------------------------------**
     P RtvObjAtr       B                   Export
     D                 Pi            10a
     D  RaObjNamQ                    20a   Const
     D  RaObjTyp                     10a   Const
     **
     D OBJD0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTypRt                     10a
     D  ObjLibRt                     10a
     D  ObjASP                       10i 0
     D  ObjOwn                       10a
     D  ObjDmn                        2a
     D  ObjCrtDT                     13a
     D  ObjChgDT                     13a
     D  ExtAtr                       10a
     D  TxtDsc                       50a
     D  SrcF                         10a
     D  SrcLib                       10a
     D  SrcMbr                       10a

      /Free

         RtvObjD( OBJD0200
                : %Size( OBJD0200 )
                : 'OBJD0200'
                : RaObjNamQ
                : RaObjTyp
                : ERRC0100
                );

         If  ERRC0100.BytAvl > *Zero;
           Return  *Blanks;

         Else;
           Return  OBJD0200.ExtAtr;
         EndIf;

      /End-Free

     P RtvObjAtr       E
     **-- Get physical file name from logical:  ------------------------------**
     P GetPhyFil       B                   Export
     D                 Pi            20a
     D  GpObjNamQ                    20a   Const

     **-- Local variables:
     D PhyFilNamQ      s             20a   Inz
     D FilNamRtnQ      s             20a
     D ApiRcvSiz       s             10u 0
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

      /Free

        PhyFilNamQ = GpObjNamQ;

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
                   : GpObjNamQ
                   : '*FIRST'
                   : '0'
                   : '*LCL'
                   : '*EXT'
                   : ERRC0100
                   );
        EndDo;

        If  ERRC0100.BytAvl = *Zero;

          pQdb_Qdbfb = pQdb_Qdbfh + Qdb_Qdbfh.Qdbfos;

          If  Qdb_Qdbfh.Qdbflbnum = 1;

            PhyFilNamQ = Qdb_Qdbfb.Qdbfbf + Qdb_Qdbfb.Qdbfbfl;
          EndIf;
        EndIf;

        DeAlloc  pQdb_Qdbfh;

        Return  PhyFilNamQ;

      /End-Free

     P GetPhyFil       E
