tests-interfaces
testOperationSignature
	self
		assert: (grammar operationSignature end parse: 'op1, op2, op3 : nat ==> ()')
		equals: #(#('op1' 'op2' 'op3') #('nat' nil))