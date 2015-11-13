tests-types
testMapType2
	self assert: (grammar type end parse: 'map t1 to map t2 to t3') equals: #('t1' #('t2' 't3'))