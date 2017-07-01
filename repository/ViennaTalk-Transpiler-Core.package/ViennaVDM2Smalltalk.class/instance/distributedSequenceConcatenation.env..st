code generation-expressions
distributedSequenceConcatenation: aViennaNode env: aDictionary
	^ (self generate: aViennaNode first env: aDictionary) , ' concatenation asOrderedCollection'