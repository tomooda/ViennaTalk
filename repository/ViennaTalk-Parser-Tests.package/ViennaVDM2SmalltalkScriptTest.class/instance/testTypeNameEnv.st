tests-code generation-types
testTypeNameEnv
	| node |
	node := ViennaVDMParser new type end parse: 't'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeName'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat