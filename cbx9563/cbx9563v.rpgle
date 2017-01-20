     **
     **  Program . . : CBX2063V
     **  Description : Display Index Entry Count - VCP
     **  Author  . . : Carsten Flensburg
     **  Published . : System iNetwork Programming Tips Newsletter
     **  Date  . . . : July 23, 2009
     **
     **
     **  Program description:
     **    This program checks the existence of the specified object.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX2063V )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX2063V )
     **              Module( CBX2063V )
     **              BndSrvPgm( CBX205 )
     **              ActGrp( *NEW )
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
     D  MsgDta                      128a

     **-- Global variables:
     D TypHex          s              2a
     **-- Global constants:
     D NULL            c                   ''

     **-- Convert object type to hex:
     D CvtObjTyp       Pr                  ExtPgm( 'QLICVTTP' )
     D  CnvOpt                       10a   Const
     D  ObjSym                       10a   Const
     D  ObjHex                        2a
     D  Error                     32767a          Options( *VarSize )
     **-- Retrieve system value:
     D RtvSysVal       Pr                  ExtPgm( 'QWCRSVAL' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  NbrSysVal                    10i 0 Const
     D  SysVal                       10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  Error                     32767a          Options( *VarSize )

     **-- Check object existence:
     D ChkObj          Pr              n
     D  PxObjNam_q                   20a   Const
     D  PxObjTyp                     10a   Const
     **-- Retrieve message:
     D RtvMsg          Pr          4096a   Varying
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Get hexadecimal object type:
     D GetHexTyp       Pr             1a
     D  PxIdxTyp                     10a   Const
     **-- Get system value:
     D GetSysVal       Pr          4096a   Varying
     D  PxSysVal                     10a   Const

     **-- Entry parameters:
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a
     **
     D CBX2063V        Pr
     D  PxIdxNam_q                         LikeDs( ObjNam_q )
     D  PxIdxTyp                     10a
     **
     D CBX2063V        Pi
     D  PxIdxNam_q                         LikeDs( ObjNam_q )
     D  PxIdxTyp                     10a

      /Free

        Select;
        When  GetSysVal( 'QSECURITY' ) >= '40';
          SndDiagMsg( 'CPD0006'
                    : '0000' +
                      'This command will only run on ' +
                      'on security level 30 or lower.'
                    );

          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );

        When  GetHexTyp( PxIdxTyp ) =  x'00';

          SndDiagMsg( 'CPD0006'
                    : '0000' +
                      RtvMsg( 'CPF219E': %Subst( PxIdxTyp: 2 ))
                    );

          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );

        When  GetHexTyp( PxIdxTyp ) <> x'0E';

          SndDiagMsg( 'CPD0006'
                    : '0000' +
                      RtvMsg( 'CPF2160': %Subst( PxIdxTyp: 2 ))
                    );

          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );

        When  ChkObj( PxIdxNam_q: PxIdxTyp ) = *Off;

          SndDiagMsg( 'CPD0006'
                    : '0000' +
                      RtvMsg( 'CPF2105': PxIdxNam_q + %Subst( PxIdxTyp: 2 ))
                    );

          SndEscMsg( 'CPF0002': 'QCPFMSG': '' );
        EndSl;

        *InLr = *On;
        Return;

      /End-Free

     **-- Get hexadecimal object type:
     P GetHexTyp       B
     D                 Pi             1a
     D  PxIdxTyp                     10a   Const

     **-- Local variables:
     D TypHex          s              2a

      /Free

        CvtObjTyp( '*SYMTOHEX': PxIdxTyp: TypHex: ERRC0100 );

        If  ERRC0100.BytAvl > *Zero;
          Return  x'00';

        Else;
          Return  %Subst( TypHex: 1: 1 );
        EndIf;

      /End-Free

     P GetHexTyp       E
     **-- Get system value:
     P GetSysVal       B                   Export
     D                 Pi          4096a   Varying
     D  PxSysVal                     10a   Const

     **-- Local variables:
     D Idx             s             10i 0
     D SysVal          s           4096a   Varying
     **
     D ApiPrm          Ds                  Qualified
     D  RtnVarLen                    10i 0
     D  SysValNbr                    10i 0 Inz( %Elem( ApiPrm.SysVal ))
     D  SysVal                       10a   Dim( 1 )
     **
     D RtnVar          Ds                  Qualified
     D  RtnVarNbr                    10i 0
     D  RtnVarOfs                    10i 0 Dim( %Elem( ApiPrm.SysVal ))
     D  RtnVarDta                  4096a
     **
     D SysValInf       Ds                  Qualified  Based( pSysVal )
     D  SysValKwd                    10a
     D  DtaTyp                        1a
     D  InfSts                        1a
     D  DtaLen                       10i 0
     D  Dta                        4096a
     D  DtaInt                       10i 0 Overlay( Dta )

      /Free

        ApiPrm.RtnVarLen = %Elem( ApiPrm.SysVal ) * 24 + %Size( SysVal ) + 4;
        ApiPrm.SysVal(1) = PxSysVal;

        RtvSysVal( RtnVar
                 : ApiPrm.RtnVarLen
                 : ApiPrm.SysValNbr
                 : ApiPrm.SysVal
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          SysVal = NULL;

        Else;
          For  Idx = 1  to RtnVar.RtnVarNbr;

            pSysVal = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);

            If  SysValInf.SysValKwd = PxSysVal;

              Select;
              When  SysValInf.DtaTyp = 'C';
                SysVal = %Subst( SysValInf.Dta: 1: SysValInf.DtaLen );

              When  SysValInf.DtaTyp = 'B';
                SysVal = %Char( SysValInf.DtaInt );

              Other;
                SysVal = NULL;
              EndSl;
            EndIf;

          EndFor;
        EndIf;

        Return  SysVal;

      /End-Free

     P GetSysVal       E
