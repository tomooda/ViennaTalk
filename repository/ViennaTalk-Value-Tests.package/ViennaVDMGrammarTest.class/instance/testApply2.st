tests-expressions
testApply2
	self assert: (grammar expression end parse: 'f(a1)') equals: #('f' #('a1'))