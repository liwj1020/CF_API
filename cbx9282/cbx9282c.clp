000100041201     Pgm
000200021010
000300951127
000400050107     ChkSpcAut  UsrPrf( <user profile> )  SpcAut( *ALLOBJ *IOSYSCFG )
000500041211
000600041203     MonMsg     CPFB304     *N    Do
000700041203     RcvMsg     MsgType( *EXCP )  Rmv( *YES )
000800041203
000900041214     SndPgmMsg  Msg( 'Sorry - not authorized to this function.' )
001000041203     GoTo       EndPgm
001100041203     EndDo
001200041203
001300041211     /*-- Do whatever ... --*/
001400041203
001500041203EndPgm:
001600021010     EndPgm
