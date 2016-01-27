code generation-expressions
mapInverse: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' inversed'