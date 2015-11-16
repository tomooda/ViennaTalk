tests-expressions
testIsofclassExpression1
	self assert: (grammar expression end parse: 'isofclass(t, e)') equals: #('t' 'e')