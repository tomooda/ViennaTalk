tests-code generation-expressions
testOldNameEnv
	| node |
	node := ViennaVDMParser new expression end parse: 'x~'.
	self deny: node isPetitFailure.
	self assert: node label = 'OldName'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('x~' -> '1')} asDictionary)) equals: 1