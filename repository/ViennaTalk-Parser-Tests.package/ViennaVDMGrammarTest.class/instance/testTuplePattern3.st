tests-patterns
testTuplePattern3
	self assert: (grammar pattern end parse: 'mk_(e1,e2)') equals: #('e1' 'e2')