tests-expressions
testConnectives1
	self assert: (grammar expression end parse: 'not e') equals: 'e'