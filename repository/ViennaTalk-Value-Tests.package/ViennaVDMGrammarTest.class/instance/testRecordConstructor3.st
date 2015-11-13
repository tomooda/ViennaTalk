tests-expressions
testRecordConstructor3
	self assert: (grammar expression end parse: 'mk_t(e1,e2)') equals: #(#t #('e1' 'e2'))