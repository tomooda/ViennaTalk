tests-expressions
testFunctionTypeInstantiation2
	self assert: (grammar expression end parse: 'f[t1,t2]') equals: #(#f #('t1' 't2'))