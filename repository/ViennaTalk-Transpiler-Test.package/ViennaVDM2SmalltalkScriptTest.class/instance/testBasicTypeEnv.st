tests-code generation-types
testBasicTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'int'.
	self deny: node isPetitFailure.
	self assert: node label = 'BasicType'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType int