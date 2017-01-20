     **
     **  Program . . : CBX962
     **  Description : Change Server Share - POP
     **  Author  . . : Carsten Flensburg
     **
     **
     **  Parameters:
     **    PxCmdNam_q  INPUT      Qualified command name
     **
     **    PxKeyPrm1   INPUT      Key parameter identifying the
     **                           server share to retrieve attribute
     **                           information about.
     **
     **    PxKeyPrm2   INPUT      Key parameter specifying the
     **                           server share type.
     **
     **    PxCmdStr    OUTPUT     The formatted command prompt
     **                           string returning the current
     **                           attribute setting of the
     **                           specified server share.
     **
     **
     **  Compile options:
     **    CrtRpgMod Module( CBX962O )
     **              DbgView( *LIST )
     **
     **    CrtPgm    Pgm( CBX962O )
     **              Module( CBX962O )
     **              ActGrp( QILE )
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
     **-- Global variables:
     D Path            s           1024a   Varying

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

     **-- Double quotes:
     D DblQuotes       Pr           256a   Varying
     D  PxTxtDsc                    256a   Value  Varying
     **-- Format file extension:
     D FmtFilExt       Pr          6000a   Varying
     D  PxFilExtTbl                        LikeDs( FilExtTbl )
     D                                     Const
     D  PxNbrFilEnt                  10i 0 Const
     **-- Send diagnostic message:
     D SndDiagMsg      Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying
     **-- Send escape message:
     D SndEscMsg       Pr            10i 0
     D  PxMsgId                       7a   Const
     D  PxMsgDta                    512a   Const  Varying

     **-- Entry parameters:
     D CBX962O         Pr
     D  PxCmdNam_q                   20a
     D  PxKeyPrm1                    12a
     D  PxKeyPrm2                    10a
     D  PxCmdStr                  32674a   Varying
     **
     D CBX962O         Pi
     D  PxCmdNam_q                   20a
     D  PxKeyPrm1                    12a
     D  PxKeyPrm2                    10a
     D  PxCmdStr                  32674a   Varying

      /Free

        LstSvrInf( ZLSL0101
                 : %Len( ZLSL0101 )
                 : LstInf
                 : 'ZLSL0101'
                 : PxKeyPrm1
                 : ERRC0100
                 );

        If  ERRC0100.BytAvl > *Zero;

          If  ERRC0100.BytAvl < OFS_MSGDTA;
            ERRC0100.BytAvl = OFS_MSGDTA;
          EndIf;

          SndDiagMsg( ERRC0100.MsgId
                    : %Subst( ERRC0100.MsgDta: 1: ERRC0100.BytAvl - OFS_MSGDTA )
                    );

          SndEscMsg( 'CPF0011': '' );

        Else;
          If  PxKeyPrm2 = '*FILE'   And  ZLSL0101.DevTyp = 0  Or
              PxKeyPrm2 = '*PRINT'  And  ZLSL0101.DevTyp = 1;

          ExSr  RtvShrInf;
          EndIf;
        EndIf;


        *InLr = *On;
        Return;

        BegSr  RtvShrInf;

          ZLSL0101.TxtDsc = DblQuotes( ZLSL0101.TxtDsc );

          If  ZLSL0101.TxtDsc = *Blanks;
            PxCmdStr += '?<TEXT(*BLANK) ';
          Else;
            PxCmdStr += '?<TEXT(''' + ZLSL0101.TxtDsc + ''') ';
          EndIf;

          If  PxKeyPrm2 = '*FILE';
            Path = %Subst( ZLSL0101
                         : ZLSL0101.OfsPthNam + 1
                         : ZLSL0101.LenPthNam
                         );

            PxCmdStr += '?<PATH(''' + Path + ''') ';

            If  ZLSL0101.Permis = 1;
              PxCmdStr += '?<PERMISSION(*READONLY) ';
            Else;
              PxCmdStr += '?<PERMISSION(*READWRITE) ';
            EndIf;

            If  ZLSL0101.MaxUsr = -1;
              PxCmdStr += '?<MAXUSERS(*NOMAX) ';
            Else;
              PxCmdStr += '?<MAXUSERS(' + %Char( ZLSL0101.MaxUsr ) + ') ';
            EndIf;

            If  ZLSL0101.TxtCcsId = 0;
              PxCmdStr += '?<CCSID(*SVRCCSID) ';
            Else;
              PxCmdStr += '?<CCSID(' + %Char( ZLSL0101.TxtCcsId ) + ') ';
            EndIf;

            Select;
            When  ZLSL0101.EnbTxtCnv = '0';
              PxCmdStr += '?<CVTTXT(*NO) ';

            When  ZLSL0101.EnbTxtCnv = '1';
              PxCmdStr += '?<CVTTXT(*YES) ';

            Other;
              PxCmdStr += '?<CVTTXT(*MIXED) ';
            EndSl;

            If  ZLSL0101.NbrTblEnt = 0;
              PxCmdStr += '?<FILEXT(*NONE) ';
            Else;
              FilExtTbl = %Subst( ZLSL0101
                                : ZLSL0101.OfsExtTbl + 1
                                : ZLSL0101.NbrTblEnt * %Size( FilExtTbl.TblEnt )
                                );

              PxCmdStr += FmtFilExt( FilExtTbl: ZLSL0101.NbrTblEnt );
            EndIf;

          Else;
            PxCmdStr += '?<OUTQ(' + %Trim( ZLSL0101.OutQueLib ) +
                              '/' + %Trim( ZLSL0101.OutQueNam ) + ') ';

            Select;
            When  ZLSL0101.SpfTyp = 1;
              PxCmdStr += '?<SPLFTYPE(*USERASCII) ';

            When  ZLSL0101.SpfTyp = 2;
              PxCmdStr += '?<SPLFTYPE(*AFPDS) ';

            When  ZLSL0101.SpfTyp = 3;
              PxCmdStr += '?<SPLFTYPE(*SCS) ';

            Other;
              PxCmdStr += '?<SPLFTYPE(*AUTO) ';
            EndSl;

            If  ZLSL0101.PrtDrv = *Blanks;
              PxCmdStr += '?<PRTDRV(*BLANK) ';
            Else;
              PxCmdStr += '?<PRTDRV(''' + %Trim( ZLSL0101.PrtDrv ) + ''') ';
            EndIf;

            If  ZLSL0101.PrtFil_q = *Blanks;
              PxCmdStr += '?<PRTF(*NONE) ';
            Else;
              PxCmdStr += '?<PRTF(' + %Trim( ZLSL0101.PrtFilLib ) +
                                '/' + %Trim( ZLSL0101.PrtFilNam ) + ') ';
            EndIf;

            If  ZLSL0101.Publish = '0';
              PxCmdStr += '?<PUBLISH(*NO) ';
            Else;
              PxCmdStr += '?<PUBLISH(*YES) ';
            EndIf;
          EndIf;

        EndSr;

      /End-Free

     **-- Double quotes:  ----------------------------------------------------**
     P DblQuotes       B
     D                 Pi           256a   Varying
     D  PxTxtDsc                    256a   Value  Varying

     D Pos             s             10i 0

      /Free

          Pos = %Scan( '''': PxTxtDsc );

          DoW  Pos > *Zero;
            PxTxtDsc = %Replace( '''': PxTxtDsc: Pos: 0 );

            If  Pos + 2 <= %Len( PxTxtDsc );
              Pos = %Scan( '''': PxTxtDsc: Pos + 2 );
            Else;
              Pos = *Zero;
            EndIf;
          EndDo;

          Return  %TrimR( PxTxtDsc );

      /End-Free

     P DblQuotes       E
     **-- Format file extension:  --------------------------------------------**
     P FmtFilExt       B
     D                 Pi          6000a   Varying
     D  PxFilExtTbl                        LikeDs( FilExtTbl )
     D                                     Const
     D  PxNbrFilEnt                  10i 0 Const

     D Idx             s             10i 0
     D FilExt          s             46a   Varying
     D CmdStr          s           6000a   Varying

      /Free

          CmdStr = ' ?<FILEXT(';

          For  Idx = 1  to  PxNbrFilEnt;
            FilExt = %Subst( PxFilExtTbl.FilExt(Idx)
                           : 1
                           : PxFilExtTbl.ExtLen(Idx)
                           );

            Select;
            When  FilExt = '*';
              CmdStr += '*ALL';

            When  FilExt = '.';
              CmdStr += '*NOEXT';

            Other;
              CmdStr += '''' + FilExt + ''' ';
            EndSl;
          EndFor;

          Return  %TrimR( CmdStr ) + ')';

      /End-Free

     P FmtFilExt       E
     **-- Send diagnostic message:  ------------------------------------------**
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
