tests-code generation-expressions
testCasesExpressionEnv
	| node |
	node := ViennaVDMParser new expression end
		parse: 'cases 1: []^x -> <seq>, {}^x -> <set>, x -> x + 2, others -> undefined end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 3