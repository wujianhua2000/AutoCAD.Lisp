;
;------------------------------------------------------------------------------
;
;( defun c:lt( / pt1 pt2 num Dep oldlay
;		 dx dy i Ang myAng dxd4
;		 pnt1 pnt2 pnt3 pnt4 pnt11 pnt12 pnt21 pnt22 )
;
;	wujianhua,	2007-11-27, local.
;
( defun c:ltlt( )
    ( SYSpush )

    ( setq pt1 ( getpoint     "第一点（起步）: " ) ) ( terpri )
    ( setq pt2 ( getpoint pt1 "第二点（结束）:" ) ) ( terpri )
    ( if ( NOT ( AND pt1 pt2 ) ) ( exit ) )

    ( setq num ( getint       "踏步数:" ) ) ( terpri )
    ( setq Dep ( getint       "梯板厚:" ) ) ( terpri )

    ( setq dx  ( - ( car  pt2 ) ( car  pt1 ) ) )
    ( setq dy  ( - ( cadr pt2 ) ( cadr pt1 ) ) )
    ( setq dx  ( / dx ( 1- num ) ) )
    ( setq dy  ( / dy num	 ) )
    ( if ( minusp dx )
	  ( setq myAng ( / pi  2.00 ) )
	  ( setq myAng ( / pi -2.00 ) )
    )

    ( setq i   0 )
    ( setq pnt1 pt1 )
    ( setvar "OSMODE" 0 )

    ; steps line
    ( curlay "SOLID_LINE" )
    ( repeat ( * num 2 )
		( if (	= 0 ( rem i 2 ) )
			( setq pnt2 ( polar pnt1 ( * 0.50 pi ) dy ) )
			( setq pnt2 ( polar pnt1 0.00	       dx ) )
		)
		( command "LINE" pnt1 pnt2 "" )
		( setq pnt1 pnt2 )
		( setq i ( 1+ i ) )
    )

    ; step slab bottom line
    ( setq Ang ( angle pt1 pnt2 ) )
    ( setq pnt1 ( polar pt1  ( + Ang myAng ) Dep ) )
    ( setq pnt2 ( polar pnt2 ( + Ang myAng ) Dep ) )
    ( command "LINE" pnt1 pnt2 "" )

    ( setvar "PLINEWID" ( WHL 0.50 ) )

    ; bottom steel bar ( +M bar )
    ( curlay "SOLID_STEEL" )
    ( setq pnt1 ( polar pnt1 ( - Ang myAng ) ( WHL 1.00 ) ) )
    ( setq pnt2 ( polar pnt2 ( - Ang myAng ) ( WHL 1.00 ) ) )
    ( command "PLINE" pnt1  pnt2 "" )

    ; top steel bar ( -M bar )
    ( setq dx	( - ( car  pt2 ) ( car	pt1 ) ) )
    ( setq dy	( - ( cadr pt2 ) ( cadr pt1 ) ) )
    ( setq dxd4 ( atoi ( rtos dx 2 0 ) ) )

    ( if ( /= 0 ( rem dxd4 200 ) )
	( if ( > dxd4 0 )
	    ( setq dxd4 ( * ( 1+ ( / dxd4 200 ) ) 50 ) )
	    ( setq dxd4 ( * ( 1- ( / dxd4 200 ) ) 50 ) )
	)
	( setq dxd4 ( / dxd4  4 ) )
    )

    ( setq pnt1 ( polar pnt1 ( - Ang myAng ) ( - Dep ( * 1.50 scale ) ) ) )
    ( setq pnt2 ( polar pnt2 ( - Ang myAng ) ( - Dep ( * 1.50 scale ) ) ) )

    ( setq pnt3  ( mapcar '+ pt1  ( list dxd4 0.00 0.00 ) ) )
    ( setq pnt4  ( mapcar '+ pnt3 ( list 0.00 dy   0.00 ) ) )
    ( setq pnt11 ( inters pnt1 pnt2 pnt3 pnt4 nil ) )
;   ( command "PLINE" pnt1 pnt11 "" )

    ( setq pnt12 ( polar pnt11 ( + Ang myAng ) ( - Dep ( * 1.00 scale ) ) ) )
    ( command "PLINE" pnt1 pnt11 pnt12 "" )

    ( setq pnt3  ( mapcar '- pt2  ( list dxd4 0.00 0.00 ) ) )
    ( setq pnt4  ( mapcar '- pnt3 ( list 0.00 dy   0.00 ) ) )
    ( setq pnt21 ( inters pnt1 pnt2 pnt3 pnt4 nil ) )
;   ( command "PLINE" pnt2 pnt21 "" )

    ( setq pnt22 ( polar pnt21 ( + Ang myAng ) ( - Dep ( * 1.00 scale ) ) ) )
    ( command "PLINE" pnt2 pnt21 pnt22 "" )

    ( SYSpops )
)
