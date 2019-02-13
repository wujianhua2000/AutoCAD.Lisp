;-------------------------------------------------------------------------
;	2006-10-08	wujianhua	全局比例的读取.
;
;
( defun SYSpush( )
    ( graphscr )

    ;( setq   olderr	*error* )
    ;( setq   *error*	stderr	)

    ( setq   oldlay	( getvar "CLAYER"    ) )
    ( setq   oldosp	( getvar "OSMODE"    ) )
    ( setq   oldsty	( getvar "TEXTSTYLE" ) )
    ( setq   oldPLW	( getvar "PLINEWID"  ) )
    ( setvar "blipmode"  0     )
    ( setvar "cmdecho"   0     )

	;	读取全局的变量，比例尺。
	( setq scale ( getvar "USERR1" ) )

    ( command "_UNDO" "GROUP" )
)

;-------------------------------------------------------------------------
( defun SYSpops( )
    ;( setq   *error*	  olderr    )
    
	( curlay oldlay		    )

    ( setvar "OSMODE"     oldosp    )
    ( setvar "TEXTSTYLE"  oldsty    )
    ( setvar "PLINEWID"   oldPLW    )

    ( command "_UNDO"     "END"     )
    ( setvar "BLIPMODE"   1         )
    ( setvar "CMDECHO"    1         )
    ( princ )
)

;-------------------------------------------------------------------------
; Modified Memo ::
;	Date		Because
;	Jul-19-96	a PROCEDURCE: define a default variable of integer.
;			tmpInt : default integer variable
;			varInt : store integer value variable
;			msg    : prompt message
;	Feb-16-97	using STRCAT to verkurzen PROMPT statement.
;
( defun defInt( Msg tmpInt / varInt )
    ( if ( = tmpInt nil ) ( setq tmpInt 0 ) )
    ( prompt ( strcat Msg  "<"  ( itoa tmpInt ) ">:" ) )
    ( setq varInt ( getint ) )	  ( terpri )
    ( if ( = varInt nil ) ( setq varInt tmpInt ) )
    varInt
)

;-------------------------------------------------------------------------
; Modified Memo ::
;	Date		Because
;	Jul--19--96	a PROCEDURCE: define a default variable of double.
;			varReal : store double value variable
;			msg    : prompt message
;			tmpReal : default double variable
;
;	Jul--21--96	add a variable for set up double precision.
;			precs	: set up double dot-bits-num/precision.
;
( defun defReal( Msg tmpR precs / varReal )
    ( if ( = tmpR nil ) ( setq tmpR 0.00 ) )
    ( prompt ( strcat Msg  "<"  ( rtos TmpR 2 precs ) ">:" ) )
    ( setq varReal ( getreal ) )    ( terpri )
    ( if ( = varReal nil ) ( setq varReal tmpR ) )
    varReal
)
;------------------------------------------------------------------------------
; Modified Memo ::
;	Date		Because
;	Jul--19--96	a PROCEDURCE: define a default variable of Angle.
;			varAng : store angle value variable
;			msg    : prompt message
;			tmpAng : default angle variable
;	Jul--21--96	add a variable for set up Angle precision.
;			precs	: set up Angle dot-bits-num/precision.
( defun defAngle( Msg tmpAng precs / varAng )
    ( if ( = tmpAng nil ) ( setq tmpAng 0.00 ) )
    ( prompt ( strcat Msg  "<"  ( angtos TmpAng 0 precs )  ">:" ) )
    ( setq  varAng ( getangle ) )    ( terpri )
    ( if ( = varAng nil ) ( setq varAng tmpAng ) )
    varAng
)

;------------------------------------------------------------------------------
; Modified Memo ::
;	Date		Because
;	Feb--15--97	a PROCEDURCE: define a default variable of String.
;			varTxt : store text variable
;			msg    : prompt message
;			tmpTxt : default text variable
;
( defun defText( Msg tmpTxt / varTxt )

    ( if ( = tmpTxt nil ) ( setq tmpTxt "" ) )

    ( prompt ( strcat Msg  "<"  TmpTxt  ">:"  ) )
    ( setq varTxt ( getstring ) )    ( terpri )
    ( if ( = ( strlen varTxt ) 0 ) ( setq varTxt TmpTxt ) )

	varTxt
)

;------------------------------------------------------------------------------
;
( defun stderr( msg )
    ( if ( /= msg "Function cancelled" )
	 ( princ ( strcat "\nError: " msg ) )
    )
    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun curSee( Aview )
  ( if ( tblsearch "VIEW" Aview )
    ( progn
	( command "VIEW" "R" Aview )
    )
    ( progn
	( command "ZOOM" "A" )
	( command "VIEW" "S" Aview )
    )
  )
)

