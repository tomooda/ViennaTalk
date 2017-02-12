tests-statements
testAlwaysStatement
	self assert: (grammar statement end parse: 'always return e1 in return e2') equals: #('e1' 'e2')