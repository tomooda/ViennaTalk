tests-expressions
testIfExpression3
	self
		assert: (grammar expression end parse: 'if cond1 then e1 else if cond2 then e2 else e3')
		equals: #(#(#('cond1' 'e1')) #(#(#('cond2' 'e2')) 'e3'))