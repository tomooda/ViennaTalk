tests-statements
testIdentityStatement
	self
		assert: (Compiler evaluate: '| a | a := 1.' , (ViennaVDM2SmalltalkTranslator new statement end parse: 'skip') , '. a')
		equals: 1