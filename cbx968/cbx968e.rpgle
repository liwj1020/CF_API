     **
     **  Program . . : CBX968E
     **  Description : Display Job Queue Jobs - UIM Exit Program
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX968E )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX968E )
     **               Module( CBX968E )
     **               ActGrp( *CALLER )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     D  CurUsr                       10a   Overlay( PgmSts: 358 )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a

     **-- Global constants:
     D NULL            c                   ''
     D NO_ENT          c                   x'00000000'
     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  EntHdl                        4a
     **-- UIM constants:
     D APP_PRTF        c                   'QPRINT    *LIBL'
     D ODP_SHR         c                   'N'
     D SPLF_NAM        c                   'PJOBQJOB'
     D SPLF_USRDTA     c                   'DSPJOBQJOB'
     D EJECT_NO        c                   'N'
     D CLO_NRM         c                   'M'
     D RES_OK          c                   0
     D RES_ERR         c                   1

     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  JobId                        26a
     D  JobNam_q                     26a
     D   JobNam                      10a   Overlay( JobNam_q:  1 )
     D   JobUsr                      10a   Overlay( JobNam_q: 11 )
     D   JobNbr                       6s 0 Overlay( JobNam_q: 21 )
     D  JobTyp                        1a
     D  JobSts1                       7a
     D  JobSts2                       7a
     D  JobPty                        2a
     D  EntDat                        7a
     D  EntTim                        6a
     D  CurUsr                       10a
     D  SbmJob                       10a
     D  SbmUsr                       10a
     D  SbmNbr                        6s 0
     D  MsgRpy                        1a
     D  MsgQue_q                     20a
     D   MsgQueNam                   10a   Overlay( MsgQue_q:  1 )
     D   MsgQueLib                   10a   Overlay( MsgQue_q: 11 )
     D  MsgKey                        4a

     **-- UIM exit program interfaces:
     **-- Parm interface:
     D UimExit         Ds            70    Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     **-- Function key - call:
     D Type1           Ds                  Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     D  PnlNam                       10a
     D  FncKey                       10i 0
     **-- Action list option/Pull-down field choice - call (type 3/9):
     D Type3           Ds                  Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     D  PnlNam                       10a
     D  LstNam                       10a
     D  LstEntHdl                     4a
     D  OptNbr                       10i 0
     D  FncQlf                       10i 0
     D  PdwFldNam                    10a

     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  PosOpt                        4a   Const
     D  CpyOpt                        1a   Const
     D  SltCri                       20a   Const
     D  SltHdl                        4a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )
     **-- Print panel:
     D PrtPnl          Pr                  ExtPgm( 'QUIPRTP' )
     D  AppHdl                        8a   Const
     D  PrtPnlNam                    10a   Const
     D  EjtOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Add print application:
     D AddPrtApp       Pr                  ExtPgm( 'QUIADDPA' )
     D  AppHdl                        8a   Const
     D  PrtDevF_q                    20a   Const
     D  AltFilNam                    10a   Const
     D  ShrOpnDtaPth                  1a   Const
     D  UsrDta                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     D  OpnDtaRcv                   128a          Options( *NoPass: *VarSize )
     D  OpnDtaRcvLen                 10i 0 Const  Options( *NoPass )
     D  OpnDtaRcvAvl                 10i 0        Options( *NoPass )
     **-- Remove print application:
     D RmvPrtApp       Pr                  ExtPgm( 'QUIRMVPA' )
     D  AppHdl                        8a   Const
     D  CloOpt                        1a   Const
     D  Error                     32767a          Options( *VarSize )

     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                     32767a          Options( *VarSize )

     **-- Additional message information:
     D CBX209          Pr                  ExtPgm( 'CBX209' )
     D  MsqNam_q                     20a
     D  MsqKey                        4a

     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX968E         Pr
     D  PxUimExit                          LikeDs( UimExit )
     **
     D CBX968E         Pi
     D  PxUimExit                          LikeDs( UimExit )

      /Free

          Select;
          When  PxUimExit.TypCall = 1;
            Type1 = PxUimExit;

            If  Type1.FncKey = 21;
              ExSr  PrtJobPnl;
            EndIf;

          When  PxUimExit.TypCall = 3;
            Type3 = PxUimExit;

            If  Type3.OptNbr = 7;
              ExSr  DspMsgInf;
            EndIf;
          EndSl;

        Return;


        BegSr  PrtJobPnl;

          AddPrtApp( Type1.AppHdl
                   : APP_PRTF
                   : SPLF_NAM
                   : ODP_SHR
                   : SPLF_USRDTA
                   : ERRC0100
                   );

          PrtPnl( Type1.AppHdl
                : 'PRTHDR'
                : EJECT_NO
                : ERRC0100
                );

          PrtPnl( Type1.AppHdl
                : 'PRTLST'
                : EJECT_NO
                : ERRC0100
                );

          RmvPrtApp( Type1.AppHdl
                   : CLO_NRM
                   : ERRC0100
                   );

          SndCmpMsg( 'List has been printed.' );

        EndSr;

        BegSr  DspMsgInf;

          GetLstEnt( Type3.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'HNDL'
                   : 'Y'
                   : *Blanks
                   : Type3.LstEntHdl
                   : 'N'
                   : UIM.EntHdl
                   : ERRC0100
                   );

          Select;
          When  LstEnt.MsgRpy = '2';
            SndEscMsg( 'CPI1150': 'QCPFMSG': LstEnt.JobNam_q + LstEnt.MsgQue_q);

          When  LstEnt.MsgKey = *Blanks;
            SndEscMsg( 'CPD1201': 'QCPFMSG': LstEnt.JobNam_q );

          When  LstEnt.MsgKey = *Allx'00';
            SndEscMsg( 'CPD1201': 'QCPFMSG': LstEnt.JobNam_q );

          Other;
            CBX209( LstEnt.MsgQue_q: LstEnt.MsgKey );
          EndSl;

        EndSr;

      /End-Free

     **-- Send escape message:
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
     **-- Send completion message:
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     **
     P SndCmpMsg       E
