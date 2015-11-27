tests-operators
testUnaryPlus
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ 1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ + 1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ (1+2)')) equals: 3