;------------------------------------------------------------------------------
;
( defun curlay( ALayer )
    ( if ( tblsearch "layer" ALayer )
	( command "layer" "S" ALayer "" )
	( cond
	    ( ( = ALayer "CENTER"       )
		( command "LAYER" "M" ALayer "L" "CENTER" ""  "C"  "red"     ""    "" ) )
	    ( ( = ALayer "SOLID_STEEL"  )
		( command "LAYER" "M" ALayer                  "C"  "green"   ""    "" ) )
	    ( ( = ALayer "DASHED_STEEL" )
		( command "LAYER" "M" ALayer "L" "HIDDEN" ""  "C"  "yellow"  ""    "" ) )
	    ( ( = ALayer "TEMPLAYER"    )
		( command "LAYER" "M" ALayer                  "C"  "cyan"    ""    "" ) )
	    ( T
		( command "layer" "M" ALayer                                       "" ) )
	)   ; END cond.
    )	; END if.
)

;------------------------------------------------------------------------------
( defun cursty( myStil )
    ( if ( tblsearch "style" myStil )
		( setvar "TEXTSTYLE" myStil )
		( cond
			( ( = myStil "ROMANS08" )
				( command "STYLE"  myStil  "ROMANS.SHX"            ""  "0.800"  ""  ""  ""  "" ) 
			)
			
			( ( = myStil "ROMANS05" )
				( command "STYLE"  myStil  "ROMANS.SHX"            ""  "0.500"  ""  ""  ""  "" ) 
			)
			
			( ( = myStil "ROMANC08" )
				( command "STYLE"  myStil  "ROMANC.SHX"            ""  "0.800"  ""  ""  ""  "" ) 
			)
			
			( ( = myStil "ROMANC05" )
				( command "STYLE"  myStil  "ROMANC.SHX"            ""  "0.500"  ""  ""  ""  "" ) 
			)

			( ( = myStil "ROMAND08" )
				( command "STYLE"  myStil  "ROMAND.SHX,CHINA.SHX"  ""  "0.800"  ""  ""  ""  "" ) 
			)
			
			( ( = myStil "ROMAND05" )
				( command "STYLE"  myStil  "ROMAND.SHX"            ""  "0.500"  ""  ""  ""  "" ) 
			)
			
			( T 			nil	)
		)
    )
)

;------------------------------------------------------------------------------
;
( defun dtor( vtAng )
   ( * PI ( / vtAng 180.0 ) )
)
( defun rtod( vtAng )
   ( * 180.0 ( / vtAng PI ) )
)
( defun R$D( vtAng1 vtAng2 )
    ( + vtAng1 ( dtor vtAng2 ) )
)

;	宽\高\长.
;
( defun WHL( vtReal )
    ( * scale vtReal )
)

;------------------------------------------------------------------------------
;
( defun box( ptA ptB / dx dy )
    ( setq dx ( - ( car  ptB ) ( car  ptA ) ) )
    ( setq dy ( - ( cadr ptB ) ( cadr ptA ) ) )

    ( command "pline"
	      ptA
	      ( polar ptA 0.00		 dx )
	      ptB
	      ( polar ptA ( * PI  0.50 ) dy )
	      ptA
	      ""
    )
)

;------------------------------------------------------------------------------
;
;
;
( defun GenText( vtPnt vtJust vtHei vtAng vtTxt  / vtDir vtOff	)
    ( cond
		( ( = vtJust  "BC" ) ( setq vtDir  90.00   vtOff  0.50 ) )
		( ( = vtJust  "TC" ) ( setq vtDir -90.00   vtOff  0.50 ) )
		( ( = vtJust  "MC" ) ( setq vtDir  90.00   vtOff  0.00 ) )
		( T					 ( setq vtDir   0.00   vtOff  0.00 ) )
    )

    ( setvar "OSMODE" 0 )
    ( command "TEXT"
	      "J"  vtJust
	      ( polar vtPnt ( R$D vtAng vtDir ) ( WHL vtOff ) )
	      ( WHL  vtHei )
	      ( rtod vtAng )
	      vtTxt
    )
)

;------------------------------------------------------------------------------
( defun isHZCH( vtText )
    ( if ( < ( strlen vtText ) 2 )
	nil
	( AND ( <= 161 ( ascii		vtText	   ) )
	      ( <= 161 ( ascii ( substr vtText 2 ) ) )
	)
    )
)

;-------------------------------------------------------------------------
( defun DeltaXYZ( vPoint dx dy dz )
    ( mapcar '+ vPoint ( List dx dy dz ) )
)
( defun DeltaXY( vPoint dx dy )
    ( mapcar '+ vPoint ( List  dx  dy  0.00 ) )
)
( defun DeltaX( vPoint dx )
    ( mapcar '+ vPoint ( List  dx  0.00  0.00 ) )
)
( defun DeltaY( vPoint dy )
    ( mapcar '+ vPoint ( List  0.00  dy  0.00 ) )
)
( defun DeltaZ( vPoint dz )
    ( mapcar '+ vPoint ( List  0.00  0.00  dz ) )
)

;------------------------------------------------------------------------------
