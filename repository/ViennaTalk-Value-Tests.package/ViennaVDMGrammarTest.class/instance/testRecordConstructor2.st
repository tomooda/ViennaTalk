tests-expressions
testRecordConstructor2
	self assert: (grammar expression end parse: 'mk_t(e1)') equals: #(#t #('e1'))