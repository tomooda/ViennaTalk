code generation-expressions
sequenceLength: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' size'