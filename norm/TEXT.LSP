;------------------------------------------------------------------------------
;	以底边、中心对齐输入比例尺。
;
(defun c:sca (/ TxtPnt)
	(SYSpush)

	(setq TxtPnt (getpoint "Text insert point :"))
	(terpri)

	;	文字的高度是 0.05, 不希望显示出来，仅仅是查询。
	;	水平方向书写。
	;	内容格式： 1：xxx
	(setq txtHei 0.50)
	(setq TxtAng 0.00)
	(setq TxtStr (strcat "(1:" (rtos scale 2 0) ")"))

	(curlay "TEXT")
	(GenText TxtPnt "BC" txtHei txtAng txtStr)

	(SYSpops)
)

;------------------------------------------------------------------------------
;	以中心 + 中心对齐输入文字。
;
( defun c:tmc( / TxtPnt )
    ( SYSpush )

    ( setq TxtPnt ( getpoint "插入点:"	 			) ) ( terpri )
    ( setq txtHei ( defReal  "高度"		TxtHei 2	) )
    ( setq TxtAng ( defAngle "角度"		TxtAng 4	) )
    ( setq TxtStr ( defText  "文字"      TxtStr		) )

    ( setq TxtStr ( strcase TxtStr ) )
    ( curlay "TEXT" )
    ( GenText TxtPnt  "MC"  txtHei  txtAng  txtStr )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	以 **下底边** + **右边界** 对齐输入文字。
;
( defun c:tbr( / TxtPnt )
    ( SYSpush )

    ( setq TxtPnt ( getpoint "插入点:"	 			) ) ( terpri )
    ( setq txtHei ( defReal  "高度"		TxtHei 2	) )
    ( setq TxtAng ( defAngle "角度"		TxtAng 4	) )
    ( setq TxtStr ( defText  "文字"      TxtStr		) )

    ( setq TxtStr ( strcase TxtStr ) )
    ( curlay "TEXT" )
    ( GenText TxtPnt  "BR"  txtHei  txtAng  txtStr )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	以底边、中心对齐输入文字。
;
( defun c:tbc( / TxtPnt )
    ( SYSpush )

	( setq TxtPnt ( getpoint "插入点:"	 			) ) ( terpri )
    ( setq txtHei ( defReal  "高度"		TxtHei 2	) )
    ( setq TxtAng ( defAngle "角度"		TxtAng 4	) )
    ( setq TxtStr ( defText  "文字"		TxtStr		) )

    ( setq TxtStr ( strcase TxtStr ) )

    ;	( curlay "TEXT" )
    ( GenText TxtPnt  "BC"  txtHei  txtAng  txtStr )

    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:ttc( / TxtPnt )
    ( SYSpush )

    ( setq TxtPnt ( getpoint "Text insert point :" ) ) ( terpri )
    ( setq txtHei ( defReal  "Text Height "         TxtHei 2 ) )
    ( setq TxtAng ( defAngle "Text rotation angle " TxtAng 4 ) )
    ( setq TxtStr ( defText  "Text string "         TxtStr   ) )

    ( setq TxtStr ( strcase TxtStr ) )
    ( curlay "TEXT" )
    ( GenText TxtPnt  "TC"  txtHei  txtAng  txtStr )


    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:cctxt( )
    ( SYSpush )

    ( setq myStl ( getstring "Enter text Style Name:" ) )
    ( setq oldTH ( getreal   "Enter old text Height:" ) )
    ( setq newTH ( getreal   "Enter new text Height:" ) )

    ( setq mysel ( ssget "x"  ( list  ( cons  0 "TEXT" )
				      ( cons 40 oldTH  )
				      ( cons  7 myStl  ) ) ) )

    ( setq num	 ( sslength mysel ) )
    ( setq index 0 )

	( repeat num
		( setq Txtent  ( entget ( ssname mysel index ) ) )
		( setq index ( 1+ index ) )

		( setq Hgold ( assoc 40 Txtent ) )
		( setq Hgnew ( cons ( car Hgold ) newTH ) )
		
		( setq Txtent  ( subst Hgnew Hgold Txtent ) )
		
		( entmod Txtent )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
;	修改文本的高度。	2006-11-29
;
( defun c:tth( / Allsel	Num  Index NewH HtList This NewEnt EntHht )
    ( SYSpush )

    ( setq NewH ( getreal  "Input New Text Height:" ) ) ( terpri )
	;	更新， 2006-10，26。考虑比例。
    ( setq NewH ( WHL NewH ) )

    ( prompt "Select texts to be changed "   ) ( terpri )
    ( setq Allsel ( ssget ) )

    ( setq Num	   ( sslength Allsel ) )
    ( setq Index   0 )
    ( setq HtList   ( cons  40	NewH ) )

    ( repeat Num
	( setq This	 ( entget ( ssname Allsel index ) ) )
	( setq EntHht	 ( assoc 40 This ) )
	( setq NewEnt	 ( subst HtList EntHht This ) )
	( entmod  NewEnt )
	( setq Index ( + Index 1 ) )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:chwid( )
    ( SYSpush )

    ( setq myStl ( getstring "Enter STYLENAME:" ) )
    ( setq oldWH ( getreal   "Enter old text width factor:" ) )
    ( setq newWH ( getreal   "Enter new text width factor:" ) )

    ( setq mysel ( ssget "x"  ( list  ( cons  0 "TEXT" )
				      ( cons 41 oldWH  )
				      ( cons  7 myStl  ) ) ) )

    ( setq num	 ( sslength mysel ) )
    ( setq index 0 )
    ( repeat num
	( setq ent1  ( entget ( ssname mysel index ) ) )
	( setq Hold  ( assoc 41 ent1 ) )
	( setq Hnew  ( cons ( car Hold ) newWH ) )
	( setq ent2  ( subst Hnew Hold ent1 ) )
	( entmod ent2 )
	( setq index ( 1+ index ) )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:chstil( )
    ( SYSpush )

    ( setq OldStl ( getstring "Enter OLD STYLENAME:" ) )
    ( setq NewStl ( getstring "Enter NEW STYLENAME:" ) )

    ( setq mysel ( ssget "x"  ( list  ( cons  0 "TEXT" )
				      ( cons  7 OldStl ) ) ) )

    ( setq num	 ( sslength mysel ) )
    ( setq index 0 )
    ( repeat num
	( setq ent1  ( entget ( ssname mysel index ) ) )
	( setq Stold  ( assoc  7 ent1 ) )
	( setq Stnew  ( cons ( car Stold ) NewStl ) )
	( setq ent2  ( subst Stnew Stold ent1 ) )
	( entmod ent2 )
	( setq index ( 1+ index ) )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:chRad( )
    ( SYSpush )

    ( setq OldR ( getreal  "Input Old Circle Radius:" ) ) ( terpri )
    ( setq NewR ( getreal  "Input New Circle Radius:" ) ) ( terpri )

    ( setq mysel ( ssget "x"  ( list  ( cons  0 "CIRCLE" )
				      ( cons 40 OldR	 ) ) ) )

    ( setq Num	   ( sslength mysel ) )
    ( setq Index   0 )
    ( setq NewLst   ( cons  40	NewR ) )

    ( repeat Num
	( setq This	 ( entget ( ssname mysel index ) ) )
	( setq OldLst	 ( assoc 40 This ) )
	( setq NewEnt	 ( subst NewLst OldLst This ) )
	( entmod  NewEnt )
	( setq Index ( + Index 1 ) )
    )

    ( SYSpops )
)

;------------------------------------------------------------------------------
( defun c:dwst( )
    ( SYSpush )

    ( setq mysel ( ssget "x"  ( list  ( cons  0 "TEXT" )
				      ( cons  8 "C"    ) ) ) )

    ( setq Num	   ( sslength mysel ) )
    ( setq Index   0 )
;   ( setq i	   1 )

    ( repeat Num
	( setq This	 ( entget ( ssname mysel index ) ) )
	( setq txt	 ( strcase ( cdr ( assoc 1 This ) ) ) )
;	( setq Len	 ( strlen txt	) )

	    ( if ( /= "X" ( substr txt 4 1 ) )
		( entdel ( ssname mysel index ) )
;		( command "ERASE" Asel "" )
	    )

;	( while ( <= i Len )
;	    ( setq i ( + i 1 ) )
;	)

	( setq Index ( + Index 1 ) )
    )

    ( SYSpops )
)

;-------------------------------------------------------------------------
( defun c:hz( )
    ( if ( isHZCH "汉字" )
	( prompt "is hanzi\n" )
	( prompt "not hanzi\n" )
    )
    ( if ( isHZCH ( substr "汉字" 3 ) )
	( prompt "is hanzi\n" )
	( prompt "not hanzi\n" )
    )
)

