;
;------------------------------------------------------------------------------
;
;
( defun c:ptpt( / pt1 pt2 pt )
  ( SYSpush )

  ( setq pt1	  ( getpoint "Select first  POINT:" ) ) ( terpri )
  ( setq pt2	  ( getpoint "Select second POINT:" ) ) ( terpri )
  ( setq pt	  ( mapcar '( lambda ( x y )  ( / ( + x y ) 2.0 )  )
			    pt1 pt2
		  )
  )

  ( setvar "OSMODE" 0 )
  ( command "point" pt )

  ( SYSpops )
)

;------------------------------------------------------------------------------
;
;
( defun c:ptln( / Done pt1 pt2 pt pnt X Y X1 Y1 K Ang1 Ang2 Lin )
    ( SYSpush )

    ; SELECT A POINT
    ( prompt "Select a point  : " )  ( terpri )
    ( setq pt ( getpoint ) )	     ( terpri )

    ; SELECT A LINE
    ( setq Done 0 )
    ( if ( = Done 0 )
	( progn
	    ( prompt "Select a line  : " )
	    ( terpri )
	    ( setq Sel ( ssget ) )
	    ( setq Lin ( entget ( ssname Sel 0 ) ) )

	    ( if ( = ( cdr ( assoc 0 Lin ) ) "LINE" )
		( setq Done 1 )
		( setq Sel nil )
	    )
	)
    )

    ( setq pt1 ( cdr ( assoc 10 Lin ) ) )
    ( setq pt2 ( cdr ( assoc 11 Lin ) ) )
    ( setq Ang1 ( angle pt1 pt2 )  )
    ( setq Ang2 ( angtos Ang1 0 0 ) )

    ( setq Done 0 )

    ; Select line is VER LINE
    ( if ( or ( = Ang2 "90" ) ( = Ang2 "270" ) )
	 ( progn
	     ( setq pnt ( list ( car pt1 ) ( car ( cdr pt ) ) ( last pt ) ) )
	     ( setq Done 1 )
	 )
    )

    ; Select line is HOR LINE
    ( if ( = Ang2 "0" )
	 ( progn
	     ( setq pnt ( list ( car pt ) ( car ( cdr pt1 ) ) ( last pt ) ) )
	     ( setq Done 1 )
	 )
    )

    ; Select LINE is
    ( if ( = Done 0 )
	 ( progn
	     ( setq Ang1 ( + Ang1 ( / pi 2.00 ) ) )
	     ( setq K	 ( / ( sin Ang1 ) ( cos Ang1 ) ) )
	     ( setq X1	 ( car pt ) )
	     ( setq Y1	 ( car ( cdr pt ) ) )
	     ( setq X	 ( + X1 1.00 ) )
	     ( setq Y	 ( + ( * K ( - X X1 ) ) Y1 ) )
	     ( setq pnt  ( list X Y ( last pt ) ) )
	     ( setq pnt  ( inters pt1 pt2 pt pnt nil ) )
	 )
    )

    ( setvar "OSMODE" 0 )
    ( command "POINT" pnt )

    ( SYSpops )
)
;------------------------------------------------------------------------------
;
;
( defun c:lnln(  / Allsel Lin1 Lin2 pt1 pt2 pt3 pt4 )
    ( SYSpush )

    ( prompt "Select 2 line :"   ) ( terpri )
    ( setq Allsel ( ssget ) )

    ( setq Lin1     ( entget ( ssname Allsel 0 ) ) )
    ( setq pt1	    ( cdr ( assoc 10 Lin1 ) ) )
    ( setq pt2	    ( cdr ( assoc 11 Lin1 ) ) )

    ( setq Lin2     ( entget ( ssname Allsel 1 ) ) )
    ( setq pt3	    ( cdr ( assoc 10 Lin2 ) ) )
    ( setq pt4	    ( cdr ( assoc 11 Lin2 ) ) )

    ( setvar "OSMODE" 0 )
    ( command "point" ( inters pt1 pt2 pt3 pt4 nil ) )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:+non( )  ( setvar "OSMODE"                                   0   ) )
( defun c:+end( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )    1 ) ) )
( defun c:+mid( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )    2 ) ) )
( defun c:+cen( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )    4 ) ) )
( defun c:+nod( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )    8 ) ) )
( defun c:+qua( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )   16 ) ) )
( defun c:+int( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )   32 ) ) )
( defun c:+ins( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )   64 ) ) )
( defun c:+per( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )  128 ) ) )
( defun c:+tan( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )  256 ) ) )
( defun c:+nea( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" )  512 ) ) )
( defun c:+qui( )  ( setvar "OSMODE" ( boole  6 ( getvar "OSMODE" ) 1024 ) ) )

;------------------------------------------------------------------------------
