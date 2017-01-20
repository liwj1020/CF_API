     **
     **  Program . . : CBX9261
     **  Description : Run IFS file processing
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxFilNam . :  INPUT   IFS file name; the IFS file to process
     **
     **    PxPthNam . :  INPUT   IFS path name; the path used to locate
     **                          the IFS file
     **
     **
     **  Program description:
     **    This program will perform two operations against the IFS file
     **    specified in the two input parameters, file name and path name:
     **
     **    1. Check that no one is currently holding a lock against the
     **       specified file.  This check is repeated for the number of
     **       times specified by the program constant NBR_RTY.  The delay
     **       in seconds between each check is specified by the constant
     **       RTY_ITV_SEC.
     **
     **       Currently the above setting defines a maximum of 120 retreis
     **       and a 30 second interval between each retry.  This enables
     **       this function to wait up to an hour for the file creation to
     **       complete.  Please adjust this setting to accommodate your
     **       specific requirements.
     **
     **       If the attempt to achieve a non-lock situation fails, an
     **       informational message is sent to the user message queue of
     **       the user running this program.
     **
     **       This function is performed by the program CBX9262.
     **
     **    2. Open, read and close the specified IFS file.  While this
     **       process is run, the IFS file will be checked out to prevent
     **       other processes from updating it.  Once the file has been
     **       it will be moved to an archive subdirectory.
     **
     **       Any processing of the file data itself can be added to the
     **       sample program performing this process, CBX9263.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX9261 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX9261 )
     **              Module( CBX9261 )
     **              ActGrp( QILE )
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
     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a
     **-- Global variables:
     D MsgDta          s            512a   Varying
     D MsgKey          s              4a
     D RtnVal          s             10i 0
     D RtyCnt          s             10i 0
     **-- Global constants:
     D NBR_RTY         c                   120
     D RTY_ITV_SEC     c                   30
     **
     D ChkIfsLck       Pr                  ExtPgm( 'CBX9262' )
     D  PxPthNam                   2048a   Const  Varying
     D  PxRtnVal                     10i 0
     **
     D PrcIfsFil       Pr                  ExtPgm( 'CBX9263' )
     D  PxFilNam                   1024a   Const  Varying
     D  PxPthNam                   1024a   Const  Varying
     D  PxRtnVal                     10i 0
     **-- Send message:
     D SndMsg          Pr                  ExtPgm( 'QMHSNDM' )
     D  SmMsgId                       7a   Const
     D  SmMsgFq                      20a   Const
     D  SmMsgDta                    512a   Const  Options( *VarSize )
     D  SmMsgDtaLen                  10i 0 Const
     D  SmMsgTyp                     10a   Const
     D  SmMsgQq                    1000a   Const  Options( *VarSize )
     D  SmMsgQnbr                    10i 0 Const
     D  SmMsgQrpy                    20a   Const
     D  SmMsgKey                      4a
     D  SmError                   32767a          Options( *VarSize )
     **
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
     **-- Delay job:
     D sleep           Pr            10i 0 ExtProc( 'sleep' )
     D  seconds                      10u 0 Value

     **-- Entry parameters:
     D CBX9261         Pr
     D  PxFilNam                   1024a   Const  Varying
     D  PxPthNam                   1024a   Const  Varying
     **
     D CBX9261         Pi
     D  PxFilNam                   1024a   Const  Varying
     D  PxPthNam                   1024a   Const  Varying

      /Free

        For  RtyCnt = 1  To NBR_RTY;

          ChkIfsLck( PxPthNam + '/' + PxFilNam: RtnVal );

          If  RtnVal <= -2;
            sleep( RTY_ITV_SEC );

          Else;
            Leave;

          EndIf;
        EndFor;

        If  RtnVal < *Zero;

          MsgDta = 'IFS file '''        + PxFilNam +
                   ''' in directory ''' + PxPthNam +
                   ''' is currently in use and could not be processed.';
        Else;

          PrcIfsFil( PxFilNam: PxPthNam: RtnVal );

          If  RtnVal < *Zero;
            MsgDta = 'The attempt to process IFS file ''' + PxFilNam +
                     ''' in directory '''                 + PxPthNam +
                     ''' ended in error.';
          Else;
            MsgDta = 'The IFS file '''    + PxFilNam +
                     ''' in directory ''' + PxPthNam +
                     ''' was processed succesfully.';
          EndIf;
        EndIf;

        SndMsg( 'CPF9897'
              : 'QCPFMSG   *LIBL'
              : MsgDta
              : %Len( MsgDta )
              : '*INFO'
              : PsCurUsr + '*LIBL'
              : 1
              : *Blanks
              : MsgKey
              : ERRC0100
              );

        *InLr = *On;
        Return;

      /End-Free
