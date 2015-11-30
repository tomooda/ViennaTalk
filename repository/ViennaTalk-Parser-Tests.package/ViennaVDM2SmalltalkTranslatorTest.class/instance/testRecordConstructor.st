tests-expressions
testRecordConstructor
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'mk_t(1,2)'))
		equals: (ViennaComposite constructorName: 't' with: 1 with: 2)