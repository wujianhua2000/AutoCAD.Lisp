
;	( if ( = ( getvar "USERR1" ) 0.00 ) 
;		( setvar "USERR1" 100.00 ) 
;	)

    ;
    ( if ( = scale nil )
		( setq scale ( getvar "USERR1" ) )
    )

	;
    ;	ȫ�ֱ�����
    ;	���ڻ�ǽ�ߵ���� wall.
    ;	1995-12-01, wujianhua
	;
;    ( setq   Wwid	250.0 )
;    ( setq   Woff	125.0 )
    ;
    ;	1996-01-08, wujianhua
	;
    ( setq  TxtHei	2.50	 )
    ( setq  TxtAng	0.00	 )
    ( setq  TxtStr	"txt"    )
    ;
    ;	��������: rele.
	;	1997-02-16, wujianhua
;    ( setq  eleAng	0.00	 )
    ;


( LOAD "D:\\code-lisp\\WJHLIB.LSP" )
( LOAD "D:\\code-lisp\\TOOL.LSP" )
( LOAD "D:\\code-lisp\\LINE.LSP" )

( LOAD "D:\\code-lisp\\TEXT.LSP" )

;	���� pline �ı༭����
( LOAD "D:\\code-lisp\\PLINE.LSP" )

( LOAD "D:\\code-lisp\\LAYER.LSP" )

( LOAD "D:\\code-lisp\\STEEL.LSP" )

;	���� **��ע�ߴ�** �Ĺ���
( LOAD "D:\\code-lisp\\DIMPT.LSP" )
( LOAD "D:\\code-lisp\\DIM.LSP" )

;	¥��̤��
( LOAD "D:\\code-lisp\\LADDER.LSP" )

;	ƽ����
( LOAD "D:\\code-lisp\\WALL.LSP" )

;	�㴦��
( LOAD "D:\\code-lisp\\point.LSP" )
