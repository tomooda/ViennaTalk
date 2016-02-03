tests-code generation-types
testRecordTypeDefinitionEnv
	| node |
	node := ViennaVDMParser new recordTypeDefinition end parse: 'T :: x:nat y:-int char'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordTypeDefinition'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
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