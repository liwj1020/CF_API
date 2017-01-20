/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ADDPRNSEED )                                       */
/*           Pgm( CBX951 )                                           */
/*           SrcMbr( CBX951X )                                       */
/*           Allow(( *INTERACT ))                                    */
/*           HlpPnlGrp( CBX951H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
      Cmd        Prompt( 'Add Pseudo Random Number Seed' )

      Parm       SEED1         *Char      32                  +
                 Min( 1 )                                     +
                 Full( *YES )                                 +
                 Prompt( 'Seed block 1' )

      Parm       SEED2         *Char      32                  +
                 Min( 1 )                                     +
                 Full( *YES )                                 +
                 Prompt( 'Seed block 2' )

      Parm       SEED3         *Char      32                  +
                 Min( 1 )                                     +
                 Full( *YES )                                 +
                 Prompt( 'Seed block 3' )

      Parm       SEED4         *Char      32                  +
                 Min( 1 )                                     +
                 Full( *YES )                                 +
                 Prompt( 'Seed block 4' )

      Parm       SEED5         *Char      32                  +
                 Min( 1 )                                     +
                 Full( *YES )                                 +
                 Prompt( 'Seed block 5' )

