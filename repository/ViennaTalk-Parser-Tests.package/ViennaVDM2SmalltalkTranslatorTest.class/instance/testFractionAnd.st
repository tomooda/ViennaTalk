tests-operators
testFractionAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 / 3')) equals: 2.0 / 3.0