tests-patterns
testSetUnionPattern1
	self assert: (grammar pattern end parse: '{}union rest') equals: #(#() 'rest')