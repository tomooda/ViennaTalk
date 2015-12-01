tests-expressions
testTypeJudgement
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_(true, bool)'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_(true, int)'))
		equals: false.
	self
		assert:
			(Compiler
				evaluate: '| t | t := ViennaType int. ' , (ViennaVDM2SmalltalkTranslator new expression end parse: 'is_(1, t)'))
		equals: true