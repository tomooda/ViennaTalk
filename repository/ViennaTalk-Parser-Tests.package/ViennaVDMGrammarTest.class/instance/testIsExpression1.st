tests-expressions
testIsExpression1
	self assert: (grammar expression end parse: 'is_t(e)') equals: #('t' 'e')