code generation-expressions
distributedSequenceConcatenation: aViennaNode
	^ (self generate: aViennaNode first) , ' concatenation asOrderedCollection'