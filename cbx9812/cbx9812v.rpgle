     **
     **  Program . . : CBX9812V
     **  Description : Change User Time Zone Information - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Systems Management Tips Newsletter
     **
     **
     **  Program description:
     **    Validity checking program for the Change User Query Attributes
     **    (CHGUSRQRYA) command.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX9812V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX9812V )
     **              Module( CBX9812V )
     **              BndSrvPgm( CBX980 )
     **              ActGrp( *NEW )
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
     D ADP_PRV_INVLVL  c                   1
     **-- Global variables:
     D AutFlg          s              1a
     D SpcAut          s             10a   Dim( 8 )
 
     **-- Check special authority
     D ChkSpcAut       Pr                  ExtPgm( 'QSYCUSRS' )
     D  AutInf                        1a
     D  UsrPrf                       10a   Const
     D  SpcAut                       10a   Const  Dim( 8 )  Options( *VarSize )
     D  NbrAut                       10i 0 Const
     D  CalLvl                       10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFq                        20a   Const
     D  MsgDta                      128a   Const
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkE                      10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                      1024a          Options( *VarSize )
 
     **-- Check object existence:
     D ChkObj          Pr              n
     D  PxObjNam                     10a   Const
     D  PxObjLib                     10a   Const
     D  PxObjTyp                     10a   Const
     **-- Verify user query attributes:
     D VfyUsrQryA      Pr              n
     D  PxUsrPrf                     10a   Const
 
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
 
     **-- Entry parameters:
     D Degree          Ds                  Qualified
     D  NbrElem                       5i 0
     D  ElemVal                       5i 0 Dim( 2 )
     **
     D CBX9812V        Pr
     D  PxUsrPrf                     10a
     D  PxQryIntLmt                  10i 0
     D  PxQryIntAlw                  10a
     D  PxQryOptLib                  10a
     **
     D CBX9812V        Pi
     D  PxUsrPrf                     10a
     D  PxQryIntLmt                  10i 0
     D  PxQryIntAlw                  10a
     D  PxQryOptLib                  10a
 
      /Free
 
        SpcAut( 1 ) = '*SECADM';
        SpcAut( 2 ) = '*ALLOBJ';
 
        ChkSpcAut( AutFlg
                 : PgmSts.UsrPrf
                 : SpcAut
                 : 2
                 : ADP_PRV_INVLVL
                 : ERRC0100
                 );
 
        If  ERRC0100.BytAvl > *Zero  Or AutFlg = 'N';
          SndDiagMsg( 'CPD0006'
                    : '0000Special authority *SECADM and *ALLOBJ required.'
                    );
 
          SndEscMsg( 'CPF0002': '' );
        EndIf;
 
        If  ChkObj( PxUsrPrf: '*LIBL': '*USRPRF' ) = *Off;
          SndDiagMsg( 'CPD0006'
                    : '0000User profile '   +
                       %Trim( PxUsrPrf )    +
                      ' does not exist.'
                    );
 
          SndEscMsg( 'CPF0002': '' );
        EndIf;
 
        If  VfyUsrQryA( PxUsrPrf ) = *Off;
          SndDiagMsg( 'CPD0006'
                    : '0000User profile '   +
                       %Trim( PxUsrPrf )    +
                      ' does not have user query attributes registered.'
                    );
 
          SndEscMsg( 'CPF0002': '' );
        EndIf;
 
        If  %Scan( '*': PxQryOptLib ) = *Zero;
 
          If  ChkObj( PxQryOptLib: '*LIBL': '*LIB' ) = *Off;
            SndDiagMsg( 'CPD0006'
                      : '0000Library '   +
                         %Trim( PxQryOptLib )    +
                        ' does not exist.'
                      );
 
            SndEscMsg( 'CPF0002': '' );
          EndIf;
        EndIf;
 
 
        *InLr = *On;
        Return;
 
      /End-Free
 
     **-- Send diagnostic message:
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
     **-- Send escape message:
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
