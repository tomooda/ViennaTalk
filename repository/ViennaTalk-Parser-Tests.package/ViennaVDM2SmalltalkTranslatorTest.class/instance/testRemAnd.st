tests-operators
testRemAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '5 rem 3')) equals: 2.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-5 rem 3')) equals: -2