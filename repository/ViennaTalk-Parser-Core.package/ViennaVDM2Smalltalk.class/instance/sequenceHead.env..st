code generation-expressions
sequenceHead: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' first'