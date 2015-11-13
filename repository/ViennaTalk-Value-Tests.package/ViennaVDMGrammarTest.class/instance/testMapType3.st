tests-types
testMapType3
	self assert: (grammar type end parse: 'map map t1 to t2 to t3') equals: #(#('t1' 't2') 't3')