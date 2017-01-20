     **
     **  Program . . : CBX958E
     **  Description : Work with Netserver User - UIM Exit Program
     **  Author  . . : Carsten Flensburg
     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX958E )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX958E )
     **               Module( CBX958E )
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
     **-- UIM variables:
     D UIM             Ds                  Qualified
     D  EntHdl                        4a
     **-- UIM constants:
     D RES_OK          c                   0
     D RES_ERR         c                   1

     **-- UIM List entry:
     D LstEnt          Ds                  Qualified
     D  Option                        5i 0
     D  NetUsr                       10a
     D  UsrSts                       10a
     D  UsrTxt                       50a
     **-- UIM exit program interfaces:
     **-- Parm interface:
     D UimExit         Ds            70    Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     **-- Action list option/Pull-down field choice:
     D Type5           Ds                  Qualified
     D  StcLvl                       10i 0
     D                                8a
     D  TypCall                      10i 0
     D  AppHdl                        8a
     D  PnlNam                       10a
     D  LstNam                       10a
     D  LstEntHdl                     4a
     D  OptNbr                       10i 0
     D  FncQlf                       10i 0
     D  ActRes                       10i 0
     D  PdwFldNam                    10a

     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QUIGETLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  PosOpt                        4a   Const
     D  CpyOpt                        1a   Const
     D  SltCri                       20a   Const
     D  SltHdl                        4a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )
     **-- Update list entry:
     D UpdLstEnt       Pr                  ExtPgm( 'QUIUPDLE' )
     D  AppHdl                        8a   Const
     D  VarBuf                    32767a   Const  Options( *VarSize )
     D  VarBufLen                    10i 0 Const
     D  VarRcdNam                    10a   Const
     D  LstNam                       10a   Const
     D  Option                        4a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )
     **-- Remove list entry:
     D RmvLstEnt       Pr                  ExtPgm( 'QUIRMVLE' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )

     **-- Entry parameters:
     D CBX958E         Pr
     D  PxUimExit                          LikeDs( UimExit )
     **
     D CBX958E         Pi
     D  PxUimExit                          LikeDs( UimExit )

      /Free

        If  PxUimExit.TypCall = 5;
          Type5 = PxUimExit;

          If  Type5.ActRes = RES_OK;

            If  Type5.OptNbr = 1;
              ExSr  ChgLstEnt;
            EndIf;
          EndIf;
        EndIf;

        Return;


        BegSr  ChgLstEnt;

          GetLstEnt( Type5.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'HNDL'
                   : 'Y'
                   : *Blanks
                   : Type5.LstEntHdl
                   : 'N'
                   : UIM.EntHdl
                   : ERRC0100
                   );

          LstEnt.UsrSts = '*ENABLED';

          UpdLstEnt( Type5.AppHdl
                   : LstEnt
                   : %Size( LstEnt )
                   : 'DTLRCD'
                   : 'DTLLST'
                   : 'SAME'
                   : UIM.EntHdl
                   : ERRC0100
                   );

        EndSr;

        BegSr  DltLstEnt;

          RmvLstEnt( Type5.AppHdl
                   : 'DTLLST'
                   : 'Y'
                   : Type5.LstEntHdl
                   : ERRC0100
                   );

        EndSr;

      /End-Free
