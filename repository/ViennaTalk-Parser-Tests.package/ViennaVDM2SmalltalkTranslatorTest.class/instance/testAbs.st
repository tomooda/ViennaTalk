tests-operators
testAbs
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'abs -1')) equals: 1