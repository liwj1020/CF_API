     **
     **  Program . . : CBX9281
     **  Description : Check user special authority - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Authority and security restrictions:
     **    To successfully run this program *ALLOBJ special authority is
     **    necessary.  The required authority can be obtained by means of
     **    adopted authority:
     **
     **    -  Change the program object's USRPRF attribute to *OWNER using
     **       the CHGPGM command.
     **
     **    -  Change the program object owner to QSECOFR using the CHGOBJOWN
     **       command.
     **
     **    If you successfully follow the compile and setup instructions below,
     **    the program will be capable of performing the necessary operations.
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX9281 )
     **                DbgView( *NONE )
     **                Aut( *USE )
     **
     **    CrtPgm      Pgm( CBX9281 )
     **                Module( CBX9281 )
     **                ActGrp( *NEW )
     **                UsrPrf( *OWNER )
     **                Aut( *USE )
     **
     **    ChgObjOwn   Obj( CBX9281 )
     **                ObjType( *PGM )
     **                NewOwn( QSECOFR )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- Global variables:
     D AutFlg          s              1a
     **
     D SpcAut          Ds                  Qualified
     D  NbrAut                        5i 0
     D  AutVal                       10a   Dim( 8 )
     **-- Global constants:
     D ADP_PRV_INVLVL  c                   1

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      512a

     **-- Check user special authority
     D ChkUsrSpcAut    Pr                  ExtPgm( 'QSYCUSRS' )
     D  CsAutInf                      1a
     D  CsUsrPrf                     10a   Const
     D  CsSpcAut                     10a   Const  Dim( 8 )  Options( *VarSize )
     D  CsNbrAut                     10i 0 Const
     D  CsCalLvl                     10i 0 Const
     D  CsError                   32767a          Options( *VarSize )
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
     D  PxMsgDta                    512a   Const  Varying

     D CBX9281         Pr
     D  PxUsrPrf                     10a
     D  PxSpcAut                           LikeDs( SpcAut )
     D  PxAutFlg                      1a
     **
     D CBX9281         Pi
     D  PxUsrPrf                     10a
     D  PxSpcAut                           LikeDs( SpcAut )
     D  PxAutFlg                      1a

      /Free

        ChkUsrSpcAut( AutFlg
                    : PxUsrPrf
                    : PxSpcAut.AutVal
                    : PxSpcAut.NbrAut
                    : ADP_PRV_INVLVL
                    : ERRC0100
                    );

        If  ERRC0100.BytAvl > *Zero;

          SndEscMsg( ERRC0100.MsgId
                   : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - 16 )
                   );

        Else;
          PxAutFlg = AutFlg;
        EndIf;

        *InLr = *On;
        Return;

      /End-Free

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
