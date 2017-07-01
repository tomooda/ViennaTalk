tests-code generation-expressions
testResultExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'RESULT'.
	self deny: node isPetitFailure.
	self assert: node label = 'ResultExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('RESULT' -> '1')} asDictionary))
		equals: 1