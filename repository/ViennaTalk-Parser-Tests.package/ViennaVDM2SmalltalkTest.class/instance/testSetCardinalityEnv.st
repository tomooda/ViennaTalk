tests-code generation-expressions
testSetCardinalityEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'card {4, 5, 6}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetCardinality'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3