tests-code generation-expressions
testGreaterThanOrEqualEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 >= 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false