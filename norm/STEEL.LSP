;
;------------------------------------------------------------------------------
;
;
( defun c:ttt( / inspt A_len B_len myAng oldlay
                  pt1 pt2 pt3 pt4                 )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt ( getpoint "Input a insert POINT:"   ) ) ( terpri )
    ( setq A_len ( getreal  "Steel Bar Left  length:" ) ) ( terpri )
    ( setq B_len ( getreal  "Steel Bar Right length:" ) ) ( terpri )
    ( setq myAng ( getangle "Input angle:"            ) ) ( terpri )

    ( setq pt1 ( polar inspt myAng           ( * A_len -1.00 ) ) )
    ( setq pt1 ( polar pt1 ( R$D myAng -90 ) ( WHL 2.00      ) ) )
    ( setq pt2 ( polar pt1 ( R$D myAng  90 ) ( WHL 2.00      ) ) )

    ( setq pt3 ( polar pt2 myAng             ( + A_len B_len ) ) )
    ( setq pt4 ( polar pt3 ( R$D myAng -90 ) ( WHL 2.00      ) ) )

    ( setvar "OSMODE" 0 )
    ( command "plinewid" ( WHL 0.50 ) )
    ( command "pline"  pt1  pt2  pt3  pt4  "" )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	上部钢筋（负弯矩钢筋）。
;
( defun c:ttt2( / inspt A_len B_len myAng oldlay
                  pt1 pt2 pt3 pt4                 )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt ( getpoint "第一点:"   ) ) ( terpri )
    ( setq secpt ( getpoint "第二点:"   ) ) ( terpri )

    ( setq A_len ( getreal  "左边长度:" ) ) ( terpri )
    ( setq B_len ( getreal  "右边长度:" ) ) ( terpri )
    ( setq myAng ( getangle "角度:"     ) ) ( terpri )

    ( setq pt1 ( polar inspt myAng           ( * A_len -1.00 ) ) )
    ( setq pt1 ( polar pt1 ( R$D myAng -90 ) ( WHL 2.00      ) ) )
    ( setq pt2 ( polar pt1 ( R$D myAng  90 ) ( WHL 2.00      ) ) )

	;	两个临时点。
	( setq tp1 ( polar inspt myAng				100.0 ) )
	( setq tp2 ( polar secpt ( + myAng ( * PI 0.5 ) )	100.0 ) )
	;	交点。 pt3 是一个关键计算点。
	( setq pt3 ( inters inspt tp1 secpt tp2 nil ) )	

	
    ( setq pt3 ( polar pt3 myAng               B_len ) )
    ( setq pt4 ( polar pt3 ( R$D myAng -90 ) ( WHL 2.00      ) ) )

    ( setvar "OSMODE" 0 )
    ( command "plinewid" ( WHL 0.50 ) )
    ( command "pline"  pt1  pt2  pt3  pt4  "" )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
;
( defun c:bbb( / inspt A_len B_len myAng
                  pt1 pt2 pt3 pt4               )
    ( SYSpush )

  ( curlay "SOLID_STEEL" )
  ( setq inspt ( getpoint "第一点："   ) ) ( terpri )

  ( setq A_len ( getreal  "左边长度：" ) ) ( terpri )
  ( setq B_len ( getreal  "右边长度：" ) ) ( terpri )
  ( setq myAng ( getangle "角度："    ) ) ( terpri )

  ( setq pt3 ( polar inspt myAng           ( * A_len -1.0 ) ) )
  ( setq pt2 ( polar pt3  ( R$D myAng 90 ) ( WHL 1.00 ) ) )
  ( setq pt1 ( polar pt2   myAng           ( WHL 1.50 ) ) )

  ( setq pt4 ( polar inspt myAng             B_len       ) )
  ( setq pt5 ( polar pt4  ( R$D myAng 90 ) ( WHL  1.00 ) ) )
  ( setq pt6 ( polar pt5   myAng           ( WHL -1.50 ) ) )

  ( setvar "OSMODE" 0 )
  ( command "plinewid" ( WHL 0.50 ) )
  ( command "pline" pt1  pt2
            "ARC"
            "radius" ( WHL 0.50 )
            "angle"  180.00
            ( + ( rtod myAng ) 270.00 )
            "line"
            pt4
            "arc"
            "radius" ( WHL 0.50 )
            "angle"  180.00
            ( + ( rtod myAng ) 90.00 )
            "line"
            pt6
            ""
  )

    ( SYSpops )
)

