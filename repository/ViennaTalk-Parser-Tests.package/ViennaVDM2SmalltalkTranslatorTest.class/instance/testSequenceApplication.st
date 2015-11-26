tests-expressions
testSequenceApplication
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[ "0123456789abcdef"(i+1) |i in set {0,...,15} & i mod 2 = 0]'))
		equals: #($0 $2 $4 $6 $8 $a $c $e) asOrderedCollection