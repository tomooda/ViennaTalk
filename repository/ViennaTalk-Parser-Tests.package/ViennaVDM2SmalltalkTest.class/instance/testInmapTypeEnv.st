tests-code generation-types
testInmapTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'inmap nat to int'.
	self deny: node isPetitFailure.
	self assert: node label = 'InmapType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: (ViennaType nat inmapTo: ViennaType int)