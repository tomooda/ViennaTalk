code generation-expressions
arithmeticAbs: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' abs'