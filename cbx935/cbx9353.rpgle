     **
     **  Program . . : CBX9353
     **  Description : Run Job Command - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will run the command received from a data queue and
     **    pass back a flag indicating success or failure of the command.
     **
     **
     **  Compile and setup instructions:
     **    CrtBndRpg   Pgm( CBX9353 )
     **                SrcFile( QRPGLESRC )
     **                SrcMbr( CBX9353 )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )  DftActGrp( *Yes )
     **-- System information:
     D PgmSts         SDs                  Qualified  NoOpt
     D  PgmNam           *Proc
     D  Status                        5a   Overlay( PgmSts: 11 )
     D  StmNbr                        8a   Overlay( PgmSts: 21 )
     D  MsgId                         7a   Overlay( PgmSts: 40 )
     D  Msg                          80a   Overlay( PgmSts: 91 )
     D  JobId                        26a   Overlay( PgmSts: 244 )
     D  CurJob                       10a   Overlay( PgmSts: 244 )
     D  JobId2                       16a   Overlay( PgmSts: 254 )
     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
     D  JobNbr                        6a   Overlay( PgmSts: 264 )
     **-- Data queue API parameters:
     D Dta             s           4096a
     D DtaLen          s              5p 0
     D WaitSec         s              5p 0 Inz( 0 )
     D SndInfo         s              1a
     D DtqNam          s             10a   Inz( 'CBX935DQ' )
     D DtqLib          s             10a   Inz( 'QGPL' )
     **-- Send data queue entry:
     D SndDtaQe        Pr                  ExtPgm( 'QSNDDTAQ' )
     D  SqName                       10a   Const
     D  SqLib                        10a   Const
     D  SqDtaLen                      5p 0 Const
     D  SqDta                     32767a   Const  Options( *VarSize )
     D  SqKeyLen                      3p 0 Const  Options( *NoPass )
     D  SqKey                       256a   Const  Options( *VarSize: *NoPass )
     **-- Retrieve data queue entry:
     D RcvDtaQe        Pr                  ExtPgm( 'QRCVDTAQ' )
     D  RqName                       10a   Const
     D  RqLib                        10a   Const
     D  RqDtaLen                      5p 0 Const
     D  RqDta                     32767a          Options( *VarSize )
     D  RqWait                        5p 0 Const
     D  RqKeyOrder                    2a   Const  Options( *NoPass )
     D  RqKeyLen                      3p 0 Const  Options( *NoPass )
     D  RqKey                       256a          Options( *VarSize: *NoPass )
     D  RqSndInLg                     3p 0 Const  Options( *NoPass)
     D  RqSndInfo                    44a          Options( *VarSize: *Nopass )
     **-- Execute command:
     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
     D  CmdStr                      256a   Const  Options( *VarSize )
     D  CmdLen                       15p 5 Const
     D  CmdIGC                        3a   Const  Options( *NoPass )

      /Free

        RcvDtaQe( DtqNam
                : DtqLib
                : DtaLen
                : Dta
                : WaitSec
                : 'EQ'
                : %Size( PgmSts.JobId )
                : PgmSts.JobId
                : *Zero
                : SndInfo
                );

        If  DtaLen > *Zero;

          CallP(e)  ExcCmd( Dta: DtaLen );

          SndDtaQe( DtqNam
                  : DtqLib
                  : 1
                  : %Error
                  : %Size( PgmSts.JobId )
                  : 'RUNJOBCMD ' + PgmSts.JobId2
                  );

        EndIf;

        *InLr = *On;
        Return;

      /End-Free

