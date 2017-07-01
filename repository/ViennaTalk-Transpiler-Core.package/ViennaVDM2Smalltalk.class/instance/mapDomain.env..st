code generation-expressions
mapDomain: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' keys asSet'