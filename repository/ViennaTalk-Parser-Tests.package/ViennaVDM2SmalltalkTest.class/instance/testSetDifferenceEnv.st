tests-code generation-expressions
testSetDifferenceEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} \ {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetDifference'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: {1} asSet