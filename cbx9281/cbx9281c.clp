000100041201     Pgm
000200021010
000300041214     Dcl        &AutInd      *Char     1
000400951127
000500050107     RtvSpcAut  UsrPrf( <user profile> )         +
000600050107                SpcAut( *ALLOBJ *IOSYSCFG )      +
000700041214                AutInd( &AutInd )
000800041211
000900041214     If       ( &AutInd *NE 'Y' ) Do
001000041203
001100041214     SndPgmMsg  Msg( 'Sorry - not authorized to this function.' )
001200041203     GoTo       EndPgm
001300041203     EndDo
001400041203
001500041211     /*-- Do whatever ... --*/
001600041203
001700041203EndPgm:
001800021010     EndPgm
