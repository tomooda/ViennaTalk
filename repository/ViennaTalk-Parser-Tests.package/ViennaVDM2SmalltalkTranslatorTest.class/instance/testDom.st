tests-operators
testDom
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dom {1|->2, 2|->3}'))
		equals: #(1 2) asSet