;;------------------------------------------------------------------------------
;;	第二种板底钢筋的画法。
;;	wujianhua	2006-12-6.
;;
( defun c:bbb2( / inspt A_len B_len myAng pt1 pt2 pt3 pt4 )

	( SYSpush )

	( curlay "SOLID_STEEL" )
	( setq inspt ( getpoint "第一点:"   ) ) ( terpri )
	( setq secpt ( getpoint "第二点:"   ) ) ( terpri )

	( setq A_len ( getreal  "左边长度:" ) ) ( terpri )
	( setq B_len ( getreal  "右边长度:" ) ) ( terpri )
	( setq myAng ( getangle "角度:"     ) ) ( terpri )

;;;;	;	第一点左边的钢筋弯钩控制点。
	( setq pt3 ( polar inspt myAng           ( * A_len -1.0 ) ) )
	( setq pt2 ( polar pt3  ( R$D myAng 90 ) ( WHL 1.00		) ) )
	( setq pt1 ( polar pt2   myAng           ( WHL 1.50		) ) )

;;;;	;	如何计算两个点之间的距离。第二点到第一点的
;;;;	;	两个临时点。
	( setq tp1 ( polar inspt myAng				100.0 ) )
	( setq tp2 ( polar secpt ( + myAng ( * PI 0.5 ) )	100.0 ) )

;;;;	;	交点。
	( setq pt4 ( inters inspt tp1 secpt tp2 nil ) )	

;;;;	;	( setq pt4 ( polar inspt myAng B_len   ) )
;;;;	;	使用pt4 继续延长都钢筋的转弯处。
	( setq pt4 ( polar pt4   myAng             B_len       ) )

	( setq pt5 ( polar pt4  ( R$D myAng 90 ) ( WHL  1.00 ) ) )
	( setq pt6 ( polar pt5   myAng           ( WHL -1.50 ) ) )

	( setvar "OSMODE" 0 )
	( command "plinewid" ( WHL 0.50 ) )
	( command "pline" pt1  pt2
		"ARC"
		"radius" ( WHL 0.50 )
		"angle"  180.00
		( + ( rtod myAng ) 270.00 )
		"line"
		pt4
		"arc"
		"radius" ( WHL 0.50 )
		"angle"  180.00
		( + ( rtod myAng ) 90.00 )
		"line"
		pt6
		""
  	)

    	( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:1st( / inspt STAng )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt  ( getpoint "Input a POINT:" ) )        ( terpri )
    ( setq STAng  ( getangle "Input a ANGLE:" ) )        ( terpri )

    ( setvar "OSMODE" 0 )
    ( command "PLINEWID" ( WHL 0.50 ) )
    ( command "PLINE" inspt
              "arc"
              "radius"  ( WHL 0.50 )
              "angle"   -180.00
              ( + ( rtod STAng ) 90.00 )
              "line"
              ( polar ( getvar "LASTPOINT" ) STAng ( WHL 1.50 ) )
              ""
    )
    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:2st( / inspt STAng )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt  ( getpoint "Input a POINT:" ) )        ( terpri )
    ( setq STAng  ( getangle "Input a ANGLE:" ) )        ( terpri )

    ( setvar "OSMODE" 0 )
    ( command "PLINEWID" ( WHL 0.50 ) )
    ( command "PLINE" inspt
              "arc"
              "radius"  ( WHL 0.50 )
              "angle"   180.00
              ( + ( rtod STAng ) 90.00 )
              "line"
              ( polar ( getvar "LASTPOINT" ) 
		      STAng 
		      ( WHL -1.50 ) )
              ""
    )
    ( SYSpops )
)

