tests-operators
testHd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'hd [1,2,3]')) equals: 1.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'hd []') ]
		raise: SubscriptOutOfBounds