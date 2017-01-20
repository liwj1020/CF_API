     Pgm


     ChkSpcAut  UsrPrf( <user profile> )  SpcAut( *ALLOBJ *IOSYSCFG )

     MonMsg     CPFB304     *N    Do
     RcvMsg     MsgType( *EXCP )  Rmv( *YES )

     SndPgmMsg  Msg( 'Sorry - not authorized to this function.' )
     GoTo       EndPgm
     EndDo

     /*-- Do whatever ... --*/

EndPgm:
     EndPgm
