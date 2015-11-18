tests-expressions
testSetRangeExpression2
	self assert: (grammar expression end parse: '{ s , ... , e }') equals: #('s' 'e')