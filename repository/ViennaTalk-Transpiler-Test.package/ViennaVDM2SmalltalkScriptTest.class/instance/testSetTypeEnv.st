tests-code generation-types
testSetTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'set of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetType'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat set