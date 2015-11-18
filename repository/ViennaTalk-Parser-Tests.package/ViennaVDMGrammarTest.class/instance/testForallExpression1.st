tests-expressions
testForallExpression1
	self
		assert: (grammar expression end parse: 'forall v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')