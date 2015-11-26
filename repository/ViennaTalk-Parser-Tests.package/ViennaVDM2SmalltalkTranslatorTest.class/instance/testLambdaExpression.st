tests-expressions
testLambdaExpression
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '(lambda x:int&x+1)(2)'))
		equals: 3