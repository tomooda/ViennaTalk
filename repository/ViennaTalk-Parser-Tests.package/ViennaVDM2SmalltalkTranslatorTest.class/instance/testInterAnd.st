tests-operators
testInterAnd
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1,2,3} inter {2,3,4}'))
		equals: #(2 3) asSet