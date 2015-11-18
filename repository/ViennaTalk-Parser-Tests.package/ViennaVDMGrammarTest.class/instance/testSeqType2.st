tests-types
testSeqType2
	self assert: (grammar type end parse: 'seq of seq of t') equals: 't'