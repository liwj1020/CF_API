     **
     **  Program . . : CBX963E
     **  Description : Display Server Share - UIM Exit Program
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **  Programmer's notes:
     **    Activation group *CALLER ensures that this program is run in the
     **    same activation group as the CPP, thereby limiting all data and
     **    resources to a common scope.
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX963E )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX963E )
     **               Module( CBX963E )
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
     D RES_OK          c                   0
     **-- Global variables:
     D MsgKey          s              4a
     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  EntHdl                        4a

     **-- UIM API return structures:
     **-- Cursor record:
     D CsrRcd          Ds                  Qualified
     D  CsrVar                       10a
     D  CsrNam                       10a
     D  CsrPos                        5i 0
     **-- UIM Detail record:
     D DtlRcd          Ds                  Qualified
     D  Permis                        1s 0
     D  MaxUsr                       10i 0
     D  CurUsr                       10i 0
     D  SpfTyp                        1s 0
     D  Path                       1000a
     D  Path_s                      256a
     D  OutQue_q                     20a
     D  PrtDrv                       50a
     D  PrtFil_q                     20a
     D  EnbTxtCnv                     1a
     D  PubPrtShr                     1a
     D  NbrFilExt                     3s 0
     D  FilExt                     1000a

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

     **-- Get dialog variable:
     D GetDlgVar       Pr                  ExtPgm( 'QUIGETV' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a          Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **-- Display long text:
     D DspLngTxt       Pr                  ExtPgm( 'QUILNGTX' )
     D  LngTxt                    32767a   Const  Options( *VarSize )
     D  LngTxtLen                    10i 0 Const
     D  MsgId                         7a   Const
     D  MsgF                         20a   Const
     D  Error                     32767a   Const  Options( *VarSize )
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

     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX963E         Pr
     D  PxUimExit                          LikeDs( UimExit )
     **
     D CBX963E         Pi
     D  PxUimExit                          LikeDs( UimExit )

      /Free

        Select;
        When  PxUimExit.TypCall = 1;
          Type1 = PxUimExit;

          Select;
          When  Type1.FncKey = 20;

            GetDlgVar( Type1.AppHdl
                     : DtlRcd
                     : %Size( DtlRcd )
                     : 'DTLRCD'
                     : ERRC0100
                     );

            DspLngTxt( DtlRcd.FilExt
                     : %Len( %TrimR( DtlRcd.FilExt ))
                     : 'CBX0002'
                     : 'CBX963M   *LIBL'
                     : ERRC0100
                     );

          When  Type1.FncKey = 22;

            GetDlgVar( Type1.AppHdl
                     : CsrRcd
                     : %Size( CsrRcd )
                     : 'CSRRCD'
                     : ERRC0100
                     );

            If  CsrRcd.CsrVar <> 'PATHS';
              SndEscMsg( 'CPD9820': 'QCPFMSG': NULL );

            Else;
              GetDlgVar( Type1.AppHdl
                       : DtlRcd
                       : %Size( DtlRcd )
                       : 'DTLRCD'
                       : ERRC0100
                       );

              DspLngTxt( DtlRcd.Path
                       : %Len( %TrimR( DtlRcd.Path ))
                       : 'CBX0001'
                       : 'CBX963M   *LIBL'
                       : ERRC0100
                       );

            EndIf;
          EndSl;
        EndSl;

        Return;

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
