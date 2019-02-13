;------------------------------------------------------------------------------
; Global Variable ::
;	Wwid		Wall width ( default 240.00 )
;	Woff		Wall width left offset ( default 120.00 )
;
; Modified Memo ::
;	Date		Because
;	Dec--01--95	Add default Wall-width & Wall-offset;
;			240.00/120.00;
;	Jan--10--96	can set up OSNAP command;
;	2006-11-28	wujianhua		������
;
( defun c:wall( / pt1 pt2 AoffL AoffR Ang ang1 ang2 TmpReal )
    ( SYSpush )

    ( command "OSNAP" "INT" )
    ( setq pt1 ( getpoint      "��ʼ�㣺" ) )  ( terpri )
    ( setq pt2 ( getpoint pt1  "�����㣺"   ) )  ( terpri )

    ( if ( = Wwid nil ) ( setq Wwid 250.00 ) )
    ( if ( = Woff nil ) ( setq Woff 125.00 ) )

    ( setq TmpReal  Wwid  )
    ( setq Wwid ( defReal "���ȣ�"  tmpReal 0 ) )

    ( if ( /= TmpReal Wwid )  ( setq Woff ( / Wwid 2.00 ) )  )

    ( setq TmpReal  Woff  )
    ( setq Woff ( defReal "ƫ������" tmpReal 0 ) )

    ( setq AoffL Woff		  )
    ( setq AoffR ( - Wwid AoffL ) )

    ( setq Ang	( angle pt1 pt2 ) )
    ( setq ang1 ( R$D Ang    90 ) )
    ( setq ang2 ( R$D Ang   -90 ) )

    ( if ( /= oldlay "SOLID_LINE" )   ( curlay "DASHED_LINE" )  )

    ( setvar "OSMODE"  0 )
    ( command "line"  ( polar pt1 ang1 AoffL )  ( polar pt2 ang1 AoffL )  ""  )
    ( command "line"  ( polar pt1 ang2 AoffR )  ( polar pt2 ang2 AoffR )  ""  )

    ( SYSpops )
)
