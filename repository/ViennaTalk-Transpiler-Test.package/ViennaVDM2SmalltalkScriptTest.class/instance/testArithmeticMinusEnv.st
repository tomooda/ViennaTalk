tests-code generation-expressions
testArithmeticMinusEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 - 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMinus'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 1