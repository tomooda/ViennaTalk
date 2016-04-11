code generation-expressions
not: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' not'