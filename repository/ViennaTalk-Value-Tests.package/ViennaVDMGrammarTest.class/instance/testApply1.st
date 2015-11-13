tests-expressions
testApply1
	self assert: (grammar expression end parse: 'f()') equals: #('f' #())