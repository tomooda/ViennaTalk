code generation-expressions
finitePowerSet: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' power'