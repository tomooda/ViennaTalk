tests-expressions
testSetComprehension2
	self
		assert: (grammar expression end parse: '{v1 | v1,v2:t1, v3 in set s }')
		equals: #('v1' #(#(#('v1' 'v2') 't1') #(#('v3') 's')) nil)