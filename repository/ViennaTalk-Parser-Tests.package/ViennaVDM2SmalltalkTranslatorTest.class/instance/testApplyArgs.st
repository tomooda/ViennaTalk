tests-operators
testApplyArgs
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '(lambda x:int&x+1)(2)'))
		equals: 3.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[2,3,4](2)')) equals: 3.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 3|->4}(2)'))
		equals: 3