tests-literals
testNilLiteral
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'nil')) equals: nil