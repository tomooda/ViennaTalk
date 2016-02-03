tests-code generation-expressions
testUnaryMinusEnv
	| node |
	node := ViennaVDMParser new expression end parse: '-1'.
	self deny: node isPetitFailure.
	self assert: node label = 'UnaryMinus'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: -1