     Pgm        &AppLib
 
/*-- Parameter - library to contain log system:  --------------------*/
     Dcl        &AppLib      *Char    10
 
 
     MonMsg     CPF0000      *N       GoTo Error
 
 
     CrtDtaAra  &AppLib/CBX902D       *Dec    10   Value( 0 )
 
     CrtJrnRcv  &AppLib/CBXJRN0001    Threshold( 1000000 )
 
     CrtJrn     &AppLib/CBXJRN        +
                &AppLib/CBXJRN0001    +
                MngRcv( *System )     +
                RcvSizOpt( *MaxOpt2 )
 
     CrtPf      &AppLib/CBX902F                  +
                SrcFile( &AppLib/QDDSSRC )       +
                Size( 2000000 )
 
     CrtPf      &AppLib/CBXDTAF                  +
                SrcFile( &AppLib/QDDSSRC )
 
     StrJrnPf   &AppLib/CBX902F                  +
                &AppLib/CBXJRN                   +
                Images( *Both )                  +
                OmtJrnE( *OpnClo )
 
     CrtClPgm   &AppLib/CBX902C                  +
                SrcFile( &AppLib/QCLSRC )        +
                SrcMbr( *Pgm )
 
     CrtRpgMod  &AppLib/CBX902                   +
                SrcFile( &AppLib/QRPGLESRC )     +
                SrcMbr( *Module )
 
     CrtPgm     &AppLib/CBX902
 
 Return:
     Return
 
/*-- Error handling:  -----------------------------------------------*/
 Error:
     Call      QMHMOVPM    ( '    '                                  +
                             '*DIAG'                                 +
                             x'00000001'                             +
                             '*PGMBDY'                               +
                             x'00000001'                             +
                             x'0000000800000000'                     +
                           )
 
     Call      QMHRSNEM    ( '    '                                  +
                             x'0000000800000000'                     +
                           )
 
 EndPgm:
     EndPgm
