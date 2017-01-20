     **
     **  Program . . : CBX964E
     **  Description : Work with Server Shares - UIM Exit Program
     **  Author  . . : Carsten Flensburg
     **  Published . : Club Tech iSeries Systems Management Tips Newsletter
     **
     **
     **
     **  Compile options:
     **    CrtRpgMod  Module( CBX964E )
     **               DbgView( *LIST )
     **
     **    CrtPgm     Pgm( CBX964E )
     **               Module( CBX964E )
     **               ActGrp( *CALLER )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a

     **-- UIM constants:
     D RES_OK          c                   0
     D RES_ERR         c                   1

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

     **-- Remove list entry:
     D RmvLstEnt       Pr                  ExtPgm( 'QUIRMVLE' )
     D  AppHdl                        8a   Const
     D  LstNam                       10a   Const
     D  ExtOpt                        1a   Const
     D  LstEntHdl                     4a
     D  Error                     32767a          Options( *VarSize )

     **-- Entry parameters:
     D CBX964E         Pr
     D  PxUimExit                          LikeDs( UimExit )
     **
     D CBX964E         Pi
     D  PxUimExit                          LikeDs( UimExit )

      /Free

        If  PxUimExit.TypCall = 5;
          Type5 = PxUimExit;

          If  Type5.ActRes = RES_OK;

            If  Type5.OptNbr = 4;
              ExSr  DltLstEnt;
            EndIf;
          EndIf;
        EndIf;

        Return;


        BegSr  DltLstEnt;

          RmvLstEnt( Type5.AppHdl
                   : 'DTLLST'
                   : 'Y'
                   : Type5.LstEntHdl
                   : ERRC0100
                   );

        EndSr;

      /End-Free
