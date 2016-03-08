tests-code generation-expressions
testInSetEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'InSet'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '0 in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'InSet'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false