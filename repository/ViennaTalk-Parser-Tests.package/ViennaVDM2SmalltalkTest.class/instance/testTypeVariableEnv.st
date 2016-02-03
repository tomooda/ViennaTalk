tests-code generation-types
testTypeVariableEnv
	| node |
	node := ViennaVDMParser new type end parse: '@t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariable'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('@t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat