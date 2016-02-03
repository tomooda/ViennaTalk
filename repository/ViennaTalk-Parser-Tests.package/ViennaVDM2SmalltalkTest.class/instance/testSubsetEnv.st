tests-code generation-expressions
testSubsetEnv
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2} subset {1,2,3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2} subset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2,3} subset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false