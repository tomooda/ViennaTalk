tests-types
testUnionType3
	self assert: (grammar type end parse: 't1 | t2 | t3') equals: #('t1' 't2' 't3')