tests-literals
testDecimalLiteral
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '10')) equals: 10.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-1.23e-4')) equals: -1.23e-4.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-1.23E-4')) equals: -1.23e-4