tests-types
testSeq1Type2
	self assert: (grammar type end parse: 'seq1 of seq1 of t') equals: 't'