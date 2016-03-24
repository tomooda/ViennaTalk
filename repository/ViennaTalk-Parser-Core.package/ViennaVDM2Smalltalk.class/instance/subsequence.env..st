code generation-expressions
subsequence: aViennaNode env: aDictionary
	| seq arg1 arg2 |
	seq := self generate: aViennaNode first env: aDictionary.
	arg1 := self generate: aViennaNode second env: aDictionary.
	arg2 := self generate: aViennaNode third env: aDictionary.
	^ '(' , seq , ' subsequenceFrom: ' , arg1 , ' to: ' , arg2 , ')'