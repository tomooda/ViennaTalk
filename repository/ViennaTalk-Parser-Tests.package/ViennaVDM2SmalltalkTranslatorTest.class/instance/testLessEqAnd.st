tests-operators
testLessEqAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 0')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 1')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 2')) equals: true