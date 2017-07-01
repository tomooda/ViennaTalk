code generation-expressions
setUnion: aViennaNode env: aDictionary
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' copy addAll: ' , arg2 , '; yourself)'