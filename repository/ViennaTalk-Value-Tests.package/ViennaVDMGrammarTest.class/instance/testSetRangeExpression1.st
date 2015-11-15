tests-expressions
testSetRangeExpression1
	self assert: (grammar expression end parse: '{s,...,e}') equals: #('s' 'e')