     **
     **  Program . . : CBX919
     **  Description : Remove ARP table entry - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile options:
     **
     **    CrtRpgMod Module( CBX919 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX919 )
     **              Module( CBX919 )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D   MsgPfx                       3a   Overlay( MsgId: 1 )
     D                                1a
     D  MsgDta                      512a
     **-- Global variables:
     D ErrHdrLen       s             10i 0 Inz( 16 )
     D ErrMsgF         s             10a   Inz( 'QCPFMSG' )

     **-- Convert an address from dotted-decimal format:
     D inet_addr       Pr            10u 0 ExtProc( 'inet_addr' )
     D  char_addr                      *   Value  Options( *String )
     **-- Open list of job queues:
     D RmvArpTblE      Pr                  ExtProc( 'QtocRmvARPTblE' )
     D  RaLinNam                     10a   Const
     D  RaIntNetAdr                  10u 0 Const
     D  RaEntTyp                     10a   Const
     D  RaError                    1024a          Options( *VarSize )
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

     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX919          Pr
     D  PxLinNam                     10a
     D  PxIntNetAdr                  15a
     D  PxEntTyp                     10a
     **
     D CBX919          Pi
     D  PxLinNam                     10a
     D  PxIntNetAdr                  15a
     D  PxEntTyp                     10a

      /Free

        RmvArpTblE( PxLinNam
                  : inet_addr( %Trim( PxIntNetAdr ))
                  : PxEntTyp
                  : ERRC0100
                  );

        If  ERRC0100.BytAvl  > *Zero;

          If  ERRC0100.BytAvl  < 16;
            ErrHdrLen = ERRC0100.BytAvl;
          EndIf;

          If  ERRC0100.MsgPfx  = 'TCP';
            ErrMsgF   = 'QTCPMSG';
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : ErrMsgF
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - ErrHdrLen )
                   );

        Else;

          SndCmpMsg( 'ARP table entry '   +
                      %TrimR( PxEntTyp )  +
                     ' has been removed.'
                   );

        EndIf;

        *InLr = *On;

        Return;

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
          Return   0;
        EndIf;

      /End-Free

     P SndCmpMsg       E
