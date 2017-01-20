     **
     **  Program . . : CBX957
     **  Description : Change NetServer User - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Programmer's notes:
     **    To enable a NetServer user *SECADM special authority is required
     **    as well as *OBJMGT and *USE authority to the system user profile
     **    (the corresponding iSeries user profile).
     **
     **    To use the QZLSCHSI API, you must have *IOSYSCFG special authority.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX957 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX957 )
     **              Module( CBX957 )
     **              ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D STS_ENABLE      c                   'E'

     **-- Request variable:
     D ZLSS0200        Ds                  Qualified
     D  NbrSvrUsr                    10i 0
     D  NetSvrUsr                    10a   Dim( 1024 )

     **-- Change server information:
     D ChgSvrInf       Pr                  ExtPgm( 'QZLSCHSI' )
     D  RqsVar                    32767a   Const  Options( *VarSize )
     D  RqsVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgF_q                       20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkEnt                    10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                       512a          Options( *VarSize )
     **
     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
     D  DspWait                      10i 0 Const  Options( *NoPass )
     **
     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
     D  CcsId                        10i 0 Const  Options( *NoPass )

     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX957          Pr
     D  PxUsrPrf                     10a   Varying
     D  PxStatus                      1a
     **
     D CBX957          Pi
     D  PxUsrPrf                     10a   Varying
     D  PxStatus                      1a

      /Free

        If  PxStatus = STS_ENABLE;

          ZLSS0200.NbrSvrUsr  = 1;
          ZLSS0200.NetSvrUsr(1) = PxUsrPrf;

          ChgSvrInf( ZLSS0200: %Size( ZLSS0200 ): 'ZLSS0200': ERRC0100 );

          If  ERRC0100.BytAvl > *Zero;

            If  ERRC0100.BytAvl < OFS_MSGDTA;
              ERRC0100.BytAvl = OFS_MSGDTA;
            EndIf;

            SndEscMsg( ERRC0100.MsgId
                     : 'QCPFMSG'
                     : %Subst( ERRC0100.MsgDta
                             : 1
                             : ERRC0100.BytAvl - OFS_MSGDTA
                             )
                     );
          Else;
            SndCmpMsg( 'NetServer user ' + PxUsrPrf + ' enabled.' );
          EndIf;

        Else;
            SndCmpMsg( 'NetServer user ' + PxUsrPrf + ' not changed.' );
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Send completion message:  ------------------------------------------**
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

     P SndCmpMsg       E
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
