tests-interfaces
testFunctionsSignature
	self
		assert: (grammar functionsSignature end parse: 'functions f1, f2 : nat -> nat; f3 : int +> int;')
		equals: #(#(#('f1' 'f2') #('nat' 'nat')) #(#('f3') #('int' 'int')))