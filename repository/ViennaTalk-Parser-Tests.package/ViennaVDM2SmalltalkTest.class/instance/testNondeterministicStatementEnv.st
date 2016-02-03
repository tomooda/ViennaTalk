tests-code generation-statements
testNondeterministicStatementEnv
	| node |
	node := ViennaVDMParser new statement end parse: '||(a := a union {1}, a := a union {2}, a := a union {3})'.
	self deny: node isPetitFailure.
	self assert: node label = 'NondeterministicStatement'.
	self
		assert: (Compiler evaluate: '|a| a := Set new.' , (ViennaVDM2Smalltalk new generate: node) , '. a')
		equals: #(1 2 3) asSet