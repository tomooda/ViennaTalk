tests-code generation-types
testOptionalTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: '[nat]'.
	self deny: node isPetitFailure.
	self assert: node label = 'OptionalType'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat optional