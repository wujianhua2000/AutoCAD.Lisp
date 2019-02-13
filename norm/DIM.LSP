;=========================================================================
( defun bar( vtPnt vtAng )
    ( curlay  "_DIMLINE"   )
    ( setvar  "OSMODE"   0 )

    ( command "PLINEWID" ( WHL 0.5 ) )
    ( command "PLINE"
              ( polar vtPnt ( R$D vtAng 225 ) ( WHL 0.75 ) )
              ( polar vtPnt ( R$D vtAng  45 ) ( WHL 0.75 ) )
              ""
    )
)

;=========================================================================
( defun c:dm( / inspt pt0
                Htext
                uplin dnlin
                n i
                Lhor myLst pt1 pt2 Offhor )
    ( SYSpush )

    ( setq inspt ( getpoint "Insert point :"     ) ) ( terpri )
    ( setq uplin ( getreal  "Up line length :" ) ) ( terpri )
    ( setq dnlin ( getreal  "Down line length :" ) ) ( terpri )

;   ( setq DimAng ( getangle "rotation angle   :" ) ) ( terpri )

    ( setq DimAng ( defAngle "Rotation angle" DimAng 4 ) )

    ( setq n     ( getint   "span number :"      ) ) ( terpri )

    ( setvar "OSMODE"  0 )

    ( setq Htext 3.00 )
    ( setq i     1    )
    ( setq Lhor  0.00 )
    ( setq myLst '( 0.00 ) )
    ( setq pt0 inspt )

    ( repeat n
        ( princ "Input No. " )  ( princ i )  ( princ ". dimension:" )
        ( initget ( + 1   4 ) )
        ( setq dx    ( getreal ) ) ( terpri )
        ( setq Lhor  ( + Lhor dx ) )
        ( setq myLst ( append myLst ( list dx ) ) )
        ( setq i ( 1+ i ) )
    )

    ;draw total line ( dimension )
    ( curlay "_DIMLINE" )
    ( setq Lhor ( + Lhor ( * 4.00 scale ) ) )
    ( setq pt1  ( polar inspt ( + pi myAng ) ( * 2.00 scale ) ) )
    ( setq pt2  ( polar pt1   myAng          Lhor             ) )
    ( command "line" pt1 pt2 "" )

    ; draw dimension stop line
    ( setq i  0 )
    ( repeat ( 1+ n )
       ( setq Offhor ( nth i myLst ) )
       ( setq inspt ( polar inspt myAng Offhor ) )

       ( bar inspt myAng )

       ( setq pt1 ( polar inspt ( + ( * 0.5 pi ) myAng ) ( * uplin scale ) ) )
       ( setq pt2 ( polar inspt ( + ( * 1.5 pi ) myAng ) ( * dnlin scale ) ) )
       ( command "line" pt1 pt2 "" )

       ( setq i ( 1+ i ) )
    )

    ( curlay "_DIMTEXT" )
    ( setq i 1 )
    ( setq inspt pt0 )
    ( repeat n
       ( setq Offhor ( nth i myLst ) )
       ( setq pt0    ( polar inspt myAng ( * 0.50 Offhor ) ) )
       ( setq pt0    ( polar pt0  ( + ( * 0.5 pi ) myAng ) ( * 1.50 scale ) ) )

       ( command "TEXT" "J" "C" pt0 ( * Htext scale ) ( rtod myAng ) ( rtos Offhor 2 0 ) )

       ( setq inspt ( polar inspt myAng Offhor ) )
       ( setq i ( 1+ i ) )
    )

  ( SYSpops )
)

;=========================================================================
( defun c:stdm( / inspt pt0
                Htext
                uplin dnlin myAng
                n i
                Lhor myLst pt1 pt2 Offhor )
    ( SYSpush )

    ( setq inspt ( getpoint "insert point :" ) )     ( terpri )
    ( setq uplin ( getreal  "up line length :"   ) ) ( terpri )
    ( setq dnlin ( getreal  "down line length :" ) ) ( terpri )

    ( setq myAng ( defAngle "the rotation angle" 0.000 4 ) )

    ( setq n     ( getint   "span number :" ) )      ( terpri )

    ( setvar "cmdecho" 0 )
    ( setvar "OSMODE"  0 )

    ( setq Htext 2.50 )
    ( setq i     1    )
    ( setq Lhor  0.00 )
    ( setq myLst '( 0.00 ) )
    ( setq pt0 inspt )

    ( repeat n
        ( princ "Input No. " )  ( princ i )  ( princ ". dimension:" )
        ( initget ( + 1   4 ) )
        ( setq dx    ( getreal ) ) ( terpri )
        ( setq Lhor  ( + Lhor dx ) )
        ( setq myLst ( append myLst ( list dx ) ) )
        ( setq i ( 1+ i ) )
    )

    ;draw total line ( dimension )
    ( curlay "_DIMLINE" )
    ( setq Lhor ( + Lhor ( * 4.00 scale ) ) )
    ( setq pt1  ( polar inspt ( + pi myAng ) ( * 2.00 scale ) ) )
    ( setq pt2  ( polar pt1   myAng          Lhor             ) )
    ( command "line" pt1 pt2 "" )

    ; draw dimension stop line
    ( setq i  0 )
    ( repeat ( 1+ n )
       ( setq Offhor ( nth i myLst ) )
       ( setq inspt ( polar inspt myAng Offhor ) )

       ( bar inspt myAng )

       ( setq pt1 ( polar inspt ( + ( * 0.5 pi ) myAng ) ( * uplin scale ) ) )
       ( setq pt2 ( polar inspt ( + ( * 1.5 pi ) myAng ) ( * dnlin scale ) ) )
       ( command "line" pt1 pt2 "" )

       ( setq i ( 1+ i ) )
    )

    ( curlay "_DIMTEXT" )
    ( setq i 1 )
    ( setq inspt pt0 )
    ( repeat n
       ( setq Offhor ( nth i myLst ) )
       ( setq pt0    ( polar inspt myAng ( * 0.50 Offhor ) ) )
       ( setq pt0    ( polar pt0  ( + ( * 0.5 pi ) myAng ) ( * 1.50 scale ) ) )

       ( command "TEXT"   "J"   "C"   pt0
                 ( * Htext scale ) ( rtod myAng ) ( rtos Offhor 2 0 )
       )

       ( setq inspt ( polar inspt myAng Offhor ) )
       ( setq i ( 1+ i ) )
    )

    ( SYSpops )
)
;
;==============================================================================
;
;
( defun c:ddm( / inspt pt0
                Htext
                uplin dnlin myAng
                n i
                Lhor myLst pt1 pt2 Offhor )
    ( SYSpush )

    ( setq inspt ( getpoint "insert point :" ) )     ( terpri )
    ( setq uplin ( getreal  "up line length :"   ) ) ( terpri )
    ( setq dnlin ( getreal  "down line length :" ) ) ( terpri )
    ( setq myAng ( getangle "rotation angle   :" ) ) ( terpri )
    ( setq n     ( getint   "span number :" ) )      ( terpri )

    ( setq Htext 3.00 )
    ( setq i     1    )
    ( setq Lhor  0.00 )
    ( setq myLst '( 0.00 ) )
    ( setq pt0 inspt )

    ( repeat n
        ( princ "Input No. " )  ( princ i )  ( princ ". dimension:" )
        ( initget ( + 1   4 ) )
        ( setq dx    ( getreal ) ) ( terpri )
        ( setq Lhor  ( + Lhor dx ) )
        ( setq myLst ( append myLst ( list dx ) ) )
        ( setq i ( 1+ i ) )
    )

    ( setvar "OSMODE" 0 )

    ;draw total line ( dimension )
    ( curlay "_DIMLINE" )
    ( setq Lhor ( + Lhor ( * 4.00 scale ) ) )
    ( setq pt1  ( polar inspt ( + pi myAng ) ( * 2.00 scale ) ) )
    ( setq pt2  ( polar pt1   myAng          Lhor             ) )
    ( command "line" pt1 pt2 "" )

    ; draw dimension stop line
    ( setq i  0 )
    ( repeat ( 1+ n )
       ( setq Offhor ( nth i myLst ) )
       ( setq inspt ( polar inspt myAng Offhor ) )

       ( command "DONUT" 0.00 scale inspt "" )

       ( setq pt1 ( polar inspt ( + ( * 0.5 pi ) myAng ) ( * uplin scale ) ) )
       ( setq pt2 ( polar inspt ( + ( * 1.5 pi ) myAng ) ( * dnlin scale ) ) )
       ( command "line" pt1 pt2 "" )

       ( setq i ( 1+ i ) )
    )

    ( curlay "_DIMTEXT" )
    ( setq i 1 )
    ( setq inspt pt0 )
    ( repeat n
       ( setq Offhor ( nth i myLst ) )
       ( setq pt0    ( polar inspt myAng ( * 0.50 Offhor ) ) )
       ( setq pt0    ( polar pt0  ( + ( * 0.5 pi ) myAng ) ( * 1.50 scale ) ) )

       ( command "TEXT" "J" "C" pt0 ( * Htext scale ) ( rtod myAng ) ( rtos Offhor 2 0 ) )

       ( setq inspt ( polar inspt myAng Offhor ) )
       ( setq i ( 1+ i ) )
    )

    ( SYSpops )
)

;==============================================================================
( defun c:tick( / inspt )
    ( SYSpush )

    ( setvar "OSMODE" 32 )
    ( setq inspt  ( getpoint "Insert point:"  ) ) ( terpri )
    ( setq DimAng ( defAngle "Rotation angle" DimAng 4 ) )

    ( bar inspt DimAng )

    ( SYSpops )
)
