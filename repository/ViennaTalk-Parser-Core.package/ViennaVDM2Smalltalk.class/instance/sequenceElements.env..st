code generation-expressions
sequenceElements: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' asSet'