;------------------------------------------------------------------------------
;
( defun c:3st( / inspt STAng )
    ( SYSpush )

    ( curlay "SOLID_STEEL" )
    ( setq inspt  ( getpoint "Input a POINT:" ) )        ( terpri )
    ( setq STAng  ( getangle "Input a ANGLE:" ) )        ( terpri )

    ( setvar  "OSMODE"  0 )
    ( command "PLINEWID" ( WHL 0.50 ) )
    ( command "pline" inspt
              ( polar inspt STAng ( WHL 1.20 ) )
              ""
    )
    ( SYSpops )
)

;------------------------------------------------------------------------------
;
;
( defun c:label( / inspt index myAng oldlay direct )
    ( SYSpush )

    ( setq inspt  ( getpoint "Circle Center Point:" ) )  ( terpri )
    ( setq index  ( getint   "Input steel label:"   ) )  ( terpri )
    ( setq myAng  ( getangle "Input angle:"         ) )  ( terpri )

    ; MODIFY 1996-12-05 AM LIKE xy COMMAND
    ( setq direct ( getangle "input move direction angle:" ) ) ( terpri )

    ( setvar "OSMODE"       0 )
    ( curlay "SOLID_STEEL"    )
    ( setq inspt  ( polar inspt direct ( WHL 3.00 ) ) )
    ( command "CIRCLE" inspt ( WHL 3.00 ) )

    ( curlay "TEXT" )
    ( command "TEXT" "mc" inspt ( WHL 3.00 ) ( rtod myAng ) index )

    ( SYSpops )
)
;
;------------------------------------------------------------------------------
;
; Modified Memo ::
;       Date            Because
;       Aug--08--96     first create.
;
( defun c:st1( / pt1 pt2 myAng PI_2 )
    ( SYSpush )

    ; setvar OSNAP is CENTER
    ( setvar "OSMODE" 4 )
    ( setq pt1 ( getpoint     "Locate 1st point:" ) ) ( terpri )
    ( setq pt2 ( getpoint pt1 "Locate 2nd point:" ) ) ( terpri )

    ( setq myAng ( angle pt1 pt2 ) )
    ( setq PI_2  ( * PI 0.50     ) )

    ( setvar "OSMODE"       0 )
    ( curlay  "SOLID_STEEL"   )

    ( command "PLINEWID" ( WHL 0.50 ) )
    ( command "PLINE"
              ( polar ( polar pt1 ( - myAng PI_2 ) ( * 0.75 scale ) )
                                  myAng            ( * 1.50 scale )   )
              ( polar pt1 ( - myAng PI_2 ) ( *  0.75 scale ) )
              "Arc"
              "Second"
              ( polar pt1 myAng            ( * -0.75 scale ) )
              ( polar pt1 ( + myAng PI_2 ) ( *  0.75 scale ) )
              "Line"
              ( polar pt2 ( + myAng PI_2 ) ( *  0.75 scale ) )
              "Arc"
              "Second"
              ( polar pt2 myAng            ( *  0.75 scale ) )
              ( polar pt2 ( - myAng PI_2 ) ( *  0.75 scale ) )
              "Line"
              ( polar ( polar pt2 ( - myAng PI_2 ) ( *  0.75 scale ) )
                                  myAng            ( * -1.50 scale )   )

              ""
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;
; Modified Memo ::
;       Date            Because
;       Aug--08--96     first create.
;
( defun c:dot( / inspt Done )
    ( SYSpush )

    ( curlay  "SOLID_STEEL" )
    ( setq Done nil )
    ( while ( null Done )
;       ( initget 16 )
        ( setq inspt ( getpoint "Locate a point:" ) )  ( terpri )

        ( if ( null inspt )
            ( setq Done 0 )
            ( command "DONUT"  0.00  ( WHL 1.00 )  inspt ""  )
        )
    )

    ( SYSpops )
)

