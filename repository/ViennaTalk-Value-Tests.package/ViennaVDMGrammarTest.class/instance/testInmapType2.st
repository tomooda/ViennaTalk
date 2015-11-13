tests-types
testInmapType2
	self assert: (grammar type end parse: 'inmap t1 to inmap t2 to t3') equals: #('t1' #('t2' 't3'))