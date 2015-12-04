tests-statements
testCasesStatement
	self
		assert: (grammar statement end parse: 'cases e:p11,p12->return e1,p2->return e2,others->return default end')
		equals: #('e' #(#(#('p11' 'p12') 'e1') #(#('p2') 'e2')) 'default')