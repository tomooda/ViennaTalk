tests-expressions
testSamebaseclassExpression1
	self assert: (grammar expression end parse: 'samebaseclass(e1, e2)') equals: #('e1' 'e2')