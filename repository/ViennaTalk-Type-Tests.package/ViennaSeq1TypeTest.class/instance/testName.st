tests
testName
	self assert: seq1ofnat name equals: 'seq1 of nat'.
	self assert: (ViennaSeq1Type with: ViennaType nat | ViennaType bool) name equals: 'seq1 of (nat|bool)'