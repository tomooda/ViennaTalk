tests-code generation-types
testMapTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'map nat to int'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: (ViennaType nat mapTo: ViennaType int)