tests-patterns
testSetUnionPattern3
	self assert: (grammar pattern end parse: '{} union s1 union s2') isPetitFailure