tests-types
testInmapType1
	self assert: (grammar type end parse: 'inmap t1 to t2') equals: #('t1' 't2')