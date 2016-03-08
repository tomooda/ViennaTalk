tests-code generation-expressions
testNotEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'not true'.
	self deny: node isPetitFailure.
	self assert: node label = 'Not'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: 'not false'.
	self deny: node isPetitFailure.
	self assert: node label = 'Not'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true