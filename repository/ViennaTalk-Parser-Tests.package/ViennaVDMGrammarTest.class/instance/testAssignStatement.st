tests-statements
testAssignStatement
	self assert: (grammar statement end parse: 'a := e') equals: #('a' 'e')