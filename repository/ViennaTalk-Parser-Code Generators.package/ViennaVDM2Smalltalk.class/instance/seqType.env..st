code generation-types
seqType: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' seq'