000100040606/*-------------------------------------------------------------------*/
000200040606/*                                                                   */
000300040606/*  Compile options:                                                 */
000400040606/*                                                                   */
000500040807/*    CrtCmd Cmd( PRCFILLCK )                                        */
000600040807/*           Pgm( CBX920 )                                           */
000700040807/*           SrcMbr( CBX920X )                                       */
000800040808/*           AlwLmtUsr( *NO )                                        */
000900040807/*           HlpPnlGrp( CBX920H )                                    */
001000040606/*           HlpId( *CMD )                                           */
001100040606/*                                                                   */
001200040606/*-------------------------------------------------------------------*/
001300040807        Cmd      Prompt( 'Process File Locks' )
001400961213
001500040807
001600040807        Parm     FILE          Q0001             +
001700040807                 Min( 1 )                        +
001800040807                 File( *UNSPFD )                 +
001900040807                 Choice( *NONE )                 +
002000040807                 Prompt( 'File' )
002100040807
002200040807        Parm     ACTION        *Char     7       +
002300040807                 Dft( *BRKMSG )                  +
002400040807                 Rstd( *YES )                    +
002500040807                 SpcVal(( *BRKMSG )              +
002600040807                        ( *ENDJOB ))             +
002700040807                 Expr( *YES )                    +
002800040807                 Prompt( 'Action to perform' )
002900040807
003000040807        Parm     MSG          *Char    512       +
003100040807                 Expr( *YES )                    +
003200040807                 Vary( *YES *INT2 )              +
003300040807                 PmtCtl( P0001 )                 +
003400040807                 Prompt( 'Message text' )
003500040807
003600040813        Parm     MSGTO         *Char     5       +
003700040807                 Dft( *JOB )                     +
003800040807                 Rstd( *YES )                    +
003900040807                 SpcVal(( *JOB )                 +
004000040807                        ( *USER ))               +
004100040807                 Expr( *YES )                    +
004200040807                 PmtCtl( P0001 )                 +
004300040807                 Prompt( 'Send message to' )
004400040813
004500040813        Parm     ENDOPT        *Char     7       +
004600040813                 Rstd( *YES )                    +
004700040813                 Dft( *CNTRLD )                  +
004800040813                 SpcVal(( *CNTRLD )              +
004900040813                        ( *IMMED  ))             +
005000040813                 Expr( *YES )                    +
005100040813                 PmtCtl( P0002 )                 +
005200040813                 Prompt( 'How to end' )
005300040813
005400040813        Parm     DELAY         *Int4             +
005500040813                 DFT( 30 )                       +
005600040813                 Range( 1 999999 )               +
005700040813                 Expr( *YES )                    +
005800040813                 PmtCtl( P0002 )                 +
005900040813                 Choice( 'Seconds' )             +
006000040813                 Prompt( 'Delay time, if *CNTRLD' )
006100040807
006200040813        Parm     IGNRCDLCK    *Char      4       +
006300040813                 Dft( *NO )                      +
006400040813                 Rstd( *YES )                    +
006500040813                 SpcVal(( *NO )                  +
006600040813                        ( *YES ))                +
006700040813                 Expr( *YES )                    +
006800040813                 PmtCtl( P0002 )                 +
006900040813                 Prompt( 'Ignore record lock' )
007000040813
007100040807
007200040807Q0001:  Qual                  *Name     10       +
007300040807                 Min( 1 )                        +
007400040807                 Expr( *YES )
007500040807
007600040807        Qual                  *Name     10       +
007700040807                 Dft( *LIBL )                    +
007800040807                 SpcVal(( *LIBL )                +
007900040807                        ( *CURLIB ))             +
008000040807                 Expr( *YES )                    +
008100040807                 Prompt( 'Library' )
008200040728
008300040807
008400040807P0001:  PmtCtl   Ctl( ACTION )                   +
008500040807                 Cond(( *EQ *BRKMSG ))
008600040807
008700040807P0002:  PmtCtl   Ctl( ACTION )                   +
008800040807                 Cond(( *EQ *ENDJOB ))
008900040807
009000040807
009100040807        Dep      Ctl( &ACTION *EQ '*BRKMSG' )    +
009200040807                 Parm(( MSG ))                   +
009300040807                 NbrTrue( *EQ 1 )                +
009400040807                 MsgId( CPF1EBD )
009500040807
009600040807        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
009700040807                 Parm(( MSG ))                   +
009800040807                 NbrTrue( *EQ 0 )                +
009900040807                 MsgId( CPE3028 )
010000040728
010100040807        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
010200040807                 Parm(( MSGTO ))                 +
010300040807                 NbrTrue( *EQ 0 )
010400040807
010500040813        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
010600040813                 Parm(( ENDOPT ))                +
010700040813                 NbrTrue( *EQ 0 )                +
010800040813
010900040813        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
011000040813                 Parm(( DELAY ))                 +
011100040813                 NbrTrue( *EQ 0 )                +
011200040813
011300040813        Dep      Ctl( &ENDOPT *NE '*CNTRLD' )    +
011400040813                 Parm(( DELAY ))                 +
011500040813                 NbrTrue( *EQ 0 )                +
011600040813
011700040813        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
011800040813                 Parm(( IGNRCDLCK ))             +
011900040813                 NbrTrue( *EQ 0 )                +
012000040813
