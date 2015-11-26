tests-operators
testIterateExpressionAnd
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 ** 3')) equals: 8.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '((lambda x:int&x+1) ** 2)(1)'))
		equals: 3.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '({0|->1, 1|->2, 2|->3, 3|->0} ** 2)(1)'))
		equals: 3