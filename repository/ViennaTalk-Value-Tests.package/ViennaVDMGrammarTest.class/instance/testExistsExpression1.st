tests-expressions
testExistsExpression1
	self
		assert: (grammar expression end parse: 'exists v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')