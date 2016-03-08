tests-code generation-expressions
testIsNameExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'is_T(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsNameExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('T' -> 'ViennaType nat')} asDictionary))
		equals: true.
	node := ViennaVDMParser new expression end parse: 'is_T(-1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsNameExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('T' -> 'ViennaType nat')} asDictionary))
		equals: false