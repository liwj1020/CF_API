     **-- Header specifications:  --------------------------------------------**
     H  Option( *SrcStmt )
     **
     D AudLvl          s              1a
     **-- API error information:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )

     **-- Retrieve user audit:
     D RtvUsrAud       Pr             1a
     D  PxUsrPrf                     10a   Value
     D  PxAudVal                     10a   Value

      /Free

          AudLvl = RtvUsrAud( 'CF101': '*CMD' );

          Return;

      /End-Free

     **-- Retrieve user audit value:  ----------------------------------------**
     P RtvUsrAud       B                   Export
     D                 Pi             1a
     D  PxUsrPrf                     10a   Value
     D  PxAudVal                     10a   Value
     **
     D USRI0300        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  UsrAud                             Overlay( USRI0300: 511 )
     D                                     LikeDs( AudLvl )
     **
     D AudLvl          Ds                  Qualified
     D  Cmd                           1a
     D  Create                        1a
     D  Delete                        1a
     D  JobDta                        1a
     D  ObjMgt                        1a
     D  OfcSrv                        1a
     D  PgmAdp                        1a
     D  SavRst                        1a
     D  Security                      1a
     D  Service                       1a
     D  SplfDta                       1a
     D  SysMgt                        1a
     D  Optical                       1a

      /Free

        RtvUsrInf( USRI0300
                 : %Size( USRI0300 )
                 : 'USRI0300'
                 : PxUsrPrf
                 : ERRC0100
                 );

        Select;
        When  ERRC0100.BytAvl > *Zero;
          Return  *Blank;

        When  PxAudVal = '*CMD';
          Return  USRI0300.UsrAud.Cmd;

        When  PxAudVal = '*CREATE';
          Return  USRI0300.UsrAud.Create;

        When  PxAudVal = '*DELETE';
          Return  USRI0300.UsrAud.Delete;

        When  PxAudVal = '*JOBDTA';
          Return  USRI0300.UsrAud.JobDta;

        When  PxAudVal = '*OBJMGT';
          Return  USRI0300.UsrAud.ObjMgt;

        When  PxAudVal = '*OFCSRV';
          Return  USRI0300.UsrAud.OfcSrv;

        When  PxAudVal = '*OPTICAL';
          Return  USRI0300.UsrAud.Optical;

        When  PxAudVal = '*PGMADP';
          Return  USRI0300.UsrAud.PgmAdp;

        When  PxAudVal = '*SAVRST';
          Return  USRI0300.UsrAud.SavRst;

        When  PxAudVal = '*SECURITY';
          Return  USRI0300.UsrAud.Security;

        When  PxAudVal = '*SERVICE';
          Return  USRI0300.UsrAud.Service;

        When  PxAudVal = '*SPLFDTA';
          Return  USRI0300.UsrAud.SplfDta;

        When  PxAudVal = '*SYSMGT';
          Return  USRI0300.UsrAud.SysMgt;

        Other;
          Return  *Blank;
        EndSl;

      /End-Free

     P RtvUsrAud       E
