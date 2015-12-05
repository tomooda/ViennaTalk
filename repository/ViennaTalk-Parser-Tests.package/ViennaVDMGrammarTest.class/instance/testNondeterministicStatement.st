tests-statements
testNondeterministicStatement
	self assert: (grammar statement end parse: '||(return e1, return e2, return e3)') equals: #('e1' 'e2' 'e3')