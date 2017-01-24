     **-- Program description:  ----------------------------------------------**
     **
     **   After proper registration of this program as a password validation
     **   exit program (see below), this program will be called whenever the
     **   Change Password (CHGPWD) command or the Change Password (QSYCHGPW)
     **   API is executed.
     **
     **   More than one program can be registered to the password validation
     **   exit point and the validation programs will be called in turn until
     **   all programs have been called - or a until a reject return code is
     **   received.
     **
     **   The objective of the password validation process in this program
     **   is to prevent users from entering a default password as the new
     **   password.  A default password describes the situation where the
     **   password and the user profile name is the same.
     **
     **
     **-- Exit point registration:  ------------------------------------------**
     **
     **   ChgSysVal SysVal( QPWDVLDPGM )  Value( *REGFAC )
     **
     **   AddExitPgm ExitPnt( QIBM_QSY_VLD_PASSWRD )
     **              Format( VLDP0100 )
     **              PgmNbr( 1 )
     **              Pgm( <library name>/CBX901 )
     **              Text( 'Password validation exit' )
     **
     **
     **   Exit point documentation:
     **   http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/xsyvlphr.htm
     **
     **
     **-- Compilation specification:  ----------------------------------------**
     **
     **   CrtRpgMod Module( CBX901 )   DbgView( *NONE )
     **   CrtPgm    Pgm( CBX901 )      Module( CBX901 )   ActGrp( QILE )
     **
     **
     **-- Exit format VLDP0100:  ---------------------------------------------**
     D VLDP0100        Ds           324
     D  VpExpNam                     20a
     D  VpExpFmtNam                   8a
     D  VpPwdLvl                     10i 0
     D  VpUsrPrf                     10a
     D                                2a
     D  VpOfsOldPwd                  10i 0
     D  VpLenOldPwd                  10i 0
     D  VpCcsOldPwd                  10i 0
     D  VpOfsNewPwd                  10i 0
     D  VpLenNewPwd                  10i 0
     D  VpCcsNewPwd                  10i 0
     **
     D VpOldPwd        s            128a   Based( pVpOldPwd )
     D VpNewPwd        s            128a   Based( pVpNewPwd )
     **-- Global constants:  -------------------------------------------------**
     D Accept          c                   '0'
     D Reject          c                   '1'
     **-- Parameters:  -------------------------------------------------------**
     D PxRtnInd        s              1a
     **
     C     *Entry        Plist
     C                   Parm                    VLDP0100
     C                   Parm                    PxRtnInd
     **
     **-- Validate password:  ------------------------------------------------**
     **
     C                   If        VpExpNam    = 'QIBM_QSY_VLD_PASSWRD'  And
     C                             VpExpFmtNam = 'VLDP0100'
     **
     C                   Eval      pVpOldPwd  =  %Addr( VLDP0100 ) + VpOfsOldPwd
     C                   Eval      pVpNewPwd  =  %Addr( VLDP0100 ) + VpOfsNewPwd
     **
     C                   If        VpNewPwd    = VpUsrPrf
     C                   Eval      PxRtnInd    = Reject
     **
     C                   Else
     C                   Eval      PxRtnInd    = Accept
     C                   EndIf
     C                   EndIf
     **
     C                   Eval      *InLr       = *On
     C                   Return
     **
