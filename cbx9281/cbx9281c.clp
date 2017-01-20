     Pgm

     Dcl        &AutInd      *Char     1

     RtvSpcAut  UsrPrf( <user profile> )         +
                SpcAut( *ALLOBJ *IOSYSCFG )      +
                AutInd( &AutInd )

     If       ( &AutInd *NE 'Y' ) Do

     SndPgmMsg  Msg( 'Sorry - not authorized to this function.' )
     GoTo       EndPgm
     EndDo

     /*-- Do whatever ... --*/

EndPgm:
     EndPgm
