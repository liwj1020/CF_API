     **
     **  Program . . : CBX938
     **  Description : Print journal receiver information - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Program description:
     **    This program prints a list of the specified journals and their
     **    journal receiver directories.  The list contains information
     **    about journal and journal receiver size and status.
     **
     **
     **  Compile and setup instructions:
     **    CrtRpgMod   Module( CBX938 )
     **                DbgView( *LIST )
     **                Aut( *USE )
     **
     **    CrtPgm      Pgm( CBX938 )
     **                Module( CBX938 )
     **                ActGrp( *NEW )
     **
     **
     **-- Control specification:  --------------------------------------------**
     H Option( *SrcStmt: *NoDebugIo )  DatEdit( *DMY )
     **-- Printer file:
     FQSYSPRT   O    F  132        Printer  InfDs( PrtLinInf )  OflInd( *InOf )
     **-- Printer file information:
     D PrtLinInf       Ds                  Qualified
     D  OvfLin                        5i 0 Overlay( PrtLinInf: 188 )
     D  CurLin                        5i 0 Overlay( PrtLinInf: 367 )
     D  CurPag                        5i 0 Overlay( PrtLinInf: 369 )
     **-- System information:
     D PgmSts         SDs                  Qualified
     D  PgmNam           *Proc
     **-- Global declarations:
     D Idx             s             10u 0
     D ApiRcvSiz       s             10u 0
     **
     D ObjNam_q        Ds
     D  ObjNam                       10a
     D  ObjLib                       10a
     **-- Api error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPro                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0 Inz
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      128a

     **-- Global variables:
     D LstTim          s              6s 0
     D SysNam          s              8a
     D TrlTxt          s             32a
     **-- List header record:
     D HdrRcd          Ds                  Qualified
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  JrnTxt                       50a
     D  JrnTyp                        7a
     D  MsqNam                       10a
     D  MsqLib                       10a
     D  MngRcv                        7a
     D  DltRcv                        4a
     D  RcvOpt                       30a
     D  NbrRcv                       10i 0
     D  RcvSiz                       20i 0
     **-- List record:
     D LstRcd          Ds                  Qualified
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  RcvThh                       10a
     D  RcvSiz                       10i 0
     D  RcvSts                       10a
     D  FstSeq                       10i 0
     D  NbrEnt                       10i 0
     D  AtcDat                        8a
     D  AtcTim                        8a
     D  DtcDat                        8a
     D  DtcTim                        8a
     D  SavDat                        8a
     D  SavTim                        8a
     **-- List API parameters:
     D LstApi          Ds                  Qualified  Inz
     D  RtnRcdNbr                    10i 0
     D  NbrKeyRtn                    10i 0 Inz( 0 )
     D  KeyFld                       10i 0 Dim( 1 )
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
     **-- Journal information:
     D RJRN0100        Ds                  Based( pJrnInf )  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  OfsKeyInf                    10i 0
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  ASP                          10i 0
     D  MsgQnam                      10a
     D  MsgQlib                      10a
     D  MngRcvOpt                     1a
     D  DltRcvOpt                     1a
     D  RsoRit                        1a
     D  RsoMfl                        1a
     D  RsoMo1                        1a
     D  RsoMo2                        1a
     D  Rsv1                          3a
     D  JrnTyp                        1a
     D  RmtJrnTyp                     1a
     D  JrnStt                        1a
     D  JrnDlvMod                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  RdrRcvLib                    10a
     D  JrnTxt                       50a
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv2                          9a
     D  NbrAtcRcv                    10i 0
     D  AtcRcvNam                    10a
     D  AtcRcvLib                    10a
     D  AtcLocSys                     8a
     D  AtcSrcSys                     8a
     D  AtcRcvNamDu                  10a
     D  AtcRcvLibDu                  10a
     D  Rsv3                        192a
     D  NbrKey                       10i 0
     **
     D JrnKey          Ds                  Based( pJrnKey )  Qualified
     D  Key                          10i 0
     D  OfsKeyInf                    10i 0
     D  KeyHdrSecLn                  10i 0
     D  NbrEnt                       10i 0
     D  KeyInfEntLn                  10i 0
     **
     D JrnKeyHdr1      Ds                  Based( pKeyHdr1 )  Qualified
     D  RcvNbrTot                    10i 0
     D  RcvSizTot                    10i 0
     D  RcvSizMtp                    10i 0
     D  Rsv                           8a
     **
     D JrnKeyEnt1      Ds                  Based( pKeyEnt1 )  Qualified
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  RcvNbr                        5a
     D  RcvAtcDts                    13a
     D  RcvSts                        1a
     D  RcvSavDts                    13a
     D  LocJrnSys                     8a
     D  SrcJrnSys                     8a
     D  RcvSiz                       10i 0
     D  Rsv                          56a
     **-- Journal information specification:
     D JrnInfRtv       Ds                  Qualified
     D  NbrVarRcd                    10i 0 Inz( 1 )
     D  VarRcdLen                    10i 0 Inz( 12 )
     D  Key                          10i 0 Inz( 1 )
     D  DtaLen                       10i 0 Inz( 0 )
     **
     D JrnInfRtv2      Ds                  Qualified
     D  NbrVarRcd                    10i 0 Inz( 1 )
     D  VarRcdLen                    10i 0 Inz( 22 )
     D  Key                          10i 0 Inz( 2 )
     D  DtaLen                       10i 0 Inz( %Size( JrnInfRtv2.Dta ))
     D  Dta
     D   JrnObjInf                   10a   Overlay( Dta )
     **
     D JrnInfRtv3      Ds                  Qualified
     D  NbrVarRcd                    10i 0 Inz( 1 )
     D  VarRcdLen                    10i 0 Inz( 60 )
     D  Key                          10i 0 Inz( 3 )
     D  DtaLen                       10i 0 Inz( %Size( JrnInfRtv3.Dta ))
     D  Dta
     D   RdbDirEinf                  18a   Overlay( Dta )
     D   RmtJrnNam                   20a   Overlay( Dta: *Next )
     **-- Receiver information:
     D RRCV0100        Ds                  Qualified
     D  BytRtn                       10i 0
     D  BytAvl                       10i 0
     D  RcvNam                       10a
     D  RcvLib                       10a
     D  JrnNam                       10a
     D  JrnLib                       10a
     D  Thh                          10i 0
     D  Siz                          10i 0
     D  ASP                          10i 0
     D  NbrJrnEnt                    10i 0
     D  MaxEspDtaLn                  10i 0
     D  MaxNulInd                    10i 0
     D  FstSeqNbr                    10i 0
     D  MinEntDtaAr                   1a
     D  MinEntFiles                   1a
     D  Rsv1                          2a
     D  LstSeqNbr                    10i 0
     D  Rsv2                         10i 0
     D  Sts                           1a
     D  MinFxlVal                     1a
     D  RcvMaxOpt                     1a
     D  Rsv3                          4a
     D  AtcDts                       13a
     D   AtcDat                       7a   Overlay( AtcDts: 1 )
     D   AtcTim                       6a   Overlay( AtcDts: 8 )
     D  DtcDts                       13a
     D   DtcDat                       7a   Overlay( DtcDts: 1 )
     D   DtcTim                       6a   Overlay( DtcDts: 8 )
     D  SavDts                       13a
     D   SavDat                       7a   Overlay( SavDts: 1 )
     D   SavTim                       6a   Overlay( SavDts: 8 )
     D  Txt                          50a
     D  PndTrn                        1a
     D  RmtJrnTyp                     1a
     D  LocJrnNam                    10a
     D  LocJrnLib                    10a
     D  LocJrnSys                     8a
     D  LocRcvLib                    10a
     D  SrcJrnNam                    10a
     D  SrcJrnLib                    10a
     D  SrcJrnSys                     8a
     D  SrcRcvLib                    10a
     D  RdcRcvLib                    10a
     D  DuaRcvNam                    10a
     D  DuaRcvLib                    10a
     D  PrvRcvNam                    10a
     D  PrvRcvLib                    10a
     D  PrvRcvNamDu                  10a
     D  PrvRcvLibDu                  10a
     D  NxtRcvNam                    10a
     D  NxtRcvLib                    10a
     D  NxtRcvNamDu                  10a
     D  NxtRcvLibDu                  10a
     D  NbrJrnEntL                   20s 0
     D  MaxEspDtlL                   20s 0
     D  FstSeqNbrL                   20s 0
     D  LstSeqNbrL                   20s 0
     D  AspDevNam                    10a
     D  LocJrnAspGn                  10a
     D  SrcJrnAspGn                  10a
     D  FldJob                        1a
     D  FldUsr                        1a
     D  FldPgm                        1a
     D  FldPgmLib                     1a
     D  FldSysSeq                     1a
     D  FldRmtAdr                     1a
     D  FldThd                        1a
     D  FldLuw                        1a
     D  FldXid                        1a
     D  Rsv4                         21a

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
     **-- Retrieve journal information:
     D RtvJrnInf       Pr                  ExtProc( 'QjoRetrieveJournal-
     D                                     Information' )
     D  JiRcvVar                  65535a         Options( *VarSize )
     D  JiRcvVarLen                  10i 0 Const
     D  JiJrnNam                     20a   Const
     D  JiFmtNam                      8a   Const
     D  JiInfRtv                  65535a   Const Options( *VarSize )
     D  JiError                   32767a         Options( *VarSize: *Omit )
     **-- Retrieve journal receiver information:
     D RtvRcvInf       Pr                  ExtProc( 'QjoRtvJrnReceiver-
     D                                     Information' )
     D  RiRcvVar                  65535a         Options( *VarSize )
     D  RiRcvVarLen                  10i 0 Const
     D  RiRcvNam                     20a   Const
     D  RiFmtNam                      8a   Const
     D  RiError                   32767a         Options( *VarSize: *Omit )
     **-- Retrieve net attribute:
     D RtvNetAtr       Pr                  ExtPgm( 'QWCRNETA' )
     D  RnRcvVar                  32767a          Options( *VarSize )
     D  RnRcvVarLen                  10i 0 Const
     D  RnNbrNetAtr                  10i 0 Const
     D  RnNetAtr                     10a   Const  Dim( 256 )
     D                                            Options( *VarSize )
     D  RnError                   32767a          Options( *VarSize )
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

     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Write detail line:
     D WrtDtlLin       Pr
     **-- Write list header:
     D WrtLstHdr       Pr
     **-- Write detail header:
     D WrtDtlHdr       Pr
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )
     **-- Write list trailer:
     D WrtLstTrl       Pr
     D  PxTrlTxt                     32a   Const
     **-- Get system name:
     D GetSysNam       Pr             8a   Varying

     D CBX938          Pr
     D  PxJrnNam                           LikeDs( ObjNam_q )
     **
     D CBX938          Pi
     D  PxJrnNam                           LikeDs( ObjNam_q )

      /Free

        SrtInf.NbrKeys      = 0;
        SrtInf.KeyFldOfs(1) = 0;
        SrtInf.KeyFldLen(1) = 0;
        SrtInf.KeyFldTyp(1) = 0;
        SrtInf.SrtOrd(1)    = '1';
        SrtInf.Rsv(1)       = x'00';

        LstApi.RtnRcdNbr = 1;

        LstObjs( ObjInf
               : %Size( ObjInf )
               : LstInf
               : 1
               : SrtInf
               : PxJrnNam.ObjNam + PxJrnNam.ObjLib
               : '*JRN'
               : AutCtl
               : SltCtl
               : LstApi.NbrKeyRtn
               : LstApi.KeyFld
               : ERRC0100
               );

        If  ERRC0100.BytAvl = *Zero;

          DoW  LstInf.LstSts <> '2'  Or
               LstInf.RcdNbrTot >= LstApi.RtnRcdNbr;

            ExSr  GetJrnInf;

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

        SndCmpMsg( 'List has been printed.' );

        *InLr = *On;
        Return;


        BegSr GetJrnInf;

          ApiRcvSiz = 10240;
          pJrnInf   = %Alloc( ApiRcvSiz );

          DoU  RJRN0100.BytAvl <= ApiRcvSiz     Or
               ERRC0100.BytAvl  > *Zero;

            If  RJRN0100.BytAvl > ApiRcvSiz;
              ApiRcvSiz  = RJRN0100.BytAvl;
              pJrnInf    = %ReAlloc( pJrnInf: ApiRcvSiz );
            EndIf;

            RtvJrnInf( RJRN0100
                     : ApiRcvSiz
                     : ObjInf.ObjNam + ObjInf.ObjLib
                     : 'RJRN0100'
                     : JrnInfRtv
                     : ERRC0100
                     );
          EndDo;

          If  ERRC0100.BytAvl = *Zero;
            ExSr PrcKeyEnt;
          EndIf;

          DeAlloc  pJrnInf;

        EndSr;

        BegSr PrcKeyEnt;

          pJrnKey  = pJrnInf  + RJRN0100.OfsKeyInf + %Size( RJRN0100.NbrKey );

          pKeyHdr1 = pJrnKey  + JrnKey.OfsKeyInf;
          pKeyEnt1 = pKeyHdr1 + %Size( JrnKeyHdr1 );

          WrtLstHdr();

          For  Idx = 1  to JrnKey.NbrEnt;

            RtvRcvInf( RRCV0100
                     : %Size( RRCV0100 )
                     : JrnKeyEnt1.RcvNam + JrnKeyEnt1.RcvLib
                     : 'RRCV0100'
                     : ERRC0100
                     );

            If  ERRC0100.BytAvl = *Zero;

              WrtDtlLin();
            EndIf;

            If  Idx < JrnKey.NbrEnt;
              Eval pKeyEnt1 = pKeyEnt1 + JrnKey.KeyInfEntLn;
            EndIf;
          EndFor;

          WrtLstTrl( '**  END OF RECEIVER DIRECTORY **' );

        EndSr;

        BegSr  *InzSr;

          LstTim = %Int( %Char( %Time(): *ISO0));
          SysNam = GetSysNam();

        EndSr;


      /End-Free

     **-- Printer file definition:  ------------------------------------------**
     OQSYSPRT   EF           Header         2  2
     O                       UDATE         Y      8
     O                       LstTim              18 '  :  :  '
     O                                           36 'System:'
     O                       SysNam              45
     O                                           82 'Print journal receivers'
     O                                          107 'Program:'
     O                       PgmSts.PgmNam      118
     O                                          126 'Page:'
     O                       PAGE             +   1
     **
     OQSYSPRT   EF           LstHdr         1
     O                                           20 'Journal name . . . :'
     O                       HdrRcd.JrnNam       32
     O                                           60 'Text . . . . . . . :'
     O                       HdrRcd.JrnTxt      112
     OQSYSPRT   EF           LstHdr         1
     O                                           20 '  Library name . . :'
     O                       HdrRcd.JrnLib       34
     O                                           60 'Journal type . . . :'
     O                       HdrRcd.JrnTyp       69
     O                                          100 'Number of receivers . :'
     O                       HdrRcd.NbrRcv 3    112
     OQSYSPRT   EF           LstHdr         1
     O                                           20 'Message queue  . . :'
     O                       HdrRcd.MsqNam       32
     O                                           60 'Manage receivers . :'
     O                       HdrRcd.MngRcv       69
     O                                          100 'Total size (K)  . . . :'
     O                       HdrRcd.RcvSiz 3    122
     OQSYSPRT   EF           LstHdr         2
     O                                           20 '  Library name . . :'
     O                       HdrRcd.MsqLib       34
     O                                           60 'Delete receivers . :'
     O                       HdrRcd.DltRcv       66
     O                                          100 'Receiver options  . . :'
     O                       HdrRcd.RcvOpt      132
     **
     OQSYSPRT   EF           DtlHdr         1
     O                                            8 'Receiver'
     O                                           19 'Library'
     O                                           33 'Threshold'
     O                                           44 'Size (K)'
     O                                           52 'Status'
     O                                           64 'Seq. nbr.'
     O                                           75 'Entries'
     O                                           93 'Attach timestamp'
     O                                          112 'Detach timestamp'
     O                                          129 'Save timestamp'
     **
     OQSYSPRT   EF           DtlLin         1
     O                       LstRcd.RcvNam       10
     O                       LstRcd.RcvLib       22
     O                       LstRcd.RcvThh       33
     O                       LstRcd.RcvSiz 3     44
     O                       LstRcd.RcvSts       56
     O                       LstRcd.FstSeq 3     64
     O                       LstRcd.NbrEnt 3     75
     O                       LstRcd.AtcDat       85
     O                       LstRcd.AtcTim       94
     O                       LstRcd.DtcDat      104
     O                       LstRcd.DtcTim      113
     O                       LstRcd.SavDat      123
     O                       LstRcd.SavTim      132
     **
     OQSYSPRT   EF           LstTrl         1
     O                       TrlTxt              34
     **-- Write detail line:  ------------------------------------------------**
     P WrtDtlLin       B
     D                 Pi

      /Free

        WrtDtlHdr( 3 );

        LstRcd.RcvNam = RRCV0100.RcvNam;
        LstRcd.RcvLib = RRCV0100.RcvLib;
        LstRcd.RcvSiz = RRCV0100.Siz;
        LstRcd.FstSeq = RRCV0100.FstSeqNbr;
        LstRcd.NbrEnt = RRCV0100.NbrJrnEnt;

        If  RRCV0100.Thh = *Zero;
          LstRcd.RcvThh = ' *NONE';
        Else;
          LstRcd.RcvThh = %EditC( RRCV0100.Thh: '3' );
        EndIf;

        Select;
        When  RRCV0100.Sts = '1';
          LstRcd.RcvSts = 'ATTACHED';

        When  RRCV0100.Sts = '2';
          LstRcd.RcvSts = 'ONLINE';

        When  RRCV0100.Sts = '3';
          LstRcd.RcvSts = 'SAVED';

        When  RRCV0100.Sts = '4';
          LstRcd.RcvSts = 'FREED';

        When  RRCV0100.Sts = '5';
          LstRcd.RcvSts = 'PARTIAL';

        Other;
          LstRcd.RcvSts = *Blanks;
        EndSl;

        If  RRCV0100.AtcDts = *Zeros;
          LstRcd.AtcDat = *Blanks;
          LstRcd.AtcTim = *Blanks;
        Else;
          LstRcd.AtcDat = %Char( %Date( RRCV0100.AtcDat: *CYMD0 ): *JOBRUN );
          LstRcd.AtcTim = %Char( %Time( RRCV0100.AtcTim: *HMS0 ): *JOBRUN );
        EndIf;

        If  RRCV0100.DtcDts = *Zeros;
          LstRcd.DtcDat = *Blanks;
          LstRcd.DtcTim = *Blanks;
        Else;
          LstRcd.DtcDat = %Char( %Date( RRCV0100.DtcDat: *CYMD0 ): *JOBRUN );
          LstRcd.DtcTim = %Char( %Time( RRCV0100.DtcTim: *HMS0 ): *JOBRUN );
        EndIf;

        If  RRCV0100.SavDts = *Zeros;
          LstRcd.SavDat = *Blanks;
          LstRcd.SavTim = *Blanks;
        Else;
          LstRcd.SavDat = %Char( %Date( RRCV0100.SavDat: *CYMD0 ): *JOBRUN );
          LstRcd.SavTim = %Char( %Time( RRCV0100.SavTim: *HMS0 ): *JOBRUN );
        EndIf;

        Except  DtlLin;

      /End-Free

     P WrtDtlLin       E
     **-- Write list header:  ------------------------------------------------**
     P WrtLstHdr       B
     D                 Pi

      /Free

        Clear  HdrRcd;

        HdrRcd.JrnNam = RJRN0100.JrnNam;
        HdrRcd.JrnLib = RJRN0100.JrnLib;
        HdrRcd.JrnTxt = RJRN0100.JrnTxt;
        HdrRcd.MsqNam = RJRN0100.MsgQnam;
        HdrRcd.MsqLib = RJRN0100.MsgQlib;
        HdrRcd.NbrRcv = JrnKeyHdr1.RcvNbrTot;
        HdrRcd.RcvSiz = JrnKeyHdr1.RcvSizTot * JrnKeyHdr1.RcvSizMtp;

        Select;
        When  RJRN0100.JrnTyp = '0';
          HdrRcd.JrnTyp = '*LOCAL';

        When  RJRN0100.JrnTyp = '1';
          HdrRcd.JrnTyp = '*REMOTE';
        EndSl;

        Select;
        When  RJRN0100.MngRcvOpt = '0';
          HdrRcd.MngRcv = '*USER';

        When  RJRN0100.MngRcvOpt = '1';
          HdrRcd.MngRcv = '*SYSTEM';
        EndSl;

        Select;
        When  RJRN0100.DltRcvOpt = '0';
          HdrRcd.DltRcv = '*NO';

        When  RJRN0100.DltRcvOpt = '1';
          HdrRcd.DltRcv = '*YES';
        EndSl;

        If  RJRN0100.RsoRit = '1';
          HdrRcd.RcvOpt = '*RMVINTENT';
        EndIf;

        If  RJRN0100.RsoMfl = '1';
          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MINFIXLEN';
        EndIf;

        If  RJRN0100.RsoMo1 = '1';
          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MAXOPT1';
        EndIf;

        If  RJRN0100.RsoMo2 = '1';
          HdrRcd.RcvOpt = %Trim( HdrRcd.RcvOpt ) + ' ' + '*MAXOPT2';
        EndIf;

        HdrRcd.RcvOpt = %TrimL( HdrRcd.RcvOpt );

        Except  Header;
        Except  LstHdr;
        Except  DtlHdr;

      /End-Free

     P WrtLstHdr       E
     **-- Write detail header:  ----------------------------------------------**
     P WrtDtlHdr       B
     D                 Pi
     D  PxOvrFlwRel                  10i 0 Const  Options( *NoPass )

      /Free

        If  PrtLinInf.CurLin > PrtLinInf.OvfLin - PxOvrFlwRel;

          Except  Header;
          Except  DtlHdr;
        EndIf;

      /End-Free

     P WrtDtlHdr       E
     **-- Write list trailer:  -----------------------------------------------**
     P WrtLstTrl       B
     D                 Pi
     D  PxTrlTxt                     32a   Const

      /Free

        TrlTxt = PxTrlTxt;

        Except  LstTrl;

      /End-Free

     P WrtLstTrl       E
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
     **-- Get system name:  --------------------------------------------------**
     P GetSysNam       B
     D                 Pi             8a   Varying
     **
     **-- Local variables:
     D Idx             s             10i 0
     D SysNam          s              8a   Varying
     **
     D RtnAtrLen       s             10i 0
     D NetAtrNbr       s             10i 0 Inz( %Elem( NetAtr ))
     D NetAtr          s             10a   Dim( 1 )
     **
     D RtnVar          Ds                  Qualified
     D  RtnVarNbr                    10i 0
     D  RtnVarOfs                    10i 0 Dim( %Elem( NetAtr ))
     D  RtnVarDta                  1024a

     D RtnAtr          Ds                  Qualified  Based( RtnValPtr )
     D  AtrNam                       10a
     D  DtaTyp                        1a
     D  InfSts                        1a
     D  AtrLen                       10i 0
     D  Atr                        1008a

      /Free

        RtnAtrLen = %Elem( NetAtr ) * 24 + ( %Size( SysNam )) + 4;

        NetAtr(1) = 'SYSNAME';

        RtvNetAtr( RtnVar
                 : RtnAtrLen
                 : NetAtrNbr
                 : NetAtr
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;
          SysNam = '';

        Else;
          For  Idx = 1  to RtnVar.RtnVarNbr;

            RtnValPtr = %Addr( RtnVar ) + RtnVar.RtnVarOfs(Idx);

            If  RtnAtr.AtrNam = 'SYSNAME';
              SysNam  = %SubSt( RtnAtr.Atr: 1: RtnAtr.AtrLen );
            EndIf;

          EndFor;
        EndIf;

        Return  SysNam;

      /End-Free

     P GetSysNam       E
