tests-interfaces
testImportOperationsSignature
	self
		assert: (grammar importOperationsSignature end parse: 'operations op1; op2 : () ==> () renamed op3')
		equals: #(#('op1' nil nil) #('op2' #(nil nil) 'op3'))