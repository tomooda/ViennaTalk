tests-operators
testDivAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '3 div 2')) equals: 1