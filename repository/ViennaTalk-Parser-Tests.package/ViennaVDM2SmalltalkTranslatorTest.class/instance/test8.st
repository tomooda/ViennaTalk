testing
test8
	self
		assert: (Compiler evaluate: (translator expression parse: '{ i+1 |i in set {1,...,9} & i mod 2 = 0}'))
		equals: #(3 5 7 9) asSet