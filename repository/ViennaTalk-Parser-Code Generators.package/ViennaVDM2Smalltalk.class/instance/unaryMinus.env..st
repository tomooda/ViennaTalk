code generation-expressions
unaryMinus: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' negated'