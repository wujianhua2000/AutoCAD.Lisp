
;-------------------------------------------------------------------------
;
;	wujianhua, 2006-10-11,	update and comments.
;
( defun c:dmpt( / LocPnt pt0
		PointA	PointB
		n i
		Lhor myLst pt1 pt2 Offhor )

	( SYSpush )

    ( setq LocPtA ( getpoint "尺寸线标注位置:"   ) ) ( terpri )

    ( setq upLen  ( defReal  "尺寸线上端线段长度:"		upLen  0 ) )
    ( setq dnLen  ( defReal  "尺寸线下端线段长度:"		dnLen  0 ) )
    ( setq DimAng ( defAngle "尺寸线标注角度:"		DimAng 4 ) )

    ; LocPtA & LocPtB define Dimension	direction.
    ( setq LocPtB ( polar LocPtA DimAng 1000.00 ) )

    ( setq PrevPt  ( getpoint "第一个点:"				) )   ( terpri )
    ( setq PrevPt  ( ProjPt LocPtA LocPtB PrevPt    ) )
    ( setq PointA  ( polar  PrevPt ( R$D DimAng 180 ) ( WHL 2.0 ) ) )

    ( setq Done    T	)
    ( setq BasLin  nil	)
    ( setq i	   0	)

	;	标注主程序循环开始.
    ( while Done
		( setvar "OSMODE" oldosp )
		( setq NextPt ( getpoint PrevPt "下一个点:" ) )		( terpri )

		( if ( null NextPt )
			( progn
				( setq Done nil )
				( prompt "命令结束!" )
			)

			( progn
				( setq NextPt  ( ProjPt LocPtA LocPtB NextPt ) )
				( if ( = i 0 )		( StopLn  PrevPt ) )
				( StopLn  NextPt )
				( setq PointB ( polar NextPt DimAng ( WHL 2.0 ) ) )
				( setq myDist ( distance PrevPt NextPt ) )

				( curlay "_DIMTEXT" )
				( GenText ( polar PrevPt DimAng ( / myDist 2.00 ) )
					  "BC"
					  2.50
					  DimAng
					  ( rtos myDist 2 0 )
				)   
				; >> GenText << statement end.

				( if ( = ( type BasLin ) 'ENAME )			( command "ERASE" BasLin "" )	)
				( curlay "_DIMLINE" )
				( command "LINE" PointA PointB "" )
				( setq BasLin ( entlast ) )

				( setq PrevPt NextPt   )
				( setq i      ( 1+ i ) )
		    )	
			; >> PROGN << statement end.
			;
		)   
		; >> IF << statement end.
		;
    )	
	; >> WHILE << statement end.
	;

	( SYSpops )
)

;-------------------------------------------------------------------------
( defun StopLn( vtPnt / pt1 pt2 )
    ( curlay "_DIMLINE"   )
    ( setvar "OSMODE"   0 )

    ( bar vtPnt DimAng )

    ( setq pt1 ( polar vtPnt ( R$D DimAng  90 ) ( WHL upLen ) ) )
    ( setq pt2 ( polar vtPnt ( R$D DimAng 270 ) ( WHL dnLen ) ) )
    ( command "line" pt1 pt2 "" )
    ( setvar "OSMODE"  oldosp )
)

;-------------------------------------------------------------------------
( defun ProjPt( vtLPt1 vtLPt2 vtPtA / vtPtB vtAng )
    ( setq vtAng ( angle vtLPt1 vtLPt2 ) )

    ( setq vtPtB  ( polar vtPtA ( R$D vtAng -90 ) 1000.00 ) )
    ( inters vtLPt1 vtLPt2 vtPtA vtPtB nil )
)

