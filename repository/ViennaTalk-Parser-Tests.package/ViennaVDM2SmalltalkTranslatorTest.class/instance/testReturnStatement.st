tests-statements
testReturnStatement
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new statement parse: 'return 1')) equals: 1