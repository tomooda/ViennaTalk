tests-expressions
testSameclassExpression1
	self assert: (grammar expression end parse: 'sameclass(e1, e2)') equals: #('e1' 'e2')