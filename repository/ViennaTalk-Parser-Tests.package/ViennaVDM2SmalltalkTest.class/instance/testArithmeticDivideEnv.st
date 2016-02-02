tests-code generation-expressions
testArithmeticDivideEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 / 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticDivide'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1.5