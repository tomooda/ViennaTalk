tests-code generation-types
testProductTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProductType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat * ViennaType int