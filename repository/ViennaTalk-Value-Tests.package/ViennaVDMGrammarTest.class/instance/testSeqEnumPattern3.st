tests-patterns
testSeqEnumPattern3
	self assert: (grammar pattern end parse: '[e1,e2]') equals: #('e1' 'e2')