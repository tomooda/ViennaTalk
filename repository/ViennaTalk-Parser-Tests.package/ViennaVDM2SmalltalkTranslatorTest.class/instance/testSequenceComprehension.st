tests-expressions
testSequenceComprehension
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[mk_(x, x+1) | x in set {1,...,3} & x mod 2 <> 0]'))
		equals: #(#(1 2) #(3 4)) asOrderedCollection