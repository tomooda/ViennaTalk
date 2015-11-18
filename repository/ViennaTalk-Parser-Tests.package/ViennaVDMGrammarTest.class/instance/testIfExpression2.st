tests-expressions
testIfExpression2
	self
		assert: (grammar expression end parse: 'if cond1 then e1 elseif cond2 then e2 else e3')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2')) 'e3')