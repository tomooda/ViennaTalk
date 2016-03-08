tests-code generation-expressions
testLessThanOrEqualEnv
	| node |
	node := ViennaVDMParser new expression end parse: '1 <= 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 <= 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 <= 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: true