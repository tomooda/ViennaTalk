tests-expressions
testTupleConstructor1
	self assert: (grammar expression end parse: 'mk_(e1,e2)') equals: #('e1' 'e2')