tests-expressions
testApply3
	self assert: (grammar expression end parse: 'f(a1,a2)') equals: #('f' #('a1' 'a2'))