     Pgm

/*-- Global variables:  ---------------------------------------------*/
     Dcl        &JrnSeqNbr   *Dec     10
     Dcl        &JrnExit     *Char    10     'CBX925   '
     Dcl        &JrnSeqDta   *Char    10     'CBX925D  '
     Dcl        &JrnNam      *Char    10     'CBXIFSJRN'
     Dcl        &JrnLib      *Char    10     '*LIBL    '

     MonMsg     CPF0000      *N       GoTo Error


/*-- Journal entry date format *TYPE2 = *JOB --*/
     ChgJob     DatFmt( *YMD )

     RtvDtaAra  &JrnSeqDta     RtnVar( &JrnSeqNbr )
     ChgVar     &JrnSeqNbr   ( &JrnSeqNbr + 1 )

 RcvJrnE:
     RcvJrnE    Jrn( &JrnLib/&JrnNam )      +
                ExitPgm( &JrnExit )         +
                File( *ALLFILE )            +
                RcvRng( *CURCHAIN )         +
                FromEnt( &JrnSeqNbr )       +
                ToEnt( *NONE )              +
                JrnCde( B )                 +
                EntTyp( 'B1' )              +
                EntFmt( *TYPE2 )            +
                Delay( *NEXTENT  25 )       +
                BlkLen( *NONE )

     MonMsg     CPF7054          *N   Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

/*-- From entry not found - get first entry in current receiver --*/
     RtvJrnE    Jrn( &JrnLib/&JrnNam )      +
                RcvRng( *CURRENT )          +
                FromEnt( *FIRST )           +
                RtnSeqNbr( &JrnSeqNbr )

     GoTo       RcvJrnE
     EndDo

 Return:
     Return

/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call       QMHMOVPM    ( '    '                                 +
                              '*DIAG'                                +
                              x'00000001'                            +
                              '*PGMBDY'                              +
                              x'00000001'                            +
                              x'0000000800000000'                    +
                            )

     Call       QMHRSNEM    ( '    '                                 +
                              x'0000000800000000'                    +
                            )

 EndPgm:
     EndPgm
