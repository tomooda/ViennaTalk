code generation-expressions
sequenceIndices: aViennaNode env: aDictionary
	^ '(1 to: ' , (self generate: aViennaNode first env: aDictionary) , ' size) asSet'