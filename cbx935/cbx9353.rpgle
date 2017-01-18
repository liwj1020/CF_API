000100050513     **
000200050513     **  Program . . : CBX9353
000300050513     **  Description : Run Job Command - CPP
000400050513     **  Author  . . : Carsten Flensburg
000500050513     **
000600050513     **
000700050513     **  Program description:
000800050513     **    This program will run the command received from a data queue and
000900050513     **    pass back a flag indicating success or failure of the command.
001000050513     **
001100050513     **
001200050513     **  Compile and setup instructions:
001300050513     **    CrtBndRpg   Pgm( CBX9353 )
001400050513     **                SrcFile( QRPGLESRC )
001500050513     **                SrcMbr( CBX9353 )
001600050513     **
001700050513     **
001800050513     **-- Control specification:  --------------------------------------------**
001900031112     H Option( *SrcStmt )  DftActGrp( *Yes )
002000050320     **-- System information:
002100050320     D PgmSts         SDs                  Qualified  NoOpt
002200050320     D  PgmNam           *Proc
002300050320     D  Status                        5a   Overlay( PgmSts: 11 )
002400050320     D  StmNbr                        8a   Overlay( PgmSts: 21 )
002500050320     D  MsgId                         7a   Overlay( PgmSts: 40 )
002600050320     D  Msg                          80a   Overlay( PgmSts: 91 )
002700050320     D  JobId                        26a   Overlay( PgmSts: 244 )
002800050320     D  CurJob                       10a   Overlay( PgmSts: 244 )
002900050320     D  JobId2                       16a   Overlay( PgmSts: 254 )
003000050320     D  UsrPrf                       10a   Overlay( PgmSts: 254 )
003100050320     D  JobNbr                        6a   Overlay( PgmSts: 264 )
003200050320     **-- Data queue API parameters:
003300050320     D Dta             s           4096a
003400050320     D DtaLen          s              5p 0
003500050320     D WaitSec         s              5p 0 Inz( 0 )
003600050320     D SndInfo         s              1a
003700050320     D DtqNam          s             10a   Inz( 'CBX935DQ' )
003800050320     D DtqLib          s             10a   Inz( 'QGPL' )
003900050320     **-- Send data queue entry:
004000981102     D SndDtaQe        Pr                  ExtPgm( 'QSNDDTAQ' )
004100010530     D  SqName                       10a   Const
004200010530     D  SqLib                        10a   Const
004300011119     D  SqDtaLen                      5p 0 Const
004400010530     D  SqDta                     32767a   Const  Options( *VarSize )
004500011119     D  SqKeyLen                      3p 0 Const  Options( *NoPass )
004600010530     D  SqKey                       256a   Const  Options( *VarSize: *NoPass )
004700050320     **-- Retrieve data queue entry:
004800021018     D RcvDtaQe        Pr                  ExtPgm( 'QRCVDTAQ' )
004900021018     D  RqName                       10a   Const
005000021018     D  RqLib                        10a   Const
005100021018     D  RqDtaLen                      5p 0 Const
005200021018     D  RqDta                     32767a          Options( *VarSize )
005300021018     D  RqWait                        5p 0 Const
005400021018     D  RqKeyOrder                    2a   Const  Options( *NoPass )
005500021018     D  RqKeyLen                      3p 0 Const  Options( *NoPass )
005600021018     D  RqKey                       256a          Options( *VarSize: *NoPass )
005700021018     D  RqSndInLg                     3p 0 Const  Options( *NoPass)
005800021018     D  RqSndInfo                    44a          Options( *VarSize: *Nopass )
005900050320     **-- Execute command:
006000021114     D ExcCmd          Pr                  ExtPgm( 'QCMDEXC' )
006100021114     D  CmdStr                      256a   Const  Options( *VarSize )
006200021114     D  CmdLen                       15p 5 Const
006300021114     D  CmdIGC                        3a   Const  Options( *NoPass )
006400050320
006500050320      /Free
006600050320
006700050320        RcvDtaQe( DtqNam
006800050320                : DtqLib
006900050320                : DtaLen
007000050320                : Dta
007100050320                : WaitSec
007200050320                : 'EQ'
007300050320                : %Size( PgmSts.JobId )
007400050320                : PgmSts.JobId
007500050320                : *Zero
007600050320                : SndInfo
007700050320                );
007800050320
007900050320        If  DtaLen > *Zero;
008000050320
008100050320          CallP(e)  ExcCmd( Dta: DtaLen );
008200050320
008300050320          SndDtaQe( DtqNam
008400050320                  : DtqLib
008500050320                  : 1
008600050320                  : %Error
008700050320                  : %Size( PgmSts.JobId )
008800050320                  : 'RUNJOBCMD ' + PgmSts.JobId2
008900050320                  );
009000050320
009100050320        EndIf;
009200050320
009300050320        *InLr = *On;
009400050320        Return;
009500050320
009600050320      /End-Free
009700050320
