tests-code generation-expressions
testLessThanEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 < 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true