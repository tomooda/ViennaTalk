tests-statements
testExitStatement
	self assert: (grammar statement end parse: 'exit e') equals: 'e'