code generation-expressions
setCardinality: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' size'