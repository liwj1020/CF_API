/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHGOBJAUT )                                        */
/*           Pgm( CBX931 )                                           */
/*           SrcMbr( CBX931X )                                       */
/*           VldCkr( CBX931V )                                       */
/*           HlpPnlGrp( CBX931H )                                    */
/*           HlpId( *CMD )                                           */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Change Object Authority' )

          Parm     OBJ         Q0001                  +
                   Min( 1 )                           +
                   Choice( *NONE )                    +
                   Prompt( 'Object' 1 )

          Parm     OBJTYPE     *Char        7         +
                   Rstd( *YES )                       +
                   SpcVal(( *ALL    )                 +
                          ( *ALRTBL )                 +
                          ( *BNDDIR )                 +
                          ( *CFGL   )                 +
                          ( *CHTFMT )                 +
                          ( *CLD    )                 +
                          ( *CLS    )                 +
                          ( *CMD    )                 +
                          ( *CNNL   )                 +
                          ( *COSD   )                 +
                          ( *CRG    )                 +
                          ( *CRQD   )                 +
                          ( *CSI    )                 +
                          ( *CSPMAP )                 +
                          ( *CSPTBL )                 +
                          ( *CTLD   )                 +
                          ( *DEVD   )                 +
                          ( *DTAARA )                 +
                          ( *DTADCT )                 +
                          ( *DTAQ   )                 +
                          ( *EDTD   )                 +
                          ( *FCT    )                 +
                          ( *FILE   )                 +
                          ( *FNTRSC )                 +
                          ( *FNTTBL )                 +
                          ( *FORMDF )                 +
                          ( *FTR    )                 +
                          ( *GSS    )                 +
                          ( *IMGCLG )                 +
                          ( *IPXD   )                 +
                          ( *JOBD   )                 +
                          ( *JOBQ   )                 +
                          ( *JOBSCD )                 +
                          ( *JRN    )                 +
                          ( *JRNRCV )                 +
                          ( *LIB    )                 +
                          ( *LIND   )                 +
                          ( *LOCALE )                 +
                          ( *M36    )                 +
                          ( *M36CFG )                 +
                          ( *MEDDFN )                 +
                          ( *MENU   )                 +
                          ( *MGTCOL )                 +
                          ( *MODD   )                 +
                          ( *MODULE )                 +
                          ( *MSGF   )                 +
                          ( *MSGQ   )                 +
                          ( *NODGRP )                 +
                          ( *NODL   )                 +
                          ( *NTBD   )                 +
                          ( *NWID   )                 +
                          ( *NWSD   )                 +
                          ( *OUTQ   )                 +
                          ( *OVL    )                 +
                          ( *PAGDFN )                 +
                          ( *PAGSEG )                 +
                          ( *PDG    )                 +
                          ( *PGM    )                 +
                          ( *PNLGRP )                 +
                          ( *PRDAVL )                 +
                          ( *PRDDFN )                 +
                          ( *PRDLOD )                 +
                          ( *PSFCFG )                 +
                          ( *QMFORM )                 +
                          ( *QMQRY  )                 +
                          ( *QRYDFN )                 +
                          ( *RCT    )                 +
                          ( *S36    )                 +
                          ( *SBSD   )                 +
                          ( *SCHIDX )                 +
                          ( *SPADCT )                 +
                          ( *SQLPKG )                 +
                          ( *SQLUDT )                 +
                          ( *SRVPGM )                 +
                          ( *SSND   )                 +
                          ( *SVRSTG )                 +
                          ( *TBL    )                 +
                          ( *USRIDX )                 +
                          ( *USRPRF )                 +
                          ( *USRQ   )                 +
                          ( *USRSPC )                 +
                          ( *VLDL   )                 +
                          ( *WSCST  ))                +
                   Min( 1 )                           +
                   Expr( *YES )                       +
                   Prompt( 'Object type' 2 )

          Parm     USER        *Name       10         +
                   SpcVal(( *PUBLIC ))                +
                   Min( 1 )                           +
                   Expr( *YES )                       +
                   Prompt( 'User' 4 )

          Parm     CURAUT      *Char       10         +
                   Rstd( *YES )                       +
                   Dft( *CHANGE )                     +
                   SpcVal(( *OBJALTER )               +
                          ( *OBJEXIST )               +
                          ( *OBJMGT   )               +
                          ( *OBJOPR   )               +
                          ( *OBJREF   )               +
                          ( *ADD      )               +
                          ( *DLT      )               +
                          ( *READ     )               +
                          ( *UPD      )               +
                          ( *EXECUTE  ))              +
                   SngVal(( *CHANGE  )                +
                          ( *ALL     )                +
                          ( *USE     )                +
                          ( *EXCLUDE )                +
                          ( *AUTL    ))               +
                   Max( 10 )                          +
                   Expr( *YES )                       +
                   Prompt( 'Current authority' 5)

          Parm     NEWAUT      *Char       10         +
                   Rstd( *YES )                       +
                   Dft( *CHANGE )                     +
                   SpcVal(( *OBJALTER )               +
                          ( *OBJEXIST )               +
                          ( *OBJMGT   )               +
                          ( *OBJOPR   )               +
                          ( *OBJREF   )               +
                          ( *ADD      )               +
                          ( *DLT      )               +
                          ( *READ     )               +
                          ( *UPD      )               +
                          ( *EXECUTE  ))              +
                   SngVal(( *CHANGE  )                +
                          ( *ALL     )                +
                          ( *USE     )                +
                          ( *EXCLUDE )                +
                          ( *AUTL    ))               +
                   Max( 10 )                          +
                   Expr( *YES )                       +
                   Prompt( 'New authority' 5)

Q0001:    Qual                 *Generic    10         +
                   SpcVal(( *ALL ))                   +
                   Min( 1 )                           +
                   Expr( *YES )

          Qual                 *Name       10         +
                   Dft( *LIBL )                       +
                   SpcVal(( *LIBL    )                +
                          ( *CURLIB  )                +
                          ( *ALL     )                +
                          ( *ALLUSR  )                +
                          ( *USRLIBL ))               +
                   Expr( *YES )                       +
                   Prompt( 'Library' )

          Dep      Ctl( &OBJ *EQ QTEMP )              +
                   Parm(( &OBJTYPE *NE 'LIB' ))       +
                   MsgId( CPD2258 )

          Dep      Ctl( &NEWAUT *EQ '*AUTL' )         +
                   Parm(( &USER *EQ *PUBLIC ))        +
                   MsgId( CPF22A0 )

          Dep      Ctl( *ALWAYS )                     +
                   Parm(( &CURAUT *EQ &NEWAUT ))      +
                   NbrTrue( *EQ 0 )                   +
                   MsgId( CPF7054 )

