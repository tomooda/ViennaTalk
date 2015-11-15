tests-expressions
testMapEnumeration3
	self assert: (grammar expression end parse: '{k1|->v1,k2|->v2}') equals: #(#('k1' 'v1') #('k2' 'v2'))