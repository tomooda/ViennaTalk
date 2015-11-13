tests-patterns
testBind1
	self assert: (grammar bind end parse: 'v:t') equals: #('v' 't')