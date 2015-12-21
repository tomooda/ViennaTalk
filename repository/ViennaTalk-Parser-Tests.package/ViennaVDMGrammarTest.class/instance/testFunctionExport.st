tests-interfaces
testFunctionExport
	self
		assert: (grammar functionExport end parse: 'f1, f2[@t] : @t -> bool')
		equals: #(#('f1' 'f2') #('@t') #('@t' 'bool'))