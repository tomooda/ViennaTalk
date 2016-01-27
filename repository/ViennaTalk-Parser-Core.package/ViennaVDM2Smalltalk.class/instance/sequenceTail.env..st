code generation-expressions
sequenceTail: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' tail'