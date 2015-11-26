tests-operators
testEqualAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 = 1')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 = 2')) equals: false