tests-code generation-types
testSet1TypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'set1 of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'Set1Type'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat set1