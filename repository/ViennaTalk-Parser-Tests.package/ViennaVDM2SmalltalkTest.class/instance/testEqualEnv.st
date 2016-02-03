tests-code generation-expressions
testEqualEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Equal'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 = 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Equal'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false