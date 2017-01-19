000100040227     Pgm
000200030905
000300030905/*-- Global variables:  ---------------------------------------------*/
000400030905     Dcl        &JrnSeqNbr   *Dec     10
000500041016     Dcl        &JrnExit     *Char    10     'CBX925   '
000600041016     Dcl        &JrnSeqDta   *Char    10     'CBX925D  '
000700041017     Dcl        &JrnNam      *Char    10     'CBXIFSJRN'
000800041016     Dcl        &JrnLib      *Char    10     '*LIBL    '
000900960126
001000030907     MonMsg     CPF0000      *N       GoTo Error
001100030905
001200030907
001300030908/*-- Journal entry date format *TYPE2 = *JOB --*/
001400030905     ChgJob     DatFmt( *YMD )
001500960704
001600030905     RtvDtaAra  &JrnSeqDta     RtnVar( &JrnSeqNbr )
001700030906     ChgVar     &JrnSeqNbr   ( &JrnSeqNbr + 1 )
001800911227
001900030905 RcvJrnE:
002000030905     RcvJrnE    Jrn( &JrnLib/&JrnNam )      +
002100030905                ExitPgm( &JrnExit )         +
002200030908                File( *ALLFILE )            +
002300030905                RcvRng( *CURCHAIN )         +
002400030905                FromEnt( &JrnSeqNbr )       +
002500030906                ToEnt( *NONE )              +
002600041016                JrnCde( B )                 +
002700041016                EntTyp( 'B1' )              +
002800030905                EntFmt( *TYPE2 )            +
002900030906                Delay( *NEXTENT  25 )       +
003000030906                BlkLen( *NONE )
003100030905
003200030908     MonMsg     CPF7054          *N   Do
003300030908     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
003400030908
003500030908/*-- From entry not found - get first entry in current receiver --*/
003600030908     RtvJrnE    Jrn( &JrnLib/&JrnNam )      +
003700030908                RcvRng( *CURRENT )          +
003800030908                FromEnt( *FIRST )           +
003900030908                RtnSeqNbr( &JrnSeqNbr )
004000030908
004100030908     GoTo       RcvJrnE
004200030908     EndDo
004300920305
004400030905 Return:
004500030905     Return
004600030905
004700030905/*-- Error handling:  -----------------------------------------------*/
004800030905 Error:
004900030909     Call       QMHMOVPM    ( '    '                                 +
005000030909                              '*DIAG'                                +
005100030909                              x'00000001'                            +
005200030909                              '*PGMBDY'                              +
005300030909                              x'00000001'                            +
005400030909                              x'0000000800000000'                    +
005500030909                            )
005600030905
005700030909     Call       QMHRSNEM    ( '    '                                 +
005800030909                              x'0000000800000000'                    +
005900030909                            )
006000030905
006100030905 EndPgm:
006200030905     EndPgm
