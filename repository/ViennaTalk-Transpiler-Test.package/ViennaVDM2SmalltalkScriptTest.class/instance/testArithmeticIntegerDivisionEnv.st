tests-code generation-expressions
testArithmeticIntegerDivisionEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 div 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticIntegerDivision'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 1