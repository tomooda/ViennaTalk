tests-expressions
testTupleConstructor2
	self assert: (grammar expression end parse: 'mk_(e1,e2,e3)') equals: #('e1' 'e2' 'e3')