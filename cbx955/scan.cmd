000100060216/*-------------------------------------------------------------------*/
000200060216/*                                                                   */
000300060216/*  Compile options:                                                 */
000400060216/*                                                                   */
000500060216/*    CrtCmd Cmd( SCAN )                                             */
000600060216/*           Pgm( CBX955 )                                           */
000700060216/*           SrcMbr( CBX955X )                                       */
000800060216/*           Allow((*IPGM) (*BPGM) (*IMOD) (*BMOD) (*IREXX) (*BREXX))*/
000900060216/*           HlpPnlGrp( CBX955H )                                    */
001000060216/*           HlpId( *CMD )                                           */
001100060216/*                                                                   */
001200060216/*                                                                   */
001300060216/*-------------------------------------------------------------------*/
001400060216    Cmd        Prompt( 'Scan String' )
001500930930
001600060216    Parm       STRING     *Char      999              +
001700060216               Min( 1 )                               +
001800060216               Expr( *YES )                           +
001900060216               Vary( *YES )                           +
002000060216               Prompt( 'String to scan' )
002100060216
002200060216    Parm       PATTERN    *Char      999              +
002300060216               Min( 1 )                               +
002400060216               Expr( *YES )                           +
002500060216               Vary( *YES )                           +
002600060216               Prompt( 'Pattern to scan for' )
002700060216
002800060216    Parm       START      *Dec         3              +
002900060216               Dft( *START )                          +
003000060216               Range( 1  999 )                        +
003100060216               SpcVal(( *START  1 ))                  +
003200060216               Expr( *YES )                           +
003300060216               Prompt( 'Starting position' )
003400060216
003500060216    Parm       TRANSLATE  *Char        1              +
003600060216               Dft( *NO )                             +
003700060216               Rstd( *YES )                           +
003800060216               SpcVal(( *NO  '0' ) ( *YES  '1' ))     +
003900060216               Expr( *YES )                           +
004000060216               Prompt( 'Translate characters' )
004100940711
004200060216    Parm       TRIM       *Char        1              +
004300060216               Dft( *NO )                             +
004400060216               Rstd( *YES )                           +
004500060216               SpcVal(( *NO  '0' ) ( *YES  '1' ))     +
004600060216               Expr( *YES )                           +
004700060216               Prompt( 'Trim trailing blanks' )
004800060216
004900060216    Parm       WILDCARD   *Char        1              +
005000060216               Dft( *NONE )                           +
005100060216               SpcVal(( *NONE ' ' ))                  +
005200060216               Expr( *YES )                           +
005300060216               Prompt( 'Wildcard character' )
005400940711
005500060216    Parm       RESULT     *Dec         3              +
005600060216               RtnVal( *YES )                         +
005700060216               Prompt( 'Result' )
005800940712
