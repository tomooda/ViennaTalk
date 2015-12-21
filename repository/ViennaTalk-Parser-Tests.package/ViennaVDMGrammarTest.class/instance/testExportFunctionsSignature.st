tests-interfaces
testExportFunctionsSignature
	self
		assert: (grammar exportFunctionsSignature end parse: 'functions f1, f2[@t] : @t -> bool; f3 : nat -> nat')
		equals: #(#(#('f1' 'f2') #('@t') #('@t' 'bool')) #(#('f3') #() #('nat' 'nat')))