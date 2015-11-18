tests-expressions
testCasesExpression2
	self assert: (grammar expression end parse: 'cases e:p1->e1 end') equals: #('e' #(#(#('p1') 'e1')) nil)