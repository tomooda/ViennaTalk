code generation-expressions
arithmeticIntegerDivision: aViennaNode
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' asInteger // ' , arg2 , ' asInteger)'