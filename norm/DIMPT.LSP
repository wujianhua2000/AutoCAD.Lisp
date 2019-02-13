
;-------------------------------------------------------------------------
;
;	wujianhua, 2006-10-11,	update and comments.
;
( defun c:dmpt( / LocPnt pt0
		PointA	PointB
		n i
		Lhor myLst pt1 pt2 Offhor )

	( SYSpush )

    ( setq LocPtA ( getpoint "�ߴ��߱�עλ��:"   ) ) ( terpri )

    ( setq upLen  ( defReal  "�ߴ����϶��߶γ���:"		upLen  0 ) )
    ( setq dnLen  ( defReal  "�ߴ����¶��߶γ���:"		dnLen  0 ) )
    ( setq DimAng ( defAngle "�ߴ��߱�ע�Ƕ�:"		DimAng 4 ) )

    ; LocPtA & LocPtB define Dimension	direction.
    ( setq LocPtB ( polar LocPtA DimAng 1000.00 ) )

    ( setq PrevPt  ( getpoint "��һ����:"				) )   ( terpri )
    ( setq PrevPt  ( ProjPt LocPtA LocPtB PrevPt    ) )
    ( setq PointA  ( polar  PrevPt ( R$D DimAng 180 ) ( WHL 2.0 ) ) )

    ( setq Done    T	)
    ( setq BasLin  nil	)
    ( setq i	   0	)

	;	��ע������ѭ����ʼ.
    ( while Done
		( setvar "OSMODE" oldosp )
		( setq NextPt ( getpoint PrevPt "��һ����:" ) )		( terpri )

		( if ( null NextPt )
			( progn
				( setq Done nil )
				( prompt "�������!" )
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
