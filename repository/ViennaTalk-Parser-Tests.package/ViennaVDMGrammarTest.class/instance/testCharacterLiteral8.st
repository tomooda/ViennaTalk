tests-literals
testCharacterLiteral8
	self assert: (grammar expression end parse: '''\x41''') equals: $A