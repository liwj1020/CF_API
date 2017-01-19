000100040606/*-------------------------------------------------------------------*/
000200040606/*                                                                   */
000300040606/*  Compile options:                                                 */
000400040606/*                                                                   */
000500040831/*    CrtCmd Cmd( PRCRCDLCK )                                        */
000600040831/*           Pgm( CBX922 )                                           */
000700040831/*           SrcMbr( CBX922X )                                       */
000800040808/*           AlwLmtUsr( *NO )                                        */
000900040831/*           HlpPnlGrp( CBX922H )                                    */
001000040606/*           HlpId( *CMD )                                           */
001100040606/*                                                                   */
001200040606/*-------------------------------------------------------------------*/
001300040831        Cmd      Prompt( 'Process Record Locks' )
001400961213
001500040807
001600040807        Parm     FILE          Q0001             +
001700040807                 Min( 1 )                        +
001800040807                 File( *UNSPFD )                 +
001900040807                 Choice( *NONE )                 +
002000040831                 Prompt( 'Physical file' )
002100040831
002200040831        Parm     MBR           *Name    10       +
002300040831                 Dft( *FIRST )                   +
002400040831                 SpcVal(( *FIRST ))              +
002500040831                 Expr( *YES )                    +
002600040831                 Prompt( 'Member' )
002700040831
002800040831        Parm     RCDNBR        *UINT4            +
002900040831                 Dft( *ALL )                     +
003000040831                 Range( 1 4294967288 )           +
003100040831                 SpcVal(( *ALL 0 ))              +
003200040831                 Expr( *YES )                    +
003300040831                 Choice( '1-4294967288' )        +
003400040831                 Prompt( 'Record number' )
003500040807
003600040807        Parm     ACTION        *Char     7       +
003700040807                 Dft( *BRKMSG )                  +
003800040807                 Rstd( *YES )                    +
003900040807                 SpcVal(( *BRKMSG )              +
004000040807                        ( *ENDJOB ))             +
004100040807                 Expr( *YES )                    +
004200040807                 Prompt( 'Action to perform' )
004300040807
004400040807        Parm     MSG          *Char    512       +
004500040807                 Expr( *YES )                    +
004600040807                 Vary( *YES *INT2 )              +
004700040807                 PmtCtl( P0001 )                 +
004800040807                 Prompt( 'Message text' )
004900040807
005000040813        Parm     MSGTO         *Char     5       +
005100040807                 Dft( *JOB )                     +
005200040807                 Rstd( *YES )                    +
005300040807                 SpcVal(( *JOB )                 +
005400040807                        ( *USER ))               +
005500040807                 Expr( *YES )                    +
005600040807                 PmtCtl( P0001 )                 +
005700040807                 Prompt( 'Send message to' )
005800040813
005900040813        Parm     ENDOPT        *Char     7       +
006000040813                 Rstd( *YES )                    +
006100040813                 Dft( *CNTRLD )                  +
006200040813                 SpcVal(( *CNTRLD )              +
006300040813                        ( *IMMED  ))             +
006400040813                 Expr( *YES )                    +
006500040813                 PmtCtl( P0002 )                 +
006600040813                 Prompt( 'How to end' )
006700040813
006800040813        Parm     DELAY         *Int4             +
006900040813                 DFT( 30 )                       +
007000040813                 Range( 1 999999 )               +
007100040813                 Expr( *YES )                    +
007200040813                 PmtCtl( P0002 )                 +
007300040813                 Choice( 'Seconds' )             +
007400040813                 Prompt( 'Delay time, if *CNTRLD' )
007500040807
007600040831
007700040807Q0001:  Qual                  *Name     10       +
007800040807                 Min( 1 )                        +
007900040807                 Expr( *YES )
008000040807
008100040807        Qual                  *Name     10       +
008200040807                 Dft( *LIBL )                    +
008300040807                 SpcVal(( *LIBL )                +
008400040807                        ( *CURLIB ))             +
008500040807                 Expr( *YES )                    +
008600040807                 Prompt( 'Library' )
008700040728
008800040807
008900040807P0001:  PmtCtl   Ctl( ACTION )                   +
009000040807                 Cond(( *EQ *BRKMSG ))
009100040807
009200040807P0002:  PmtCtl   Ctl( ACTION )                   +
009300040807                 Cond(( *EQ *ENDJOB ))
009400040807
009500040807
009600040807        Dep      Ctl( &ACTION *EQ '*BRKMSG' )    +
009700040807                 Parm(( MSG ))                   +
009800040807                 NbrTrue( *EQ 1 )                +
009900040807                 MsgId( CPF1EBD )
010000040807
010100040807        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
010200040807                 Parm(( MSG ))                   +
010300040807                 NbrTrue( *EQ 0 )                +
010400040807                 MsgId( CPE3028 )
010500040728
010600040807        Dep      Ctl( &ACTION *NE '*BRKMSG' )    +
010700040807                 Parm(( MSGTO ))                 +
010800040807                 NbrTrue( *EQ 0 )
010900040807
011000040813        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
011100040813                 Parm(( ENDOPT ))                +
011200040813                 NbrTrue( *EQ 0 )                +
011300040813
011400040813        Dep      Ctl( &ACTION *NE '*ENDJOB' )    +
011500040813                 Parm(( DELAY ))                 +
011600040813                 NbrTrue( *EQ 0 )                +
011700040813
011800040813        Dep      Ctl( &ENDOPT *NE '*CNTRLD' )    +
011900040813                 Parm(( DELAY ))                 +
012000040813                 NbrTrue( *EQ 0 )                +
012100040813
