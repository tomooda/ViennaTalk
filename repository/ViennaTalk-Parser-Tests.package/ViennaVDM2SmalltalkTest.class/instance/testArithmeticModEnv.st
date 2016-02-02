tests-code generation-expressions
testArithmeticModEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 mod 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMod'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1