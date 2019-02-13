
;	( if ( = ( getvar "USERR1" ) 0.00 ) 
;		( setvar "USERR1" 100.00 ) 
;	)

    ;
    ( if ( = scale nil )
		( setq scale ( getvar "USERR1" ) )
    )

	;
    ;	全局变量，
    ;	用于画墙线的命令： wall.
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
    ;	用于命令: rele.
	;	1997-02-16, wujianhua
;    ( setq  eleAng	0.00	 )
    ;


( LOAD "D:\\code-lisp\\WJHLIB.LSP" )
( LOAD "D:\\code-lisp\\TOOL.LSP" )
( LOAD "D:\\code-lisp\\LINE.LSP" )

( LOAD "D:\\code-lisp\\TEXT.LSP" )

;	加载 pline 的编辑工具
( LOAD "D:\\code-lisp\\PLINE.LSP" )

( LOAD "D:\\code-lisp\\LAYER.LSP" )

( LOAD "D:\\code-lisp\\STEEL.LSP" )

;	加载 **标注尺寸** 的工具
( LOAD "D:\\code-lisp\\DIMPT.LSP" )
( LOAD "D:\\code-lisp\\DIM.LSP" )

;	楼梯踏步
( LOAD "D:\\code-lisp\\LADDER.LSP" )

;	平行线
( LOAD "D:\\code-lisp\\WALL.LSP" )

;	点处理。
( LOAD "D:\\code-lisp\\point.LSP" )
