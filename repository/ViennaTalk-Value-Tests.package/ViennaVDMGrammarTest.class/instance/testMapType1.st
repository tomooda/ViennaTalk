tests-types
testMapType1
	self assert: (grammar type end parse: 'map t1 to t2') equals: #('t1' 't2')