tests-expressions
testMapEnumeration2
	self assert: (grammar expression end parse: '{k1|->v1}') equals: #(#('k1' 'v1'))