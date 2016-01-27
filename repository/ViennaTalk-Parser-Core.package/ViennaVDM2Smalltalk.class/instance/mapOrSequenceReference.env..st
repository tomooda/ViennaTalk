code generation-expressions
mapOrSequenceReference: aViennaNode env: aDictionary
	| mapOrSeq key |
	mapOrSeq := self generate: aViennaNode first env: aDictionary.
	key := self generate: aViennaNode second env: aDictionary.
	^ '(' , mapOrSeq , ' at: ' , key , ')'