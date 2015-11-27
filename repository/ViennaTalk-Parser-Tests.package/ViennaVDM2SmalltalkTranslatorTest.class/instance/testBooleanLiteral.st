tests-literals
testBooleanLiteral
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false')) equals: false