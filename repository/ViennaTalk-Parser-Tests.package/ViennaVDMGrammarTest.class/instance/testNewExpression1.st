tests-expressions
testNewExpression1
	self assert: (grammar expression end parse: 'new t()') equals: #('t' #())