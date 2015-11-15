tests-expressions
testRecordModifier1
	self assert: (grammar expression end parse: 'mu(e,f1|->e1,f2|->e2)') equals: #('e' #(#('f1' 'e1') #('f2' 'e2')))