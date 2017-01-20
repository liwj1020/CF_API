     **
     **  Program . . : CBX960
     **  Description : Add Server Share - CPP
     **  Author  . . : Carsten Flensburg
     **
     **
     **
     **  Programmer's notes:
     **    To use the QZLSADFS API, you must have *IOSYSCFG special
     **    authority or own the integrated file system directory.
     **
     **    To use the QZLSADPS API, you must have *IOSYSCFG special
     **    authority or own the output queue.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX960 )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX960 )
     **              Module( CBX960 )
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

     **-- Request variable:
     D FilExtTbl       Ds                  Qualified  Dim( 128 )
     D  ExtLen                       10i 0
     D  FilExt                       46a

     **-- Add file server share:
     D AddFilShr       Pr                  ExtPgm( 'QZLSADFS' )
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
     D  FilExtTbl                          LikeDs( FilExtTbl )  Dim(128)
     D                                     Const  Options( *NoPass: *VarSize )
     D  NbrFilExt                    10i 0 Const  Options( *NoPass )
     **-- Add print server share:
     D AddPrtShr       Pr                  ExtPgm( 'QZLSADPS' )
     D  Share                        12a   Const
     D  OutQue_q                     20a   Const
     D  TxtDsc                       50a   Const
     D  SpfTyp                       10i 0 Const
     D  PrtDrv                       50a   Const
     D  Error                     32767a          Options( *VarSize )
     D  PrtF_q                       20a   Const  Options( *NoPass )
     D  Publish                       1a   Const  Options( *NoPass )
     **-- Send program message:
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  MsgId                         7a   Const
     D  MsgF_q                       20a   Const
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
     D CBX960          Pr
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
     D  PxPrtF_q                           LikeDs( ObjNam_q )
     D  PxPublish                     1a
     **
     D CBX960          Pi
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
     D  PxPrtF_q                           LikeDs( ObjNam_q )
     D  PxPublish                     1a

      /Free

        If  PxShrTyp = '*FILE';

          If  PxFilExt.NbrExt = 1  And PxFilExt.FilExt(1) = *Blank;
            PxFilExt.NbrExt = *Zero;

          Else;
            For  Idx = 1  To  PxFilExt.NbrExt;

              FilExtTbl(Idx).ExtLen = %Len( PxFilExt.FilExt(Idx));
              FilExtTbl(Idx).FilExt = PxFilExt.FilExt(Idx) + NULL;
            EndFor;
          EndIf;

          AddFilShr( PxShare
                   : PxPthNam
                   : %Len( PxPthNam )
                   : JOB_CCSID
                   : PxTxtDsc
                   : PxPermis
                   : PxMaxUsr
                   : ERRC0100
                   : PxCcsId
                   : PxCnvTxt
                   : FilExtTbl
                   : PxFilExt.NbrExt
                   );
        Else;
          AddPrtShr( PxShare
                   : PxOutQue_q
                   : PxTxtDsc
                   : PxSpfTyp
                   : PxPrtDrv
                   : ERRC0100
                   : PxPrtF_q
                   : PxPublish
                   );
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
          SndCmpMsg( 'Share ' + %Trim( PxShare ) + ' added.' );
        EndIf;


        *InLr = *On;
        Return;

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
