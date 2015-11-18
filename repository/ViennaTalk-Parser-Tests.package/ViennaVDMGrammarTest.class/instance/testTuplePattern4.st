tests-patterns
testTuplePattern4
	self assert: (grammar pattern end parse: 'mk_(e1,e2,e3)') equals: #('e1' 'e2' 'e3')