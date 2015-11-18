tests-expressions
testFunctionTypeInstantiation1
	self assert: (grammar expression end parse: 'f[bool]') equals: #(#f #('bool'))