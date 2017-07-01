tests-code generation-expressions
testArithmeticPlusEnv
	| node |
	node := ViennaVDMParser new expression end parse: '3 + 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticPlus'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 5