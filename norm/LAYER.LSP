;
;------------------------------------------------------------------------------
;	改变当前图层成为选中的实体的图层。
;
( defun c:go( / Allsel	a2  Num  Index	b1  b2	d1  d2	d3 )
    ( SYSpush )

    ( prompt "请选择实体："   ) ( terpri )
    ( setq Allsel ( ssget ) )

    ( prompt "Point to entity on target layer " ) ( terpri )
    ( setq a2 ( entsel ) )

    ( setq Num	 ( sslength Allsel ) )
    ( setq Index 0 )
    ( setq b2	 ( entget ( car a2 ) ) )
    ( setq d2	 ( assoc 8 b2 ) )

    ( repeat Num
		( setq b1    ( entget ( ssname Allsel index ) ) )
		( setq d1    ( assoc 8 b1 ) )
		( setq b3    ( subst d2 d1 b1 ) )
		( entmod  b3 )
		( setq index ( + index 1 ) )
    )
    ( SYSpops )
)
;
;------------------------------------------------------------------------------
( defun c:txt( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "TEXT" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
( defun c:sln( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "SOLID_LINE" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
( defun c:dln( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "DASHED_LINE" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
( defun c:spl( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "SOLID_STEEL" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:dpl( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "DASHED_STEEL" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:old( / lay )
    ( setvar "cmdecho" 0 )
    ( setq lay ( getvar "CLAYER" ) )
    ( curlay oldlay )
    ( setq oldlay lay )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:tmp( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "TEMPLAYER" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:cnt( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "CENTER" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:kjz( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "_ZZ" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:ZHT( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "_ZZ_HATCH" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
;( defun c:hol( )
;   ( setvar "cmdecho" 0 )
;   ( setq oldlay ( getvar "CLAYER" ) )
;   ( curlay "HOLE" )
;   ( setvar "cmdecho" 1 )
;)
;
;------------------------------------------------------------------------------
( defun c:lbh( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "TEXT-LBH" )
    ( setvar "cmdecho" 1 )
)
;
;------------------------------------------------------------------------------
( defun c:wat( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "WATER" )
    ( setvar "cmdecho" 1 )
)
;

;------------------------------------------------------------------------------
;
;	wu jianhua, shenzhen, nigang, 601#, 2013-04-18, 17:41
;
;	检查基本库的位置，为什么不能运行。	
;
( defun c:LYOF( / mySel myLay )
    ( SYSpush )

    ( prompt "Point to entity to close layer " ) ( terpri )
    ( setq mySel ( entsel ) )
    ( setq myEnt ( entget ( car mySel ) ) )
    ( setq mylay ( cdr ( assoc 8 myEnt ) ) )

    ( if ( = myLay ( getvar "CLAYER" ) )
		( command  "layer"  "m"    0      "" )
		( command  "layer"  "off"  myLay  "" )
    )

    ( SYSpops )
)
;
;------------------------------------------------------------------------------
( defun c:LYON( )
    ( command "layer" "on" "*" "" )
    ( princ )
)

;------------------------------------------------------------------------------
;	地图上的边界，省级、县。
;
( defun c:BJ( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "RegionBorder" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
;	地图上的河流。
;
( defun c:HL( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "River" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
;	地图上的铁路。
;
( defun c:TL( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "Railway" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
;	地图上的高速公路。
;
( defun c:GSGL( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "HighSpeedWay" )
    ( setvar "cmdecho" 1 )
)

;------------------------------------------------------------------------------
;	地图上的主要公路。
;
( defun c:ZYGL( )
    ( setvar "cmdecho" 0 )
    ( setq oldlay ( getvar "CLAYER" ) )
    ( curlay "MainWay" )
    ( setvar "cmdecho" 1 )
)




