tests-code generation-expressions
testNotInSetEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 not in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotInSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '0 not in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotInSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true