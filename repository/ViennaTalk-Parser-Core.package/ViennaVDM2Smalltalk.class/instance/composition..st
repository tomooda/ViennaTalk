code generation-expressions
composition: aViennaNode
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' comp: ' , arg2 , ')'