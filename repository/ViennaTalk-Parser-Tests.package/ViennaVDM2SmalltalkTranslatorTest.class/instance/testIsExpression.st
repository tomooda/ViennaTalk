tests-expressions
testIsExpression
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_bool(true)'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_int(true)'))
		equals: false.
	self
		assert:
			(Compiler evaluate: '| t | t := ViennaType int. ' , (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_t(1)'))
		equals: true