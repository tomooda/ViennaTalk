tests-statements
testTrapStatement
	self
		assert: (grammar statement end parse: 'trap p with return e1 in return e2')
		equals: #('p' 'e1' 'e2')