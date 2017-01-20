     **-----------------------------------------------------------------------**
     **
     **  Program . . : CBX918S
     **  Description : Retrieve & set encrypted user password - services
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Compile options required:
     **
     **    CrtRpgMod  Module( CBX918S )
     **               DbgView( *NONE )
     **
     **    CrtSrvPgm  SrvPgm( CBX918S )
     **               Module( CBX918S )
     **               Export( *ALL )
     **               ActGrp( *CALLER )
     **
     **    - Ensure that service program CBX918S uses adopted authority,
     **      if necessary run the following command:
     **
     **        ChgSrvPgm  SrvPgm( CLIB/CBX918S )  UseAdpAut( *YES )
     **
     **
     **-- Header Specifications:  --------------------------------------------**
     H NoMain  Option( *SrcStmt )  BndDir( 'QC2LE' )
     **-- API Error Data Structure:
     D ApiError        Ds                  Inz
     D  AeBytPro                     10i 0 Inz( %Size( ApiError ))
     D  AeBytAvl                     10i 0
     D  AeMsgId                       7a
     D                                1a
     D  AeMsgDta                    256a
     **-- Product information:
     D PRDR0100        Ds                  Qualified
     D  BytPrv                       10i 0
     D  BytRtn                       10i 0
     D                               10i 0
     D  PrdId                         7a
     D  Release                       6a
     D  PrdOpt                        4a
     D  LodId                         4a
     D  LodTyp                       10a
     D  SymLodStt                    10a
     D  LodErrInd                    10a
     D  LodStt                        2a
     D  SupFlg                        1a
     D  RegTyp                        2a
     D  RegVal                       14a
     D                                2a
     D  OfsAddInf                    10i 0
     D  PriLodId                      4a
     D  MinTrgRel                     6a
     D  MinVrmBas                     6a
     D  RqmBasOpt                     1a
     D  Level                         3a
     **-- Copy memory:
     D memcpy          Pr              *   ExtProc( 'memcpy' )
     D  pOutMem                        *   Value
     D  pInpMem                        *   Value
     D  iMemSiz                      10u 0 Value
     **-- Get system value:
     D GetSysVal       Pr                  ExtPgm( 'QWCRSVAL' )
     D  GsRcvVar                  32767a          Options( *VarSize )
     D  GsRcvVarLen                  10i 0 Const
     D  GsNbrSysVal                  10i 0 Const
     D  GsSysVal                     10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  GsError                   32767a          Options( *VarSize )
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RnRcvVar                  32767a          Options( *VarSize )
     D  RnRcvVarLen                  10i 0 Const
     D  RnNbrNetAtr                  10i 0 Const
     D  RnNetAtr                     10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  RnError                   32767a          Options( *VarSize )
     **-- Retrieve product information:
     D RtvPrdInf       Pr                  ExtPgm( 'QSZRTVPR' )
     D  PiDta                              Like( PRDR0100 )
     D  PiDtaLen                     10i 0 Const
     D  PiFmtNam                      8a   Const
     D  PiPrdInf                     27a   Const
     D  PiError                    1024a         Options( *VarSize )
     **-- Retrieve user information:
     D RtvUsrInf       Pr                  ExtPgm( 'QSYRUSRI' )
     D  RuRcvVar                  32767a          Options( *VarSize )
     D  RuRcvVarLen                  10i 0 Const
     D  RuFmtNam                     10a   Const
     D  RuUsrPrf                     10a   Const
     D  RuError                   32767a          Options( *VarSize )
     **-- Convert date & time:
     D CvtDtf          Pr                  ExtPgm( 'QWCCVTDT' )
     D  CdInpFmt                     10a   Const
     D  CdInpVar                     17a   Const  Options( *VarSize )
     D  CdOutFmt                     10a   Const  Options( *VarSize )
     D  CdOutVar                     17a   Const  Options( *VarSize )
     D  CdError                   32767a          Options( *VarSize )
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
     D  SmCcsId                      10i 0 Const  Options( *NoPass )
     **
     **-- Get system password level:
     D GetPwdLvl       Pr            10i 0
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying
     **-- Get system release level:
     D GetRlsLvl       Pr             6a
     **-- Get user last password change timestamp:
     D GetPwdDts       Pr              z
     D  PxUsrPrf                     10a   Value
     **-- Get user class:
     D GetUsrCls       Pr            10a   Varying
     D  PxUsrPrf                     10a   Value
     **-- Send error message:
     D SndErrMsg       Pr            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     **-- Get system password level:
     P GetPwdLvl       B                   Export
     D                 Pi            10i 0
     **
     **-- Local variables:
     D Idx             s             10i 0
     D PwdLvl          s             10i 0
     **
     D RsRtnVarLen     s             10i 0
     D RsSysValNbr     s             10i 0 Inz( %Elem( RsSysVal ))
     D RsSysVal        s             10a   Dim( 1 )
     ***
     D RsRtnVar        Ds          1024
     D  RsRtnVarNbr                  10i 0
     D  RsRtnVarOfs                  10i 0 Dim( %Elem( RsSysVal ))
     D  RsRtnVarDta                1008a
     **
     D RsSysValInf     Ds                  Based( pSysVal )
     D  RsSysValKwd                  10a
     D  RsDtaTyp                      1a
     D  RsInfSts                      1a
     D  RsDtaLen                     10i 0
     D  RsDta                       512a

      /Free

        RsRtnVarLen = %Elem( RsSysVal ) * 24 + %Size( PwdLvl ) + 4;
        RsSysVal(1) = 'QPWDLVL';

        GetSysVal( RsRtnVar
                 : RsRtnVarLen
                 : RsSysValNbr
                 : RsSysVal
                 : ApiError
                 );

        If  AeBytAvl > *Zero;
          PwdLvl = -1;

        Else;
          For  Idx = 1  to RsRtnVarNbr;

            pSysVal = %Addr( RsRtnVar ) + RsRtnVarOfs(Idx);

            If  RsSysValKwd = 'QPWDLVL';
              MemCpy( %Addr( PwdLvl ): %Addr( RsDta ): %Size( PwdLvl ));
            EndIf;

          EndFor;
        EndIf;

        Return  PwdLvl;

      /End-Free

     P GetPwdLvl       E
     **-- Get system name:  --------------------------------------------------**
     P GetSysNam       B                   Export
     D                 Pi             8a   Varying
     **
     **-- Local variables:
     D Idx             s             10i 0
     D SysNam          s              8a   Varying
     **
     D RnRtnAtrLen     s             10i 0
     D RnNetAtrNbr     s             10i 0 Inz( %Elem( RnNetAtr ))
     D RnNetAtr        s             10a   Dim( 1 )
     **
     D RnRtnVar        Ds
     D  RnRtnVarNbr                  10i 0
     D  RnRtnVarOfs                  10i 0 Dim( %Elem( RnNetAtr ))
     D  RnRtnVarDta                1024a
     **
     D RnRtnAtr        Ds                  Based( RtnValPtr )
     D  RnAtrNam                     10a
     D  RnDtaTyp                      1a
     D  RnInfSts                      1a
     D  RnAtrLen                     10i 0
     D  RnAtr                      1008a

      /Free

        RnRtnAtrLen = %Elem( RnNetAtr ) * 24 + ( %Size( SysNam )) + 4;

        RnNetAtr(1) = 'SYSNAME';

        RtvNetAtr( RnRtnVar
                 : RnRtnAtrLen
                 : RnNetAtrNbr
                 : RnNetAtr
                 : ApiError
                 );

        If  AeBytAvl > *Zero;
          SysNam = '';

        Else;
          For  Idx = 1  to RnRtnVarNbr;

            RtnValPtr = %Addr( RnRtnVar ) + RnRtnVarOfs(Idx);

            If  RnAtrNam = 'SYSNAME';
              SysNam      = %SubSt( RnAtr: 1: RnAtrLen );
            EndIf;

          EndFor;
        EndIf;

        Return  SysNam;

      /End-Free

     P GetSysNam       E
     **-- Get system release level:  -----------------------------------------**
     P GetRlsLvl       B                   Export
     D                 Pi             6a

      /Free

        RtvPrdInf( PRDR0100
                 : %Size( PRDR0100 )
                 : 'PRDR0100'
                 : '*OPSYS *CUR  0000*CODE    '
                 : ApiError
                 );

        If  AeBytAvl > *Zero;
          PRDR0100.Release = *Blanks;
        EndIf;

        Return  PRDR0100.Release;

      /End-Free

     P GetRlsLvl       E
     **-- Get user last password change timestamp:  --------------------------**
     P GetPwdDts       B                   Export
     D                 Pi              z
     D  PxUsrPrf                     10a   Value
     **
     D PwdChgDts       Ds            17
     D  PcChgDat                      8a
     D  PcChgTim                      6a
     **
     D USRI0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  PwdChgDts                     8a    Overlay( USRI0100: 47 )

      /Free

        RtvUsrInf( USRI0100
                 : %Size( USRI0100 )
                 : 'USRI0100'
                 : PxUsrPrf
                 : ApiError
                 );

        If  AeBytAvl > *Zero;
          Return *LoVal;

        Else;
          CvtDtf( '*DTS'
                : USRI0100.PwdChgDts
                : '*YYMD'
                : PwdChgDts
                : ApiError
                );

          Return  %Date( PcChgDat: *ISO0 ) + %Time( PcChgTim: *HMS0 );
        EndIf;

      /End-Free

     P GetPwdDts       E
     **-- Get user class:  ---------------------------------------------------**
     P GetUsrCls       B                   Export
     D                 Pi            10a   Varying
     D  PxUsrPrf                     10a   Value
     **
     D USRI0200        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  UsrPrf                       10a
     D  UsrCls                       10a   Overlay( USRI0200: 19 )

      /Free

        RtvUsrInf( USRI0200
                 : %Size( USRI0200 )
                 : 'USRI0200'
                 : PxUsrPrf
                 : ApiError
                 );

        If  AeBytAvl > *Zero;
          USRI0200.UsrCls = *Blanks;
        EndIf;

        Return  %Trim( USRI0200.UsrCls );

      /End-Free

     P GetUsrCls       E
     **-- Send error message:  -----------------------------------------------**
     P SndErrMsg       B                   Export
     D                 Pi            10i 0
     D  PxUsrPrf                     10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndMsg( 'CPF9898'
              : 'QCPFMSG   *LIBL'
              : PxMsgDta
              : %Len( PxMsgDta )
              : '*INFO'
              : PxUsrPrf + '*LIBL'
              : 1
              : *Blanks
              : MsgKey
              : ApiError
              );

        If  AeBytAvl > *Zero;
          Return -1;

        Else;
          Return  0;
        EndIf;

      /End-Free

     **
     P SndErrMsg       E
