tests-operators
testNot
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not true')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not false')) equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not 1/0') ]
		raise: ZeroDivide