tests-types
testPartialFunctionType1
	self assert: (grammar type end parse: 't1->t2') equals: #('t1' 't2')