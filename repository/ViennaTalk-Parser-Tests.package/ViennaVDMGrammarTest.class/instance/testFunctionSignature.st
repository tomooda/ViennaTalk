tests-interfaces
testFunctionSignature
	self assert: (grammar functionSignature end parse: 'f1, f2 : nat -> nat') equals: #(#('f1' 'f2') #('nat' 'nat'))