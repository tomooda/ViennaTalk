tests-expressions
testIsExpression7
	self assert: (grammar expression end parse: 'is_(e, t)') = #('e' 't')