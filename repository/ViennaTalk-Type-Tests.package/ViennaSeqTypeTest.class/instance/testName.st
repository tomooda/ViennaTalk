tests
testName
	self assert: seqofnat name equals: 'seq of nat'.
	self assert: (ViennaSeqType with: ViennaType nat | ViennaType bool) name equals: 'seq of (nat|bool)'