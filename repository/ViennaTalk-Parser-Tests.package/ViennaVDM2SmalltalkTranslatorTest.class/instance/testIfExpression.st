tests-expressions
testIfExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression
						parse: '[(lambda x:int&if x = 0 then <zero> elseif x = 1 then <one> else <many>)(i)|i in set {0,...,3}]'))
		equals: #('<zero>' '<one>' '<many>' '<many>') asOrderedCollection