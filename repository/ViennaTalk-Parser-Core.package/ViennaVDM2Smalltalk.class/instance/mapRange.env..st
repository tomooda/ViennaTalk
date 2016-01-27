code generation-expressions
mapRange: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' values asSet'