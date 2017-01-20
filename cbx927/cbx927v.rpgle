     **
     **  Program . . : CBX927V
     **  Description : Display attributes - VCP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program checks the existence of the specified IFS object.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX927V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX927V )
     **              Module( CBX927V )
     **              ActGrp( QILE )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  ExcpId                        7a
     D                                1a
     D  ExcpDta                     512a
     **-- Global variables:
     D addr            s             10u 0
     **-- access API constants:
     D F_OK            c                   0
     D X_OK            c                   1
     D W_OK            c                   2
     D R_OK            c                   4

     **-- IFS file functions:
     D access          Pr            10i 0 ExtProc( 'access' )
     D   Path                          *   Value  Options( *String )
     D   Amode                       10i 0 Value
     **-- Error number:
     D sys_errno       Pr              *    ExtProc( '__errno' )
     **-- Error string:
     D sys_strerror    Pr              *    ExtProc( 'strerror' )
     D  errno                        10i 0  Value
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

     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Error identification:
     D errno           Pr            10i 0
     D strerror        Pr           128a   Varying

     D*-- Entry parameters:
     D CBX927V         Pr
     D  PxIfsObj                   5002a   Varying
     D  PxOutOpt                      3a
     **
     D CBX927V         Pi
     D  PxIfsObj                   5002a   Varying
     D  PxOutOpt                      3a

      /Free

        If  access( PxIfsObj: F_OK ) = -1;

          SndDiagMsg( 'CPD0006': '0000' + %Char( errno ) + ': ' + strerror );

          SndEscMsg( 'CPF0002': '' );

        EndIf;

        *InLr = *On;

        Return;


      /End-Free

     **-- Get runtime error number:  -----------------------------------------**
     P errno           B
     D                 Pi            10i 0
     **
     D Error           s             10i 0  Based( pError )  NoOpt

      /Free

        pError = sys_errno;

        Return  Error;

      /End-Free

     P errno           E
     **-- Get runtime error text:  -------------------------------------------**
     P strerror        B
     D                 Pi           128a    Varying

      /Free

        Return  %Str( sys_strerror( errno ));

      /End-Free

     P strerror        E
     **-- Send diagnostic message:  ------------------------------------------**
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
     **-- Send escape message:  ----------------------------------------------**
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
