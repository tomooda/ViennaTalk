tests-expressions
testSetComprehension1
	self
		assert: (grammar expression end parse: '{v1 | v1,v2:t1, v3 in set s & v3}')
		equals: #('v1' #(#(#('v1' 'v2') 't1') #(#('v3') 's')) 'v3')