code generation-expressions
sequenceReverse: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' reversed'