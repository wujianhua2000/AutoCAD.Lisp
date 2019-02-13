
;	改变多义线的宽度。
;
;	wujianhua	2006-10-10	加注释
;
(defun c:wpl( / mySel myEnt myHnd myNam myCol myWid
				outRad_out innRad myPtc )
	( SYSpush )
	( curlay "SOLID_STEEL" )

	( if ( not miWid )
		( setq myWid 0.30 )
	)

	( setq myWid  ( defReal "请输入新的线宽" myWid 2 ) )

	( prompt "\n请选择需变线宽的线段:" )
	( setq mySel ( ssget ) )

	( while ( and mySel ( setq myEnt ( ssname mySel 0 ) ) )
		( setq myHnd ( entget myEnt )
			   mySel ( ssdel  myEnt mySel )
			   myNam ( cdr ( assoc  0 myHnd ) )
			   myCol ( cdr ( assoc 62 myHnd ) )
			   myLay ( cdr ( assoc  8 myHnd ) )
		)
		( if ( = myNam "LINE" )
			( command "pedit" myEnt "y" "w" ( WHL myWid ) "")
		)
		( if ( = myNam "LWPOLYLINE" )
			( command "pedit" myEnt "w" ( WHL myWid ) "" )
		)
		( if ( = myNam "ARC" )
			 ( command "pedit" myEnt "y" "w" ( WHL myWid ) "")
		)
		( if ( = myNam "CIRCLE" )
			( progn
				( setq myPtc  ( cdr ( assoc 10 myHnd ) )
					   myRad  ( cdr ( assoc 40 myHnd ) )
				)
				( entdel myEnt )
				( setq outRad ( * 2 myRad )
					   innRad ( * 2 ( - myRad ( WHL myWid ) ) )
				)
				( curlay myLay )
				( command "donut"  innRad outRad myPtc "" )
			)
		)	;;; end >>>IF<<< :: "CIRCLE"
	)
	; //end while statement
	( SYSPops )
)
