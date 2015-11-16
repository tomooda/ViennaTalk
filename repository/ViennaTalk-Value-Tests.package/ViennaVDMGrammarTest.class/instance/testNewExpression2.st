tests-expressions
testNewExpression2
	self assert: (grammar expression end parse: 'new t(e1, e2, e3)') equals: #('t' #('e1' 'e2' 'e3'))