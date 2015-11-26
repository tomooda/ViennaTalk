tests-patterns
testSeqEnumPattern
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases [1,2,3] : [a,b,3] -> mk_(a, b) end'))
		equals: #(1 2)