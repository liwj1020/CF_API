     **
     **  Program . . : CBX963V
     **  Description : Display Server Share - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **  Program description:
     **    Validity checking program for server share existence.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX963V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX963V )
     **              Module( CBX963V )
     **              ActGrp( QILE )
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

     D                               34a

     **-- Open list of server information:
     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       64a
     D  Format                        8a   Const
     D  InfQual                      15a   Const
     D  Error                     32767a          Options( *VarSize )
     D  SsnUsr                       10a   Const  Options( *NoPass )
     D  SsnId                        20u 0 Const  Options( *NoPass )
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
     D  Error                      1024a          Options( *VarSize )

     **-- Check share existence:
     D ChkShr          Pr              n
     D  PxShare                      12a   Const

     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX963V         Pr
     D  PxShare                      12a
     **
     D CBX963V         Pi
     D  PxShare                      12a

      /Free

        If  ChkShr( PxShare ) = *Off;

          SndDiagMsg( 'CPD0006'
                    : '0000Share '        +
                       %Trim( PxShare )   +
                      ' not found.'
                    );

          SndEscMsg( 'CPF0002': '' );
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

     **-- Check share existence:  --------------------------------------------**
     P ChkShr          B                   Export
     D                 Pi              n
     D  PxShare                      12a   Const

     **-- Share information:
     D ZLSL0101        Ds         32767    Qualified
     D  EntLen                       10i 0
     D  Share                        12a
     D  DevTyp                       10i 0
     D  Permis                       10i 0
     D  MaxUsr                       10i 0
     D  CurUsr                       10i 0
     D  SpfTyp                       10i 0
     D  OfsPthNam                    10i 0
     D  LenPthNam                    10i 0
     D  OutQue_q                     20a
     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
     D  PrtDrv                       50a
     D  TxtDsc                       50a
     D  PrtFil_q                     20a
     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
     D  TxtCcsId                     10i 0
     D  OfsExtTbl                    10i 0
     D  NbrTblEnt                    10i 0
     D  EnbTxtCnv                     1a
     D  Publish                       1a
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  RcdLen                       10i 0
     D  InfLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D                               34a

      /Free

        LstSvrInf( ZLSL0101
                 : %Len( ZLSL0101 )
                 : LstInf
                 : 'ZLSL0101'
                 : PxShare
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Off;

        When  LstInf.RcdNbrTot <> 1;
          Return  *Off;

        Other;
          Return  *On;
        EndSl;

      /End-Free

     P ChkShr          E
     **-- Send diagnostic message:
     P SndDiagMsg      B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*DIAG'
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

     P SndDiagMsg      E
     **-- Send escape message:
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : 'QCPFMSG   *LIBL'
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
