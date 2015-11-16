tests-literals
testCharacterLiteral9
	self assert: (grammar expression end parse: '''\u0041''') equals: $A