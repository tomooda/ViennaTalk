tests-operators
testCompositionExpressionAnd
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: '((lambda x:int&x+1) comp (lambda s:set of int&card s))({1,2,3})'))
		equals: 4.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '({2|->3, 3|->4} comp {1|->2, 2|->3})(2)'))
		equals: 4.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: '({2|->3, 3|->4} comp (lambda s:set of int&card s))({1,2,3})'))
		equals: 4.
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '((lambda x:int&x+1) comp {2|->3, 3|->4})(2)'))
		equals: 4