tests-code generation-expressions
testSetRangeExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,...,4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetRangeExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet