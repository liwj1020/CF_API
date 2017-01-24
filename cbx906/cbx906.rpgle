     **-- Program description:  ----------------------------------------------**
     **
     **   This program is based on the Materialize Machine Attributes built-in
     **   _MATMATR1 which is capable of retrieving - as its name indicates - a
     **   large number of machine attributes, such as machine serial ID, date
     **   format, communication network attributes, cryptographic attributes
     **   and a lot of other information of that nature.
     **
     **   All the details can be found in the online documentation of the MI
     **   built-in at the following URL:
     **
     **   http://publib.boulder.ibm.com/iseries/v5r1/ic2924/tstudio/tech_ref/mi/MATMATR.htm
     **
     **   The present program utilises the MATMATR1 built-in to retrieve the
     **   current panel status regarding key lock position and IPL setting.
     **   The found status is returned in an informational message sent to
     **   the caller of the program.
     **
     **
     **-- Compilation specification:  ----------------------------------------**
     **
     **   CrtBndRpg   Pgm( <library>/CBX906 )
     **               SrcFile( <library>/QRPGLESRC )
     **
     **
     **-- Header specifications:  --------------------------------------------**
     H Option( *SrcStmt )  BndDir( 'QC2LE' )  DftActGrp( *No )
     **-- Global variables:  -------------------------------------------------**
     D MsgKey          s              4a
     D MsgTxt          s            256a   Varying
     D KeyLckPos       s             10a   Varying
     **-- Panel status structure:  -------------------------------------------**
     D MatPnlSts       Ds
     D  PsBytPrv                     10i 0 Inz( %Size( MatPnlSts ) )
     D  PsBytAvl                     10i 0
     D  PsCurIplTyp                   1a
     D  PsBitMap                      1a
     D                                6a
     D  PsPrvIplTyp                   1a
     **
     D  PsUpsIns                      3i 0
     D  PsPwrFail                     3i 0
     D  PsUpsBps                      3i 0
     D  PsLowBat                      3i 0
     D  PsAutKey                      3i 0
     D  PsNrmKey                      3i 0
     D  PsManKey                      3i 0
     D  PsSecKey                      3i 0
     **-- Materialize machine attributes:  -----------------------------------**
     D MatMatr         Pr                  ExtProc( '_MATMATR1' )
     D  Atr                                Like( MatPnlSts )
     D  Opt                           2a   Const
     **-- Test bit in string:  -----------------------------------------------**
     D tstbts          Pr            10i 0 ExtProc( 'tstbts' )
     D  string                         *   Value
     D  bitofs                       10u 0 Value
     **-- Send program message:  ---------------------------------------------**
     D SndPgmMsg       Pr                  ExtPgm( 'QMHSNDPM' )
     D  SpMsgId                       7a   Const
     D  SpMsgFq                      20a   Const
     D  SpMsgDta                    128a   Const
     D  SpMsgDtaLen                  10i 0 Const
     D  SpMsgTyp                     10a   Const
     D  SpCalStkE                    10a   Const Options( *VarSize )
     D  SpCalStkCtr                  10i 0 Const
     D  SpMsgKey                      4a
     D  SpError                      10i 0 Const
     **
     C                   Callp     MatMatr( MatPnlSts: x'0168' )
     **
     C                   Eval      PsUpsIns     = tstbts( %Addr( PsBitMap ): 0 )
     C                   Eval      PsPwrFail    = tstbts( %Addr( PsBitMap ): 1 )
     C                   Eval      PsUpsBps     = tstbts( %Addr( PsBitMap ): 2 )
     C                   Eval      PsLowBat     = tstbts( %Addr( PsBitMap ): 3 )
     C                   Eval      PsAutKey     = tstbts( %Addr( PsBitMap ): 4 )
     C                   Eval      PsNrmKey     = tstbts( %Addr( PsBitMap ): 5 )
     C                   Eval      PsManKey     = tstbts( %Addr( PsBitMap ): 6 )
     C                   Eval      PsSecKey     = tstbts( %Addr( PsBitMap ): 7 )
     **
     C                   Select
     C                   When      PsAutKey     = 1
     C                   Eval      KeyLckPos    = 'Auto'
     **
     C                   When      PsNrmKey     = 1
     C                   Eval      KeyLckPos    = 'Normal'
     **
     C                   When      PsManKey     = 1
     C                   Eval      KeyLckPos    = 'Manual'
     **
     C                   When      PsSecKey     = 1
     C                   Eval      KeyLckPos    = 'Secure'
     C                   EndSl
     **
     C                   Eval      MsgTxt       = 'Current keylock position ' +
     C                                            'is ' +  KeyLckPos          +
     C                                            ' and current IPL type is ' +
     C                                            %Trim( PsCurIplTyp ) + '.'
     **
     C                   CallP     SndPgmMsg( 'CPF9897'
     C                                      : 'QCPFMSG   *LIBL'
     C                                      : MsgTxt
     C                                      : %Len( MsgTxt )
     C                                      : '*INFO'
     C                                      : '*PGMBDY'
     C                                      : 1
     C                                      : MsgKey
     C                                      : *Zero
     C                                      )
     **
     C                   Eval      *InLr       = *On
     C                   Return
     **
