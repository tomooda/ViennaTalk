tests-expressions
testRecordConstructor4
	self assert: (grammar expression end parse: 'mk_t(e1,e2,e3)') equals: #(#t #('e1' 'e2' 'e3'))