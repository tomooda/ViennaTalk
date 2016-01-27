code generation-expressions
tupleSelect: aViennaNode env: aDictionary
	| tuple index |
	tuple := self generate: aViennaNode first env: aDictionary.
	index := self generate: aViennaNode second env: aDictionary.
	^ '(' , tuple , ' at: ' , index , ')'