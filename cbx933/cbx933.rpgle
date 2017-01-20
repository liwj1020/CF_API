     **
     **  Program . . : CBX933
     **  Description : Start journal for library - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program will, depending on object type, run the STRJRNPF
     **    or STRJRNOBJ command for the objects defined by the input
     **    parameters.
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX933 )
     **                DbgView( *NONE )
     **                Aut( *USE )
     **
     **    CrtPgm      Pgm( CBX933 )
     **                Module( CBX933 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )
     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a
     **-- Global variables:
     D Idx             s             10i 0
     D ObjCntSlt       s             10i 0 Inz( *Zero )
     D ObjCntIgn       s             10i 0 Inz( *Zero )
     **
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( %Elem( LstApi.KeyFld ))
     D  KeyFld                       10i 0 Dim( 2 )
     D  ObjTyp                       10a
     **-- Object information:
     D ObjInf          Ds          4096    Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     D  ObjTyp                       10a
     D  InfSts                        1a
     D                                1a
     D  FldNbrRtn                    10i 0
     D  Data                               Like( KeyInf )
     **-- Key information:
     D KeyInf          Ds                  Qualified  Based( pKeyInf )
     D  FldInfLen                    10i 0
     D  KeyFld                       10i 0
     D  DtaTyp                        1a
     D                                3a
     D  DtaLen                       10i 0
     D  Data                        256a
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  Handle                        4a
     D  RcdLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D  LstSts                        1a
     D                                1a
     D  InfLen                       10i 0
     D  Rcd1                         10i 0
     D                               40a
     **-- Sort information:
     D SrtInf          Ds                  Qualified
     D  NbrKeys                      10i 0 Inz( 0 )
     D  SrtInf                       12a   Dim( 10 )
     D   KeyFldOfs                   10i 0 Overlay( SrtInf:  1 )
     D   KeyFldLen                   10i 0 Overlay( SrtInf: *Next )
     D   KeyFldTyp                    5i 0 Overlay( SrtInf: *Next )
     D   SrtOrd                       1a   Overlay( SrtInf: *Next )
     D   Rsv                          1a   Overlay( SrtInf: *Next )
     **-- Authority control:
     D AutCtl          Ds                  Qualified
     D  AutFmtLen                    10i 0 Inz( %Size( AutCtl ))
     D  CalLvl                       10i 0 Inz( 0 )
     D  DplObjAut                    10i 0 Inz( 0 )
     D  NbrObjAut                    10i 0 Inz( 0 )
     D  DplLibAut                    10i 0 Inz( 0 )
     D  NbrLibAut                    10i 0 Inz( 0 )
     D                               10i 0 Inz( 0 )
     D  ObjAut                       10a   Dim( 10 )
     D  LibAut                       10a   Dim( 10 )
     **-- Selection control:
     D SltCtl          Ds
     D  SltFmtLen                    10i 0 Inz( %Size( SltCtl ))
     D  SltOmt                       10i 0 Inz( 0 )
     D  DplSts                       10i 0 Inz( 20 )
     D  NbrSts                       10i 0 Inz( 1 )
     D                               10i 0 Inz( 0 )
     D  Status                        1a   Inz( '*' )
     **-- Object information key fields:
     D KeyFld          Ds                  Qualified
     D  ExtObjAtr                    10a
     D  JrnSts                        1a
     **-- Open list of objects:
     D LstObjs         Pr                  ExtPgm( 'QGYOLOBJ' )
     D  LoRcvVar                  65535a          Options( *VarSize )
     D  LoRcvVarLen                  10i 0 Const
     D  LoLstInf                     80a
     D  LoNbrRcdRtn                  10i 0 Const
     D  LoSrtInf                   1024a   Const  Options( *VarSize )
     D  LoObjNam_q                   20a   Const
     D  LoObjTyp                     10a   Const
     D  LoAutCtl                   1024a   Const  Options( *VarSize )
     D  LoSltCtl                   1024a   Const  Options( *VarSize )
     D  LoNbrKeyRtn                  10i 0 Const
     D  LoKeyFld                     10i 0 Const  Options( *VarSize )  Dim( 32 )
     D  LoError                    1024a          Options( *VarSize )
     **
     D  LoJobIdInf                  256a          Options( *NoPass: *VarSize )
     D  LoJobIdFmt                    8a   Const  Options( *NoPass )
     **
     D  LoAspCtl                    256a          Options( *NoPass: *VarSize )
     **-- Get list entry:
     D GetLstEnt       Pr                  ExtPgm( 'QGYGTLE' )
     D  GlRcvVar                  65535a          Options( *VarSize )
     D  GlRcvVarLen                  10i 0 Const
     D  GlHandle                      4a   Const
     D  GlLstInf                     80a
     D  GlNbrRcdRtn                  10i 0 Const
     D  GlRtnRcdNbr                  10i 0 Const
     D  GlError                    1024a          Options( *VarSize )
     **-- Close list:
     D CloseLst        Pr                  ExtPgm( 'QGYCLST' )
     D  ClHandle                      4a   Const
     D  ClError                    1024a          Options( *VarSize )
     **-- Process commands:
     D PrcCmds         Pr                  ExtPgm( 'QCAPCMD' )
     D  PcSrcCmd                  32702a   Const  Options( *VarSize )
     D  PcSrcCmdLen                  10i 0 Const
     D  PcOptCtlBlk                  20a   Const
     D  PcOptCtlBlkLn                10i 0 Const
     D  PcOptCtlBlkFm                 8a   Const
     D  PcChgCmd                  32767a          Options( *VarSize )
     D  PcChgCmdLen                  10i 0 Const
     D  PcChgCmdLenAv                10i 0
     D  PcError                   32767a          Options( *VarSize )
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

     **-- Process command:
     D PrcCmd          Pr             7a
     D  CmdStr                     1024a   Const  Varying
     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying

     D CBX933          Pr
     D  PxLibNam                     10a
     D  PxJrnNam                           LikeDs( ObjNam_q )
     D  PxObjNam                     10a
     D  PxObjTyp                     10a
     D  PxImages                      6a
     D  PxOmtJrnE                    10a
     **
     D CBX933          Pi
     D  PxLibNam                     10a
     D  PxJrnNam                           LikeDs( ObjNam_q )
     D  PxObjNam                     10a
     D  PxObjTyp                     10a
     D  PxImages                      6a
     D  PxOmtJrnE                    10a

      /Free

        LstApi.KeyFld(1) = 202;
        LstApi.KeyFld(2) = 513;

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*FILE';
          LstApi.ObjTyp = '*FILE';

          ExSr  PrcObjLst;
        EndIf;

        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAQ';
          LstApi.ObjTyp = '*DTAQ';

          ExSr  PrcObjLst;
        EndIf;

        If  PxObjTyp = '*ALL'  Or  PxObjTyp = '*DTAARA';
          LstApi.ObjTyp = '*DTAARA';

          ExSr  PrcObjLst;
        EndIf;

        SndCmpMsg( 'Command completed normally. ' + %Char( ObjCntSlt ) +
                   ' objects processed. '         + %Char( ObjCntIgn ) +
                   ' objects not processed.'
                 );

        *InLr = *On;
        Return;


        BegSr  PrcObjLst;

          LstApi.RtnRcdNbr = 1;

          LstObjs( ObjInf
                 : %Size( ObjInf )
                 : LstInf
                 : 1
                 : SrtInf
                 : PxObjNam + PxLibNam
                 : LstApi.ObjTyp
                 : AutCtl
                 : SltCtl
                 : LstApi.NbrKeyRtn
                 : LstApi.KeyFld
                 : ERRC0100
                 );

          If  ERRC0100.BytAvl = *Zero;

            DoW  LstInf.LstSts <> '2'  Or
                 LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

              ExSr  GetKeyDta;
              ExSr  StrJrnObj;

              LstApi.RtnRcdNbr = LstApi.RtnRcdNbr + 1;

              GetLstEnt( ObjInf
                       : %Size( ObjInf )
                       : LstInf.Handle
                       : LstInf
                       : 1
                       : LstApi.RtnRcdNbr
                       : ERRC0100
                       );

              If  ERRC0100.BytAvl > *Zero;
                Leave;
              EndIf;
            EndDo;

            CloseLst( LstInf.Handle: ERRC0100 );
          EndIf;

        EndSr;

        BegSr  GetKeyDta;

          pKeyInf = %Addr( ObjInf.Data );

          For  Idx = 1  To ObjInf.FldNbrRtn;

            Select;
            When  KeyInf.KeyFld = 202;
              KeyFld.ExtObjAtr = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );

            When  KeyInf.KeyFld = 513;
              KeyFld.JrnSts = %Subst( KeyInf.Data: 1: KeyInf.DtaLen );
            EndSl;

            If  Idx < ObjInf.FldNbrRtn;
              pKeyInf = pKeyInf + KeyInf.FldInfLen;
            EndIf;
          EndFor;

        EndSr;

        BegSr  StrJrnObj;

          Select;
          When  ObjInf.ObjTyp = '*FILE'  And  KeyFld.ExtObjAtr = 'PF';

            If  KeyFld.JrnSts = '0';

              PrcCmd( 'STRJRNPF FILE(' + %Trim( ObjInf.ObjLib )   + '/'  +
                                         %Trim( ObjInf.ObjNam )   + ') ' +
                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
                                         %Trim( PxJrnNam.ObjNam ) + ') ' +
                             'IMAGES(' + %Trim( PxImages  )     + ') ' +
                            'OMTJRNE(' + %Trim( PxOmtJrnE )     + ') '
                    );

              ObjCntSlt += 1;
            Else;
              ObjCntIgn += 1;
            EndIf;

          When  ObjInf.ObjTyp = '*DTAQ';

            If  KeyFld.JrnSts = '0';

              PrcCmd( 'STRJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
                                         %Trim( ObjInf.ObjNam )   + ') ' +
                            'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') ' +
                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
                                         %Trim( PxJrnNam.ObjNam ) + ') '
                    );

              ObjCntSlt += 1;
            Else;
              ObjCntIgn += 1;
            EndIf;

          When  ObjInf.ObjTyp = '*DTAARA';

            If  KeyFld.JrnSts = '0';

              PrcCmd( 'STRJRNOBJ OBJ(' + %Trim( ObjInf.ObjLib )   + '/'  +
                                         %Trim( ObjInf.ObjNam )   + ') ' +
                            'OBJTYPE(' + %Trim( ObjInf.ObjTyp )   + ') ' +
                                'JRN(' + %Trim( PxJrnNam.ObjLib ) + '/'  +
                                         %Trim( PxJrnNam.ObjNam ) + ') ' +
                             'IMAGES(' + %Trim( PxImages  )     + ') '
                    );

              ObjCntSlt += 1;
            Else;
              ObjCntIgn += 1;
            EndIf;
          EndSl;

        EndSr;

      /End-Free

     **-- Process command:  --------------------------------------------------**
     P PrcCmd          B
     D                 Pi             7a
     D  PxCmdStr                   1024a   Const  Varying
     **-- Local variables:
     D CpOptCtlBlk     Ds
     D  CpTypPrc                     10i 0 Inz( 2 )
     D  CpDBCS                        1a   Inz( '0' )
     D  CpPmtAct                      1a   Inz( '2' )
     D  CpCmdStx                      1a   Inz( '0' )
     D  CpMsgRtvKey                   4a   Inz( *Allx'00' )
     D  CpRsv                         9a   Inz( *Allx'00' )
     **
     D CpChgCmd        s          32767a
     D CpChgCmdAvl     s             10i 0

      /Free

        PrcCmds( PxCmdStr
               : %Len( PxCmdStr )
               : CpOptCtlBlk
               : %Size( CpOptCtlBlk )
               : 'CPOP0100'
               : CpChgCmd
               : %Size( CpChgCmd )
               : CpChgCmdAvl
               : ERRC0100
               );

        If  ERRC0100.BytAvl > *Zero;
          Return  ERRC0100.MsgId;
        Else;
          Return  *Blanks;
        EndIf;

      /End-Free

     P PrcCmd          E
     **-- Send completion message:  ------------------------------------------**
     P SndCmpMsg       B
     D                 Pi            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( 'CPF9897'
                 : 'QCPFMSG   *LIBL'
                 : PxMsgDta
                 : %Len( PxMsgDta )
                 : '*COMP'
                 : '*PGMBDY'
                 : 1
                 : MsgKey
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          Return  -1;

        Else;
          Return  0;

        EndIf;

      /End-Free

     **
     P SndCmpMsg       E
