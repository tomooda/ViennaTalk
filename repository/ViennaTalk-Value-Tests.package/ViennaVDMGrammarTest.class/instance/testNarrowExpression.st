tests-expressions
testNarrowExpression
	self assert: (grammar expression end parse: 'narrow_(e,t)') equals: #('e' 't')