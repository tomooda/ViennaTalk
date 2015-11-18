tests-patterns
testSeqEnumPattern2
	self assert: (grammar pattern end parse: '[e]') equals: #('e')