tests-expressions
testRecordConstructor1
	self assert: (grammar expression end parse: 'mk_t()') equals: #(#t #())