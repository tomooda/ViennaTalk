tests-literals
testHexadecimalLiteral
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '10')) equals: 10.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0x10')) equals: 16.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0X10')) equals: 16