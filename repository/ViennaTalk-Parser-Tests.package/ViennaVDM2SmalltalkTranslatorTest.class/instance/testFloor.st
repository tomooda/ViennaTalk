tests-operators
testFloor
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'floor 1.9')) equals: 1