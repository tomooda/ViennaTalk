tests-interfaces
testOperationsSignature
	self
		assert: (grammar operationsSignature end parse: 'operations op1, op2 : nat ==> (); op3 : () ==> nat;')
		equals: #(#(#('op1' 'op2') #('nat' nil)) #(#('op3') #(nil 'nat')))