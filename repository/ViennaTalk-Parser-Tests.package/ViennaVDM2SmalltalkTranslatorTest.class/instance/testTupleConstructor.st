tests-expressions
testTupleConstructor
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'mk_(1,2)')) equals: #(1 2)