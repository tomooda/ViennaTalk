tests-types
testSeqType1
	self assert: (grammar type end parse: 'seq of t') equals: 't'