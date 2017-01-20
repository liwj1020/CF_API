     **
     **  Program . . : CBX962
     **  Description : Change Server Share - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Programmer's notes:
     **    To use the QZLSCHFS API, you must have *IOSYSCFG special
     **    authority or own the integrated file system directory.
     **
     **    To use the QZLSCHPS API, you must have *IOSYSCFG special
     **    authority or own the output queue.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX962 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX962 )
     **              Module( CBX962 )
     **              ActGrp( *NEW )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )

     **-- API error data structure:
     D ERRC0100        Ds                  Qualified
     D  BytPrv                       10i 0 Inz( %Size( ERRC0100 ))
     D  BytAvl                       10i 0
     D  MsgId                         7a
     D                                1a
     D  MsgDta                      256a

     **-- Global constants:
     D OFS_MSGDTA      c                   16
     D JOB_CCSID       c                   0
     D NULL            c                   x'00'
     **-- Global variables:
     D Idx             s             10i 0
     D PthNam          s           1024a   Varying
     D TxtDsc          s             50a
     D Permis          s             10i 0
     D MaxUsr          s             10i 0
     D CcsId           s             10i 0
     D CnvTxt          s              1a
     D SpfTyp          s             10i 0
     D OutQue_q        s             20a
     D PrtFil_q        s             20a
     D PrtDrv          s             50a
     D Publish         s              1a
     D NbrTblEnt       s             10i 0

     **-- File extension table:
     D FilExtTbl       Ds                  Qualified
     D  TblEnt                             Dim( 128 )
     D   ExtLen                      10i 0 Overlay( TblEnt: 1 )
     D   FilExt                      46a   Overlay( TblEnt: 5 )
     **-- List information:
     D ZLSL0101        Ds         32767    Qualified
     D  EntLen                       10i 0
     D  Share                        12a
     D  DevTyp                       10i 0
     D  Permis                       10i 0
     D  MaxUsr                       10i 0
     D  CurUsr                       10i 0
     D  SpfTyp                       10i 0
     D  OfsPthNam                    10i 0
     D  LenPthNam                    10i 0
     D  OutQue_q                     20a
     D   OutQueNam                   10a   Overlay( OutQue_q:  1 )
     D   OutQueLib                   10a   Overlay( OutQue_q: 11 )
     D  PrtDrv                       50a
     D  TxtDsc                       50a
     D  PrtFil_q                     20a
     D   PrtFilNam                   10a   Overlay( PrtFil_q:  1 )
     D   PrtFilLib                   10a   Overlay( PrtFil_q: 11 )
     D  TxtCcsId                     10i 0
     D  OfsExtTbl                    10i 0
     D  NbrTblEnt                    10i 0
     D  EnbTxtCnv                     1a
     D  Publish                       1a
     **-- List information:
     D LstInf          Ds                  Qualified
     D  RcdNbrTot                    10i 0
     D  RcdNbrRtn                    10i 0
     D  RcdLen                       10i 0
     D  InfLen                       10i 0
     D  InfSts                        1a
     D  Dts                          13a
     D                               34a

     **-- Open list of server information:
     D LstSvrInf       Pr                  ExtPgm( 'QZLSOLST' )
     D  RcvVar                    32767a          Options( *VarSize )
     D  RcvVarLen                    10i 0 Const
     D  LstInf                       64a
     D  Format                        8a   Const
     D  InfQual                      15a   Const
     D  Error                     32767a          Options( *VarSize )
     D  SsnUsr                       10a   Const  Options( *NoPass )
     D  SsnId                        20u 0 Const  Options( *NoPass )
     **-- Change file server share:
     D ChgFilShr       Pr                  ExtPgm( 'QZLSCHFS' )
     D  Share                        12a   Const
     D  PthNam                     1024a   Const  Options( *VarSize )
     D  PthNamLen                    10i 0 Const
     D  PthNamCcsId                  10i 0 Const
     D  TxtDsc                       50a   Const
     D  Permis                       10i 0 Const
     D  MaxUsr                       10i 0 Const
     D  Error                     32767a          Options( *VarSize )
     D  TxtCnvCcsId                  10i 0 Const  Options( *NoPass )
     D  EnbTxtCnv                     1a   Const  Options( *NoPass )
     D  FilExtTbl                          LikeDs( FilExtTbl )
     D                                     Const  Options( *NoPass: *VarSize )
     D  NbrFilExt                    10i 0 Const  Options( *NoPass )
     **-- Change print server share:
     D ChgPrtShr       Pr                  ExtPgm( 'QZLSCHPS' )
     D  Share                        12a   Const
     D  OutQue_q                     20a   Const
     D  TxtDsc                       50a   Const
     D  SpfTyp                       10i 0 Const
     D  PrtDrv                       50a   Const
     D  Error                     32767a          Options( *VarSize )
     D  PrtFil_q                     20a   Const  Options( *NoPass )
     D  Publish                       1a   Const  Options( *NoPass )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgFil_q                     20a   Const
     D  MsgDta                      512a   Const  Options( *VarSize )
     D  MsgDtaLen                    10i 0 Const
     D  MsgTyp                       10a   Const
     D  CalStkEnt                    10a   Const  Options( *VarSize )
     D  CalStkCtr                    10i 0 Const
     D  MsgKey                        4a
     D  Error                       512a          Options( *VarSize )
     **
     D  CalStkEntLen                 10i 0 Const  Options( *NoPass )
     D  CalStkEntQlf                 20a   Const  Options( *NoPass )
     D  DspWait                      10i 0 Const  Options( *NoPass )
     **
     D  CalStkEntTyp                 20a   Const  Options( *NoPass )
     D  CcsId                        10i 0 Const  Options( *NoPass )

     **-- Send completion message:
     D SndCmpMsg       Pr            10i 0
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D ObjNam_q        Ds                  Qualified
     D  ObjNam                       10a
     D  ObjLib                       10a
     **
     D FilExt          Ds                  Qualified
     D  NbrExt                        5i 0
     D  FilExt                       46a   Varying  Dim( 128 )
     **
     D CBX962          Pr
     D  PxShare                      12a
     D  PxShrTyp                     10a
     D  PxPthNam                   1024a   Varying
     D  PxTxtDsc                     50a
     D  PxPermis                     10i 0
     D  PxMaxUsr                     10i 0
     D  PxCcsId                      10i 0
     D  PxCnvTxt                      1a
     D  PxFilExt                           LikeDs( FilExt )
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxSpfTyp                     10i 0
     D  PxPrtDrv                     50a
     D  PxPrtFil_q                         LikeDs( ObjNam_q )
     D  PxPublish                     1a
     **
     D CBX962          Pi
     D  PxShare                      12a
     D  PxShrTyp                     10a
     D  PxPthNam                   1024a   Varying
     D  PxTxtDsc                     50a
     D  PxPermis                     10i 0
     D  PxMaxUsr                     10i 0
     D  PxCcsId                      10i 0
     D  PxCnvTxt                      1a
     D  PxFilExt                           LikeDs( FilExt )
     D  PxOutQue_q                         LikeDs( ObjNam_q )
     D  PxSpfTyp                     10i 0
     D  PxPrtDrv                     50a
     D  PxPrtFil_q                         LikeDs( ObjNam_q )
     D  PxPublish                     1a

      /Free

        LstSvrInf( ZLSL0101
                 : %Len( ZLSL0101 )
                 : LstInf
                 : 'ZLSL0101'
                 : PxShare
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl = *Zero;

          If  PxShrTyp = '*FILE';

            If  ZLSL0101.DevTyp = 0;

              ExSr  SetFilInf;

              ChgFilShr( PxShare
                       : PthNam
                       : %Len( PthNam )
                       : JOB_CCSID
                       : TxtDsc
                       : Permis
                       : MaxUsr
                       : ERRC0100
                       : CcsId
                       : CnvTxt
                       : FilExtTbl
                       : NbrTblEnt
                       );
              EndIf;
          Else;

            If  ZLSL0101.DevTyp = 1;

              ExSr  SetOutQueInf;

              ChgPrtShr( PxShare
                       : OutQue_q
                       : TxtDsc
                       : SpfTyp
                       : PrtDrv
                       : ERRC0100
                       : PrtFil_q
                       : Publish
                       );
            EndIf;
          EndIf;
        EndIf;

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndEscMsg( ERRC0100.MsgId
                   : 'QCPFMSG'
                   : %Subst( ERRC0100.MsgDta
                           : 1
                           : ERRC0100.BytAvl - OFS_MSGDTA
                           )
                   );
        Else;
          SndCmpMsg( 'Share ' + %Trim( PxShare ) + ' changed.' );
        EndIf;


        *InLr = *On;
        Return;


        BegSr  SetFilInf;

          If  PxPthNam = '*SAME';
            PthNam = %Subst( ZLSL0101
                           : ZLSL0101.OfsPthNam + 1
                           : ZLSL0101.LenPthNam
                           );
          Else;
            PthNam = PxPthNam;
          EndIf;

          If  PxTxtDsc = '*SAME';
            TxtDsc = ZLSL0101.TxtDsc;
          Else;
            TxtDsc = PxTxtDsc;
          EndIf;

          If  PxPermis = *Zero;
            Permis = ZLSL0101.Permis;
          Else;
            Permis = PxPermis;
          EndIf;

          If  PxMaxUsr = *Zero;
            MaxUsr = ZLSL0101.MaxUsr;
          Else;
            MaxUsr = PxMaxUsr;
          EndIf;

          If  PxCcsId = -1;
            CcsId = ZLSL0101.TxtCcsId;
          Else;
            CcsId = PxCcsId;
          EndIf;

          If  PxCnvTxt = '*';
            CnvTxt = ZLSL0101.EnbTxtCnv;
          Else;
            CnvTxt = PxCnvTxt;
          EndIf;

          Select;
          When  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = '*SAME';
            FilExtTbl = %Subst( ZLSL0101
                              : ZLSL0101.OfsExtTbl + 1
                              : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
                              );

            NbrTblEnt = ZLSL0101.NbrTblEnt;

          When  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = *Blank;
            NbrTblEnt = *Zero;

          Other;
            For  Idx = 1  To  PxFilExt.NbrExt;
              FilExtTbl.ExtLen(Idx) = %Len( PxFilExt.FilExt(Idx));
              FilExtTbl.FilExt(Idx) = PxFilExt.FilExt(Idx) + NULL;
            EndFor;

            NbrTblEnt = PxFilExt.NbrExt;
          EndSl;

        EndSr;

        BegSr  SetOutQueInf;

          If  PxTxtDsc = '*SAME';
            TxtDsc = ZLSL0101.TxtDsc;
          Else;
            TxtDsc = PxTxtDsc;
          EndIf;

          If  PxOutQue_q = '*SAME';
            OutQue_q = ZLSL0101.OutQue_q;
          Else;
            OutQue_q = PxOutQue_q;
          EndIf;

          If  PxPrtFil_q = '*SAME';
            PrtFil_q = ZLSL0101.PrtFil_q;
          Else;
            PrtFil_q = PxPrtFil_q;
          EndIf;

          If  PxPrtDrv = '*SAME';
            PrtDrv = ZLSL0101.PrtDrv;
          Else;
            PrtDrv = PxPrtDrv;
          EndIf;

          If  PxSpfTyp = *Zero;
            SpfTyp = ZLSL0101.SpfTyp;
          Else;
            SpfTyp = PxSpfTyp;
          EndIf;

          If  PxPublish = '*';
            Publish = ZLSL0101.Publish;
          Else;
            Publish = PxPublish;
          EndIf;

        EndSr;

      /End-Free

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

     P SndCmpMsg       E
     **-- Send escape message:  ----------------------------------------------**
     P SndEscMsg       B
     D                 Pi            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgF                       10a   Const
     D  PxMsgDta                    512a   Const  Varying
     **
     D MsgKey          s              4a

      /Free

        SndPgmMsg( PxMsgId
                 : PxMsgF + '*LIBL'
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
