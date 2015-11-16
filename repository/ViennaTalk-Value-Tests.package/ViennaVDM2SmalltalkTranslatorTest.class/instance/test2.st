testing
test2
	self
		assert: (Compiler evaluate: (translator expression parse: 'dom ({"one"|->1, "two"|->2, "three"|->3} :> {1,3})'))
		equals:
			{('one' asArray).
			('three' asArray)} asSet