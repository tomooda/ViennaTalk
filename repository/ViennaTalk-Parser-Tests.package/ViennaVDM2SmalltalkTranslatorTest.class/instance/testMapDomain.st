tests-expressions
testMapDomain
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'dom ({"one"|->1, "two"|->2, "three"|->3} :> {1,3})'))
		equals:
			{('one' asOrderedCollection).
			('three' asOrderedCollection)} asSet