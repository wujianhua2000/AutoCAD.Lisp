
;------------------------------------------------------------------------------
;
( defun c:YYY( / inspt X pt1 pt2 oldlay maxPnt minPnt )
    ( SYSpush )

    ( command "xline" "V"  )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
;
( defun c:XXX( / inspt Y pt1 pt2 oldlay maxPnt minPnt )
    ( SYSpush )

    ( command "xline" "H"  )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	将一条直线转换成为折断线。
;
( defun c:brkln( / pt1 pt2 pnt1 pnt2 pnt3 pnt4 midpt myAng myLen mySel  myLin  Done  )
	
	( SYSpush )

    ( prompt "选取一条要转换成为折断线的直线:" )   ( terpri )
    ( setq mySel ( ssget ) )

    ( setq myLin ( entget ( ssname mySel 0 ) ) )
    ( if ( = ( cdr ( assoc 0 myLin ) ) "LINE" )
		( setq Done 1 )
		( setq mySel nil )
    )

    ( setq pt1	   ( cdr ( assoc 10 myLin ) ) )
    ( setq pt2	   ( cdr ( assoc 11 myLin ) ) )
    ( setq myAng   ( angle    pt1 pt2	  ) )
    ( setq myLen   ( distance pt1 pt2	  ) )
    ( setq midpt   ( polar pt1 myAng ( * myLen 0.50 ) ) )

    ( if ( < myLen ( WHL 6.0 ) )
		( progn
			( setq pt1 ( polar midpt myAng ( WHL -3.00 ) ) )
			( setq pt2 ( polar midpt myAng ( WHL  3.00 ) ) )
		)
    )

    ( setq pnt1    ( polar midpt myAng					( WHL -0.75 ) ) )
    ( setq pnt2    ( polar pnt1  ( R$D myAng -60.0 )	( WHL  1.00 ) ) )
    ( setq pnt4    ( polar midpt myAng					( WHL  0.75 ) ) )
    ( setq pnt3    ( polar pnt4  ( R$D myAng 120.0 )	( WHL  1.00 ) ) )

    ( curlay  "SOLID_STEEL"      )
    ( setvar  "OSMODE"      0    )
    ( command "PLINEWID"    0.00 )
    ( command "pline"  pt1  pnt1 pnt2 pnt3 pnt4  pt2  ""  )
    ( command "erase"  mySel "" )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:lnzs( / pt1  pt2  pnt1  pnt2	pnt3  pnt4  midpt  myAng  myLen  )
    ( SYSpush )

    ( setq pt1	   ( getpoint	   "No.1 point " ) )   ( terpri )
    ( setq pt2	   ( getpoint pt1  "No.2 point " ) )   ( terpri )

    ( setq myAng  ( angle    pt1 pt2 ) )
    ( setq myLen  ( distance pt1 pt2 ) )
    ( setq midpt  ( polar pt1 myAng ( * myLen 0.50 ) ) )

    ( if ( < myLen ( WHL 6.0 ) )
	( progn
	    ( setq pt1 ( polar midpt myAng ( WHL -3.00 ) ) )
	    ( setq pt2 ( polar midpt myAng ( WHL  3.00 ) ) )
	)
    )

    ( setq pnt1    ( polar midpt myAng		     ( WHL -0.75 ) ) )
    ( setq pnt2    ( polar pnt1  ( R$D myAng -60.0 ) ( WHL  1.00 ) ) )
    ( setq pnt4    ( polar midpt myAng		     ( WHL  0.75 ) ) )
    ( setq pnt3    ( polar pnt4  ( R$D myAng 120.0 ) ( WHL  1.00 ) ) )

    ( curlay  "SOLID_STEEL"     )
    ( setvar  "OSMODE"        0 )
    ( command "PLINEWID"   0.00 )
    ( command "pline"  pt1  pnt1 pnt2 pnt3 pnt4  pt2  ""  )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:aaale( )
    ( SYSpush )

    ( prompt "Select a line  : " )   ( terpri )
    ( setq Sel ( ssget ) )
    ( setq Lin ( entget ( ssname Sel 0 ) ) )

;   ( if ( = ( cdr ( assoc 0 Lin ) ) "LINE" )
;	( setq Done 1 )
;	( setq Sel nil )
;   )

    ( setq pt1	   ( cdr ( assoc 10 Lin ) ) )
    ( setq pt2	   ( cdr ( assoc 11 Lin ) ) )
    ( setq linAng  ( angle pt1 pt2	  ) )

    ( setq pi_05    ( * pi 0.50 ) )
    ( setq pi_15    ( * pi 1.50 ) )
    ( setq pi_20    ( * pi 2.00 ) )

    ( cond
	( ( > linAng pi_15 )
	    ( progn
		( setq linAng ( - linAng pi_20 ) )
		( prompt "-" ( angtos linAng 0 4 )  )
	    )
	)
	( ( > linAng pi    )
	    ( progn
		( setq linAng ( - linAng pi  ) )
		( prompt ( angtos linAng 0 4 )	)
	    )
	)
	( ( > linAng pi_05 )
	    ( progn
		( setq linAng ( - linAng pi ) )
		( prompt "-" ( angtos linAng 0 4 )  )
	    )
	)
	( ( > linAng 0.00  )
	    ( progn
;		( setq linAng ( - pi_20 linAng	) )
		( prompt ( angtos linAng 0 4 )	)
	    )
	)
    )

;   ( if ( > linAng pi_2 )
;	( progn
;	    ( prompt rtod( linAng ) )
;	)

;	( progn
;	    ( prompt rtod( linAng ) )
;	)
;   )

    ( SYSpops )
)
