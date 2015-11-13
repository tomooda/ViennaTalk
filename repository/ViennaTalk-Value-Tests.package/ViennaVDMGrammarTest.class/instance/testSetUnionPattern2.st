tests-patterns
testSetUnionPattern2
	self assert: (grammar pattern end parse: '{} union rest') equals: #(#() 'rest')