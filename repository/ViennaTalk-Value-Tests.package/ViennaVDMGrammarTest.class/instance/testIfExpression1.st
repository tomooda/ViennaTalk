tests-expressions
testIfExpression1
	self assert: (grammar expression end parse: 'if cond1 then e1 else e2') equals: #(#(#('cond1' 'e1')) 'e2')