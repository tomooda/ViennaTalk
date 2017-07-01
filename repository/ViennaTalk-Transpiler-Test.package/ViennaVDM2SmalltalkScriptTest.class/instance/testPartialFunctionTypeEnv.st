tests-code generation-types
testPartialFunctionTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int -> real'.
	self deny: node isPetitFailure.
	self assert: node label = 'PartialFunctionType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: ViennaType nat * ViennaType int -> ViennaType real