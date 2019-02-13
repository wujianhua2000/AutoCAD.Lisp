;==============================================================================
;
( defun c:xcopy(  / mysel dx dy num pt1 pt2 Xoff Yoff )
    ( SYSpush )

    ( prompt "Select entities to XCOPY:"              )
    ( setq mysel ( ssget ) )				( terpri )
    ( setq dx	 ( getreal  "input a dx:"           ) ) ( terpri )
    ( setq dy	 ( getreal  "input a dy:"           ) ) ( terpri )
    ( setq num	 ( getint   "input a xcopy number:" ) ) ( terpri )

    ( setq Xoff dx )
    ( setq Yoff dy )
    ( setq pt1 ( list 0.00 0.00 0.00 ) )
    ( setq pt2 ( list Xoff Yoff 0.00 ) )
    ( repeat num
	( command "copy" mysel "" pt1 pt2 )
	( setq Xoff ( + Xoff dx ) )
	( setq Yoff ( + Yoff dy ) )
	( setq pt2  ( list Xoff Yoff 0.00 ) )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:rele( / inspt len05 len20 pt1 pt2 pt3 )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt  ( getpoint "Input a point:"          ) )  ( terpri )
    ( setq eleAng ( defAngle "Input a angle:" eleAng 4 ) )

    ( setvar "OSMODE" 0 )
    ( setq len05 ( WHL	4.0 ) )			;;;	5 ---> 4
    ( setq len20 ( WHL 16.0 ) )			;;;	20 ---> 16

    ( command "PLINEWID" 0.00 )

    ( if ( <= eleAng ( * pi 0.50 ) )
		( progn
			( setq pt1	 ( polar inspt ( R$D eleAng   45 ) len05 ) )
			( setq pt2	 ( polar inspt ( R$D eleAng  135 ) len05 ) )

			( setq pt3	 ( polar pt2   eleAng len20 ) )
			( command "PLINE"  pt1  inspt  pt2  pt3  "" )
		)
		( progn
			( setq pt1	 ( polar inspt ( R$D eleAng  -45 ) len05 ) )
			( setq pt2	 ( polar inspt ( R$D eleAng -135 ) len05 ) )

			( setq pt3	 ( polar pt2   eleAng len20 ) )
			( command "PLINE"  pt1  inspt  pt2  pt3  "" )
		)
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	画轴线号.
;
;	全局变量
；		scale	比例尺。
;
;	吴建华,	2006-09-29, 修改,汉化,注释.
;
( defun c:xy( / InsPt TxtLen )
    ( SYSpush )

	;	设置变量 Direct = 270.
    ( if ( = Direct nil )
		( setq Direct ( R$D 0.00 -90 ) ) 
	)

    ( command "OSNAP" "END" )
    ( setq InsPt  ( getpoint  "插入点:"				) ) ( terpri )
    ( setq InsTxt ( getstring "轴线编号:"				) ) ( terpri )
    ( setq Direct ( defAngle  "标注方向:" Direct 4	) ) ( terpri )

    ( setvar "OSMODE" 0 )

    ( setq InsPt  ( polar InsPt Direct ( WHL 5.0 ) ) )
    ( curlay "AXISDIM" )		;	切换图层
    ( command "CIRCLE" InsPt ( WHL 5.00 ) )

    ( curlay "AXISTAG" )		;	切换图层
    ( setq TxtLen ( strlen InsTxt ) )

	；	原来的想法，文字长度较大的时候，改变长宽比例。
    ( if ( >= TxtLen 3 )
       ( progn
		   ( curSty "COMPLEX" )
		   ( command "TEXT" "mc" InsPt ( WHL 5.0 ) 0.00 InsTxt )
       )
       ( progn
		   ( curSty "COMPLEX" )
		   ( command "TEXT" "mc" InsPt ( WHL 5.0 ) 0.00 InsTxt )
       )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:RC( / InsPt TxtLen )
    ( SYSpush )

    ( if ( = XYorit nil )	 ( setq XYorit ( R$D 0.00 -90 ) ) )

    ( cond ( = XYtxt  nil )	   ( setq XYtxt "1" )
    )

    ( command "OSNAP" "END" )
    ( setq InsPt  ( getpoint  "Insert Axis point :"   ) ) ( terpri )
    ( setq XYtxt  ( getstring "Axis number:"          ) ) ( terpri )
    ( setq XYorit ( defAngle  "Move direction angle" XYorit 4 ) )

    ( setvar "OSMODE" 0 )

    ( setq InsPt  ( polar InsPt XYorit ( WHL 5.0 ) ) )
    ( curlay "_XYLINE" )
    ( command "CIRCLE" InsPt ( WHL 5.00 ) )

    ( curlay "_XYTEXT" )
    ( setq TxtLen ( strlen InsTxt ) )
    ( if ( >= TxtLen 3 )
       ( progn
	   ( curSty "ROMAND05" )
	   ( command "TEXT" "mc" InsPt ( WHL 5.0 ) 0.00 InsTxt )
       )
       ( progn
	   ( curSty "ROMAND08" )
	   ( command "TEXT" "mc" InsPt ( WHL 5.0 ) 0.00 InsTxt )
       )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:setscl( )
    ( setvar "cmdecho" 0 )
    ( if ( = ( getvar "USERR1" ) 0.00 ) ( setvar "USERR1" 100.00 ) )

    ( terpri )
    ( prompt ( strcat "Input HP Plotter Scale <1:"
		      ( rtos ( getvar "USERR1" ) 2 0 )
		      ">:"                              )  )
    ( setq Scale ( getreal ) ) ( terpri )
    ( if ( = Scale nil ) ( setq Scale ( getvar "USERR1" ) ) )

    ( command "LTSCALE" ( WHL 10.0 ) )

    ( setvar  "USERR1"   Scale )
    ( setvar  "cmdecho"  1     )
)

;------------------------------------------------------------------------------
;
( defun c:all( )
    ( curSee "ALL" )
)

;------------------------------------------------------------------------------
;
( defun c:A123( / mySize insPnt insKWD XLen YLen )
    ( SYSpush )

    ( setq mySize ( getint   "Input drawing frame size( 0~~4)" ) ) ( terpri )
    ( setq incPer ( getreal  "Input extend percentage <0.00>:" ) ) ( terpri )
    ( setq insPnt ( getpoint "Insert point:"                   ) ) ( terpri )

    ( if ( null incPer ) ( setq incPer 0.0000 ) )
    ( if ( AND ( >= mySize 3  ) ( > incPer 0.0000 ) )
	 ( progn ( prompt "3# Drawing paper cannot be extended!!!" )
		 ( setq   incPer  0.0000 )
	 )
    )

    ( initget 1 "Yes No" )
    ( setq insKWD ( getkword "Rotation 90 (Yes/No) <No>" ) ) ( terpri )

    ( cond ( ( = mySize 0 ) ( setq XLen  1189.00     YLen  841.00 ) )
	   ( ( = mySize 1 ) ( setq XLen   841.00     YLen  594.00 ) )
	   ( ( = mySize 2 ) ( setq XLen   594.00     YLen  420.00 ) )
	   ( ( = mySize 3 ) ( setq XLen   420.00     YLen  297.00 ) )
	   ( T		    ( progn
				 ( setq XLen   841.00 )
				 ( setq YLen   594.00 )
				 ( prompt "Input zise is ERROR!!!"  )
			    )
	   )

    )

    ( setq XLen ( * XLen ( + 1.0000 incPer ) ) )

    ( if ( = insKWD "Yes" )  ( progn ( setq TLen   XLen )
				     ( setq XLen   YLen )
				     ( setq YLen   TLen )
			     )
    )

    ( setq XLen ( WHL XLen ) )
    ( setq YLen ( WHL YLen ) )

    ( setvar  "OSMODE"       0 )
    ( command "plinewid"     0 )
    ( curlay  "SOLID_STEEL"    )

    ( setq PntA insPnt )
    ( setq PntB ( mapcar '+ insPnt ( list XLen YLen 0.00 ) ) )
    ( box PntA PntB )

    ( setq AOff ( WHL 10.0 ) )
    ( setq BOff ( WHL 25.0 ) )

    ( command "plinewid" ( WHL 1.0 ) )
    ( if ( = insKWD "Yes" )
	( progn
	    ( setq PntA ( mapcar '+ PntA ( list AOff AOff 0.0000 ) ) )
	    ( setq PntB ( mapcar '- PntB ( list AOff BOff 0.0000 ) ) )

	    ( setq PntC ( mapcar '+ PntA ( list ( - XLen ( WHL 20.0 ) ) 0.00 0.00 ) ) )
	    ( setq PntD PntB )
	)
	( progn
	    ( setq PntA ( mapcar '+ PntA ( list Boff AOff 0.00 ) ) )
	    ( setq PntB ( mapcar '- PntB ( list AOff Aoff 0.00 ) ) )

	    ( setq PntC ( mapcar '+ PntA ( list ( - XLen ( WHL 35.00 ) )  0.00 0.00 ) ) )
	    ( setq PntD PntB )
	)
    )

    ( box PntA PntB )
    ( command "INSERT"  "Designer"  PntC  ( WHL 1.0 )  ( WHL 1.0 )  0.0000 )
    ( command "_EXPLODE" ( entlast )  )

    ( SYSpops )
)

;-------------------------------------------------------------------------
;
( defun signbox( vtPnt vtAng / Pnt1 Pnt2 Pnt3 Pnt4 myAng Delta )
   ( setq Pnt1	vtPnt )
   ( setq Pnt2	( polar Pnt1 ( R$D vtAng  90 ) ( WHL  21.0 ) ) )
   ( setq Pnt3	( polar Pnt2 ( R$D vtAng 180 ) ( WHL 150.0 ) ) )
   ( setq Pnt4	( polar Pnt3 ( R$D vtAng -90 ) ( WHL  21.0 ) ) )

   ( command "LINE" Pnt1 Pnt2 Pnt3 "" )

   ( setq myAng ( R$D vtAng -90 ) )
   ( setq Delta ( WHL	   5.00 ) )
   ( repeat 3
	( setq Pnt2  ( polar Pnt2 myAng Delta ) )
	( setq Pnt3  ( polar Pnt3 myAng Delta ) )
	( command "LINE" Pnt2 Pnt3 "" )
   )

   ( setq Pnt2	( polar Pnt1 ( R$D vtAng  90 ) ( WHL  21.0 ) ) )

   ( setq myAng ( R$D vtAng 180 ) )
   ( setq Delta ( WHL	  25.00 ) )
   ( repeat 5
	( setq Pnt1  ( polar Pnt1 myAng Delta ) )
	( setq Pnt2  ( polar Pnt2 myAng Delta ) )
	( command "LINE" Pnt1 Pnt2 "" )
   )
)

;-------------------------------------------------------------------------
;( defun c:aaa( )
;( setq inspt ( getpoint ) )
;( signbox inspt 0.00 )
;)

;-------------------------------------------------------------------------
( defun c:cls( )
    ( graphscr )
    ( setvar "cmdecho" 0 )
    ( command "erase" "ALL" "" )
    ( setvar "cmdecho" 1 )
)

;-------------------------------------------------------------------------
( defun c:arrow( )
    ( SYSpush )
    ( setq inspt  ( getpoint "insert point:"   ) )    ( terpri )
    ( setq AngArr ( getangle "rotation angle:" ) )    ( terpri )

    ( setvar "OSMODE" 0 )
    ( command "PLINE" inspt
	      "w"  0.0000  ( WHL 1.00 )
	      ( polar inspt ( R$D AngArr 180 ) ( WHL  5.00 ) )	  ""
    )

    ( SYSpops )
)
