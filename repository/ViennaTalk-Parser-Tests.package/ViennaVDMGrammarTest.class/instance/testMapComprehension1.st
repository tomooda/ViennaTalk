tests-expressions
testMapComprehension1
	self
		assert: (grammar expression end parse: '{k1|->v1|k1,v1:t,e in set s&e}')
		equals: #('k1' 'v1' #(#(#('k1' 'v1') 't') #(#('e') 's')) 'e')