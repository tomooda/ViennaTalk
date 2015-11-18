tests-patterns
testBind2
	self assert: (grammar bind end parse: 'v in set t') equals: #('v' 't')