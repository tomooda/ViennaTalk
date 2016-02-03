tests-code generation-expressions
testUndefinedExpressionEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'undefined'.
	self deny: node isPetitFailure.
	self assert: node label = 'UndefinedExpression'.
	self
		should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ]
		raise: ViennaUndefinedEvaluationError