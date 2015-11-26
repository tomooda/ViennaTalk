tests-operators
testMinusAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1-2')) equals: -1