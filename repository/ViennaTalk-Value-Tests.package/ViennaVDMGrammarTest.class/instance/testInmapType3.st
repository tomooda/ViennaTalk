tests-types
testInmapType3
	self assert: (grammar type end parse: 'inmap inmap t1 to t2 to t3') equals: #(#('t1' 't2') 't3')