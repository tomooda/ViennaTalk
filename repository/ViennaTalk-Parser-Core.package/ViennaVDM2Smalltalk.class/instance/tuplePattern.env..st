code generation-patterns
tuplePattern: aViennaNode env: aDictionary
	| argPatterns |
	argPatterns := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaRuntimeUtil matchTuple: {' , (' . ' join: argPatterns) , '})'