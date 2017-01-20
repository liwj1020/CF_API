     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX946S
     **  Description : Enhanced system request menu - services
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Compile options required:
     **    CrtRpgMod  CBX946S
     **
     **    CrtSrvPgm  CBX946S                        +
     **               Module( CBX946S )              +
     **               Export( *ALL )                 +
     **               ActGrp( QSRVPGM )
     **
     **
     **-- Header Specifications:  --------------------------------------------**
     H NoMain  Option( *SrcStmt )

     **-- API Error data structure:
     D ERRC0100        Ds                  Inz
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Global constants:
     D NULL            c                   ''

     **-- Retrieve message:
     D RtvMsg          Pr                  ExtPgm( 'QMHRTVM' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  FmtNam                       10a   Const
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  RplSubVal                    10a   Const
     D  RtnFmtChr                    10a   Const
     D  Error                     32767a          Options( *VarSize )
     **
     D  RtvOpt                       10a   Const  Options( *NoPass )
     D  CvtCcsId                     10i 0 Const  Options( *NoPass )
     D  RplCcsId                     10i 0 Const  Options( *NoPass )
     **-- Move program messages:
     D MovPgmMsgs      Pr                  ExtPgm( 'QMHMOVPM' )
     D  MsgKey                        4a   Const
     D  MsgTyps                      10a   Const  Options( *VarSize )
     D                                     Dim( 4 )
     D  NbrMsgTyps                   10i 0 Const
     D  ToCalStkE                  4102a   Const  Options( *VarSize )
     D  ToCalStkCnt                  10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **
     D  ToCalStkLen                  10i 0 Const  Options( *NoPass )
     D  ToCalStkEq                   20a   Const  Options( *NoPass )
     **
     D  ToCalStkEdt                  10a   Const  Options( *NoPass )
     D  FrCalStkEad                    *   Const  Options( *NoPass )
     D  FrCalStkCnt                  10i 0 Const  Options( *NoPass )
     **-- Process commands:
     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
     D  SrcCmd                    32702a   Const  Options( *VarSize )
     D  SrcCmdLen                    10i 0 Const
     D  OptCtlBlk                    20a   Const
     D  OptCtlBlkLn                  10i 0 Const
     D  OptCtlBlkFm                   8a   Const
     D  ChgCmd                    32767a          Options( *VarSize )
     D  ChgCmdLen                    10i 0 Const
     D  ChgCmdLenAvl                 10i 0
     D  Error                     32767a          Options( *VarSize )

     **-- Retrieve message text:
     D RtvMsgTxt       Pr          1024a   Varying
     D  MsgId                         7a   Value
     D  MsgF                         10a   Value
     D  MsgFlib                      10a   Value
     D  MsgDta                     1024a   Const  Options( *NoPass )
     **-- Process command:
     D PrcCmd          Pr            10i 0
     D  CmdStr                     1024a   Const  Varying
     **-- Get string:
     D GetStr          Pr          1024a   Varying
     D  StrPtr                         *   Value

     **-- Retrieve message text:
     P RtvMsgTxt       B                   Export
     D                 Pi          1024a   Varying
     D  PxMsgId                       7a   Value
     D  PxMsgF                       10a   Value
     D  PxMsgFlib                    10a   Value
     D  PxMsgDta                   1024a   Const  Options( *NoPass )

     **-- Local variables:
     D MsgDta          s           1024a   Varying
     **-- Return structure:
     D RTVM0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RtnMsgLen                    10i 0
     D  RtnMsgAvl                    10i 0
     D  RtnHlpLen                    10i 0
     D  RtnHlpAvl                    10i 0
     D  Msg                        1024a

      /Free

        If  %Parms >= 4;
          MsgDta = %TrimL( PxMsgDta );
        EndIf;

        RtvMsg( RTVM0100
              : %Size( RTVM0100 )
              :'RTVM0100'
              : PxMsgId
              : PxMsgF + PxMsgFlib
              : MsgDta
              : %Len( MsgDta )
              : '*YES'
              : '*NO'
              : ERRC0100
              );

        If  ERRC0100.BytAvl = *Zero;
          Return  %SubSt( RTVM0100.Msg: 1: RTVM0100.RtnMsgLen );

        Else;
          Return  NULL;
        EndIf;

      /End-Free

     P RtvMsgTxt       E
     **-- Process command:  --------------------------------------------------**
     P PrcCmd          B                   Export
     D                 Pi            10i 0
     D  PxCmdStr                   1024a   Const  Varying

     **-- Local variables:
     D CPOP0100        Ds                  Qualified
     D  TypPrc                       10i 0 Inz( 2 )
     D  DBCS                          1a   Inz( '0' )
     D  PmtAct                        1a   Inz( '2' )
     D  CmdStx                        1a   Inz( '0' )
     D  MsgRtvKey                     4a   Inz( *Allx'00' )
     D  Rsv                           9a   Inz( *Allx'00' )
     **
     D ChgCmd          s          32767a
     D ChgCmdAvl       s             10i 0
     **
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( 0 )
     **
     D TypTbl          Ds
     D  MsgTyps                      10a   Dim( 2 )
     D                               20a   Overlay( TypTbl )
     D                                     Inz( '*DIAG     *ESCAPE ' )

      /Free

        CallP(e)  PrcCmds( PxCmdStr
                         : %Len( PxCmdStr )
                         : CPOP0100
                         : %Size( CPOP0100 )
                         : 'CPOP0100'
                         : ChgCmd
                         : %Size( ChgCmd )
                         : ChgCmdAvl
                         : ERRC0100
                         );

        If  %Error;

          CallP(e)  MovPgmMsgs( *Blanks
                              : MsgTyps
                              : %Elem( MsgTyps )
                              : '*PGMBDY'
                              : 1
                              : ERRC0100
                              );

          Return  -1;
        EndIf;

        Return  0;

      /End-Free

     P PrcCmd          E
     **-- Get string:  -------------------------------------------------------**
     P GetStr          B                   Export
     D                 Pi          1024a   Varying
     D  StrPtr                         *   Value

      /Free

        If  StrPtr = *Null;
          Return  NULL;

        Else;
          Return  %Str( StrPtr );
        EndIf;

      /End-Free

     P GetStr          E
