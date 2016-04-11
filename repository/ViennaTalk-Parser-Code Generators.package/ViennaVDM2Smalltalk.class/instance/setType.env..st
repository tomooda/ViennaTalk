code generation-types
setType: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' set'