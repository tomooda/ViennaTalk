tests-operators
testTl
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'tl [1,2,3]'))
		equals: #(2 3) asOrderedCollection.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'tl []') ]
		raise: SubscriptOutOfBounds