tests-code generation-expressions
testArithmeticRemEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 rem 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticRem'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 1