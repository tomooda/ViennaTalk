tests-expressions
testDefExpression3
	self
		assert: (grammar expression end parse: 'def v1 : t1 = e1 ; v2 in set s = e2 ; v3 = e3 in e')
		equals: #(#(#(#('v1' 't1') 'e1') #(#('v2' 's') 'e2') #('v3' 'e3')) 'e')