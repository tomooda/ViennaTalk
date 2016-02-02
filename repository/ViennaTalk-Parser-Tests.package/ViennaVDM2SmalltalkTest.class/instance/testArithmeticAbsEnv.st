tests-code generation-expressions
testArithmeticAbsEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'abs -1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticAbs'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1