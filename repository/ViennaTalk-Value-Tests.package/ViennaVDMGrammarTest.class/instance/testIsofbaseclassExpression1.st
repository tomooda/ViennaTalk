tests-expressions
testIsofbaseclassExpression1
	self assert: (grammar expression end parse: 'isofbaseclass(t, e)') equals: #('t' 'e')