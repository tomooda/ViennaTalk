code generation-expressions
arithmeticRem: aViennaNode
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' rem: ' , arg2 , ')'