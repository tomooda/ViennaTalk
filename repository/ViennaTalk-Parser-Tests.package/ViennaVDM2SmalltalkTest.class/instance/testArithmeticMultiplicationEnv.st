tests-code generation-expressions
testArithmeticMultiplicationEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 * 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMultiplication'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 6