tests-operators
testLen
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'len [10,20,30]')) equals: 3