tests-expressions
testMapComprehension2
	self assert: (grammar expression end parse: '{k1|->v1|k1,v1 in set s}') equals: #('k1' 'v1' #(#(#('k1' 'v1') 's')) nil)