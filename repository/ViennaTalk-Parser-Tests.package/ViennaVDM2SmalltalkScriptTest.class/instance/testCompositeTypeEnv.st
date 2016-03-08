tests-code generation-types
testCompositeTypeEnv
	| node |
	node := ViennaVDMParser new type end parse: 'compose T of x:nat y:-int char end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CompositeType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals:
			(ViennaType
				compose: 'T'
				of:
					{{'x'.
					false.
					(ViennaType nat)}.
					{'y'.
					true.
					(ViennaType int)}.
					{nil.
					false.
					(ViennaType char)}})