testing
test1
	self
		assert: (Compiler evaluate: (translator expression parse: '(inverse {"one"|->1, "two"|->2, "three"|->3})(2)'))
		equals: 'two' asOrderedCollection