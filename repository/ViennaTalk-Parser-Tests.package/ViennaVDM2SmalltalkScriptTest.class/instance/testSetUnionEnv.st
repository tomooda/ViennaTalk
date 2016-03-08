tests-code generation-expressions
testSetUnionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} union {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetUnion'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet