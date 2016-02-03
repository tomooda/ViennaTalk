tests-code generation-types
testTotalFunctionTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int +> real'.
	self deny: node isPetitFailure.
	self assert: node label = 'TotalFunctionType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: ViennaType nat * ViennaType int +> ViennaType real