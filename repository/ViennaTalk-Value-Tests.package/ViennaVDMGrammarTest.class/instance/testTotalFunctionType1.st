tests-types
testTotalFunctionType1
	self assert: (grammar type end parse: 't1+>t2') equals: #('t1' 't2')