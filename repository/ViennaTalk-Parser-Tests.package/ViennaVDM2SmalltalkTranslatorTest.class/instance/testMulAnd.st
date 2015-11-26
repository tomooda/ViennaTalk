tests-operators
testMulAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 * 3')) equals: 6