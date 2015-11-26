tests-expressions
testMapInverse
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '(inverse {"one"|->1, "two"|->2, "three"|->3})(2)'))
		equals: 'two' asOrderedCollection